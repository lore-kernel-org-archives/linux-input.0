From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Tue, 1 Mar 2016 16:30:48 +0000
Message-ID: <CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34274 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcCAQau (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 11:30:50 -0500
Received: by mail-qg0-f46.google.com with SMTP id b67so146106169qgb.1
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 08:30:49 -0800 (PST)
In-Reply-To: <56D568C7.20203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor,

Thanks for joining!
Unfortunately DSDT was taken from my Chuwi Vi10 tablet rev 11 with
Chipone icn8528.h touch and information provided via ACPI looks like a
total false.
I have compared DSDTs on both Android and Linux 4.4.2  - they are lie
both and are the same.
Touch is located in Android on i2c-4, 0x48 (exactly as it is mentioned
in the specs I have sent to you).
In Android I am able to read via i2cget -f (force because is used by
ts driver in Adroid) 4 0x48 main registers of icn85xx, for example:
i2cget -f 4 0x048 0x000c FW version returns 0x38
i2cget -f 4 0x048 0x000a IcVersion main - returns 0x85 = 85xx family

The additional strange things are: in Android is loaded only
atmel_mxt_ts which even could be rmmod and touch still working! no
any other module relative to touch! Looks someone just modified
atmel_mxt_ts and used it as a stub for initializing chip, loads
firmware and switch to it = no need module.

In Bios for touch there is option I2c Touch address field with
Options: Auto/0x4a, 0x4b. By default is Auto.

This makes me completely crazy hot this all works together while wrong
DSDT ACPI, strange options in BIOS.
Actually Chuwi Vi10 has 11 revisions, so thats why possibly there are
rudiment settings not relative to actual HW that is used.

So, the question still interesting - I exactly know which touch I have
and on which i2c bus and address (based on Android and Windows working
on it) and we have wrong? DSDT - how to obtain something to wakeup the
chip!
According spec: there are 2 methods: INT/WAKE pin or something weird
for me - SCL SDA and delays between them as it is described in
ICNT88xx_Application note spec.
In userspace I have just done enumerating all via exporting and
probing: 391-392-393 - is TS relative (blank on/off) and by analogy
with Chuwi Vi8 my experience - 393 is the same gpio to wakeup TS on
Chuwi vi8.
Simpe set 0-1 of 393 pin doesnot make i2cdetect -r -y 4  permanently
something on 0x48 - it sometimes detects sometimes not and I am unable
to read via mentioned above i2cget -f 4 0x048 0x000a nothing.
So looks like chip is not wake uped.

Kind regards,
                       Serge Kolotylo.

On Tue, Mar 1, 2016 at 10:02 AM, Gregor Riepl <onitake@gmail.com> wrote:
> Hi Serge,
>
>> Howto use ACPI for touchscreen:
>>
>>   1) is it possible to detect via ACPI GPIO pin to INT/WAKE Touch?
>>    2) If yes how to find out equivalent of this gpio pin in
>> /sys/class/gpio? (to have userspace interface to it via export
>> gpioPINNUMBER> /sys/class/gpio/export
>> 3) From the bellow DSDT table touch is dependant from I2C5  while
>> i2c-dev creates devices i2c-0...i2c-4. Does this mean that in ACPI
>> base is 1 and I2C5 is identical to i2c-4 dev ?
>
> In a kernel driver, you don't have to do all of this yourself, as the kernel
> will take care of ACPI parsing and device configuration when you request it.
>
> If your driver lives in user space, you need to do this mapping yourself.
>
> This is all the relevant information:
>
>>                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
>>                             AddressingMode7Bit, "\\_SB.I2C4",
>>                             0x00, ResourceConsumer, ,
>>                             )
>>                         Interrupt (ResourceConsumer, Level,
>> ActiveHigh, Exclusive, ,, )
>>                         {
>>                             0x00000044,
>>                         }
>>                         GpioIo (Exclusive, PullDefault, 0x0000,
>> 0x0000, IoRestrictionOutputOnly,
>>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>>                             )
>>                             {   // Pin list
>>                                 0x001A
>>                             }
>>
>
> Device on I2C address 0x30 (with 7-bit addressing), on I2C controller I2C4
> (not I2C5, I believe this dependency is a bug in the DSDT entry of many
> touchscreen devices), speed 400kHz.
> One IRQ line (pin number 0x44), high level triggered. This maps directly to
> the physical pin on Baytrail AFAIK. I'm not sure how to access it from user
> space. Perhaps GPIO works, and perhaps it's not needed at all if you do polling.
> One output GPIO pin, number 0x1a on GPO1 with default pullup settings. This is
> most likely the "wakeup" pin on the controller.
>
> I don't quite remember how the GPIO pin mapping works on Baytrail. Usually,
> each "chip" has a base pin number, and the pin number from the DSDT entry is
> added to that. Maybe check all /sys/class/gpio/gpiochip*/label entries and see
> if you can find GPO1? You can then map the logical pin number (base + 0x1a)
> using /sys/class/gpio/export
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
