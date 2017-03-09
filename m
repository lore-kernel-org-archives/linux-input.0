From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Thu, 9 Mar 2017 15:45:42 +0100
Message-ID: <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
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
 <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
 <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
 <1488969002.20145.119.camel@linux.intel.com>
 <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
 <1488973582.20145.125.camel@linux.intel.com>
 <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
 <1488997525.20145.161.camel@linux.intel.com>
 <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
 <1489068196.20145.169.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932290AbdCIOpr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 09:45:47 -0500
In-Reply-To: <1489068196.20145.169.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 09-03-17 15:03, Andy Shevchenko wrote:
> On Thu, 2017-03-09 at 14:57 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 08-03-17 19:25, Andy Shevchenko wrote:

<snip soc_button_array stuff>

>>>>>>>> I think that "extcon: int3496: Add GPIO ACPI mapping
>>>>>>>> table"
>>>>>>>> will
>>>>>>>> need
>>>>>>>> a similar change (I haven't tested it yet).
>>>>
>>>> So I assume you want to do the same (pass NULL as con-id to
>>>> gpiod_get_index()) for the extcon-in3496 driver or do you want
>>>> to keep the GPIO ACPI mapping table there?
>>>
>>> A slightly preferable table variant (needs to be fixed I guess)
>>> because
>>> initial one used to have different labels.
>>
>> Ok, I will test with the acpi-mapping table then and if necessary
>> create a fixup patch for it and send that to you.
>
> Sounds like a plan!
>
> Since extcon patches are landed already mainstream it might make sense
> to send it as usual to all maintainers.

Ack, so to be clear we should use gpiod_get not gpiod_get_index with
the acpi mapping table, right ? The reason I'm asking is that my
test devices only have the id pin which has index 0 so in my
experience with soc_button_array it will work with both
(the button with index 0 would even work with gpiod_get_index).

Regards,

Hans
