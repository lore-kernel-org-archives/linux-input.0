From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]convert away from urb->status in xpad driver #2
Date: Thu, 3 Apr 2008 21:40:59 +0200
Message-ID: <200804032141.00023.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44969 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762676AbYDCToE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 15:44:04 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, honza@jikos.cz, Greg KH <greg@kroah.com>

USB is moving to transfering status as a parameter. To ease the transition
urb->status is to be touched only once in a function. The xpad driver has
been overlooked. Dmitry wants this to go through the USB tree.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

--- linux-2.6.25-rc7-vanilla/drivers/input/joystick/xpad.c	2008-03-31 15:20:58.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/joystick/xpad.c	2008-04-03 13:05:26.000000000 +0200
@@ -339,9 +339,11 @@ static void xpad360_process_packet(struc
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
-	int retval;
+	int retval, status;
 
-	switch (urb->status) {
+	status = urb->status;
+
+	switch (status) {
 	case 0:
 		/* success */
 		break;
@@ -350,11 +352,11 @@ static void xpad_irq_in(struct urb *urb)
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
 		dbg("%s - urb shutting down with status: %d",
-			__FUNCTION__, urb->status);
+			__FUNCTION__, status);
 		return;
 	default:
 		dbg("%s - nonzero urb status received: %d",
-			__FUNCTION__, urb->status);
+			__FUNCTION__, status);
 		goto exit;
 	}
 
@@ -373,9 +375,11 @@ exit:
 #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 static void xpad_irq_out(struct urb *urb)
 {
-	int retval;
+	int retval, status;
+
+	status = urb->status;
 
-	switch (urb->status) {
+	switch (status) {
 		case 0:
 		/* success */
 		break;
@@ -384,11 +388,11 @@ static void xpad_irq_out(struct urb *urb
 		case -ESHUTDOWN:
 			/* this urb is terminated, clean up */
 			dbg("%s - urb shutting down with status: %d",
-				__FUNCTION__, urb->status);
+				__FUNCTION__, status);
 			return;
 		default:
 			dbg("%s - nonzero urb status received: %d",
-				__FUNCTION__, urb->status);
+				__FUNCTION__, status);
 			goto exit;
 	}
 
