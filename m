From: Ignacy =?iso-8859-2?Q?Gaw=EAdzki?= <bugs@qult.net>
Subject: Re: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 18:50:23 +0100
Message-ID: <20170202175023.2fjjoij7p5r3xrsl@zenon.in.qult.net>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
 <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
 <20170202164748.GB21924@dtor-ws>
 <20170202170825.r3ellulrx47kku35@zenon.in.qult.net>
 <156e931c68344eccb7360df7c15f6577@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.193.33.39] ([78.193.33.39]:59368 "EHLO mail.qult.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbdBBRub (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 12:50:31 -0500
Content-Disposition: inline
In-Reply-To: <156e931c68344eccb7360df7c15f6577@ausx13mpc124.AMER.DELL.COM>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Thu, Feb 02, 2017 at 05:15:02PM +0000, thus spake Mario.Limonciello@dell.com:
> > -----Original Message-----
> > From: Ignacy Gawêdzki [mailto:bugs@qult.net]
> > Sent: Thursday, February 2, 2017 11:08 AM
> > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; linux-
> > input@vger.kernel.org
> > Subject: Re: Dell XPS 13 Fn key bug?
> > 
> > On Thu, Feb 02, 2017 at 08:47:48AM -0800, thus spake Dmitry Torokhov:
> > > On Thu, Feb 02, 2017 at 09:40:33AM +0100, Ignacy Gawêdzki wrote:
> > > > On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry Torokhov:
> > > > > OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> > > > > KEY_END, and it seems that implementation of FN handling is very
> > > > > naive as it emits "release" keycodes for the state FN is currently
> > > > > in, not the state it was when key was pressed.
> > > > >
> > > > > Ideally Dell would fix that. Mario, any chance of that?
> > > >
> > > > I'm just wondering whether this is still something that could be
> > > > fixed or worked around in the input driver,
> > >
> > > Well, obviously I'd rather fix the bug at its root rather than piling
> > > workarounds in the driver.
> > 
> > Sure, but supposing that the BIOS has to be fixed, I don't expect Dell to release
> > a fix for a model that's about five years old.  Unless there's a good soul out
> > there reading this and able to do anything about it.
> > 
> 
> There hasn't been any maintenance BIOS releases for the L322X since around the
> end of 2013.
> I won't be able to get anyone to spin up resources on this unless it
> was a major security vulnerability or proverbial kitten killer type
> of bug.

Yeah well, obviously it's not the former.  As for the latter, the
qualification is very subjective.  It's very annoying when it happens,
but I must admit I can sort of live with it (I already have for all
these years).  It's just a pity such a lame thing hasn't shown up
before production, supposing it is actually something that can be
fixed with a BIOS patch (a question which hasn't been answered yet).
Anyway, God certainly kills a kitten every time my auto-repeat gets
stuck. :/

-- 
To err is human, to purr feline.
