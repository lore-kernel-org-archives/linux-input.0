From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/6] HID: hid-logitech-hidpp: Add basic support for
 Logitech G920
Date: Mon, 9 Nov 2015 09:11:11 +0100
Message-ID: <CAN+gG=Hi5PG+-pLqVr5KQeSdM_51yurvg4FrU4tjuSSLa332_w@mail.gmail.com>
References: <1446912609-2573-1-git-send-email-simon@mungewell.org>
	<1446912609-2573-4-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32776 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbKIILN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 03:11:13 -0500
In-Reply-To: <1446912609-2573-4-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Simon,

On Sat, Nov 7, 2015 at 5:10 PM, Simon Wood <simon@mungewell.org> wrote:
> This patch adds basic support for the Logitech G920 wheel when in HID
> mode. This wheel 'speaks' the HID++ protocol, and therefor is driven
> with hid-logitech-hidpp.
>
> At this stage the driver only shows that it can communicate with the
> wheel by outputting the name discovered over HID++.
>
> The normal HID functions work to give input functionality using
> joystick/event interface.
>
> Signed-off-by: Simon Wood <simon@mungewell.org>

Just 2 nitpicks:

> ---
>  drivers/hid/hid-core.c           |  1 +
>  drivers/hid/hid-ids.h            |  1 +
>  drivers/hid/hid-logitech-hidpp.c | 69 +++++++++++++++++++++++++++++++---------
>  3 files changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index bcd914a..60d564d 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1896,6 +1896,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index f769208..d3500c4 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -614,6 +614,7 @@
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2      0xc218
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2    0xc219
>  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL       0xc24f
> +#define USB_DEVICE_ID_LOGITECH_G920_WHEEL      0xc262
>  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D     0xc283
>  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO     0xc286
>  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940      0xc287
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 08e65e8..dbb9ff3 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -49,11 +49,13 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_CLASS_WTP                  BIT(0)
>  #define HIDPP_QUIRK_CLASS_M560                 BIT(1)
>  #define HIDPP_QUIRK_CLASS_K400                 BIT(2)
> +#define HIDPP_QUIRK_CLASS_G920                 BIT(3)
>
>  /* bits 2..20 are reserved for classes */
>  #define HIDPP_QUIRK_CONNECT_EVENTS             BIT(21)
>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS       BIT(22)
>  #define HIDPP_QUIRK_NO_HIDINPUT                        BIT(23)
> +#define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS       BIT(24)
>
>  #define HIDPP_QUIRK_DELAYED_INIT               (HIDPP_QUIRK_NO_HIDINPUT | \
>                                                  HIDPP_QUIRK_CONNECT_EVENTS)
> @@ -146,8 +148,11 @@ static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
>  static int __hidpp_send_report(struct hid_device *hdev,
>                                 struct hidpp_report *hidpp_report)
>  {
> +       struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>         int fields_count, ret;
>
> +       hidpp = hid_get_drvdata(hdev);
> +
>         switch (hidpp_report->report_id) {
>         case REPORT_ID_HIDPP_SHORT:
>                 fields_count = HIDPP_REPORT_SHORT_LENGTH;
> @@ -168,9 +173,13 @@ static int __hidpp_send_report(struct hid_device *hdev,
>          */
>         hidpp_report->device_index = 0xff;
>
> -       ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
> -               (u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
> -               HID_REQ_SET_REPORT);
> +       if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
> +               ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
> +       } else {
> +               ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
> +                       (u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
> +                       HID_REQ_SET_REPORT);
> +       }
>
>         return ret == fields_count ? 0 : -1;
>  }
> @@ -1430,8 +1439,10 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
>
>         if (!name)
>                 hid_err(hdev, "unable to retrieve the name of the device");
> -       else

Put braces under the "if" statement too (kernel coding style IIRC).

> +       else {
> +               dbg_hid("HID++: Got name: %s\n", name);
>                 snprintf(hdev->name, sizeof(hdev->name), "%s", name);
> +       }
>
>         kfree(name);
>  }
> @@ -1594,6 +1605,25 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 goto hid_parse_fail;
>         }
>
> +       if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> +               connect_mask &= ~HID_CONNECT_HIDINPUT;
> +
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> +               ret = hid_hw_start(hdev, connect_mask);
> +               if (ret) {
> +                       hid_err(hdev, "hw start failed\n");
> +                       goto hid_hw_start_fail;
> +               }
> +               ret = hid_hw_open(hdev);
> +               if (ret < 0) {
> +                       dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
> +                               __func__, ret);
> +                       hid_hw_stop(hdev);
> +                       goto hid_hw_start_fail;
> +               }
> +       }
> +

This is fine, but please mention this in the commit message. We might
even need this for all USB devices not using the unifying protocol.
Better noting that in the commit message so that in the future we do
not enumerate each and every classes of USB devices not using
unifying.
For now, I think it is OK to keep it that way until we see more devices.


Cheers,
Benjamin

> +
>         /* Allow incoming packets */
>         hid_device_io_start(hdev);
>
> @@ -1602,8 +1632,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 if (!connected) {
>                         ret = -ENODEV;
>                         hid_err(hdev, "Device not connected");
> -                       hid_device_io_stop(hdev);
> -                       goto hid_parse_fail;
> +                       goto hid_hw_open_failed;
>                 }
>
>                 hid_info(hdev, "HID++ %u.%u device connected.\n",
> @@ -1616,19 +1645,18 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
>                 ret = wtp_get_config(hidpp);
>                 if (ret)
> -                       goto hid_parse_fail;
> +                       goto hid_hw_open_failed;
>         }
>
>         /* Block incoming packets */
>         hid_device_io_stop(hdev);
>
> -       if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> -               connect_mask &= ~HID_CONNECT_HIDINPUT;
> -
> -       ret = hid_hw_start(hdev, connect_mask);
> -       if (ret) {
> -               hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> -               goto hid_hw_start_fail;
> +       if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
> +               ret = hid_hw_start(hdev, connect_mask);
> +               if (ret) {
> +                       hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> +                       goto hid_hw_start_fail;
> +               }
>         }
>
>         if (hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) {
> @@ -1640,6 +1668,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>
>         return ret;
>
> +hid_hw_open_failed:
> +       hid_device_io_stop(hdev);
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> +               hid_hw_close(hdev);
> +               hid_hw_stop(hdev);
> +       }
>  hid_hw_start_fail:
>  hid_parse_fail:
>         cancel_work_sync(&hidpp->work);
> @@ -1653,9 +1687,11 @@ static void hidpp_remove(struct hid_device *hdev)
>  {
>         struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
> +               hid_hw_close(hdev);
> +       hid_hw_stop(hdev);
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> -       hid_hw_stop(hdev);
>  }
>
>  static const struct hid_device_id hidpp_devices[] = {
> @@ -1683,6 +1719,9 @@ static const struct hid_device_id hidpp_devices[] = {
>
>         { HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>                 USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
> +
> +       { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> +               .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
>         {}
>  };
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
