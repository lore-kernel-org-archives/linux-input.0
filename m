From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Tue, 7 Mar 2017 14:55:31 +0100
Message-ID: <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
 <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
 <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
 <20170202131251.GQ2053@lahna.fi.intel.com>
 <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
 <3f433773-27ba-8d07-3209-6df71d6d4b33@redhat.com>
 <1487778778.20145.22.camel@linux.intel.com>
 <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
 <1488454727.20145.71.camel@linux.intel.com>
 <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
 <1488553076.20145.79.camel@linux.intel.com>
 <3be3837a-a57c-e6bf-538b-e135c1b37ff0@redhat.com>
 <1488554609.20145.81.camel@linux.intel.com>
 <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
 <1488887470.20145.108.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdCGN43 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Mar 2017 08:56:29 -0500
In-Reply-To: <1488887470.20145.108.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 07-03-17 12:51, Andy Shevchenko wrote:
> On Mon, 2017-03-06 at 10:31 +0100, Hans de Goede wrote:

<mega snip>

>>>> forcible adding fake _DSD tables everywhere, see above.
>>>
>>> Why are they fake?
>>
>> Because they are not coming from the firmware,
>
> They actually are. The problem here is that older firmwares and ACPI
> specification lack of naming GPIO resources. So, this information is
> complimentary to the existing GPIO resources. It's not fake.
>
>>  as said I believe it
>> is better to clearly differentiate between the no-connection-id (so we
>> use indexes) and the firmware provides connection-ids cases.
>
> Indexes without label is error prone approach. Sorry, I'm not going to
> vote for them. This is explained in the patches I have: we never know
> what we get by index. The mapping makes it robust.
>
> It was clearly my mistake to even think in this direction.
>
>> I believe this is better for 2 reasons:
>>
>> 1) Cleaner (and less) code for drivers which need to use indexes
>
> Yes and no. Cleaner, indeed, but less code does not always mean less
> error prone, more robust, etc.
>
>> 2) It is easier to debug things if it is clear at all levels if we
>> are dealing with indexes or connection ids
>
> And my point that adding labels along with connection IDs is a hiding of
> a huge abuse of at least ACPI case! It will not get rid of the chaos we
> have. And it will make API more confusing.

Ok, since it seems clear that I'm not going to be able to change your
mind on this, I will give your patches a try and see if they fix the
silead ts problems.

Regards,

Hans

