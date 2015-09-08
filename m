From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Tue, 8 Sep 2015 22:28:36 +0200
Message-ID: <CAJZ5v0ghdvULcdb9nEAk_WkSNWJDDpVSXfXxvUE56_ViDKORFA@mail.gmail.com>
References: <2125433.CLuFqMxLgc@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1509081055390.1533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32935 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbIHU2i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2015 16:28:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509081055390.1533-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Tirdea, Irina" <irina.tirdea@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On Tue, Sep 8, 2015 at 5:00 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 8 Sep 2015, Rafael J. Wysocki wrote:
>
>> > > [1] http://marc.info/?l=linux-input&m=140564626306396&w=2
>> >
>> > Purely as a matter of interest, in that email Rafael also mentioned
>> > that he and I had discussed a way to disable remote wakeup during
>> > runtime suspend.  Oddly enough, the method we decided upon was to add
>> > an "off" option to /sys/.../power/control.  :-)
>>
>> Wasn't that /sys/devices/.../power/wakeup rather?
>
> Not the way I remember.  Of course, it's possible that we misunderstood
> each other at the time.
>
>> > It would not put the device into runtime suspend immediately, like you
>> > are proposing.  Instead it would mean the same as the "auto" mode,
>> > except that remote wakeup should be disabled during runtime suspend.
>> >
>> > We never got around to implementing this, however.
>>
>> I don't think this is what we discussed then really.
>>
>> There is a fundamental problem with forcing things into runtime suspend
>> from user space, because that may happen in a wrong time.  In other words,
>> the kernel can't guarantee that the device would actually be able to go
>> into runtime suspend when requested.
>
> Exactly.  What we discussed at LinuxCon wasn't forcing things into
> runtime suspend; it was disabling remote wakeup during runtime suspend.
>
> And even though the topic was quite different from Irina's proposal, we
> ended up settling on the same API (according to my recollection).

So I remember that differently.

My idea was to add a third value to /sys/devices/.../power/wakeup (in
addition to "disabled" and "enabled") so user space can indicate that
remote wakeup should not be enabled for runtime suspend for the device
(since there's no way to indicate that today).  I don't see how
/sys/devices/.../power/control might help here to be honest.

Thanks,
Rafael
