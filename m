From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/15] ARM: at91: sam9g45: remove unused platform_data
Date: Sun, 16 Mar 2014 17:49:02 +0000
Message-ID: <5325E40E.7050501@kernel.org>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com> <1394040940-18246-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394040940-18246-2-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/03/14 17:35, Alexandre Belloni wrote:
> num_channels and registers are not used anymore since they are defined inside
> the at91_adc driver and assigned by matching the id_table.
>
> Also, remove the mach/at91_adc.h include that is not necessary anymore.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>   arch/arm/mach-at91/at91sam9g45_devices.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 88554024eb2d..cd36009c3511 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -25,7 +25,6 @@
>   #include <linux/fb.h>
>   #include <video/atmel_lcdc.h>
>
> -#include <mach/at91_adc.h>
>   #include <mach/at91sam9g45.h>
>   #include <mach/at91sam9g45_matrix.h>
>   #include <mach/at91_matrix.h>
> @@ -1235,13 +1234,6 @@ static struct at91_adc_trigger at91_adc_triggers[] = {
>   	},
>   };
>
> -static struct at91_adc_reg_desc at91_adc_register_g45 = {
> -	.channel_base = AT91_ADC_CHR(0),
> -	.drdy_mask = AT91_ADC_DRDY,
> -	.status_register = AT91_ADC_SR,
> -	.trigger_register = 0x08,
> -};
> -
>   void __init at91_add_device_adc(struct at91_adc_data *data)
>   {
>   	if (!data)
> @@ -1267,9 +1259,7 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
>   	if (data->use_external_triggers)
>   		at91_set_A_periph(AT91_PIN_PD28, 0);
>
> -	data->num_channels = 8;
>   	data->startup_time = 40;
> -	data->registers = &at91_adc_register_g45;
>   	data->trigger_number = 4;
>   	data->trigger_list = at91_adc_triggers;
>
>
