From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Tue, 17 Jun 2008 23:02:31 +0300
Message-ID: <48581857.2080906@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:57448 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751186AbYFQUCg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 16:02:36 -0400
In-Reply-To: <20080617153423.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Dmitry Torokhov wrote:
> On Tue, Jun 17, 2008 at 09:52:36PM +0300, Anssi Hannula wrote:
>> (Added Jiri Kosina due to the hid problem I describe near the end)
>>
>> Dmitry Torokhov wrote:
>>> Hi Anssi,
>>>
>>> On Sun, Jun 15, 2008 at 10:01:55PM +0300, Anssi Hannula wrote:
>>>> Hi all!
>>>>
>>>> It seems a new spinlock input_dev->event_lock has been added [1] to the
>>>> input subsystem since the force feedback support was reworked.
>>>>
>>>> However, the force feedback subsystem sleeps on events in multiple
>>>> places, e.g. ff-core.c uses a mutex, and hid-pidff driver waits for hid
>>>> io (otherwise commands were lost, IIRC; if necessary I'll test again).
>>>>
>>>> ff_device->mutex is used to shield effects[], so it is locked when
>>>> handling EV_FF events, on flushes, and on effect upload and erase ioctls.
>>>>
>>>> Maybe we should make EV_FF handling atomic? For effect uploading we
>>>> could either make it completely atomic, or lock only for reserving the
>>>> effect slot, then release the lock, and mark it as ready after upload is
>>>> complete.
>>>> Making even the upload completely atomic would mean that no force
>>>> feedback events/ioctl() would sleep, which AFAIK would be a plus for
>>>> userspace ff applications. On the other hand, hid-pidff (device managed
>>>> mode) driver doesn't know whether effect upload was successful until it
>>>> has received a report from the device, so it wouldn't be able to report
>>>> failure immediately. Other drivers would, though.
>>>>
>>>> What do you think?
>>>>
>>> I think something the patch below is what is needed. EV_FF handling is
>>> already atomic because of event_lock (and it is here to stay), but
>>> uploading does not need to be atomic, only installing into effect
>>> table needs the lock. Any change you could test the patch? I dont have
>>> any FF devices.
>> It seems to be ok, but not enough. The hid-pidff.c driver also waits on
>> pidff_playback_pid(). However, I now see that the wait is probably only
>> necessary because just the report pointer is passed to
>> usbhid_submit_report(). But fixing it properly seems non-trivial (to me).
>>
>> E.g. the problem sequence is:
>>
>> - playback_pid() gets called to stop effect 1.
>> - it sets control_report->field[X]->value[X] = 1;
>> - it submits control_report
>> - thus usbhid_submit_report() stores a pointer to the report
>> - playback_pid() gets immediately called again for effect 2.
>> - it sets control_report->field[X]->value[X] = 2;
>> - thus the previous report hasn't yet been submitted, but the report
>> content has already changed, thus effect 1 is never stopped.
>>
>> Any idea how this should be solved properly?
>>
> 
> It looks like there is a common issue with HID FF devices. Pid driver
> tries to handle it by inserting waits till the control queue is
> cleared, other drivers are completely ignorant of this problem...
> I guess we need to implement a queue of events to be played and put it
> in hid-ff.c so it is available for all hid ff drivers.

With other HID FF drivers than hid-pidff we actually want to skip to the
last one, though (the report contains complete device state, so skipping
old ones does not matter). But indeed of course we still shouldn't be
modifying the just-submitted reports since hid_output_report() could be
reading them at the same time.

-- 
Anssi Hannula
