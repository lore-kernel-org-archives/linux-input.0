From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Mon, 8 Feb 2010 15:25:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002081505220.1316-100000@iolanthe.rowland.org>
References: <20100208190649.0ceea556@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56489 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754293Ab0BHUZJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 15:25:09 -0500
In-Reply-To: <20100208190649.0ceea556@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Marcel Holtmann <marcel@holtmann.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 8 Feb 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> On Mon, 08 February 2010 Bruno Pr=C3=A9mont <bonbons@linux-vserver.or=
g> wrote:
> > 2.6.33-rc7 (don't know if any previous version resumes properly)
> > crashes during resume from S2Ram when my USB keyboard is connected =
but
> > resumes properly (viafb corruption put apart) when the USB keyboard=
 is
> > not connected.
>=20
> The patch below works around the crash though the WARN_ON() in
> usbhid_restart_out_queue() triggers in place.
>=20
> Bruno
>=20
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index e2997a8..d2f8eef 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -196,7 +196,7 @@ static void usbhid_mark_busy(struct usbhid_device=
 *usbhid)
> =20
>  static int usbhid_restart_out_queue(struct usbhid_device *usbhid)
>  {
> -	struct hid_device *hid =3D usb_get_intfdata(usbhid->intf);
> +	struct hid_device *hid =3D usbhid->intf ? usb_get_intfdata(usbhid->=
intf) : NULL;
>  	int kicked;
> =20
>  	if (!hid)
> @@ -214,7 +214,7 @@ static int usbhid_restart_out_queue(struct usbhid=
_device *usbhid)
> =20
>  static int usbhid_restart_ctrl_queue(struct usbhid_device *usbhid)
>  {
> -	struct hid_device *hid =3D usb_get_intfdata(usbhid->intf);
> +	struct hid_device *hid =3D usbhid->intf ? usb_get_intfdata(usbhid->=
intf) : NULL;
>  	int kicked;
> =20
>  	WARN_ON(hid =3D=3D NULL);

Clearly something is setting usbhid->intf to NULL.  But I don't see any
code that would do it.  You may have to resort to putting printk() =20
statements at various strategic places to find out where it happens. =20
You could start with the beginnings and ends of hid_suspend,
hid_resume, and hid_reset_resume.  Maybe also usbhid_disconnect(), just
in case.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
