From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Mon, 23 Aug 2010 16:00:21 +0200
Message-ID: <AANLkTinvcUJPgSeLcc-rDF97g_QxZe_W53tCMNGT9wAd@mail.gmail.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59187 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab0HWOB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Aug 2010 10:01:28 -0400
Received: by fxm13 with SMTP id 13so2927628fxm.19
        for <linux-input@vger.kernel.org>; Mon, 23 Aug 2010 07:01:26 -0700 (PDT)
In-Reply-To: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Henrik,

Thank you for providing the MT support for Wacom's Bamboo touch only
device. Please see my comments inline.

Ping

On Sun, Aug 22, 2010 at 4:10 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Add support for the Bamboo Touch trackpad, and make it work well with
> both the Synaptics X Driver and the Multitouch X Driver. The device
> uses MT slots internally, so the choice of protocol is a given.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Dmitry, Ping,
>
> Here is a small patch which adds trackpad support for the Bamboo Touc=
h. There are a couple if things to discuss:
>
> 1) It uses the MT slot protocol
> 2) It creates two input devices, but only one is useful

I would like to keep the same wacom_features and usb_device_id
wacom_ids structures for Bamboo as we did for all the other models,
i.e., we define one entry for Bamboo although there could be more than
one logical devices (touch and pen) associated with it.

This may not make a difference for your Bamboo (a touch only device).
It would make the code easy to maintain for the other Bamboos (Product
ID: 0xd1, 0xd2, 0xd3, and 0xd4).

If you are not sure what I am talking about, please let me know.

> 3) It works well with the synaptics and multitouch X drivers

I guess it depends on what the plan is for MT support in the userland.
If our goal is to make the MT X driver generic, there would be no need
to have a Wacom X drvier for MT (I'd love to go with this route). If
the MT X driver is only a way to test the kernel driver, we'll have to
discuss what to do next.

> 4) It does not work well with the wacom X driver (!)

This would not be an issue if we (as a team working in the community)
can answer item 3 above properly.

> In particular the last point may seem upsetting, but my reasoning is
> simply that the wacom X driver really supports tablets and not
> trackpads. I might be convinced otherwise. :-)

As I said earlier, I would love to see MT supported by a generic X driv=
er.

>
> Cheers,
> Henrik
>
> =A0drivers/input/tablet/wacom_wac.c | =A0 76 ++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A06 +++
> =A02 files changed, 82 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 40d77ba..61dbd5d 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -855,6 +855,52 @@ static int wacom_tpc_irq(struct wacom_wac *wacom=
, size_t len)
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> +static int wacom_bbt_irq(struct wacom_wac *wacom, size_t len)
> +{
> + =A0 =A0 =A0 static int trkid;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> + =A0 =A0 =A0 unsigned char *data =3D wacom->data;
> + =A0 =A0 =A0 int i, sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
> +
> + =A0 =A0 =A0 if (len !=3D WACOM_PKGLEN_BBTOUCH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unaligned=
_be16(&data[9 * i + 3]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unaligned=
_be16(&data[9 * i + 5]) & 0x7ff;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_PRESSURE, p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[i] < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->=
id[i] =3D trkid++ & MAX_TRACKING_ID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!count++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp =3D =
p, sx =3D x, sy =3D y;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[i] =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRACKING=
_ID, wacom->id[i]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, count > 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_FINGER, count =3D=3D 1=
);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_DOUBLETAP, count =3D=3D=
 2);
> +
> + =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, sp);
> + =A0 =A0 =A0 input_report_abs(input, ABS_X, sx);
> + =A0 =A0 =A0 input_report_abs(input, ABS_Y, sy);
> +
> + =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_MIDDLE, (data[1] & 0x06) !=3D=
 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D=
 0);
> +
> + =A0 =A0 =A0 input_sync(input);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
> =A0{
> =A0 =A0 =A0 =A0bool sync;
> @@ -900,6 +946,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, =
size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case BAMBOO_TOUCH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_bbt_irq(wacom_wac, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1076,6 +1126,22 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0case PENPARTNER:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUBBER, input_dev->=
keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> + =A0 =A0 =A0 case BAMBOO_TOUCH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_LEFT, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_MIDDLE, input_dev->keybit=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_RIGHT, input_dev->keybit)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_FINGER, input_dev->k=
eybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBLETAP, input_dev=
->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_create_slots(input_dev, 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
POSITION_X, 0, features->x_max, 4, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
POSITION_Y, 0, features->y_max, 4, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
PRESSURE, 0, features->pressure_max, 16, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
TRACKING_ID, 0, MAX_TRACKING_ID, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -1213,11 +1279,19 @@ static const struct wacom_features wacom_feat=
ures_0xE3 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
> =A0static const struct wacom_features wacom_features_0x47 =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023, 31, INTUOS };
> +static const struct wacom_features wacom_features_0xD0_0 =3D
> + =A0 =A0 =A0 { "Wacom Bamboo Touch", =A0 WACOM_PKGLEN_BBTOUCH, =A0 4=
80, =A0320, 255, 0, BAMBOO_TOUCH };
> +static const struct wacom_features wacom_features_0xD0_2 =3D
> + =A0 =A0 =A0 { "Wacom Bamboo Boot", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0 =
480, =A0320, 255, 0, BAMBOO_BOOT };
>
> =A0#define USB_DEVICE_WACOM(prod) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0USB_DEVICE(USB_VENDOR_ID_WACOM, prod), =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0.driver_info =3D (kernel_ulong_t)&wacom_features_##pro=
d
>
> +#define USB_DEVICE_WACOM_PROTO(prod, pr) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 USB_DEVICE_INTERFACE_PROTOCOL(USB_VENDOR_ID_WACOM, prod=
, pr), =A0 \
> + =A0 =A0 =A0 .driver_info =3D (kernel_ulong_t)&wacom_features_##prod=
##_##pr
> +
> =A0const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x00) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x10) },
> @@ -1277,6 +1351,8 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC7) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xCE) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM_PROTO(0xD0, 0) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM_PROTO(0xD0, 2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xF0) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xCC) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x90) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 99e1a54..770909c 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -21,6 +21,7 @@
> =A0#define WACOM_PKGLEN_INTUOS =A0 =A010
> =A0#define WACOM_PKGLEN_TPC1FG =A0 =A0 5
> =A0#define WACOM_PKGLEN_TPC2FG =A0 =A014
> +#define WACOM_PKGLEN_BBTOUCH =A0 20
>
> =A0/* device IDs */
> =A0#define STYLUS_DEVICE_ID =A0 =A0 =A0 0x02
> @@ -37,6 +38,9 @@
> =A0#define WACOM_REPORT_TPC1FG =A0 =A0 =A0 =A0 =A0 =A06
> =A0#define WACOM_REPORT_TPC2FG =A0 =A0 =A0 =A0 =A0 =A013
>
> +/* largest reported tracking id */
> +#define MAX_TRACKING_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00xfff
> +
> =A0enum {
> =A0 =A0 =A0 =A0PENPARTNER =3D 0,
> =A0 =A0 =A0 =A0GRAPHIRE,
> @@ -57,6 +61,8 @@ enum {
> =A0 =A0 =A0 =A0WACOM_MO,
> =A0 =A0 =A0 =A0TABLETPC,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> + =A0 =A0 =A0 BAMBOO_TOUCH,
> + =A0 =A0 =A0 BAMBOO_BOOT,
> =A0 =A0 =A0 =A0MAX_TYPE
> =A0};
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
