From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 8 Sep 2015 22:56:28 +0200
Message-ID: <CAJZ5v0jf1=YFW3iCh8LvOU+5diKgoVH7LtTeu80ym2H4TPYSkg@mail.gmail.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	<8981266.1iKleIVcUj@vostro.rjw.lan>
	<1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
	<1441697744.26994.21.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36772 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbIHU4a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2015 16:56:30 -0400
In-Reply-To: <1441697744.26994.21.camel@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Sep 8, 2015 at 9:35 AM, Oliver Neukum <oneukum@suse.com> wrote:
> On Tue, 2015-09-08 at 01:10 +0000, Tirdea, Irina wrote:

[cut]

>> this would work except for adding a sysfs attribute that would trigger
>> a runtime suspend while ignoring usage count. Would that be a
>> better direction?
>
> No. If we want this at all, we need a new callback to notify drivers
> that user space is temporarily uninterested in a device. And the reverse
> of course.
> The power model is good. We must not assume that devices can be
> suspended at will. If we do this at all, we ought to see it as giving
> strong hints to drivers when a device can be considered idle.

This is a good summary in my view.

The only thing we can add, realistically, is an interface for user
space to "kick" drivers to check if the devices they handle may be
suspended at this point (or to run their ->runtime_idle callbacks
IOW).

That would be quite similar to autosuspend except that the "kick" will
come from user space rather than from a timer function in the kernel.

Thanks,
Rafael
