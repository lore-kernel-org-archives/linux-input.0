From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Wed, 30 Mar 2016 10:28:14 +0000
Message-ID: <CA+V1Lzpkpy4i-t-=C8nSK0T_3cP56CXd0ACmLso-3JbgC0Pt-Q@mail.gmail.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
	<56EF459E.8000808@gmail.com>
	<CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
	<20160329095244.GI2099@lahna.fi.intel.com>
	<CA+V1LzqzMyxoAQv=DDFvWr_MOTThVnhJwTt8uS_piwVhGJtWgQ@mail.gmail.com>
	<20160329125642.GM2099@lahna.fi.intel.com>
	<CA+V1Lzov4WXXjERAwAV03VdMEQKDC_=ADAgr2-0p-k=gYC8i3w@mail.gmail.com>
	<20160329133307.GO2099@lahna.fi.intel.com>
	<CA+V1LzqP+tzQ9b8=6xu9vjgYqM93zQXfJe5sUoYEArgzv+A5fw@mail.gmail.com>
	<20160330094159.GQ2099@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34952 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcC3K2P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2016 06:28:15 -0400
Received: by mail-qk0-f175.google.com with SMTP id o6so17366202qkc.2
        for <linux-input@vger.kernel.org>; Wed, 30 Mar 2016 03:28:15 -0700 (PDT)
In-Reply-To: <20160330094159.GQ2099@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, Gregor Riepl <onitake@gmail.com>

Hi Mika,

"This should create new i2c device for i2c-hid.c."
Ok - provided code registered platform device, looks like hid device
and what will be next then? where and how will be setuped irq mode for
touchscreen? the problem was from the begining - I could not setup irq
for this touch due absence of gpio or the way of puting it into irq
mode.

Kind regards,
                     Serge Kolotylo.


On Wed, Mar 30, 2016 at 9:41 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Mar 30, 2016 at 12:03:13AM +0000, sergk sergk2mail wrote:
>> Hi Mika,
>>  full acpidump of the machine is located here
>> https://gitlab.com/SergK/icn8528/blob/master/DSDT/dsdt.dsl
>
> OK, so there is only one touchscreen device and it has _STA method
> looking like this:
>
>         Method (_STA, 0, NotSerialized)  // _STA: Status
>         {
>                 If ((OSSL & 0x80))
>                 {
>                         Return (Zero)
>                 }
>
> My guess is that that OSSL variable tells if the machine is in Android
> or Windows mode or something like that. In your case it returns zero
> here.
>
>> >From Android:
>> "What does 'ls -l /sys/bus/i2c/devices' show under android?"
>> 1) sysi2cdev  /sys/bus/i2c/devices
>> https://gitlab.com/SergK/icn8528/blob/master/Androiddata/sysi2cdev
>
> And this explains why Android works. It initializes the I2C devices
> directly from a board file.
>
> So what you are doing probably works but instead of hardcoding in the
> driver you can fill i2c_board_info from "platform specific" files like
> for example here:
>
>         arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
>
> Translating the _CRS from ACPI TCS5 device it might look like:
>
>         static const struct i2c_hid_platform_data pdata = {
>                 .hid_descriptor_address = 3, // from _DSM
>         };
>
>         static const struct i2c_board_info my_board_info[] = {
>                 {
>                         I2C_BOARD_INFO("hid", 0x30"),
>                         .irq = 0x44,
>                         .platform_data = &pdata,
>                 },
>         };
>
>         static int __init my_init(void)
>         {
>                 i2c_register_board_info(3, my_board_info, ARRAY_SIZE(my_board_info));
>         }
>         arch_initcall(my_init);
>
> This should create new i2c device for i2c-hid.c.
