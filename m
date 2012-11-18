From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.7-rc3: mouses stopped working
Date: Sun, 18 Nov 2012 19:53:17 +0100
Message-ID: <20121118185316.GA2844@elf.ucw.cz>
References: <20121115132849.GA4062@elf.ucw.cz>
 <alpine.LNX.2.00.1211151429240.15877@pobox.suse.cz>
 <20121115140736.GA2651@elf.ucw.cz>
 <alpine.LNX.2.00.1211151508350.15877@pobox.suse.cz>
 <20121116013405.GA2002@elf.ucw.cz>
 <alpine.LNX.2.00.1211161153290.20577@pobox.suse.cz>
 <20121116122400.GA10994@elf.ucw.cz>
 <alpine.LNX.2.00.1211161335180.20577@pobox.suse.cz>
 <20121118085638.GA2331@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37293 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab2KRSxB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Nov 2012 13:53:01 -0500
Content-Disposition: inline
In-Reply-To: <20121118085638.GA2331@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org

Hi!


> > That is correct and expected behavior.
> > 
> > > So it seems to be "/dev/input/mice" issue. Does it work for you?
> > 
> > Yes, it works for me properly (testing with rc4+, 1b42fc4 more precisely). 
> > Even after disconnect/reconnect cycle of USB mouse, I am getting events 
> > properly from /dev/input/mice (frankly I am surprised that you noticed ... 
> > Xorg has been using evdev driver for ages already by default, right?)
> > 
> > What was the last kernel version that worked for you in this respect?
> > 
> > Adding Dmitry and linux-input.
> 
> Does the patch below help?

Yes. With this patch, my mice are back.

Tested-by: Pavel Machek <pavel@ucw.cz>

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
