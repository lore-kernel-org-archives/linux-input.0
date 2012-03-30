From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv3 1/3] HID: hid-lg: Allow for custom device properties
 to be stored in private driver data
Date: Fri, 30 Mar 2012 15:34:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203301533530.25526@pobox.suse.cz>
References: <1549268.LAjoPqsQ59@qosmio-x300> <2473446.GW5eCxYo0z@qosmio-x300>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33665 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760180Ab2C3NeQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 09:34:16 -0400
In-Reply-To: <2473446.GW5eCxYo0z@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Wed, 14 Mar 2012, Michal Mal=FD wrote:

> For some reason the Makefile got modified along with the driver and I=
 didn't
> catch it. This is the updated version of the first part of the patch =
that leaves
> the Makefile alone.

Please resend the patch with proper changelog, I can't apply it this wa=
y=20
:) Thanks.

>=20
> Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
>=20
> ---
>  drivers/hid/hid-lg.c |   55 +++++++++++++++++++++++++++++-----------=
----------
>  drivers/hid/hid-lg.h |    7 +++++++
>  2 files changed, 39 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
> index e7a7bd1..fc37ed6 100644
> --- a/drivers/hid/hid-lg.c
> +++ b/drivers/hid/hid-lg.c
> @@ -109,23 +109,23 @@ static __u8 dfp_rdesc_fixed[] =3D {
>  static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		unsigned int *rsize)
>  {
> -	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
> +	struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
> =20
> -	if ((quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=3D 0x26 =
&&
> +	if ((drv_data->quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=
=3D 0x26 &&
>  			rdesc[84] =3D=3D 0x8c && rdesc[85] =3D=3D 0x02) {
>  		hid_info(hdev,
>  			 "fixing up Logitech keyboard report descriptor\n");
>  		rdesc[84] =3D rdesc[89] =3D 0x4d;
>  		rdesc[85] =3D rdesc[90] =3D 0x10;
>  	}
> -	if ((quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
> +	if ((drv_data->quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
>  			rdesc[32] =3D=3D 0x81 && rdesc[33] =3D=3D 0x06 &&
>  			rdesc[49] =3D=3D 0x81 && rdesc[50] =3D=3D 0x06) {
>  		hid_info(hdev,
>  			 "fixing up rel/abs in Logitech report descriptor\n");
>  		rdesc[33] =3D rdesc[50] =3D 0x02;
>  	}
> -	if ((quirks & LG_FF4) && *rsize >=3D 101 &&
> +	if ((drv_data->quirks & LG_FF4) && *rsize >=3D 101 &&
>  			rdesc[41] =3D=3D 0x95 && rdesc[42] =3D=3D 0x0B &&
>  			rdesc[47] =3D=3D 0x05 && rdesc[48] =3D=3D 0x09) {
>  		hid_info(hdev, "fixing up Logitech Speed Force Wireless button des=
criptor\n");
> @@ -278,7 +278,7 @@ static int lg_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
>  		  0,  0,  0,  0,  0,183,184,185,186,187,
>  		188,189,190,191,192,193,194,  0,  0,  0
>  	};
> -	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
> +	struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
>  	unsigned int hid =3D usage->hid;
> =20
>  	if (hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_RECEIVER &&
> @@ -289,7 +289,7 @@ static int lg_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
>  			lg_dinovo_mapping(hi, usage, bit, max))
>  		return 1;
> =20
> -	if ((quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usage, bit, m=
ax))
> +	if ((drv_data->quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usa=
ge, bit, max))
>  		return 1;
> =20
>  	if ((hid & HID_USAGE_PAGE) !=3D HID_UP_BUTTON)
> @@ -299,11 +299,11 @@ static int lg_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> =20
>  	/* Special handling for Logitech Cordless Desktop */
>  	if (field->application =3D=3D HID_GD_MOUSE) {
> -		if ((quirks & LG_IGNORE_DOUBLED_WHEEL) &&
> +		if ((drv_data->quirks & LG_IGNORE_DOUBLED_WHEEL) &&
>  				(hid =3D=3D 7 || hid =3D=3D 8))
>  			return -1;
>  	} else {
> -		if ((quirks & LG_EXPANDED_KEYMAP) &&
> +		if ((drv_data->quirks & LG_EXPANDED_KEYMAP) &&
>  				hid < ARRAY_SIZE(e_keymap) &&
>  				e_keymap[hid] !=3D 0) {
>  			hid_map_usage(hi, usage, bit, max, EV_KEY,
> @@ -319,13 +319,13 @@ static int lg_input_mapped(struct hid_device *h=
dev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
>  {
> -	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
> +	struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
> =20
> -	if ((quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D EV_KEY &&
> +	if ((drv_data->quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D=
 EV_KEY &&
>  			(field->flags & HID_MAIN_ITEM_RELATIVE))
>  		field->flags &=3D ~HID_MAIN_ITEM_RELATIVE;
> =20
> -	if ((quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D EV_KEY ||
> +	if ((drv_data->quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D=
 EV_KEY ||
>  			 usage->type =3D=3D EV_REL || usage->type =3D=3D EV_ABS))
>  		clear_bit(usage->code, *bit);
> =20
> @@ -335,9 +335,9 @@ static int lg_input_mapped(struct hid_device *hde=
v, struct hid_input *hi,
>  static int lg_event(struct hid_device *hdev, struct hid_field *field=
,
>  		struct hid_usage *usage, __s32 value)
>  {
> -	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
> +	struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
> =20
> -	if ((quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL_HWHEEL) {
> +	if ((drv_data->quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL=
_HWHEEL) {
>  		input_event(field->hidinput->input, usage->type, usage->code,
>  				-value);
>  		return 1;
> @@ -348,13 +348,20 @@ static int lg_event(struct hid_device *hdev, st=
ruct hid_field *field,
> =20
>  static int lg_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
>  {
> -	unsigned long quirks =3D id->driver_data;
>  	unsigned int connect_mask =3D HID_CONNECT_DEFAULT;
> +	struct lg_drv_data *drv_data;
>  	int ret;
> =20
> -	hid_set_drvdata(hdev, (void *)quirks);
> +	drv_data =3D kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
> +	if (!drv_data) {
> +		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n"=
);
> +		return -ENOMEM;
> +	}
> +	drv_data->quirks =3D id->driver_data;
> +=09
> +	hid_set_drvdata(hdev, (void *)drv_data);
> =20
> -	if (quirks & LG_NOGET)
> +	if (drv_data->quirks & LG_NOGET)
>  		hdev->quirks |=3D HID_QUIRK_NOGET;
> =20
>  	ret =3D hid_parse(hdev);
> @@ -363,7 +370,7 @@ static int lg_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
>  		goto err_free;
>  	}
> =20
> -	if (quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
> +	if (drv_data->quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
>  		connect_mask &=3D ~HID_CONNECT_FF;
> =20
>  	ret =3D hid_hw_start(hdev, connect_mask);
> @@ -392,27 +399,29 @@ static int lg_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		}
>  	}
> =20
> -	if (quirks & LG_FF)
> +	if (drv_data->quirks & LG_FF)
>  		lgff_init(hdev);
> -	if (quirks & LG_FF2)
> +	if (drv_data->quirks & LG_FF2)
>  		lg2ff_init(hdev);
> -	if (quirks & LG_FF3)
> +	if (drv_data->quirks & LG_FF3)
>  		lg3ff_init(hdev);
> -	if (quirks & LG_FF4)
> +	if (drv_data->quirks & LG_FF4)
>  		lg4ff_init(hdev);
> =20
>  	return 0;
>  err_free:
> +	kfree(drv_data);
>  	return ret;
>  }
> =20
>  static void lg_remove(struct hid_device *hdev)
>  {
> -	unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
> -	if(quirks & LG_FF4)
> +	struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
> +	if (drv_data->quirks & LG_FF4)
>  		lg4ff_deinit(hdev);
> =20
>  	hid_hw_stop(hdev);
> +	kfree(drv_data);
>  }
> =20
>  static const struct hid_device_id lg_devices[] =3D {
> diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
> index 4b09728..500457b 100644
> --- a/drivers/hid/hid-lg.h
> +++ b/drivers/hid/hid-lg.h
> @@ -1,6 +1,13 @@
>  #ifndef __HID_LG_H
>  #define __HID_LG_H
> =20
> +#include <linux/spinlock.h>
> +
> +struct lg_drv_data {
> +	unsigned long quirks;
> +	void *device_props;	/* Device specific properties */
> +};
> +
>  #ifdef CONFIG_LOGITECH_FF
>  int lgff_init(struct hid_device *hdev);
>  #else
> --=20
> 1.7.9.4
>=20
>=20

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
