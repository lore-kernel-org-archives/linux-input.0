From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] input/mfd/ucb1400: move static function from header into core]
Date: Tue, 13 Jan 2009 09:30:19 +0100
Message-ID: <200901130930.19918.marek.vasut@gmail.com>
References: <20090112212318.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:5362 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbZAMIaS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 03:30:18 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1398766nfc.21
        for <linux-input@vger.kernel.org>; Tue, 13 Jan 2009 00:30:16 -0800 (PST)
In-Reply-To: <20090112212318.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Samuel Ortiz <sameo@openedhand.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Tuesday 13 of January 2009 06:25:31 Dmitry Torokhov wrote:
> Samuel,
>
> I suppose it should go through your tree, right?
>
> Thanks,
> Dmitry

Thanks. I'd be overly grateful if someone could pick up the ucb1400-battery 
patch from LAKML and merge it as well (since I wont have any time to do it 
myself any soon). Also there is GPIO handler for ucb1400 in LAKML, that one 
would be nice to have merged as well.

Thanks
Marek

>
> ----- Forwarded message from Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> -----
>
> Date: Mon, 12 Jan 2009 10:31:30 +0100
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org
> Subject: [PATCH] input/mfd/ucb1400: move static function from header into
> core
>
> it's a little too large for static line.
> The ts is currently the only mainline user but Marek Vasut claims that
> there is a battery driver in an ARM tree which also needs this function.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mfd/ucb1400_core.c |   20 ++++++++++++++++++++
>  include/linux/ucb1400.h    |   20 ++------------------
>  2 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mfd/ucb1400_core.c b/drivers/mfd/ucb1400_core.c
> index 88f33c1..3a89e7f 100644
> --- a/drivers/mfd/ucb1400_core.c
> +++ b/drivers/mfd/ucb1400_core.c
> @@ -23,6 +23,26 @@
>  #include <linux/module.h>
>  #include <linux/ucb1400.h>
>
> +unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
> +		int adcsync)
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
> +EXPORT_SYMBOL_GPL(ucb1400_adc_read);
> +
>  static int ucb1400_core_probe(struct device *dev)
>  {
>  	int err;
> diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
> index 970473b..1b0840d 100644
> --- a/include/linux/ucb1400.h
> +++ b/include/linux/ucb1400.h
> @@ -134,24 +134,8 @@ static inline void ucb1400_adc_enable(struct snd_ac97
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
> +unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
> +		int adcsync);
>
>  static inline void ucb1400_adc_disable(struct snd_ac97 *ac97)
>  {


