From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Fri, 22 May 2015 11:29:22 -0700
Message-ID: <20150522182922.GF40101@dtor-ws>
References: <555E4BF8.80401@web.de>
 <20150521230612.GA39517@dtor-ws>
 <555EBFF3.1010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37739 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536AbbEVS31 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 14:29:27 -0400
Received: by igbsb11 with SMTP id sb11so39021238igb.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 11:29:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555EBFF3.1010602@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, May 22, 2015 at 07:34:43AM +0200, Heiner Kallweit wrote:
> Am 22.05.2015 um 01:06 schrieb Dmitry Torokhov:
> > Hi Heiner,
> > 
> > On Thu, May 21, 2015 at 11:19:52PM +0200, Heiner Kallweit wrote:
> >> Even with poper DT config the module didn't autoload.
> >> That's fixed by this additional alias.
> >>
> >> Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
> >> on RPI2 under Arch Linux ARM (kernel 3.18.13).
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/input/touchscreen/stmpe-ts.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> >> index e4c3125..1940e3c 100644
> >> --- a/drivers/input/touchscreen/stmpe-ts.c
> >> +++ b/drivers/input/touchscreen/stmpe-ts.c
> >> @@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
> >>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
> >>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
> >>  MODULE_LICENSE("GPL");
> >> +MODULE_ALIAS("spi:" STMPE_TS_NAME);
> >>  MODULE_ALIAS("platform:" STMPE_TS_NAME);
> > 
> > Bit this is not an SPI driver, it is a platform driver for a MFD cell.
> > Why does adding SPI alias help?
> > 
> > Thanks.
> > 
> The STMPE610 in my case is used on a small touchscreen for the Raspberry Pi
> and touchscreen controller as well as display controller are connected via
> SPI + a few GPIOs to the RPI.
> 
> The display controller is supported by the fbtft driver and the drivers
> for the respective display controllers have similar aliases.
> see e.g. drivers/staging/fbtft/fb_hx8353d.c
> 
> MODULE_ALIAS("spi:hx8353d");
> MODULE_ALIAS("platform:hx8353d");

I understand why both platform and spi aliases are needed for
fb_hx8353d: FBTFT_REGISTER_DRIVER macro does register 2 separate
drivers, one SPI and another platform, and so needs both aliases. You
still have not explained why we need SPI alias for stmpe-ts which is MFD
cell represented by a platform device/driver no matter what bus is used
to connect stmpe itself, I2C or SPI.

What is the modalias on the stmpe-ts device in sysfs?

Thanks.

-- 
Dmitry
