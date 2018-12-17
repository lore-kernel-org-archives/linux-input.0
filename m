From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: asus: Add support for the ASUS T101HA keyboard dock
Date: Mon, 17 Dec 2018 14:23:49 +0100
Message-ID: <CAO-hwJ+L_D98q5byOvYFiOxYgFEgJZ8s2xTe3Mb7R2UW8mhyOQ@mail.gmail.com>
References: <20181216155319.GA17189@arks.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216155319.GA17189@arks.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: kernelrocks@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, mbrugger@suse.com
List-Id: linux-input@vger.kernel.org

On Sun, Dec 16, 2018 at 4:52 PM Aleix Roca Nonell <kernelrocks@gmail.com> wrote:
>
> The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
> specific UsagePage 0xff31. In consequence, some multimedia keys such as
> brightness up and down are not working with hid-generic.
>
> This commit adds the T101HA dock into the supported device list of the
> hid-asus driver. It also prevents the dock's integrated touchpad to be
> bound with hid-asus given that it is already working fine with
> hid-multitouch.
>
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
>
> Changes in v2:
> - use the report descriptor's application usage to identify the dock's
>   touchpad instead of the usb interface id

Thanks for the quick respin.

Pushed into 4.21/hid-asus.

Cheers,
Benjamin

>
> drivers/hid/hid-asus.c | 8 ++++++++
> drivers/hid/hid-ids.h  | 1 +
> 2 files changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ab8bd40a77ed..951bb17ae8b2 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -70,6 +70,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_T100_KEYBOARD            BIT(6)
>  #define QUIRK_T100CHI                  BIT(7)
>  #define QUIRK_G752_KEYBOARD            BIT(8)
> +#define QUIRK_T101HA_DOCK              BIT(9)
>
>  #define I2C_KEYBOARD_QUIRKS                    (QUIRK_FIX_NOTEBOOK_REPORT | \
>                                                  QUIRK_NO_INIT_REPORTS | \
> @@ -699,6 +700,11 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 return ret;
>         }
>
> +       /* use hid-multitouch for T101HA touchpad */
> +       if (id->driver_data & QUIRK_T101HA_DOCK &&
> +           hdev->collection->usage == HID_GD_MOUSE)
> +               return -ENODEV;
> +
>         ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>         if (ret) {
>                 hid_err(hdev, "Asus hw start failed: %d\n", ret);
> @@ -830,6 +836,8 @@ static const struct hid_device_id asus_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>                 USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>           QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +               USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
>         { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4206428c0ba2..f1eee2778b70 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -184,6 +184,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD  0x17e0
>  #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD 0x1807
>  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD 0x8502
> +#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD  0x183d
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD    0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD     0x8585
>  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD     0x0101
> --
> 2.20.0
>
