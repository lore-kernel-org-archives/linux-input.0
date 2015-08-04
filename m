From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 02/11] input: Allow compile test of GPIO consumers if
 !GPIOLIB
Date: Tue, 4 Aug 2015 11:44:08 -0700
Message-ID: <20150804184408.GD37185@dtor-ws>
References: <1438506475-31012-1-git-send-email-geert@linux-m68k.org>
 <1438506588-31545-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438506588-31545-1-git-send-email-geert@linux-m68k.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Aug 02, 2015 at 11:09:48AM +0200, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
> 
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/input/keyboard/Kconfig    |  4 ++--
>  drivers/input/misc/Kconfig        | 11 ++++++-----
>  drivers/input/mouse/Kconfig       |  2 +-
>  drivers/input/touchscreen/Kconfig |  8 ++++----
>  4 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 82a8fb50afacb253..da53ae6a93346c90 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -187,7 +187,7 @@ config KEYBOARD_EP93XX
>  
>  config KEYBOARD_GPIO
>  	tristate "GPIO Buttons"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  This driver implements support for buttons connected
>  	  to GPIO pins of various CPUs (and some other chips).
> @@ -253,7 +253,7 @@ config KEYBOARD_TCA8418
>  
>  config KEYBOARD_MATRIX
>  	tristate "GPIO driven matrix keypad support"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select INPUT_MATRIXKMAP
>  	help
>  	  Enable support for GPIO driven matrix keypad.
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index d4f0a817e858262b..dade381c7da80eb9 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -259,7 +259,7 @@ config INPUT_APANEL
>  config INPUT_GP2A
>  	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
>  	  hooked to an I2C bus.
> @@ -269,7 +269,7 @@ config INPUT_GP2A
>  
>  config INPUT_GPIO_BEEPER
>  	tristate "Generic GPIO Beeper support"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a beeper connected to a GPIO pin.
>  
> @@ -278,7 +278,7 @@ config INPUT_GPIO_BEEPER
>  
>  config INPUT_GPIO_TILT_POLLED
>  	tristate "Polled GPIO tilt switch"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select INPUT_POLLDEV
>  	help
>  	  This driver implements support for tilt switches connected
> @@ -569,7 +569,7 @@ config INPUT_PWM_BEEPER
>  
>  config INPUT_GPIO_ROTARY_ENCODER
>  	tristate "Rotary encoders connected to GPIO pins"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here to add support for rotary encoders connected to GPIO lines.
>  	  Check file:Documentation/input/rotary-encoder.txt for more
> @@ -776,7 +776,8 @@ config INPUT_SOC_BUTTON_ARRAY
>  
>  config INPUT_DRV260X_HAPTICS
>  	tristate "TI DRV260X haptics support"
> -	depends on INPUT && I2C && GPIOLIB
> +	depends on INPUT && I2C
> +	depends on GPIOLIB || COMPILE_TEST
>  	select INPUT_FF_MEMLESS
>  	select REGMAP_I2C
>  	help
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index d7820d1152d2ef2d..17f97e5e11e7cd2e 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -341,7 +341,7 @@ config MOUSE_VSXXXAA
>  
>  config MOUSE_GPIO
>  	tristate "GPIO mouse"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select INPUT_POLLDEV
>  	help
>  	  This driver simulates a mouse on GPIO lines of various CPUs (and some
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 860d426c480e2088..059edeb7f04a0d40 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -118,7 +118,7 @@ config TOUCHSCREEN_ATMEL_MXT
>  config TOUCHSCREEN_AUO_PIXCIR
>  	tristate "AUO in-cell touchscreen using Pixcir ICs"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a AUO display with in-cell touchscreen
>  	  using Pixcir ICs.
> @@ -142,7 +142,7 @@ config TOUCHSCREEN_BU21013
>  
>  config TOUCHSCREEN_CHIPONE_ICN8318
>  	tristate "chipone icn8318 touchscreen controller"
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	depends on I2C
>  	depends on OF
>  	help
> @@ -156,7 +156,7 @@ config TOUCHSCREEN_CHIPONE_ICN8318
>  config TOUCHSCREEN_CY8CTMG110
>  	tristate "cy8ctmg110 touchscreen"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a cy8ctmg110 capacitive touchscreen on
>  	  an AAVA device.
> @@ -1030,7 +1030,7 @@ config TOUCHSCREEN_TPS6507X
>  config TOUCHSCREEN_ZFORCE
>  	tristate "Neonode zForce infrared touchscreens"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a touchscreen using the zforce
>  	  infraread technology from Neonode.
> -- 
> 1.9.1
> 

-- 
Dmitry
