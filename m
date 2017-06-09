From: Joe Perches <joe@perches.com>
Subject: [PATCH] hil_kbd: Use more common logging style
Date: Fri,  9 Jun 2017 14:12:32 -0700
Message-ID: <9db67b231b99c8412f5cc90036d385fa9c6acbd9.1497042739.git.joe@perches.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:33636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751682AbdFIVMn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 17:12:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Remove use of #define PREFIX and use #define pr_fmt

Miscellanea:

o Convert printk(KERN_<LEVEL> to pr_<level>
o Realign arguments
o Remove duplicate "HIL" prefixes from a few messages

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/input/keyboard/hil_kbd.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index 5b152f25a8e1..ee5f005adb60 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -31,6 +31,8 @@
  *
  */
 
+#define pr_fmt(fmt) "HIL: " fmt
+
 #include <linux/hil.h>
 #include <linux/input.h>
 #include <linux/serio.h>
@@ -40,8 +42,6 @@
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 
-#define PREFIX "HIL: "
-
 MODULE_AUTHOR("Brian S. Julin <bri@calyx.com>");
 MODULE_DESCRIPTION("HIL keyboard/mouse driver");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -130,7 +130,7 @@ static void hil_dev_handle_command_response(struct hil_dev *dev)
 		/* These occur when device isn't present */
 		if (p != (HIL_ERR_INT | HIL_PKT_CMD)) {
 			/* Anything else we'd like to know about. */
-			printk(KERN_WARNING PREFIX "Device sent unknown record %x\n", p);
+			pr_warn("Device sent unknown record %x\n", p);
 		}
 		goto out;
 	}
@@ -211,8 +211,7 @@ static void hil_dev_handle_ptr_events(struct hil_dev *ptr)
 	bool absdev, ax16;
 
 	if ((p & HIL_CMDCT_POL) != idx - 1) {
-		printk(KERN_WARNING PREFIX
-			"Malformed poll packet %x (idx = %i)\n", p, idx);
+		pr_warn("Malformed poll packet %x (idx = %i)\n", p, idx);
 		return;
 	}
 
@@ -266,7 +265,7 @@ static void hil_dev_handle_ptr_events(struct hil_dev *ptr)
 
 static void hil_dev_process_err(struct hil_dev *dev)
 {
-	printk(KERN_WARNING PREFIX "errored HIL packet\n");
+	pr_warn("errored HIL packet\n");
 	dev->idx4 = 0;
 	complete(&dev->cmd_done); /* just in case somebody is waiting */
 }
@@ -346,7 +345,7 @@ static void hil_dev_keyboard_setup(struct hil_dev *kbd)
 	input_dev->name	= strlen(kbd->rnm) ? kbd->rnm : "HIL keyboard";
 	input_dev->phys	= "hpkbd/input0";
 
-	printk(KERN_INFO PREFIX "HIL keyboard found (did = 0x%02x, lang = %s)\n",
+	pr_info("keyboard found (did = 0x%02x, lang = %s)\n",
 		did, hil_language[did & HIL_IDD_DID_TYPE_KB_LANG_MASK]);
 }
 
@@ -432,11 +431,8 @@ static void hil_dev_pointer_setup(struct hil_dev *ptr)
 
 	input_dev->name = strlen(ptr->rnm) ? ptr->rnm : "HIL pointer device";
 
-	printk(KERN_INFO PREFIX
-		"HIL pointer device found (did: 0x%02x, axis: %s)\n",
-		did, txt);
-	printk(KERN_INFO PREFIX
-		"HIL pointer has %i buttons and %i sets of %i axes\n",
+	pr_info("pointer device found (did: 0x%02x, axis: %s)\n", did, txt);
+	pr_info("pointer has %i buttons and %i sets of %i axes\n",
 		ptr->nbtn, naxsets, ptr->naxes);
 }
 
@@ -510,8 +506,7 @@ static int hil_dev_connect(struct serio *serio, struct serio_driver *drv)
 	case HIL_IDD_DID_TYPE_CHAR:
 		if (HIL_IDD_NUM_BUTTONS(idd) ||
 		    HIL_IDD_NUM_AXES_PER_SET(*idd)) {
-			printk(KERN_INFO PREFIX
-				"combo devices are not supported.\n");
+			pr_info("combo devices are not supported\n");
 			goto bail1;
 		}
 
-- 
2.10.0.rc2.1.g053435c

