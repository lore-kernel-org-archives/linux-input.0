From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Turn Sony motion controller into RGB led
Date: Fri, 24 Apr 2015 14:53:59 +0200
Message-ID: <20150424125359.GA31195@amd>
References: <20150314191917.GA3680@amd>
 <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
 <20150316130547.GA20976@amd>
 <20150409212536.GA1440@amd>
 <55271A53.6080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55271A53.6080505@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> >I did not yet figure out how to get sensor data from the controller,
> >but it works rather well as a RGB led.
> 
> Hi Pavel,
> 
> From what I've read, the motion controller only sends sensor data when
> connected via bluetooth.
> Otherwise it should be in report 1 with the buttons and other data.

Aha, that would explain a lot.

> If you can send a version without all of the unrelated underscore changes
> I'll help clean it up.  I don't own one of these controllers
> though, so I can't help test the functionality.

Ok, if the offer is still valid, lets do that.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
