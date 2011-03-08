From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 09:04:14 +0100
Message-ID: <20110308080414.GA2888@polaris.bitmath.org>
References: <1299417912.9645.495.camel@itzy>
 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
 <1299564524.2306.18.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:43669 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753377Ab1CHIDa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 03:03:30 -0500
Content-Disposition: inline
In-Reply-To: <1299564524.2306.18.camel@itzy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Richard,

> Hi Benjamin, Hendrick, Jiri and St=E9phan,=20

The name is Henrik.

> I would like to give this patch another shot, after Benjamin reviewed=
 it (thanks for that!).
> As he pointed out, testing for the capacitive kind of egalax devices =
is needed. Maybe St=E9phan,  =20
> has the hardware and would be so kind to test it? I have tried it wit=
h my Samsung MB30 display
> and it worked:=20
> Bus 002 Device 002: ID 0eef:480e D-WAV Scientific Co., Ltd=20
> (thats USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3)
>=20
> I am looking forward to your comments,
> Richard
>=20
>=20
> PS: The patch should apply to 2fa403e8b49 of Jiris for-next branch, a=
lthough I had to cheat=20
> a little and rebase his tree to 2.6.38-rc7 because of some unrelated =
breakage (ecryptfs).

Thanks for making this patch. Please find some comments inline. Also,
since you are removing copyright from something that was largely
copied into this driver, perhaps something should be done about that.

