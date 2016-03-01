From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Tue, 1 Mar 2016 11:02:47 +0100
Message-ID: <56D568C7.20203@gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34957 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcCAKCv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 05:02:51 -0500
Received: by mail-wm0-f53.google.com with SMTP id l68so28239777wml.0
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 02:02:51 -0800 (PST)
Received: from [172.28.172.2] ([213.55.176.237])
        by smtp.googlemail.com with ESMTPSA id ei9sm30209529wjd.40.2016.03.01.02.02.48
        for <linux-input@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 02:02:49 -0800 (PST)
In-Reply-To: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Serge,

> Howto use ACPI for touchscreen:
>
>   1) is it possible to detect via ACPI GPIO pin to INT/WAKE Touch?
>    2) If yes how to find out equivalent of this gpio pin in
> /sys/class/gpio? (to have userspace interface to it via export
> gpioPINNUMBER> /sys/class/gpio/export
> 3) From the bellow DSDT table touch is dependant from I2C5  while
> i2c-dev creates devices i2c-0...i2c-4. Does this mean that in ACPI
> base is 1 and I2C5 is identical to i2c-4 dev ?

In a kernel driver, you don't have to do all of this yourself, as the kernel
will take care of ACPI parsing and device configuration when you request it.

If your driver lives in user space, you need to do this mapping yourself.

This is all the relevant information:

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
>     

Device on I2C address 0x30 (with 7-bit addressing), on I2C controller I2C4
(not I2C5, I believe this dependency is a bug in the DSDT entry of many
touchscreen devices), speed 400kHz.
One IRQ line (pin number 0x44), high level triggered. This maps directly to
the physical pin on Baytrail AFAIK. I'm not sure how to access it from user
space. Perhaps GPIO works, and perhaps it's not needed at all if you do polling.
One output GPIO pin, number 0x1a on GPO1 with default pullup settings. This is
most likely the "wakeup" pin on the controller.

I don't quite remember how the GPIO pin mapping works on Baytrail. Usually,
each "chip" has a base pin number, and the pin number from the DSDT entry is
added to that. Maybe check all /sys/class/gpio/gpiochip*/label entries and see
if you can find GPO1? You can then map the logical pin number (base + 0x1a)
using /sys/class/gpio/export

