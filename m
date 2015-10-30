From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Fri, 30 Oct 2015 11:40:04 +0100
Message-ID: <5143701.zqn4HuBlp3@wuerfel>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org> <20151030003905.GL28319@sirena.org.uk> <20151030010151.GA4196@qwerty.qwertyembedded>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151030010151.GA4196-hEWAmvUofr51knWWc6b7UDvvZPQxeRhI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thursday 29 October 2015 20:01:51 Michael Welling wrote:
> On Fri, Oct 30, 2015 at 09:39:05AM +0900, Mark Brown wrote:
> > On Thu, Oct 29, 2015 at 03:23:31PM -0700, Dmitry Torokhov wrote:
> > 
> > > However, you have regmap in the driver core already. Mark, is it
> > > possible to have regmap API also allow doing raw underlying protocol
> > > transfer so that consumers could issue command requests without needing
> > > to know if they need to do it over i2c or spi or whatever. Or we need a
> > > notion of command registers in regmap...
> > 
> > I don't think it's a good idea to break the encapsulation of the regmap
> > and export the raw I/O functionality directly, there seem to be more bad
> > ways of using that than good.  The driver must at some point know what
> > bus it is dealing with and be able to manage this itself.
> > 
> > I don't know what "command registers" are.
> 
> With this device, if the MSB of the first byte of the transaction is 1 then
> a convertor command is encoded in that byte instead of a register address.
> 
> So here is my plan:
> - Add a function pointer for tsc2005_cmd in the struct tsc2005
> - Put the spi and i2c tsc2005_cmd versions in their respective drivers
> - Pass the cmd functions to the core via tsc200x_probe
> 
> Any objections?

Sounds good. If you end up needing more than one function pointer,
better pass a 'const' pointer to a structure of function pointers that
you can declare statically in the driver.

> Other review suggestions before I code the revision?
> Am I doing too much with a single patch?

Yes.

Please split out the DT binding changes into a separate patch, and
start with one patch that just moves the common parts out of the SPI
driver before you add the new driver.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
