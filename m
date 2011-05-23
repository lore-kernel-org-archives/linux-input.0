From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: select() on /dev/input/eventX not level-triggered?
Date: Mon, 23 May 2011 13:49:10 -0700
Message-ID: <20110523204910.GA20525@core.coreip.homeip.net>
References: <20110519235051.GA9782@elf.ucw.cz>
 <20110523181312.GA20438@core.coreip.homeip.net>
 <20110523200622.GA1590@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:44712 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1EWUtR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 16:49:17 -0400
Content-Disposition: inline
In-Reply-To: <20110523200622.GA1590@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, May 23, 2011 at 10:06:22PM +0200, Pavel Machek wrote:
> On Mon 2011-05-23 11:13:12, Dmitry Torokhov wrote:
> > On Fri, May 20, 2011 at 01:50:51AM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I'm debugging strange behaviour on /dev/input/eventX ... it seems that
> > > select is not behaving level-triggered as it apparently should. I can
> > > reproduce it when hitting windows & alt keys.
> > > 
> > > Now, I really should rewrite it into C, first, but perhaps someone has
> > > an idea?
> 
> (Ok, so  we agree that select()  should mark descriptor as ready as
> long as data are available... right?)
> 
> > Is this with next or with mainline? In next we try not to signal that FD
> > is ready unless we have full packet in the buffer...
> 
> 2.6.39-rcX mainline.
> 
> > FWIW I see python indeed not reading the tail of events (btw the format
> > should be 'llhhi' and the size on 64 bit arches is 24, not 16) but when
> > I hacked evtest to use select and non-blockign read it all worked
> > properly.
> 
> It  was on x32, but I'll fix that, thanks.
> 
> Difference was I'm not using non-blocking read().

Does not matter.

> It is unusual but
> should work AFAICT. Just read one packet when select shows its ready;
> if there's more than one, don't loop around read, but rely on select
> returning immediately.
> 
> I did verify it on strace, so it should not  be python artefact.

It is artefact of your program, you buffering your input. Use:

	file = open("/dev/input/event3", "rb", 0)

Thanks.

-- 
Dmitry
