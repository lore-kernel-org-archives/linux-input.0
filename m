From: Ignacy =?iso-8859-2?Q?Gaw=EAdzki?= <bugs@qult.net>
Subject: Re: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 18:08:25 +0100
Message-ID: <20170202170825.r3ellulrx47kku35@zenon.in.qult.net>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
 <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
 <20170202164748.GB21924@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.193.33.39] ([78.193.33.39]:59134 "EHLO mail.qult.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbdBBRIb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 12:08:31 -0500
Content-Disposition: inline
In-Reply-To: <20170202164748.GB21924@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <Mario_Limonciello@dell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Feb 02, 2017 at 08:47:48AM -0800, thus spake Dmitry Torokhov:
> On Thu, Feb 02, 2017 at 09:40:33AM +0100, Ignacy Gawêdzki wrote:
> > On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry Torokhov:
> > > OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> > > KEY_END, and it seems that implementation of FN handling is very naive
> > > as it emits "release" keycodes for the state FN is currently in, not
> > > the state it was when key was pressed.
> > > 
> > > Ideally Dell would fix that. Mario, any chance of that?
> > 
> > I'm just wondering whether this is still something that could be fixed
> > or worked around in the input driver,
> 
> Well, obviously I'd rather fix the bug at its root rather than piling
> workarounds in the driver.

Sure, but supposing that the BIOS has to be fixed, I don't expect Dell
to release a fix for a model that's about five years old.  Unless
there's a good soul out there reading this and able to do anything
about it.

> > since the bug obviously doesn't
> > show up in neither in the linux console nor in Windows.
> 
> So where does it not work in Linux? Because keyboard driver in console
> and elsewhere is the same. Maybe it is not noticeable when in text
> console?

The bug appears only in X11.  Not in the console, although autorepeat
is active there too.

> In Windows the bug might be masked if they use hardware autorepeat for
> PS/2 keyboards. I don't know if they do or not.

I have no idea either.

-- 
To err is human, to purr feline.
