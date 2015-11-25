From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] Input: aiptek: fix crash on detecting device without endpoints
Date: Wed, 25 Nov 2015 16:58:08 +0100
Message-ID: <1448467088-7703-1-git-send-email-vdronov@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbbKYP6W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 10:58:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>

The aiptek driver crashes in aiptek_probe() when a specially crafted usb device
without endpoints is detected. This fix adds a check that the device has proper
configuration expected by the driver. Also an error return value is changed to
more matching one in one of the error paths.

Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/input/tablet/aiptek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index e7f966d..78c0732 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1819,6 +1819,15 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	input_set_abs_params(inputdev, ABS_TILT_Y, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
 	input_set_abs_params(inputdev, ABS_WHEEL, AIPTEK_WHEEL_MIN, AIPTEK_WHEEL_MAX - 1, 0, 0);
 
+	/* Verify that a device really has an endpoint
+	 */
+	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
+		dev_warn(&intf->dev,
+			"interface has %d endpoints, but must have minimum 1\n",
+			intf->altsetting[0].desc.bNumEndpoints);
+		err = -ENODEV;
+		goto fail3;
+	}
 	endpoint = &intf->altsetting[0].endpoint[0].desc;
 
 	/* Go set up our URB, which is called when the tablet receives
@@ -1861,6 +1870,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (i == ARRAY_SIZE(speeds)) {
 		dev_info(&intf->dev,
 			 "Aiptek tried all speeds, no sane response\n");
+		err = -ENODEV;
 		goto fail3;
 	}
 
-- 
2.6.2

