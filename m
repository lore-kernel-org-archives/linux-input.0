From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from
 suspend-to-idle
Date: Tue, 17 Mar 2015 09:50:33 +0100
Message-ID: <20150317085033.GC9761@amd>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan>
 <2514027.izE5Direg3@vostro.rjw.lan>
 <20150316211108.GC11441@amd>
 <1902569.dAVq7nl4i8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1902569.dAVq7nl4i8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> > > Yeah, that works too.  And you're right that there's no reason to do that for
> > > keyboard only.
> > 
> > Actually, are you sure?
> > 
> > Resuming on mouse click is reasonable, resuming on mouse move is not,
> > as table vibrations are likely to cause that.
> 
> This is disabled by default, so user space has to enable it anyway if it wants
> to.

Good. (But still, for suspend-to-RAM, only mouse _click_ will resume
the machine, as the optical sensor is powered down, no?)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
