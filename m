From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v2 4/4] input: wacom: Intuos5 multitouch sensor support
Date: Mon, 12 Mar 2012 22:25:06 -0500
Message-ID: <CAGzDe_b4f3Ls_wRfMJUDz8tt8m-PSefUYV2Zg0w1ansL7VMOwQ@mail.gmail.com>
References: <1331345166-1022-1-git-send-email-killertofu@gmail.com>
	<1331591805-4014-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36856 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758762Ab2CMDZI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 23:25:08 -0400
Received: by lahj13 with SMTP id j13so72339lah.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 20:25:07 -0700 (PDT)
In-Reply-To: <1331591805-4014-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linuxwacom-devel@lists.sourceforge.net

On Mon, Mar 12, 2012 at 5:36 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> Intuos5 tablets with PTH-* model numbers include a multitouch sensor
> which use the same touch reports as the 3rd-generation Bamboo. No
> useful information is in the HID descriptor for the touch interface
> so hardcoded values are used during setup.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> Changes from v1:
> =A0* Fixed calculation of x_phy and y_phy (logic for the 3rd-gen Bamb=
oo
> =A0 which I copied is incorrect! Patch on the way.)

Thanks for catching.

=46or patches 1, 2, and 4 in this series:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

I did review and didn't see any issues with patch #3 but I'm not
familiar with LED support to comment.

Chris

>
> =A0drivers/input/tablet/wacom_sys.c | =A0 24 ++++++++++++++
> =A0drivers/input/tablet/wacom_wac.c | =A0 63 ++++++++++++++++++++++++=
+++++++++++---
> =A02 files changed, 82 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 11b4c05..528e3a4 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -228,6 +228,9 @@ static int wacom_parse_logical_collection(unsigne=
d char *report,
> =A0* 3rd gen Bamboo Touch no longer define a Digitizer-Finger Pysical
> =A0* Collection. Instead they define a Logical Collection with a sing=
le
> =A0* Logical Maximum for both X and Y.
> + *
> + * Intuos5 touch interface does not contain useful data. We deal wit=
h
> + * this after returning from this function.
> =A0*/
> =A0static int wacom_parse_hid(struct usb_interface *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_descri=
ptor *hid_desc,
> @@ -924,6 +927,27 @@ static int wacom_probe(struct usb_interface *int=
f, const struct usb_device_id *i
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
>
> + =A0 =A0 =A0 /* Intuos5 has no useful data about its touch interface=
 in its
> + =A0 =A0 =A0 =A0* HID descriptor. If this is the touch interface (wM=
axPacketSize
> + =A0 =A0 =A0 =A0* of WACOM_PKGLEN_BBTOUCH3), override the table valu=
es.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (features->type >=3D INTUOS5S && features->type <=3D=
 INTUOS5L) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (endpoint->wMaxPacketSize =3D=3D WAC=
OM_PKGLEN_BBTOUCH3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=
 BTN_TOOL_FINGER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WA=
COM_PKGLEN_BBTOUCH3;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (featur=
es->x_max * 100) / features->x_resolution;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (featur=
es->y_max * 100) / features->y_resolution;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max =3D 409=
6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max =3D 409=
6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=
 BTN_TOOL_PEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0wacom_setup_device_quirks(features);
>
> =A0 =A0 =A0 =A0strlcpy(wacom_wac->name, features->name, sizeof(wacom_=
wac->name));
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 86827c7..30067ae 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -321,6 +321,9 @@ static int wacom_intuos_inout(struct wacom_wac *w=
acom)
>
> =A0 =A0 =A0 =A0/* Enter report */
> =A0 =A0 =A0 =A0if ((data[1] & 0xfc) =3D=3D 0xc0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type >=3D INTUOS5S && fea=
tures->type <=3D INTUOS5L)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_i=
n_proximity =3D true;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* serial number of the tool */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->serial[idx] =3D ((data[3] & 0x0=
f) << 28) +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(data[4] << 20) + (dat=
a[5] << 12) +
> @@ -406,6 +409,9 @@ static int wacom_intuos_inout(struct wacom_wac *w=
acom)
>
> =A0 =A0 =A0 =A0/* Exit report */
> =A0 =A0 =A0 =A0if ((data[1] & 0xfe) =3D=3D 0x80) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type >=3D INTUOS5S && fea=
tures->type <=3D INTUOS5L)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_i=
n_proximity =3D false;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Reset all states otherwise we lose =
the initial states
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * when in-prox next time
> @@ -1111,9 +1117,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
> =A0 =A0 =A0 =A0case INTUOS4S:
> =A0 =A0 =A0 =A0case INTUOS4:
> =A0 =A0 =A0 =A0case INTUOS4L:
> - =A0 =A0 =A0 case INTUOS5S:
> - =A0 =A0 =A0 case INTUOS5:
> - =A0 =A0 =A0 case INTUOS5L:
> =A0 =A0 =A0 =A0case CINTIQ:
> =A0 =A0 =A0 =A0case WACOM_BEE:
> =A0 =A0 =A0 =A0case WACOM_21UX2:
> @@ -1121,6 +1124,15 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_intuos_irq(wacom_wac);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case INTUOS5S:
> + =A0 =A0 =A0 case INTUOS5:
> + =A0 =A0 =A0 case INTUOS5L:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_BBTOUCH3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_bpt3_tou=
ch(wacom_wac);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_intuos_i=
rq(wacom_wac);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> @@ -1191,7 +1203,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
>
> =A0 =A0 =A0 =A0/* these device have multiple inputs */
> =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC || features->type =3D=
=3D TABLETPC2FG ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT)
> + =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT || (features->t=
ype >=3D INTUOS5S && features->type <=3D INTUOS5L))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_MULT=
I_INPUT;
>
> =A0 =A0 =A0 =A0/* quirk for bamboo touch with 2 low res touches */
> @@ -1350,13 +1362,54 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>
> =A0 =A0 =A0 =A0case INTUOS5:
> =A0 =A0 =A0 =A0case INTUOS5L:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_PEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_7, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_8, input_=
dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
> +
> + =A0 =A0 =A0 case INTUOS5S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_PEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 7; i+=
+)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_b=
it(BTN_0 + i, input_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_DISTANCE, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->distance_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_Z, -900, 899, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_setup_intuos(waco=
m_wac);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (features->device_type =3D=3D=
 BTN_TOOL_FINGER) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, i=
nput_dev->absbit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_FING=
ER, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUB=
LETAP, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_TRIP=
LETAP, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_QUAD=
TAP, input_dev->keybit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(inp=
ut_dev, 16);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_MT_TOUCH_MAJOR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00, 255, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_MT_POSITION_X,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00, features->x_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0features->x_fuzz, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_MT_POSITION_Y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00, features->y_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0features->y_fuzz, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0case INTUOS4:
> =A0 =A0 =A0 =A0case INTUOS4L:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_7, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_8, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> - =A0 =A0 =A0 case INTUOS5S:
> =A0 =A0 =A0 =A0case INTUOS4S:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < 7; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_0 + i, i=
nput_dev->keybit);
> --
> 1.7.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
