From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 15:23:31 -0700
Message-ID: <20151029222331.GA1419@localhost>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <201510291514.OprNyiZf%fengguang.wu@intel.com>
 <20151029142237.GA11531@qwerty.qwertyembedded>
 <4152426.STHOuGxqsW@wuerfel>
 <20151029215353.GA10355@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151029215353.GA10355@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 29, 2015 at 04:53:53PM -0500, Michael Welling wrote:
> On Thu, Oct 29, 2015 at 10:46:20PM +0100, Arnd Bergmann wrote:
> > On Thursday 29 October 2015 09:22:37 Michael Welling wrote:
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >    drivers/built-in.o: In function `tsc2005_cmd':
> > > > >> tsc200x-core.c:(.text+0x2ae07f): undefined reference to `i2c_smbus_write_byte'
> > > 
> > > Argh!
> > > 
> > > How do I fix this one?
> > > 
> > 
> > Move all the I2C specific code into the tsc2004.c file and remove the
> > #ifdef. The problem is that tsc200x-core.c is used as built-in when
> > TOUCHSCREEN_TSC2005=y and I2C=m, so it can't call functions that are
> > defined in i2c-core.c.
> 
> How would I call the function from the core then?

You can pass a cmd function from the transport module into core module
and store and use it.

However, you have regmap in the driver core already. Mark, is it
possible to have regmap API also allow doing raw underlying protocol
transfer so that consumers could issue command requests without needing
to know if they need to do it over i2c or spi or whatever. Or we need a
notion of command registers in regmap...

Thanks.

-- 
Dmitry
