From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: Re: [PATCH] Introduce Naming Convention in Input Subsystem
Date: Sun, 2 Mar 2014 00:47:30 +0530
Message-ID: <CADYu308fqa-9Jj45Oz7Hm+ZR+G78mHWh6=S-MdR7ZEqhG_AfAw@mail.gmail.com>
References: <25201406.444611389372583656.JavaMail.weblogic@epml19>
	<20140110191108.GC10889@core.coreip.homeip.net>
	<CADYu30_qxKV7SmUdUc1Y-sN+KDYbWyz6Yv_H6BsSA-koK9aWYQ@mail.gmail.com>
	<20140110214604.GA19779@core.coreip.homeip.net>
	<CADYu309xpKK7Zj_KjXWPO=cQ__qQ85zsHR91ky2_EMsW8Nk6ZA@mail.gmail.com>
	<CAN+gG=HXcjmBcaxaBJczMWjNdKXdFiZzQGducQwMU6mdrS-R0Q@mail.gmail.com>
	<CADYu309oDWRZGfnnNaBrwsP_uzCZsA_MS7KxOMBrGKPV9H6X8w@mail.gmail.com>
	<20140120214933.GA4270@core.coreip.homeip.net>
	<CADYu30-f8uwfP_ZFZCDD=ho0BgAitvWVBuHxYn9up9+vN4gNKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33804 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbaCATRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Mar 2014 14:17:33 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so3646338lbv.32
        for <linux-input@vger.kernel.org>; Sat, 01 Mar 2014 11:17:31 -0800 (PST)
In-Reply-To: <CADYu30-f8uwfP_ZFZCDD=ho0BgAitvWVBuHxYn9up9+vN4gNKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>, Aniroop Mathur <a.mathur@samsung.com>

Dear Mr. Torokhov, Mr. Tissoires,

Gentle Reminder:
Please, update your comment/opinion/suggestion on below mail.

