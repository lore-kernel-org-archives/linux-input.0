From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/5] Input - wacom: create a separate input device for pads
Date: Thu, 10 Jul 2014 17:18:51 -0700
Message-ID: <CANRwn3S-vhSf5tMSt1L_1CwkxttGx1qHKx=O+S5TcU+wjgtNBg@mail.gmail.com>
References: <1403557039-1487-1-git-send-email-benjamin.tissoires@redhat.com>
	<1403557039-1487-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:39621 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaGKASy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 20:18:54 -0400
In-Reply-To: <1403557039-1487-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>

On Mon, Jun 23, 2014 at 1:57 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Currently, the pad events are sent through the stylus input device
> for the Intuos/Cintiqs, and through the touch input device for the
> Bamboos.
>
> To differentiate the buttons pressed on the pad from the ones pressed
> on the stylus, the Intuos/Cintiq uses MISC_SERIAL and ABS_MISC. This
> lead to a multiplexing of the events into one device, which are then
> splitted out in xf86-input-wacom. Bamboos are not using MISC events
> because the pad is attached to the touch interface, and only BTN_TOUC=
H
> is used for the finger (and DOUBLE_TAP, etc...). However, the user sp=
ace
> driver still splits out the pad from the touch interface in the same
> way it does for the pro line devices.
>
> The other problem we can see with this fact is that some of the Intuo=
s
> and Cintiq have a wheel, and the effective range of the reported valu=
es
> is [0..71]. Unfortunately, the airbrush stylus also sends wheel event=
s
> (there is a small wheel on it), but in the range [0..1023]. From the =
user
> space point of view it is kind of difficult to understand that becaus=
e
> the wheel on the pad are quite common, while the airbrush tool is not=
=2E
>
> A solution to fix all of these problems is to split out the pad devic=
e
> from the stylus/touch. This decision makes more sense because the pad=
 is
> not linked to the absolute position of the finger or pen, and usually=
, the
> events from the pad are filtered out by the compositor, which then co=
nvert
> them into actions or keyboard shortcuts.
>
> For backward compatibility with current xf86-input-wacom, the pad dev=
ices
> still present the ABS_X, ABS_Y and ABS_MISC events, but they can be
> completely ignored in the new implementation.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/tablet/wacom.h     |  2 ++
>  drivers/input/tablet/wacom_sys.c | 63 ++++++++++++++++++++++++++++++=
+++++-----
>  drivers/input/tablet/wacom_wac.c | 27 ++++++++++++++++-
>  drivers/input/tablet/wacom_wac.h |  2 ++
>  4 files changed, 85 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/waco=
m.h
> index 9ebf0ed..caa59ca 100644
> --- a/drivers/input/tablet/wacom.h
> +++ b/drivers/input/tablet/wacom.h
> @@ -136,4 +136,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, s=
ize_t len);
>  void wacom_setup_device_quirks(struct wacom_features *features);
>  int wacom_setup_input_capabilities(struct input_dev *input_dev,
>                                    struct wacom_wac *wacom_wac);
> +int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
> +                                      struct wacom_wac *wacom_wac);
>  #endif
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index c993eee..b9bf37e 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -135,6 +135,9 @@ static int wacom_open(struct input_dev *dev)
>
>         mutex_lock(&wacom->lock);
>
> +       if (wacom->open)
> +               goto out;
> +
>         if (usb_submit_urb(wacom->irq, GFP_KERNEL)) {
>                 retval =3D -EIO;
>                 goto out;
> @@ -157,9 +160,14 @@ static void wacom_close(struct input_dev *dev)
>         autopm_error =3D usb_autopm_get_interface(wacom->intf);
>
>         mutex_lock(&wacom->lock);
> +       if (!wacom->open)
> +               goto out;
> +
>         usb_kill_urb(wacom->irq);
>         wacom->open =3D false;
>         wacom->intf->needs_remote_wakeup =3D 0;
> +
> +out:
>         mutex_unlock(&wacom->lock);
>
>         if (!autopm_error)
> @@ -1109,19 +1117,16 @@ static void wacom_destroy_battery(struct waco=
m *wacom)
>         }
>  }
>
> -static int wacom_register_input(struct wacom *wacom)
> +static struct input_dev *wacom_allocate_input(struct wacom *wacom)
>  {
>         struct input_dev *input_dev;
>         struct usb_interface *intf =3D wacom->intf;
>         struct usb_device *dev =3D interface_to_usbdev(intf);
>         struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
> -       int error;
>
>         input_dev =3D input_allocate_device();
> -       if (!input_dev) {
> -               error =3D -ENOMEM;
> -               goto fail1;
> -       }
> +       if (!input_dev)
> +               return NULL;
>
>         input_dev->name =3D wacom_wac->name;
>         input_dev->phys =3D wacom->phys;
> @@ -1131,21 +1136,59 @@ static int wacom_register_input(struct wacom =
*wacom)
>         usb_to_input_id(dev, &input_dev->id);
>         input_set_drvdata(input_dev, wacom);
>
> +       return input_dev;
> +}
> +
> +static int wacom_register_input(struct wacom *wacom)
> +{
> +       struct input_dev *input_dev, *pad_input_dev;
> +       struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
> +       int error;
> +
> +       input_dev =3D wacom_allocate_input(wacom);
> +       pad_input_dev =3D wacom_allocate_input(wacom);
> +       if (!input_dev || !pad_input_dev) {
> +               error =3D -ENOMEM;
> +               goto fail1;
> +       }
> +
>         wacom_wac->input =3D input_dev;
> +       wacom_wac->pad_input =3D pad_input_dev;
> +       wacom_wac->pad_input->name =3D wacom_wac->pad_name;
> +
>         error =3D wacom_setup_input_capabilities(input_dev, wacom_wac=
);
>         if (error)
> -               goto fail1;
> +               goto fail2;
>
>         error =3D input_register_device(input_dev);
>         if (error)
>                 goto fail2;
>
> +       error =3D wacom_setup_pad_input_capabilities(pad_input_dev, w=
acom_wac);
> +       if (error) {
> +               /* no pad in use on this interface */
> +               input_free_device(pad_input_dev);
> +               wacom_wac->pad_input =3D NULL;
> +               pad_input_dev =3D NULL;
> +       } else {
> +               error =3D input_register_device(pad_input_dev);
> +               if (error)
> +                       goto fail3;
> +       }
> +
>         return 0;
>
> +fail3:
> +       input_unregister_device(input_dev);
> +       input_dev =3D NULL;
>  fail2:
> -       input_free_device(input_dev);
>         wacom_wac->input =3D NULL;
> +       wacom_wac->pad_input =3D NULL;
>  fail1:
> +       if (input_dev)
> +               input_free_device(input_dev);
> +       if (pad_input_dev)
> +               input_free_device(pad_input_dev);
>         return error;
>  }
>
> @@ -1364,6 +1407,8 @@ static int wacom_probe(struct usb_interface *in=
tf, const struct usb_device_id *i
>         wacom_calculate_res(features);
>
>         strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->na=
me));
> +       snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
> +               "%s Pad", features->name);

