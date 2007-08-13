From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
 declaration visible
Date: Mon, 13 Aug 2007 23:09:30 +1000 (EST)
Message-ID: <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
References: <20070812094050.522858761@mail.of.borg> <20070812094119.910815432@mail.of.borg>
 <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org, debian-68k@lists.debian.org
List-Id: linux-input@vger.kernel.org



On Mon, 13 Aug 2007, Michael Schmitz wrote:

> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
> 
> With buttons emulation being available via uinput event devices, do we 
> still need the kernel mouse button emulation? At least on powerpc, it 
> was declared deprecated long ago ...
>
> Anyone using mouseemu on m68k Mac?

Yes, and on powermac too. It provides the paste key for gpm and I'm quite 
fond of it. But if there's a better alternative, I'll happily try it 
instead.

-f

> 
> 	Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
