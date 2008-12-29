From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] sh: maple: add support for the Maple mouse on the SEGA
 Dreamcast
Date: Mon, 29 Dec 2008 21:38:34 +0000
Message-ID: <1230586714.6496.29.camel@localhost.localdomain>
References: <1230578246.6496.25.camel@localhost.localdomain>
	 <200812291602.18572.vapier@gentoo.org>
	 <1230586215.6496.28.camel@localhost.localdomain>
	 <200812291636.36303.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <200812291636.36303.vapier@gentoo.org>
Sender: linux-sh-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2008-12-29 at 16:36 -0500, Mike Frysinger wrote:
> On Monday 29 December 2008 16:30:14 Adrian McMenamin wrote:
> > +static int __devexit remove_maple_mouse(struct device *dev)
> > +static struct maple_driver dc_mouse_driver = {
> > +	.drv = {
> > +		.remove = remove_maple_mouse,
> 
> does that really build warning free ?  usually you need __devexit_p() in the 
> .remove assignment ...
> -mike

Yep

adrian@bossclass:~/linux-2.6$ make ARCH=sh
CROSS_COMPILE=/home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/bin/sh4-linux- zImage modules -j4
scripts/kconfig/conf -s arch/sh/Kconfig
  CHK     include/linux/version.h
  SYMLINK include/asm -> include/asm-sh
make[1]: `include/asm-sh/machtypes.h' is up to date.
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      init/version.o
  CC      kernel/module.o
  LD      init/built-in.o
  CC [M]  drivers/input/mouse/maplemouse.o
  LD      kernel/built-in.o

