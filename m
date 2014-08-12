From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/joystick: use get_cycles on ARMv8
Date: Tue, 12 Aug 2014 10:01:49 -0700
Message-ID: <20140812170149.GB5563@core.coreip.homeip.net>
References: <1407771730-1641-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33282 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbaHLRBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 13:01:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so13271685pab.40
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 10:01:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407771730-1641-1-git-send-email-broonie@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Mon, Aug 11, 2014 at 04:42:10PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> As with ARM the ARMv8 architecture provides a cycle counter which can be
> used to provide a high resolution time for the joystick driver and silence
> the build warning that results from not having a precise timer on ARMv8,
> making allmodconfig and allyesconfig quieter.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Applied, although I wonder if it is time to retire whole gamecon subsystem. I
don't think there are many users left... 

> ---
>  drivers/input/joystick/analog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index 9135606c8649..ab0fdcd36e18 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -158,7 +158,7 @@ static unsigned int get_time_pit(void)
>  #define GET_TIME(x)	rdtscl(x)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"TSC"
> -#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_TILE)
> +#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
>  #define GET_TIME(x)	do { x = get_cycles(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"get_cycles"
> -- 
> 2.0.1
> 

-- 
Dmitry
