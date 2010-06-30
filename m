From: feng.tang@intel.com
Subject: [PATCH] input: i8042 - make function definitions in i8042.h "static inline"
Date: Wed, 30 Jun 2010 13:26:51 +0800
Message-ID: <1277875611-22907-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28468 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab0F3FIf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 01:08:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>

From: Feng Tang <feng.tang@intel.com>

Otherwise when build kernel with allyesconfig on x86_32, it will
have such errors:

drivers/platform/built-in.o: In function `i8042_lock_chip':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:50: multiple definition of `i8042_lock_chip'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:50: first defined here
drivers/platform/built-in.o: In function `i8042_unlock_chip':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:54: multiple definition of `i8042_unlock_chip'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:54: first defined here
drivers/platform/built-in.o: In function `i8042_command':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:58: multiple definition of `i8042_command'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:58: first defined here
drivers/platform/built-in.o: In function `i8042_remove_filter':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:75: multiple definition of `i8042_remove_filter'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:75: first defined here
drivers/platform/built-in.o: In function `i8042_check_port_owner':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:63: multiple definition of `i8042_check_port_owner'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:63: first defined here
drivers/platform/built-in.o: In function `i8042_install_filter':
/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:69: multiple definition of `i8042_install_filter'
drivers/input/serio/built-in.o:/home/test/ws2/projects/linux-2.6/include/linux/i8042.h:69: first defined here
make[1]: *** [drivers/built-in.o] Error 1
make: *** [drivers] Error 2

This patch will fix it.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/i8042.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 9bf6870..a986ff5 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -46,31 +46,31 @@ int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
 
 #else
 
-void i8042_lock_chip(void)
+static inline void i8042_lock_chip(void)
 {
 }
 
-void i8042_unlock_chip(void)
+static inline void i8042_unlock_chip(void)
 {
 }
 
-int i8042_command(unsigned char *param, int command)
+static inline int i8042_command(unsigned char *param, int command)
 {
 	return -ENODEV;
 }
 
-bool i8042_check_port_owner(const struct serio *serio)
+static inline bool i8042_check_port_owner(const struct serio *serio)
 {
 	return false;
 }
 
-int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+static inline int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 					struct serio *serio))
 {
 	return -ENODEV;
 }
 
-int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+static inline int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
 				       struct serio *serio))
 {
 	return -ENODEV;
-- 
1.5.6.5

