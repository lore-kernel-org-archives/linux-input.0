From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH] Input: applespi: Fix build error without CONFIG_PCI
Date: Thu, 18 Jul 2019 04:40:36 -0700
Message-ID: <20190718114036.GA2872@innovation.ch>
References: <20190718020654.39860-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190718020654.39860-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: dmitry.torokhov@gmail.com, hsweeten@visionengravers.com, robh@kernel.org, arnd@arndb.de, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Thu, Jul 18, 2019 at 10:06:54AM +0800, YueHaibing wrote:
> If CONFIG_KEYBOARD_APPLESPI is set to y, but
> CONFIG_PCI is not set, building will fails:
> 
> drivers/spi/spi-pxa2xx-pci.c: In function pxa2xx_spi_pci_probe:
> drivers/spi/spi-pxa2xx-pci.c:208:8: error: implicit declaration of function pcim_enable_device;
>  did you mean pci_enable_device? [-Werror=implicit-function-declaration]
>   ret = pcim_enable_device(dev);
>         ^~~~~~~~~~~~~~~~~~
>         pci_enable_device
> drivers/spi/spi-pxa2xx-pci.c:239:8: error: implicit declaration of function pci_alloc_irq_vectors;
>  did you mean pci_alloc_consistent? [-Werror=implicit-function-declaration]
>   ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>         ^~~~~~~~~~~~~~~~~~~~~
> 
> Make CONFIG_KEYBOARD_APPLESPI depends on CONFIG_PCI
> to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: b426ac045209 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index dd934c4..fefcc46 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -74,7 +74,7 @@ config ATARI_KBD_CORE
>  config KEYBOARD_APPLESPI
>  	tristate "Apple SPI keyboard and trackpad"
>  	depends on ACPI && EFI
> -	depends on SPI
> +	depends on SPI && PCI
>  	depends on X86 || COMPILE_TEST
>  	imply SPI_PXA2XX
>  	imply SPI_PXA2XX_PCI
> -- 
> 2.7.4

I think this is more properly fixed by Dmitry's suggestion of making
SPI_PXA2XX_PCI depend on PCI, since it's that module, not applespi,
that actually needs PCI - see
https://www.spinics.net/lists/linux-input/msg62351.html


  Cheers,

  Ronald
