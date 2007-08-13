From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
 declaration visible
Date: Mon, 13 Aug 2007 15:35:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
References: <20070812094050.522858761@mail.of.borg> <20070812094119.910815432@mail.of.borg>
 <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
 <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org, debian-68k@lists.debian.org
List-Id: linux-input@vger.kernel.org

> > Anyone using mouseemu on m68k Mac?
>
> Yes, and on powermac too. It provides the paste key for gpm and I'm quite
> fond of it. But if there's a better alternative, I'll happily try it
> instead.

Too much overhead on m68k? On powermac it never gave me trouble, but I was
surprised to hear people use it on m68k.

If it works OK, we can really drop the kernel support.

	Michael
