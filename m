From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] input: cyapa: fix update suspend scanrate set to max 1000 issue
Date: Mon, 20 Apr 2015 10:00:42 -0700
Message-ID: <CANLzEkuuQZ4MNT0tZLkU8sx3u8FGxm6ZBK46tRGczzP=LiPr4w@mail.gmail.com>
References: <1429508594-24255-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35478 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbDTRAn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 13:00:43 -0400
Received: by igbyr2 with SMTP id yr2so64901356igb.0
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2015 10:00:42 -0700 (PDT)
In-Reply-To: <1429508594-24255-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dudley.

Just a minor commit message nit. Thanks!

On Sun, Apr 19, 2015 at 10:43 PM, Dudley Du <dudl@cypress.com> wrote:
> Fix update suspend scareate always set to max 1000 issue, the root cause is
s/scareate/scanrate
> the missed using max_t as min_t.
> TEST=test on Chromebook.
>
> Signed-off-by: Dudley Du <dudl@cypress.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/input/mouse/cyapa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 58f4f6f..efe1484 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -723,7 +723,7 @@ static ssize_t cyapa_update_suspend_scanrate(struct device *dev,
>         } else if (sysfs_streq(buf, OFF_MODE_NAME)) {
>                 cyapa->suspend_power_mode = PWR_MODE_OFF;
>         } else if (!kstrtou16(buf, 10, &sleep_time)) {
> -               cyapa->suspend_sleep_time = max_t(u16, sleep_time, 1000);
> +               cyapa->suspend_sleep_time = min_t(u16, sleep_time, 1000);
>                 cyapa->suspend_power_mode =
>                         cyapa_sleep_time_to_pwr_cmd(cyapa->suspend_sleep_time);
>         } else {
> @@ -840,7 +840,7 @@ static ssize_t cyapa_update_rt_suspend_scanrate(struct device *dev,
>         if (error)
>                 return error;
>
> -       cyapa->runtime_suspend_sleep_time = max_t(u16, time, 1000);
> +       cyapa->runtime_suspend_sleep_time = min_t(u16, time, 1000);
>         cyapa->runtime_suspend_power_mode =
>                 cyapa_sleep_time_to_pwr_cmd(cyapa->runtime_suspend_sleep_time);
>
> --
> 1.9.1
>



-- 
Benson Leung
Software Engineer, Chrome OS
Google Inc.
bleung@google.com
