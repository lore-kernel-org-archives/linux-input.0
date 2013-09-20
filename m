From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: ad714x-spi - Remove redundant spi_set_drvdata
Date: Fri, 20 Sep 2013 09:39:38 -0700
Message-ID: <20130920163938.GA6300@core.coreip.homeip.net>
References: <1379652173-32477-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45259 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3ITQjn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Sep 2013 12:39:43 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so917907pab.11
        for <linux-input@vger.kernel.org>; Fri, 20 Sep 2013 09:39:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379652173-32477-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, michael.hennerich@analog.com, Barry Song <21cnbao@gmail.com>

On Fri, Sep 20, 2013 at 10:12:50AM +0530, Sachin Kamat wrote:
> Driver core sets driver data to NULL upon failure or remove.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
> ---
> Series compile tested.

Applied all 4, thank you.

> ---
>  drivers/input/misc/ad714x-spi.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
> index 6189148..3a90b71 100644
> --- a/drivers/input/misc/ad714x-spi.c
> +++ b/drivers/input/misc/ad714x-spi.c
> @@ -108,7 +108,6 @@ static int ad714x_spi_remove(struct spi_device *spi)
>  	struct ad714x_chip *chip = spi_get_drvdata(spi);
>  
>  	ad714x_remove(chip);
> -	spi_set_drvdata(spi, NULL);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 

-- 
Dmitry
