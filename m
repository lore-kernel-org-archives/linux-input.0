From: Pavel Machek <pavel@ucw.cz>
Subject: Re: select() on /dev/input/eventX not level-triggered?
Date: Mon, 23 May 2011 23:20:16 +0200
Message-ID: <20110523212016.GA24969@elf.ucw.cz>
References: <20110519235051.GA9782@elf.ucw.cz>
 <20110523181312.GA20438@core.coreip.homeip.net>
 <20110523200622.GA1590@ucw.cz>
 <20110523204910.GA20525@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:58683 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757369Ab1EWVUU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 17:20:20 -0400
Content-Disposition: inline
In-Reply-To: <20110523204910.GA20525@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon 2011-05-23 13:49:10, Dmitry Torokhov wrote:
> On Mon, May 23, 2011 at 10:06:22PM +0200, Pavel Machek wrote:
> > On Mon 2011-05-23 11:13:12, Dmitry Torokhov wrote:
> > > On Fri, May 20, 2011 at 01:50:51AM +0200, Pavel Machek wrote:
> > Difference was I'm not using non-blocking read().
> 
> Does not matter.
> 
> > It is unusual but
> > should work AFAICT. Just read one packet when select shows its ready;
> > if there's more than one, don't loop around read, but rely on select
> > returning immediately.
> > 
> > I did verify it on strace, so it should not  be python artefact.
> 
> It is artefact of your program, you buffering your input. Use:
> 
> 	file = open("/dev/input/event3", "rb", 0)

Oops, yes, you are right, that solves it. Thanks... and sorry for the
noise.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
