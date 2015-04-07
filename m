From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Tue, 7 Apr 2015 08:42:57 -0700
Message-ID: <CAKdAkRS=j4sOCDNVKzr7di2wh2XWDCF8ZC7sTXAa05NPdqJPmA@mail.gmail.com>
References: <1428399169.9694.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33751 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbbDGPm7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Apr 2015 11:42:59 -0400
Received: by lbbzk7 with SMTP id zk7so45850421lbb.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2015 08:42:57 -0700 (PDT)
In-Reply-To: <1428399169.9694.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Fleig <andreasfleig@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Andreas,

On Tue, Apr 7, 2015 at 2:32 AM, Andreas Fleig <andreasfleig@gmail.com> wrote:
> Set flags INPUT_PROP_POINTER and INPUT_PROP_POINTING_STICK for the
> trackpoint integrated in Lenovo USB and Bluetooth keyboards. Libinput checks
> these flags to enable features such as middle-button-scrolling by default.
>
> Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
> Cc: Peter Hutterer <peter.hutterer@who-t.net>
>
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index c4c3f09..4cb7235 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -762,6 +762,16 @@ static void lenovo_remove(struct hid_device *hdev)
>         hid_hw_stop(hdev);
> }
>
> +static void lenovo_input_configured(struct hid_device *hdev,
> +               struct hid_input *hi)
> +{
> +       if (*hi->input->ledbit == 0) {

Without commenting on validity of making this decision based on
presence or absence of LEDs the proper test would be:

        if (!test_bit(EV_LED, hi->input->evbit)) {
                ...
        }

> +               /* set only for trackpoint device, identify by missing LEDs
> */
> +               __set_bit(INPUT_PROP_POINTER, hi->input->propbit);
> +               __set_bit(INPUT_PROP_POINTING_STICK, hi->input->propbit);
> +       }
> +}
> +
> static const struct hid_device_id lenovo_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD)
> },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD)
> },
> @@ -774,6 +784,7 @@ MODULE_DEVICE_TABLE(hid, lenovo_devices);
> static struct hid_driver lenovo_driver = {
>         .name = "lenovo",
>         .id_table = lenovo_devices,
> +       .input_configured = lenovo_input_configured,
>         .input_mapping = lenovo_input_mapping,
>         .probe = lenovo_probe,
>         .remove = lenovo_remove,
>

Thanks.

-- 
Dmitry
