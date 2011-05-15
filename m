From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] input: members 'name' and 'phys' of 'struct hid_device' can never be NULL
Date: Sun, 15 May 2011 18:07:42 +0200
Message-ID: <1305475662-4478-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.bugwerft.de ([212.112.241.193]:40621 "EHLO
	mail.bugwerft.de" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760066Ab1EOQOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 May 2011 12:14:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>

As they are static members of fix size, there is no need to them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hidraw.c        |   14 ++------------
 drivers/hid/usbhid/hiddev.c |   18 ++----------------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 54409cb..3dd1877 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -395,12 +395,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 				}
 
 				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWNAME(0))) {
-					int len;
-					if (!hid->name) {
-						ret = 0;
-						break;
-					}
-					len = strlen(hid->name) + 1;
+					int len = strlen(hid->name) + 1;
 					if (len > _IOC_SIZE(cmd))
 						len = _IOC_SIZE(cmd);
 					ret = copy_to_user(user_arg, hid->name, len) ?
@@ -409,12 +404,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 				}
 
 				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWPHYS(0))) {
-					int len;
-					if (!hid->phys) {
-						ret = 0;
-						break;
-					}
-					len = strlen(hid->phys) + 1;
+					int len = strlen(hid->phys) + 1;
 					if (len > _IOC_SIZE(cmd))
 						len = _IOC_SIZE(cmd);
 					ret = copy_to_user(user_arg, hid->phys, len) ?
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index af0a7c1..5ca9c35 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -801,14 +801,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			break;
 
 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGNAME(0))) {
-			int len;
-
-			if (!hid->name) {
-				r = 0;
-				break;
-			}
-
-			len = strlen(hid->name) + 1;
+			int len = strlen(hid->name) + 1;
 			if (len > _IOC_SIZE(cmd))
 				 len = _IOC_SIZE(cmd);
 			r = copy_to_user(user_arg, hid->name, len) ?
@@ -817,14 +810,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 
 		if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGPHYS(0))) {
-			int len;
-
-			if (!hid->phys) {
-				r = 0;
-				break;
-			}
-
-			len = strlen(hid->phys) + 1;
+			int len = strlen(hid->phys) + 1;
 			if (len > _IOC_SIZE(cmd))
 				len = _IOC_SIZE(cmd);
 			r = copy_to_user(user_arg, hid->phys, len) ?
-- 
1.7.1

