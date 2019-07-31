From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: applespi - Fix build error
Date: Wed, 31 Jul 2019 06:49:37 -0700
Message-ID: <20190731134937.GE147138@dtor-ws>
References: <20190729031455.59400-1-yuehaibing@huawei.com>
 <20190730133414.49008-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730133414.49008-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: ronald@innovation.ch, nikolas@gnu.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 30, 2019 at 09:34:14PM +0800, YueHaibing wrote:
> If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
> building fails:
> 
> drivers/input/keyboard/applespi.o: In function `applespi_probe':
> applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'
> 
> Add "depends on LEDS_CLASS" to the Konfig
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
> v2: use 'depends on LEDS_CLASS'
> ---
>  drivers/input/keyboard/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index ebb19e2..90e8a7f 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -76,6 +76,7 @@ config KEYBOARD_APPLESPI
>  	depends on ACPI && EFI
>  	depends on SPI
>  	depends on X86 || COMPILE_TEST
> +	depends on LEDS_CLASS
>  	select CRC16
>  	help
>  	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
