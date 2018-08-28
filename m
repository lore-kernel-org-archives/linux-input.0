From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] [v2] HID: add support for Apple Magic Keyboards
Date: Tue, 28 Aug 2018 09:09:36 +0200
Message-ID: <CAO-hwJJRzdtOXxWrTC62M81jAD747Snvq9SkuC7YYAH0A4E36A@mail.gmail.com>
References: <20180827200215.172838-1-seobrien@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827200215.172838-1-seobrien@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: seobrien@chromium.org
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 27, 2018 at 10:02 PM Sean O'Brien <seobrien@chromium.org> wrote:
>
> USB device
>         Vendor 05ac (Apple)
>         Device 026c (Magic Keyboard with Numeric Keypad)
>
> Bluetooth devices
>         Vendor 004c (Apple)
>         Device 0267 (Magic Keyboard)
>         Device 026c (Magic Keyboard with Numeric Keypad)
>
> Support already exists for the Magic Keyboard over USB connection.
> Add support for the Magic Keyboard over Bluetooth connection, and for
> the Magic Keyboard with Numeric Keypad over Bluetooth and USB
> connection.
>
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> ---

Looks good now.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

However, now that I read it, I believe the quirk APPLE_HAS_FN could be
autodetected or at least renamed to something better (or inverted to
not have 80% of the devices that need it). Anyway, that's for someone
who will want to do it, I am not requesting this to be changed.

Cheers,
Benjamin

>
>  drivers/hid/hid-apple.c | 9 ++++++++-
>  drivers/hid/hid-ids.h   | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 25b7bd56ae11..1cb41992aaa1 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                 struct hid_field *field, struct hid_usage *usage,
>                 unsigned long **bit, int *max)
>  {
> -       if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
> +       if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
> +                       usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
>                 /* The fn key on Apple USB keyboards */
>                 set_bit(EV_REP, hi->input->evbit);
>                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
> @@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
>                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
>                 .driver_data = APPLE_HAS_FN },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
>                 .driver_data = APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 79bdf0c7e351..5dbe3fb82690 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -88,6 +88,7 @@
>  #define USB_DEVICE_ID_ANTON_TOUCH_PAD  0x3101
>
>  #define USB_VENDOR_ID_APPLE            0x05ac
> +#define BT_VENDOR_ID_APPLE             0x004c
>  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE        0x0304
>  #define USB_DEVICE_ID_APPLE_MAGICMOUSE 0x030d
>  #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD      0x030e
> @@ -157,6 +158,7 @@
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
>  #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
> +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI   0x0290
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO    0x0291
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS    0x0292
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
