From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Wed, 7 Jun 2017 15:12:59 +0200
Message-ID: <CAN+gG=FZCwqk5LLOhUHGz3B2K_khtKb3XBcVnq1aOgaCaeSw3g@mail.gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=EchYSE4=iZU9NPOvQy6PHZVSZcA2YkoH01nhg81E+Xsw@mail.gmail.com>
 <8566ae03-faad-a1ee-2156-db49d36cea71@ginzinger.com> <CAN+gG=Frvd0bJ62xBp+sGFgqB5=mdYwJGo7L+MZiscNbPb4K_w@mail.gmail.com>
 <540cd246-d72f-a9eb-9618-ff2449384a21@ginzinger.com> <a4766146-3edb-31c6-16dd-99eee28bdd63@gmail.com>
 <CAN+gG=F8kaWaS81L9uxON-ZDQoHe6eS2puauAofJxGKkhEeCcg@mail.gmail.com>
 <8d690a3d-88f6-cef9-b271-da5dcc87741b@gmail.com> <12ac2e90-ba7b-8a29-bb35-40d50841a63b@ginzinger.com>
 <27a556e7-2045-2d6a-3b13-287d314375d5@gmail.com> <CAN+gG=G3KbhTFcXZEmiYuOmFsjADvHuwXRxz=FOKf6F9ctB8gg@mail.gmail.com>
 <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com> <c2492242-71c3-1bd5-8e1e-0f282e9ab0d1@gmail.com>
 <CAN+gG=H_B_Y9WspjJKJCLKyAHCfLfQgazifeQ_hPMm8o4nqJow@mail.gmail.com>
 <c0ba39eb-c8d5-2473-36d9-ce7c605ef845@gmail.com> <CAN+gG=HyxZGu5fJ-u+WXNOKG3oXuYL5DgU1aPnmavMOhwzoZbg@mail.gmail.com>
 <699f72dc-25fe-3ffb-a20a-7800a09f0c86@gmail.com> <11ceaddd-41ad-c7fe-1ab0-453d2b1a57e1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33661 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdFGNNC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 09:13:02 -0400
Received: by mail-wr0-f174.google.com with SMTP id v104so6013805wrb.0
        for <linux-input@vger.kernel.org>; Wed, 07 Jun 2017 06:13:01 -0700 (PDT)
In-Reply-To: <11ceaddd-41ad-c7fe-1ab0-453d2b1a57e1@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=C3=A9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>

Hi Arek,

On Wed, Jun 7, 2017 at 9:27 AM, Arek Burdach <arek.burdach@gmail.com> wrote:
> Hi Benjamin,
>
>
> On 16.05.2017 11:46, Arek Burdach wrote:
>>
>>
>>
>> On 16.05.2017 10:18, Benjamin Tissoires wrote:
>>>
>>> On Mon, May 15, 2017 at 8:45 PM, Arek Burdach <arek.burdach@gmail.com>
>>> wrote:
>>>>
>>>> Hi Benjamin,
>>>>
>>>> I found out what was wrong in the change that you've provided:
>>>>
>>>> On 12.05.2017 16:28, Benjamin Tissoires wrote:
>>>>
>>>> +       if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS)
>>>> +               mod_timer(&td->release_timer, msecs_to_jiffies(250));
>>>>   }
>>>>
>>>> Should be:
>>>>
>>>> mod_timer(&td->release_timer, jiffies + msecs_to_jiffies(100));
>>>
>>> Right, thanks!
>>>
>>>> Delay should be added to current jiffies value. Also I found out that
>>>> 250 ms
>>>> is too long delay - xserver recognize such a delay as a drag gesture.
>>>> Using
>>>> 100 ms everything works perfectly!
>>>
>>> Does 160 ms works too?
>>
>> 160 ms works too but I have a feeling that values closer to 200 ms gives
>> quite a laggy experience so I'd suggest to keep value closer to 100 ms.
>> Beside that I haven't seen situation that "normal" syn_report have been
>> repored after longer delay than 30 ms. Mean value is 9 ms and 95 pp ~10 ms
>> (tested by drags with evemu-record)
>>
>>> I'd rather have 10 times the maximum time
>>> between 2 reports than 6.25 times it :)
>>> We can use 96 ms if 160 doesn't work.
>>
>> In fact 100 ms it is exactly 6 times the maximum time between 2 reports,
>> because 60 Hz frequency gives 16,(6) ms period
>>
>>>> What do you think that should be changed
>>>> more in the patch to make it ready for being submitted as an official
>>>> patch?
>>>
>>> Not much actually. I need to wrote down a commit message, sign it
>>> (your sign-off-by can also be added given that you debugged it), and
>>> that should be it.
>
>
> Do you planning to submit this change? I think that other users would be
> glad to take advantage of this fix :-)

Yes, sorry, it's still on my todo list. I am trying to fix the last
issue I can think of which is problematic:
if you happen touch again the sensor when the deferred timeout starts,
both threads will access the input node, and this can create some
nasty behaviors.

I am not 100% sure we can rely on classic solutions (spinlock,
mutexes) because in these 2 concurrent threads we are in places where
we can not stop.

So I'll need to conduct more tests and find a better/simpler solution
to not hit that. Sorry for the delay.

> Or do you want me to do it on your behalf?

I'd like you to give a test when I finally get something. However,
it's not on my top priority list, sorry for that.

Cheers,
Benjamin

>
>
>>>
>>>> I thought about some unit tests, but can't find any for hid drivers also
>>>> I
>>>
>>> I have a test suite that can emulate hid devices and inject them in
>>> hid-multitouch. The setup is a little bit manual, so I'll try to run
>>> it today and see if there are differences with or without the patch.
>>
>> Ok, waiting for signed patch
>
>
> Cheers,
> Arek
