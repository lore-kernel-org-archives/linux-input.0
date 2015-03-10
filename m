From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Mon, 9 Mar 2015 23:17:27 -0700
Message-ID: <CAKbGBLjD_YmJoDtDinhmwjfduBOvA9F-0XYQ65f-4uqx=N0f+Q@mail.gmail.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
	<CAN+gG=F7kJXmvCV7CiQxfdn9wv8a9EkcLjaj9G8fbV=hqkYecQ@mail.gmail.com>
	<CAN+gG=FwOGMS66q4GC=jTYvyRkO4Mi6s2wmVGfchLtx6i=BA7w@mail.gmail.com>
	<54EDE30C.3080208@redhat.com>
	<20150309064649.GE17331@dtor-ws>
	<54FD58B0.7060003@redhat.com>
	<CAN+gG=EaSpH2sG2HYXJMbCfCWOfvyZ9H9GYMBbkCUmKjfOgCPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36934 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbCJGR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 02:17:29 -0400
Received: by lbdu10 with SMTP id u10so29068237lbd.4
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2015 23:17:27 -0700 (PDT)
In-Reply-To: <CAN+gG=EaSpH2sG2HYXJMbCfCWOfvyZ9H9GYMBbkCUmKjfOgCPg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Daniel Martin <consume.noise@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Benjamin,

I just got a ThinkPad X250 in today and have tried out your patches on
3.19.1. Before the patches, the top TrackPoint buttons weren't working
at all, but the clickpad was working fine. For the most part, your
patches fixed the TrackPoint.

There's something weird going on though. If I control the mouse cursor
with the trackpoint nub, it feels "slow". At first I though it was
running the video mode at half the normal refresh rate, because the
pointer was only moving at what felt like a 30Hz refresh rate. But
then I tried the trackpad, and it behaves as expected (snappy and
responsive). Note that this is a definite difference between the BDW
generation and the HSW generation, as my HSW ThinkPad Yoga feels fine.

Is there something in the driver that controls the TrackPoint nub's
sampling rate?

- Steven

On Mon, Mar 9, 2015 at 12:36 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Mon, Mar 9, 2015 at 4:24 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 09-03-15 07:46, Dmitry Torokhov wrote:
>>>
>>> On Wed, Feb 25, 2015 at 03:58:20PM +0100, Hans de Goede wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 25-02-15 15:36, Benjamin Tissoires wrote:
>>>>>
>>>>> On Mon, Feb 16, 2015 at 10:23 PM, Benjamin Tissoires
>>>>> <benjamin.tissoires@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Feb 6, 2015 at 3:04 PM, Benjamin Tissoires
>>>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> This is the second episode of the Lenovo 2015 party :)
>>>>>>>
>>>>>>> Thanks to Andrew, we now have an idea within the driver of what are
>>>>>>> the extra
>>>>>>> buttons aimed for, and the patch series looks cleaner.
>>>>>>> Many thanks for your help.
>>>>>>>
>>>>>>> I marked only patches 1/7, 2/7 and 3/7 as stable because they are
>>>>>>> really
>>>>>>> stable fixes. Without the rest of the series, user-space can cope with
>>>>>>> the
>>>>>>> kernel result, and so there is IMO no need to backport too many
>>>>>>> patches in
>>>>>>> stable. I bet distributions will cherry-pick the rest of the series
>>>>>>> however.
>>>>>>>
>>>>>>
>>>>>> Guys,
>>>>>>
>>>>>> any chances we consider this for 3.20 (or whatever it will be
>>>>>> numbered)?
>>>>>> I'd really like to see this accepted upstream in one way or one other
>>>>>> so we will prevent the mess we had to deal with last year.
>>>>>>
>>>>>
>>>>> Hans, Dmitry,
>>>>>
>>>>> well, it's been 3 weeks since I received the loaner I have to support
>>>>> these touchpads. I will have to return it next week or the week after
>>>>> at most. That means that I will not be able to conduct more tests at
>>>>> that point.
>>>>> Can I ask you to please review the series?
>>>>
>>>>
>>>> Ah, sorry I missed you did a v2 (I did review v1).
>>>>
>>>> Series looks good to me and is:
>>>>
>>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>>
>>> I did a few edits of the patches in the 2 series so I created a separate
>>> branch "synaptics" based on 3.19. I'd appreciate if you could give it q
>>> quick spin before I will send it for 4.0.
>>
>>
>> I don't have access to the hardware in question, but Benjamin does, so
>> we'll have to wait (a bit) for him to wake up :)
>>
>
> It took me a little bit of time to retrieve the laptop and get it tested.
> So far, so good:
> - t440s (2013) shows the correct behavior
> - x1 carbon 3 has the buttons properly forwarded through the
> trackstick interface and are reacting as expected.
>
> Thanks Dmitry!
>
> I've added Daniel to the thread and asked it this morning if he could
> also give a try to the series.
>
> Cheers,
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