> [PATCH] [input-hid] Add hid-egalax driver to the unified hid-multitou=
ch framework.
>=20
> This patch merges the hid-egalax driver into hid-multitouch and
> therefore adds two device classes (MT_CLS_EGALAX_CAPACITIVE/RESISTIVE=
).
> It also gains the capability to work around broken hid reports by
> overriding X/Y limits and emitting events for each finger
> (MT_QUIRK_SEND_AT_EACH_REPORT). As a side effect, this patch
> fixes the broken suspend/resume behavior with the old driver.
>=20
> Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
> ---
>  drivers/hid/Kconfig          |    9 +-
>  drivers/hid/Makefile         |    1 -
>  drivers/hid/hid-egalax.c     |  279 --------------------------------=
----------
>  drivers/hid/hid-multitouch.c |   68 ++++++++++-
>  4 files changed, 68 insertions(+), 289 deletions(-)
>  delete mode 100644 drivers/hid/hid-egalax.c
>=20
[...]
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 65e7f20..a00f3d8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
>  #define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
>  #define MT_QUIRK_VALID_IS_INRANGE	(1 << 4)
>  #define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 5)
> +#define MT_QUIRK_SEND_AT_EACH_REPORT	(1 << 6)
> =20
>  struct mt_slot {
>  	__s32 x, y, p, w, h;
> @@ -63,6 +64,9 @@ struct mt_class {
>  	__s32 sn_move;	/* Signal/noise ratio for move events */
>  	__s32 sn_pressure;	/* Signal/noise ratio for pressure events */
>  	__u8 maxcontacts;
> +	__u8 override_logical_limits;  /* correct the reported X/Y range */
> +	__u32 logical_min[2];
> +	__u32 logical_max[2];

Please think about byte alignment here, keeping elements of the same
size together. Also, the override needs a specific name, given that it
applies to the whole class, not just the x and y positions. Perhaps
the override should be triggered with a quirk instead?

>  };
> =20
>  /* classes of device behavior */
> @@ -70,6 +74,8 @@ struct mt_class {
>  #define MT_CLS_DUAL_INRANGE_CONTACTID		2
>  #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	3
>  #define MT_CLS_CYPRESS				4
> +#define MT_CLS_EGALAX_CAPACITIVE		5
> +#define MT_CLS_EGALAX_RESISTIVE			6
> =20
>  /*
>   * these device-dependent functions determine what slot corresponds
> @@ -119,7 +125,25 @@ struct mt_class mt_classes[] =3D {
>  		.quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>  			MT_QUIRK_CYPRESS,
>  		.maxcontacts =3D 10 },
> -
> +	{ .name =3D MT_CLS_EGALAX_CAPACITIVE,
> +		.quirks =3D  MT_QUIRK_SLOT_IS_CONTACTID |
> +			MT_QUIRK_VALID_IS_INRANGE,
> +		.maxcontacts =3D 2,
> +		.sn_move =3D 4096,
> +		.sn_pressure =3D 32,
> +		.override_logical_limits =3D 1,
> +		.logical_min =3D { 0, 0 },
> +		.logical_max =3D { 32760, 32760 } },
> +	{ .name =3D MT_CLS_EGALAX_RESISTIVE,
> +		.quirks =3D  MT_QUIRK_SLOT_IS_CONTACTID |
> +			MT_QUIRK_VALID_IS_INRANGE |
> +			MT_QUIRK_SEND_AT_EACH_REPORT,
> +		.maxcontacts =3D 2,
> +		.sn_move =3D 4096,
> +		.sn_pressure =3D 32,
> +		.override_logical_limits =3D 1,
> +		.logical_min =3D { 0, 0 },
> +		.logical_max =3D { 32760, 32760 } },
>  	{ }
>  };
> =20
> @@ -147,11 +171,19 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>  {
>  	struct mt_device *td =3D hid_get_drvdata(hdev);
>  	struct mt_class *cls =3D td->mtclass;
> +

Please check for patch for unrelated changes like this.

>  	switch (usage->hid & HID_USAGE_PAGE) {
> =20
>  	case HID_UP_GENDESK:
> +
>  		switch (usage->hid) {
>  		case HID_GD_X:
> +			/* fix up the reported X limits if necessary*/
> +			if (cls->override_logical_limits) {
> +				field->logical_minimum =3D cls->logical_min[0];
> +				field->logical_maximum =3D cls->logical_max[0];
> +			}
> +

Something like "if (quirks & MT_QUIRK_FIX_X)", and then on next line "f=
ield->logical_maximum =3D cls->max_x".

>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_POSITION_X);
>  			set_abs(hi->input, ABS_MT_POSITION_X, field,
> @@ -161,6 +193,11 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>  			td->last_slot_field =3D usage->hid;
>  			return 1;
>  		case HID_GD_Y:
> +			/* fix up the reported Y limits if nessecary*/
> +			if (cls->override_logical_limits) {
> +				field->logical_minimum =3D cls->logical_min[1];
> +				field->logical_maximum =3D cls->logical_max[1];
> +			}

Ditto.

>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_POSITION_Y);
>  			set_abs(hi->input, ABS_MT_POSITION_Y, field,
> @@ -204,6 +241,10 @@ static int mt_input_mapping(struct hid_device *h=
dev, struct hid_input *hi,
>  			td->last_slot_field =3D usage->hid;
>  			return 1;
>  		case HID_DG_TIPPRESSURE:
> +			/* fix up the pressure range for some devices
> +			with broken report */
> +			field->logical_minimum =3D 0;
> +
>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_PRESSURE);
>  			set_abs(hi->input, ABS_MT_PRESSURE, field,
> @@ -367,8 +408,12 @@ static int mt_event(struct hid_device *hid, stru=
ct hid_field *field,
>  		if (usage->hid =3D=3D td->last_slot_field)
>  			mt_complete_slot(td);
> =20
> -		if (field->index =3D=3D td->last_field_index
> +		if ((field->index =3D=3D td->last_field_index
>  			&& td->num_received >=3D td->num_expected)
> +			|| ((quirks & MT_QUIRK_SEND_AT_EACH_REPORT)
> +				&& (usage->hid =3D=3D td->last_slot_field)))
> +			/* emit an event for every finger to work around
> +			a corrupt last_field_index in the hid report*/
>  			mt_emit_event(td, field->hidinput->input);
> =20
>  	}
> @@ -484,6 +529,25 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>  		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>  			USB_DEVICE_ID_CANDO_PIXCIR_MULTI_TOUCH) },
> =20
> +	/* Resistive eGalax devices */
> +	{  .driver_data =3D MT_CLS_EGALAX_RESISTIVE,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
> +	{  .driver_data =3D MT_CLS_EGALAX_RESISTIVE,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
> +
> +	/* Capacitive eGalax devices */
> +	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
> +	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
> +	{  .driver_data =3D MT_CLS_EGALAX_CAPACITIVE,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
> +
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, mt_devices);
> --=20
> 1.7.1
>=20

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
