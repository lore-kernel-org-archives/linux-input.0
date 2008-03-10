From: Pavel Machek <pavel@ucw.cz>
Subject: Re: BUG in sermouse driver
Date: Mon, 10 Mar 2008 13:01:37 +0100
Message-ID: <20080310120137.GB29197@elf.ucw.cz>
References: <20080310093039.GA26118@localhost.localdomain> <Pine.LNX.4.64.0803101130060.18589@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58024 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYCJMBJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 08:01:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803101130060.18589@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi!

> > There is a bug in sermouse driver that inputattach program terminates 
> > during suspend (or resume) to ram hence mouse does not work afer resume. 
> > When i execute inputattach after resume, the mouse is working.
> 
> I know that Pavel (added to CC) knows where the problem is (improper fake 
> signal handling around try_to_freeze() call), I guess he'd be able to 
> provide a patch to test.

I don't have a patch ready, but I believe we localized the problem to
serport_ldisc_read().

        wait_event_interruptible(serport->wait,
+test_bit(SERPORT_DEAD,&serport->flags));

It does interruptible wait, but does not expect signals. We tried
something like:

do {
        wait_event_interruptible(serport->wait, test_bit(SERPORT_DEAD,&serport->flags));
} while (try_to_freeze());

...but that did not help IIRC.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
