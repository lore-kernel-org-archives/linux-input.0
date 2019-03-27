From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Date: Wed, 27 Mar 2019 19:45:26 +0100
Message-ID: <20190327184526.GA11095@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
 <20190327093530.GH9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327093530.GH9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 11:35:30AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
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
> > +// SPDX-License-Identifier: GPL-2.0
> 
> According to last changes this should be GPL-2.0-only

What "last changes"?  "GPL-2.0" is a totally valid SPDX identifier for
the kernel.  Don't buy into the "-only" prefix crud that the newer SPDX
version adopted for crazy reasons.  The in-kernel documentation lists
the valid identifiers and the version of SPDX we are currently using.

thanks,

greg k-h
