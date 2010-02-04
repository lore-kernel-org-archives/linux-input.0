From: Pavel Machek <pavel@ucw.cz>
Subject: Re: O_ASYNC not working on /dev/input/event* ?
Date: Thu, 4 Feb 2010 08:02:53 +0100
Message-ID: <20100204070253.GB3928@atrey.karlin.mff.cuni.cz>
References: <20100203085600.GA20743@atrey.karlin.mff.cuni.cz> <20100203090045.GC22110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56525 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0BDHDA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Feb 2010 02:03:00 -0500
Content-Disposition: inline
In-Reply-To: <20100203090045.GC22110@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> On Wed, Feb 03, 2010 at 09:56:00AM +0100, Pavel Machek wrote:
> > HI!
> > 
> > I'm trying to use O_ASYNC on /dev/input/event* (getting SIGIO when key
> > is pressed), but so far no luck. Is it possible that O_ASYNC is not
> > implemented there?
> 
> You should be getting SIGIO when driver sends EV_SYN/SYN_REPORT...

Thanks, it works now. Signal setup needs to be before fcntl(). 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
