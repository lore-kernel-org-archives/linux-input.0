From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Wed, 9 Dec 2009 22:08:16 +0100
Message-ID: <20091209210816.GD3480@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
 <87einfltp3.fsf@tac.ki.iif.hu>
 <20091206084704.GC2766@ucw.cz>
 <20091208042251.GB11147@core.coreip.homeip.net>
 <1260277410.19669.84.camel@localhost>
 <20091208174218.GB14271@core.coreip.homeip.net>
 <1260343860.19669.1189.camel@localhost>
 <20091209180345.GE4456@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57952 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbZLIVIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 16:08:16 -0500
Content-Disposition: inline
In-Reply-To: <20091209180345.GE4456@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> > > I refuse it because it will be supported by exactly 1 driver in the
> > > kernel - gpio-keys. It is the only driver that allows shut half of the
> > > "device" (because in reality it is a group of disjoint devices). It is
> > > the only case when "muting" a button means that IRQ is shut off abnd
> > > thus CPU can continue to sleep if that button is pressed. For all other
> > > devices that have 1 inettrupt per device, you still have to wake up,
> > > because you don't know whether the button that generated event is
> > > "important" or not.
> > 
> > Fair enough.
> > 
> > > Now, there is a issue of waking up userspace task, additional scheduling
> > > and keeping CPU running longer than necessary for "uninteresting" keys.
> > > This can be solved by implementing a subscription model which allows
> > > filtering uninteresing events on a per-client basis at evdev level.
> > 
> > Right. And for gpio_keys, this would be dine on the driver level.
> 
> But the semantics are different - if done on driver level you'd be
> affecting _all_  consumers of the device; what I want to be done only
> affects owner of the file descriptor.

Well, if _all_ consumers decide to ignore some key, we should be able
to ignore it at driver level.

And actually it may make some sense -- I do not think disabling irq
during runtime is worth the effort, but disabling wakeup source and
getting rid of unneccessary wakeup when system is suspended is
probably worth it.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
