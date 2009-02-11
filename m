From: akpm@linux-foundation.org
Subject: [patch for 2.6.29? 1/2] input: introduce a tougher i8042.reset
Date: Wed, 11 Feb 2009 13:10:41 -0800
Message-ID: <200902112110.n1BLAfJA008014@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40142 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677AbZBKVLd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 16:11:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com

From: Arjan van de Ven <arjan@linux.intel.com>

Some touchpads don't reset right the first time (MSI Wind U-100 for
example).  This patch will retry the reset up to 5 times.

In addition, this patch also adds a module parameter to not treat reset
failures as fatal to the usage of the device.  This prevents a touchpad
failure from also disabling the keyboard.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/kernel-parameters.txt |    2 +
 drivers/input/serio/i8042.c         |   33 ++++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff -puN Documentation/kernel-parameters.txt~input-introduce-a-tougher-i8042reset Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt~input-introduce-a-tougher-i8042reset
+++ a/Documentation/kernel-parameters.txt
@@ -852,6 +852,8 @@ and is between 256 and 4096 characters. 
 			[HW] Frequency with which keyboard LEDs should blink
 			     when kernel panics (default is 0.5 sec)
 	i8042.reset	[HW] Reset the controller during init and cleanup
+	i8042.nonfatal  [HW] Don't treat i8042.reset failures as fatal for the
+			     device initialization.
 	i8042.unlock	[HW] Unlock (ignore) the keylock
 
 	i810=		[HW,DRM]
diff -puN drivers/input/serio/i8042.c~input-introduce-a-tougher-i8042reset drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c~input-introduce-a-tougher-i8042reset
+++ a/drivers/input/serio/i8042.c
@@ -47,6 +47,10 @@ static unsigned int i8042_reset;
 module_param_named(reset, i8042_reset, bool, 0);
 MODULE_PARM_DESC(reset, "Reset controller during init and cleanup.");
 
+static unsigned int i8042_nonfatal;
+module_param_named(nonfatal, i8042_nonfatal, bool, 0);
+MODULE_PARM_DESC(reset, "Treat controller test failures as non-fatal.");
+
 static unsigned int i8042_direct;
 module_param_named(direct, i8042_direct, bool, 0);
 MODULE_PARM_DESC(direct, "Put keyboard port into non-translated mode.");
@@ -712,22 +716,33 @@ static int i8042_controller_check(void)
 static int i8042_controller_selftest(void)
 {
 	unsigned char param;
+	int i = 0;
 
 	if (!i8042_reset)
 		return 0;
 
-	if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
-		printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
-		return -ENODEV;
-	}
+	/*
+	 * We try this 5 times; on some really fragile systems this does not
+	 * take the first time...
+	 */
+	do {
+
+		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
+			printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
+			return -ENODEV;
+		}
+
+		if (param == I8042_RET_CTL_TEST)
+			return 0;
 
-	if (param != I8042_RET_CTL_TEST) {
 		printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
-			 param, I8042_RET_CTL_TEST);
-		return -EIO;
-	}
+			param, I8042_RET_CTL_TEST);
+		msleep(50);
+	} while (i++ < 5);
 
-	return 0;
+	if (i8042_nonfatal)
+		return 0;
+	return -EIO;
 }
 
 /*
_
