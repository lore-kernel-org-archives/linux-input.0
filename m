From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Wed, 14 Dec 2011 16:19:31 +0800
Message-ID: <CAGS+omAzL+RspmQ=GCAN+NSEyDddm=zXvJR99PPT8R=4OVGn4g@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
 <1321529030-7845-4-git-send-email-djkurtz@chromium.org> <201112140901.35203.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab1LNITw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 03:19:52 -0500
Received: by iaeh11 with SMTP id h11so890807iae.19
        for <linux-input@vger.kernel.org>; Wed, 14 Dec 2011 00:19:52 -0800 (PST)
In-Reply-To: <201112140901.35203.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Dec 14, 2011 at 4:01 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 17. November 2011, 12:23:50 schrieb Daniel Kurtz:
>> Defer LED setting action to a workqueue.
>> This is more likely to send all LED change events in a single URB.
>
> Hi,
>
> I hope I am looking at the correct version of this patch.

Yes, that is the correct version.  It looks like I forgot to bump r in
the [PATCH] of the subject.

> But as far as I can see the work for handling LEDs is not delayed
> while a reset is going on. That is wrong.

Good catch, I think.  Your comment is a bit terse, so it is difficult t=
o
tell exactly what you are recommending.  Perhaps something like the fol=
lowing?

+/* Workqueue routine to send requests to change LEDs */
+static void hid_led(struct work_struct *work)
+{
+       struct usbhid_device *usbhid =3D
+               container_of(work, struct usbhid_device, led_work);
+       struct hid_device *hid =3D usbhid->hid;
+       struct hid_field *field;
+       unsigned long flags;
+
+       field =3D hidinput_get_led_field(hid);
+       if (!field) {
+               hid_warn(hid, "LED event field not found\n");
+               return;
+       }
+
+       spin_lock_irqsave(&usbhid->lock, flags);
+       if (!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
+           !test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
+               usbhid->ledcount =3D hidinput_count_leds(hid);
+               hid_dbg(usbhid->hid, "New ledcount =3D %u\n", usbhid->l=
edcount);
+               __usbhid_submit_report(hid, field->report, USB_DIR_OUT)=
;
+       }
+       spin_unlock_irqrestore(&usbhid->lock, flags);
+}


-Dan

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
