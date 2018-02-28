From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC 2/4] mfd: add Gateworks System Controller core driver
Date: Tue, 27 Feb 2018 18:00:25 -0800
Message-ID: <170c83e1-8a34-5103-3767-139b22081cf9@infradead.org>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 02/27/2018 05:21 PM, Tim Harvey wrote:
> The Gateworks System Controller (GSC) is an I2C slave controller
> implemented with an MSP430 micro-controller whose firmware embeds the
> following features:
>  - I/O expander (16 GPIO's) using PCA955x protocol
>  - Real Time Clock using DS1672 protocol
>  - User EEPROM using AT24 protocol
>  - HWMON using custom protocol
>  - Interrupt controller with tamper detect, user pushbotton
>  - Watchdog controller capable of full board power-cycle
>  - Power Control capable of full board power-cycle
> 
> see http://trac.gateworks.com/wiki/gsc for more details
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/mfd/Kconfig     |  10 ++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/gsc.c       | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/gsc.h |  79 ++++++++++++
>  4 files changed, 420 insertions(+)
>  create mode 100644 drivers/mfd/gsc.c
>  create mode 100644 include/linux/mfd/gsc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1d20a80..16dd486 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -341,6 +341,16 @@ config MFD_EXYNOS_LPASS
>  	  Select this option to enable support for Samsung Exynos Low Power
>  	  Audio Subsystem.
>  
> +config MFD_GSC
> +	tristate "Gateworks System Controller"
> +	depends on (I2C && OF) || COMPILE_TEST

Do both I2C and OF have stubs so that a driver will build when they are
both disabled?  I.e., only COMPILE_TEST is enabled?


> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Enable support for the Gateworks System Controller found
> +	  on Gateworks Single Board Computers.
> +
>  config MFD_MC13XXX
>  	tristate
>  	depends on (SPI_MASTER || I2C)
thanks,
-- 
~Randy
