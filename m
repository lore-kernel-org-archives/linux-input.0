From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Fri, 12 May 2017 09:57:10 +0200
Message-ID: <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <1f16ba27-99cd-d16d-f09f-97dcda1bd358@gmail.com>
 <dee48656-1993-b52d-5451-7a0cb186f18a@synaptics.com>
 <03d13b14-1f97-eee7-4131-60ef014cbf50@gmail.com>
 <8c492623-d37c-e8e1-2445-cf86109dad44@ginzinger.com>
 <aa5cb000-7e8a-2f9b-30de-a35b0c44db96@gmail.com>
 <9e370d9b-a2d4-9fcd-9b0d-2d97e225188a@ginzinger.com>
 <CAN+gG=EchYSE4=iZU9NPOvQy6PHZVSZcA2YkoH01nhg81E+Xsw@mail.gmail.com>
 <8566ae03-faad-a1ee-2156-db49d36cea71@ginzinger.com>
 <CAN+gG=Frvd0bJ62xBp+sGFgqB5=mdYwJGo7L+MZiscNbPb4K_w@mail.gmail.com>
 <540cd246-d72f-a9eb-9618-ff2449384a21@ginzinger.com>
 <a4766146-3edb-31c6-16dd-99eee28bdd63@gmail.com>
 <CAN+gG=F8kaWaS81L9uxON-ZDQoHe6eS2puauAofJxGKkhEeCcg@mail.gmail.com>
 <8d690a3d-88f6-cef9-b271-da5dcc87741b@gmail.com>
 <12ac2e90-ba7b-8a29-bb35-40d50841a63b@ginzinger.com>
 <27a556e7-2045-2d6a-3b13-287d314375d5@gmail.com>
 <CAN+gG=G3KbhTFcXZEmiYuOmFsjADvHuwXRxz=FOKf6F9ctB8gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34105 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757679AbdELH5O (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 May 2017 03:57:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so6494726wrb.1
        for <linux-input@vger.kernel.org>; Fri, 12 May 2017 00:57:13 -0700 (PDT)
In-Reply-To: <CAN+gG=G3KbhTFcXZEmiYuOmFsjADvHuwXRxz=FOKf6F9ctB8gg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>



On 12.05.2017 09:39, Benjamin Tissoires wrote:
> On Fri, May 12, 2017 at 9:25 AM, Arek Burdach <arek.burdach@gmail.com> wrote:
>>
>> On 12.05.2017 08:56, Martin Kepplinger wrote:
>>>>>>>> No, you won't have "move after hold>5s" broken. Because at the HID
>>>>>>>> level, the device is supposed to send an update on every touch when
>>>>>>>> reporting a touch (for Windows 8 devices). So if there are tiny
>>>>>>>> movements filtered at the input level in the kernel, we will get
>>>>>>>> those
>>>>>>>> and I suspect the timeout will only appear when the finger actual
>>>>>>>> leaves the surface.
>>>>>>> ok. sounds a little more like a solution in the kernel would be
>>>>>>> justified. Isn't it? It still feels dangerously ugly.
>>>>>>>
>>>>>>> Mainly I wanted to point out that if you somehow have to stay with
>>>>>>> "no"
>>>>>>> for such broken devices, tslib would be a garbage can for userspace
>>>>>>> workarounds. (in this case, most probably a new device-specific hidraw
>>>>>>> based module).
>>> (...)
>>>
>>>> Thank you for clarification. So do someone have an idea how it is
>>>> possible that Windows manages this? From my point of view, they can't
>>>> rely on timeouts because effect is visible immediately after releasing
>>>> finger. Is it possible that they use other protocol for communication
>>>> with device then we do? Because beside that, I don't see any other
>>>> option - there is too few information from device to correctly handle
>>>> this situation.
>>> hey, Benjamin explained what most probably is going on, see above, so:
>>>
>>> 1. convice yourself that microsoft isn't using out-of-band data by
>>> sniffing the connection.
>> Touchscreen is communicating via i2c - am i right? Can you recommend some
>> i2c sniffer for windows?
> I wrote something few months ago:
> https://github.com/bentiss/SimplePeripheralBusProbe
> But it requires you to have confidence in not breaking your EFI :)
>
> I can help you setting the bits up if you want.
>
>>> 2. if not, and Benjamin is right, come up with a timer- and hidraw based
>>> solution (I guess) and convince him and Dmitry to take it.
>>>
>>> 3. if they don't see any chance to support such broken behaviour in the
>>> kernel, which could as well be and also has it's benefits in some way,
>>> you write the thing in userspace (a tslib raw module is only one example
>>> that would make it easy for you).
>>>
>>> Even *if* Synaptics would come up with a firmware update:
>>> 1. the current firmware is already out there in the wild;
>>> 2. it takes time and work to get people to update
>>>
>>> so, if I had the device, I'd write a workaround.
>> It is reasonable what you've wrote. The only blocker for me is that I have
>> almost zero-experience in low level programming. I'm from java world :-) It
>> is why I was looking for some low entry level solution. I'll do my best but
>> every helping hand will be appreciated.
> I am currently checking the requirements for the devices to be
> validated by Microsoft:
> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/compatibility/1703/device-input-digitizer
>
> I would believe that the Latency and ReportRate requirements mean that
> as long as a finger is there, it should be reported at at least 60Hz,
> meaning that if there are no input reports for more than 16 ms, all
> fingers should be lifted. I think we can work something like that
> (taking an arbitrary multiple of 60 Hz would prevent any system lag),
> and release the touches if nothing comes in for, lets say, 250ms.

Thank you Benjamin, it is significant brick for building knowledge how 
this devices are handled in Windows. I will take a look in our drivers 
and will try to understand the code and find the way how to handle it.

>
> I should be able to work on that for Win8 devices. Win7 devices are a
> different beast, but hopefully they are nearly extinct or at least
> quirked in the kernel for them to be working.
>
> Cheers,
> Benjamin
>
>> Cheers,
>> Arek

