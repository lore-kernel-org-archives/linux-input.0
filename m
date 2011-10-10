From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 11:47:10 -0400
Message-ID: <1318261630-24044-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1JJPrB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 11:47:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, dtor@mail.ru, Matthew Garrett <mjg@redhat.com>

The bcm5974 code takes a USB autosuspend reference on device open and
releases it on device close. This means that the hardware won't sleep when
anything holds it open. This is sensible for input devices that don't
support remote wakeups on normal use (like most mice), but this hardware
trigger wakeups on touch and so can suspend transparently to the user. Doing
so allows the USB host controller to sleep when the machine is idle, giving
measurable power savings.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---

Correctly flag needs_remote_wake.

 drivers/input/mouse/bcm5974.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..4ca5523 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -631,6 +631,7 @@ static void bcm5974_irq_button(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(dev->udev);
 		break;
 	case -EOVERFLOW:
 	case -ECONNRESET:
@@ -660,6 +661,7 @@ static void bcm5974_irq_trackpad(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(dev->udev);
 		break;
 	case -EOVERFLOW:
 	case -ECONNRESET:
@@ -764,8 +766,7 @@ static int bcm5974_open(struct input_dev *input)
 
 	mutex_unlock(&dev->pm_mutex);
 
-	if (error)
-		usb_autopm_put_interface(dev->intf);
+	usb_autopm_put_interface(dev->intf);
 
 	return error;
 }
@@ -780,8 +781,6 @@ static void bcm5974_close(struct input_dev *input)
 	dev->opened = 0;
 
 	mutex_unlock(&dev->pm_mutex);
-
-	usb_autopm_put_interface(dev->intf);
 }
 
 static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
@@ -870,6 +869,9 @@ static int bcm5974_probe(struct usb_interface *iface,
 			 dev->tp_data, dev->cfg.tp_datalen,
 			 bcm5974_irq_trackpad, dev, 1);
 
+	/* Required for autosuspend */
+	iface->needs_remote_wakeup = 1;
+
 	/* create bcm5974 device */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
-- 
1.7.6.4

