From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Thu, 22 Oct 2009 12:11:03 +0200
Message-ID: <20091022101103.GR14091@buzzloop.caiaq.de>
References: <20091018072738.GF3935@core.coreip.homeip.net>
 <20091019073728.GC28832@buzzloop.caiaq.de>
 <20091020013852.GC24370@core.coreip.homeip.net>
 <20091020101357.GR28832@buzzloop.caiaq.de>
 <20091021043553.GA378@core.coreip.homeip.net>
 <20091021193347.GL14091@buzzloop.caiaq.de>
 <20091022012121.5b35ff22.const@mimas.ru>
 <20091021204158.GN14091@buzzloop.caiaq.de>
 <20091022023928.2a8afea8.const@mimas.ru>
 <20091022030909.742b3ba1.const@mimas.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753195AbZJVKLL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091022030909.742b3ba1.const@mimas.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Constantin Baranov <const@mimas.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 22, 2009 at 03:09:09AM +0500, Constantin Baranov wrote:
> On Thu, 22 Oct 2009 02:39:28 +0500 Constantin Baranov <const@mimas.ru> wrote:
> > On Wed, 21 Oct 2009 22:41:58 +0200 Daniel Mack <daniel@caiaq.de> wrote:
> > > On Thu, Oct 22, 2009 at 01:21:21AM +0500, Constantin Baranov wrote:
> > > > I wonder why do you integrate the input driver into the leds driver. They
> > > > should be separated. Or at least the complex driver should be moved to the
> > > > "X86 Platform Specific Device Drivers" and renamed to some like "PC Engines
> > > > ALIX Extras". I personally would prefer the separation way.
> > > 
> > > I would as well, yes. And I was of course considerating this when I
> > > hacked these lines. However, the major part of the LED driver and what
> > > it currently shares with the button implementation is the BIOS detection
> > > code which is so ugly that I didn't want to duplicate it ;) That would,
> > > however, be the only option if you wanted to split the drivers up. Or
> > > do you have any better idea?
> > 
> > We may introduce new ALIX2 extended platform (module in arch/x86/kernel).
> > In the init function it shall perform detection. The module shall export
> > the is_alix2() function which shall be called from init functions of drivers.
> > Also the cs5535_gpio driver could be reused for gpio access (the previous
> > patch for leds-alix2 is copy&paste from cs5535_gpio).
> 
> Moreover, the cs5535_gpio driver itself could be reworked and ported to
> the gpiolib. This goes far from initial task (button support) indeed :)

Indeed, agreed to all points, that would be the sane way to do it.
However, I won't have time to care for that soon. So the best thing to
do for now is drop the patch and leave it in the mail archives. And wait
untils eventually cares to do ir right :)

Daniel
