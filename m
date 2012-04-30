From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: wacom - use dev_xxx() instead of naked printk()s and
 dbg()s
Date: Sun, 29 Apr 2012 22:51:31 -0700
Message-ID: <20120430055130.GA12364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58893 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab2D3Fvh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 01:51:37 -0400
Received: by pbbrp8 with SMTP id rp8so2908689pbb.19
        for <linux-input@vger.kernel.org>; Sun, 29 Apr 2012 22:51:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/tablet/wacom_sys.c |   15 ++++++++-------
 drivers/input/tablet/wacom_wac.c |   29 +++++++++++++++++++----------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 8f3b30b..b3a8bd3 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -522,7 +522,8 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 		error = usb_get_extra_descriptor(&interface->endpoint[0],
 						 HID_DEVICET_REPORT, &hid_desc);
 		if (error) {
-			printk(KERN_ERR "wacom: can not retrieve extra class descriptor\n");
+			dev_err(&intf->dev,
+				"can not retrieve extra class descriptor\n");
 			goto out;
 		}
 	}
@@ -1040,13 +1041,13 @@ static void wacom_wireless_work(struct work_struct *work)
 	wacom->wacom_wac.input = NULL;
 
 	if (wacom_wac->pid == 0) {
-		printk(KERN_INFO "wacom: wireless tablet disconnected\n");
+		dev_info(&wacom->intf->dev, "wireless tablet disconnected\n");
 	} else {
 		const struct usb_device_id *id = wacom_ids;
 
-		printk(KERN_INFO
-		       "wacom: wireless tablet connected with PID %x\n",
-		       wacom_wac->pid);
+		dev_info(&wacom->intf->dev,
+			 "wireless tablet connected with PID %x\n",
+			 wacom_wac->pid);
 
 		while (id->match_flags) {
 			if (id->idVendor == USB_VENDOR_ID_WACOM &&
@@ -1056,8 +1057,8 @@ static void wacom_wireless_work(struct work_struct *work)
 		}
 
 		if (!id->match_flags) {
-			printk(KERN_INFO
-			       "wacom: ignorning unknown PID.\n");
+			dev_info(&wacom->intf->dev,
+				 "ignoring unknown PID.\n");
 			return;
 		}
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 10e5cf8..004bc1b 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -61,7 +61,8 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom)
 		break;
 
 	default:
-		printk(KERN_INFO "wacom_penpartner_irq: received unknown report #%d\n", data[0]);
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
 		return 0;
         }
 
@@ -76,7 +77,8 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 	int prox, pressure;
 
 	if (data[0] != WACOM_REPORT_PENABLED) {
-		dbg("wacom_pl_irq: received unknown report #%d", data[0]);
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
 		return 0;
 	}
 
@@ -146,7 +148,8 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->input;
 
 	if (data[0] != WACOM_REPORT_PENABLED) {
-		printk(KERN_INFO "wacom_ptu_irq: received unknown report #%d\n", data[0]);
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
 		return 0;
 	}
 
@@ -175,7 +178,8 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->input;
 	int prox = data[1] & 0x20, pressure;
 
-	dbg("wacom_dtu_irq: received report #%d", data[0]);
+	dev_dbg(input->dev.parent,
+		"%s: received report #%d", __func__, data[0]);
 
 	if (prox) {
 		/* Going into proximity select tool */
@@ -211,7 +215,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	int retval = 0;
 
 	if (data[0] != WACOM_REPORT_PENABLED) {
-		dbg("wacom_graphire_irq: received unknown report #%d", data[0]);
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
 		goto exit;
 	}
 
@@ -489,10 +494,13 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	unsigned int t;
 	int idx = 0, result;
 
-	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_INTUOSREAD
-		&& data[0] != WACOM_REPORT_INTUOSWRITE && data[0] != WACOM_REPORT_INTUOSPAD
-		&& data[0] != WACOM_REPORT_INTUOS5PAD) {
-		dbg("wacom_intuos_irq: received unknown report #%d", data[0]);
+	if (data[0] != WACOM_REPORT_PENABLED &&
+	    data[0] != WACOM_REPORT_INTUOSREAD &&
+	    data[0] != WACOM_REPORT_INTUOSWRITE &&
+	    data[0] != WACOM_REPORT_INTUOSPAD &&
+	    data[0] != WACOM_REPORT_INTUOS5PAD) {
+		dev_dbg(input->dev.parent,
+			"%s: received unknown report #%d\n", __func__, data[0]);
                 return 0;
 	}
 
@@ -938,7 +946,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
 
-	dbg("wacom_tpc_irq: received report #%d", data[0]);
+	dev_dbg(wacom->input->dev.parent,
+		"%s: received report #%d\n", __func__, data[0]);
 
 	switch (len) {
 	case WACOM_PKGLEN_TPC1FG:
-- 
1.7.7.6


-- 
Dmitry
