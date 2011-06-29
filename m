From: Austin Zhang <zhang.austin@gmail.com>
Subject: Re: [questions]touch driver.
Date: Thu, 30 Jun 2011 00:28:40 +0800
Message-ID: <BANLkTinLtAAZJxvPk+wiZQ=-E14v6o=7tQ@mail.gmail.com>
References: <BANLkTinXNa9Uu+d1=pwH6aDJ-wtOVJ+jiQ@mail.gmail.com>
	<BANLkTinAHXnz98dJNQFeDSVRMR5U7WdKbA@mail.gmail.com>
	<BANLkTin+BwR7XBO3swqnsuxw_V2Nkz4GdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38954 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143Ab1F2Q2l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 12:28:41 -0400
Received: by iyb12 with SMTP id 12so1162602iyb.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 09:28:41 -0700 (PDT)
In-Reply-To: <BANLkTin+BwR7XBO3swqnsuxw_V2Nkz4GdA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, rydberg@euromail.se

Thanks for your reply.

>> 1 For touch panel, if it is HID type panel, then for enabling
>> autosuspend for this device, can we only let its parent device enable
>> autosuspend as default, don't need do anything within that touch
>> driver?
>
> I don't really understand this point.
> The hid multitouch panel sleep issue has been solved in
> hid-multitouch. Normally there are no problems with suspend to ram (if
> you mean that by autosuspend) except if the device need to be in a
> special mode (as for most multitouch devices).
> See the function mt_reset_resume in hid-multitouch.c
Here, for autosuspend, what I am pointing to is USB autosuspend (say,
supports_autosuspend = 1). For the current hid touch panel, seemed no
one declare it explicitly, so I want to know if hid touch panel
implement autosuspend from his up-level class.

>
>>
>> 2 When setting fuzz parameter by input_set_abs_params, what is the
>> typical rule/scenarios in general? For example, if one device which
>> supports logical max sample in X/Y as 4096*3072 and the screen LCD
>> resolution as 1024*768, then fuzz=100 is meaning that the driver will
>> not report (by input_event) contact point within 50 sample point
>> (fuzz/2) to userspace? And if in this case, the high level gesture
>> recognizer is setting Manhattan length as 60, does it means it is ok
>> if the Manhattan length of contact point coordinator from driver is
>> less than 240? (60*4)
>
> Personally, I don't care with fuzz. My idea of the kernel is that it
> needs to send data from the device with less transformations (or we
> won't be able to use it in user space).
> You should ask Henrik Rydberg on fuzz as he is the one to introduce it
> in hid-multitouch.
Thanks.

> There is also a problem with your explanation: fuzz should not be
> related to screen resolution as in the kernel we are not aware of the
> screen resolution and the mapping.
Yes, we don't know the resolution in userspace. But as above my
description, our touch panel has resolution as Xtouch*Ytouch, if I set
fuzz=<fuzz_value>, then from the current code, contact point within
fuzz_value/2 will be treated as same contact point, that filtered some
noise. And the high level touch/gesture recognizer also has rule to
filter noise (by Manhattan length).
So can I assume:
If the high level gesture recognizer set Manhattan length as 60 and
Xorg sets screen resolution as Xlcd*Ylcd, then almost X-direction
changes of contact point within 60*(Xtouch/Xlcd) will be treated as
same X-direction coordinate by userspace gesture recognizer?
And if it is ture, then fuzz parameter seemed not so useful.


> I think, and it's my own opinion that fuzz should be used when the
> device is not stable, i.e. when it has a range of 4096 for instance
> and the values are floating in a range of 10 for instance.
In above case, if Xtouch*Ytouch= 4096*3072, Xlcd*Ylcd = 1024*768, then
the floating of 10 in panel is meaning 2.5 in logical resolution,
which << the Manhattan length in gesture recognizer. So even thought I
don't set it in driver, the floating also was filtered from userspace.
And also 60 Manhattan length in userspace would be 240 Manhattan
length in driver, seemed no device will have such big floating in
practice. So fuzz is useless in this situation.


> Then, on some integrated platforms (tablets, and others) fuzz can be
> used to not awake too much the different processes that rely on input.
> But I would say this is a side effect of the original goal (again,
> it's my only guess).
>
>>
>> 3 Seemed few drivers (only egalax and intel-mid-touch) are using this
>> fuzz param, so in most cases, it is one in-case params to leave to
>> user for 'tuning' only? Then should it be exported as module
>> parameter?
>
> With the current implementation, I don't think so. If you want to
> submit a patch, I won't vote against. Dimitry and Jiri may have a
> different view on this.
>
> Cheers,
> Benjamin
>
>>
>> Thanks for your answer in advance.
>>
>
