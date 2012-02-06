From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/5] Input: wacom - Bamboo wireless monitor framework
Date: Mon, 6 Feb 2012 10:00:04 -0600
Message-ID: <CAGzDe_YUMrqVJDzcViRocn-LLKYKAjKynPepmi8mVgwdcF60yg@mail.gmail.com>
References: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com>
	<1328496376-28502-3-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62470 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755326Ab2BFQAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Feb 2012 11:00:06 -0500
Received: by lagu2 with SMTP id u2so3168047lag.19
        for <linux-input@vger.kernel.org>; Mon, 06 Feb 2012 08:00:04 -0800 (PST)
In-Reply-To: <1328496376-28502-3-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

On Sun, Feb 5, 2012 at 8:46 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> The 3rd gen Bamboo Pen & Touch tablets support an optional
> wireless module. When its receiver is plugged into USB it
> presents 3 interfaces: 0) Monitor 1) Pen and 2) Touch.
>
> The exact capabilities of the Pen and Touch interfaces can
> not be determined until a tablet connection is established
> and reported over the Monitor interface.
>
> This patch detects this wireless receiver and enables interrupt
> packets to be processed for the Monitor interface. Processing
> the data in packets will be left to another patch.
>
> Since it doesn't make sense to create an input device for the
> Monitor interface, it is not created. Creation of Pen and Touch
> input device is also delayed until monitor packets can be processed.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 35 ++++++++++++++++++++++++=
++++++-----
> =A0drivers/input/tablet/wacom_wac.c | =A0 28 ++++++++++++++++++++++++=
+++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A04 ++++
> =A03 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 43e82e9..2827ef3 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -422,6 +422,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0report_id, rep_data, 4, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while ((error < 0 || rep_data[1] !=3D=
 4) && limit++ < WAC_MSG_RETRIES);
