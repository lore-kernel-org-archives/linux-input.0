From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Thu, 10 Sep 2015 11:38:42 +0200
Message-ID: <1441877922.19022.10.camel@suse.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	 <1441806946.19223.5.camel@suse.com>
	 <CAE1zotKye=grm2CR+0Q25t7B3ZFo_LjrHa5qLYbCUv9=tYTSmw@mail.gmail.com>
	 <1870624.bK0YQxbsoD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbbIJJkJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 05:40:09 -0400
In-Reply-To: <1870624.bK0YQxbsoD@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Colin Cross <ccross@android.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Wed, 2015-09-09 at 22:25 +0200, Rafael J. Wysocki wrote:
> > >
> > > I'd doubt that. Suppose you put the phone into your pocket while
> > > the device isn't suspended. The continuous stream of spurious
> events
> > > will keep it awake.
> 
> Why would they be regarded as spurious then?  They are just regular
> touch panel
> events in that case, aren't they?

These events are not expected to be caused by the user's hand.

But it raises a design question; whose job it is to handle
such information?
It makes no sense to gather events from a touchscreen if you
suspect the phone is randomly rubbing at things or to take
video from a camera if you know that the lid is closed covering
the lens. I think we can agree to that.

The thing is that we handle all other availability in kernel
space. You can argue that user space has an agreed interface
(evdev, V4L or whatever) and it is the kernel's job to react
if it learns that a device becomes temporarily unavailable
and this is merely a question of adding an interface to the
kernel by which user space can feed such information to the
kernel.

	Regards
		Oliver



