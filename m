From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Sat, 9 Jan 2016 04:13:10 +0530
Message-ID: <CADYu30-Nykka4gwWCUSDt1_pKUZkYDuGY5X_giFLOYxDSDr3wA@mail.gmail.com>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
	<CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
	<20160108201346.6a6694e2@lxorguk.ukuu.org.uk>
	<CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
	<20160108203340.2b728a41@lxorguk.ukuu.org.uk>
	<CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
	<CAKdAkRQ6SPt2oBJPv6h-gPVsEGZWRcBfp7J-TZpzWnO-nEOXKw@mail.gmail.com>
	<CADYu309cx-mb0skOTOkT67bjg83Vx6A-_rJ2QWRkbyLL9yHKxQ@mail.gmail.com>
	<20160108222720.GB39042@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36614 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcAHWnM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 17:43:12 -0500
In-Reply-To: <20160108222720.GB39042@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, Jan 9, 2016 at 3:57 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Jan 09, 2016 at 03:46:41AM +0530, Aniroop Mathur wrote:
>> On Sat, Jan 9, 2016 at 2:32 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Fri, Jan 8, 2016 at 12:51 PM, Aniroop Mathur
>> > <aniroop.mathur@gmail.com> wrote:
>> >> On Sat, Jan 9, 2016 at 2:03 AM, One Thousand Gnomes
>> >> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >>> On Sat, 9 Jan 2016 01:50:42 +0530
>> >>> Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>> >>>
>> >>>> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
>> >>>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >>>> >> During system boot up, user space buf size is fixed, it cannot be
>> >>>> >> resized later and we cannot choose by hit&trial.
>> >>>> >> struct input_event* mBuffer = new input_event[mBuf];
>> >>>> >
>> >>>> > Who says that won't change ? Imagine a future case where plugging in a
>> >>>> > device changes the buffer size ?
>> >>>> >
>> >>>>
>> >>>> Ofcourse buffer size can be changed but it will also change the value of bufsize
>> >>>> variable and accordingly user space client should also change its buf size.
>> >>>
>> >>> If its hot plugged why shouldn't that value change dynamically after
>> >>> you've asked ?
>> >>>
>> >>
>> >> Please put up your query clearly. what value ? what asked ?
>> >
>> > There is nothing that would stop us (kernel) to decide to resize the
>> > buffer after you issued your new EVIOCGBUFSIZE. For example one can
>> > decide to implement a feature that will double the size of evdev's
>> > client buffer if there happened too many overruns i a given time
>> > period.
>> >
>>
>> If one decided to double the size of evdev buffer then it would be done
>> by the same client facing buffer overrun and for this case client would
>> not need to request for evdev buf size again as it has only set it. And
>> still evdev buf size variable value be changed as well with the request
>> to change buf size so client can read it again, if wishes.
>
> I was talking about changing the size of the buffer on kernel side.
>
>>
>> > In any case the userpsace consumers already have to inspect input
>> > device in question (number of axes and what they are; number of
>> > keys/buttons, number of slots, etc) so that they can handle devices
>> > properly and it should have enough information to intelligently size
>> > of the receiving buffers. There is no need for a new kernel ioctl.
>> >
>>
>> yes, consumers have to inspect input device but they cannot know
>> the size of evdev buffer initially set as it is calculated in evdev.c file
>> Consumer does not know that there is a limit of 8 packets.
>> #define EVDEV_BUF_PACKETS       8
>> unsigned int n_events =
>>     max(dev->hint_events_per_packet * EVDEV_BUF_PACKETS, EVDEV_MIN_BUFFER_SIZE);
>> return roundup_pow_of_two(n_events);
>> This value varies for every device as every device has different value
>> of hint_events_per_packet.
>>
>> Even after increasing kernel buffer size, buffer overrun can occur
>> if reading is delayed and userspace buf is very small say only 1/2.
>> In this case, buffer overrun will still occur and it will only be delayed.
>> This was happening in my use case for gyroscope sensor device for
>> which I initially forcefully increased the evdev buf size but problem was
>> still not solved and buffer overrun was only delayed. The cause of the
>> problem was that gyroscope client was using very small buf size for
>> reading and after increasing the user space buf size, problem was solved.
>> If client chooses maximum possible buffer size then it will be able to
>> consume maximum events when reading is delayed and hence there will
>> be least chance of buffer overrun. Evdev buf size should only be increased
>> when buffer overrun occurs even with max user-space buf size.
>> But the max user space buf size cannot be known until client request for it
>> using this ioctl. So, I added it.
>>
>> So, are you convinced now that this ioctl is required ?
>
> No because I'd rather you managed size of your own buffer and increased
> it as needed if you see drops. Let's say kernel decides to have buffer
> of 100 events, do you have to mirror this size? What if device only
> generates 1 event per minute?
>

We do not want any drop in the first place by keeping max buf size for
reading for devices which need it only. On changing buf size on run time
would not do any help because many events have already been dropped.
And then after rebooting the system, user space buf size will again change
to old value and so again events will be dropped and again buf size need to
be changed.
Yes, there is a need to mirror it, especially for device which support batching.
If device generates only 1 event per minute, then client can choose minimum
user space buf size, say 1. It is not compulsory to choose max buf size always
for every device.

Regards,
Aniroop

> Thanks.
>
> --
> Dmitry
