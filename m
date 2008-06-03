From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue,  3 Jun 2008 21:45:47 +0300
Message-ID: <1212518747-23000-2-git-send-email-syrjala@sci.fi>
References: <1212518747-23000-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:53848 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbYFCSps (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2008 14:45:48 -0400
In-Reply-To: <1212518747-23000-1-git-send-email-syrjala@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

Add USB autosuspend support to ati_remote2.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
The only issue I have so far with this patch is that the first key press
is lost when the device wakes up.

Do I need to worry about the remote wakeup thingy? At least remote wakeup
doesn't seem to be enabled (according to lsusb, short except below) and the
device wakes up just fine. There is a LED on the receiver which dims but
doesn't completely turn off when the device is suspended.

Bus 003 Device 003: ID 0471:0602 Philips 
Device Descriptor:
  Configuration Descriptor:
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
Device Status:     0x0000
  (Bus Powered)

 drivers/input/misc/ati_remote2.c |  140 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index b80b2fa..47071bf 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -45,6 +45,13 @@ static struct usb_device_id ati_remote2_id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, ati_remote2_id_table);
 
+static DEFINE_MUTEX(ati_remote2_mutex);
+
+enum {
+	ATI_REMOTE2_OPENED = 0x1,
+	ATI_REMOTE2_SUSPENDED = 0x2,
+};
+
 enum {
 	ATI_REMOTE2_AUX1,
 	ATI_REMOTE2_AUX2,
@@ -124,46 +131,112 @@ struct ati_remote2 {
 
 	/* Each mode (AUX1-AUX4 and PC) can have an independent keymap. */
 	u16 keycode[ATI_REMOTE2_MODES][ARRAY_SIZE(ati_remote2_key_table)];
+
+	unsigned int flags;
 };
 
 static int ati_remote2_probe(struct usb_interface *interface, const struct usb_device_id *id);
 static void ati_remote2_disconnect(struct usb_interface *interface);
+static int ati_remote2_suspend(struct usb_interface *interface, pm_message_t message);
+static int ati_remote2_resume(struct usb_interface *interface);
 
 static struct usb_driver ati_remote2_driver = {
 	.name       = "ati_remote2",
 	.probe      = ati_remote2_probe,
 	.disconnect = ati_remote2_disconnect,
 	.id_table   = ati_remote2_id_table,
+	.suspend    = ati_remote2_suspend,
+	.resume     = ati_remote2_resume,
+	.supports_autosuspend = 1,
 };
 
-static int ati_remote2_open(struct input_dev *idev)
+static int ati_remote2_submit_urbs(struct ati_remote2 *ar2)
 {
-	struct ati_remote2 *ar2 = input_get_drvdata(idev);
 	int r;
 
 	r = usb_submit_urb(ar2->urb[0], GFP_KERNEL);
 	if (r) {
 		dev_err(&ar2->intf[0]->dev,
-			"%s: usb_submit_urb() = %d\n", __FUNCTION__, r);
+			"%s(): usb_submit_urb() = %d\n", __FUNCTION__, r);
 		return r;
 	}
 	r = usb_submit_urb(ar2->urb[1], GFP_KERNEL);
 	if (r) {
 		usb_kill_urb(ar2->urb[0]);
 		dev_err(&ar2->intf[1]->dev,
-			"%s: usb_submit_urb() = %d\n", __FUNCTION__, r);
+			"%s(): usb_submit_urb() = %d\n", __FUNCTION__, r);
 		return r;
 	}
 
 	return 0;
 }
 
+static void ati_remote2_kill_urbs(struct ati_remote2 *ar2)
+{
+	usb_kill_urb(ar2->urb[1]);
+	usb_kill_urb(ar2->urb[0]);
+}
+
+static int ati_remote2_open(struct input_dev *idev)
+{
+	struct ati_remote2 *ar2 = input_get_drvdata(idev);
+	int r;
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	r = usb_autopm_get_interface(ar2->intf[0]);
+	if (r) {
+		dev_err(&ar2->intf[0]->dev,
+			"%s(): usb_autopm_get_interface() = %d\n", __FUNCTION__, r);
+		goto fail1;
+	}
+	r = usb_autopm_get_interface(ar2->intf[1]);
+	if (r) {
+		dev_err(&ar2->intf[1]->dev,
+			"%s(): usb_autopm_get_interface() = %d\n", __FUNCTION__, r);
+		goto fail2;
+	}
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (!(ar2->flags & ATI_REMOTE2_SUSPENDED)) {
+		r = ati_remote2_submit_urbs(ar2);
+		if (r)
+			goto fail3;
+	}
+
+	ar2->flags |= ATI_REMOTE2_OPENED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	usb_autopm_put_interface(ar2->intf[1]);
+	usb_autopm_put_interface(ar2->intf[0]);
+
+	return 0;
+
+ fail3:
+	mutex_unlock(&ati_remote2_mutex);
+	usb_autopm_put_interface(ar2->intf[1]);
+ fail2:
+	usb_autopm_put_interface(ar2->intf[0]);
+ fail1:
+	return r;
+}
+
 static void ati_remote2_close(struct input_dev *idev)
 {
 	struct ati_remote2 *ar2 = input_get_drvdata(idev);
 
-	usb_kill_urb(ar2->urb[0]);
-	usb_kill_urb(ar2->urb[1]);
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (!(ar2->flags & ATI_REMOTE2_SUSPENDED))
+		ati_remote2_kill_urbs(ar2);
+
+	ar2->flags &= ~ATI_REMOTE2_OPENED;
+
+	mutex_unlock(&ati_remote2_mutex);
 }
 
 static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
@@ -288,6 +361,7 @@ static void ati_remote2_complete_mouse(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_mouse(ar2);
 		break;
 	case -ENOENT:
@@ -298,6 +372,7 @@ static void ati_remote2_complete_mouse(struct urb *urb)
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[0]->dev,
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 	}
@@ -315,6 +390,7 @@ static void ati_remote2_complete_key(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_key(ar2);
 		break;
 	case -ENOENT:
@@ -325,6 +401,7 @@ static void ati_remote2_complete_key(struct urb *urb)
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[1]->dev,
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 	}
@@ -594,6 +671,57 @@ static void ati_remote2_disconnect(struct usb_interface *interface)
 	kfree(ar2);
 }
 
+static int ati_remote2_suspend(struct usb_interface *interface,
+			       pm_message_t message)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt = interface->cur_altsetting;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 = usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (ar2->flags & ATI_REMOTE2_OPENED)
+		ati_remote2_kill_urbs(ar2);
+
+	ar2->flags |= ATI_REMOTE2_SUSPENDED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	return 0;
+}
+
+static int ati_remote2_resume(struct usb_interface *interface)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt = interface->cur_altsetting;
+	int r = 0;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 = usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (ar2->flags & ATI_REMOTE2_OPENED)
+		r = ati_remote2_submit_urbs(ar2);
+
+	if (!r)
+		ar2->flags &= ~ATI_REMOTE2_SUSPENDED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	return r;
+}
+
 static int __init ati_remote2_init(void)
 {
 	int r;
-- 
1.5.3.7

