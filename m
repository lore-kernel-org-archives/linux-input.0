From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atkbd - add forced release kays quirk for
	Samsung N130
Date: Tue, 17 Nov 2009 21:16:05 -0800
Message-ID: <20091118051605.GA31480@core.coreip.homeip.net>
References: <20091116171814.GA26183@sig21.net> <20091116195443.GE24026@core.coreip.homeip.net> <20091116213425.GA2128@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752501AbZKRFQK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091116213425.GA2128@sig21.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 16, 2009 at 10:34:25PM +0100, Johannes Stezenbach wrote:
> Hi Dmitry,
> 
> On Mon, Nov 16, 2009 at 11:54:43AM -0800, Dmitry Torokhov wrote:
> > On Mon, Nov 16, 2009 at 06:18:14PM +0100, Johannes Stezenbach wrote:
> > > Samsung N130 has the same function key quirks as the NC10.
> > > 
> > > Signed-off-by: Johannes Stezenbach <js@sig21.net>
> > > ---
> > > It would be nice if this could go into 2.6.32.  It might also be
> > > suitable for stable.
> > 
> > 2.6.32 will allow manipulating force release quirk from userspace
> > (sysfs) so I stopped accepting in-kernel quirks like this one.
> 
> OK, makes sense.  Will this be put in udev along with
> the keymap setup for the function keys? 

I think that is the best place to put it, yes.

> If yes, is
> there already an example how to do it correctly so 
> I can submit a patch to add the N130 support there?

No, but you can be the first and pave the road ;)

-- 
Dmitry
