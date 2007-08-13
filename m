From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
 declaration visible
Date: Mon, 13 Aug 2007 14:36:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
References: <20070812094050.522858761@mail.of.borg> <20070812094119.910815432@mail.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070812094119.910815432@mail.of.borg>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org, debian-68k@lists.debian.org
List-Id: linux-input@vger.kernel.org

> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible

With buttons emulation being available via uinput event devices, do we
still need the kernel mouse button emulation? At least on powerpc, it was
declared deprecated long ago ...

Anyone using mouseemu on m68k Mac?

	Michael
