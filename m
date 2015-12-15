From: Charlie Mooney <charliemooney@chromium.org>
Subject: [PATCH] input: Report vendor and product IDs for elan_i2c
Date: Tue, 15 Dec 2015 11:11:12 -0800
Message-ID: <1450206672-9840-1-git-send-email-charliemooney@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34729 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbbLOTLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 14:11:41 -0500
Received: by mail-pa0-f50.google.com with SMTP id wq6so9307959pac.1
        for <linux-input@vger.kernel.org>; Tue, 15 Dec 2015 11:11:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dusonlin@emc.com.tw, charliemooney@chromium.org, jkosina@suse.com, michele.curti@gmail.com, k.kozlowski@samsung.com, bleung@chromium.org, drake@endlessm.com, linux-kernel@vger.kernel.org

Previously the "vendor" and "product" IDs for the elan_i2c
driver simply reported 0000.  This patch modifies the elan_i2c
driver to include the Elan vendor ID and the touchpad's product
id under input/input*/{vendor,product}.

Specifically, this is to allow us to apply a generic Elan gestures
config that will apply to all Elan touchpads on ChromeOS.  These
configs  match to input devices in various ways, but one major way
is by matching on vendor ID.  Adding this patch allows the
default Elan touchpad config to be applied to Elan touchpads in
this kernel by matching on devices that have vendor ID 04f3.

To test this patch, I mannually built and installed the modified
driver for my laptop which has an elan_i2c touchpad.  Everything
still functions correctly, and when I query the vendor and product
ID I see what I expected:

localhost i2c-ELAN0000:00 # cat \
    /sys/bus/i2c/devices/i2c-ELAN0000\:00/input/input6/id/{vendor,product}
04f3
007f

Before this patch it simply returned 0000 for both values.  Note that
007F is the product ID that this device will return through its custom
sysfs entry "product_id" as well.

Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5e1665b..2f58985 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -41,6 +41,7 @@
 
 #define DRIVER_NAME		"elan_i2c"
 #define ELAN_DRIVER_VERSION	"1.6.1"
+#define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
@@ -914,6 +915,8 @@ static int elan_setup_input_device(struct elan_tp_data *data)
 
 	input->name = "Elan Touchpad";
 	input->id.bustype = BUS_I2C;
+	input->id.vendor = ELAN_VENDOR_ID;
+	input->id.product = data->product_id;
 	input_set_drvdata(input, data);
 
 	error = input_mt_init_slots(input, ETP_MAX_FINGERS,
-- 
2.1.2

