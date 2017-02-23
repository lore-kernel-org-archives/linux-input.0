From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Thu, 23 Feb 2017 15:19:05 +0100
Message-ID: <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdBWO3Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 09:29:24 -0500
In-Reply-To: <1487778778.20145.22.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi Andy,

On 22-02-17 16:52, Andy Shevchenko wrote:
> On Sun, 2017-02-12 at 11:40 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 10-02-17 12:52, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 02-02-17 14:12, Mika Westerberg wrote:
>>>> On Thu, Feb 02, 2017 at 01:50:58PM +0100, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 02-02-17 13:32, Mika Westerberg wrote:
>>>>>> On Thu, Feb 02, 2017 at 02:10:18PM +0200, Mika Westerberg
>>>>>> wrote:
>>>>>>> I do not have a copy of the patch in this thread but sounds
>>>>>>> like
>>>>>>> something that might work.
>>>>>>
>>>>>> Actually, I seem have a copy of that patch.
>>>>>>
>>>>>> So you are saying that the device has a power GPIO in ACPI
>>>>>> _CRS but it
>>>>>> should not be used for some reason?
>>>>>
>>>>>                 Method (_CRS, 0, NotSerialized)  // _CRS:
>>>>> Current Resource Setti
>>>>>                 {
>>>>>                     Name (WBUF, ResourceTemplate ()
>>>>>                     {
>>>>>                         I2cSerialBusV2 (0x0040,
>>>>> ControllerInitiated, 0x00061A80,
>>>>>                             AddressingMode7Bit,
>>>>> "\\_SB.PCI0.I2C6",
>>>>>                             0x00, ResourceConsumer, , Exclusive,
>>>>>                             )
>>>>>                         GpioIo (Exclusive, PullDefault, 0x0000,
>>>>> 0x0000, IoRestri
>>>>>                             "\\_SB.GPO1", 0x00,
>>>>> ResourceConsumer, ,
>>>>>                             )
>>>>>                             {   // Pin list
>>>>>                                 0x0019
>>>>>                             }
>>>>>                         GpioInt (Edge, ActiveHigh, Shared,
>>>>> PullDefault, 0x0000,
>>>>>                             "\\_SB.GPO1", 0x00,
>>>>> ResourceConsumer, ,
>>>>>                             )
>>>>>                             {   // Pin list
>>>>>                                 0x0013
>>>>>                             }
>>>>>                     })
>>>>>                     Return (WBUF) /*
>>>>> \_SB_.PCI0.I2C6.TCS4._CRS.WBUF */
>>>>>                 }
>>>>>
>>>>> The setting of the special bit in the gpio control register
>>>>> leads to
>>>>> drivers/pinctrl/intel/pinctrl-cherryview.c
>>>>> chv_gpio_request_enable()
>>>>> returning -EBUSY, which in return makes gpiod_get_optional
>>>>> return -EBUSY for this pin, rather then NULL (as we would like).
>>>>
>>>> Actually what is wrong here is that your gpiod_get(dev, "power")
>>>> falls
>>>> back to use plain indexes and returns the first GPIO even though
>>>> it
>>>> should not as the driver specifically requests GPIO with name
>>>> "power"
>>>> and there is no _DSD.
>>>>
>>>> Andy (Cc'd) has a patch that tries to make the fallback mechanism
>>>> more
>>>> stricter which should in theory fix the problem as well. The patch
>>>> series is here:
>>>>
>>>> https://bitbucket.org/andy-shev/linux/commits/338c0226b631b8b497d1
>>>> 43070a301d8b8883c349?at=master
>>>
>>> Ok, that patches fixes the issues I was seeing with the silead
>>> driver
>>> on my cube iwork8 air cherrytrail tablet.
>>
>> But unfortunately it causes regressions for drivers which actually use
>> gpiod_get_by_index, e.g. drivers/extcon/extcon-intel-int3496.c, which
>> does:
>>
>>          data->gpio_usb_id = devm_gpiod_get_index(dev, "id",
>>                                                  INT3496_GPIO_USB_ID,
>>                                                  GPIOD_IN);
>>
>> Where GPIOD_IN is 0, (it also gets gpios for index 1 and 2), I guess
>> this driver can be fixed by replacing "id" with NULL, but the name
>> gets used in things like /sys/kernel/debug/gpio and is actually
>> useful there, so it looks like that patch from Andy needs some
>> work so as to not see getting by index as an undesirable fallback
>> while the driver is actually doing a request gpio by index.
>
> Hans, I have just pushed most recent stuff into my branch. Would you
> have a chance test it? It has extcon patches embedded.

First of all thank you for working on this.

Before I spend time on testing this I must say that I've the feeling
these patches are going in the wrong direction.

I would expect you to modify gpiod_get_index to internally inside
the gpiolib code pass a flag which makes it clear that the name is
just a hint and that it should fallback to the index (*), as it is
doing before your patches to clean things up. That way we avoid
needing to fixup the drivers and add with IMHO is unnecessary
boilerplate to them, in both the extcon-intel-int3496.c and
soc_button_array.c cases we really just want to get a gpio by
index and the name is just there to make debugging easier.

Also if you look at the ACPI 6.0 or later spec. then there is
a new "generic button device" defined there and I've patches to
soc_button_array.c pending to add support for that:

https://github.com/jwrdegoede/linux-sunxi/commit/4fad488f818a9e45bd27e6030dfcaddb555d0e2d
https://github.com/jwrdegoede/linux-sunxi/commit/ae8a643e9060979e43950ae3ad09623c6b7fcaa5

The ACPI spec clearly defines the _DSD (device specific data)
for these devices with a ACPI0011 _HID as containing an index
into the ACPI resources table for the device, since your patches
make it impossible to directly get a gpio by index (if one still
want the gpio to have a sensible name) that means I now need
to create an acpi_gpio_mapping table on the fly for this.

TL;DR: this approach seems like a lot of extra work / churn and
boilerplate code in drivers for no gain.

Can't we please just simply keep the fallback as-is when a driver
calls gpiod_get_index rather then gpiod_get ? That seems like a
lot simpler and cleaner solution to me.

Regards,

Hans



*) Or maybe even a flag that it is the index which should be looked at
and not the name, but that may break some existing users


