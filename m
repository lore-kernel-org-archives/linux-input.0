From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 5 Feb 2019 13:45:22 +0200
Message-ID: <20190205114522.GV9224@smile.fi.intel.com>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204081947.25152-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

> +config KEYBOARD_APPLESPI
> +	tristate "Apple SPI keyboard and trackpad"

> +	depends on (X86 && ACPI && SPI) || COMPILE_TEST

COMPILE_TEST more or less makes sense in conjunction with architecture selection.
It means, your code always dependant to ACPI and SPI frameworks.
That's why 0day complained.

> +	imply SPI_PXA2XX
> +	imply SPI_PXA2XX_PCI
> +	imply MFD_INTEL_LPSS_PCI
> +	help
> +	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
> +	  or any MacBookPro13,* or MacBookPro14,*.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called applespi.


-- 
With Best Regards,
Andy Shevchenko
