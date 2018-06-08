From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: google: Add support for whiskers
Date: Fri, 8 Jun 2018 08:48:57 +0200
Message-ID: <CAO-hwJ+-h8r2x4ZRRwSEh_=PDphBhJML7v3FXJfjPYD0V4CcSA@mail.gmail.com>
References: <20180608001450.76836-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608001450.76836-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 8, 2018 at 2:14 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> Another device in the hammer class, with USB id 0x5030.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-google-hammer.c | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 7b8e17b03cb86..6bf4da7ad63a5 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -124,6 +124,8 @@ static const struct hid_device_id hammer_devices[] = {
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, hammer_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index a85634fe033f0..c7981ddd87763 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -452,6 +452,7 @@
>  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE        0x5028
>  #define USB_DEVICE_ID_GOOGLE_STAFF     0x502b
>  #define USB_DEVICE_ID_GOOGLE_WAND      0x502d
> +#define USB_DEVICE_ID_GOOGLE_WHISKERS  0x5030
>
>  #define USB_VENDOR_ID_GOTOP            0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2         0x007f
> --
> 2.18.0.rc1.242.g61856ae69a-goog
>
