From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: dualshock
Date: Sat, 14 Mar 2015 20:31:40 +0100
Message-ID: <20150314193139.GB4089@amd>
References: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45318 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbCNTbm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Mar 2015 15:31:42 -0400
Content-Disposition: inline
In-Reply-To: <20150314191917.GA3680@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

After oopsing kernel with ps/3 peripherals, I decided to play some
more.

Third, regular controller. The one you don't have to dance with.

/sys/class/power_supply/*/capacity works.

again, evtest reports funny-looking multitouch events:

Event: time 1426361100.640824, -------------- EV_SYN ------------
Event: time 1426361100.650827, type 3 (EV_ABS), code 59
(ABS_MT_DISTANCE), value 506
Event: time 1426361100.650827, -------------- EV_SYN ------------
Event: time 1426361100.660827, type 3 (EV_ABS), code 5 (ABS_RZ), value
127
Event: time 1426361100.660827, -------------- EV_SYN ------------

...but seems to work. I even have 4 new leds that work. Unfortunately
they are small and not colorful.

Aha, force feedback needs CONFIG_SONY_FF. Setting it now. Did not have
it for previous mails.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
