From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Wed, 25 Feb 2015 15:58:20 +0100
Message-ID: <54EDE30C.3080208@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>	<CAN+gG=F7kJXmvCV7CiQxfdn9wv8a9EkcLjaj9G8fbV=hqkYecQ@mail.gmail.com> <CAN+gG=FwOGMS66q4GC=jTYvyRkO4Mi6s2wmVGfchLtx6i=BA7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=FwOGMS66q4GC=jTYvyRkO4Mi6s2wmVGfchLtx6i=BA7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 25-02-15 15:36, Benjamin Tissoires wrote:
> On Mon, Feb 16, 2015 at 10:23 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Fri, Feb 6, 2015 at 3:04 PM, Benjamin Tissoires
>> <benjamin.tissoires@redhat.com> wrote:
>>> Hi,
>>>
>>> This is the second episode of the Lenovo 2015 party :)
>>>
>>> Thanks to Andrew, we now have an idea within the driver of what are the extra
>>> buttons aimed for, and the patch series looks cleaner.
>>> Many thanks for your help.
>>>
>>> I marked only patches 1/7, 2/7 and 3/7 as stable because they are really
>>> stable fixes. Without the rest of the series, user-space can cope with the
>>> kernel result, and so there is IMO no need to backport too many patches in
>>> stable. I bet distributions will cherry-pick the rest of the series however.
>>>
>>
>> Guys,
>>
>> any chances we consider this for 3.20 (or whatever it will be numbered)?
>> I'd really like to see this accepted upstream in one way or one other
>> so we will prevent the mess we had to deal with last year.
>>
>
> Hans, Dmitry,
>
> well, it's been 3 weeks since I received the loaner I have to support
> these touchpads. I will have to return it next week or the week after
> at most. That means that I will not be able to conduct more tests at
> that point.
> Can I ask you to please review the series?

Ah, sorry I missed you did a v2 (I did review v1).

Series looks good to me and is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

>
> Sorry for pushing, but I am running out of time and I'd like to be
> able to include the fixes in RHEL/Fedora too.
>
> Cheers,
> Benjamin
>
>>> Benjamin Tissoires (7):
>>>    Input: synaptics - fix middle button on Lenovo 2015 products
>>>    Input: synaptics - handle spurious release of trackstick buttons
>>>    Input: synaptics - do not retrieve the board id on old firmwares
>>>    Input: synaptics - retrieve the extended capabilities in query $10
>>>    Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
>>>    Input: synaptics - re-route tracksticks buttons on the Lenovo 2015
>>>      series
>>>    Input: synaptics - Remove X1 Carbon 3rd gen from the topbuttonpad list
>>>
>>>   drivers/input/mouse/synaptics.c | 129 +++++++++++++++++++++++++++++-----------
>>>   drivers/input/mouse/synaptics.h |  28 +++++++++
>>>   2 files changed, 122 insertions(+), 35 deletions(-)
>>>
>>> --
>>> 2.1.0
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
