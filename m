From: Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH v2] HID: google: add google hammer HID driver
Date: Fri, 1 Sep 2017 09:58:43 -0700
Message-ID: <CAE_wzQ-isUWNk602pySa9oDM4DfJk=wUta8qMp8iv+MXC+9s2w@mail.gmail.com>
References: <20170817084508.22718-1-wnhuang@google.com> <CAE_wzQ_t5+9JwsOw-Wm9OpFpLZ5jPuo172t+7GwRu0S0Tg98ow@mail.gmail.com>
 <CABicQ-XHPqXX0kJ=WKrFqdhMbV7zwEaOPEZ0Y=6HHOMqxC1KTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABicQ-XHPqXX0kJ=WKrFqdhMbV7zwEaOPEZ0Y=6HHOMqxC1KTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei-Ning Huang <wnhuang@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 17, 2017 at 8:33 PM, Wei-Ning Huang <wnhuang@google.com> wrote:
> + Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Jiri, there are some unwanted interactions between hid-multitouch and
this driver, please hold off applying it (if you were considering it).

Thanks!

>
> On Fri, Aug 18, 2017 at 2:35 AM, Dmitry Torokhov <dtor@google.com> wrote:
>> On Thu, Aug 17, 2017 at 1:45 AM, Wei-Ning Huang <wnhuang@chromium.org> w=
rote:
>>> Add Google hammer HID driver. This driver allow us to control hammer
>>> keyboard backlights and support future features.
>>>
>>> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
>>
>> I was helping Wei-Ning internally with this, so
>>
>> Reviewed-by: Dmitry Torokhov <dtor@google.com>
>>
>> You might need to resend to directly to Jiri who is HID maintainer.
>>
>>> ---
>>>  drivers/hid/Kconfig             |   6 +++
>>>  drivers/hid/Makefile            |   1 +
>>>  drivers/hid/hid-core.c          |   4 ++
>>>  drivers/hid/hid-google-hammer.c | 108 ++++++++++++++++++++++++++++++++=
++++++++
>>>  drivers/hid/hid-ids.h           |   3 ++
>>>  5 files changed, 122 insertions(+)
>>>  create mode 100644 drivers/hid/hid-google-hammer.c
>>>
>>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>>> index 3cd60f460b61..efc71acbcf5b 100644
>>> --- a/drivers/hid/Kconfig
>>> +++ b/drivers/hid/Kconfig
>>> @@ -329,6 +329,12 @@ config HOLTEK_FF
>>>           Say Y here if you have a Holtek On Line Grip based game contr=
oller
>>>           and want to have force feedback support for it.
>>>
>>> +config HID_GOOGLE_HAMMER
>>> +       tristate "Google Hammer Keyboard"
>>> +       depends on USB_HID && LEDS_CLASS
>>> +       ---help---
>>> +       Say Y here if you have a Google Hammer device.
>>> +
>>>  config HID_GT683R
>>>         tristate "MSI GT68xR LED support"
>>>         depends on LEDS_CLASS && USB_HID
>>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>>> index 8659d7e633a5..b5d3039286e3 100644
>>> --- a/drivers/hid/Makefile
>>> +++ b/drivers/hid/Makefile
>>> @@ -43,6 +43,7 @@ obj-$(CONFIG_HID_ELO)         +=3D hid-elo.o
>>>  obj-$(CONFIG_HID_EZKEY)                +=3D hid-ezkey.o
>>>  obj-$(CONFIG_HID_GEMBIRD)      +=3D hid-gembird.o
>>>  obj-$(CONFIG_HID_GFRM)         +=3D hid-gfrm.o
>>> +obj-$(CONFIG_HID_GOOGLE_HAMMER)        +=3D hid-google-hammer.o
>>>  obj-$(CONFIG_HID_GT683R)       +=3D hid-gt683r.o
>>>  obj-$(CONFIG_HID_GYRATION)     +=3D hid-gyration.o
>>>  obj-$(CONFIG_HID_HOLTEK)       +=3D hid-holtek-kbd.o
>>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> index 9017dcc14502..813e3d86e2d0 100644
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -2049,6 +2049,10 @@ static const struct hid_device_id hid_have_speci=
al_driver[] =3D {
>>>          { HID_BLUETOOTH_DEVICE(0x58, 0x2000) },
>>>          { HID_BLUETOOTH_DEVICE(0x471, 0x2210) },
>>>  #endif
>>> +#if IS_ENABLED(CONFIG_HID_GOOGLE_HAMMER)
>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAM=
MER) },
>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STA=
FF) },
>>> +#endif
>>>  #if IS_ENABLED(CONFIG_HID_GREENASIA)
>>>         { HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
>>>  #endif
>>> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-h=
ammer.c
>>> new file mode 100644
>>> index 000000000000..b6955f01c656
>>> --- /dev/null
>>> +++ b/drivers/hid/hid-google-hammer.c
>>> @@ -0,0 +1,108 @@
>>> +/*
>>> + *  HID driver for Google Hammer device.
>>> + *
>>> + *  Copyright (c) 2017 Google Inc.
>>> + *  Author: Wei-Ning Huang <wnhuang@google.com>
>>> + */
>>> +
>>> +/*
>>> + * This program is free software; you can redistribute it and/or modif=
y it
>>> + * under the terms of the GNU General Public License as published by t=
he Free
>>> + * Software Foundation; either version 2 of the License, or (at your o=
ption)
>>> + * any later version.
>>> + */
>>> +
>>> +#include <linux/hid.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/module.h>
>>> +#include <linux/usb.h>
>>> +
>>> +#include "hid-ids.h"
>>> +
>>> +#define MAX_BRIGHTNESS 100
>>> +
>>> +struct hammer_kbd_leds {
>>> +       struct led_classdev cdev;
>>> +       struct hid_device *hdev;
>>> +       u8 buf[2] ____cacheline_aligned;
>>> +};
>>> +
>>> +static int hammer_kbd_brightness_set_blocking(struct led_classdev *cde=
v,
>>> +               enum led_brightness br)
>>> +{
>>> +       struct hammer_kbd_leds *led =3D container_of(cdev,
>>> +                                                  struct hammer_kbd_le=
ds,
>>> +                                                  cdev);
>>> +       int ret;
>>> +
>>> +       led->buf[0] =3D 0;
>>> +       led->buf[1] =3D br;
>>> +
>>> +       ret =3D hid_hw_output_report(led->hdev, led->buf, sizeof(led->b=
uf));
>>> +       if (ret =3D=3D -ENOSYS)
>>> +               ret =3D hid_hw_raw_request(led->hdev, 0, led->buf,
>>> +                                        sizeof(led->buf),
>>> +                                        HID_OUTPUT_REPORT,
>>> +                                        HID_REQ_SET_REPORT);
>>> +       if (ret < 0)
>>> +               hid_err(led->hdev, "failed to set keyboard backlight: %=
d\n",
>>> +                       ret);
>>> +       return ret;
>>> +}
>>> +
>>> +static int hammer_register_leds(struct hid_device *hdev)
>>> +{
>>> +       struct hammer_kbd_leds *kbd_backlight;
>>> +
>>> +       kbd_backlight =3D devm_kzalloc(&hdev->dev,
>>> +                                    sizeof(*kbd_backlight),
>>> +                                    GFP_KERNEL);
>>> +       if (!kbd_backlight)
>>> +               return -ENOMEM;
>>> +
>>> +       kbd_backlight->hdev =3D hdev;
>>> +       kbd_backlight->cdev.name =3D "hammer::kbd_backlight";
>>> +       kbd_backlight->cdev.max_brightness =3D MAX_BRIGHTNESS;
>>> +       kbd_backlight->cdev.brightness_set_blocking =3D
>>> +               hammer_kbd_brightness_set_blocking;
>>> +       kbd_backlight->cdev.flags =3D LED_HW_PLUGGABLE;
>>> +
>>> +       /* Set backlight to 0% initially. */
>>> +       hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
>>> +
>>> +       return devm_led_classdev_register(&hdev->dev, &kbd_backlight->c=
dev);
>>> +}
>>> +
>>> +static int hammer_input_configured(struct hid_device *hdev,
>>> +                                  struct hid_input *hi)
>>> +{
>>> +       struct usb_interface *intf =3D to_usb_interface(hdev->dev.paren=
t);
>>> +
>>> +       if (intf->cur_altsetting->desc.bInterfaceProtocol =3D=3D
>>> +           USB_INTERFACE_PROTOCOL_KEYBOARD) {
>>> +               int err =3D hammer_register_leds(hdev);
>>> +
>>> +               if (err)
>>> +                       hid_warn(hdev,
>>> +                                "Failed to register keyboard backlight=
: %d\n",
>>> +                                err);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct hid_device_id hammer_devices[] =3D {
>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAM=
MER) },
>>> +       { HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STA=
FF) },
>>> +       { }
>>> +};
>>> +MODULE_DEVICE_TABLE(hid, hammer_devices);
>>> +
>>> +static struct hid_driver hammer_driver =3D {
>>> +       .name =3D "hammer",
>>> +       .id_table =3D hammer_devices,
>>> +       .input_configured =3D hammer_input_configured,
>>> +};
>>> +module_hid_driver(hammer_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index c9ba4c6db74c..193959700df8 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -434,7 +434,10 @@
>>>  #define USB_DEVICE_ID_GOODTOUCH_000f   0x000f
>>>
>>>  #define USB_VENDOR_ID_GOOGLE           0x18d1
>>> +#define USB_DEVICE_ID_GOOGLE_QUICKSTEP 0x0477
>>> +#define USB_DEVICE_ID_GOOGLE_HAMMER    0x5022
>>>  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE        0x5028
>>> +#define USB_DEVICE_ID_GOOGLE_STAFF     0x502b
>>>
>>>  #define USB_VENDOR_ID_GOTOP            0x08f2
>>>  #define USB_DEVICE_ID_SUPER_Q2         0x007f
>>> --
>>> 2.12.2
>>>
>
>
>
> --
> Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google I=
nc., Taiwan |
> wnhuang@google.com | Cell: +886 910-380678
