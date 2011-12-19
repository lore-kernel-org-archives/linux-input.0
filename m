From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH v2] Input: bcm5974 - Fix USB autosuspend
Date: Mon, 19 Dec 2011 18:02:03 +0100
Message-ID: <1324314123-2200-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

The bcm5974 code takes a USB autosuspend reference on device open and
releases it on device close. This means that the hardware won't sleep
when anything holds it open. This is sensible for input devices that
don't support remote wakeups on normal use (like most mice), but this
hardware trigger wakeups on touch and so can suspend transparently to
the user. Doing so allows the USB host controller to sleep when the
machine is idle, giving measurable power savings.

[rydberg@euromail.se: wakeup before mode switch]
Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..4f0b10d 100644
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
@@ -732,10 +734,15 @@ err_out:
 	return error;
 }
 
-static void bcm5974_pause_traffic(struct bcm5974 *dev)
+static void bcm5974_kill_urbs(struct bcm5974 *dev)
 {
 	usb_kill_urb(dev->tp_urb);
 	usb_kill_urb(dev->bt_urb);
+}
+
+static void bcm5974_pause_traffic(struct bcm5974 *dev)
+{
+	bcm5974_kill_urbs(dev);
 	bcm5974_wellspring_mode(dev, false);
 }
 
@@ -764,8 +771,7 @@ static int bcm5974_open(struct input_dev *input)
 
 	mutex_unlock(&dev->pm_mutex);
 
-	if (error)
-		usb_autopm_put_interface(dev->intf);
+	usb_autopm_put_interface(dev->intf);
 
 	return error;
 }
@@ -773,15 +779,23 @@ static int bcm5974_open(struct input_dev *input)
 static void bcm5974_close(struct input_dev *input)
 {
 	struct bcm5974 *dev = input_get_drvdata(input);
+	int error;
+
+	error = usb_autopm_get_interface(dev->intf);
 
 	mutex_lock(&dev->pm_mutex);
 
-	bcm5974_pause_traffic(dev);
+	bcm5974_kill_urbs(dev);
 	dev->opened = 0;
+	if (error)
+		err("bcm5974: wakeup failed during close: %d\n", error);
+	else
+		bcm5974_wellspring_mode(dev, false);
 
 	mutex_unlock(&dev->pm_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (!error)
+		usb_autopm_put_interface(dev->intf);
 }
 
 static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
@@ -870,6 +884,9 @@ static int bcm5974_probe(struct usb_interface *iface,
 			 dev->tp_data, dev->cfg.tp_datalen,
 			 bcm5974_irq_trackpad, dev, 1);
 
+	/* Required for autosuspend */
+	iface->needs_remote_wakeup = 1;
+
 	/* create bcm5974 device */
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
-- 
1.7.8
