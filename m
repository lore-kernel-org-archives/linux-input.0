From: Pavel Machek <pavel@ucw.cz>
Subject: Re: xterms freezing on 2.6.31-rc2 (was Re: [regression] Re:
	2.6.31-rc2: X stop accepting keystrokes?)
Date: Fri, 17 Jul 2009 15:17:58 +0200
Message-ID: <20090717131758.GA2331@elf.ucw.cz>
References: <20090714092459.GA2010@elf.ucw.cz> <20090715131611.GB2367@elf.ucw.cz> <20090717125946.GA2022@elf.ucw.cz> <alpine.LNX.2.00.0907171501080.11648@wotan.suse.de> <20090717130649.GA2202@elf.ucw.cz> <alpine.LNX.2.00.0907171512260.11648@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55071 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbZGQNSF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 09:18:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907171512260.11648@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri 2009-07-17 15:13:41, Jiri Kosina wrote:
> On Fri, 17 Jul 2009, Pavel Machek wrote:
> 
> > > > ...and they seem to be slightly different crashes. Once keyboard was
> > > > dead but mouse worked, second time keyboard still worked but xterms
> > > > kept locking up. I managed to type dmesg into one of them, but that
> > > > xterm hung in middle of dump :-(.
> > > 
> > > I guess that both keyboard and mouse are PS/2 connected, right?
> > 
> > Thinkpad internal keyboard/mouse, yes.
> > 
> > > Any possibility to capture serial console output?
> > 
> > I managed to get dmesg via magic sysrq at some point. I got some
> > softlockup messages and processes seemed to hang.
> 
> Softlockup in which area?

Sorry, I did not write it down :-(.

> Are you able to ssh into the machine? Where do the xterms hang? 
> (/proc/<pid>/stack)

I was not able to capture that. I'll try pen and paper next :-).

> > I'm no  longer sure how much keyboard related it is. It seems to
> > happen while typing, but ... the system still reacts to keyboard but
> > xterms hang. 
> 
> Could this be related to
> 
> 	http://lkml.org/lkml/2009/7/16/268

Actually... that sounds suspiciously like it. I'll try -rc3 update.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
