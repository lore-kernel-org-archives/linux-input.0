From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Add drivers for Logitech G110, G13, G15v2 and G19
Date: Sat, 21 Feb 2015 18:21:20 +0100
Message-ID: <1424539280.24292.33.camel@x220>
References: <2205053.ll7fhHWnZQ@pink>
	 <1424533803-17017-1-git-send-email-cheepeero@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424533803-17017-1-git-send-email-cheepeero@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ciprian Ciubotariu <cheepeero@gmx.net>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
List-Id: linux-input@vger.kernel.org

On Sat, 2015-02-21 at 17:50 +0200, Ciprian Ciubotariu wrote:
> New modules:
>   - hid-gcore - common functions
>   - hid-gfb   - framebuffer implementation
>   - hid-g110  - G110 driver
>   - hid-g13   - G13 driver
>   - hid-g15v2 - G15 v2 driver
>   - hid-g19   - G19 driver
> 
> Add Kconfig options for each driver, and a main menu option which is
> responsible for hid-gcore. hid-gfb is only selected when individual
> drivers need it.
> 
> Add product IDs to hid-ids.h, and blacklist them for hid-generic.

No Signed-off-by?

Apparently Alistair Buxton, Rick L Vinyard Jr, and Thomas Berger were
involved with this code too. There's no mention of them in the commit
explanation. They're also not CC-ed.

A few trivialities follow. And a question about the license of one of
these drivers.

>  drivers/hid/Kconfig     |  81 +++++
>  drivers/hid/Makefile    |   8 +
>  drivers/hid/hid-core.c  |   4 +
>  drivers/hid/hid-g110.c  | 789 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-g13.c   | 783 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-g15v2.c | 721 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-g19.c   | 882 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-gcore.c | 398 ++++++++++++++++++++++
>  drivers/hid/hid-gcore.h |  74 ++++
>  drivers/hid/hid-gfb.c   | 751 +++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-gfb.h   |  54 +++
>  drivers/hid/hid-ids.h   |   7 +
>  12 files changed, 4552 insertions(+)
>  create mode 100644 drivers/hid/hid-g110.c
>  create mode 100644 drivers/hid/hid-g13.c
>  create mode 100644 drivers/hid/hid-g15v2.c
>  create mode 100644 drivers/hid/hid-g19.c
>  create mode 100644 drivers/hid/hid-gcore.c
>  create mode 100644 drivers/hid/hid-gcore.h
>  create mode 100644 drivers/hid/hid-gfb.c
>  create mode 100644 drivers/hid/hid-gfb.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 152b006..5f28272 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -451,6 +451,87 @@ config LOGIWHEELS_FF
>  	  - Logitech MOMO/MOMO 2
>  	  - Logitech Formula Force EX
>  
> +config HID_LOGITECH_GSERIES
> +	tristate "Logitech G-Series devices"
> +	depends on HID
> +	depends on USB
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	Support for Logitech G-Series devices.
> +
> +	This option allows you to choose from a list of Logitech G-series devices.
> +	If your keyboard has an LCD display, you will have to enable framebuffer
> +	support (CONFIG_FB) to see it here.
> +
> +	If unsure, say N.
> +
> +	To compile this driver as a module, choose M here: the
> +	module will be called hid-gcore.

Please indent the help text bit more (ie, add two spaces, like the help
texts of the rest of the added entries have).

> +
> +config LOGITECH_GFB
> +	tristate
> +	depends on HID_LOGITECH_GSERIES
> +	depends on FB
> +	select FB_DEFERRED_IO
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	# select LCD_CLASS_DEVICE
> +	# select BACKLIGHT_CLASS_DEVICE
> +	# select BACKLIGHT_LCD_SUPPORT

Why did you add these comments?

> +
> +config LOGITECH_G110
> +	tristate "Logitech G110 keyboard"
> +	depends on HID_LOGITECH_GSERIES
> +	help
> +	  Say Y here if you have a Logitech G110 keyboard.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-g110.
> +
> +config LOGITECH_G13
> +	tristate "Logitech G13 keyboard"
> +	depends on HID_LOGITECH_GSERIES
> +	depends on FB
> +	select LOGITECH_GFB
> +	help
> +	  Say Y here if you have a Logitech G13 keyboard.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-g13.
> +
> +config LOGITECH_G15V2
> +	tristate "Logitech G15 Version 2 keyboard"
> +	depends on HID_LOGITECH_GSERIES
> +	depends on FB
> +	select LOGITECH_GFB
> +	help
> +	  Say Y here if you have a Logitech G15 Version 2 keyboard.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-g15v2.
> +
> +config LOGITECH_G19
> +	tristate "Logitech G19 keyboard"
> +	depends on HID_LOGITECH_GSERIES
> +	depends on FB
> +	select LOGITECH_GFB
> +	help
> +	  Say Y here if you have a Logitech G19 keyboard.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-g19.
> +
>  config HID_MAGICMOUSE
>  	tristate "Apple Magic Mouse/Trackpad multi-touch support"
>  	depends on HID

[...]

> diff --git a/drivers/hid/hid-g19.c b/drivers/hid/hid-g19.c
> new file mode 100644
> index 0000000..366d2d5
> --- /dev/null
> +++ b/drivers/hid/hid-g19.c
> @@ -0,0 +1,882 @@
> +/***************************************************************************
> + *   Copyright (C) 2010 by Alistair Buxton				   *
> + *   a.j.buxton@gmail.com						   *
> + *   based on hid-g13.c							   *
> + *									   *
> + *   This program is free software: you can redistribute it and/or modify  *
> + *   it under the terms of the GNU General Public License as published by  *
> + *   the Free Software Foundation, either version 2 of the License, or	   *
> + *   (at your option) any later version.				   *
> + *									   *
> + *   This driver is distributed in the hope that it will be useful, but	   *
> + *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
> + *   General Public License for more details.				   *
> + *									   *
> + *   You should have received a copy of the GNU General Public License	   *
> + *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
> + ***************************************************************************/

[...]

> +MODULE_DESCRIPTION("Logitech G19 HID Driver");
> +MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
> +MODULE_AUTHOR("Thomas Berger (tbe@boreus.de)");
> +MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
> +MODULE_LICENSE("GPL v2");

This means GPL v2 only. The comment header has or later. Which is right?

Thanks,


Paul Bolle
