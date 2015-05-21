From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Thu, 21 May 2015 16:06:12 -0700
Message-ID: <20150521230612.GA39517@dtor-ws>
References: <555E4BF8.80401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34088 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbEUXGQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 19:06:16 -0400
Received: by igbhj9 with SMTP id hj9so23267141igb.1
        for <linux-input@vger.kernel.org>; Thu, 21 May 2015 16:06:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555E4BF8.80401@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <heiner.kallweit@web.de>
Cc: linux-input@vger.kernel.org

Hi Heiner,

On Thu, May 21, 2015 at 11:19:52PM +0200, Heiner Kallweit wrote:
> Even with poper DT config the module didn't autoload.
> That's fixed by this additional alias.
> 
> Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
> on RPI2 under Arch Linux ARM (kernel 3.18.13).
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index e4c3125..1940e3c 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:" STMPE_TS_NAME);
>  MODULE_ALIAS("platform:" STMPE_TS_NAME);

Bit this is not an SPI driver, it is a platform driver for a MFD cell.
Why does adding SPI alias help?

Thanks.

-- 
Dmitry
