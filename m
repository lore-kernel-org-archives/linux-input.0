From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: touchscreen: fix link error
Date: Mon, 14 Jan 2019 10:32:24 -0800
Message-ID: <20190114183224.GB117329@dtor-ws>
References: <20190114095754.23175-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114095754.23175-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2019 at 10:57:54AM +0100, Anders Roxell wrote:
> Fix link error when TOUCHSCREEN_RASPBERRYPI_FW is enabled as a module
> and the dependent module is built-in.
> The 'depends on RASPBERRYPI_FIRMWARE' by itself prevents the touchscreen
> driver from being built-in when the firmware is configured as a module.
> However, the '|| COMPILE_TEST' still allows it unless we explicitly
> prevent that configuration with '|| (RASPBERRYPI_FIRMWARE=n &&
> COMPILE_TEST)'
> 
> ld: drivers/input/touchscreen/raspberrypi-ts.o: in function `rpi_ts_probe':
> raspberrypi-ts.c:(.text+0x3a8): undefined reference to `rpi_firmware_get'
> ld: raspberrypi-ts.c:(.text+0x3a8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
> ld: raspberrypi-ts.c:(.text+0x4c8): undefined reference to `rpi_firmware_property'
> ld: raspberrypi-ts.c:(.text+0x4c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'
> 
> Rework so that TOUCHSCREEN_RASPBERRYPI_FW depends on
> RASPBERRYPI_FIRMWARE=n if COMPILE_TEST is enabled.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index af6027cc7bbf..068dbbc610fc 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -698,7 +698,7 @@ config TOUCHSCREEN_EDT_FT5X06
>  
>  config TOUCHSCREEN_RASPBERRYPI_FW
>  	tristate "Raspberry Pi's firmware base touch screen support"
> -	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> +	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
>  	help
>  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
>  	  your system.
> -- 
> 2.19.2
> 

-- 
Dmitry
