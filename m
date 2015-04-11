From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: Fix multitouch support for Type Cover 3
Date: Sat, 11 Apr 2015 10:08:53 -0400
Message-ID: <CAN+gG=E51Xy6gG93yh-sck7O6Uf7TQ2E_0+5RXujyJcWKbBFFw@mail.gmail.com>
References: <1428725871-4040-1-git-send-email-felipe.otamendi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428725871-4040-1-git-send-email-felipe.otamendi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Otamendi <felipe.otamendi@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Felipe,

On Sat, Apr 11, 2015 at 12:17 AM, Felipe Otamendi
<felipe.otamendi@gmail.com> wrote:
> Make the Type Cover 3 use the hid multitouch driver, which is better suited for the touchpad. Also, since it has multiple reports under the same interface, allow the generic hid driver to handle non-multitouch inputs such as the keyboard's.

IIRC, the point of having hid-microsoft was to have better support of
the keyboard special functions and shortcuts. Can you please confirm
that you do not lose any functionality?

>
> Signed-off-by: Felipe Otamendi <felipe.otamendi@gmail.com>
> ---
>  drivers/hid/hid-core.c       | 6 ++----
>  drivers/hid/hid-microsoft.c  | 3 ---
>  drivers/hid/hid-multitouch.c | 5 +++++
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 56ce8c2..5a80896 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -705,9 +705,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>                 hid->group = HID_GROUP_SENSOR_HUB;
>
>         if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
> -           (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
> -            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
> -           hid->group == HID_GROUP_MULTITOUCH)
> +               hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP &&
> +               hid->group == HID_GROUP_MULTITOUCH)
>                 hid->group = HID_GROUP_GENERIC;
>
>         if ((parser->global.usage_page << 16) == HID_UP_GENDESK)
> @@ -1878,7 +1877,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index af935eb..7e84463 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -276,11 +276,8 @@ static const struct hid_device_id ms_devices[] = {
>                 .driver_data = MS_NOGET },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
>                 .driver_data = MS_DUPLICATE_USAGES },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
> -               .driver_data = MS_HIDINPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
>                 .driver_data = MS_HIDINPUT },
> -

Please keep this line, it adds extra to the commit and might have been
put on purpose by the original author.

>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
>                 .driver_data = MS_PRESENTER },
>         { }
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f65e78b..d93c766 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1235,6 +1235,11 @@ static const struct hid_device_id mt_devices[] = {
>                 MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
>                         USB_DEVICE_ID_ILITEK_MULTITOUCH) },
>
> +       /* Microsoft Type Cover 3 */
> +       { .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
> +               MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +                       USB_DEVICE_ID_MS_TYPE_COVER_3) },
> +
>         /* MosArt panels */
>         { .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
>                 MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> --
> 2.1.0

I had a similar patch in my tree at the time when we were deciding
what to do for those devices.
This patch had an extra hunk (sorry gmail will cut the lines and everything):

--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -961,6 +961,9 @@ static void mt_input_configured(struct hid_device
*hdev, struct hid_input *hi)
                case HID_DG_TOUCHSCREEN:
                        /* we do not set suffix = "Touchscreen" */
                        break;
+               case HID_DG_TOUCHPAD:
+                       suffix = "Touchpad";
+                       break;
                case HID_GD_SYSTEM_CONTROL:
                        suffix = "System Control";
                        break;

Can you please test/add this with your current patch. Your touchpad
might appear as "UNKNOWN", which is not very appealing :)

Cheers,
Benjamin

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
