From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: input: i8042: build failure on powerpc
Date: Thu, 12 Nov 2015 16:01:45 +0100
Message-ID: <20151112150145.GC3758@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello

I have made a random .config for testing my powerpc cross-compiler and I got this fail:

  LD      init/built-in.o
drivers/built-in.o: In function `i8042_wait_write':
i8042.c:(.text+0x13d8be): undefined reference to `kb_cs'
i8042.c:(.text+0x13d8c6): undefined reference to `kb_cs'
i8042.c:(.text+0x13d8e6): undefined reference to `kb_cs'
drivers/built-in.o: In function `i8042_kbd_write':
i8042.c:(.text+0x13d9aa): undefined reference to `kb_data'
i8042.c:(.text+0x13d9ae): undefined reference to `kb_data'
drivers/built-in.o: In function `i8042_flush':
i8042.c:(.text+0x13da56): undefined reference to `kb_cs'
i8042.c:(.text+0x13da62): undefined reference to `kb_cs'
i8042.c:(.text+0x13da66): undefined reference to `kb_data'
i8042.c:(.text+0x13da86): undefined reference to `kb_data'
drivers/built-in.o: In function `i8042_panic_blink':
i8042.c:(.text+0x13db92): undefined reference to `kb_cs'
i8042.c:(.text+0x13db9a): undefined reference to `kb_cs'
i8042.c:(.text+0x13dc06): undefined reference to `kb_data'
i8042.c:(.text+0x13dc16): undefined reference to `kb_data'
i8042.c:(.text+0x13dc8a): undefined reference to `kb_data'
drivers/built-in.o: In function `i8042_interrupt':
i8042.c:(.text+0x13dd1a): undefined reference to `kb_cs'
i8042.c:(.text+0x13dd1e): undefined reference to `kb_cs'
i8042.c:(.text+0x13dd3e): undefined reference to `kb_data'
i8042.c:(.text+0x13dd42): undefined reference to `kb_data'
drivers/built-in.o: In function `__i8042_command':
i8042.c:(.text+0x13e2b6): undefined reference to `kb_cs'
i8042.c:(.text+0x13e2be): undefined reference to `kb_cs'
i8042.c:(.text+0x13e2ea): undefined reference to `kb_data'
i8042.c:(.text+0x13e302): undefined reference to `kb_data'
i8042.c:(.text+0x13e34e): undefined reference to `kb_cs'
i8042.c:(.text+0x13e362): undefined reference to `kb_cs'
i8042.c:(.text+0x13e366): undefined reference to `kb_data'
i8042.c:(.text+0x13e3de): undefined reference to `kb_data'
drivers/built-in.o: In function `i8042_aux_test_irq':
i8042.c:(.init.text+0x59a2): undefined reference to `kb_cs'
i8042.c:(.init.text+0x59a6): undefined reference to `kb_cs'
i8042.c:(.init.text+0x59ca): undefined reference to `kb_data'
i8042.c:(.init.text+0x59ce): undefined reference to `kb_data'
drivers/built-in.o: In function `i8042_probe':
i8042.c:(.init.text+0x5dda): undefined reference to `kb_cs'
i8042.c:(.init.text+0x5dde): undefined reference to `kb_cs'
i8042.c:(.init.text+0x6366): undefined reference to `kb_data'
i8042.c:(.init.text+0x6376): undefined reference to `kb_cs'
i8042.c:(.init.text+0x637a): undefined reference to `kb_data'
Makefile:929: recipe for target 'vmlinux' failed

it seems that kb_data and kb_cs (declared as extern in drivers/input/serio/i8042-ppcio.h) are defined anywhere.

Regards
