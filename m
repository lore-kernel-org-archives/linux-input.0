From: Andreas Fleig <andreasfleig@gmail.com>
Subject: [PATCH v4] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Tue, 14 Apr 2015 12:09:57 +0200
Message-ID: <1429006197.2676.2@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32936 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbDNKJ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 06:09:59 -0400
Received: by wgin8 with SMTP id n8so6147402wgi.0
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 03:09:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>

Set flags INPUT_PROP_POINTER and INPUT_PROP_POINTING_STICK for the
trackpoint integrated in Lenovo USB and Bluetooth keyboards. Libinput 
checks
these flags to enable features such as middle-button-scrolling by 
default.

Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index c4c3f09..59f21a0 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -762,6 +762,23 @@ static void lenovo_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }

+static void lenovo_input_configured(struct hid_device *hdev,
+		struct hid_input *hi)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_TPKBD:
+	case USB_DEVICE_ID_LENOVO_CUSBKBD:
+	case USB_DEVICE_ID_LENOVO_CBTKBD:
+		if (test_bit(EV_REL, hi->input->evbit)) {
+			/* set only for trackpoint device */
+			__set_bit(INPUT_PROP_POINTER, hi->input->propbit);
+			__set_bit(INPUT_PROP_POINTING_STICK,
+				  hi->input->propbit);
+		}
+		break;
+	}
+}
+
 static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) 
},
@@ -774,6 +791,7 @@ MODULE_DEVICE_TABLE(hid, lenovo_devices);
 static struct hid_driver lenovo_driver = {
 	.name = "lenovo",
 	.id_table = lenovo_devices,
+	.input_configured = lenovo_input_configured,
 	.input_mapping = lenovo_input_mapping,
 	.probe = lenovo_probe,
 	.remove = lenovo_remove,



