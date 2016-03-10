From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Thu, 10 Mar 2016 22:59:24 +0100
Message-ID: <56E1EE3C.6010007@gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35970 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbcCJV71 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 16:59:27 -0500
Received: by mail-wm0-f53.google.com with SMTP id n186so5479784wmn.1
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2016 13:59:26 -0800 (PST)
In-Reply-To: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org

>  1) It is strange, but it looks that via Vanilla custom x8_64 Linux
> 4.4.2 ArchLinux   Baytrail on Chuwi Vi10 the Touchscreen Control Chip
> probably resides not on 0x48  and it is resides on i2c-3 0x30. This
> confused me completely, AFAIK chip could switch buses but not its
> address.
> Will be happy if anyone helps with this - whether it is possible for
> chip to be i2c-4, 0x48 on Android and switched in Linux to i2c-3 0x30?

The way I2C works, this is simply not possible unless the chip is reconfigured
somehow. I2C frames always start with the device address, and if a chip isn't
listening for a specific address (or a broadcast), it will not respond.

The I2C bus number in user space on the other hand is completely dynamic and
depends on the driver load order.

So in short, without any separate "switching" mechanism (highly unlikely), the
device will always have the same address (0x30 is 48 in decimal, mind you),
but it may live on i2c-0, i2c-1, i2c-2, i2c-3, i2c-4, i2c-5 depending on when
the bus is initialised or which drivers are loaded.

> Also my discovering:
> 1.1)  On Chuwi Vi8 for gsl1680 it was only such Android: i2c-4, 0x40
> and in Linux: i2c-3, 0x40 - only bus! But not address switching!

Are you sure this is the TS controller and not a different device?

> 2) I have not got positive results with my code - and still under
> guessing whether I am not successful in waking up the chip or
> something other wrong. :( I could not even read correct Chip version
> in checking whether hw initialized correct.

Perhaps there's more initialisation needed. Have a look at the _PS0/_PS3
methods in the DSDT. Those are usually meant for automatic power management
when the system exits/enters standby.
Perhaps the icn85 is still in sleep mode?

> It is sad but Linux in contrast to Android has a lack of drivers for
> touchscreen and many other hw of the tablets and this is to my mind is
> very strange and reminding early times of 2.xx kernel. ;-) I am trying
> to join and change this situation!

That is sad indeed. There wasn't much support for touchscreens in Linux before
tablets became so widespread, and most manufacturers just cared about "getting
things working". Many Android drivers out in the wild don't even use
DeviceTree for hardware configuration, instead relying on proprietary blobs or
hardcoded data in the driver code. Messed up ACPI tables aren't improving the
situation either.

Thanks to the effort of the fine people here on linux-input however, the
situation is getting better. :)
But it will take time.


