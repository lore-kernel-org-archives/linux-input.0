From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Wed, 9 Jun 2010 18:36:14 +0200
Message-ID: <201006091836.14136.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <20100607161920.GA7706@core.coreip.homeip.net> <201006091540.06003.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:36446 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0FIQf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 12:35:59 -0400
In-Reply-To: <201006091540.06003.linux@rainbow-software.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

Am Mittwoch, 9. Juni 2010 15:40:04 schrieb Ondrej Zary:

> Looking at the patches from archive:
> 
> If I understand it correctly, usbtouch_resume submits the irq URB only if
> the input device is open. That will fail with Nexio as it has an internal
> watchdog which needs URBs or the device will reconnect - see irq_always
> (Zytronic seems to need it too).

Thank you for the review. Does this patch fix the issues?

	Regards
		Oliver

>From 3fe66013333931b4b0cb7361fbe60d502d306eb4 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Wed, 9 Jun 2010 18:32:58 +0200
Subject: [PATCH] usbtouchscreen: fix typo and touchpads which require constant polling

1. fix typo
2. start polling on closed devices if they require it

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/input/touchscreen/usbtouchscreen.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 421f168..d13517a 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1333,7 +1333,7 @@ static int usbtouch_resume(struct usb_interface *intf)
 	int result = 0;
 	
 	mutex_lock(&input->mutex);
-	if (input->users)
+	if (input->users || usbtouch->type->irq_always)
 		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
 	mutex_unlock(&input->mutex);
 	return result;
@@ -1484,7 +1484,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	/* device specific allocations */
-	if (type->init) {
+	if (type->alloc) {
 		err = type->alloc(usbtouch);
 		if (err) {
 			dbg("%s - type->alloc() failed, err: %d", __func__, err);
-- 
1.6.4.2

