From: Thomas Reitmayr <treitmayr-lNf3axTzMcOzZXS1Dc/lvw@public.gmane.org>
Subject: [patch]reset/resume support for yealink
Date: Thu, 10 Jul 2008 20:03:22 +0200
Message-ID: <1215713002.6672.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,
the following two patches add reset/resume support to the yealink driver
and were created & reviewed by Oliver and me and tested on my yealink
device. The patches have to be applied in the same order as listed
below.
Regards,
-Thomas


Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Reitmayr <treitmayr-lNf3axTzMcOzZXS1Dc/lvw@public.gmane.org>

---

--- linux-2.6.26-sierra/drivers/input/misc/yealink.alt3.c	2008-07-02 15:42:35.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/misc/yealink.c	2008-07-02 16:14:57.000000000 +0200
@@ -122,6 +122,9 @@ struct yealink_dev {
 	int shutdown:1;
 	int open:1;
 
+	u8 *old_ringtone;
+	int tonecount;
+
 	int	stat_ix;
 	union {
 		struct yld_status s;
@@ -564,6 +567,8 @@ static void input_close(struct input_dev
 
 	down_write(&sysfs_rwsema);
 	yld->open = 0;
+	kfree(yld->old_ringtone),
+	yld->old_ringtone = NULL;
 	up_write(&sysfs_rwsema);
 	stop_traffic(yld);
 }
@@ -767,6 +772,9 @@ static ssize_t store_ringtone(struct dev
 {
 	struct yealink_dev *yld;
 
+	if (!count)
+		return 0;
+
 	down_write(&sysfs_rwsema);
 	yld = dev_get_drvdata(dev);
 	if (yld == NULL) {
@@ -776,6 +784,14 @@ static ssize_t store_ringtone(struct dev
 
 	/* TODO locking with async usb control interface??? */
 	yealink_set_ringtone(yld, (char *)buf, count);
+	kfree(yld->old_ringtone);
+	yld->old_ringtone = kmalloc(count, GFP_KERNEL);
+	if (!yld->old_ringtone)
+		goto error_bail;
+	memcpy(yld->old_ringtone, buf, count);
+	yld->tonecount = count;
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
+	struct yealink_dev *yld = usb_get_intfdata(intf);
+	int rv = 0;
+
+	down_read(&sysfs_rwsema);
+	if (!yld->open)
+		goto skip_io;
+	if (yld->old_ringtone)
+		rv = yealink_set_ringtone(yld,
+					  yld->old_ringtone,
+					  yld->tonecount);
+	else
+		rv = yealink_set_ringtone(yld,
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
 	.disconnect	= usb_disconnect,
 	.suspend	= usb_suspend,
 	.resume		= usb_resume,
+	.reset_resume	= usb_reset_resume,
 	.id_table	= usb_table,
 };
 

--- linux-2.6.26-rc8/drivers/input/misc/yealink.old.c	2008-07-03 20:10:36.000000000 +0200
+++ linux-2.6.26-rc8/drivers/input/misc/yealink.c	2008-07-03 20:10:26.000000000 +0200
@@ -903,10 +903,18 @@ static int usb_reset_resume(struct usb_i
 {
 	struct yealink_dev *yld = usb_get_intfdata(intf);
 	int rv = 0;
+	int i;
 
 	down_read(&sysfs_rwsema);
 	if (!yld->open)
 		goto skip_io;
+
+	/* force updates to device */
+	for (i = 0; i<sizeof(yld->master); i++)
+		yld->copy.b[i] = ~yld->master.b[i];
+	yld->key_code = -1;	/* no keys pressed */
+
+	/* restore the ringtone */
 	if (yld->old_ringtone)
 		rv = yealink_set_ringtone(yld,
 					  yld->old_ringtone,
@@ -916,6 +924,10 @@ static int usb_reset_resume(struct usb_i
 					  default_ringtone,
 					  sizeof(default_ringtone));
 
+	/* restart updates and key scan */
+	if (rv == 0)
+		rv = usb_submit_urb(yld->urb_ctl, GFP_NOIO);
+
 skip_io:
 	up_read(&sysfs_rwsema);
 



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
