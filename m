From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH] ati_remote2: Add autosuspend support (v2)
Date: Fri, 13 Jun 2008 00:31:22 +0300
Message-ID: <20080612213122.GE9041@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add autosuspend support to ati_remote2.

Signed-off-by: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
---
Changes from v1:
- Only call autopm_get/put stuff for one of the interfaces since it's e=
nough.
- Enable the needs_remote_wakeup flag for one interface (looks like one=
 should
  be enough here as well).

 drivers/input/misc/ati_remote2.c |  133 ++++++++++++++++++++++++++++++=
+++++++--
 1 file changed, 127 insertions(+), 6 deletions(-)

Index: linux-2.6.25.4/drivers/input/misc/ati_remote2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.25.4.orig/drivers/input/misc/ati_remote2.c
+++ linux-2.6.25.4/drivers/input/misc/ati_remote2.c
@@ -45,6 +45,13 @@ static struct usb_device_id ati_remote2_
 };
 MODULE_DEVICE_TABLE(usb, ati_remote2_id_table);
=20
+static DEFINE_MUTEX(ati_remote2_mutex);
+
+enum {
+	ATI_REMOTE2_OPENED =3D 0x1,
+	ATI_REMOTE2_SUSPENDED =3D 0x2,
+};
+
 enum {
 	ATI_REMOTE2_AUX1,
 	ATI_REMOTE2_AUX2,
@@ -124,46 +131,103 @@ struct ati_remote2 {
=20
 	/* Each mode (AUX1-AUX4 and PC) can have an independent keymap. */
 	u16 keycode[ATI_REMOTE2_MODES][ARRAY_SIZE(ati_remote2_key_table)];
+
+	unsigned int flags;
 };
=20
 static int ati_remote2_probe(struct usb_interface *interface, const st=
ruct usb_device_id *id);
 static void ati_remote2_disconnect(struct usb_interface *interface);
+static int ati_remote2_suspend(struct usb_interface *interface, pm_mes=
sage_t message);
+static int ati_remote2_resume(struct usb_interface *interface);
=20
 static struct usb_driver ati_remote2_driver =3D {
 	.name       =3D "ati_remote2",
 	.probe      =3D ati_remote2_probe,
 	.disconnect =3D ati_remote2_disconnect,
 	.id_table   =3D ati_remote2_id_table,
+	.suspend    =3D ati_remote2_suspend,
+	.resume     =3D ati_remote2_resume,
+	.supports_autosuspend =3D 1,
 };
=20
-static int ati_remote2_open(struct input_dev *idev)
+static int ati_remote2_submit_urbs(struct ati_remote2 *ar2)
 {
-	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
 	int r;
=20
 	r =3D usb_submit_urb(ar2->urb[0], GFP_KERNEL);
 	if (r) {
 		dev_err(&ar2->intf[0]->dev,
-			"%s: usb_submit_urb() =3D %d\n", __FUNCTION__, r);
+			"%s(): usb_submit_urb() =3D %d\n", __FUNCTION__, r);
 		return r;
 	}
 	r =3D usb_submit_urb(ar2->urb[1], GFP_KERNEL);
 	if (r) {
 		usb_kill_urb(ar2->urb[0]);
 		dev_err(&ar2->intf[1]->dev,
-			"%s: usb_submit_urb() =3D %d\n", __FUNCTION__, r);
+			"%s(): usb_submit_urb() =3D %d\n", __FUNCTION__, r);
 		return r;
 	}
=20
 	return 0;
 }
=20
+static void ati_remote2_kill_urbs(struct ati_remote2 *ar2)
+{
+	usb_kill_urb(ar2->urb[1]);
+	usb_kill_urb(ar2->urb[0]);
+}
+
+static int ati_remote2_open(struct input_dev *idev)
+{
+	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
+	int r;
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	r =3D usb_autopm_get_interface(ar2->intf[0]);
+	if (r) {
+		dev_err(&ar2->intf[0]->dev,
+			"%s(): usb_autopm_get_interface() =3D %d\n", __FUNCTION__, r);
+		goto fail1;
+	}
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (!(ar2->flags & ATI_REMOTE2_SUSPENDED)) {
+		r =3D ati_remote2_submit_urbs(ar2);
+		if (r)
+			goto fail2;
+	}
+
+	ar2->flags |=3D ATI_REMOTE2_OPENED;
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
 	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
=20
-	usb_kill_urb(ar2->urb[0]);
-	usb_kill_urb(ar2->urb[1]);
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (!(ar2->flags & ATI_REMOTE2_SUSPENDED))
+		ati_remote2_kill_urbs(ar2);
+
+	ar2->flags &=3D ~ATI_REMOTE2_OPENED;
+
+	mutex_unlock(&ati_remote2_mutex);
 }
=20
 static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
@@ -288,6 +352,7 @@ static void ati_remote2_complete_mouse(s
=20
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_mouse(ar2);
 		break;
 	case -ENOENT:
@@ -298,6 +363,7 @@ static void ati_remote2_complete_mouse(s
 			"%s(): urb status =3D %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[0]->dev,
 			"%s(): urb status =3D %d\n", __FUNCTION__, urb->status);
 	}
@@ -315,6 +381,7 @@ static void ati_remote2_complete_key(str
=20
 	switch (urb->status) {
 	case 0:
+		usb_mark_last_busy(ar2->udev);
 		ati_remote2_input_key(ar2);
 		break;
 	case -ENOENT:
@@ -325,6 +392,7 @@ static void ati_remote2_complete_key(str
 			"%s(): urb status =3D %d\n", __FUNCTION__, urb->status);
 		return;
 	default:
+		usb_mark_last_busy(ar2->udev);
 		dev_err(&ar2->intf[1]->dev,
 			"%s(): urb status =3D %d\n", __FUNCTION__, urb->status);
 	}
@@ -562,6 +630,8 @@ static int ati_remote2_probe(struct usb_
=20
 	usb_set_intfdata(interface, ar2);
=20
+	interface->needs_remote_wakeup =3D 1;
+
 	return 0;
=20
  fail2:
@@ -594,6 +664,57 @@ static void ati_remote2_disconnect(struc
 	kfree(ar2);
 }
=20
+static int ati_remote2_suspend(struct usb_interface *interface,
+			       pm_message_t message)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt =3D interface->cur_altsetting;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 =3D usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (ar2->flags & ATI_REMOTE2_OPENED)
+		ati_remote2_kill_urbs(ar2);
+
+	ar2->flags |=3D ATI_REMOTE2_SUSPENDED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	return 0;
+}
+
+static int ati_remote2_resume(struct usb_interface *interface)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt =3D interface->cur_altsetting;
+	int r =3D 0;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 =3D usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCTION__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (ar2->flags & ATI_REMOTE2_OPENED)
+		r =3D ati_remote2_submit_urbs(ar2);
+
+	if (!r)
+		ar2->flags &=3D ~ATI_REMOTE2_SUSPENDED;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	return r;
+}
+
 static int __init ati_remote2_init(void)
 {
 	int r;
--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
