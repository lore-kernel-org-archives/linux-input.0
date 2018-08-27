From: "Sean O'Brien" <seobrien@google.com>
Subject: Re: [PATCH] HID: add support for Apple Magic Keyboards
Date: Mon, 27 Aug 2018 12:39:15 -0700
Message-ID: <CABBVx+CnSzemH5+o1XMq+aHfymBwh3QEm5mCV3TRTvL0mpxCKQ@mail.gmail.com>
References: <20180823164005.201582-1-seobrien@chromium.org> <CAO-hwJLegX7Uuw8WSErg8W7L0jXj7v2RGiABnrujLonHBYRrog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLegX7Uuw8WSErg8W7L0jXj7v2RGiABnrujLonHBYRrog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: seobrien@chromium.org, jikos@kernel.org, dtor@chromium.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 27, 2018 at 5:19 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Sean,
>
> On Thu, Aug 23, 2018 at 6:40 PM Sean O'Brien <seobrien@chromium.org> wrote:
> >
> > USB device
> >         Vendor 05ac (Apple)
> >         Device 026c (Magic Keyboard with Numeric Keypad)
> >
> > Bluetooth devices
> >         Vendor 004c (Apple)
> >         Device 0267 (Magic Keyboard)
> >         Device 026c (Magic Keyboard with Numeric Keypad)
> >
> > Support already exists for the Magic Keyboard over USB connection.
> > This patch adds support for the Magic Keyboard over Bluetooth
> > connection, and for the Magic Keyboard with Numeric Keypad over
> > Bluetooth and USB connection.
> >
> > Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> > ---
> >
> >  drivers/hid/hid-apple.c  | 9 ++++++++-
> >  drivers/hid/hid-ids.h    | 2 ++
> >  drivers/hid/hid-quirks.c | 3 +++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 25b7bd56ae11..1cb41992aaa1 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >                 struct hid_field *field, struct hid_usage *usage,
> >                 unsigned long **bit, int *max)
> >  {
> > -       if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
> > +       if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
> > +                       usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
> >                 /* The fn key on Apple USB keyboards */
> >                 set_bit(EV_REP, hi->input->evbit);
> >                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
> > @@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
> >                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> >                 .driver_data = APPLE_HAS_FN },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
> >                 .driver_data = APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 79bdf0c7e351..5dbe3fb82690 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -88,6 +88,7 @@
> >  #define USB_DEVICE_ID_ANTON_TOUCH_PAD  0x3101
> >
> >  #define USB_VENDOR_ID_APPLE            0x05ac
> > +#define BT_VENDOR_ID_APPLE             0x004c
> >  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE        0x0304
> >  #define USB_DEVICE_ID_APPLE_MAGICMOUSE 0x030d
> >  #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD      0x030e
> > @@ -157,6 +158,7 @@
> >  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
> >  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
> >  #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
> > +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI   0x0290
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO    0x0291
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS    0x0292
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > index 249d49b6b16c..a3b3aecf8628 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -270,6 +270,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
>
> Unless the device doesn't work without this hunk, please drop this
> from the submission. Since v4.16 this is not required anymore and is
> doomed to be removed.
>

I'll do that.  Thank you.

> Cheers,
> Benjamin
>
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
> >  #endif
> > --
> > 2.18.0.1017.ga543ac7ca45-goog
> >
