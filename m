From: Thomas Reitmayr <treitmayr-lNf3axTzMcOzZXS1Dc/lvw@public.gmane.org>
Subject: Re: [rft]suspend/resume support for yealink
Date: Thu, 03 Jul 2008 20:27:53 +0200
Message-ID: <1215109674.6680.17.camel@localhost>
References: <200806301608.03788.oliver@neukum.org>
	 <1214862428.6977.27.camel@localhost> <200807021626.50883.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200807021626.50883.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Oliver,
your patch did improve things, however I had to add the submission of
the control URB to get the update/scan cycle going (same as in
usb_resume). As yealink_set_ringtone uses synchronous USB submissions it
won't invoke the callback function. Also apart from restoring the
ringtone, I forced an update of the remaining device data (display,
LED, ...). Otherwise if during suspend the device is unplugged and
plugged in again, the driver does not know about the changes on the
display (for example) and the driver's data and the data stored in the
device are out of sync.
My test went all well with these additions.

The patch below builds on your latest patch.
Regards,
-Thomas

Signed-off-by: Thomas Reitmayr <treitmayr-lNf3axTzMcOzZXS1Dc/lvw@public.gmane.org>

---

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



Am Mittwoch, den 02.07.2008, 16:26 +0200 schrieb Oliver Neukum:
> Am Montag 30 Juni 2008 23:47:08 schrieb Thomas Reitmayr:
> > * Suspend to RAM:
> >   The device suspends properly, I hear the audio subsystem turning off
> > while the display keeps its current state.
> >   Apparently the USB root hub gets reset during suspend/resume according
> > to the kernel log. Then after resume the input events are generated
> 
> This patch may help.
> 
> 	Regards
> 		Oliver
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
