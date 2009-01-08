From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] input/mfd/ucb1400: move static function from header to its user
Date: Thu, 8 Jan 2009 13:23:55 +0100
Message-ID: <200901081323.55398.marek.vasut@gmail.com>
References: <20090108110757.GB24243@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:50354 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZAHMX5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2009 07:23:57 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1692594ugf.37
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2009 04:23:55 -0800 (PST)
In-Reply-To: <20090108110757.GB24243@www.tglx.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org

On Thursday 08 of January 2009 12:07:57 Sebastian Andrzej Siewior wrote:
> it's a little too large for static line and just static is somehow ....
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> The only user I've seen is ts driver.

NAK, this is used by the battery as well (which is not merged yet, see ARM 
linux mailing list for it)

>
>  drivers/input/touchscreen/ucb1400_ts.c |   19 +++++++++++++++++++
>  include/linux/ucb1400.h                |   19 -------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> b/drivers/input/touchscreen/ucb1400_ts.c index 1647bc4..f2377a2 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -44,6 +44,25 @@ static inline void ucb1400_ts_mode_int(struct snd_ac97
> *ac97) UCB_TS_CR_MODE_INT);
>  }
>
> +static unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16
> adc_channel, +		int adcsync)
> +{
> +	unsigned int val;
> +
> +	if (adcsync)
> +		adc_channel |= UCB_ADC_SYNC_ENA;
> +
> +	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel);
> +	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel |
> +			UCB_ADC_START);
> +
> +	while (!((val = ucb1400_reg_read(ac97, UCB_ADC_DATA))
> +				& UCB_ADC_DAT_VALID))
> +		schedule_timeout_uninterruptible(1);
> +
> +	return val & UCB_ADC_DAT_MASK;
> +}
> +
>  /*
>   * Switch to pressure mode, and read pressure.  We don't need to wait
>   * here, since both plates are being driven.
> diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
> index 970473b..bf4f547 100644
> --- a/include/linux/ucb1400.h
> +++ b/include/linux/ucb1400.h
> @@ -134,25 +134,6 @@ static inline void ucb1400_adc_enable(struct snd_ac97
> *ac97) ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA);
>  }
>
> -static unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16
> adc_channel, -					int adcsync)
> -{
> -	unsigned int val;
> -
> -	if (adcsync)
> -		adc_channel |= UCB_ADC_SYNC_ENA;
> -
> -	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel);
> -	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel |
> -				UCB_ADC_START);
> -
> -	while (!((val = ucb1400_reg_read(ac97, UCB_ADC_DATA))
> -			& UCB_ADC_DAT_VALID))
> -		schedule_timeout_uninterruptible(1);
> -
> -	return val & UCB_ADC_DAT_MASK;
> -}
> -
>  static inline void ucb1400_adc_disable(struct snd_ac97 *ac97)
>  {
>  	ucb1400_reg_write(ac97, UCB_ADC_CR, 0);


