From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Date: Wed, 27 Mar 2019 17:24:38 -0700
Message-ID: <20190328002438.GE24753@innovation.ch>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Wed, Mar 27, 2019 at 11:35:30AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
[snip]
> > +#include <asm/barrier.h>
> 
> > +#include <asm-generic/unaligned.h>
> 
> generic?!
> 
> #include <asm/unaligned.h>
> should work.

Yes, you're right. I brought myself up-to-speed now on the difference
between the two.

> > +static const char *applespi_debug_facility(unsigned int log_mask)
> > +{
> > +	switch (log_mask) {
> > +	case DBG_CMD_TP_INI:
> > +		return "Touchpad Initialization";
> > +	case DBG_CMD_BL:
> > +		return "Backlight Command";
> > +	case DBG_CMD_CL:
> > +		return "Caps-Lock Command";
> > +	case DBG_RD_KEYB:
> > +		return "Keyboard Event";
> > +	case DBG_RD_TPAD:
> > +		return "Touchpad Event";
> > +	case DBG_RD_UNKN:
> > +		return "Unknown Event";
> > +	case DBG_RD_IRQ:
> > +		return "Interrupt Request";
> > +	case DBG_RD_CRC:
> > +		return "Corrupted packet";
> > +	case DBG_TP_DIM:
> > +		return "Touchpad Dimensions";
> > +	default:
> 
> > +		return "-Unrecognized log mask-";
> 
> I don't think '-' surroundings are needed, but this is rather minor. Up to you.

I've used that to distinguish an error value from normal values; but
that's not an idiom used in the kernel AFAICT, so I'll remove them.

Thanks.


  Cheers,

  Ronald
