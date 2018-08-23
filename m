From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V4 3/3] Input: new da7280 haptic driver
Date: Thu, 23 Aug 2018 08:28:24 -0700
Message-ID: <6115d6ca-8df6-1830-3c61-681610d8f2b0@infradead.org>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
 <2c28a93093c075e0145b70e7bc999f2654d0431d.1534830272.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c28a93093c075e0145b70e7bc999f2654d0431d.1534830272.git.Roy.Im@diasemi.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/20/2018 10:44 PM, Roy Im wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2b..6e0de69 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -851,4 +851,16 @@ config INPUT_SC27XX_VIBRA
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called sc27xx_vibra.
>  

Hi,
Can you explain the "depends on" below, please.

> +config INPUT_DA7280_HAPTICS
> +	tristate "Dialog Semiconductor DA7280 haptics support"
> +	depends on (INPUT && I2C && SYSFS) || PWM
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C

If INPUT is disabled, and I2C is disabled, and SYSFS is disabled, but PWM=y,
then the "select"s will have problems with unmet dependencies.

> +	help
> +	  Say Y to enable support for the haptics controller on
> +	  Dialog DA7280 chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280-haptic.

That module name doesn't match what's in the Makefile (below).

> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1..d941348 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
>  obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o


-- 
~Randy
