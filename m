From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 11:14:21 +0800
Message-ID: <53C1F98D.9030603@gmail.com>
References: <53C1F7DE.3060102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <53C1F7DE.3060102@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, jic23@kernel.org, wim@iguana.be, benh@kernel.crashing.org, kys@microsoft.com, schwidefsky@de.ibm.com, teg@jklm.no, Mischa.Jonker@synopsys.com, msalter@redhat.com, lars@metafoo.de, richard@nod.at, knaack.h@gmx.de, marex@denx.de, rdunlap@infradead.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, David Rientjes <rientjes@google.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org


After this last patch, score architecture can pass allmodconfig. :-)

And also find a compiler issue, I will try to fix it, but shall not notify
kernel mailing list, again. The related issue is below (it seems a kernel
issue, but in fact, it is a compiler's issue):

    CC [M]  drivers/staging/lustre/lustre/ptlrpc/sec.o
  drivers/staging/lustre/lustre/ptlrpc/sec.c: In function 'sptlrpc_cli_ctx_expire':
  drivers/staging/lustre/lustre/ptlrpc/sec.c:309:13: error: 'struct ptlrpc_ctx_ops' has no member named '__die'
    ctx->cc_ops->die(ctx, 0);
               ^
  drivers/staging/lustre/lustre/ptlrpc/sec.c: In function 'ctx_refresh_timeout':
  drivers/staging/lustre/lustre/ptlrpc/sec.c:594:26: error: 'struct ptlrpc_ctx_ops' has no member named '__die'
     req->rq_cli_ctx->cc_ops->die(req->rq_cli_ctx, 0);
                            ^
  make[5]: *** [drivers/staging/lustre/lustre/ptlrpc/sec.o] Error 1
  make[4]: *** [drivers/staging/lustre/lustre/ptlrpc] Error 2
  make[3]: *** [drivers/staging/lustre/lustre] Error 2
  make[2]: *** [drivers/staging/lustre] Error 2
  make[1]: *** [drivers/staging] Error 2
  make: *** [drivers] Error 2

Thanks.

On 07/13/2014 11:07 AM, Chen Gang wrote:
> Several drivers need 'devm_ioremap_resource' which need HAS_IOMEM enabled.
> So let them depend on HAS_IOMEM.
> 
> The related error (with allmodconfig under score):
> 
>     MODPOST 1365 modules
>   ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/staging/iio/adc/mxs-lradc.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undefined!
> 
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/input/serio/Kconfig     | 3 ++-
>  drivers/pwm/Kconfig             | 2 +-
>  drivers/staging/iio/adc/Kconfig | 2 +-
>  drivers/watchdog/Kconfig        | 3 ++-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index bc2d474..449d45f 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -244,6 +244,7 @@ config SERIO_PS2MULT
>  
>  config SERIO_ARC_PS2
>  	tristate "ARC PS/2 support"
> +	depends on HAS_IOMEM
>  	help
>  	  Say Y here if you have an ARC FPGA platform with a PS/2
>  	  controller in it.
> @@ -263,7 +264,7 @@ config SERIO_APBPS2
>  
>  config SERIO_OLPC_APSP
>  	tristate "OLPC AP-SP input support"
> -	depends on OLPC || COMPILE_TEST
> +	depends on (OLPC || COMPILE_TEST) && HAS_IOMEM
>  	help
>  	  Say Y here if you want support for the keyboard and touchpad included
>  	  in the OLPC XO-1.75 and XO-4 laptops.
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4ad7b89..2faf5ce 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -82,7 +82,7 @@ config PWM_BFIN
>  
>  config PWM_CLPS711X
>  	tristate "CLPS711X PWM support"
> -	depends on ARCH_CLPS711X || COMPILE_TEST
> +	depends on (ARCH_CLPS711X || COMPILE_TEST) && HAS_IOMEM
>  	help
>  	  Generic PWM framework driver for Cirrus Logic CLPS711X.
>  
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index b87e382..4e927d2 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -94,7 +94,7 @@ config LPC32XX_ADC
>  
>  config MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> -	depends on ARCH_MXS || COMPILE_TEST
> +	depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
>  	depends on INPUT
>  	select STMP_DEVICE
>  	select IIO_BUFFER
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 76dd541..0e4abb2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -113,6 +113,7 @@ config WM8350_WATCHDOG
>  
>  config XILINX_WATCHDOG
>  	tristate "Xilinx Watchdog timer"
> +	depends on HAS_IOMEM
>  	select WATCHDOG_CORE
>  	help
>  	  Watchdog driver for the xps_timebase_wdt ip core.
> @@ -434,7 +435,7 @@ config SIRFSOC_WATCHDOG
>  
>  config TEGRA_WATCHDOG
>  	tristate "Tegra watchdog"
> -	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here to include support for the watchdog timer
> 


-- 
Chen Gang

Open share and attitude like air water and life which God blessed
