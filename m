From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
Date: Tue, 11 Feb 2014 13:08:49 +0100
Message-ID: <52FA12D1.4020408@metafoo.de>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com> <003f01cf25fd$b3e274b0$1ba75e10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <003f01cf25fd$b3e274b0$1ba75e10$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 02/10/2014 02:16 AM, Jingoo Han wrote:
> The HAVE_PWM symbol is only for legacy platforms that provide
> the PWM API without using the generic framework. However, legacy
> PWM drivers were already moved to the generic PWM framework.
> Thus, HAVE_PWM should be removed, because HAVE_PWM is not
> required anymore.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/input/misc/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ae74df7..762e6d2 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -470,7 +470,7 @@ config INPUT_PCF8574
>
>   config INPUT_PWM_BEEPER
>   	tristate "PWM beeper support"
> -	depends on PWM && HAVE_PWM
> +	depends on PWM
>   	help
>   	  Say Y here to get support for PWM based beeper devices.
>
>
