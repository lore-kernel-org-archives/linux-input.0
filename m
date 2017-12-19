From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: [PATCH v2] HID: sony: Fix up nyko core controller
Date: Tue, 19 Dec 2017 11:07:12 -0800
Message-ID: <CAEc3jaBXjgqV0X4eKHYTUzioxdXNqP2x5BTg_A3ansXvj78qHA@mail.gmail.com>
References: <1513131714-10907-1-git-send-email-oreaus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36852 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdLSTHN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Dec 2017 14:07:13 -0500
Received: by mail-yb0-f179.google.com with SMTP id j7so14430454ybl.3
        for <linux-input@vger.kernel.org>; Tue, 19 Dec 2017 11:07:13 -0800 (PST)
In-Reply-To: <1513131714-10907-1-git-send-email-oreaus@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Moreau <oreaus@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

(From personal email as work email, doesn't do plain text well..)

Acked-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

On Tue, Dec 12, 2017 at 6:21 PM, Scott Moreau <oreaus@gmail.com> wrote:
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
