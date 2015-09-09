From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 9 Sep 2015 18:02:02 +0300
Message-ID: <CAE1zotKye=grm2CR+0Q25t7B3ZFo_LjrHa5qLYbCUv9=tYTSmw@mail.gmail.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	<8981266.1iKleIVcUj@vostro.rjw.lan>
	<1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
	<1441697744.26994.21.camel@suse.com>
	<CAJZ5v0jf1=YFW3iCh8LvOU+5diKgoVH7LtTeu80ym2H4TPYSkg@mail.gmail.com>
	<CAPDyKFrZqGcB9kMTnvAFRAWVqyvJ6REGFLce4iA2w5rqps=d4g@mail.gmail.com>
	<CAJZ5v0iCRUJoDJ4oy8TKDvngjZ7SbBUngK2+a7ccUEtVFhW0gg@mail.gmail.com>
	<CAE1zotJ_XPFww_dsOihF1vQRLrgi+OQmQ17e_8aBkAJ+yLqdNg@mail.gmail.com>
	<CAJZ5v0j5XN3Y=YW4jWekUB9qwL5KAVkeDMdhMiKv6j=xLa8psA@mail.gmail.com>
	<1441806946.19223.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33755 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbbIIPCD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2015 11:02:03 -0400
Received: by ykei199 with SMTP id i199so19269937yke.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2015 08:02:02 -0700 (PDT)
In-Reply-To: <1441806946.19223.5.camel@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Colin Cross <ccross@android.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>

On Wed, Sep 9, 2015 at 4:55 PM, Oliver Neukum <oneukum@suse.com> wrote:
> On Wed, 2015-09-09 at 14:22 +0200, Rafael J. Wysocki wrote:
>> > Note that when the screen is turned-on again, we want to resume the
>> > touchscreen so that it can send events again.
>
> Why is it impractical to close the fd for the touchscreen?
>

I am not sure, but I think it is this way due to historical reasons.
On Android devices early-suspend was used originally to save power
when the screen was turned-off but the device was not suspend. Later
Android moved to power HAL [1] and run-time PM for some devices,
however that is not sufficient for touchscreen.

i2c touchscreen devices usually have two low-power states: a deep
power state where event collection is disabled and the device needs to
be poked via i2c to restart collecting events and a shallow power
state where the device reduces the internal polling rate after it is
idle for some time. The latter it is usually implemented directly in
hardware. That means that you can't really implemented auto-suspend
with the deep power state, since the device can not resume itself.

To address this limitation, Android used early suspend (and then the
power HAL mechanism) where the upper layers signals when you can turn
on or off certain devices.

I have added Colin and Arve to this thread who maybe can answer this better.

>> In fact, then, what you need seems to be the feature discussed by Alan
>> and me some time ago allowing remote wakeup do be disabled for runtime
>> PM from user space as that in combination with autosuspend should
>> address your use case.
>
> I'd doubt that. Suppose you put the phone into your pocket while
> the device isn't suspended. The continuous stream of spurious events
> will keep it awake.

I agree.

> The ability to disable remote wakeup is necessary but not sufficient.
>

I don't know enough about remote wake-up, but do we even need to use
it for this kind of devices?