On Mon, Feb 10, 2014 at 9:24 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
> Dear Mr. Torokhov, Mr. Benjamin,
> Greetings!
>
> I sent a mail on January 25th, but still waiting for the reply.
> Therefore, sending it again.
> I hope to hear soon ~
>
>
> On Tue, Jan 21, 2014 at 3:19 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Aniroop,
>>
>> On Tue, Jan 21, 2014 at 01:34:07AM +0530, Aniroop Mathur wrote:
>>> Hello Mr Tissoires
>>> Greetings !!
>>>
>>> On Jan 20, 2014 11:54 PM, "Benjamin Tissoires" <benjamin.tissoires@gmail.com>
>>> wrote:
>>> >
>>> > Hi Aniroop,
>>> >
>>> > [sorry for top posting, but I really don't know where to put this
>>> regarding your answers].
>>> >
>>> No problem at all.
>>> In fact I am quite happy to hear from
>>> Linux community again
>>> Its my pleasure.
>>>
>>> > I _think_ I get one of the reasons you don't understand Dmitry, and why
>>> Dmitry does not understand you. From the different mails, I would say that
>>> you are referring to an Android platform.
>>> > If it's not the case, then sorry for the noise.
>>> >
>>> No I am not specifically referring to
>>> Android platform
>>> But yes, I am from android background
>>> and through android only I came up with
>>> this idea.
>>>
>>> > So, the last time I checked with android, this system does _not_ have an
>>> udev user-space daemon, which means that what you seem to be doing is
>>> parsing manually the sysfs tree to retrieve the inputs and their properties.
>>> > This, IMO, is a very bad idea. Parsing the entire sysfs tree is indeed
>>> costly and you will have to build everything by hand.
>>> >
>>> No, Android also have a daemon but it is not udev daemon. There is a
>>> separate daemon in android different from generic
>>> udev daemon. It is different but basic is
>>> still same.
>>> Just like udev daemon, android daemon
>>> also receives uevents from kernel
>>> and creates devfs nodes for us,
>>> that is /Dev/input/event1/2/3... based
>>> on uevent env variables.
>>> Android daemon is different from generic
>>> daemon in a sense it does not see any file
>>> like udev rules before creating nodes. Instead it directly create nodes as
>>> per uevent env variables in the structure.
>>> So without opening any extra udev rule
>>> file, it create nodes.
>>> So I understand it has also a limitation that it only has to be dependent
>>> only on default uevents and cannot read any sysfs attribute to identify the
>>> device if default uevents are not sufficient.
>>
>> Why can it not?
>>
>
> It cannot because currently in android code, it does not read any
> sysfs attribute.
> It only reads default kernel uevents. I think functionality may be added to read
> sysfs attribute also but this functionality is currently not added in
> android code.
> I think it is not added because in embedded system mostly there are only single
> and unique devices and this manipulation might add extra time during android
> initialization.
>
>>>
>>> But the problem I am referring  is for both in case of generic kernel and
>>> android kernel.
>>
>> So far I really do not see it as generic kernel problem since we do have
>> existing infrastructure in userspace that is quite efficient.
>>
>
> The existing way is also there but there is always a scope of improvement.
> Tell me which is more efficient ?
> 1. existing method in which udev opens and read udev files for setting name
> or
> 2. Directly set name without doing extra calculations
>
> Its correct existing method will also do the same task but why not to use
> more efficient way.
> I just want to improve efficiency.
>
>
>>>
>>> > On regular distros, we use udev. This daemon builds its device database
>>> from the events generated by the kernels directly (the uevents). Once the
>>> events are emitted, we never (except for some user-space drivers) use them
>>> in the kernel drivers (at least, I never saw that).
>>> >
>>> > So if you want to create symlinks, then indeed, you just add 2 or 3 rules
>>> in /etc/udev/rules.d, and then the user space (and the system integrator)
>>> can see the different devices with the "correct" symlink.
>>> > However, the kernel developer will never see them (and especially in the
>>> ->probe callback). However, the user-space tools which receives the udev
>>> events (emitted from udev, not the kernel this time) can easily retrieve
>>> many information from the event. Just run "udevadm info --export-db" on a
>>> regular Linux, and you will see that the device which presents the event
>>> node (/dev/input/eventX) has all the requirements to identify itself (VID,
>>> PID, path, etc...)
>>> >
>>> Yes udev gives so many uevents but as I checked through logs specifically
>>> in case of /Dev/input/event1/2/3/4....it does not give sufficient uevents
>>> to identify the device.
>>> As I found in logs it gives only 7 env variable like action, subsystem, Dev
>>> name, Dev path, major, minor and seq number.
>>> It does not give vendor Id or pid.
>>> Now with these uevent we cannot identify the input device whether its
>>> accelerometer or touchscreen. Can we ??
>>
>> While information sent in uevent emitted for creation of event device
>> might not be enough to identify and classify input device you can:
>>
>> 1. Capture udevent sent a few moments earlier for the input device
>>    itself, or
>>
>> 2. Read /sys/class/$DEVNAME/device/uevent to retrieve input device's
>> uevent data:
>>
>> [dtor@dtor-d630 work]$ cat /sys/class/input/event6/uevent
>> MAJOR=13
>> MINOR=70
>> DEVNAME=input/event6
>> [dtor@dtor-d630 work]$ cat /sys/class/input/event6/device/uevent
>> PRODUCT=11/2/8/300
>> NAME="AlpsPS/2 ALPS DualPoint TouchPad"
>> PHYS="isa0060/serio1/input0"
>> PROP=8
>> EV=b
>> KEY=e420 70000 0 0 0 0
>> ABS=260800001000003
>> MODALIAS=input:b0011v0002p0008e0300-e0,1,3,k110,111,112,145,14A,14D,14E,14F,ra0,1,18,2F,35,36,39,mlsfw
>> [dtor@dtor-d630 work]$
>>
>> That should give you plenty data to work with. Yes, the 2nd option
>> involves additional filesystem operations, but this is sysfs (so you are
>> not hitting real media) and you only need a few (open, read, and close)
>> per device.
>
> Yes this method can surely solve the task , but not the purpose.
> My query is why not to use more efficient way when we can ?
> ( Already discussed this way is backward compatible and is optional to use)
>
>
>
> Apart from above, Could you please tell me the role/use of init_name variable,
> which is defined in "struct device" ?
> (I think, it is also used to set name of device node)
>
> Thanks,
> Aniroop Mathur
>
>>
>> Thanks.
>>
>> --
>> Dmitry
