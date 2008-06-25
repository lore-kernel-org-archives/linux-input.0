From: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Wed, 25 Jun 2008 13:56:11 +0300
Message-ID: <1214391371-13698-3-git-send-email-syrjala@sci.fi>
References: <1214391371-13698-1-git-send-email-syrjala@sci.fi>
 <1214391371-13698-2-git-send-email-syrjala@sci.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1214391371-13698-2-git-send-email-syrjala-ORSVBvAovxo@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add autosuspend support to ati_remote2.

Signed-off-by: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
---
 drivers/input/misc/ati_remote2.c |  133 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index b80b2fa..27d9c02 100644
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
@@ -124,46 +131,103 @@ struct ati_remote2 {
 
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
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (!(ar2->flags & ATI_REMOTE2_SUSPENDED)) {
+		r = ati_remote2_submit_urbs(ar2);
+		if (r)
+			goto fail2;
+	}
+
+	ar2->flags |= ATI_REMOTE2_OPENED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	usb_autopm_put_interface(ar2->intf[0]);
+
+	return 0;
+
+ fail2:
+	mutex_unlock(&ati_remote2_mutex);
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
@@ -288,6 +352,7 @@ static void ati_remote2_complete_mouse(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_mouse(ar2);
 		break;
 	case -ENOENT:
@@ -298,6 +363,7 @@ static void ati_remote2_complete_mouse(struct urb *urb)
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[0]->dev,
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 	}
@@ -315,6 +381,7 @@ static void ati_remote2_complete_key(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_key(ar2);
 		break;
 	case -ENOENT:
@@ -325,6 +392,7 @@ static void ati_remote2_complete_key(struct urb *urb)
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[1]->dev,
 			"%s(): urb status = %d\n", __FUNCTION__, urb->status);
 	}
@@ -562,6 +630,8 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 
 	usb_set_intfdata(interface, ar2);
 
+	interface->needs_remote_wakeup = 1;
+
 	return 0;
 
  fail2:
@@ -594,6 +664,57 @@ static void ati_remote2_disconnect(struct usb_interface *interface)
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
1.5.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
