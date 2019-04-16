From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 16 Apr 2019 15:52:34 +0300
Message-ID: <20190416125234.GD9224@smile.fi.intel.com>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <20190415081300.24831-3-ronald@innovation.ch>
 <20190415090346.GL9224@smile.fi.intel.com>
 <20190415230955.GA13033@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415230955.GA13033@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 15, 2019 at 04:09:55PM -0700, Life is hard, and then you die wrote:
> On Mon, Apr 15, 2019 at 12:03:46PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 15, 2019 at 01:13:00AM -0700, Ronald Tschalär wrote:

> > > +static void
> > > +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> > > +{
> > > +	unsigned char tmp;
> > 
> > > +	u8 bit = BIT(fnremap - 1);
> > 
> > The above is UB and I'm sorry I didn't find this earlier.
> > 
> > So, something like this would work
> > 
> > 	u8 bit = BIT((fnremap - 1) & 0x07);
> 
> fnremap is already constrained by the following:

"already" is a wrong word here. Compiler checks in the order of appearing, so,
for it it is UB and we need to limit bits to allowed range, up to 31 for
unsigned int.

> 
> > > +
> > > +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> > > +	    !applespi_controlcodes[fnremap - 1])
> > > +		return;
> 
> and the array-size of applespi_controlcodes is constrained to the
> number of bits in u8 according to this assertion
> 
> > > +	compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
> > > +			   sizeof_field(struct keyboard_protocol, modifiers) * 8,
> > > +			   "applespi_controlcodes has wrong number of entries");
> 
> So I don't see that the masking buys anything new.

It buys us the follow to the standard. But gcc is clever enough to strip number
to allowed one.

-- 
With Best Regards,
Andy Shevchenko
