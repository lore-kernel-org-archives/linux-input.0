From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v4 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Mon, 8 Apr 2019 20:23:31 -0700
Message-ID: <20190409032331.GA478@innovation.ch>
References: <20190407050358.2976-1-ronald@innovation.ch>
 <20190407050358.2976-3-ronald@innovation.ch>
 <20190408123343.GO9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408123343.GO9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Mon, Apr 08, 2019 at 03:33:43PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 06, 2019 at 10:03:58PM -0700, Ronald Tschalär wrote:
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
> Thank you for an update, my comments below.

Thank you again for your review.

[snip]
> > +	} else {
> > +		struct dentry *ret;
> > +
> > +		ret = debugfs_create_bool("enable_tp_dim", 0600,
> > +					  applespi->debugfs_root,
> > +					  &applespi->debug_tp_dim);
> > +		if (IS_ERR(ret))
> > +			dev_warn(&(applespi)->spi->dev,
> > +				 "Error creating debugfs entry enable_tp_dim (%ld)\n",
> > +				 PTR_ERR(ret));
> 
> Can ret be NULL?

No, it actually can't (I manually traced all code paths to be sure):
the documentation for these helper functions is wrong in this respect.
However, I note that a lot of existing kernel code also has this wrong
(i.e. it's checking for NULL). Digging a bit further and looking at
the history, it appears this was changed just recently (commit
ff9fb72b "debugfs: return error values, not NULL"), which would
explain the existing code and documentation. I'll submit a patch to
update the docs.

> dev_dbg() looks more appropriate.

Hmm, ok, I guess I find this a bit odd, though: true, this only
affects code used for debugging, but it's nevertheless an error that
shouldn't normally occur.


  Cheers,

  Ronald
