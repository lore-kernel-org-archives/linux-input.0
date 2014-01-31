From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 6/6] HID: Update the hidraw sample with the usage of HIDIOCGRAWCLIENTADDR
Date: Fri, 31 Jan 2014 12:32:53 -0500
Message-ID: <1391189573-2591-7-git-send-email-frank.praznik@oh.rr.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34862 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876AbaAaRdF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 12:33:05 -0500
In-Reply-To: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw sample program.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 samples/hidraw/hid-example.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/samples/hidraw/hid-example.c b/samples/hidraw/hid-example.c
index 512a7e5..dbf072d 100644
--- a/samples/hidraw/hid-example.c
+++ b/samples/hidraw/hid-example.c
@@ -23,6 +23,10 @@
 #define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
 #define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
 #endif
+#ifndef HIDIOCGRAWCLIENTADDR
+#warning Please have your distro update the userspace kernel headers
+#define HIDIOCGRAWCLIENTADDR(len) _IOC(_IOC_READ, 'H', 0x08, len)
+#endif
 
 /* Unix */
 #include <sys/ioctl.h>
@@ -93,6 +97,13 @@ int main(int argc, char **argv)
 	else
 		printf("Raw Phys: %s\n", buf);
 
+	/* Get Client Address */
+	res = ioctl(fd, HIDIOCGRAWCLIENTADDR(256), buf);
+	if (res < 0)
+		perror("HIDIOCGRAWCLIENTADDR");
+	else
+		printf("Raw Client Address: %s\n", buf);
+
 	/* Get Raw Info */
 	res = ioctl(fd, HIDIOCGRAWINFO, &info);
 	if (res < 0) {
-- 
1.8.5.3

