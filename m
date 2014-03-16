From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/15] ARM: at91: sam9260: remove unused platform_data
Date: Sun, 16 Mar 2014 17:49:30 +0000
Message-ID: <5325E42A.5000401@kernel.org>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com> <1394040940-18246-3-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394040940-18246-3-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
>   arch/arm/mach-at91/at91sam9260_devices.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 0a0315920963..a299c50512f0 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -24,7 +24,6 @@
>   #include <mach/at91sam9260_matrix.h>
>   #include <mach/at91_matrix.h>
>   #include <mach/at91sam9_smc.h>
> -#include <mach/at91_adc.h>
>
>   #include "board.h"
>   #include "generic.h"
> @@ -1321,13 +1320,6 @@ static struct at91_adc_trigger at91_adc_triggers[] = {
>   	},
>   };
>
> -static struct at91_adc_reg_desc at91_adc_register_g20 = {
> -	.channel_base = AT91_ADC_CHR(0),
> -	.drdy_mask = AT91_ADC_DRDY,
> -	.status_register = AT91_ADC_SR,
> -	.trigger_register = AT91_ADC_MR,
> -};
> -
>   void __init at91_add_device_adc(struct at91_adc_data *data)
>   {
>   	if (!data)
> @@ -1345,9 +1337,7 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
>   	if (data->use_external_triggers)
>   		at91_set_A_periph(AT91_PIN_PA22, 0);
>
> -	data->num_channels = 4;
>   	data->startup_time = 10;
> -	data->registers = &at91_adc_register_g20;
>   	data->trigger_number = 4;
>   	data->trigger_list = at91_adc_triggers;
>
>
