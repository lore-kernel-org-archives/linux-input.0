From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 08:19:32 +0200
Message-ID: <201204250819.32642.oneukum@suse.de>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com> <201204242057.29100.oliver@neukum.org> <CACVXFVOuSamcBrPT=K9Q3fAXULjz57e-1W9pi9AW1gAKxyCT7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55415 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987Ab2DYGXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 02:23:35 -0400
In-Reply-To: <CACVXFVOuSamcBrPT=K9Q3fAXULjz57e-1W9pi9AW1gAKxyCT7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Mittwoch, 25. April 2012, 03:27:19 schrieb Ming Lei:
> On Wed, Apr 25, 2012 at 2:57 AM, Oliver Neukum <oliver@neukum.org> wr=
ote:
>=20
>  usb_submit_urb()
> >>
> >> This submit won't happen because HID_OUT_RUNNING is not cleared.
> >
> > I may be dense, but as far as I can tell a resubmit will happen, ex=
actly if
> > HID_OUT_RUNNING is _not_ cleared.
>=20
> In fact, it should be a double unlink bug, usb_unlink_urb can handle
> it correctly
> if the lock is held. We also can deal with it easily by checking urb-=
>unlinked,
> so how about the below patch?
>=20
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index aa1c503..b530463 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -411,10 +411,10 @@ static void hid_irq_out(struct urb *urb)
>  {
>  	struct hid_device *hid =3D urb->context;
>  	struct usbhid_device *usbhid =3D hid->driver_data;
> -	unsigned long flags;
> +	unsigned long status =3D urb->status;

Error codes are negative.


> @@ -546,8 +557,13 @@ static void __usbhid_submit_report(struct
> hid_device *hid, struct hid_report *re
>  			 * no race because this is called under
>  			 * spinlock
>  			 */
> -			if (time_after(jiffies, usbhid->last_out + HZ * 5))
> +
> +			if (time_after(jiffies, usbhid->last_out + HZ * 5) &&
> +					!usbhid->urbout->unlinked) {
> +				spin_unlock(&usbhid->lock);
>  				usb_unlink_urb(usbhid->urbout);
> +				spin_lock(&usbhid->lock);
> +			}
>  		}
>  		return;
>  	}

Same objection. You are just making the race unlikelier. The flag
needs to be set under a lock you hold while checking time_after().
We'd be back at the original proposal.

	Regards
		Oliver

--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
