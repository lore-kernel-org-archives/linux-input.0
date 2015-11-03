From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH 1/4] Input: tsc2005 - Separate SPI and core functions
Date: Tue, 3 Nov 2015 09:48:42 -0600
Message-ID: <20151103154842.GB13271@deathstar>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
 <1446252086-24334-2-git-send-email-mwelling@ieee.org>
 <20151103014946.GB32018@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151103014946.GB32018@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 02, 2015 at 05:49:46PM -0800, Dmitry Torokhov wrote:
> On Fri, Oct 30, 2015 at 07:41:23PM -0500, Michael Welling wrote:
> > This patch separates the SPI functionality from core functionality
> > that overlaps with the tsc2004.
> > 
> > Prepares kernel for new tsc2004 driver without much redundant code.
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > ---
> >  drivers/input/touchscreen/Kconfig                  |   4 +
> >  drivers/input/touchscreen/Makefile                 |   1 +
> >  drivers/input/touchscreen/tsc2005.c                | 709 +--------------------
> >  .../touchscreen/{tsc2005.c => tsc200x-core.c}      | 226 ++-----
> >  drivers/input/touchscreen/tsc200x-core.h           |  78 +++
> >  5 files changed, 162 insertions(+), 856 deletions(-)
> >  copy drivers/input/touchscreen/{tsc2005.c => tsc200x-core.c} (72%)
> >  create mode 100644 drivers/input/touchscreen/tsc200x-core.h
> 
> This was giving me:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#1451)
>   MODPOST 1447 modules
> ERROR: "tsc200x_regmap_config" [drivers/input/touchscreen/tsc2005.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> I'll fix it up locally by exporting the symbol.
> 
> Thanks.

Ooops. I guess that I need to check more thoroughly the different configs.

Thanks for your help.

> 
> -- 
> Dmitry
