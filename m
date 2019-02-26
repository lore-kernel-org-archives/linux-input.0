From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 26 Feb 2019 10:51:29 +0200
Message-ID: <20190226085129.GU9224@smile.fi.intel.com>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
 <20190225080529.GA26142@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225080529.GA26142@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 25, 2019 at 12:05:29AM -0800, Life is hard, and then you die wrote:
> 
> On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
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

> > +/**
> > + * This is a reduced version of print_hex_dump() that uses dev_printk().
> > + */

...and this should follow kernel doc as stated by comment style.

> > +static void dev_print_hex_dump(const char *level, const struct device *dev,
> > +			       const char *prefix_str,
> > +			       int rowsize, int groupsize,
> > +			       const void *buf, size_t len, bool ascii)
> > +{
> > +	const u8 *ptr = buf;
> > +	int i, linelen, remaining = len;
> > +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> > +
> > +	if (rowsize != 16 && rowsize != 32)
> > +		rowsize = 16;
> > +
> > +	for (i = 0; i < len; i += rowsize) {
> > +		linelen = min(remaining, rowsize);
> > +		remaining -= rowsize;
> > +
> > +		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> > +				   linebuf, sizeof(linebuf), ascii);
> > +
> > +		dev_printk(level, dev, "%s%s\n", prefix_str, linebuf);
> > +	}
> > +}
> 
> Apologies, I should've have fixed this before posting v2: I'll
> introduce an additional patch to add this function to the core to
> avoid duplication and because I presume this may be useful for others
> too.

Yes, makes sense.

-- 
With Best Regards,
Andy Shevchenko
