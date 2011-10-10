From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 09:41:26 -0400
Message-ID: <1318254086-22752-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab1JJNlW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 09:41:22 -0400
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

Got rid of the unbalanced put on the close path, and added usb_mark_last_busy()
calls to make sure the device doesn't go to sleep while in use. This works fine
on my hardware now, and I don't see any warning messages being generated.

 drivers/input/mouse/bcm5974.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..453e9da 100644
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
-- 
1.7.6.4

