From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v5 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Mon, 15 Apr 2019 16:09:55 -0700
Message-ID: <20190415230955.GA13033@innovation.ch>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <20190415081300.24831-3-ronald@innovation.ch>
 <20190415090346.GL9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415090346.GL9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  Hi Andy,

On Mon, Apr 15, 2019 at 12:03:46PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2019 at 01:13:00AM -0700, Ronald Tschalär wrote:
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
> Thank you for an update.
> I suddenly realized couple of places where something maybe optimized.
> 
> Nevertheless, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Many thanks for all your reviews!

[snip]
> > +static void
> > +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> > +{
> > +	unsigned char tmp;
> 
> > +	u8 bit = BIT(fnremap - 1);
> 
> The above is UB and I'm sorry I didn't find this earlier.
> 
> So, something like this would work
> 
> 	u8 bit = BIT((fnremap - 1) & 0x07);

fnremap is already constrained by the following:

> > +
> > +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> > +	    !applespi_controlcodes[fnremap - 1])
> > +		return;

and the array-size of applespi_controlcodes is constrained to the
number of bits in u8 according to this assertion

> > +	compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
> > +			   sizeof_field(struct keyboard_protocol, modifiers) * 8,
> > +			   "applespi_controlcodes has wrong number of entries");

So I don't see that the masking buys anything new.

[snip]
> > +	/* check for rollover overflow, which is signalled by all keys == 1 */
> > +	for (i = 0; i < MAX_ROLLOVER; i++) {
> > +		if (keyboard_protocol->keys_pressed[i] != 1)
> > +			break;
> > +	}
> > +
> > +	if (i == MAX_ROLLOVER)	/* all keys were 1 */
> > +		return;
> 
> Since keys_pressed is an array of byte values, it may be replaced with
> memchr_inv().
> 
> > +
> > +	/* remap fn key if desired */
> > +	applespi_remap_fn_key(keyboard_protocol);
> > +
> > +	/* check released keys */
> > +	for (i = 0; i < MAX_ROLLOVER; i++) {
> > +		for (j = 0; j < MAX_ROLLOVER; j++) {
> > +			if (applespi->last_keys_pressed[i] ==
> > +			    keyboard_protocol->keys_pressed[j])
> > +				break;
> > +		}
> > +
> > +		if (j < MAX_ROLLOVER)	/* key is still pressed */
> > +			continue;
> 
> And memchr() here.

Ah, yes, excellent suggestion. Thanks.


  Cheers,

  Ronald
