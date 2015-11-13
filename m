From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: Re: input: i8042: build failure on powerpc
Date: Fri, 13 Nov 2015 09:35:59 +0100
Message-ID: <20151113083559.GA12869@Red>
References: <20151112150145.GC3758@Red>
 <20151112154117.GA21686@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34311 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbKMIgD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 03:36:03 -0500
Content-Disposition: inline
In-Reply-To: <20151112154117.GA21686@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, Nov 12, 2015 at 07:41:17AM -0800, Guenter Roeck wrote:
> On Thu, Nov 12, 2015 at 04:01:45PM +0100, LABBE Corentin wrote:
> > Hello
> > 
> > I have made a random .config for testing my powerpc cross-compiler and I got this fail:
> > 
> 
> In general it helps to provide the broken configuration.
> 
> If you do some digging, you may notice that this has been broken
> since commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc"),
> or in other words since 2008. CONFIG_INPUT is not set with walnut_defconfig,
> which may explain why no one noticed.
> 
> I would suggest to just remove the offending code. Quite obviously it is dead.
> 

Just for be clear, you suggest that I make a patch for removing powerpc support of the i8042 driver ?
I have add linuxppc-dev@lists.ozlabs.org to the discution.

Regards

> >   LD      init/built-in.o
> > drivers/built-in.o: In function `i8042_wait_write':
> > i8042.c:(.text+0x13d8be): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13d8c6): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13d8e6): undefined reference to `kb_cs'
> > drivers/built-in.o: In function `i8042_kbd_write':
> > i8042.c:(.text+0x13d9aa): undefined reference to `kb_data'
> > i8042.c:(.text+0x13d9ae): undefined reference to `kb_data'
> > drivers/built-in.o: In function `i8042_flush':
> > i8042.c:(.text+0x13da56): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13da62): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13da66): undefined reference to `kb_data'
> > i8042.c:(.text+0x13da86): undefined reference to `kb_data'
> > drivers/built-in.o: In function `i8042_panic_blink':
> > i8042.c:(.text+0x13db92): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13db9a): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13dc06): undefined reference to `kb_data'
> > i8042.c:(.text+0x13dc16): undefined reference to `kb_data'
> > i8042.c:(.text+0x13dc8a): undefined reference to `kb_data'
> > drivers/built-in.o: In function `i8042_interrupt':
> > i8042.c:(.text+0x13dd1a): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13dd1e): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13dd3e): undefined reference to `kb_data'
> > i8042.c:(.text+0x13dd42): undefined reference to `kb_data'
> > drivers/built-in.o: In function `__i8042_command':
> > i8042.c:(.text+0x13e2b6): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13e2be): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13e2ea): undefined reference to `kb_data'
> > i8042.c:(.text+0x13e302): undefined reference to `kb_data'
> > i8042.c:(.text+0x13e34e): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13e362): undefined reference to `kb_cs'
> > i8042.c:(.text+0x13e366): undefined reference to `kb_data'
> > i8042.c:(.text+0x13e3de): undefined reference to `kb_data'
> > drivers/built-in.o: In function `i8042_aux_test_irq':
> > i8042.c:(.init.text+0x59a2): undefined reference to `kb_cs'
> > i8042.c:(.init.text+0x59a6): undefined reference to `kb_cs'
> > i8042.c:(.init.text+0x59ca): undefined reference to `kb_data'
> > i8042.c:(.init.text+0x59ce): undefined reference to `kb_data'
> > drivers/built-in.o: In function `i8042_probe':
> > i8042.c:(.init.text+0x5dda): undefined reference to `kb_cs'
> > i8042.c:(.init.text+0x5dde): undefined reference to `kb_cs'
> > i8042.c:(.init.text+0x6366): undefined reference to `kb_data'
> > i8042.c:(.init.text+0x6376): undefined reference to `kb_cs'
> > i8042.c:(.init.text+0x637a): undefined reference to `kb_data'
> > Makefile:929: recipe for target 'vmlinux' failed
> > 
> > it seems that kb_data and kb_cs (declared as extern in drivers/input/serio/i8042-ppcio.h) are defined anywhere.
> > 
> > Regards
