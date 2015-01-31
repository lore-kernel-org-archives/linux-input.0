From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH] Input: cap11xx - Remove wrong and unneeded cap11xx modalias
Date: Sat, 31 Jan 2015 02:17:39 -0800
Message-ID: <CAKzfze8qAQLz7DzU7aeoEX57grt0_zcoOXWrk491JnB6YfkDaA@mail.gmail.com>
References: <1422679082.8722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35993 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbAaKRk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 05:17:40 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so8171951igb.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 02:17:40 -0800 (PST)
In-Reply-To: <1422679082.8722.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Reviewed-by: Matt Ranostay <mranostay@gmail.com>

Thanks,

Matt Ranostay

On Fri, Jan 30, 2015 at 8:38 PM, Axel Lin <axel.lin@ingics.com> wrote:
> This is a I2C driver, so it's wrong to use platform prefix for the modalias.
> We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
> so remove the wrong and unneeded cap11xx modalias.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 4f59f0b..f07461a 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -370,7 +370,6 @@ static struct i2c_driver cap11xx_i2c_driver = {
>
>  module_i2c_driver(cap11xx_i2c_driver);
>
> -MODULE_ALIAS("platform:cap11xx");
>  MODULE_DESCRIPTION("Microchip CAP11XX driver");
>  MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
>  MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
>
>
