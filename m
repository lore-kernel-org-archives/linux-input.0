From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] Input: gtco: fix crash on detecting device without endpoints
Date: Fri, 18 Mar 2016 19:35:00 +0100
Message-ID: <1458326100-14899-1-git-send-email-vdronov@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbcCRSfP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2016 14:35:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>

The gtco driver expects at least one valid endpoint. If given
malicious descriptors that specify 0 for the number of endpoints,
it will crash in the probe function. Ensure there is at least
one endpoint on the interface before using it. Fix minor coding
style issue.

The full report of this issue can be found here:
http://seclists.org/bugtraq/2016/Mar/86

Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/input/tablet/gtco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index 3a7f3a4..7c18249 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -858,6 +858,14 @@ static int gtco_probe(struct usb_interface *usbinterface,
 		goto err_free_buf;
 	}
 
+	/* Sanity check that a device has an endpoint */
+	if (usbinterface->altsetting[0].desc.bNumEndpoints < 1) {
+		dev_err(&usbinterface->dev,
+			"Invalid number of endpoints\n");
+		error = -EINVAL;
+		goto err_free_urb;
+	}
+
 	/*
 	 * The endpoint is always altsetting 0, we know this since we know
 	 * this device only has one interrupt endpoint
@@ -879,7 +887,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	 * HID report descriptor
 	 */
 	if (usb_get_extra_descriptor(usbinterface->cur_altsetting,
-				     HID_DEVICE_TYPE, &hid_desc) != 0){
+				     HID_DEVICE_TYPE, &hid_desc) != 0) {
 		dev_err(&usbinterface->dev,
 			"Can't retrieve exta USB descriptor to get hid report descriptor length\n");
 		error = -EIO;
-- 
2.5.0
