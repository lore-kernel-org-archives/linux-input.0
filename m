From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom - battery reporting improvements
Date: Tue, 22 May 2012 11:05:28 -0700
Message-ID: <CAF8JNh+tNUvmiAFA_=MV0GgScO3J3+bmATkoVvOJK_3Gy0Y-eg@mail.gmail.com>
References: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56673 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab2EVSF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 14:05:29 -0400
Received: by yenm10 with SMTP id m10so5663890yen.19
        for <linux-input@vger.kernel.org>; Tue, 22 May 2012 11:05:28 -0700 (PDT)
In-Reply-To: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Sun, May 20, 2012 at 6:43 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Do not register battery device until connected to a tablet.
> This prevents an empty battery icon from being shown when tablet is
> connected using USB cable.
>
> Also, call power_supply_powers() for apps that can make use of that
> info.
>
> And stop ignoring input registration failures.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Reviewed by: Ping Cheng <pingc@wacom.com>

Thank you for rearranging the failure cases. It makes the driver more
user friendly and fixes potential memory leaks..

Ping

> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 82 ++++++++++++++++++++++++=
--------------
> =A01 file changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b3a8bd3..74b7725 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -967,6 +967,10 @@ static int wacom_initialize_battery(struct wacom=
 *wacom)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D power_supply_register(&wacom=
->usbdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&wacom->battery);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_supply_powers(&wa=
com->battery,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &wacom->usbdev->dev);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return error;
> @@ -974,8 +978,11 @@ static int wacom_initialize_battery(struct wacom=
 *wacom)
>
> =A0static void wacom_destroy_battery(struct wacom *wacom)
> =A0{
> - =A0 =A0 =A0 if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONI=
TOR)
> + =A0 =A0 =A0 if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONI=
TOR &&
> + =A0 =A0 =A0 =A0 =A0 wacom->battery.dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0power_supply_unregister(&wacom->batter=
y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.dev =3D NULL;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static int wacom_register_input(struct wacom *wacom)
> @@ -1022,23 +1029,30 @@ static void wacom_wireless_work(struct work_s=
truct *work)
> =A0 =A0 =A0 =A0struct wacom *wacom =3D container_of(work, struct waco=
m, work);
> =A0 =A0 =A0 =A0struct usb_device *usbdev =3D wacom->usbdev;
> =A0 =A0 =A0 =A0struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> + =A0 =A0 =A0 struct wacom *wacom1, *wacom2;
> + =A0 =A0 =A0 struct wacom_wac *wacom_wac1, *wacom_wac2;
> + =A0 =A0 =A0 int error;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Regardless if this is a disconnect or a new tablet,
> - =A0 =A0 =A0 =A0* remove any existing input devices.
> + =A0 =A0 =A0 =A0* remove any existing input and battery devices.
> =A0 =A0 =A0 =A0 */
>
> + =A0 =A0 =A0 wacom_destroy_battery(wacom);
> +
> =A0 =A0 =A0 =A0/* Stylus interface */
> - =A0 =A0 =A0 wacom =3D usb_get_intfdata(usbdev->config->interface[1]=
);
> - =A0 =A0 =A0 if (wacom->wacom_wac.input)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(wacom->wacom_wa=
c.input);
> - =A0 =A0 =A0 wacom->wacom_wac.input =3D NULL;
> + =A0 =A0 =A0 wacom1 =3D usb_get_intfdata(usbdev->config->interface[1=
]);
> + =A0 =A0 =A0 wacom_wac1 =3D &(wacom1->wacom_wac);
> + =A0 =A0 =A0 if (wacom_wac1->input)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(wacom_wac1->inp=
ut);
> + =A0 =A0 =A0 wacom_wac1->input =3D NULL;
>
> =A0 =A0 =A0 =A0/* Touch interface */
> - =A0 =A0 =A0 wacom =3D usb_get_intfdata(usbdev->config->interface[2]=
);
> - =A0 =A0 =A0 if (wacom->wacom_wac.input)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(wacom->wacom_wa=
c.input);
> - =A0 =A0 =A0 wacom->wacom_wac.input =3D NULL;
> + =A0 =A0 =A0 wacom2 =3D usb_get_intfdata(usbdev->config->interface[2=
]);
> + =A0 =A0 =A0 wacom_wac2 =3D &(wacom2->wacom_wac);
> + =A0 =A0 =A0 if (wacom_wac2->input)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_unregister_device(wacom_wac2->inp=
ut);
> + =A0 =A0 =A0 wacom_wac2->input =3D NULL;
>
> =A0 =A0 =A0 =A0if (wacom_wac->pid =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&wacom->intf->dev, "wireless =
tablet disconnected\n");
> @@ -1063,24 +1077,39 @@ static void wacom_wireless_work(struct work_s=
truct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Stylus interface */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom =3D usb_get_intfdata(usbdev->conf=
ig->interface[1]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac =3D &wacom->wacom_wac;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac1->features =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*((struct wacom_featur=
es *)id->driver_info);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features.device_type =3D BTN=
_TOOL_PEN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_register_input(wacom);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac1->features.device_type =3D BT=
N_TOOL_PEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wacom_register_input(wacom1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Touch interface */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom =3D usb_get_intfdata(usbdev->conf=
ig->interface[2]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac =3D &wacom->wacom_wac;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac2->features =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*((struct wacom_featur=
es *)id->driver_info);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features.pktlen =3D WACOM_PK=
GLEN_BBTOUCH3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features.device_type =3D BTN=
_TOOL_FINGER;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_set_phy_from_res(&wacom_wac->feat=
ures);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->features.x_max =3D wacom_wac=
->features.y_max =3D 4096;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_register_input(wacom);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac2->features.pktlen =3D WACOM_P=
KGLEN_BBTOUCH3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac2->features.device_type =3D BT=
N_TOOL_FINGER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_set_phy_from_res(&wacom_wac2->fea=
tures);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac2->features.x_max =3D wacom_wa=
c2->features.y_max =3D 4096;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wacom_register_input(wacom2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wacom_initialize_battery(waco=
m);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 return;
> +
> +fail3:
> + =A0 =A0 =A0 input_unregister_device(wacom_wac2->input);
> + =A0 =A0 =A0 wacom_wac2->input =3D NULL;
> +fail2:
> + =A0 =A0 =A0 input_unregister_device(wacom_wac1->input);
> + =A0 =A0 =A0 wacom_wac1->input =3D NULL;
> +fail1:
> + =A0 =A0 =A0 return;
> =A0}
>
> =A0static int wacom_probe(struct usb_interface *intf, const struct us=
b_device_id *id)
> @@ -1183,14 +1212,10 @@ static int wacom_probe(struct usb_interface *=
intf, const struct usb_device_id *i
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail4;
>
> - =A0 =A0 =A0 error =3D wacom_initialize_battery(wacom);
> - =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> -
> =A0 =A0 =A0 =A0if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D wacom_register_input(wacom);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Note that if query fails it is not a hard failure *=
/
> @@ -1205,7 +1230,6 @@ static int wacom_probe(struct usb_interface *in=
tf, const struct usb_device_id *i
>
> =A0 =A0 =A0 =A0return 0;
>
> - fail6: wacom_destroy_battery(wacom);
> =A0fail5: wacom_destroy_leds(wacom);
> =A0fail4: =A0 =A0 =A0 =A0wacom_remove_shared_data(wacom_wac);
> =A0fail3: =A0 =A0 =A0 =A0usb_free_urb(wacom->irq);
> --
> 1.7.10.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
