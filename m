From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 3/3] mfd: max8997: change irq names to upper case
Date: Fri, 30 Jan 2015 10:00:57 +0900
Message-ID: <54CAD7C9.3080003@samsung.com>
References: <1415776996-11569-1-git-send-email-r.baldyga@samsung.com>
 <1415776996-11569-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <1415776996-11569-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: lee.jones@linaro.org, sameo@linux.intel.com, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, sachin.kamat@linaro.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hi Robert,

For extcon part,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

On 11/12/2014 04:23 PM, Robert Baldyga wrote:
> This patch changes naming convention of MUIC interrupts form CamelCase
> to upper case. It makes names more readable and consistent with another
> interrupt names in max8997 driver.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> [For the mfd part]
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/extcon/extcon-max8997.c     | 32 ++++++++++++++++----------------
>  include/linux/mfd/max8997-private.h | 16 ++++++++--------
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 172dbd6..834b72f 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -46,15 +46,15 @@ struct max8997_muic_irq {
>  };
>  
>  static struct max8997_muic_irq muic_irqs[] = {
> -	{ MAX8997_MUICIRQ_ADCError,	"muic-ADCERROR" },
> -	{ MAX8997_MUICIRQ_ADCLow,	"muic-ADCLOW" },
> -	{ MAX8997_MUICIRQ_ADC,		"muic-ADC" },
> -	{ MAX8997_MUICIRQ_VBVolt,	"muic-VBVOLT" },
> -	{ MAX8997_MUICIRQ_DBChg,	"muic-DBCHG" },
> -	{ MAX8997_MUICIRQ_DCDTmr,	"muic-DCDTMR" },
> -	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
> -	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
> -	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
> +	{ MAX8997_MUICIRQ_ADCERROR,	"MUIC-ADCERROR" },
> +	{ MAX8997_MUICIRQ_ADCLOW,	"MUIC-ADCLOW" },
> +	{ MAX8997_MUICIRQ_ADC,		"MUIC-ADC" },
> +	{ MAX8997_MUICIRQ_VBVOLT,	"MUIC-VBVOLT" },
> +	{ MAX8997_MUICIRQ_DBCHG,	"MUIC-DBCHG" },
> +	{ MAX8997_MUICIRQ_DCDTMR,	"MUIC-DCDTMR" },
> +	{ MAX8997_MUICIRQ_CHGDETRUN,	"MUIC-CHGDETRUN" },
> +	{ MAX8997_MUICIRQ_CHGTYP,	"MUIC-CHGTYP" },
> +	{ MAX8997_MUICIRQ_OVP,		"MUIC-OVP" },
>  };
>  
>  /* Define supported cable type */
> @@ -553,17 +553,17 @@ static void max8997_muic_irq_work(struct work_struct *work)
>  	}
>  
>  	switch (irq_type) {
> -	case MAX8997_MUICIRQ_ADCError:
> -	case MAX8997_MUICIRQ_ADCLow:
> +	case MAX8997_MUICIRQ_ADCERROR:
> +	case MAX8997_MUICIRQ_ADCLOW:
>  	case MAX8997_MUICIRQ_ADC:
>  		/* Handle all of cable except for charger cable */
>  		ret = max8997_muic_adc_handler(info);
>  		break;
> -	case MAX8997_MUICIRQ_VBVolt:
> -	case MAX8997_MUICIRQ_DBChg:
> -	case MAX8997_MUICIRQ_DCDTmr:
> -	case MAX8997_MUICIRQ_ChgDetRun:
> -	case MAX8997_MUICIRQ_ChgTyp:
> +	case MAX8997_MUICIRQ_VBVOLT:
> +	case MAX8997_MUICIRQ_DBCHG:
> +	case MAX8997_MUICIRQ_DCDTMR:
> +	case MAX8997_MUICIRQ_CHGDETRUN:
> +	case MAX8997_MUICIRQ_CHGTYP:
>  		/* Handle charger cable */
>  		ret = max8997_muic_chg_handler(info);
>  		break;
> diff --git a/include/linux/mfd/max8997-private.h b/include/linux/mfd/max8997-private.h
> index f42ea22..2817fa6 100644
> --- a/include/linux/mfd/max8997-private.h
> +++ b/include/linux/mfd/max8997-private.h
> @@ -411,14 +411,14 @@ enum max8997_irq {
>  
>  enum max8997_irq_muic {
>  	MAX8997_MUICIRQ_ADC,
> -	MAX8997_MUICIRQ_ADCLow,
> -	MAX8997_MUICIRQ_ADCError,
> -
> -	MAX8997_MUICIRQ_ChgTyp,
> -	MAX8997_MUICIRQ_ChgDetRun,
> -	MAX8997_MUICIRQ_DCDTmr,
> -	MAX8997_MUICIRQ_DBChg,
> -	MAX8997_MUICIRQ_VBVolt,
> +	MAX8997_MUICIRQ_ADCLOW,
> +	MAX8997_MUICIRQ_ADCERROR,
> +
> +	MAX8997_MUICIRQ_CHGTYP,
> +	MAX8997_MUICIRQ_CHGDETRUN,
> +	MAX8997_MUICIRQ_DCDTMR,
> +	MAX8997_MUICIRQ_DBCHG,
> +	MAX8997_MUICIRQ_VBVOLT,
>  
>  	MAX8997_MUICIRQ_OVP,
>  
> 

