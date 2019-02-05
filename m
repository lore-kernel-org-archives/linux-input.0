From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 5 Feb 2019 05:18:12 -0800
Message-ID: <20190205131812.GC4225@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
 <20190205114522.GV9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205114522.GV9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  Hi Andy,

On Tue, Feb 05, 2019 at 01:45:22PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
> > 
> > In order for this driver to work, the proper SPI drivers need to be
> > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > reason enabling this driver in the config implies enabling the above
> > drivers.
> 
> > +config KEYBOARD_APPLESPI
> > +	tristate "Apple SPI keyboard and trackpad"
> 
> > +	depends on (X86 && ACPI && SPI) || COMPILE_TEST
> 
> COMPILE_TEST more or less makes sense in conjunction with architecture selection.
> It means, your code always dependant to ACPI and SPI frameworks.
> That's why 0day complained.

Thanks. Yes, looking at this again I realized I somewhat misunderstood
the uses of COMPILE_TEST. I've changed this now to

        depends on ACPI && SPI && (X86 || COMPILE_TEST)


  Cheers,

  Ronald
