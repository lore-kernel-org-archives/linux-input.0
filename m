From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846: Correct log message for spi_sync() errors
Date: Tue, 22 Apr 2014 17:38:32 -0700
Message-ID: <20140423003832.GA22547@core.coreip.homeip.net>
References: <1398201555-13539-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:65428 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaDWAig (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 20:38:36 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so177263pdj.37
        for <linux-input@vger.kernel.org>; Tue, 22 Apr 2014 17:38:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398201555-13539-1-git-send-email-broonie@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Tue, Apr 22, 2014 at 10:19:15PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> While searching for users of spi_async() I got a false positive in the
> ads7846 driver, fix that.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ads7846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 7f8aa981500d..da201b8e37dc 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -706,7 +706,7 @@ static void ads7846_read_state(struct ads7846 *ts)
>  		m = &ts->msg[msg_idx];
>  		error = spi_sync(ts->spi, m);
>  		if (error) {
> -			dev_err(&ts->spi->dev, "spi_async --> %d\n", error);
> +			dev_err(&ts->spi->dev, "spi_sync --> %d\n", error);
>  			packet->tc.ignore = true;
>  			return;
>  		}
> -- 
> 1.9.2
> 
> 

-- 
Dmitry
