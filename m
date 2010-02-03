From: Pavel Machek <pavel@ucw.cz>
Subject: O_ASYNC not working on /dev/input/event* ?
Date: Wed, 3 Feb 2010 09:56:00 +0100
Message-ID: <20100203085600.GA20743@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38076 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756269Ab0BCI4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2010 03:56:01 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dtor@mail.ru

HI!

I'm trying to use O_ASYNC on /dev/input/event* (getting SIGIO when key
is pressed), but so far no luck. Is it possible that O_ASYNC is not
implemented there?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
