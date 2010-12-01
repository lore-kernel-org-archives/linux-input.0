From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 1/2] Input: xpad - fix memory leak
Date: Thu,  2 Dec 2010 00:04:33 +0900
Message-ID: <1291215874-5625-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0LAPEp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 10:04:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

xpad->bdata was dynamically allocated but never freed. Since it is
used for xpad->bulk_out->transfer_buffer, set URB_FREE_BUFFER flag
in order to get freed when usb_free_urb() called.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 drivers/input/joystick/xpad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f9fb7fa..f885902 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -955,6 +955,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		usb_fill_bulk_urb(xpad->bulk_out, udev,
 				usb_sndbulkpipe(udev, ep_irq_in->bEndpointAddress),
 				xpad->bdata, XPAD_PKT_LEN, xpad_bulk_out, xpad);
+		xpad->bulk_out->transfer_flags |= URB_FREE_BUFFER;
 	}
 
 	return 0;
-- 
1.7.0.4

