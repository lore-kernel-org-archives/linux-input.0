From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Fri, 12 May 2017 19:50:17 +0200
Message-ID: <a945304c-b125-5c9c-e656-3027f75186d7@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
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
 <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com>
 <c2492242-71c3-1bd5-8e1e-0f282e9ab0d1@gmail.com>
 <CAN+gG=H_B_Y9WspjJKJCLKyAHCfLfQgazifeQ_hPMm8o4nqJow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34096 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdELRuW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 May 2017 13:50:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id q24so700375lfb.1
        for <linux-input@vger.kernel.org>; Fri, 12 May 2017 10:50:21 -0700 (PDT)
In-Reply-To: <CAN+gG=H_B_Y9WspjJKJCLKyAHCfLfQgazifeQ_hPMm8o4nqJow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>

On 12.05.2017 16:28, Benjamin Tissoires wrote:
> On Fri, May 12, 2017 at 4:23 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>>
>> On 05/12/2017 09:57 AM, Arek Burdach wrote:
>>>
>>> On 12.05.2017 09:39, Benjamin Tissoires wrote:
>>>> On Fri, May 12, 2017 at 9:25 AM, Arek Burdach <arek.burdach@gmail.com>
>>>> wrote:
>>>>> On 12.05.2017 08:56, Martin Kepplinger wrote:
>>>>>>>>>>> No, you won't have "move after hold>5s" broken. Because at the HID
>>>>>>>>>>> level, the device is supposed to send an update on every touch
>>>>>>>>>>> when
>>>>>>>>>>> reporting a touch (for Windows 8 devices). So if there are tiny
>>>>>>>>>>> movements filtered at the input level in the kernel, we will get
>>>>>>>>>>> those
>>>>>>>>>>> and I suspect the timeout will only appear when the finger actual
>>>>>>>>>>> leaves the surface.
>>>>>>>>>> ok. sounds a little more like a solution in the kernel would be
>>>>>>>>>> justified. Isn't it? It still feels dangerously ugly.
>>>>>>>>>>
>>>>>>>>>> Mainly I wanted to point out that if you somehow have to stay with
>>>>>>>>>> "no"
>>>>>>>>>> for such broken devices, tslib would be a garbage can for userspace
>>>>>>>>>> workarounds. (in this case, most probably a new device-specific
>>>>>>>>>> hidraw
>>>>>>>>>> based module).
>>>>>> (...)
>>>> I am currently checking the requirements for the devices to be
>>>> validated by Microsoft:
>>>> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/compatibility/1703/device-input-digitizer
>>>>
>>>>
>>>> I would believe that the Latency and ReportRate requirements mean that
>>>> as long as a finger is there, it should be reported at at least 60Hz,
>>>> meaning that if there are no input reports for more than 16 ms, all
>>>> fingers should be lifted. I think we can work something like that
>>>> (taking an arbitrary multiple of 60 Hz would prevent any system lag),
>>>> and release the touches if nothing comes in for, lets say, 250ms.
>>> Thank you Benjamin, it is significant brick for building knowledge how
>>> this devices are handled in Windows. I will take a look in our drivers
>>> and will try to understand the code and find the way how to handle it.
>>>
>>>> I should be able to work on that for Win8 devices. Win7 devices are a
>>>> different beast, but hopefully they are nearly extinct or at least
>>>> quirked in the kernel for them to be working.
>>>>
>> I have something which seems to compile, but for various reasons I haven't tested it (yet):
(...)
>>  From what I can read in the documentation, this might be enough. However,
>> I wouldn't be surprised if this segfaults for whatever reasons.
>> Also note that there is no guards between the execution of the release and
>> the incoming events. So if you wait around 250 ms between 2 touches, nothing
>> prevents a race between the timeout previously started and the actual true
>> touches.
>>
I've just tested it. Tapping works like a charm! but ... dragging 
stopped to work at all. From logs is see that release event is produced 
even if there is some other event like ABS_MT_POSITION_Y.

Maybe one useful information is that I've observed that average delay 
between events when I'm moving finger on screen or using touchpad is 
about 7-9 ms.

Feel free to send patch proposals for testing. I'll try to debug what is 
wrong.

Cheers,
Arek
