From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [Linuxwacom-devel] [PATCH] Input: wacom - add support for the
 DTI-520 graphics tablet
Date: Tue, 22 May 2012 15:12:38 -0700
Message-ID: <CAF8JNh+fUShE5WMDcOyLfZoU3b06zWB5i43cUJaaA-ELBPgb8Q@mail.gmail.com>
References: <4F892952.6020409@shikadi.net>
	<4FB86BD7.6030304@shikadi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41341 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab2EVWMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 18:12:39 -0400
In-Reply-To: <4FB86BD7.6030304@shikadi.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, linuxwacom-devel@lists.sourceforge.net, linux-input <linux-input@vger.kernel.org>

On Sat, May 19, 2012 at 8:58 PM, Adam Nielsen <a.nielsen@shikadi.net> w=
rote:
> Add support for the two interfaces provided by the Wacom DTI-520 tabl=
et. =A0This
> allows both the tablet itself as well as the hardware buttons to be s=
een by the
> kernel.
>
> Signed-off-by: Adam Nielsen <a.nielsen@shikadi.net>
> ---
> Hi all,
>
> I'm resending this and CC'ing the linuxwacom-devel list as suggested.=
 =A0There
> are no changes since the previous post. =A0This is the kernel code th=
at makes the
> tablet appear as an input device.

I don't have the device to test this patch. Just to share my comments
(inline) based on the code itself. I am cc'ing linux-input, where this
patch normally goes.

Ping

>
> Cheers,
> Adam.
>
> =A0drivers/input/tablet/wacom_sys.c | =A0 13 +++++
> =A0drivers/input/tablet/wacom_wac.c | =A0113 ++++++++++++++++++++++++=
+++++++++++++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A03 +
> =A03 files changed, 128 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 0d26921..5d1e35d 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -459,6 +459,19 @@ static int wacom_retrieve_hid_descriptor(struct =
usb_interface *intf,
> =A0 =A0 =A0 =A0features->y_fuzz =3D 4;
> =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
> =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
> + =A0 =A0 =A0 features->x_phy =3D 0;
> + =A0 =A0 =A0 features->y_phy =3D 0;
> +
> + =A0 =A0 =A0 /* DTI devices have two interfaces */
> + =A0 =A0 =A0 if (features->type =3D=3D WACOM_DTI) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (interface->desc.bInterfaceNumber =3D=
=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* digitizer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* buttons */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WA=
COM_PKGLEN_DTIBTN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The wireless device HID is basic and layout conflic=
ts with
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index cecd35c..f0ada18 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1073,6 +1073,80 @@ static int wacom_wireless_irq(struct wacom_wac=
 *wacom, size_t len)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int wacom_dti_pen(struct wacom_wac *wacom)
> +{
> + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->features;
> + =A0 =A0 =A0 char *data =3D wacom->data;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> + =A0 =A0 =A0 int pressure;
> + =A0 =A0 =A0 bool prox =3D data[1] & 0x40;
> +
> + =A0 =A0 =A0 if (data[0] !=3D WACOM_REPORT_PENABLED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("wacom_dti_pen: received unknown re=
port #%d", data[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_report_key(input, wacom->tool[0], prox);

The line above should  be after the if statement below. Otherwise
wacom->tool can be uninitialized.

> +
> + =A0 =A0 =A0 if (prox) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->tool[0] =3D BTN_TOOL_PEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D STYLUS_DEVICE_ID;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (wacom->id[0]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS, dat=
a[7] & 0x01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, da=
ta[7] & 0x02);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, be16_to_=
cpup((__be16 *)&data[2]));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, be16_to_=
cpup((__be16 *)&data[4]));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D (data[6] << 1) | ((data[7]=
 & 0x80) >> 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pressure < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features->=
pressure_max + pressure + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, p=
ressure);

Need tp post wacom->id[0] through ABS_MISC here.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!prox)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;

This short if block should be inside the long if block above.

> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_dti_pad(struct wacom_wac *wacom)
> +{
> + =A0 =A0 =A0 char *data =3D wacom->data;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> +
> + =A0 =A0 =A0 if (data[0] =3D=3D WACOM_REPORT_DTIBTN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_3, data[1] =
& 0x01); /* up */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_4, data[1] =
& 0x02); /* down */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_0, data[1] =
& 0x04); /* L */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_2, data[1] =
& 0x08); /* R */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_1, data[1] =
& 0x10); /* both Ctrl */

