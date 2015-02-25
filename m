From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2 2/2] HID: wacom: add full support of the Wacom Bamboo PAD
Date: Wed, 25 Feb 2015 13:39:12 -0800
Message-ID: <CAF8JNhL-64sZPNP64O-jbEbZsRgcwA3itB_rbEW11321rubtuA@mail.gmail.com>
References: <1424882620-22733-1-git-send-email-benjamin.tissoires@redhat.com>
	<1424882620-22733-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:38288 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBYVjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 16:39:13 -0500
In-Reply-To: <1424882620-22733-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: josep.sanchez.ferreres@est.fib.upc.edu, ACHARD.Frederic.frederic.achard@free.fr, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Feb 25, 2015 at 8:43 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> The stylus of this device works just fine out of the box.
> The touch is seen by default as a mouse with relative events and some
> gestures.
> The wireless and the wired version have slightly different firmwares, but
> the debug mode 2 on the feature 2 is common to the 2 devices. In this mode,
> all the reports are emitted through the debug interface (pen, raw touch
> and mouse emulation), so we have to re-route manually the events.
>
> We keep the Pen interface as a HID_GENERIC one because it works, and only
> parse the raw touches while discarding the mouse emulation & gestures.
>
> Switching the default in raw mode allows us to have a consistent user
> experience accross all the multitouch touchpads (and enable the touch part
> of the devices).
>
> Note that the buttons of this devices are reported through the touch
> interface. There is no 'Pad' interface. It seemed more natural to have
> the BTN_LEFT and BTN_RIGHT reported with the touch because they are
> placed under the touch interface and it looks like they belong to the
> touch part.
>
> Tested-by: Josep Sanchez Ferreres <josep.sanchez.ferreres@est.fib.upc.edu>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c |  24 ++++++++++++
>  drivers/hid/wacom_wac.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/wacom_wac.h |   5 +++
>  3 files changed, 129 insertions(+)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b3c2395..957699f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -406,6 +406,9 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
>                 else if (features->type == WACOM_27QHDT) {
>                         return wacom_set_device_mode(hdev, 131, 3, 2);
>                 }
> +               else if (features->type == BAMBOO_PAD) {
> +                       return wacom_set_device_mode(hdev, 2, 2, 2);
> +               }
>         } else if (features->device_type == BTN_TOOL_PEN) {
>                 if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
>                         return wacom_set_device_mode(hdev, 2, 2, 2);
> @@ -1425,6 +1428,21 @@ static int wacom_probe(struct hid_device *hdev,
>                         goto fail_allocate_inputs;
>         }
>
> +       /*
> +        * Bamboo Pad has a generic hid handling for the Pen, and we switch it
> +        * into debug mode for the touch part.
> +        * We ignore the other interfaces.
> +        */
> +       if (features->type == BAMBOO_PAD) {
> +               if (features->pktlen == WACOM_PKGLEN_PENABLED) {
> +                       features->type = HID_GENERIC;
> +               } else if ((features->pktlen != WACOM_PKGLEN_BPAD_TOUCH) &&
> +                          (features->pktlen != WACOM_PKGLEN_BPAD_TOUCH_USB)) {
> +                       error = -ENODEV;
> +                       goto fail_shared_data;
> +               }
> +       }
> +
>         /* set the default size in case we do not get them from hid */
>         wacom_set_default_phy(features);
>
> @@ -1459,6 +1477,12 @@ static int wacom_probe(struct hid_device *hdev,
>                 features->y_max = 4096;
>         }
>
> +       /*
> +        * Same thing for Bamboo PAD
> +        */
> +       if (features->type == BAMBOO_PAD)
> +               features->device_type = BTN_TOOL_FINGER;
> +
>         if (hdev->bus == BUS_BLUETOOTH)
>                 features->quirks |= WACOM_QUIRK_BATTERY;
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 16e8d28..ff693a6 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1826,6 +1826,87 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
>         return 0;
>  }
>
> +static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
> +               unsigned char *data)
> +{
> +       unsigned char prefix;
> +
> +       /*
> +        * We need to reroute the event from the debug interface to the
> +        * pen interface.
> +        * We need to add the report ID to the actual pen report, so we
> +        * temporary overwrite the first byte to prevent having to kzalloc/kfree
> +        * and memcpy the report.
> +        */
> +       prefix = data[0];
> +       data[0] = WACOM_REPORT_BPAD_PEN;
> +
> +       /*
> +        * actually reroute the event.
> +        * No need to check if wacom->shared->pen is valid, hid_input_report()
> +        * will check for us.
> +        */
> +       hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
> +                        WACOM_PKGLEN_PENABLED, 1);
> +
> +       data[0] = prefix;
> +}
> +
> +static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
> +               unsigned char *data)
> +{
> +       struct input_dev *input = wacom->input;
> +       unsigned char *finger_data, prefix;
> +       unsigned id;
> +       int x, y;
> +       bool valid;
> +
> +       prefix = data[0];
> +
> +       for (id = 0; id < wacom->features.touch_max; id++) {
> +               valid = !!(prefix & BIT(id)) &&
> +                       !wacom->shared->stylus_in_proximity;

stylus_in_proximity should be updated in wacom_bamboo_pad_pen_event()
for the above statement to be sensible.

> +
> +               input_mt_slot(input, id);
> +               input_mt_report_slot_state(input, MT_TOOL_FINGER, valid);
> +
> +               if (!valid)
> +                       continue;
> +
> +               finger_data = data + 1 + id * 3;
> +               x = finger_data[0] | ((finger_data[1] & 0x0f) << 8);
> +               y = (finger_data[2] << 4) | (finger_data[1] >> 4);
> +
> +               input_report_abs(input, ABS_MT_POSITION_X, x);
> +               input_report_abs(input, ABS_MT_POSITION_Y, y);
> +       }
> +
> +       input_mt_sync_frame(input);
> +
> +       input_report_key(input, BTN_LEFT, prefix & 0x40);
> +       input_report_key(input, BTN_RIGHT, prefix & 0x80);

We need to set touch_down here so pen events won't be posted before
touch is forced up.

Everything else looks good to me.

Thanks,

Ping

> +
> +       return 1;
> +}
> +
> +static int wacom_bamboo_pad_irq(struct wacom_wac *wacom, size_t len)
> +{
> +       unsigned char *data = wacom->data;
> +
> +       if (!((len == WACOM_PKGLEN_BPAD_TOUCH) ||
> +             (len == WACOM_PKGLEN_BPAD_TOUCH_USB)) ||
> +           (data[0] != WACOM_REPORT_BPAD_TOUCH))
> +               return 0;
> +
> +       if (data[1] & 0x01)
> +               wacom_bamboo_pad_pen_event(wacom, &data[1]);
> +
> +       if (data[1] & 0x02)
> +               return wacom_bamboo_pad_touch_event(wacom, &data[9]);
> +
> +       return 0;
> +}
> +
>  static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
>  {
>         unsigned char *data = wacom->data;
> @@ -1962,6 +2043,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>                 sync = wacom_bpt_irq(wacom_wac, len);
>                 break;
>
> +       case BAMBOO_PAD:
> +               sync = wacom_bamboo_pad_irq(wacom_wac, len);
> +               break;
> +
>         case WIRELESS:
>                 sync = wacom_wireless_irq(wacom_wac, len);
>                 break;
> @@ -2300,6 +2385,13 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
>                                               0, 0);
>                 }
>                 break;
> +       case BAMBOO_PAD:
> +               __clear_bit(ABS_MISC, input_dev->absbit);
> +               input_mt_init_slots(input_dev, features->touch_max,
> +                                   INPUT_MT_POINTER);
> +               __set_bit(BTN_LEFT, input_dev->keybit);
> +               __set_bit(BTN_RIGHT, input_dev->keybit);
> +               break;
>         }
>         return 0;
>  }
> @@ -2953,6 +3045,12 @@ static const struct wacom_features wacom_features_0x30C =
>         { "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
>           .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30A, .touch_max = 10,
>           .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
> +static const struct wacom_features wacom_features_0x318 =
> +       { "Wacom USB Bamboo PAD", 4095, 4095, /* Touch */
> +         .type = BAMBOO_PAD, 35, 48, .touch_max = 4 };
> +static const struct wacom_features wacom_features_0x319 =
> +       { "Wacom Wireless Bamboo PAD", 4095, 4095, /* Touch */
> +         .type = BAMBOO_PAD, 35, 48, .touch_max = 4 };
>  static const struct wacom_features wacom_features_0x323 =
>         { "Wacom Intuos P M", 21600, 13500, 1023, 31,
>           INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
> @@ -3105,6 +3203,8 @@ const struct hid_device_id wacom_ids[] = {
>         { USB_DEVICE_WACOM(0x314) },
>         { USB_DEVICE_WACOM(0x315) },
>         { USB_DEVICE_WACOM(0x317) },
> +       { USB_DEVICE_WACOM(0x318) },
> +       { USB_DEVICE_WACOM(0x319) },
>         { USB_DEVICE_WACOM(0x323) },
>         { USB_DEVICE_WACOM(0x32A) },
>         { USB_DEVICE_WACOM(0x32B) },
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index e42efbe..a3d0828 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -33,6 +33,8 @@
>  #define WACOM_PKGLEN_MTTPC     40
>  #define WACOM_PKGLEN_DTUS      68
>  #define WACOM_PKGLEN_PENABLED   8
> +#define WACOM_PKGLEN_BPAD_TOUCH        32
> +#define WACOM_PKGLEN_BPAD_TOUCH_USB    64
>
>  /* wacom data size per MT contact */
>  #define WACOM_BYTES_PER_MT_PACKET      11
> @@ -67,6 +69,8 @@
>  #define WACOM_REPORT_24HDT             1
>  #define WACOM_REPORT_WL                        128
>  #define WACOM_REPORT_USB               192
> +#define WACOM_REPORT_BPAD_PEN          3
> +#define WACOM_REPORT_BPAD_TOUCH                16
>
>  /* device quirks */
>  #define WACOM_QUIRK_MULTI_INPUT                0x0001
> @@ -122,6 +126,7 @@ enum {
>         BAMBOO_PT,
>         WACOM_24HDT,
>         WACOM_27QHDT,
> +       BAMBOO_PAD,
>         TABLETPC,   /* add new TPC below */
>         TABLETPCE,
>         TABLETPC2FG,
> --
> 2.1.0
>
