From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Fri, 12 May 2017 09:34:09 +0200
Message-ID: <f750af47-6940-99d4-0312-22ed794f8a01@ginzinger.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <09314823-31c8-5855-d55c-3427b58b42ca@gmail.com>
 <CAN+gG=GY_0OKXNhmbDWmfEg0o4=Vf81r4rH3BGVmyd0suJdAtA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:52471 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756410AbdELHeN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 May 2017 03:34:13 -0400
In-Reply-To: <27a556e7-2045-2d6a-3b13-287d314375d5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>



On 2017-05-12 09:25, Arek Burdach wrote:
>
>
> On 12.05.2017 08:56, Martin Kepplinger wrote:
>>>>>>> No, you won't have "move after hold>5s" broken. Because at the HID
>>>>>>> level, the device is supposed to send an update on every touch when
>>>>>>> reporting a touch (for Windows 8 devices). So if there are tiny
>>>>>>> movements filtered at the input level in the kernel, we will get
>>>>>>> those
>>>>>>> and I suspect the timeout will only appear when the finger actual
>>>>>>> leaves the surface.
>>>>>> ok. sounds a little more like a solution in the kernel would be
>>>>>> justified. Isn't it? It still feels dangerously ugly.
>>>>>>
>>>>>> Mainly I wanted to point out that if you somehow have to stay with
>>>>>> "no"
>>>>>> for such broken devices, tslib would be a garbage can for userspace
>>>>>> workarounds. (in this case, most probably a new device-specific
>>>>>> hidraw
>>>>>> based module).
>> (...)
>>
>>> Thank you for clarification. So do someone have an idea how it is
>>> possible that Windows manages this? From my point of view, they can't
>>> rely on timeouts because effect is visible immediately after releasing
>>> finger. Is it possible that they use other protocol for communication
>>> with device then we do? Because beside that, I don't see any other
>>> option - there is too few information from device to correctly handle
>>> this situation.
>> hey, Benjamin explained what most probably is going on, see above, so:
>>
>> 1. convice yourself that microsoft isn't using out-of-band data by
>> sniffing the connection.
> Touchscreen is communicating via i2c - am i right? Can you recommend
> some i2c sniffer for windows?

no, I can only look for one, like you.
https://lmddgtfy.net/?q=buy%20i2c%20sniffer

>
>> 2. if not, and Benjamin is right, come up with a timer- and hidraw based
>> solution (I guess) and convince him and Dmitry to take it.
>>
>> 3. if they don't see any chance to support such broken behaviour in the
>> kernel, which could as well be and also has it's benefits in some way,
>> you write the thing in userspace (a tslib raw module is only one example
>> that would make it easy for you).
>>
>> Even *if* Synaptics would come up with a firmware update:
>> 1. the current firmware is already out there in the wild;
>> 2. it takes time and work to get people to update
>>
>> so, if I had the device, I'd write a workaround.
> It is reasonable what you've wrote. The only blocker for me is that I
> have almost zero-experience in low level programming. I'm from java
> world :-) It is why I was looking for some low entry level solution.
> I'll do my best but every helping hand will be appreciated.
>

Keep asking Synaptics for answers then. Or pay somebody to write a
driver. Or be patient and do it yourself.

                          martin


________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

