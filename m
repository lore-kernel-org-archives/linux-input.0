From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Thu, 9 Mar 2017 19:48:06 +0100
Message-ID: <97099577-181d-ac94-4d9e-ab5ca64f9ff6@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
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
 <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbdCISsL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 13:48:11 -0500
In-Reply-To: <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 09-03-17 15:45, Hans de Goede wrote:
> Hi,
>
> On 09-03-17 15:03, Andy Shevchenko wrote:
>> On Thu, 2017-03-09 at 14:57 +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 08-03-17 19:25, Andy Shevchenko wrote:
>
> <snip soc_button_array stuff>
>
>>>>>>>>> I think that "extcon: int3496: Add GPIO ACPI mapping
>>>>>>>>> table"
>>>>>>>>> will
>>>>>>>>> need
>>>>>>>>> a similar change (I haven't tested it yet).
>>>>>
>>>>> So I assume you want to do the same (pass NULL as con-id to
>>>>> gpiod_get_index()) for the extcon-in3496 driver or do you want
>>>>> to keep the GPIO ACPI mapping table there?
>>>>
>>>> A slightly preferable table variant (needs to be fixed I guess)
>>>> because
>>>> initial one used to have different labels.
>>>
>>> Ok, I will test with the acpi-mapping table then and if necessary
>>> create a fixup patch for it and send that to you.
>>
>> Sounds like a plan!
>>
>> Since extcon patches are landed already mainstream it might make sense
>> to send it as usual to all maintainers.
>
> Ack, so to be clear we should use gpiod_get not gpiod_get_index with
> the acpi mapping table, right ? The reason I'm asking is that my
> test devices only have the id pin which has index 0 so in my
> experience with soc_button_array it will work with both
> (the button with index 0 would even work with gpiod_get_index).

Ok, so there is one problem with the extcon-intel-int3496.c
together with your gpio patches:

[ 2382.484415] gpio gpiochip1: (INT33FF:01): gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
[ 2382.484425] gpio gpiochip1: (INT33FF:01): unable to lock HW IRQ 3 for IRQ
[ 2382.484429] genirq: Failed to request resources for INT3496:00 (irq 174) on irqchip chv-gpio
[ 2382.484518] intel-int3496 INT3496:00: can't request IRQ for USB ID GPIO: -22
[ 2382.500359] intel-int3496: probe of INT3496:00 failed with error -22

This can be fixed / worked around by doing this:


--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -113,6 +113,7 @@ static int int3496_probe(struct platform_device *pdev)
                 dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
                 return ret;
         }
+       gpiod_direction_input(data->gpio_usb_id);

         data->usb_id_irq = gpiod_to_irq(data->gpio_usb_id);
         if (data->usb_id_irq < 0) {

But the gpio is requested as:

         data->gpio_usb_id = devm_gpiod_get(dev, "id", GPIOD_IN);

Note the GPIOD_IN I think the new behavior is caused by:

https://bitbucket.org/andy-shev/linux/commits/ba458eb945879a66eac75de69a4e7312c4f44cc7

Of which I'm not sure it is a good idea, as the dsdt of my
cube iwork8 air shows:

         Device (OTG2)
         {
             Name (_HID, "INT3496")  // _HID: Hardware ID
             Name (_CID, "INT3496")  // _CID: Compatible ID

Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
     Name (ABUF, ResourceTemplate ()
     {
         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
             )
             {   // Pin list
                 0x0003
             }
         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
             "\\_SB.GPO3", 0x00, ResourceConsumer, ,
             )
             {   // Pin list
                 0x002E
             }
     })
     Return (ABUF) /* \_SB_.PCI0.OTG2._CRS.ABUF */
}

}

The dstd-s out there in the wild do not always get this right.

With my workaround from above the extcon-intel-int3496 driver
does work properly again, so I see 2 options here:

1) Let drivers workaround known broken IoRestriction in dstd-s
by using gpiod_direction_...

2) Drop the patch which makes gpiod_get honor the IoRestrictions

I've also tested the silead driver and with the new more strict
gpio code it works as it should as-is (as expected).

Regards,

Hans
