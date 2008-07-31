From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: Tree for July 30
Date: Thu, 31 Jul 2008 14:17:31 -0400
Message-ID: <20080731141302.ZZRA012@mailhub.coreip.homeip.net>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au> <20080730231029.9818953c.akpm@linux-foundation.org> <20080731140708.GA11229@core.corenet.prv> <58cb370e0807310836x4a6e3c40rf5c3c8ec8b5caae0@mail.gmail.com> <20080731115301.ZZRA012@mailhub.coreip.homeip.net> <20080731104437.5e5669bc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080731104437.5e5669bc.akpm@linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 31, 2008 at 10:44:37AM -0700, Andrew Morton wrote:
> On Thu, 31 Jul 2008 11:56:48 -0400 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Thu, Jul 31, 2008 at 05:36:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Thu, Jul 31, 2008 at 4:07 PM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Wed, Jul 30, 2008 at 11:10:29PM -0700, Andrew Morton wrote:
> > > >> On Wed, 30 Jul 2008 17:06:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >>
> > > >> > I have created today's linux-next tree at
> > > >> > git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> > > >>
> > > >> The X server broke on my FC8 t61p thinkpad.  Mainline is OK.
> > > >>
> > > >> Various information is at http://userweb.kernel.org/~akpm/mo/
> > > >>
> > > >> I'm suspecting the input layer - my synaptics device seems to have
> > > >> disappeared?  See http://userweb.kernel.org/~akpm/mo/Xorg-log-diff.txt
> > > >>
> > > >
> > > > I think this patch should help with Synaptics:
> > > 
> > > Which unfortunately doesn't help all people running with older synaptics
> > > user-space after commit 0571c5d20aca71c735222132b02aebddf593045c
> > > ("Input: expand keycode space").
> > > 
> > > Can't this be solved without breaking Xorg on newer kernels running
> > > older synaptics?
> > > 
> > 
> > No. The X driver is broken. It tells kernel to use buffer bugger than
> > allocated and gets its stack smashed. Tslib has also soma funkiness
> > in the ioctl handling as well... *shrug*
> > 
> > We have a couple months to get distros updated...
> > 
> 
> aaarrrrgggggghhh.  I don't think this is practical.  This means that
> (for example) FC5 machines (of which I happen to have one) are dead. 
> And lots of other older-distro-based systems.
> 
> Is there some userspace workaround which doesn't require an X server
> update?
> 
> Surely it must be possible to make the kernel contiue to support these
> servers?
> 

Andrew,

It is not like we broke ABI here. The progam (synaptics driver) had a
grave bug. Older kernels happened to paper over the bug because they
did not fill the whole buffer that was advertised as available. Now
that we have more data to report the bug bit us. What do you want me
to do?

Synaptics driver is a small package and takes 2 minutes to recompile.
You don't have to update entire X server with it (in fact I don't think
it is even part of X distribution because it is GPL).

-- 
Dmitry
