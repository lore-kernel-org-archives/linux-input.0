From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID input dealing with multiple collections?
Date: Mon, 9 Sep 2013 16:16:46 +0200
Message-ID: <CAN+gG=F9OmeXM_s_MX1_q+H=hAwZB518Lx_6FZd42Z8PX=SpJw@mail.gmail.com>
References: <522DC594.2000305@brettnet.eu>
	<CAN+gG=ELptZsD37P9XMAgbLCFt-yZVbgmbGrk+mLvT6G2raKLQ@mail.gmail.com>
	<522DD4AA.3020501@brettnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:51812 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab3IIOQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 10:16:49 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4873108lbi.25
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 07:16:46 -0700 (PDT)
In-Reply-To: <522DD4AA.3020501@brettnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Breton M. Saunders" <bms20@brettnet.eu>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Sep 9, 2013 at 4:01 PM, Breton M. Saunders <bms20@brettnet.eu> wrote:
> On 09/09/13 14:12, Benjamin Tissoires wrote:
>>
>> Hi,
>>
>> On Mon, Sep 9, 2013 at 2:56 PM, Breton M. Saunders <bms20@brettnet.eu>
>> wrote:
>>>
>>> Hello,
>>>
>>>    I've written a USB device which supports multiple input devices:
>>>      * A touch surface digitizer (following Microsoft's specification)
>>>      * A pen surface digitizer
>>>      * A mouse emulator
>>>
>>>    In windows each of these interfaces are exposed as a separate top
>>> level
>>> collection, e.g.:
>>>    Usage_Page(Generic Desktop)
>>>    Usage(Mouse)
>>>    Collection(Application)
>>>         ...
>>>    End_Collection
>>>    Usage_Page(Digitzer)
>>>    Usage(Touch_Screen)
>>>    Collection(Application)
>>>       ...
>>>    End_Collection
>>>    Usage(Digitizer)
>>>    Usage(Pen)
>>>    Collection(Application)
>>>       ...
>>>    End_Collection
>>>
>>>    Now this descriptor works well in Windows; all reporting channels are
>>> exposed correctly as hid devices and mouse/multitouch/pen input all works
>>> correctly as expected.  In linux, however, this is not the case.  What I
>>> see
>>> is that if I drop out the touch/pen functionality then the mouse support
>>> works correctly.  Likewise, if I drop any pair of other top level
>>> collections such that I have exactly one top level collection the system
>>> works correctly.
>>>
>>>    Am I missing something here - as in: Have I made an error in my usage
>>> of
>>> top level collections, or is linux-input's hid support incapable of
>>> dealing
>>> with multiple top level collections?
>>
>> If it works under Windows, there are huge chances that your report
>> descriptor is good.
>>
>> However, under Linux, we use the report IDs to split (if required) the
>> different inputs.
>> The good thing for you is that if I understand correctly, the device
>> you are talking about should be handled through hid-multitouch. Since
>> kernel v3.10, we have introduced the support of devices showing both a
>> digitizer and a pen (they will show up as two input devices).
>>
>> I would encourage you to test a 3.10 kernel, and/or send me some
>> traces of your devices by using hid-replay[1]. This way I will be able
>> to test your device on my laptop, and eventually figure out any
>> problem.
>>
>> Cheers,
>
> Hi Benjamin,
>
>   Thanks for the quick reply.
>
>   3.10 is a no-go for me; I need to get this working on a vanilla (or
> upgraded) version of Ubuntu 12.04; so something more like kernel version
> 3.2.  (Unfortunately, its what people are using in the field).

You can still try to use my backport available here:
https://github.com/bentiss/hid-multitouch

it _should_ work on a 3.2. You only have to add your VID/PID in
hid-multitouch to make it work.

>
>   I will, however, install a more modern kernel to test against; esp. since
> I note your HID-replay tool requires 3.6 to test with.

well, it requires the module uhid, which is available in 3.6, but also
in my backport :)
run "modprobe uhid_compat" and run hid-replay against the
/dev/hidraw-compatN device.

Anyway, if this is too much of a pain, just send me the report
descriptor in hexadecimal (and some hexadecimal captures of your
events), I'll do the formatting myself.

>
>   Would the correct approach here be to implement a composite USB device and
> have separate USB interfaces for mouse, touch and pen for compatibility with
> older kernel revisions?

I would say no because I don't know what would be the behavior of
Windows. But if you don't care about Windows and if this solution
works, it's entirely up to you.

Cheers,
Benjamin
