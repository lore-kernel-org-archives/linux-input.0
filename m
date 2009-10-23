From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Fri, 23 Oct 2009 22:29:07 +0200
Message-ID: <20091023202906.GD27185@elf.ucw.cz>
References: <87eiss7uhb.fsf@basil.nowhere.org>
 <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de>
 <20090708065325.GE3309@dtor-d630.eng.vmware.com>
 <alpine.LNX.2.00.0907081317000.27327@wotan.suse.de>
 <20091014045851.GA32413@core.coreip.homeip.net>
 <20091014071950.GF23248@one.firstfloor.org>
 <20091014073927.GB5318@core.coreip.homeip.net>
 <20091019213836.GD1482@ucw.cz>
 <20091021081529.GA1070@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751556AbZJWU3K@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091021081529.GA1070@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Kosina <jkosina@suse.cz>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed 2009-10-21 01:15:30, Dmitry Torokhov wrote:
> On Mon, Oct 19, 2009 at 11:38:36PM +0200, Pavel Machek wrote:
> > On Wed 2009-10-14 00:39:28, Dmitry Torokhov wrote:
> > > On Wed, Oct 14, 2009 at 09:19:50AM +0200, Andi Kleen wrote:
> > > > > Btw, what kind of keyboard is this? I was playing today but I could not
> > > > > get my USB keyboards to report release of more than 1 key per report....
> > > > 
> > > > The log was with a PS/2<->USB adapter, with a PS/2 keyboard connected
> > > > to a USB port through it.
> > > > 
> > > 
> > > Hmm, I don't think I have one of those... It is curious beast - we have
> > > software autorepeat for HID but PS/2 keyboards do autorepeat
> > > themselves... What will combination do?
> > 
> > I always wondered how that's supposed to work... on loaded system. As
> > linux is not realtime system, it can't, afaict.
> 
> What exactly requires realtime? Surely not autorepeat...

Well, ps/2 does not provide timestamps, neither does USB AFAICT. So if
you hit say interrupt latency, you'll repeat keys one too many times
or something.

[But if X does autorepeat in software, that's even worse. That means
that scheduling latency can cause autorepeat glitches, and that's
probably what I'm seeing here. And I haaaaaaaaaaaaaaate when my
tyyyyyyping goes like this just because I have background load.]

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
