From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/33] Input: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 16:15:35 +0530
Message-ID: <CAOh2x==ECCN-2wEkFuNQ6DN2K6LMe3kvYMXXpk1bzQvUVo19Wg@mail.gmail.com>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
	<1358762966-20791-13-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:42085 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab3AUKpg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 05:45:36 -0500
In-Reply-To: <1358762966-20791-13-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, linux-input@vger.kernel.org

On Mon, Jan 21, 2013 at 3:39 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> @@ -228,11 +228,9 @@ static int spear_kbd_probe(struct platform_device *pdev)
>                 kbd->suspended_rate = pdata->suspended_rate;
>         }
>
> -       kbd->io_base = devm_request_and_ioremap(&pdev->dev, res);
> -       if (!kbd->io_base) {
> -               dev_err(&pdev->dev, "request-ioremap failed for kbd_region\n");

I would like to keep this error message as is.

> -               return -ENOMEM;
> -       }
> +       kbd->io_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(kbd->io_base))
> +               return PTR_ERR(kbd->io_base);

apart from that, for SPEAr

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
