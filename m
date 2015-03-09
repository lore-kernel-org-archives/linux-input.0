From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Mon, 09 Mar 2015 09:24:16 +0100
Message-ID: <54FD58B0.7060003@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com> <CAN+gG=F7kJXmvCV7CiQxfdn9wv8a9EkcLjaj9G8fbV=hqkYecQ@mail.gmail.com> <CAN+gG=FwOGMS66q4GC=jTYvyRkO4Mi6s2wmVGfchLtx6i=BA7w@mail.gmail.com> <54EDE30C.3080208@redhat.com> <20150309064649.GE17331@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbbCIIY1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Mar 2015 04:24:27 -0400
In-Reply-To: <20150309064649.GE17331@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 09-03-15 07:46, Dmitry Torokhov wrote:
> On Wed, Feb 25, 2015 at 03:58:20PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 25-02-15 15:36, Benjamin Tissoires wrote:
>>> On Mon, Feb 16, 2015 at 10:23 PM, Benjamin Tissoires
>>> <benjamin.tissoires@gmail.com> wrote:
>>>> On Fri, Feb 6, 2015 at 3:04 PM, Benjamin Tissoires
>>>> <benjamin.tissoires@redhat.com> wrote:
>>>>> Hi,
>>>>>
>>>>> This is the second episode of the Lenovo 2015 party :)
>>>>>
>>>>> Thanks to Andrew, we now have an idea within the driver of what are the extra
>>>>> buttons aimed for, and the patch series looks cleaner.
>>>>> Many thanks for your help.
>>>>>
>>>>> I marked only patches 1/7, 2/7 and 3/7 as stable because they are really
>>>>> stable fixes. Without the rest of the series, user-space can cope with the
>>>>> kernel result, and so there is IMO no need to backport too many patches in
>>>>> stable. I bet distributions will cherry-pick the rest of the series however.
>>>>>
>>>>
>>>> Guys,
>>>>
>>>> any chances we consider this for 3.20 (or whatever it will be numbered)?
>>>> I'd really like to see this accepted upstream in one way or one other
>>>> so we will prevent the mess we had to deal with last year.
>>>>
>>>
>>> Hans, Dmitry,
>>>
>>> well, it's been 3 weeks since I received the loaner I have to support
>>> these touchpads. I will have to return it next week or the week after
>>> at most. That means that I will not be able to conduct more tests at
>>> that point.
>>> Can I ask you to please review the series?
>>
>> Ah, sorry I missed you did a v2 (I did review v1).
>>
>> Series looks good to me and is:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>
> I did a few edits of the patches in the 2 series so I created a separate
> branch "synaptics" based on 3.19. I'd appreciate if you could give it q
> quick spin before I will send it for 4.0.

I don't have access to the hardware in question, but Benjamin does, so
we'll have to wait (a bit) for him to wake up :)

Regards,

Hans
