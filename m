From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/3] HID: wacom: generic: add 3 tablet touch keys
Date: Thu, 16 Feb 2017 09:07:32 +0100
Message-ID: <CAN+gG=Es093cLmz=nUeYGmqZb6DYsgKCRbbfhm1XScRDC8OCPQ@mail.gmail.com>
References: <1487136381-5155-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34514 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbdBPIHe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 03:07:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so1826158wmi.1
        for <linux-input@vger.kernel.org>; Thu, 16 Feb 2017 00:07:34 -0800 (PST)
In-Reply-To: <1487136381-5155-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Wed, Feb 15, 2017 at 6:26 AM, Ping Cheng <pinglinux@gmail.com> wrote:
> This patch add support to the 3 touch keys on Wacom Cintiq Pro.
> These touch keys are in the middile of the other two keys on

typo: middile -> middle :)

> the top edge of the tablet.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

The series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/wacom_wac.c                | 12 ++++++++++++
>  drivers/hid/wacom_wac.h                |  3 +++
>  include/uapi/linux/input-event-codes.h |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index d51daf5..a0135ac 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1761,6 +1761,18 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
>                 wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
>                 features->device_type |= WACOM_DEVICETYPE_PAD;
>                 break;
> +       case WACOM_HID_WD_BUTTONCONFIG:
> +               wacom_map_usage(input, usage, field, EV_KEY, KEY_BUTTONCONFIG, 0);
> +               features->device_type |= WACOM_DEVICETYPE_PAD;
> +               break;
> +       case WACOM_HID_WD_ONSCREEN_KEYBOARD:
> +               wacom_map_usage(input, usage, field, EV_KEY, KEY_ONSCREEN_KEYBOARD, 0);
> +               features->device_type |= WACOM_DEVICETYPE_PAD;
> +               break;
> +       case WACOM_HID_WD_CONTROLPANEL:
> +               wacom_map_usage(input, usage, field, EV_KEY, KEY_CONTROLPANEL, 0);
> +               features->device_type |= WACOM_DEVICETYPE_PAD;
> +               break;
>         }
>
>         switch (equivalent_usage & 0xfffffff0) {
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 857ccee..5eba31d 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -120,6 +120,9 @@
>  #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
>  #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
>  #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
> +#define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
> +#define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER | 0x0983)
> +#define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER | 0x0986)
>  #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
>  #define WACOM_HID_WD_BUTTONUP           (WACOM_HID_UP_WACOMDIGITIZER | 0x0991)
>  #define WACOM_HID_WD_BUTTONDOWN         (WACOM_HID_UP_WACOMDIGITIZER | 0x0992)
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 3af60ee..f5a8d96 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -641,6 +641,7 @@
>   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>   */
>  #define KEY_DATA                       0x277
> +#define KEY_ONSCREEN_KEYBOARD          0x278
>
>  #define BTN_TRIGGER_HAPPY              0x2c0
>  #define BTN_TRIGGER_HAPPY1             0x2c0
> --
> 1.8.3.1
>
