From: Ciprian Ciubotariu <cheepeero@gmx.net>
Subject: Re: [PATCH] Add drivers for Logitech G110, G13, G15v2 and G19
Date: Mon, 23 Feb 2015 22:47:25 +0200
Message-ID: <2215516.4kP1VObgmA@pink>
References: <2205053.ll7fhHWnZQ@pink> <1424533803-17017-1-git-send-email-cheepeero@gmx.net> <1424539280.24292.33.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:62908 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbbBWUro (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 15:47:44 -0500
In-Reply-To: <1424539280.24292.33.camel@x220>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Bruno Premont <bonbons@linux-vserver.org>

On Saturday 21 February 2015 18:21:20 Paul Bolle wrote:
> On Sat, 2015-02-21 at 17:50 +0200, Ciprian Ciubotariu wrote:
> > New modules:
> >   - hid-gcore - common functions
> >   - hid-gfb   - framebuffer implementation
> >   - hid-g110  - G110 driver
> >   - hid-g13   - G13 driver
> >   - hid-g15v2 - G15 v2 driver
> >   - hid-g19   - G19 driver
> > 
> > Add Kconfig options for each driver, and a main menu option which is
> > responsible for hid-gcore. hid-gfb is only selected when individual
> > drivers need it.
> > 
> > Add product IDs to hid-ids.h, and blacklist them for hid-generic.
> 
> No Signed-off-by?

I'll make sure to add it on the next PATCH version.

> 
> Apparently Alistair Buxton, Rick L Vinyard Jr, and Thomas Berger were
> involved with this code too. There's no mention of them in the commit
> explanation. They're also not CC-ed.

The driver moved around with a lot of people contributing small changes. Some 
(including myself) chose to add a MODULE_AUTHOR line, but others didn't. While 
I can list all contributors from the git fork I found, I am sure I won't be 
able to track those before the git fork.

What is the appropriate follow-up? Add all contributors to MODULE_AUTHOR? 
Leave them as is? Which ones should be CC'ed?

> 
> A few trivialities follow. And a question about the license of one of
> these drivers.
> 
> >  drivers/hid/Kconfig     |  81 +++++
> >  drivers/hid/Makefile    |   8 +
> >  drivers/hid/hid-core.c  |   4 +
> >  drivers/hid/hid-g110.c  | 789 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-g13.c   | 783 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-g15v2.c | 721 +++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-g19.c   | 882
> >  ++++++++++++++++++++++++++++++++++++++++++++++++ drivers/hid/hid-gcore.c
> >  | 398 ++++++++++++++++++++++
> >  drivers/hid/hid-gcore.h |  74 ++++
> >  drivers/hid/hid-gfb.c   | 751 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/hid/hid-gfb.h   |  54 +++
> >  drivers/hid/hid-ids.h   |   7 +
> >  12 files changed, 4552 insertions(+)
> >  create mode 100644 drivers/hid/hid-g110.c
> >  create mode 100644 drivers/hid/hid-g13.c
> >  create mode 100644 drivers/hid/hid-g15v2.c
> >  create mode 100644 drivers/hid/hid-g19.c
> >  create mode 100644 drivers/hid/hid-gcore.c
> >  create mode 100644 drivers/hid/hid-gcore.h
> >  create mode 100644 drivers/hid/hid-gfb.c
> >  create mode 100644 drivers/hid/hid-gfb.h
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 152b006..5f28272 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -451,6 +451,87 @@ config LOGIWHEELS_FF
> > 
> >  	  - Logitech MOMO/MOMO 2
> >  	  - Logitech Formula Force EX
> > 
> > +config HID_LOGITECH_GSERIES
> > +	tristate "Logitech G-Series devices"
> > +	depends on HID
> > +	depends on USB
> > +	select NEW_LEDS
> > +	select LEDS_CLASS
> > +	help
> > +	Support for Logitech G-Series devices.
> > +
> > +	This option allows you to choose from a list of Logitech G-series
> > devices. +	If your keyboard has an LCD display, you will have to 
enable
> > framebuffer +	support (CONFIG_FB) to see it here.
> > +
> > +	If unsure, say N.
> > +
> > +	To compile this driver as a module, choose M here: the
> > +	module will be called hid-gcore.
> 
> Please indent the help text bit more (ie, add two spaces, like the help
> texts of the rest of the added entries have).

Will do.

> 
> > +
> > +config LOGITECH_GFB
> > +	tristate
> > +	depends on HID_LOGITECH_GSERIES
> > +	depends on FB
> > +	select FB_DEFERRED_IO
> > +	select FB_SYS_FILLRECT
> > +	select FB_SYS_COPYAREA
> > +	select FB_SYS_IMAGEBLIT
> > +	select FB_SYS_FOPS
> > +	# select LCD_CLASS_DEVICE
> > +	# select BACKLIGHT_CLASS_DEVICE
> > +	# select BACKLIGHT_LCD_SUPPORT
> 
> Why did you add these comments?

Leftovers. Thanks for pointing them out.

> > +
> > +config LOGITECH_G110
> > +	tristate "Logitech G110 keyboard"
> > +	depends on HID_LOGITECH_GSERIES
> > +	help
> > +	  Say Y here if you have a Logitech G110 keyboard.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-g110.
> > +
> > +config LOGITECH_G13
> > +	tristate "Logitech G13 keyboard"
> > +	depends on HID_LOGITECH_GSERIES
> > +	depends on FB
> > +	select LOGITECH_GFB
> > +	help
> > +	  Say Y here if you have a Logitech G13 keyboard.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-g13.
> > +
> > +config LOGITECH_G15V2
> > +	tristate "Logitech G15 Version 2 keyboard"
> > +	depends on HID_LOGITECH_GSERIES
> > +	depends on FB
> > +	select LOGITECH_GFB
> > +	help
> > +	  Say Y here if you have a Logitech G15 Version 2 keyboard.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-g15v2.
> > +
> > +config LOGITECH_G19
> > +	tristate "Logitech G19 keyboard"
> > +	depends on HID_LOGITECH_GSERIES
> > +	depends on FB
> > +	select LOGITECH_GFB
> > +	help
> > +	  Say Y here if you have a Logitech G19 keyboard.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called hid-g19.
> > +
> > 
> >  config HID_MAGICMOUSE
> >  
> >  	tristate "Apple Magic Mouse/Trackpad multi-touch support"
> >  	depends on HID
> 
> [...]
> 
> > diff --git a/drivers/hid/hid-g19.c b/drivers/hid/hid-g19.c
> > new file mode 100644
> > index 0000000..366d2d5
> > --- /dev/null
> > +++ b/drivers/hid/hid-g19.c
> > @@ -0,0 +1,882 @@
> > +/************************************************************************
> > *** + *   Copyright (C) 2010 by Alistair Buxton				   *
> > + *   a.j.buxton@gmail.com						   *
> > + *   based on hid-g13.c							   *
> > + *									   *
> > + *   This program is free software: you can redistribute it and/or modify
> >  * + *   it under the terms of the GNU General Public License as
> > published by  * + *   the Free Software Foundation, either version 2 of
> > the License, or	   * + *   (at your option) any later version.			
	   *
> > + *									   *
> > + *   This driver is distributed in the hope that it will be useful, but	 
> >  * + *   WITHOUT ANY WARRANTY; without even the implied warranty of		   
*
> > + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	  
> > * + *   General Public License for more details.				   *
> > + *									   *
> > + *   You should have received a copy of the GNU General Public License	  
> > * + *   along with this software. If not see
> > <http://www.gnu.org/licenses/>.  * +
> > *************************************************************************
> > **/
> [...]
> 
> > +MODULE_DESCRIPTION("Logitech G19 HID Driver");
> > +MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
> > +MODULE_AUTHOR("Thomas Berger (tbe@boreus.de)");
> > +MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
> > +MODULE_LICENSE("GPL v2");
> 
> This means GPL v2 only. The comment header has or later. Which is right?
> 

I have contacted the author of that change, and he reverted the line to 
MODULE_LICENSE("GPL").

https://github.com/CMoH/lg4l/commit/957cfd1e17b55dea4bcd4ec70fb4e53ebd52d149

> Thanks,
> 
> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
