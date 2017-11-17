From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: edt-ft5x06 question
Date: Fri, 17 Nov 2017 19:47:24 +0100
Message-ID: <0aa205cc-b4f0-287b-25b2-1d8fc93b91e4@micronovasrl.com>
References: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com>
 <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:53539 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdKQSr0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 13:47:26 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id EED52B01642
        for <linux-input@vger.kernel.org>; Fri, 17 Nov 2017 19:47:24 +0100 (CET)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZA-pHiPBD5Ff for <linux-input@vger.kernel.org>;
        Fri, 17 Nov 2017 19:47:24 +0100 (CET)
In-Reply-To: <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net>
Content-Language: it
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com

Hi Luca,

Il 17/11/2017 18:16, Luca Ceresoli ha scritto:
> Hi Giulio,
> 
> On 15/11/2017 17:30, Giulio Benetti wrote:
>> Hi Luca,
>>
>> I had problems with e-mail filter, so I rebuilt yours by hand.
>> Forgive me.
>>
>> See below.
>>
>> Thanks
>> Kind regards
>>
>>> Hi Giulio,
>>>
>>> On 14/11/2017 22:42, Giulio Benetti wrote:
>>>> Hello everybody,
>>>>
>>>> I'm using ft5206 with edt-ft5x06.c driver,
>>>> but what I see is that registers with M09 or M06
>>>> seem different from focaltech ft5206
>>>> https://www.buydisplay.com/download/ic/FT5206.pdf
>>>>
>>>> For example, except address 0x80 for threshold register(thgroup),
>>>> all the others don't appear:
>>>> GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
>>>>
>>>> Can someone clarify this?
>>>
>>> Are you having any problems, or just investigating?
>>
>> I need to add some other IC register to calibrate sensibility with
>> different glasses, but starting from ft5x06 or other Focaltech standard
>> IC FW.
> 
> If I understood correctly you want to implement auto-calibration, and in
> order to do that you need the four extra registers, not mentioned in the
> Focaltech datasheet. Right?

Yes, I need them inside the driver.
And some of them could be useful also as attributes.

> 
>>>> Maybe M06 or M09 are a custom firmware for focaltech ft5x,
>>>> then it has different registers?
>>>
>>> All the FT5x06 are 8051-based chips designed to implement touchscreen
>>> controllers. The FT5x26 are similar but with a more powerful core
>>> (Cortex-M IIRC).
>>>
>>> As far as I could understand and guess, their register interface is
>>> fully implemented in firmware, so it could change completely from one
>>> panel to another. However all panels that I have seen seem to use
>>> firmwares with either the "M06" or the "M09" protocol, which are
>>> implemented in the Linux driver.
>>
>> In my case driver recognizes M09, but only address 0x80
>> register(thgroup) is correct.
>> The others:
>> GAIN: 0x92
>> GAIN: 0x93
>> GAIN: 0x94
>> GAIN: 0x95
>>
>> are not described in that datasheet.
> 
> What about all the other registers? The datasheet lists a few dozen, not
> only 0x80. Are they implemented in the panel you are working on?

Yes they are, but as Datasheet is signed, this makes me believe that 
that is the default firmware focaltech load in factory.
So yes, they're implemented in 4 different panels I have.

> 
>> The point is that datasheet seems to be official by Focaltech,
>> like if they deliver that IC with a standard FW inside.
>> I can't find a way to safely probe if it's a standard FW or from EDT M09
>> or M06.
> 
> Since everything is based on the programmed firmware, and there's no
> "standard" way to detect firmware version, every firmware detection is
> bound to be a hack. But there's no better way I'm afraid. Thus device
> tree seems the only reliable way...

I think the same.

> 
> However, did you check registers FIRMID, FT5201ID (CTPM Vendor ID) and
> ID_G_LIB_VERSION_H/L? According to their name they might hold
> interesting info.

Still not, I will.

> 
> And did you consider read the "additional registers" tentatively during
> probe to detect whether they are present? What effect would this have on
> chips without those registers?

This doesn't sound so good to me.
It gives me an'idea of unstability.

So how can I go on?
Do I try to write a specific focaltech-ft5x.c driver?

> 
> Bye,
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
