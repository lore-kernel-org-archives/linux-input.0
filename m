From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: wacom: Add support for Cintiq 24HD
Date: Thu, 8 Dec 2011 16:34:52 -0800
Message-ID: <CAF8JNhJmDWtTGm3GQjH1_5YO=KYghxEfQynhvPVy=Rts1Fdxpg@mail.gmail.com>
References: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38402 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1LIAey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2011 19:34:54 -0500
Received: by wgbdr13 with SMTP id dr13so4377163wgb.1
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2011 16:34:52 -0800 (PST)
In-Reply-To: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, Dec 7, 2011 at 3:04 PM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
> Adds support for the Cintiq 24HD. There are two quirks about this
> model that haven't been seen in prior tablets. First, a second
> touch ring is present on this display; it is being exposed via the
> ABS_THROTTLE axis. Second, three capacitive buttons at the top of
> the unit are available; though physically a touch strip, we report
> the use of these buttons with generic KEY_ events.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> Changes from v1:
> =A0* s/ABS_WHEEL2/ABS_THROTTLE/
> =A0* Clarify comment about clearing 2nd wheel value
>
> =A0drivers/input/tablet/wacom_wac.c | =A0 77 ++++++++++++++++++++++++=
+++++++++++++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
> =A02 files changed, 77 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index ecfcbc8..a22e778 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -452,7 +452,7 @@ static void wacom_intuos_general(struct wacom_wac=
 *wacom)
> =A0 =A0 =A0 =A0if ((data[1] & 0xb8) =3D=3D 0xa0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t =3D (data[6] << 2) | ((data[7] >> 6)=
 & 3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((features->type >=3D INTUOS4S && f=
eatures->type <=3D INTUOS4L) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type =3D=3D WACOM_21U=
X2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type =3D=3D WACOM_21U=
X2 || features->type =3D=3D WACOM_24HD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t =3D (t << 1) | (data=
[1] & 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_PRESSURE, =
t);
> @@ -519,6 +519,56 @@ static int wacom_intuos_irq(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_=
report_key(input, wacom->tool[1], 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_=
report_abs(input, ABS_MISC, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (features->type =3D=3D WACOM_=
24HD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_0, (data[6] & 0x01));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_1, (data[6] & 0x02));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_2, (data[6] & 0x04));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_3, (data[6] & 0x08));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_4, (data[6] & 0x10));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_5, (data[6] & 0x20));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_6, (data[6] & 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_7, (data[6] & 0x80));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_8, (data[8] & 0x01));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_9, (data[8] & 0x02));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_A, (data[8] & 0x04));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_B, (data[8] & 0x08));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_C, (data[8] & 0x10));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_X, (data[8] & 0x20));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_Y, (data[8] & 0x40));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_Z, (data[8] & 0x80));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Three "buttons" ar=
e available on the 24HD which are
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* physically impleme=
nted as a touchstrip. Each button
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is approximately 3=
 bits wide with a 2 bit spacing.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The raw touchstrip=
 bits are stored at:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0((data[3] &=
 0x1f) << 8) | data[4])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 KEY_PROG1, data[4] & 0x07);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 KEY_PROG2, data[4] & 0xE0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 KEY_PROG3, data[3] & 0x1C);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[1] & 0x80) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_WHEEL, (data[1] & 0x7f));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Out =
of proximity, clear wheel value. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_WHEEL, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[2] & 0x80) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_THROTTLE, (data[2] & 0x7f));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Out =
of proximity, clear second wheel value. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_THROTTLE, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[1] | data[2] |=
 (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, wacom->tool[1], 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_MISC, PAD_DEVICE_ID);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, wacom->tool[1], 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_abs(input, ABS_MISC, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=
=3D WACOM_21UX2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_=
report_key(input, BTN_0, (data[5] & 0x01));
> @@ -1019,6 +1069,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
> =A0 =A0 =A0 =A0case CINTIQ:
> =A0 =A0 =A0 =A0case WACOM_BEE:
> =A0 =A0 =A0 =A0case WACOM_21UX2:
> + =A0 =A0 =A0 case WACOM_24HD:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_intuos_irq(wacom_wac);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1174,6 +1225,26 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_POINTER, input_de=
v->propbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case WACOM_24HD:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_A, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_B, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_C, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_X, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_Y, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_Z, input_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 10; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_0 + i, in=
put_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(KEY_PROG1, input_dev->keybit)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(KEY_PROG2, input_dev->keybit)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(KEY_PROG3, input_dev->keybit)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Z, =
-900, 899, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_THR=
OTTLE, 0, 71, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_setup_cintiq(wacom_wac);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case WACOM_21UX2:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_A, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_B, input_dev->keybit);
> @@ -1503,6 +1574,9 @@ static const struct wacom_features wacom_featur=
es_0xBB =3D
> =A0static const struct wacom_features wacom_features_0xBC =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos4 WL", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0=
 =A040840, 25400, 2047,
> =A0 =A0 =A0 =A0 =A063, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> +static const struct wacom_features wacom_features_0xF4 =3D
> + =A0 =A0 =A0 { "Wacom Cintiq 24HD", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
104480, 65600, 2047,
> + =A0 =A0 =A0 =A0 63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RE=
S };
> =A0static const struct wacom_features wacom_features_0x3F =3D
> =A0 =A0 =A0 =A0{ "Wacom Cintiq 21UX", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A087200, 65600, 1023,
> =A0 =A0 =A0 =A0 =A063, CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> @@ -1702,6 +1776,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE3) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x47) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xF4) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_LENOVO(0x6004) },
> =A0 =A0 =A0 =A0{ }
> =A0};
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 27f1d1c..050acae 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -59,6 +59,7 @@ enum {
> =A0 =A0 =A0 =A0INTUOS4S,
> =A0 =A0 =A0 =A0INTUOS4,
> =A0 =A0 =A0 =A0INTUOS4L,
> + =A0 =A0 =A0 WACOM_24HD,
> =A0 =A0 =A0 =A0WACOM_21UX2,
> =A0 =A0 =A0 =A0CINTIQ,
> =A0 =A0 =A0 =A0WACOM_BEE,
> --
> 1.7.7.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