> =A0 =A0 =A0 =A0} else if (features->type !=3D TABLETPC &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->type !=3D BAMBOO_WIREL=
ESS &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_=
TOOL_PEN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D 2;
> @@ -454,6 +455,21 @@ static int wacom_retrieve_hid_descriptor(struct =
usb_interface *intf,
> =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
> =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The wireless device HID is basic and layout confli=
cts with
> + =A0 =A0 =A0 =A0* other tablets (monitor and touch interface can loo=
k like pen).
> + =A0 =A0 =A0 =A0* Skip the query for this type and modify defaults b=
ased on
> + =A0 =A0 =A0 =A0* interface number.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_WIRELESS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (intf->cur_altsetting->desc.bInterfa=
ceNumber =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (intf->cur_altsetting->desc.b=
InterfaceNumber =3D=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=
 BTN_TOOL_DOUBLETAP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WA=
COM_PKGLEN_BBTOUCH3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* only Tablet PCs and Bamboo P&T need to retrieve the=
 info */
> =A0 =A0 =A0 =A0if ((features->type !=3D TABLETPC) && (features->type =
!=3D TABLETPC2FG) &&
> =A0 =A0 =A0 =A0 =A0 =A0(features->type !=3D BAMBOO_PT))
> @@ -928,9 +944,16 @@ static int wacom_probe(struct usb_interface *int=
f, const struct usb_device_id *i
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail4;
>
> - =A0 =A0 =A0 error =3D wacom_register_input(wacom);
> - =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 if (features->quirks & WACOM_QUIRK_MONITOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usb_submit_urb(wacom->irq, GFP_KERN=
EL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wacom_register_input(wacom);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Note that if query fails it is not a hard failure *=
/
> =A0 =A0 =A0 =A0wacom_query_tablet_data(intf, features);
> @@ -953,7 +976,8 @@ static void wacom_disconnect(struct usb_interface=
 *intf)
> =A0 =A0 =A0 =A0usb_set_intfdata(intf, NULL);
>
> =A0 =A0 =A0 =A0usb_kill_urb(wacom->irq);
> - =A0 =A0 =A0 input_unregister_device(wacom->wacom_wac.input);
> + =A0 =A0 =A0 if (wacom->wacom_wac.input)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(wacom->wacom_wa=
c.input);
> =A0 =A0 =A0 =A0wacom_destroy_leds(wacom);
> =A0 =A0 =A0 =A0usb_free_urb(wacom->irq);
> =A0 =A0 =A0 =A0usb_free_coherent(interface_to_usbdev(intf), WACOM_PKG=
LEN_MAX,
> @@ -985,7 +1009,8 @@ static int wacom_resume(struct usb_interface *in=
tf)
> =A0 =A0 =A0 =A0wacom_query_tablet_data(intf, features);
> =A0 =A0 =A0 =A0wacom_led_control(wacom);
>
> - =A0 =A0 =A0 if (wacom->open && usb_submit_urb(wacom->irq, GFP_NOIO)=
 < 0)
> + =A0 =A0 =A0 if ((wacom->open || features->quirks & WACOM_QUIRK_MONI=
TOR)
> + =A0 =A0 =A0 =A0 =A0 =A0&& usb_submit_urb(wacom->irq, GFP_NOIO) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rv =3D -EIO;
>
> =A0 =A0 =A0 =A0mutex_unlock(&wacom->lock);
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 9283507..5b3c58f 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1044,6 +1044,14 @@ static int wacom_bpt_irq(struct wacom_wac *wac=
om, size_t len)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int wacom_bpt_wireless_irq(struct wacom_wac *wacom, size_t le=
n)
> +{
> + =A0 =A0 =A0 if (len !=3D WACOM_PKGLEN_WIRELESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
> =A0{
> =A0 =A0 =A0 =A0bool sync;
> @@ -1094,6 +1102,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_bpt_irq(wacom_wac, len)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case BAMBOO_WIRELESS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D wacom_bpt_wireless_irq(wacom_w=
ac, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1155,7 +1167,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
>
> =A0 =A0 =A0 =A0/* these device have multiple inputs */
> =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC || features->type =3D=
=3D TABLETPC2FG ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT)
> + =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT || features->ty=
pe =3D=3D BAMBOO_WIRELESS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_MULT=
I_INPUT;
>
> =A0 =A0 =A0 =A0/* quirk for bamboo touch with 2 low res touches */
> @@ -1167,6 +1179,16 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_fuzz <<=3D 5;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_BBTO=
UCH_LOWRES;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_WIRELESS) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* monitor never has input and pen/touc=
h have delayed create */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->quirks |=3D WACOM_QUIRK_NO_IN=
PUT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* must be monitor interface if no devi=
ce_type set */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!features->device_type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->quirks |=3D W=
ACOM_QUIRK_MONITOR;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static unsigned int wacom_calculate_touch_res(unsigned int logical=
_max,
> @@ -1637,6 +1659,9 @@ static const struct wacom_features wacom_featur=
es_0xE6 =3D
> =A0static const struct wacom_features wacom_features_0x47 =3D
> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023,
> =A0 =A0 =A0 =A0 =A031, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0x84 =3D
> + =A0 =A0 =A0 { "Wacom Wireless Receiver", WACOM_PKGLEN_WIRELESS, 0, =
0, 0,
> + =A0 =A0 =A0 =A0 0, BAMBOO_WIRELESS, 0, 0 };

I just realized that the following patch will require a .touch_max =3D =
64; here:

[PATCH v2 1/2] input : wacom - retrieve maximum number of touch points

In v2, I'll fix add that and add a note about dependency.

Chris

> =A0static const struct wacom_features wacom_features_0xD0 =3D
> =A0 =A0 =A0 =A0{ "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =
=A0 14720, =A09200, 1023,
> =A0 =A0 =A0 =A0 =A031, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES =
};
> @@ -1763,6 +1788,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_DETAILED(0xCE, USB_CLASS_HID,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_INTERF=
ACE_SUBCLASS_BOOT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_INTERF=
ACE_PROTOCOL_MOUSE) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0x84) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD0) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD1) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xD2) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 4f0ba21..fcee9c5 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -24,6 +24,7 @@
> =A0#define WACOM_PKGLEN_BBTOUCH =A0 20
> =A0#define WACOM_PKGLEN_BBTOUCH3 =A064
> =A0#define WACOM_PKGLEN_BBPEN =A0 =A0 10
> +#define WACOM_PKGLEN_WIRELESS =A032
>
> =A0/* device IDs */
> =A0#define STYLUS_DEVICE_ID =A0 =A0 =A0 0x02
> @@ -45,6 +46,8 @@
> =A0/* device quirks */
> =A0#define WACOM_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
001
> =A0#define WACOM_QUIRK_BBTOUCH_LOWRES =A0 =A0 0x0002
> +#define WACOM_QUIRK_NO_INPUT =A0 =A0 =A0 =A0 =A0 0x0004
> +#define WACOM_QUIRK_MONITOR =A0 =A0 =A0 =A0 =A0 =A00x0008
>
> =A0enum {
> =A0 =A0 =A0 =A0PENPARTNER =3D 0,
> @@ -54,6 +57,7 @@ enum {
> =A0 =A0 =A0 =A0PL,
> =A0 =A0 =A0 =A0DTU,
> =A0 =A0 =A0 =A0BAMBOO_PT,
> + =A0 =A0 =A0 BAMBOO_WIRELESS,
> =A0 =A0 =A0 =A0INTUOS,
> =A0 =A0 =A0 =A0INTUOS3S,
> =A0 =A0 =A0 =A0INTUOS3,
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
