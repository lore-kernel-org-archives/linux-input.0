From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: gembird: add new driver to fix Gembird
 JPD-DualForce 2
Date: Wed, 12 Aug 2015 10:40:28 -0400
Message-ID: <20150812144028.GA31257@mail.corp.redhat.com>
References: <1439307348-5184-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150812013255.31ea3b7e@orivej.orivej.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbbHLOka (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2015 10:40:30 -0400
Content-Disposition: inline
In-Reply-To: <20150812013255.31ea3b7e@orivej.orivej.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Orivej Desh <orivej@gmx.fr>
Cc: Jiri Kosina <jkosina@suse.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Aug 12 2015 or thereabouts, Orivej Desh wrote:
> This gamepad advertises 5 absolute axis while 4 are actually used.
> The first Z axis shows some garbage, so it has to be ignored by HID.
> The second Z axis and the Rz one are actually Rx and Ry. Remap them.
>=20
> We could also just remap and ignore the axis in .input_mapping(). I
> went ahead with .report_fixup() first, so here it is.
>=20
> Reported-by: Orivej Desh <orivej@gmx.fr>
> Tested-by: Orivej Desh <orivej@gmx.fr>
> ---
>=20
> * Benjamin Tissoires
> > so here are the fixes I mentioned yesterday. If you could give a qu=
ick shot
> > and a "tested-by" that would be even better.
>=20
> I tested your patch and it works as advertised, thank you!  But your
> comment about the implementation (=C2=ABre-assigning X to the origina=
l Z
> axis=C2=BB) did not match the implementation, so I simplified the
> implementation according to the comment, and tested it too.  Since th=
e
> patch has changed, I think you need to sign it off again.

Hmm... This was actually my first shot, and I noticed that the
flickering original Z axis was now taking over the correct X axis. So
that's why I added some complexity to ignore at the HID level this axis=
=2E
I just forgot to update the comment :)

If you think this patch is good enough (you will get flickering X), we
can carry on this one, but I think the one I submitted (with the commen=
t
edited) would provide a better experience.

Cheers,
Benjamin

>=20
> > Jiri, I am not sure if the .input_mapping() alternative would not b=
e better.
> > Both solutions are valid, so if you do not like my memcpys, I can r=
e-write the
> > patch the other way.
>=20
>  drivers/hid/Kconfig       |  6 ++++
>  drivers/hid/Makefile      |  1 +
>  drivers/hid/hid-core.c    |  1 +
>  drivers/hid/hid-gembird.c | 77 +++++++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/hid/hid-ids.h     |  3 ++
>  5 files changed, 88 insertions(+)
>  create mode 100644 drivers/hid/hid-gembird.c
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 57c94d7..6ab51ae 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -251,6 +251,12 @@ config HID_EZKEY
>  	---help---
>  	Support for Ezkey BTC 8193 keyboard.
> =20
> +config HID_GEMBIRD
> +	tristate "Gembird Joypad"
> +	depends on HID
> +	---help---
> +	Support for Gembird JPD-DualForce 2.
> +
>  config HID_HOLTEK
>  	tristate "Holtek HID devices"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 2f8a41d..e6441bc 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_HID_EMS_FF)	+=3D hid-emsff.o
>  obj-$(CONFIG_HID_ELECOM)	+=3D hid-elecom.o
>  obj-$(CONFIG_HID_ELO)		+=3D hid-elo.o
>  obj-$(CONFIG_HID_EZKEY)		+=3D hid-ezkey.o
> +obj-$(CONFIG_HID_GEMBIRD)	+=3D hid-gembird.o
>  obj-$(CONFIG_HID_GT683R)	+=3D hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)	+=3D hid-gyration.o
>  obj-$(CONFIG_HID_HOLTEK)	+=3D hid-holtek-kbd.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e982e70..22afab9 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1844,6 +1844,7 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_=
PSX_ADAPTOR) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_=
PCS_ADAPTOR) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD, USB_DEVICE_ID_GEMBIRD_JPD_D=
UALFORCE2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REM=
OTE) },
> diff --git a/drivers/hid/hid-gembird.c b/drivers/hid/hid-gembird.c
> new file mode 100644
> index 0000000..cefc394
> --- /dev/null
> +++ b/drivers/hid/hid-gembird.c
> @@ -0,0 +1,77 @@
> +/*
> + *  HID driver for Gembird Joypad, "PC Game Controller"
> + *
> + *  Copyright (c) 2015 Red Hat, Inc
> + *  Copyright (c) 2015 Benjamin Tissoires
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the Free
> + * Software Foundation; either version 2 of the License, or (at your=
 option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define GEMBIRD_START_FAULTY_RDESC	22
> +
> +/*
> + * This gamepad advertises 5 absolute axis while 4 are actually used=
=2E
> + * The first Z axis shows some garbage, so it has to be ignored by H=
ID.
> + * The second Z axis and the Rz one are actually Rx and Ry. Remap th=
em.
> + */
> +
> +static const __u8 gembird_jpd_faulty_rdesc[] =3D {
> +	0x09, 0x30,			/*   Usage (X)			*/
> +	0x09, 0x31,			/*   Usage (Y)			*/
> +	0x09, 0x32,			/*   Usage (Z)			*/
> +	0x09, 0x32,			/*   Usage (Z)			*/
> +	0x09, 0x35,			/*   Usage (Rz)			*/
> +};
> +static const __u8 gembird_jpd_fixed_rdesc[] =3D {
> +	0x09, 0x30,			/*   Usage (X)			*/
> +	0x09, 0x31,			/*   Usage (Y)			*/
> +	0x09, 0x30,			/*   Usage (X) (ignored)	*/
> +	0x09, 0x33,			/*   Usage (Rx)			*/
> +	0x09, 0x34,			/*   Usage (Ry)			*/
> +};
> +
> +static __u8 *gembird_report_fixup(struct hid_device *hdev, __u8 *rde=
sc,
> +		unsigned int *rsize)
> +{
> +	if (*rsize >=3D 32 && !memcmp(&rdesc[GEMBIRD_START_FAULTY_RDESC],
> +				    gembird_jpd_faulty_rdesc,
> +				    sizeof(gembird_jpd_faulty_rdesc))) {
> +		dev_info(&hdev->dev,
> +			 "fixing Gembird JPD-DualForce 2 report descriptor.\n");
> +
> +		memcpy(rdesc + GEMBIRD_START_FAULTY_RDESC,
> +		       gembird_jpd_fixed_rdesc,
> +		       sizeof(gembird_jpd_fixed_rdesc));
> +	}
> +
> +	return rdesc;
> +}
> +
> +static const struct hid_device_id gembird_devices[] =3D {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD,
> +			 USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, gembird_devices);
> +
> +static struct hid_driver gembird_driver =3D {
> +	.name =3D "gembird",
> +	.id_table =3D gembird_devices,
> +	.report_fixup =3D gembird_report_fixup,
> +};
> +module_hid_driver(gembird_driver);
> +
> +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> +MODULE_DESCRIPTION("HID Gembird joypad driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 602f2b7..720d5e3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -363,6 +363,9 @@
>  #define USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR	0x0001
>  #define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR	0x0002
> =20
> +#define USB_VENDOR_ID_GEMBIRD			0x11ff
> +#define USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2	0x3331
> +
>  #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
> --=20
> 2.4.3
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