Looks like we could define default vaules for those buttons.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Buttons along the top of the display=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_7, data[2] =
& 0x01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_5, data[2] =
& 0x02);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_6, data[2] =
& 0x04);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_8, data[2] =
& 0x08);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_9, data[2] =
& 0x10);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dbg("wacom_dti_pad: received unknown report #%d", data[=
0]);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_dti_irq(struct wacom_wac *wacom, size_t len)
> +{
> + =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_GRAPHIRE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_dti_pen(wacom);
> + =A0 =A0 =A0 else if (len =3D=3D WACOM_PKGLEN_DTIBTN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_dti_pad(wacom);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
> =A0{
> =A0 =A0 =A0 =A0bool sync;
> @@ -1127,6 +1201,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_wireless_irq(wacom_wac,=
 len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case WACOM_DTI:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_dti_irq(wacom_wac, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1241,7 +1319,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* penabled devices have fixed resolut=
ion for each model */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_abs_set_res(input_dev, ABS_X, fe=
atures->x_resolution);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_abs_set_res(input_dev, ABS_Y, fe=
atures->y_resolution);
> - =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 } else if ((features->x_phy > 0) && (features->y_phy > =
0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_abs_set_res(input_dev, ABS_X,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_calculate_touch_=
res(features->x_max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->x_phy));
> @@ -1404,6 +1482,35 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_DIRECT, input_dev=
->propbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case WACOM_DTI:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit=
);

Why do we clear ABS_MISC for pen tool?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (features->device_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BTN_TOOL_PEN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN,=
 input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS, i=
nput_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS2, =
input_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_DI=
RECT, input_dev->propbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_0, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_1, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_2, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_3, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_4, input_=
dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_5, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_6, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_7, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_8, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_9, input_=
dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(BTN_TOUCH, =
input_dev->keybit);

This interface does not support ABS_X and ABS_Y either, right? Do we
need a tool type for this button box?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case PTU:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS2, input_dev->keyb=
it);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
> @@ -1566,6 +1673,9 @@ static const struct wacom_features wacom_featur=
es_0x38 =3D
> =A0static const struct wacom_features wacom_features_0x39 =3D
> =A0 =A0 =A0 =A0{ "Wacom DTU710", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIR=
E, =A034080, 27660, =A0511,
> =A0 =A0 =A0 =A0 =A00, PL, WACOM_PL_RES, WACOM_PL_RES };
> +static const struct wacom_features wacom_features_0x3A =3D
> + =A0 =A0 =A0 { "Wacom DTI520UB/L", =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =A0=
 6282, =A04762, =A0511,
> + =A0 =A0 =A0 =A0 0, WACOM_DTI, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0xC4 =3D
> =A0 =A0 =A0 =A0{ "Wacom DTF521", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIR=
E, =A0 6282, =A04762, =A0511,
> =A0 =A0 =A0 =A0 =A00, PL, WACOM_PL_RES, WACOM_PL_RES };
> @@ -1780,6 +1890,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x37) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x38) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x39) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0x3A) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC4) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC0) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC2) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index ba5a334..008aa12 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -15,6 +15,7 @@
> =A0#define WACOM_PKGLEN_MAX =A0 =A0 =A0 64
>
> =A0/* packet length for individual models */
> +#define WACOM_PKGLEN_DTIBTN =A0 =A0 3
> =A0#define WACOM_PKGLEN_PENPRTN =A0 =A07
> =A0#define WACOM_PKGLEN_GRAPHIRE =A0 8
> =A0#define WACOM_PKGLEN_BBFUN =A0 =A0 =A09
> @@ -35,6 +36,7 @@
>
> =A0/* wacom data packet report IDs */
> =A0#define WACOM_REPORT_PENABLED =A0 =A0 =A0 =A0 =A02
> +#define WACOM_REPORT_DTIBTN =A0 =A0 =A0 =A0 =A0 =A04
> =A0#define WACOM_REPORT_INTUOSREAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05
> =A0#define WACOM_REPORT_INTUOSWRITE =A0 =A0 =A0 6
> =A0#define WACOM_REPORT_INTUOSPAD =A0 =A0 =A0 =A0 12
> @@ -72,6 +74,7 @@ enum {
> =A0 =A0 =A0 =A0WACOM_MO,
> =A0 =A0 =A0 =A0TABLETPC,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> + =A0 =A0 =A0 WACOM_DTI,
> =A0 =A0 =A0 =A0MAX_TYPE
> =A0};
>
> -- 1.7.10
>
>
> ---------------------------------------------------------------------=
---------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discuss=
ions
> will include endpoint security, mobile security and the latest in mal=
ware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Linuxwacom-devel mailing list
> Linuxwacom-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
