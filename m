From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 17:49:32 +0100
Message-ID: <56D7199C.8040808@gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
 <56D61E05.3060407@gmail.com>
 <CA+V1Lzr09-GU8yS9RHU=qO=200DiCTCXEqc3zP0953uLOWaoKQ@mail.gmail.com>
 <56D6E5A0.9080509@gmail.com>
 <CA+V1LzoZ9DEJsqKNggQHQ9B_tW8ZPMMuydsBma_jDdsKEJ6G0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38238 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbcCBQtf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 11:49:35 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so86301612wml.1
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 08:49:34 -0800 (PST)
In-Reply-To: <CA+V1LzoZ9DEJsqKNggQHQ9B_tW8ZPMMuydsBma_jDdsKEJ6G0Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org


> Probably I know the reason of this - I have taken chuwi vi8 with
> gsl1680, after modprobe i2c-dev, i2cdetect -r 3  - detects gsl1680 on
> 0x40 PERMANENTLY! In Android touch is on i2c-4, but on the same
> address.

The differing bus assignment by be caused by slightly different loading order
or DeviceTree or platform driver configurations.

> AFAIK - i2c devices could switch bus number but not their port on bus,
> this means that if you have chipone icn85xx it should answer on 0x48
> on one of the i2c bus.
> Am I right?

Yes, the device address is normally hardcoded into the device itself.
So, unless there is an internal register or a chip pin to change, it will
always be the same.
And since I2C addressing is standardised, the physical and logical addresses
are identical.

As mentioned above, the logical I2C bus number may change depending on certain
factors. The physical bus pins are still the same though.

> In case of Chuwi Vi10 with Chipone icn8528 situation with i2cdetect is
> very very strange.
> On kernels 4.4.2 and 4.0.1 - modprobe i2c-dev and then i2cdetect -r X
> (1,2,3,4) does NOT!!!!!!!! Detect NOTHING permanently on 0x48 on any
> bus!
> This make me confused completely! To wake up something it should be
> visible on i2c bus but it is NOT!

It's possible that the device simply doesn't answer until the wakeup pin has
turned it on. In the case of the Silead chips, I think they are already turned
on at system boot and stay on until they are shut down via PM commands.

So you definitely need to configure the GPIO pin, send the wakeup sequence,
and then you should be able to communicate with the chip.

