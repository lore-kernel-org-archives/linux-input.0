From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 8 Sep 2015 10:44:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509081039470.1533-100000@iolanthe.rowland.org>
References: <1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 8 Sep 2015, Tirdea, Irina wrote:

> In the previous discussion thread , there were a couple of options
> mentioned, but none seemed to reach a consensus. You mentioned
> adding a "more aggressive runtime PM mode" [1]. I'm not sure how
> this would work except for adding a sysfs attribute that would trigger
> a runtime suspend while ignoring usage count. Would that be a
> better direction?
> 
> Thank you,
> Irina
> 
> [1] http://marc.info/?l=linux-input&m=140564626306396&w=2

Purely as a matter of interest, in that email Rafael also mentioned
that he and I had discussed a way to disable remote wakeup during 
runtime suspend.  Oddly enough, the method we decided upon was to add 
an "off" option to /sys/.../power/control.  :-)

It would not put the device into runtime suspend immediately, like you
are proposing.  Instead it would mean the same as the "auto" mode,
except that remote wakeup should be disabled during runtime suspend.

We never got around to implementing this, however.

Alan Stern

