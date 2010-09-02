From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3] input: wacom: Add support for the Bamboo Touch
 trackpad (rev2)
Date: Thu, 2 Sep 2010 14:02:19 -0700
Message-ID: <AANLkTimBFwXyBDJdaMOyR9OrvZvMD6jtybvLqRqrFWV6@mail.gmail.com>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
	<1283451517-1711-4-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48670 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab0IBVCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 17:02:21 -0400
Received: by eyb6 with SMTP id 6so662510eyb.19
        for <linux-input@vger.kernel.org>; Thu, 02 Sep 2010 14:02:20 -0700 (PDT)
In-Reply-To: <1283451517-1711-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thursday, September 2, 2010, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Add support for the Bamboo Touch trackpad, and make it work well with
> both the Synaptics X Driver and the Multitouch X Driver. The device
> uses MT slots internally, so the choice of protocol is a given.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A06 +++
> =A0drivers/input/tablet/wacom_wac.c | =A0 83 ++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A03 +
> =A03 files changed, 92 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 76e15d7..ccc2d93 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -203,6 +203,10 @@ static int wacom_parse_hid(struct usb_interface =
*intf, struct hid_descriptor *hi
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligne=
d_le16(&report[i + 5]);
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligne=
d_le16(&report[i + 8]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->x_max =3D=3D 480=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_sc=
ale =3D 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pres=
sure_fuzz =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 15;
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
> @@ -257,6 +261,8 @@ static int wacom_parse_hid(struct usb_interface *=
intf, struct hid_descriptor *hi
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligne=
d_le16(&report[i + 3]);
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligne=
d_le16(&report[i + 6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->y_max =3D=3D 320=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_sc=
ale =3D 32;
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 12;
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index bfe5654..8f93358 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -855,6 +855,57 @@ static int wacom_tpc_irq(struct wacom_wac *wacom=
, size_t len)
>  =A0 =A0 =A0 =A0return retval;
> =A0}
>
> +static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
> +{
> + =A0 =A0 =A0 static int trkid;
> + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->features;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> + =A0 =A0 =A0 unsigned char *data =3D wacom->data;
> + =A0 =A0 =A0 int sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
> + =A0 =A0 =A0 int i;
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x *=3D features->x_scal=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 y *=3D features->y_scal=
e;
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
> + =A0 =A0 =A0 input_report_key(input, BTN_MIDDLE, (data[1] & 0x04) !=3D=
 0);
> + =A0 =A0 =A0 input_report_key(input, BTN_4, (data[1] & 0x02) !=3D 0)=
;
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
>  =A0 =A0 =A0 =A0bool sync;
> @@ -900,6 +951,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, =
size_t len)
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len=
);
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case BAMBOO_PT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_bpt_irq(wacom_wac, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
>  =A0 =A0 =A0 =A0default:
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D false;
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1079,6 +1134,31 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
>  =A0 =A0 =A0 =A0case PENPARTNER:
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUBBER, input_dev-=
>keybit);
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> + =A0 =A0 =A0 case BAMBOO_PT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL=
_TRIPLETAP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_LEFT, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_MIDDLE, input_dev->keybit=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_RIGHT, input_dev->keybit)=
;

An if-else is needed here instead of the break since there is a
pen-only bamboo model in the market. If you don't have time to update
it, you can leave it to Chris. He can make the changes when he work on
the other models.

Ping

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_4, input_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_FINGER, input_dev->k=
eybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBLETAP, input_dev=
->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_create_slots(input_dev, 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
POSITION_X, 0, features->x_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0features->x_fuzz, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
POSITION_Y, 0, features->y_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0features->y_fuzz, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
PRESSURE, 0, features->pressure_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0features->pressure_fuzz, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_MT_=
TRACKING_ID, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0MAX_TRACKING_ID, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>  =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -1216,6 +1296,8 @@ static const struct wacom_features wacom_featur=
es_0xE3 =3D
>  =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =
=A0 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
> =A0static const struct wacom_features wacom_features_0x47 =3D
>  =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023, 31, INTUOS };
> +static struct wacom_features wacom_features_0xD0 =3D
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023, 63, BAMBOO_PT };
>
> =A0#define USB_DEVICE_WACOM(prod) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>  =A0 =A0 =A0 =A0USB_DEVICE(USB_VENDOR_ID_WACOM, prod), =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
> @@ -1280,6 +1362,7 @@ const struct usb_device_id wacom_ids[] =3D {
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC6) },
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xC7) },
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xCE) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xD0) },
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xF0) },
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xCC) },
>  =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x90) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index ff22e34..d070417 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -38,6 +38,9 @@
> =A0#define WACOM_REPORT_TPC1FG =A0 =A0 =A0 =A0 =A0 =A06
> =A0#define WACOM_REPORT_TPC2FG =A0 =A0 =A0 =A0 =A0 =A013
>
> +/* largest reported tracking id */
> +#define MAX_TRACKING_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00xfff
> +
> =A0enum {
>  =A0 =A0 =A0 =A0PENPARTNER =3D 0,
>  =A0 =A0 =A0 =A0GRAPHIRE,
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
