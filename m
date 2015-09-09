From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 09 Sep 2015 15:55:46 +0200
Message-ID: <1441806946.19223.5.camel@suse.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	 <8981266.1iKleIVcUj@vostro.rjw.lan>
	 <1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
	 <1441697744.26994.21.camel@suse.com>
	 <CAJZ5v0jf1=YFW3iCh8LvOU+5diKgoVH7LtTeu80ym2H4TPYSkg@mail.gmail.com>
	 <CAPDyKFrZqGcB9kMTnvAFRAWVqyvJ6REGFLce4iA2w5rqps=d4g@mail.gmail.com>
	 <CAJZ5v0iCRUJoDJ4oy8TKDvngjZ7SbBUngK2+a7ccUEtVFhW0gg@mail.gmail.com>
	 <CAE1zotJ_XPFww_dsOihF1vQRLrgi+OQmQ17e_8aBkAJ+yLqdNg@mail.gmail.com>
	 <CAJZ5v0j5XN3Y=YW4jWekUB9qwL5KAVkeDMdhMiKv6j=xLa8psA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34896 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbbIIN5L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Sep 2015 09:57:11 -0400
In-Reply-To: <CAJZ5v0j5XN3Y=YW4jWekUB9qwL5KAVkeDMdhMiKv6j=xLa8psA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 2015-09-09 at 14:22 +0200, Rafael J. Wysocki wrote:
> > Note that when the screen is turned-on again, we want to resume the
> > touchscreen so that it can send events again.

Why is it impractical to close the fd for the touchscreen?
> 
> In fact, then, what you need seems to be the feature discussed by Alan
> and me some time ago allowing remote wakeup do be disabled for runtime
> PM from user space as that in combination with autosuspend should
> address your use case.

I'd doubt that. Suppose you put the phone into your pocket while
the device isn't suspended. The continuous stream of spurious events
will keep it awake.
The ability to disable remote wakeup is necessary but not sufficient.

	Regards
		Oliver


