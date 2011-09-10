From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Use "hid-logitech" driver with Logitech Driving Force GT
Date: Sat, 10 Sep 2011 21:57:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109102156100.13109@pobox.suse.cz>
References: <1530359.8SD6lrfWuA@qosmio-x300>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42605 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab1IJT5t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Sep 2011 15:57:49 -0400
In-Reply-To: <1530359.8SD6lrfWuA@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 10 Sep 2011, Michal Mal=FD wrote:

> There's been a small oversight when adding support for Logitech Drivi=
ng Force GT. Entry in hid-core was missing so the generic driver instea=
d of hid-logitech was being used.
>=20
> Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
>=20
> ---
>  drivers/hid/hid-core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 1a5cf0c..be1cda3 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1417,6 +1417,7 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOM=
O_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOM=
O_WHEEL2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP=
_WHEEL) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFG=
T_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25=
_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27=
_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WII=
_WHEEL) },

Hi Michal,

I don't recall the exact history of the original patch from top of my=20
head, but what I have in my 'upstream' branch seems correct. It might b=
e=20
that I have noticed and fixed it on my side.

If you still see any issues in the code I have in my tree, please let m=
e=20
know.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
