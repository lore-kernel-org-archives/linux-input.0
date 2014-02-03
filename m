From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 3/6] HID: sony: Add Bluetooth output report formatting
Date: Mon, 3 Feb 2014 17:29:06 +0100
Message-ID: <CANq1E4Q8OcKPW66=zTXh0bEsKbDvn1ntpyBDZLHChTdYYZhNQw@mail.gmail.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
	<1391102648-19381-4-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:58988 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbaBCQ3H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 11:29:07 -0500
Received: by mail-ie0-f176.google.com with SMTP id tp5so6402784ieb.35
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 08:29:06 -0800 (PST)
In-Reply-To: <1391102648-19381-4-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Thu, Jan 30, 2014 at 6:24 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add formatting and reporting for Dualshock 4 output reports on Bluetooth.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>
> ---
>  drivers/hid/hid-sony.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 52162a9..4d12b4e 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1268,11 +1268,18 @@ static void dualshock4_state_worker(struct work_struct *work)
>         struct hid_device *hdev = sc->hdev;
>         int offset;
>
> -       __u8 buf[32] = { 0 };
> +       __u8 buf[78] = { 0 };
>
> -       buf[0] = 0x05;
> -       buf[1] = 0x03;
> -       offset = 4;
> +       if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> +               buf[0] = 0x05;
> +               buf[1] = 0x03;
> +               offset = 4;
> +       } else {
> +               buf[0] = 0x11;
> +               buf[1] = 0xB0;
> +               buf[3] = 0x0F;
> +               offset = 6;
> +       }
>
>  #ifdef CONFIG_SONY_FF
>         buf[offset++] = sc->right;
> @@ -1285,7 +1292,11 @@ static void dualshock4_state_worker(struct work_struct *work)
>         buf[offset++] = sc->led_state[1];
>         buf[offset++] = sc->led_state[2];
>
> -       hdev->ll_driver->output_report(hdev, buf, sizeof(buf));
> +       if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
> +               hdev->ll_driver->output_report(hdev, buf, 32);
> +       else
> +               hdev->ll_driver->raw_request(hdev, 0x11, buf, 78,
> +                               HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);

Ok, now I get it. The USB stuff takes output-reports and BT uses
SET_REPORT. That's exactly the inverse of wiimotes.

>  }
>
>  #ifdef CONFIG_SONY_FF
> @@ -1482,10 +1493,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
>                 ret = sixaxis_set_operational_bt(hdev);
>         else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> -               if (hdev->ll_driver->output_report == NULL) {
> +               if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) &&
> +                    hdev->ll_driver->output_report == NULL) {
>                         hid_err(hdev, "NULL output_report handler\n");
>                         ret = -EINVAL;
>                         goto err_stop;
> +               } else if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) &&
> +                           hdev->ll_driver->raw_request == NULL) {
> +                       hid_err(hdev, "NULL raw_request handler\n");
> +                       ret = -EINVAL;
> +                       goto err_stop;

If you rebase your patches on Benjamins series, you can use
hid_hw_output_report() and hid_hw_raw_request() which already to the
NULL check. So you can drop this stuff here.

Thanks
David

>                 }
>
>                 /* The Dualshock 4 touchpad supports 2 touches and has a
> --
> 1.8.5.3
>
