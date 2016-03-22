From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/4] aiptek: stop saving struct usb_device
Date: Tue, 22 Mar 2016 16:04:55 +0100
Message-ID: <1458659097-8213-3-git-send-email-oneukum@suse.com>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56295 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbcCVPHv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 11:07:51 -0400
In-Reply-To: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Oliver Neukum <oneukum@suse.com>

The device can now easily be derived from the interface.
Stop leaving a private copy.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/input/tablet/aiptek.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 78ca448..ee80c11 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -307,7 +307,6 @@ struct aiptek_settings {
 
 struct aiptek {
 	struct input_dev *inputdev;		/* input device struct           */
-	struct usb_device *usbdev;		/* usb device struct             */
 	struct usb_interface *intf;		/* usb interface struct          */
 	struct urb *urb;			/* urb for incoming reports      */
 	dma_addr_t data_dma;			/* our dma stuffage              */
@@ -847,7 +846,7 @@ static int aiptek_open(struct input_dev *inputdev)
 {
 	struct aiptek *aiptek = input_get_drvdata(inputdev);
 
-	aiptek->urb->dev = aiptek->usbdev;
+	aiptek->urb->dev = interface_to_usbdev(aiptek->intf);;
 	if (usb_submit_urb(aiptek->urb, GFP_KERNEL) != 0)
 		return -EIO;
 
@@ -873,8 +872,9 @@ aiptek_set_report(struct aiptek *aiptek,
 		  unsigned char report_type,
 		  unsigned char report_id, void *buffer, int size)
 {
-	return usb_control_msg(aiptek->usbdev,
-			       usb_sndctrlpipe(aiptek->usbdev, 0),
+	struct usb_device *udev = interface_to_usbdev(aiptek->intf);
+	return usb_control_msg(udev,
+			       usb_sndctrlpipe(udev, 0),
 			       USB_REQ_SET_REPORT,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE |
 			       USB_DIR_OUT, (report_type << 8) + report_id,
@@ -886,8 +886,9 @@ aiptek_get_report(struct aiptek *aiptek,
 		  unsigned char report_type,
 		  unsigned char report_id, void *buffer, int size)
 {
-	return usb_control_msg(aiptek->usbdev,
-			       usb_rcvctrlpipe(aiptek->usbdev, 0),
+	struct usb_device *udev = interface_to_usbdev(aiptek->intf);
+	return usb_control_msg(udev,
+			       usb_rcvctrlpipe(udev, 0),
 			       USB_REQ_GET_REPORT,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE |
 			       USB_DIR_IN, (report_type << 8) + report_id,
@@ -1729,7 +1730,6 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	}
 
 	aiptek->inputdev = inputdev;
-	aiptek->usbdev = usbdev;
 	aiptek->intf = intf;
 	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
 	aiptek->inDelay = 0;
@@ -1833,8 +1833,8 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 * input.
 	 */
 	usb_fill_int_urb(aiptek->urb,
-			 aiptek->usbdev,
-			 usb_rcvintpipe(aiptek->usbdev,
+			 usbdev,
+			 usb_rcvintpipe(usbdev,
 					endpoint->bEndpointAddress),
 			 aiptek->data, 8, aiptek_irq, aiptek,
 			 endpoint->bInterval);
-- 
2.1.4

