From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Sun, 13 Mar 2016 00:15:29 +0000
Message-ID: <CA+V1Lzpe4q5te_0fqkK1+FcYVd_y1tqanhBDUAa2_5iJybP46Q@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
	<CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
	<CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
	<20160302175232.GC4318@dtor-ws>
	<CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
	<20160302211949.GD4318@dtor-ws>
	<CA+V1LzqCo9hQvh9SCitDTSLPZrV+-63QMZTSh5e0PSJPAQ=bNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33599 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbcCMAPb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Mar 2016 19:15:31 -0500
Received: by mail-qg0-f41.google.com with SMTP id t4so127495286qge.0
        for <linux-input@vger.kernel.org>; Sat, 12 Mar 2016 16:15:30 -0800 (PST)
In-Reply-To: <CA+V1LzqCo9hQvh9SCitDTSLPZrV+-63QMZTSh5e0PSJPAQ=bNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi ALL,

Please help (ideally adding some code to my skeleton) how to obtain
info in i2c client driver from ACPI DSD table.

According kernel docs I have used this one skeleton:
========================================================
#define DEVICE_NAME  "testme"

static const struct acpi_device_id icn_ts_acpi_match[] = {
    { "CHPN0001", 0 },
    { "PNP05C0", 0 },
    { },
};
MODULE_DEVICE_TABLE(acpi, icn_ts_acpi_match);


static int ts_probe(struct i2c_client *client, const struct i2c_device_id *id){
    printk("Hello from %s",__func__);

    printk(&client->dev, "%s: got a device named %s at address 0x%x,
IRQ %d, flags 0x%x\n", __func__, client->name, client->addr,
client->irq, client->flags);

return 0;
}

static struct i2c_driver icn_ts_driver = {
    .probe = ts_probe,
    .remove = ts_remove,
    .id_table = ts_i2c_id,
    .driver = {
        .name = DEVICE_NAME,
        .owner = THIS_MODULE,
        .acpi_match_table = ACPI_PTR(icn_ts_acpi_match),

    },
};

static const struct i2c_device_id ts_i2c_id[] = {
    { DEVICE_NAME, 0 },
    { }
};
MODULE_DEVICE_TABLE(i2c, gsl_ts_i2c_id);


module_i2c_driver(icn_ts_driver);

===============================================


As result - nothing until I create i2c device with the name testme. I
am using user space way from kernel doc: echo testme 0x30 >
/sys/bus/i2c/devices/i2c-3/new_device.

ONLY AFTER this (Creating i2c device) I receive output from .probe function.
And as result I do NOT receive NOTHING ACPI related because i2c device
was created manually and all information is taken from my manual
created dev (bus address and bus number), no irq - nothing while DSDT
HAS THIS INFO!


>                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
>                             AddressingMode7Bit, "\\_SB.I2C4",
>                             0x00, ResourceConsumer, ,
>                             )
>                         Interrupt (ResourceConsumer, Level,
> ActiveHigh, Exclusive, ,, )
>                         {
>                             0x00000044,
>                         }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x001A
>                             }


MAIN QUESTIONS:

1) What is wrong with i2c client driver code? Why it is NOT obtain
info from ACPI DSD table?

2) In which way should be created i2c dev while registering i2c acpi
driver? Who\where\what and how should create this i2c device?


3) how to obtain info from ACPI DSD table?
In kernel doc there is a few lines but there is no enough detail explanation:


"This means that when ACPI_HANDLE(dev) returns non-NULL the device was
enumerated from ACPI namespace. This handle can be used to extract other
device-specific configuration."

PS: In Android I have seen some technic when 1st is created platform
driver, then via ACPI handle it gather all DSDT info.

Could some one example this with code (skeleton) and how then move
from platfrom driver to i2c client driver?

Regards,
                 Serge Kolotylo.

On Wed, Mar 2, 2016 at 11:01 PM, sergk sergk2mail <sergk.admin@gmail.com> wrote:
> "find this hard to believe. If you inspect /proc/bus/input/devices you
> should be able to see the parent device for the touchscreen (via sysfs
> entry) and if you inspect sysfs you should be able to see the driver
> that is connected to the device (unless they use i2c dev from userspace
> but then they'd have to resort to polling and their battery life would
> be abysmal)"
>
> Yep me too, but : as a wrote before - it is so:
>
> cat /proc/bus/input/devices:
>
> I: Bus=0000 Vendor=0000 Product=0000 Version=0000  - so nothing!
> N: Name="chipone-ts"
> P: Phys=
> S: Sysfs=/devices/virtual/input/input3 ---- this one I have described
> before with modalias!
> U: Uniq=
> H: Handlers=kbd event3
> B: Prop=2
> B: EV=b
> B: KEY=2000000 0 40000800 40 0 0 0
> B: ABS=2658000 0
>
> Regards,
>                    Serge Kolotylo.
>
>
> On Wed, Mar 2, 2016 at 9:19 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Wed, Mar 02, 2016 at 06:13:27PM +0000, sergk sergk2mail wrote:
>>> "Why do you think that mlsfw in modalias string has anything to do with
>>> loading firmware? I must have misunderstood your statement..."
>>>
>>> Hi Dmitriy,
>>>   Its rather guessing based on such disovering: On Chuwi Vi10 rev 11
>>> under Android the only touch related module that is loaded is
>>> atmel_mxt_ts while I exactly know (and have firmware too) that in this
>>> tablet there is Chipone icn8528.h.   (drivers from Windows + dmesg
>>> provs this).
>>> When you rmmod atmel_mxt_ts the touch still continues to work! I guess
>>> someone just used atmel_mxt_ts probably as prototype for detecting
>>> (wake uping) chip and loading its firmware and after - no need in any
>>> module. According specs of Chipone icn85xx it looks that it even has
>>> corresponding mode - to be initialized from firmware and work after
>>> with it. It looks weird, but this is the clevest explanation that I
>>> could provide - I never seen before such behaviour in Android when
>>> there is no dedicated driver for touch screen.
>>
>> I find this hard to believe. If you inspect /proc/bus/input/devices you
>> should be able to see the parent device for the touchscreen (via sysfs
>> entry) and if you inspect sysfs you should be able to see the driver
>> that is connected to the device (unless they use i2c dev from userspace
>> but then they'd have to resort to polling and their battery life would
>> be abysmal).
>>
>>>
>>> In anyway - this is only curiousity, the main goal is simple - to
>>> create a driver for icn85xx that wakeup it and loads firmware.
>>> I have specs, I have firmware, there is for arm open source drivers
>>> (including firmware in .h file):
>>> https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c
>>
>> Just so we are clear: the driver above is not an open source driver.
>> Even though it has MODULE_LICENSE("GPL") to circumvent kernel module
>> loading policies the actual copyright notice in the sources say that the
>> code is proprietary.
>>
>> If any code is taken from it the resulting driver should not be
>> submitted for inclusion in mainline Linux kernel unless it is done by
>> ChipOne themselves.
>>
>> Thanks.
>>
>> --
>> Dmitry
