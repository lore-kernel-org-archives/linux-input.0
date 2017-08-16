From: =?UTF-8?q?Maxime=20Belleng=C3=A9?= <maxime.bellenge@gmail.com>
Subject: [PATCH] Input: elan_i2c - Make hardware buttons work properly on Asus ROG G752xx
Date: Wed, 16 Aug 2017 13:45:13 +0200
Message-ID: <20170816114513.9967-1-maxime.bellenge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34062 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdHPLpo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Aug 2017 07:45:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Maxime=20Belleng=C3=A9?= <maxime.bellenge@gmail.com>

Asus ROG G752xx laptops have hardware buttons. Currently only the left button works if a finger touches the pad which is not very convenient.

I couldn't find a clear pattern based on ic type and product id to determine if the device has hardware buttons or if it is a clickpad as it is vendor dependant. So I chose to base the patch on dmi as I couldn't find any other laptop based on elan i2c and having hardware buttons.

Signed-off-by: Maxime Bellengé <maxime.bellenge@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 40 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3b616cb7c67f..fa417105898f 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
+#include <linux/dmi.h>
 
 #include "elan_i2c.h"
 
@@ -923,6 +924,7 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	}
 
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);
+        input_report_key(input, BTN_RIGHT, tp_info & 0x02);
 	input_report_abs(input, ABS_DISTANCE, hover_event != 0);
 	input_mt_report_pointer_emulation(input, true);
 	input_sync(input);
@@ -960,6 +962,39 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 }
 
 /*
+ * Asus ROG G752xx have hardware buttons
+ */
+ static const struct dmi_system_id elan_dmi_has_hw_buttons[] = {
+ #if defined(CONFIG_DMI) && defined(CONFIG_X86)
+ 	{
+ 		.matches = {
+ 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+ 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VT"),
+ 		},
+ 	},
+ 	{
+ 		.matches = {
+ 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+ 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VS"),
+ 		},
+ 	},
+        {
+ 		.matches = {
+ 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+ 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VY"),
+ 		},
+ 	},
+        {
+ 		.matches = {
+ 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+ 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VL"),
+ 		},
+ 	},
+ #endif
+ 	{ }
+ };
+
+/*
  ******************************************************************
  * Elan initialization functions
  ******************************************************************
@@ -991,7 +1026,10 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 
 	__set_bit(EV_ABS, input->evbit);
 	__set_bit(INPUT_PROP_POINTER, input->propbit);
-	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+        if (dmi_check_system(elan_dmi_has_hw_buttons)) {
+                __set_bit(BTN_RIGHT, input->keybit);
+        } else
+	       __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	__set_bit(BTN_LEFT, input->keybit);
 
 	/* Set up ST parameters */
-- 
2.13.5

