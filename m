From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Mon, 21 Sep 2015 14:29:19 +0200
Message-ID: <20150921122919.GA16589@amd>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
 <1441806946.19223.5.camel@suse.com>
 <CAE1zotKye=grm2CR+0Q25t7B3ZFo_LjrHa5qLYbCUv9=tYTSmw@mail.gmail.com>
 <1870624.bK0YQxbsoD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1870624.bK0YQxbsoD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Colin Cross <ccross@android.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
List-Id: linux-input@vger.kernel.org

> > >> In fact, then, what you need seems to be the feature discussed by Alan
> > >> and me some time ago allowing remote wakeup do be disabled for runtime
> > >> PM from user space as that in combination with autosuspend should
> > >> address your use case.
> > >
> > > I'd doubt that. Suppose you put the phone into your pocket while
> > > the device isn't suspended. The continuous stream of spurious events
> > > will keep it awake.
> 
> Why would they be regarded as spurious then?  They are just regular touch panel
> events in that case, aren't they?

>From userspace... they are spurious. Userspace does not known that
your device is commonly placed into the pocket, and the events it sees
are not from user.

I have mainline X/mate running on n900 cellphone. And this means
battery life is in "2 hours" range.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
