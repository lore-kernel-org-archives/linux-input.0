From: Pavel Machek <pavel@ucw.cz>
Subject: Re: patch staging-htc-dream-touchscreen-driver-for-staging.patch
	added to gregkh-2.6 tree
Date: Tue, 28 Jul 2009 13:14:17 +0200
Message-ID: <20090728111417.GB17323@elf.ucw.cz>
References: <20090720105340.GF19341@elf.ucw.cz> <1248710770577@kroah.org> <d6200be20907271545l4edc4480v22f6dec4cd3d5dc9@mail.gmail.com> <20090727225545.GC7142@elf.ucw.cz> <d6200be20907271729l4cf2f519occ8ebc1024e5140a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40889 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZG1LQ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2009 07:16:27 -0400
Content-Disposition: inline
In-Reply-To: <d6200be20907271729l4cf2f519occ8ebc1024e5140a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: gregkh@suse.de, greg@kroah.com, swetland@google.com, linux-input@vger.kernel.org

Hi!

> >> Don't see canceling timer nor shutting off WQ here. Also, maybe
> >> implement open() and close() so we don't reschedule WQ while polling?_
> > )
> 
> Unless you changed something there should be no failure path after
> starting the timer or enabling the interrupt.
> 
> synaptics_ts_remove is missing a flush_work call though.

Can you submit patch to fix that?

> > 2) it uses non-standard multitouch support. Either multitouch needs to
> > be disabled for merge, or it needs to switch to standard config.
> 
> I have a patch that adds support for the new protocol, but it does not
> yet remove the old hack.

Yes, such patch would be welcome. I guess we could wrap old, hacky
protocol in ifdef, and then remove it when moving to drivers/input.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
