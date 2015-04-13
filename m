From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Mon, 13 Apr 2015 13:23:28 -0400
Message-ID: <CAN+gG=G3NP-51vQEO5yJ40-c+YXbEdZoWFwVGraUexM1+uZ5-g@mail.gmail.com>
References: <1428485767.14997.1@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34071 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbDMRX3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 13:23:29 -0400
Received: by qkgx75 with SMTP id x75so188562582qkg.1
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2015 10:23:29 -0700 (PDT)
In-Reply-To: <1428485767.14997.1@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Fleig <andreasfleig@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Andreas,

[please do not forget to CC Jiri when submitting to HID, or your patch
will get lost]

On Wed, Apr 8, 2015 at 5:36 AM, Andreas Fleig <andreasfleig@gmail.com> wrote:
> Set flags INPUT_PROP_POINTER and INPUT_PROP_POINTING_STICK for the
> trackpoint integrated in Lenovo USB and Bluetooth keyboards. Libinput checks
> these flags to enable features such as middle-button-scrolling by default.
>
> Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
>
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index c4c3f09..c4da65d 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -762,6 +762,16 @@ static void lenovo_remove(struct hid_device *hdev)
>         hid_hw_stop(hdev);
> }
>
> +static void lenovo_input_configured(struct hid_device *hdev,
> +               struct hid_input *hi)
> +{
> +       if (test_bit(EV_REL, hi->input->evbit)) {

Are we sure that there is no other integrated mouse than the track point?
I would not like us to set INPUT_PROP_POINTING_STICK to other input
devices that should not have them.

If you are not sure, maybe test with the product ID so that we know
which ones are enabled/tested.

If there won't be any problem, then the patch is Reviewed-by: Benjamin
Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +               /* set only for trackpoint device */
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
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
