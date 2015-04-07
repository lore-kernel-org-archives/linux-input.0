From: Andreas Fleig <andreasfleig@gmail.com>
Subject: [PATCH] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Tue, 07 Apr 2015 11:32:49 +0200
Message-ID: <1428399169.9694.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35032 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbDGJcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Apr 2015 05:32:52 -0400
Received: by widdi4 with SMTP id di4so10149056wid.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2015 02:32:51 -0700 (PDT)
Received: from lski-029 ([2001:7c0:600:50:2ad2:44ff:fecc:7fa4])
        by mx.google.com with ESMTPSA id w3sm10186581wiz.5.2015.04.07.02.32.49
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 02:32:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Set flags INPUT_PROP_POINTER and INPUT_PROP_POINTING_STICK for the
trackpoint integrated in Lenovo USB and Bluetooth keyboards. Libinput 
checks
these flags to enable features such as middle-button-scrolling by 
default.

Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index c4c3f09..4cb7235 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -762,6 +762,16 @@ static void lenovo_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }

+static void lenovo_input_configured(struct hid_device *hdev,
+		struct hid_input *hi)
+{
+	if (*hi->input->ledbit == 0) {
+		/* set only for trackpoint device, identify by missing LEDs */
+		__set_bit(INPUT_PROP_POINTER, hi->input->propbit);
+		__set_bit(INPUT_PROP_POINTING_STICK, hi->input->propbit);
+	}
+}
+
 static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) 
},
@@ -774,6 +784,7 @@ MODULE_DEVICE_TABLE(hid, lenovo_devices);
 static struct hid_driver lenovo_driver = {
 	.name = "lenovo",
 	.id_table = lenovo_devices,
+	.input_configured = lenovo_input_configured,
 	.input_mapping = lenovo_input_mapping,
 	.probe = lenovo_probe,
 	.remove = lenovo_remove,



