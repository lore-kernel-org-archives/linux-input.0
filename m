From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 07/15] iio: adc: at91: add sam9rl support
Date: Sat, 22 Mar 2014 12:34:51 +0000
Message-ID: <532D836B.3010200@kernel.org>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com> <1395064628-644-8-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395064628-644-8-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 17/03/14 13:57, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   drivers/iio/adc/at91_adc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a51b8badbf8e..3b5bacd4d8da 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1346,6 +1346,20 @@ static struct at91_adc_caps at91sam9260_caps = {
>   	},
>   };
>
> +static struct at91_adc_caps at91sam9rl_caps = {
> +	.has_ts = true,
> +	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
> +	.num_channels = 6,
> +	.registers = {
> +		.channel_base = AT91_ADC_CHR(0),
> +		.drdy_mask = AT91_ADC_DRDY,
> +		.status_register = AT91_ADC_SR,
> +		.trigger_register = AT91_ADC_TRGR_9G45,
> +		.mr_prescal_mask = AT91_ADC_PRESCAL_9260,
> +		.mr_startup_mask = AT91_ADC_STARTUP_9G45,
> +	},
> +};
> +
>   static struct at91_adc_caps at91sam9g45_caps = {
>   	.has_ts = true,
>   	.calc_startup_ticks = calc_startup_ticks_9260,	/* same as 9260 */
> @@ -1380,6 +1394,7 @@ static struct at91_adc_caps at91sam9x5_caps = {
>
>   static const struct of_device_id at91_adc_dt_ids[] = {
>   	{ .compatible = "atmel,at91sam9260-adc", .data = &at91sam9260_caps },
> +	{ .compatible = "atmel,at91sam9rl-adc", .data = &at91sam9rl_caps },
>   	{ .compatible = "atmel,at91sam9g45-adc", .data = &at91sam9g45_caps },
>   	{ .compatible = "atmel,at91sam9x5-adc", .data = &at91sam9x5_caps },
>   	{},
> @@ -1391,6 +1406,9 @@ static const struct platform_device_id at91_adc_ids[] = {
>   		.name = "at91sam9260-adc",
>   		.driver_data = (unsigned long)&at91sam9260_caps,
>   	}, {
> +		.name = "at91sam9rl-adc",
> +		.driver_data = (unsigned long)&at91sam9rl_caps,
> +	}, {
>   		.name = "at91sam9g45-adc",
>   		.driver_data = (unsigned long)&at91sam9g45_caps,
>   	}, {
>
