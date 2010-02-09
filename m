From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 02/03] input: bitmap update for sh_keysc
Date: Tue, 9 Feb 2010 10:17:41 +0900
Message-ID: <20100209011741.GC14586@linux-sh.org>
References: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se> <20100208063234.2003.7539.sendpatchset@rxone.opensource.se> <20100208071843.GA22911@core.coreip.homeip.net> <aec7e5c31002072341i33ddc56cwde2776cf89a585c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:44563 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0BIBRo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 20:17:44 -0500
Content-Disposition: inline
In-Reply-To: <aec7e5c31002072341i33ddc56cwde2776cf89a585c6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Feb 08, 2010 at 04:41:16PM +0900, Magnus Damm wrote:
> Hi Dmitry,
> 
> On Mon, Feb 8, 2010 at 4:18 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Feb 08, 2010 at 03:32:34PM +0900, Magnus Damm wrote:
> >>
> >> +#define WRAP(fn, m...) bitmap_##fn(m, SH_KEYSC_MAXKEYS)
> >> +#define sh_keysc_map_zero(m) WRAP(zero, (m)->b)
> >> +#define sh_keysc_map_fill(m) WRAP(fill, (m)->b)
> >> +#define sh_keysc_map_and(m, m2) WRAP(and, (m)->b, (m)->b, (m2)->b)
> >> +#define sh_keysc_map_or(m, m2) WRAP(or, (m)->b, (m)->b, (m2)->b)
> >> +#define sh_keysc_map_complement(m) WRAP(complement, (m)->b, (m)->b)
> >> +#define sh_keysc_map_set(m, n) set_bit((n), (m)->b)
> >> +#define sh_keysc_map_clear(m, n) clear_bit((n), (m)->b)
> >> +#define sh_keysc_map_test(m, n) test_bit((n), (m)->b)
> >> +
> >
> > Why do you need these wrappers? For me they simply create a distraction,
> > later when I read the code I will have to go and look up what
> > sh_keysc_map_set() means but if I see __set_bit() I'd know right away.
> 
> To avoid duplicating SH_KEYSC_MAXKEYS all over the place I started out
> by wrapping bitmap_zero/fill/and/or/complement(). To be consistent I
> decided to wrap the set/clear/test_bit() functions as well, but it may
> be better to leave them alone.
> 
> Are you ok with wrapping the bitmap_...() functions to avoid
> duplicating SH_KEYSC_MAXKEYS?
> 
I don't see the point, either. The bitmap routines take the maximum size
of the bitmap as an argument, and so code that uses the API heavily and
has the size defined in a macro is going to have it sprinkled around, who
cares?

Wrapping up the bitmap API in your own wrappers to hide this fact only
makes it more confusing and really doesn't buy you anything. While things
like sh_keysc_map_set/clear() might seem obvious enough, it's also
impossible to tell whether these employ __set_bit()/__clear_bit() or
set_bit()/clear_bit() semantics without having to scroll back and look
them up. The added obfuscation to save yourself from having to sprinkle
SH_KEYSC_MAXKEYS around simply isn't worth it.

Any time you start out wrapping an existing API for private driver use
outside of things like I/O accessors, you're almost certainly going to
run in to trouble.
