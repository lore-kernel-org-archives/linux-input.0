From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/4] input: wacom - use BTN_TOOL_FINGER to indicate touch
 device type
Date: Sun, 18 Dec 2011 19:06:10 -0600
Message-ID: <CAGzDe_aje8vW88ZLqLJh6m2xpuaTQwhAW3crJgDbZbY-MNsb-Q@mail.gmail.com>
References: <1324082219-32686-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55402 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab1LSBGL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Dec 2011 20:06:11 -0500
Received: by eaaj10 with SMTP id j10so4343027eaa.19
        for <linux-input@vger.kernel.org>; Sun, 18 Dec 2011 17:06:10 -0800 (PST)
In-Reply-To: <1324082219-32686-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

This series had some touches to Bamboo paths so I tested it with a 1st
gen and 3rd gen.  So you can put my:

Tested-by: Chris Bagwell <chris@cnpbagwell.com>

=46or this patch:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>


On Fri, Dec 16, 2011 at 6:36 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A06 +-----
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A04 ++--
> =A02 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 7e63183..c9588ee 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -176,7 +176,7 @@ static int wacom_parse_logical_collection(unsigne=
d char *report,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Logical collection is only used by =
3rd gen Bamboo Touch */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGLEN_BBTO=
UCH3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_DOUB=
LETAP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_FING=
ER;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Stylus and Touch have same active a=
rea
> @@ -286,12 +286,10 @@ static int wacom_parse_hid(struct usb_interface=
 *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_=
TOOL_DOUBLETAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_=
TOOL_DOUBLETAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 5]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
> @@ -325,7 +323,6 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_=
TOOL_DOUBLETAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> @@ -334,7 +331,6 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0} else if (features->type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_=
TOOL_DOUBLETAP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index a22e778..e18f362 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1317,7 +1317,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_DOUBLETAP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_FINGER) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(in=
put_dev, 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_TOOL_TYPE,
> @@ -1366,7 +1366,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_POINTER, input_de=
v->propbit);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_DOUBLETAP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TO=
OL_FINGER) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_LEFT, in=
put_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_FORWARD,=
 input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_BACK, in=
put_dev->keybit);
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