This may cause some heartburn for some users that have xsetwacom
scripts (or use similar tools that need a device name). Our X driver
already appends a " pad" suffix to the device name, so this results in
X devices now having the double-suffix " Pad pad". I agree with adding
the suffix here though, so I think I'll write a patch to fix this in
xf86-input-wacom.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>
>         if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
>                 struct usb_device *other_dev;
> @@ -1438,6 +1483,8 @@ static void wacom_disconnect(struct usb_interfa=
ce *intf)
>         cancel_work_sync(&wacom->work);
>         if (wacom->wacom_wac.input)
>                 input_unregister_device(wacom->wacom_wac.input);
> +       if (wacom->wacom_wac.pad_input)
> +               input_unregister_device(wacom->wacom_wac.pad_input);
>         wacom_destroy_battery(wacom);
>         wacom_destroy_leds(wacom);
>         usb_free_urb(wacom->irq);
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 977d05c..4b16a34 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1489,8 +1489,11 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
>                 break;
>         }
>
> -       if (sync)
> +       if (sync) {
>                 input_sync(wacom_wac->input);
> +               if (wacom_wac->pad_input)
> +                       input_sync(wacom_wac->pad_input);
> +       }
>  }
>
>  static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
> @@ -1939,6 +1942,28 @@ int wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>         return 0;
>  }
>
> +int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
> +                                  struct wacom_wac *wacom_wac)
> +{
> +       struct wacom_features *features =3D &wacom_wac->features;
> +
> +       input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +
> +       /* kept for making legacy xf86-input-wacom working with the w=
heels */
> +       __set_bit(ABS_MISC, input_dev->absbit);
> +
> +       /* kept for making legacy xf86-input-wacom accepting the pad =
*/
> +       input_set_abs_params(input_dev, ABS_X, 0, 1, 0, 0);
> +       input_set_abs_params(input_dev, ABS_Y, 0, 1, 0, 0);
> +
> +       switch (features->type) {
> +       default:
> +               /* no pad supported */
> +               return 1;
> +       }
> +       return 0;
> +}
> +
>  static const struct wacom_features wacom_features_0x00 =3D
>         { "Wacom Penpartner",     WACOM_PKGLEN_PENPRTN,    5040,  378=
0,  255,
>           0, PENPARTNER, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES };
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index b2c9a9c..f48164c 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -150,6 +150,7 @@ struct wacom_shared {
>
>  struct wacom_wac {
>         char name[WACOM_NAME_MAX];
> +       char pad_name[WACOM_NAME_MAX];
>         unsigned char *data;
>         int tool[2];
>         int id[2];
> @@ -157,6 +158,7 @@ struct wacom_wac {
>         struct wacom_features features;
>         struct wacom_shared *shared;
>         struct input_dev *input;
> +       struct input_dev *pad_input;
>         int pid;
>         int battery_capacity;
>         int num_contacts_left;
> --
> 1.9.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
