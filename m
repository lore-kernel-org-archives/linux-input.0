From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Mon, 25 Feb 2019 00:05:29 -0800
Message-ID: <20190225080529.GA26142@innovation.ch>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221105609.5710-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
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
> 
> CC: Federico Lorenzi <federico@travelground.com>
> CC: Lukas Wunner <lukas@wunner.de>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=99891
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/input/keyboard/Kconfig    |   14 +
>  drivers/input/keyboard/Makefile   |    1 +
>  drivers/input/keyboard/applespi.c | 2003 +++++++++++++++++++++++++++++
>  3 files changed, 2018 insertions(+)
>  create mode 100644 drivers/input/keyboard/applespi.c
[snip]
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> new file mode 100644
> index 000000000000..2a8d1786011d
> --- /dev/null
> +++ b/drivers/input/keyboard/applespi.c
[snip]
> +/**
> + * This is a reduced version of print_hex_dump() that uses dev_printk().
> + */
> +static void dev_print_hex_dump(const char *level, const struct device *dev,
> +			       const char *prefix_str,
> +			       int rowsize, int groupsize,
> +			       const void *buf, size_t len, bool ascii)
> +{
> +	const u8 *ptr = buf;
> +	int i, linelen, remaining = len;
> +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
> +
> +	if (rowsize != 16 && rowsize != 32)
> +		rowsize = 16;
> +
> +	for (i = 0; i < len; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= rowsize;
> +
> +		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> +				   linebuf, sizeof(linebuf), ascii);
> +
> +		dev_printk(level, dev, "%s%s\n", prefix_str, linebuf);
> +	}
> +}

Apologies, I should've have fixed this before posting v2: I'll
introduce an additional patch to add this function to the core to
avoid duplication and because I presume this may be useful for others
too.


  Cheers,

  Ronald
