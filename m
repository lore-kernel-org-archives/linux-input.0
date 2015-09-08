From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Tue, 08 Sep 2015 17:15:42 +0200
Message-ID: <2125433.CLuFqMxLgc@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509081039470.1533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54733 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753193AbbIHOrx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2015 10:47:53 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509081039470.1533-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tuesday, September 08, 2015 10:44:04 AM Alan Stern wrote:
> On Tue, 8 Sep 2015, Tirdea, Irina wrote:
> 
> > In the previous discussion thread , there were a couple of options
> > mentioned, but none seemed to reach a consensus. You mentioned
> > adding a "more aggressive runtime PM mode" [1]. I'm not sure how
> > this would work except for adding a sysfs attribute that would trigger
> > a runtime suspend while ignoring usage count. Would that be a
> > better direction?
> > 
> > Thank you,
> > Irina
> > 
> > [1] http://marc.info/?l=linux-input&m=140564626306396&w=2
> 
> Purely as a matter of interest, in that email Rafael also mentioned
> that he and I had discussed a way to disable remote wakeup during 
> runtime suspend.  Oddly enough, the method we decided upon was to add 
> an "off" option to /sys/.../power/control.  :-)

Wasn't that /sys/devices/.../power/wakeup rather?

> It would not put the device into runtime suspend immediately, like you
> are proposing.  Instead it would mean the same as the "auto" mode,
> except that remote wakeup should be disabled during runtime suspend.
> 
> We never got around to implementing this, however.

I don't think this is what we discussed then really.

There is a fundamental problem with forcing things into runtime suspend
from user space, because that may happen in a wrong time.  In other words,
the kernel can't guarantee that the device would actually be able to go
into runtime suspend when requested.

Thanks,
Rafael

