From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: wacom: NULL dereferences on error in probe()
Date: Wed, 24 Jun 2015 17:27:43 +0300
Message-ID: <20150624142743.GA1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We can't pass a NULL to input_unregister_device().

Fixes: 2a6cdbdd4cc0 ('HID: wacom: Introduce new 'touch_input' device')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4c0ffca..44958d7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1271,11 +1271,13 @@ fail_leds:
 	pad_input_dev = NULL;
 	wacom_wac->pad_registered = false;
 fail_register_pad_input:
-	input_unregister_device(touch_input_dev);
+	if (touch_input_dev)
+		input_unregister_device(touch_input_dev);
 	wacom_wac->touch_input = NULL;
 	wacom_wac->touch_registered = false;
 fail_register_touch_input:
-	input_unregister_device(pen_input_dev);
+	if (pen_input_dev)
+		input_unregister_device(pen_input_dev);
 	wacom_wac->pen_input = NULL;
 	wacom_wac->pen_registered = false;
 fail_register_pen_input:
