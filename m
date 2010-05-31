From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Fix build of S3C touchscreen driver
Date: Mon, 31 May 2010 12:03:41 -0700
Message-ID: <20100531190341.GB30712@core.coreip.homeip.net>
References: <1275311294-10760-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61753 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab0EaTDr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 15:03:47 -0400
Content-Disposition: inline
In-Reply-To: <1275311294-10760-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 31, 2010 at 02:08:14PM +0100, Mark Brown wrote:
> The name of the Kconfig symbol for the ADC has changed as a result of
> application to more SoCs but the select statement has not been updated,
> causing linker failures in 2.6.35-rc1 as the ADC core has not been
> built.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied, tahnk you Mark.

> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 6703c6b..3b9d5e2 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -156,7 +156,7 @@ config TOUCHSCREEN_FUJITSU
>  config TOUCHSCREEN_S3C2410
>  	tristate "Samsung S3C2410/generic touchscreen input driver"
>  	depends on ARCH_S3C2410 || SAMSUNG_DEV_TS
> -	select S3C24XX_ADC
> +	select S3C_ADC
>  	help
>  	  Say Y here if you have the s3c2410 touchscreen.
>  
> -- 
> 1.7.1
> 

-- 
Dmitry
