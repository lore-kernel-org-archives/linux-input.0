From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [regression] Re: 2.6.31-rc2: X stop accepting keystrokes?
Date: Fri, 17 Jul 2009 15:01:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907171501080.11648@wotan.suse.de>
References: <20090714092459.GA2010@elf.ucw.cz> <20090715131611.GB2367@elf.ucw.cz> <20090717125946.GA2022@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44723 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934551AbZGQNBw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 09:01:52 -0400
In-Reply-To: <20090717125946.GA2022@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


[ adding some CCs ]

On Fri, 17 Jul 2009, Pavel Machek wrote:

> On Wed 2009-07-15 15:16:11, Pavel Machek wrote:
> > Hi!
> > 
> > > ...it happened second time now.  In one case, ctrl-alt-backspace
> > > helped and I got at least console back, in the other case I had to
> > > reboot using sysrq.
> > > 
> > > ...hmm. It was probably same crash, because console switching has
> > > probably been locked by X, and I have just one console. I ended up on
> > > empty console before.
> > 
> > It happened four times now. It seems to happen when I type heavily. I
> > was once able to reproduce it by hitting keys heavily/randomly.
> 
> Two more crashes today :-(. -rc2 is pretty much unusable.
> 
> ...and they seem to be slightly different crashes. Once keyboard was
> dead but mouse worked, second time keyboard still worked but xterms
> kept locking up. I managed to type dmesg into one of them, but that
> xterm hung in middle of dump :-(.

I guess that both keyboard and mouse are PS/2 connected, right?

Any possibility to capture serial console output?

-- 
Jiri Kosina
SUSE Labs
