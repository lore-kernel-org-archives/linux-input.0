From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 17/20] Input: spear-keyboard - Remove redundant platform_set_drvdata()
Date: Mon, 13 May 2013 09:34:07 +0530
Message-ID: <CAKohpom9uXWDZajJ-YNtMhK+PR4Rcxnk-M0VmVTGA_cAHdmBrA@mail.gmail.com>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
	<1367814240-8959-17-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42909 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3EMEEI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 00:04:08 -0400
Received: by mail-ob0-f179.google.com with SMTP id xn12so6099497obc.10
        for <linux-input@vger.kernel.org>; Sun, 12 May 2013 21:04:07 -0700 (PDT)
In-Reply-To: <1367814240-8959-17-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On 6 May 2013 09:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/input/keyboard/spear-keyboard.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index cb1e8f6..7111124 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -290,7 +290,6 @@ static int spear_kbd_remove(struct platform_device *pdev)
>         clk_unprepare(kbd->clk);
>
>         device_init_wakeup(&pdev->dev, 0);
> -       platform_set_drvdata(pdev, NULL);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
