From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v4 4/4] Input: wacom - wireless battery status
Date: Tue, 20 Mar 2012 18:03:05 -0700
Message-ID: <CAF8JNhLCrVkkm_YeRYCz3iZsdqCOFr6G_HTQLerbodcEpDcXbQ@mail.gmail.com>
References: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
	<1331686322-4914-5-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63945 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab2CUBDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 21:03:06 -0400
Received: by gghe5 with SMTP id e5so622596ggh.19
        for <linux-input@vger.kernel.org>; Tue, 20 Mar 2012 18:03:05 -0700 (PDT)
In-Reply-To: <1331686322-4914-5-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, killertofu@gmail.com

On Tue, Mar 13, 2012 at 5:52 PM, <chris@cnpbagwell.com> wrote:
>
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>

Acked-by: Ping Cheng <pingc@wacom.com> for the whole patchset.

As far as I know, Jason tested this patchset on Intuos5. So, Dmitry, yo=
u can add

Tested-by: Jason Gerecke <killertofu@gmail.com>.

Ping

> ---
> =A0drivers/input/tablet/Kconfig =A0 =A0 | =A0 =A01 +
> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A02 +
> =A0drivers/input/tablet/wacom_sys.c | =A0 58
> +++++++++++++++++++++++++++++++++++++-
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A05 ++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
> =A05 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kcon=
fig
> index 58a8775..0edeb94 100644
> --- a/drivers/input/tablet/Kconfig
> +++ b/drivers/input/tablet/Kconfig
> @@ -76,6 +76,7 @@ config TABLET_USB_KBTAB
> =A0config TABLET_USB_WACOM
> =A0 =A0 =A0 =A0tristate "Wacom Intuos/Graphire tablet support (USB)"
> =A0 =A0 =A0 =A0depends on USB_ARCH_HAS_HCD
> + =A0 =A0 =A0 select POWER_SUPPLY
> =A0 =A0 =A0 =A0select USB
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Say Y here if you want to use the USB version of t=
he Wacom Intuos
> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/waco=
m.h
> index febbfd9..b4842d0 100644
> --- a/drivers/input/tablet/wacom.h
> +++ b/drivers/input/tablet/wacom.h
> @@ -88,6 +88,7 @@
> =A0#include <linux/mod_devicetable.h>
> =A0#include <linux/init.h>
> =A0#include <linux/usb/input.h>
> +#include <linux/power_supply.h>
> =A0#include <asm/unaligned.h>
>
> =A0/*
> @@ -121,6 +122,7 @@ struct wacom {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 hlv; =A0 =A0 =A0 /* status led brig=
htness button pressed
> (1..127) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 img_lum; =A0 /* OLED matrix display=
 brightness */
> =A0 =A0 =A0 =A0} led;
> + =A0 =A0 =A0 struct power_supply battery;
> =A0};
>
> =A0static inline void wacom_schedule_work(struct wacom_wac *wacom_wac=
)
> diff --git a/drivers/input/tablet/wacom_sys.c
> b/drivers/input/tablet/wacom_sys.c
> index 2fc7705..fe8a7f6 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -843,6 +843,56 @@ static void wacom_destroy_leds(struct wacom *wac=
om)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static enum power_supply_property wacom_battery_props[] =3D {
> + =A0 =A0 =A0 POWER_SUPPLY_PROP_CAPACITY
> +};
> +
> +static int wacom_battery_get_property(struct power_supply *psy,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 enum power_supply_property psp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 union power_supply_propval *val)
> +{
> + =A0 =A0 =A0 struct wacom *wacom =3D container_of(psy, struct wacom,=
 battery);
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 switch (psp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case POWER_SUPPLY_PROP_CAPACITY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->=
wacom_wac.battery_capacity * 100 /
> 31;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int wacom_initialize_battery(struct wacom *wacom)
> +{
> + =A0 =A0 =A0 int error =3D 0;
> +
> + =A0 =A0 =A0 if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONI=
TOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.properties =3D wacom_bat=
tery_props;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.num_properties =3D
> ARRAY_SIZE(wacom_battery_props);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.get_property =3D wacom_b=
attery_get_property;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.name =3D "wacom_battery"=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.type =3D POWER_SUPPLY_TY=
PE_BATTERY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery.use_for_apm =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D power_supply_register(&wacom-=
>usbdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &wacom->battery);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return error;
> +}
> +
> +static void wacom_destroy_battery(struct wacom *wacom)
> +{
> + =A0 =A0 =A0 if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONI=
TOR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_supply_unregister(&wacom->battery=
);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static int wacom_register_input(struct wacom *wacom)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *input_dev;
> @@ -1016,10 +1066,14 @@ static int wacom_probe(struct usb_interface *=
intf,
> const struct usb_device_id *i
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail4;
>
> + =A0 =A0 =A0 error =3D wacom_initialize_battery(wacom);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> +
> =A0 =A0 =A0 =A0if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D wacom_register_input(wacom);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail6;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Note that if query fails it is not a hard failure *=
/
> @@ -1034,6 +1088,7 @@ static int wacom_probe(struct usb_interface *in=
tf,
> const struct usb_device_id *i
>
> =A0 =A0 =A0 =A0return 0;
>
> + fail6: wacom_destroy_battery(wacom);
> =A0fail5: wacom_destroy_leds(wacom);
> =A0fail4: =A0 =A0 =A0 =A0wacom_remove_shared_data(wacom_wac);
> =A0fail3: =A0 =A0 =A0 =A0usb_free_urb(wacom->irq);
> @@ -1052,6 +1107,7 @@ static void wacom_disconnect(struct usb_interfa=
ce
> *intf)
> =A0 =A0 =A0 =A0cancel_work_sync(&wacom->work);
> =A0 =A0 =A0 =A0if (wacom->wacom_wac.input)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_unregister_device(wacom->wacom_w=
ac.input);
> + =A0 =A0 =A0 wacom_destroy_battery(wacom);
> =A0 =A0 =A0 =A0wacom_destroy_leds(wacom);
> =A0 =A0 =A0 =A0usb_free_urb(wacom->irq);
> =A0 =A0 =A0 =A0usb_free_coherent(interface_to_usbdev(intf), WACOM_PKG=
LEN_MAX,
> diff --git a/drivers/input/tablet/wacom_wac.c
> b/drivers/input/tablet/wacom_wac.c
> index fce7a09..99fb6fe 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1054,17 +1054,20 @@ static int wacom_wireless_irq(struct wacom_wa=
c
> *wacom, size_t len)
>
> =A0 =A0 =A0 =A0connected =3D data[1] & 0x01;
> =A0 =A0 =A0 =A0if (connected) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int pid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int pid, battery;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pid =3D get_unaligned_be16(&data[6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 battery =3D data[5] & 0x3f;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (wacom->pid !=3D pid) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->pid =3D pid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_schedule_work(wa=
com);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery_capacity =3D battery;
> =A0 =A0 =A0 =A0} else if (wacom->pid !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* disconnected while previously conne=
cted */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->pid =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_schedule_work(wacom);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->battery_capacity =3D 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/drivers/input/tablet/wacom_wac.h
> b/drivers/input/tablet/wacom_wac.h
> index cffaf6b..ba5a334 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -112,6 +112,7 @@ struct wacom_wac {
> =A0 =A0 =A0 =A0struct wacom_shared *shared;
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int pid;
> + =A0 =A0 =A0 int battery_capacity;
> =A0};
>
> =A0#endif
> --
> 1.7.7.6
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
