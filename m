From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Fri, 11 Mar 2016 11:40:01 -0800
Message-ID: <CAKdAkRQbHDehT0t2gDUkbOQNWKsY8O7iMi7cEAsN_N8=UBWZAQ@mail.gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
	<56E1EE3C.6010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34670 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbcCKTkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 14:40:03 -0500
Received: by mail-vk0-f43.google.com with SMTP id e185so146355019vkb.1
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2016 11:40:02 -0800 (PST)
In-Reply-To: <56E1EE3C.6010007@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: sergk sergk2mail <sergk.admin@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Mar 10, 2016 at 1:59 PM, Gregor Riepl <onitake@gmail.com> wrote:
>>  1) It is strange, but it looks that via Vanilla custom x8_64 Linux
>> 4.4.2 ArchLinux   Baytrail on Chuwi Vi10 the Touchscreen Control Chip
>> probably resides not on 0x48  and it is resides on i2c-3 0x30. This
>> confused me completely, AFAIK chip could switch buses but not its
>> address.
>> Will be happy if anyone helps with this - whether it is possible for
>> chip to be i2c-4, 0x48 on Android and switched in Linux to i2c-3 0x30?
>
> The way I2C works, this is simply not possible unless the chip is reconfigured
> somehow. I2C frames always start with the device address, and if a chip isn't
> listening for a specific address (or a broadcast), it will not respond.
>
> The I2C bus number in user space on the other hand is completely dynamic and
> depends on the driver load order.
>
> So in short, without any separate "switching" mechanism (highly unlikely), the
> device will always have the same address (0x30 is 48 in decimal, mind you),
> but it may live on i2c-0, i2c-1, i2c-2, i2c-3, i2c-4, i2c-5 depending on when
> the bus is initialised or which drivers are loaded.

Some devices do allow you to switch slave address, Goodix touchscreen
is one example.

Thanks.

-- 
Dmitry
