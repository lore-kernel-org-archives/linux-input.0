From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2/8] m68k: Atari keyboard ACIA driver cleanup
Date: Mon, 15 Oct 2007 09:19:48 -0400
Message-ID: <d120d5000710150619l7d4c18f6jb51a59e5f5c12c43@mail.gmail.com>
References: <20071013123123.085686856@mail.of.borg>
	 <20071013123412.672481897@mail.of.borg> <jed4vjrpwk.fsf@sykes.suse.de>
	 <Pine.LNX.4.64.0710132027010.15951@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764912AbXJONUA@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0710132027010.15951@anakin>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
List-Id: linux-input@vger.kernel.org

On 10/13/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, 13 Oct 2007, Andreas Schwab wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > > --- a/arch/m68k/atari/atakeyb.c
> > > +++ b/arch/m68k/atari/atakeyb.c
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * linux/atari/atakeyb.c
> > > + * linux/arch/m68k/atari/atakeyb.c
> >
> > Please kill that line.
>
> Done. New version below:
>
> Subject: m68k: Atari keyboard ACIA driver cleanup
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
>
> m68k: Atari keyboard ACIA driver cleanup:
>  - removed dead key autorepeat code
>  - removed hardcoded initial keymap
>
> Signed-off-by: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good, thank you Geert. I understand Linus will merge this...

-- 
Dmitry
