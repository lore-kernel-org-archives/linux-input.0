From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 9 Sep 2015 14:22:55 +0200
Message-ID: <CAJZ5v0j5XN3Y=YW4jWekUB9qwL5KAVkeDMdhMiKv6j=xLa8psA@mail.gmail.com>
References: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
	<8981266.1iKleIVcUj@vostro.rjw.lan>
	<1F3AC3675D538145B1661F571FE1805F2F0C5CBE@irsmsx105.ger.corp.intel.com>
	<1441697744.26994.21.camel@suse.com>
	<CAJZ5v0jf1=YFW3iCh8LvOU+5diKgoVH7LtTeu80ym2H4TPYSkg@mail.gmail.com>
	<CAPDyKFrZqGcB9kMTnvAFRAWVqyvJ6REGFLce4iA2w5rqps=d4g@mail.gmail.com>
	<CAJZ5v0iCRUJoDJ4oy8TKDvngjZ7SbBUngK2+a7ccUEtVFhW0gg@mail.gmail.com>
	<CAE1zotJ_XPFww_dsOihF1vQRLrgi+OQmQ17e_8aBkAJ+yLqdNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAE1zotJ_XPFww_dsOihF1vQRLrgi+OQmQ17e_8aBkAJ+yLqdNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Tirdea, Irina" <irina.tirdea@intel.com>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Wed, Sep 9, 2015 at 1:13 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Wed, Sep 9, 2015 at 2:50 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi,
>>
>> On Wed, Sep 9, 2015 at 12:25 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > On 8 September 2015 at 22:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >> On Tue, Sep 8, 2015 at 9:35 AM, Oliver Neukum <oneukum@suse.com> wrote:
>> >>> On Tue, 2015-09-08 at 01:10 +0000, Tirdea, Irina wrote:
>> >>
>> >> [cut]
>> >>
>> >>>> this would work except for adding a sysfs attribute that would trigger
>> >>>> a runtime suspend while ignoring usage count. Would that be a
>> >>>> better direction?
>> >>>
>> >>> No. If we want this at all, we need a new callback to notify drivers
>> >>> that user space is temporarily uninterested in a device. And the reverse
>> >>> of course.
>> >>> The power model is good. We must not assume that devices can be
>> >>> suspended at will. If we do this at all, we ought to see it as giving
>> >>> strong hints to drivers when a device can be considered idle.
>> >>
>> >> This is a good summary in my view.
>> >>
>> >> The only thing we can add, realistically, is an interface for user
>> >> space to "kick" drivers to check if the devices they handle may be
>> >> suspended at this point (or to run their ->runtime_idle callbacks
>> >> IOW).
>> >>
>> >> That would be quite similar to autosuspend except that the "kick" will
>> >> come from user space rather than from a timer function in the kernel.
>> >
>> > Apologize for interrupting the discussion!
>> >
>> > Unless I miss the point, I assumes the above is somewhat already
>> > achievable via sysfs when changing the value of the auto-suspend
>> > timeout, since it triggers a call to
>> > pm_runtime_set_autosuspend_delay()...
>>
>> Well, from the initial comment in drivers/base/power/sysfs.c:
>>
>>  *
>>  *    NOTE: The autosuspend_delay_ms attribute and the autosuspend_delay
>>  *    value are used only if the driver calls pm_runtime_use_autosuspend().
>>  *
>>
>> Some drivers don't do that and they would be the primary target
>> audience for the new interface (if we agreed that it was useful after
>> all).
>>
>> > Also, according to the discussion so far, it seems like we are on
>> > agreement that we should really think twice when considering to extend
>> > the sysfs interface for runtime PM.
>>
>> That certainly is correct and not limited to runtime PM. :-)
>>
>> > From the change-log/description to $subject patch, I fail to
>> > understand *why* the regular runtime PM *autosuspend* feature isn't
>> > sufficient. Perhaps Irina can elaborate more on the use case, to help
>> > me get a better understanding of the issue!?
>>
>> My understanding is that the idea would be to trigger an attempt to
>> suspend via a specific event (eg. lid closes) rather then via an
>> inactivity timer.
>>
>
> The best example and actually the very specific problem we want to
> solve is handling touchscreens on a phone / tablet. When the screen is
> turned off, it is ideal to suspend the touchscreen for two reasons: to
> lower the power consumption as much as possible and to prevent
> interrupts to wake-up the CPU when the user touches the device, and
> thus save even more power as we allow the CPU to stay in deep idle
> states for longer periods.
>
> Note that when the screen is turned-on again, we want to resume the
> touchscreen so that it can send events again.

In fact, then, what you need seems to be the feature discussed by Alan
and me some time ago allowing remote wakeup do be disabled for runtime
PM from user space as that in combination with autosuspend should
address your use case.

> This is different then the lid closes examples, as in that case the
> user can not generate new events and thus the usual autosuspend
> feature is probably good enough (if the suspend power and autosuspend
> power consumption is similar).

Autosuspend just means checking the device state periodically and
suspending it if idle (not in use).  It doesn't affect the energy
consumption in the suspended state.

Thanks,
Rafael
