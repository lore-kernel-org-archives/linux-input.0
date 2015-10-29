From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Thu, 29 Oct 2015 16:53:53 -0500
Message-ID: <20151029215353.GA10355@deathstar>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <201510291514.OprNyiZf%fengguang.wu@intel.com>
 <20151029142237.GA11531@qwerty.qwertyembedded>
 <4152426.STHOuGxqsW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35803 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbJ2VyH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 17:54:07 -0400
Content-Disposition: inline
In-Reply-To: <4152426.STHOuGxqsW@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Oct 29, 2015 at 10:46:20PM +0100, Arnd Bergmann wrote:
> On Thursday 29 October 2015 09:22:37 Michael Welling wrote:
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/built-in.o: In function `tsc2005_cmd':
> > > >> tsc200x-core.c:(.text+0x2ae07f): undefined reference to `i2c_smbus_write_byte'
> > 
> > Argh!
> > 
> > How do I fix this one?
> > 
> 
> Move all the I2C specific code into the tsc2004.c file and remove the
> #ifdef. The problem is that tsc200x-core.c is used as built-in when
> TOUCHSCREEN_TSC2005=y and I2C=m, so it can't call functions that are
> defined in i2c-core.c.

How would I call the function from the core then?

-Michael
> 
> 	Arnd
