From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
 declaration visible
Date: Mon, 13 Aug 2007 15:57:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708131552400.8645@anakin>
References: <20070812094050.522858761@mail.of.borg> <20070812094119.910815432@mail.of.borg>
 <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
 <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
 <Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Sender: geert@linux-m68k.org
In-Reply-To: <Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
Resent-Message-ID: <lzQnXD.A.iSH.iRGwGB@murphy>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Finn Thain <fthain@telegraphics.com.au>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org, debian-68k@lists.debian.org
List-Id: linux-input@vger.kernel.org

On Mon, 13 Aug 2007, Michael Schmitz wrote:
> > > Anyone using mouseemu on m68k Mac?
> >
> > Yes, and on powermac too. It provides the paste key for gpm and I'm quite
> > fond of it. But if there's a better alternative, I'll happily try it
> > instead.
> 
> Too much overhead on m68k? On powermac it never gave me trouble, but I was
> surprised to hear people use it on m68k.
> 
> If it works OK, we can really drop the kernel support.

If it can be removed completely, for PowerMac, Mac/m68k, and IntelliMac (or
whatever it's called), fine for me!  Please coordinate with the other
Mac people.

But for now, Linus, please apply, as the missing prototype causes a
broken Mac/m68k build.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
