From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 20:01:51 -0500
Message-ID: <20151030010151.GA4196@qwerty.qwertyembedded>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <201510291514.OprNyiZf%fengguang.wu@intel.com>
 <20151029142237.GA11531@qwerty.qwertyembedded>
 <4152426.STHOuGxqsW@wuerfel>
 <20151029215353.GA10355@deathstar>
 <20151029222331.GA1419@localhost>
 <20151030003905.GL28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34773 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbJ3BCF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 21:02:05 -0400
Content-Disposition: inline
In-Reply-To: <20151030003905.GL28319@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Oct 30, 2015 at 09:39:05AM +0900, Mark Brown wrote:
> On Thu, Oct 29, 2015 at 03:23:31PM -0700, Dmitry Torokhov wrote:
> 
> > However, you have regmap in the driver core already. Mark, is it
> > possible to have regmap API also allow doing raw underlying protocol
> > transfer so that consumers could issue command requests without needing
> > to know if they need to do it over i2c or spi or whatever. Or we need a
> > notion of command registers in regmap...
> 
> I don't think it's a good idea to break the encapsulation of the regmap
> and export the raw I/O functionality directly, there seem to be more bad
> ways of using that than good.  The driver must at some point know what
> bus it is dealing with and be able to manage this itself.
> 
> I don't know what "command registers" are.

With this device, if the MSB of the first byte of the transaction is 1 then
a convertor command is encoded in that byte instead of a register address.

So here is my plan:
- Add a function pointer for tsc2005_cmd in the struct tsc2005
- Put the spi and i2c tsc2005_cmd versions in their respective drivers
- Pass the cmd functions to the core via tsc200x_probe

Any objections?
Other review suggestions before I code the revision?
Am I doing too much with a single patch?

