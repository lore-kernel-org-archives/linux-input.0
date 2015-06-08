From: Terry Junge <terry.junge@plantronics.com>
Subject: [RESEND PATCH v2 1/2] HID: hid-plantronics: Update to map volume up/down controls
Date: Mon, 8 Jun 2015 14:27:57 -0700
Message-ID: <1433798877-16751-1-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail4.plantronics.com ([198.231.10.50]:42406 "EHLO
	mail4.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbFHVae (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 17:30:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Terry Junge <terry.junge@plantronics.com>, jkosina@suse.cz

Resend with mail server adjustments to stop whitespace damage to patch.

Update Kconfig with enhanced help text for hid-plantronics driver.

Update hid-plantronics.c to identify device type and correctly map
either the vendor unique or consumer control volume up/down usages
to KEY_VOLUMEUP and KEY_VOLUMEDOWN events. Unmapped usages are ignored
to prevent core mapping of unknown usages to random mouse events.

Patched against git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git

Tested on ChromeBox/ChromeBook with various Plantronics devices.

Signed-off-by: Terry Junge <terry.junge@plantronics.com>
---
 drivers/hid/Kconfig           |   7 ++-
 drivers/hid/hid-plantronics.c | 132 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 15338af..cc4c664 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -634,7 +634,12 @@ config HID_PLANTRONICS
 	tristate "Plantronics USB HID Driver"
 	depends on HID
 	---help---
-	Provides HID support for Plantronics telephony devices.
+	  Provides HID support for Plantronics USB audio devices.
+	  Correctly maps vendor unique volume up/down HID usages to
+	  KEY_VOLUMEUP and KEY_VOLUMEDOWN events and prevents core mapping
+	  of other vendor unique HID usages to random mouse events.
+
+	  Say M here if you may ever plug in a Plantronics USB audio device.
 
 config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 2180e07..febb21e 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -2,7 +2,7 @@
  *  Plantronics USB HID Driver
  *
  *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
- *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
+ *  Copyright (c) 2015 Terry Junge <terry.junge@plantronics.com>
  */
 
 /*
@@ -17,23 +17,138 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 
+#define PLT_HID_1_0_PAGE	0xffa00000
+#define PLT_HID_2_0_PAGE	0xffa20000
+
+#define PLT_BASIC_TELEPHONY	0x0003
+#define PLT_BASIC_EXCEPTION	0x0005
+
+#define PLT_VOL_UP		0x00b1
+#define PLT_VOL_DOWN		0x00b2
+
+#define PLT1_VOL_UP		(PLT_HID_1_0_PAGE | PLT_VOL_UP)
+#define PLT1_VOL_DOWN		(PLT_HID_1_0_PAGE | PLT_VOL_DOWN)
+#define PLT2_VOL_UP		(PLT_HID_2_0_PAGE | PLT_VOL_UP)
+#define PLT2_VOL_DOWN		(PLT_HID_2_0_PAGE | PLT_VOL_DOWN)
+
+#define PLT_DA60		0xda60
+#define PLT_BT300_MIN		0x0413
+#define PLT_BT300_MAX		0x0418
+
+
+#define PLT_ALLOW_CONSUMER (field->application == HID_CP_CONSUMERCONTROL && \
+			    (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
+
 static int plantronics_input_mapping(struct hid_device *hdev,
 				     struct hid_input *hi,
 				     struct hid_field *field,
 				     struct hid_usage *usage,
 				     unsigned long **bit, int *max)
 {
-	if (field->application == HID_CP_CONSUMERCONTROL
-	    && (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
-		hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
-			 usage->hid, field->application);
-		return 0;
+	unsigned short mapped_key;
+	unsigned long plt_type = (unsigned long)hid_get_drvdata(hdev);
+
+	/* handle volume up/down mapping */
+	/* non-standard types or multi-HID interfaces - plt_type is PID */
+	if (!(plt_type & HID_USAGE_PAGE)) {
+		switch (plt_type) {
+		case PLT_DA60:
+			if (PLT_ALLOW_CONSUMER)
+				goto defaulted;
+			goto ignored;
+		default:
+			if (PLT_ALLOW_CONSUMER)
+				goto defaulted;
+		}
+	}
+	/* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
+	/* 'basic telephony compliant' - allow default consumer page map */
+	else if ((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
+		 (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) {
+		if (PLT_ALLOW_CONSUMER)
+			goto defaulted;
+	}
+	/* not 'basic telephony' - apply legacy mapping */
+	/* only map if the field is in the device's primary vendor page */
+	else if (!((field->application ^ plt_type) & HID_USAGE_PAGE)) {
+		switch (usage->hid) {
+		case PLT1_VOL_UP:
+		case PLT2_VOL_UP:
+			mapped_key = KEY_VOLUMEUP;
+			goto mapped;
+		case PLT1_VOL_DOWN:
+		case PLT2_VOL_DOWN:
+			mapped_key = KEY_VOLUMEDOWN;
+			goto mapped;
+		}
 	}
 
-	hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
-		usage->hid, field->application);
+/*
+ * Future mapping of call control or other usages,
+ * if and when keys are defined would go here
+ * otherwise, ignore everything else that was not mapped
+ */
 
+ignored:
 	return -1;
+
+defaulted:
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
+		usage->hid, field->application);
+	return 0;
+
+mapped:
+	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, mapped_key);
+	hid_dbg(hdev, "usage: %08x (appl: %08x) - mapped to key %d\n",
+		usage->hid, field->application, mapped_key);
+	return 1;
+}
+
+static unsigned long plantronics_device_type(struct hid_device *hdev)
+{
+	unsigned i, col_page;
+	unsigned long plt_type = hdev->product;
+
+	/* multi-HID interfaces? - plt_type is PID */
+	if (plt_type >= PLT_BT300_MIN && plt_type <= PLT_BT300_MAX)
+		goto exit;
+
+	/* determine primary vendor page */
+	for (i = 0; i < hdev->maxcollection; i++) {
+		col_page = hdev->collection[i].usage & HID_USAGE_PAGE;
+		if (col_page == PLT_HID_2_0_PAGE) {
+			plt_type = hdev->collection[i].usage;
+			break;
+		}
+		if (col_page == PLT_HID_1_0_PAGE)
+			plt_type = hdev->collection[i].usage;
+	}
+
+exit:
+	hid_dbg(hdev, "plt_type decoded as: %08lx\n", plt_type);
+	return plt_type;
+}
+
+static int plantronics_probe(struct hid_device *hdev,
+			     const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	hid_set_drvdata(hdev, (void *)plantronics_device_type(hdev));
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT |
+		HID_CONNECT_HIDINPUT_FORCE | HID_CONNECT_HIDDEV_FORCE);
+	if (ret)
+		hid_err(hdev, "hw start failed\n");
+
+err:
+	return ret;
 }
 
 static const struct hid_device_id plantronics_devices[] = {
@@ -46,6 +161,7 @@ static struct hid_driver plantronics_driver = {
 	.name = "plantronics",
 	.id_table = plantronics_devices,
 	.input_mapping = plantronics_input_mapping,
+	.probe = plantronics_probe,
 };
 module_hid_driver(plantronics_driver);
 
-- 
1.9.1

