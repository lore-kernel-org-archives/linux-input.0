From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: [PATCH] HID: sony: Fix up nyko core controller
Date: Tue, 12 Dec 2017 18:02:56 -0800
Message-ID: <CAEc3jaD_oMqhppZg2BkbgtzDBtq=nUxxODxYcdqeFZoykvR6mQ@mail.gmail.com>
References: <1513126444-7675-1-git-send-email-oreaus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:38470 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753996AbdLMCC6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Dec 2017 21:02:58 -0500
Received: by mail-yw0-f175.google.com with SMTP id x199so306786ywg.5
        for <linux-input@vger.kernel.org>; Tue, 12 Dec 2017 18:02:57 -0800 (PST)
In-Reply-To: <1513126444-7675-1-git-send-email-oreaus@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Moreau <oreaus@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Alright looks good then.

Acked-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

On Tue, Dec 12, 2017 at 4:54 PM, Scott Moreau <oreaus@gmail.com> wrote:
> This fixes missing d-pad axis broken since e19a267b99. The axis mapping for
> the nyko controller has the d-pad as axis 0x39 instead of d-pad as buttons.
> This is handled by the default hid mapping so we return 0 in sony_mapping.
> This controller also has no accelerometer so avoid initializing it with
> a condition in sony_input_configured() to setup these controllers.
> ---
>  drivers/hid/hid-sony.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index b9dc3ac..1be0a35 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1225,6 +1225,9 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
>         if (sc->quirks & NAVIGATION_CONTROLLER)
>                 return navigation_mapping(hdev, hi, field, usage, bit, max);
>
> +       if (sc->quirks & SINO_LITE_CONTROLLER)
> +               return 0;
> +
>         if (sc->quirks & SIXAXIS_CONTROLLER)
>                 return sixaxis_mapping(hdev, hi, field, usage, bit, max);
>
> @@ -2566,6 +2569,10 @@ static int sony_input_configured(struct hid_device *hdev,
>                 }
>
>                 sony_init_output_report(sc, sixaxis_send_output_report);
> +       } else if (sc->quirks & SINO_LITE_CONTROLLER) {
> +               hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
> +
> +               sony_init_output_report(sc, sixaxis_send_output_report);
>         } else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
>                 /*
>                  * The Sony Sixaxis does not handle HID Output Reports on the
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
