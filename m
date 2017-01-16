From: Dima Ryazanov <dima@gmail.com>
Subject: Re: [PATCH] input: ALPS - Invert the Y axis and adjust scaling on SS5 tracksticks
Date: Mon, 16 Jan 2017 12:23:38 -0800
Message-ID: <CA++2Deqao-kX979Xm-FOSMmUmfEdW3qGXdUhC=xiH7gj_PY6dQ@mail.gmail.com>
References: <20170110073555.31004-1-dima@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34799 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdAPUYC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Jan 2017 15:24:02 -0500
Received: by mail-ot0-f195.google.com with SMTP id 73so7379221otj.1
        for <linux-input@vger.kernel.org>; Mon, 16 Jan 2017 12:23:39 -0800 (PST)
In-Reply-To: <20170110073555.31004-1-dima@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dima Ryazanov <dima@gmail.com>

Actually, sorry, disregard this patch.

The Y axis has already been fixed by
47e3a5edc6538d66e470aaed3b7c57255cb37ca1, and the sensitivity should
probably be adjusted in hwdb rather than the driver.

On Mon, Jan 9, 2017 at 11:35 PM, Dima Ryazanov <dima@gmail.com> wrote:
> This patch fixes the trackstick on my Dell Latitude E7470. Currently, it's
> upside down and too fast (that is, much faster than when using the generic
> PS/2 driver).
>
> It also matches the trackpoint logic in alps_process_packet_v6.
> ---
> (I'm aware that scaling in the driver is not ideal - but at least the vertical
> orientation should be fixed.)
>
> Signed-off-by: Dima Ryazanov <dima@gmail.com>
> ---
>  drivers/input/mouse/alps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 328edc8..5fa7a15 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1346,8 +1346,8 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
>                         return;
>                 }
>
> -               input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet));
> -               input_report_rel(dev2, REL_Y, SS4_TS_Y_V2(packet));
> +               input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet) / 4);
> +               input_report_rel(dev2, REL_Y, -SS4_TS_Y_V2(packet) / 4);
>                 input_report_abs(dev2, ABS_PRESSURE, SS4_TS_Z_V2(packet));
>
>                 input_report_key(dev2, BTN_LEFT, f->ts_left);
> --
> 2.9.3
>
