From: Jiri Kosina <jiri.kosina@novell.com>
Subject: Re: [PATCH] HID: blacklist ET&T TC5UH touchscreen controller
Date: Thu, 10 Dec 2009 12:18:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912101216380.3755@pobox.suse.cz>
References: <20091130081011.GB10295@core.coreip.homeip.net> <1260392993-8619-1-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1260392993-8619-1-git-send-email-ynezz@true.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Petr_=A6tetiar?= <ynezz@true.cz>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 9 Dec 2009, Petr =C5=A0tetiar wrote:

> This patch adds ET&T TC5UH touchscreen controller to HID blacklist,
> because this device is handled by input/usbtouchscreen driver.
>=20
> Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
> ---
>  drivers/hid/hid-core.c |    1 +
>  drivers/hid/hid-ids.h  |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 7d05c4b..a000bb7 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1296,6 +1296,7 @@ static const struct hid_device_id hid_blacklist=
[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCO=
DE_2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE=
) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },

Hi Petr,

actually the entry should go into hid_ignore_list[], not hid_blacklist[=
].

hid_blacklist[] is for those drivers, for which there exists specialize=
d=20
driver on hid bus, different from generic HID driver.

usbtouch is completely separate driver that has nothing to do with hid=20
bus, therefore we want the whole hid subsystem to completely ignore the=
=20
device -- and that's what hid_ignore_list[] is for.

I have fixed it up and applied to my tree.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
