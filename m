From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]suspend/resume support for yealink
Date: Wed, 2 Jul 2008 16:26:49 +0200
Message-ID: <200807021626.50883.oliver@neukum.org>
References: <200806301608.03788.oliver@neukum.org> <1214862428.6977.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1214862428.6977.27.camel@localhost>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Reitmayr <treitmayr-lNf3axTzMcOzZXS1Dc/lvw@public.gmane.org>
Cc: "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Montag 30 Juni 2008 23:47:08 schrieb Thomas Reitmayr:
> * Suspend to RAM:
> =C2=A0 The device suspends properly, I hear the audio subsystem turni=
ng off
> while the display keeps its current state.
> =C2=A0 Apparently the USB root hub gets reset during suspend/resume a=
ccording
> to the kernel log. Then after resume the input events are generated

This patch may help.

	Regards
		Oliver

---

--- linux-2.6.26-sierra/drivers/input/misc/yealink.alt3.c	2008-07-02 15=
:42:35.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/misc/yealink.c	2008-07-02 16:14:5=
7.000000000 +0200
@@ -122,6 +122,9 @@ struct yealink_dev {
 	int shutdown:1;
 	int open:1;
=20
+	u8 *old_ringtone;
+	int tonecount;
+
 	int	stat_ix;
 	union {
 		struct yld_status s;
@@ -564,6 +567,8 @@ static void input_close(struct input_dev
=20
 	down_write(&sysfs_rwsema);
 	yld->open =3D 0;
+	kfree(yld->old_ringtone),
+	yld->old_ringtone =3D NULL;
 	up_write(&sysfs_rwsema);
 	stop_traffic(yld);
 }
@@ -767,6 +772,9 @@ static ssize_t store_ringtone(struct dev
 {
 	struct yealink_dev *yld;
=20
+	if (!count)
+		return 0;
+
 	down_write(&sysfs_rwsema);
 	yld =3D dev_get_drvdata(dev);
 	if (yld =3D=3D NULL) {
@@ -776,6 +784,14 @@ static ssize_t store_ringtone(struct dev
=20
 	/* TODO locking with async usb control interface??? */
 	yealink_set_ringtone(yld, (char *)buf, count);
+	kfree(yld->old_ringtone);
+	yld->old_ringtone =3D kmalloc(count, GFP_KERNEL);
+	if (!yld->old_ringtone)
+		goto error_bail;
+	memcpy(yld->old_ringtone, buf, count);
+	yld->tonecount =3D count;
+
+error_bail:
 	up_write(&sysfs_rwsema);
 	return count;
 }
@@ -882,6 +898,30 @@ static int usb_resume(struct usb_interfa
 	up_read(&sysfs_rwsema);
 	return rv;
 }
+
+static int usb_reset_resume(struct usb_interface *intf)
+{
+	struct yealink_dev *yld =3D usb_get_intfdata(intf);
+	int rv =3D 0;
+
+	down_read(&sysfs_rwsema);
+	if (!yld->open)
+		goto skip_io;
+	if (yld->old_ringtone)
+		rv =3D yealink_set_ringtone(yld,
+					  yld->old_ringtone,
+					  yld->tonecount);
+	else
+		rv =3D yealink_set_ringtone(yld,
+					  default_ringtone,
+					  sizeof(default_ringtone));
+
+skip_io:
+	up_read(&sysfs_rwsema);
+
+	return rv;
+}
+
 static void usb_disconnect(struct usb_interface *intf)
 {
 	struct yealink_dev *yld;
@@ -1030,6 +1070,7 @@ static struct usb_driver yealink_driver
 	.disconnect	=3D usb_disconnect,
 	.suspend	=3D usb_suspend,
 	.resume		=3D usb_resume,
+	.reset_resume	=3D usb_reset_resume,
 	.id_table	=3D usb_table,
 };
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
