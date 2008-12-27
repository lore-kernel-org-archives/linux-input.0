From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input/keyboard/hilkbd.c: fix crash when removing hilkbd
 module
Date: Sat, 27 Dec 2008 18:47:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812271847140.20983@anakin>
References: <495535B9.5070009@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <495535B9.5070009@gmx.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frans Pop <elendil@planet.nl>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 26 Dec 2008, Helge Deller wrote:
> On parisc machines, which don't have HIL, removing the hilkbd module
> panics the kernel. Fix this by adding proper implementations for the
> probe and remove functions to the parisc_driver structure.
> 
> A few functions were renamed to clean up the code and make it easier
> readable.
> 
> Disable the MODULE_DEVICE_TABLE() macro on parisc since the kernel
> module autoloader should instead prefer the hp_sdc driver which takes
> care of full HIL support, including HIL mouse and HIL tablets.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>

Looks OK, and still compiles fine on m68k/HP300.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
