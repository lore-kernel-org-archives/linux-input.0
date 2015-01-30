From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH] Input: cap11xx - fix module alias
Date: Thu, 29 Jan 2015 17:36:22 -0800
Message-ID: <CAKzfze9A=vZXNof9uYSDYmidDz0fV0RD6=LjFHNge-nLJg+kjg@mail.gmail.com>
References: <1422581293.4982.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:40521 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759323AbbA3BgX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 20:36:23 -0500
Received: by mail-ig0-f170.google.com with SMTP id l13so159595iga.1
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 17:36:22 -0800 (PST)
In-Reply-To: <1422581293.4982.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>

On Thu, Jan 29, 2015 at 5:28 PM, Axel Lin <axel.lin@ingics.com> wrote:
> This is a I2C driver, so use i2c prefix for the module alias.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 4f59f0b..938f0d5 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -370,7 +370,7 @@ static struct i2c_driver cap11xx_i2c_driver = {
>
>  module_i2c_driver(cap11xx_i2c_driver);
>
> -MODULE_ALIAS("platform:cap11xx");
> +MODULE_ALIAS("i2c:cap11xx");
>  MODULE_DESCRIPTION("Microchip CAP11XX driver");
>  MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
>  MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
>
>
