From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7877: Remove bitrotted comment
Date: Tue, 22 Apr 2014 17:39:28 -0700
Message-ID: <20140423003928.GB22547@core.coreip.homeip.net>
References: <1398201501-13470-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53856 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaDWAjc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 20:39:32 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so173168pab.26
        for <linux-input@vger.kernel.org>; Tue, 22 Apr 2014 17:39:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398201501-13470-1-git-send-email-broonie@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Tue, Apr 22, 2014 at 10:18:21PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> While searching for users of spi_async() I found a reference in the ad7877
> driver to using it to initiate data transfer from the interrupt handler.
> However there is no code for this, instead the interrupt handler is a
> threaded handler and uses spi_sync() instead.
> 
> Remove the bitrotted comment, though in actual fact the use case mentioned
> is a great use for spi_async() since it would cut down on latency handling
> the interrupt by saving us a context switch before we start SPI.
> 
> This was previously implemented, it was removed in commit b534422b2d11
> (Input: ad7877 - switch to using threaded IRQ) for code complexity reasons.
> It may be better to revert that commit instead.

Hmm, maybe.. although I think original would cause device 'stuck' if
call to spi_async() fails, so probably not a straight revert...

> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/input/touchscreen/ad7877.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 6793c85903ae..523865daa1d3 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -210,11 +210,6 @@ static bool gpio3;
>  module_param(gpio3, bool, 0);
>  MODULE_PARM_DESC(gpio3, "If gpio3 is set to 1 AUX3 acts as GPIO3");
>  
> -/*
> - * ad7877_read/write are only used for initial setup and for sysfs controls.
> - * The main traffic is done using spi_async() in the interrupt handler.
> - */
> -
>  static int ad7877_read(struct spi_device *spi, u16 reg)
>  {
>  	struct ser_req *req;
> -- 
> 1.9.2
> 
> 

-- 
Dmitry
