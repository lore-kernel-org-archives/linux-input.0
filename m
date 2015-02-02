From: Sebastien Bourdeauducq <sb@m-labs.hk>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Mon, 02 Feb 2015 21:19:51 +0800
Message-ID: <54CF7977.1090105@m-labs.hk>
References: <54CCEE3D.9040306@m-labs.hk> <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com> <54CD9D0D.20402@m-labs.hk> <20150202100031.GP22740@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040309040302020103080608"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:37685 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbbBBNUA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 08:20:00 -0500
In-Reply-To: <20150202100031.GP22740@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040309040302020103080608
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On Monday, February 02, 2015 06:00 PM, Mika Westerberg wrote:
>> With this patch and IRQF_TRIGGER_LOW | IRQF_ONESHOT, I get an interrupt
>> flood and the kernel disables the interrupt line. I have reverted it to
>> IRQF_TRIGGER_FALLING | IRQF_ONESHOT, and the i2c_hid initialization
>> completes successfully.
>
> That shouldn't happen :-(

With this computer nothing is normal. Every single component except the 
CPU, display and USB has major issues under Linux.

> On all the panels I've tried, with or without GPIO, turning the
> interrupt to active low works. How about Windows, have you tried if it
> works there?

Yes, the Wacom digitizer works fine under Windows.

> Can you send output of /sys/kernel/debug/gpio when after the kernel has
> disabled the interrupt?

Attached. The kernel message I get is "byt_gpio INT33FC:00: Gpio 56 
interrupt flood, disabling".

I also get a "byt_gpio INT33FC:02: Gpio 18 interrupt flood, disabling" 
before which seems unrelated.

Sebastien


--------------040309040302020103080608
Content-Type: text/plain; charset=UTF-8;
 name="gpio.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gpio.txt"

GPIOs 338-381, platform/INT33FC:02, INT33FC:02:
 gpio-0   (Unrequested         ) in     lo pad-29  offset:0x1d0 mux:0       rise level down 20k
 gpio-1   (Unrequested         ) in     hi pad-33  offset:0x210 mux:0  fall      level up   20k
 gpio-2   (Unrequested         ) in     hi pad-30  offset:0x1e0 mux:0                  up   20k
 gpio-3   (Unrequested         ) in     hi pad-31  offset:0x1f0 mux:0  fall      level up   20k
 gpio-4   (Unrequested         ) in     lo pad-32  offset:0x200 mux:0       rise       down 20k
 gpio-5   (Unrequested         ) in     lo pad-34  offset:0x220 mux:1                  down 20k
 gpio-6   (Unrequested         )    out lo pad-36  offset:0x240 mux:0                           
 gpio-7   (Unrequested         ) in     lo pad-35  offset:0x230 mux:1                  down 20k
 gpio-8   (Unrequested         ) in     lo pad-38  offset:0x260 mux:0       rise level down 20k
 gpio-9   (ACPI:Event          ) in     hi pad-37  offset:0x250 mux:0  fall rise       up   20k
 gpio-10  (Unrequested         )    out lo pad-18  offset:0x120 mux:0                           
 gpio-11  (Unrequested         ) in     lo pad-7   offset:0x070 mux:0                  down 20k
 gpio-12  (Unrequested         ) in     hi pad-11  offset:0x0b0 mux:1  fall      level          
 gpio-13  (Unrequested         ) in     hi pad-20  offset:0x140 mux:0                  down 20k
 gpio-14  (ACPI:Event          ) in     hi pad-17  offset:0x110 mux:1  fall rise       up   20k
 gpio-15  (Unrequested         ) in     lo pad-1   offset:0x010 mux:1       rise level          
 gpio-16  (Unrequested         ) in     hi pad-8   offset:0x080 mux:1  fall rise                
 gpio-17  (Unrequested         ) in     hi pad-10  offset:0x0a0 mux:1  fall      level up   20k
 gpio-18  (ACPI:Event          ) in     lo pad-19  offset:0x130 mux:1                  up   20k
 gpio-19  (Unrequested         ) in     hi pad-12  offset:0x0c0 mux:0                  up   20k
 gpio-20  (ACPI:OpRegion       ) in out hi pad-0   offset:0x000 mux:1                           
 gpio-21  (Unrequested         ) in out hi pad-2   offset:0x020 mux:1                           
 gpio-22  (ACPI:OpRegion       ) in out hi pad-23  offset:0x170 mux:0                           
 gpio-23  (Unrequested         )        lo pad-39  offset:0x270 mux:0                           
 gpio-24  (Unrequested         )        lo pad-28  offset:0x1c0 mux:0                           
 gpio-25  (Unrequested         )        lo pad-27  offset:0x1b0 mux:0                           
 gpio-26  (Unrequested         )        lo pad-22  offset:0x160 mux:0                           
 gpio-27  (Unrequested         ) in     hi pad-21  offset:0x150 mux:0  fall rise       up   20k
 gpio-28  (Unrequested         ) in     hi pad-24  offset:0x180 mux:0  fall rise       up   20k
 gpio-29  (Unrequested         ) in out hi pad-25  offset:0x190 mux:0                           
 gpio-30  (Unrequested         ) in out hi pad-26  offset:0x1a0 mux:0                           
 gpio-31  (Unrequested         ) in     lo pad-51  offset:0x330 mux:1                  down 20k
 gpio-32  (Unrequested         ) in     lo pad-56  offset:0x380 mux:1                  down 20k
 gpio-33  (Unrequested         ) in     lo pad-54  offset:0x360 mux:1                  down 20k
 gpio-34  (Unrequested         ) in     lo pad-49  offset:0x310 mux:1                  down 20k
 gpio-35  (Unrequested         ) in     lo pad-55  offset:0x370 mux:1                  down 20k
 gpio-36  (Unrequested         ) in     lo pad-48  offset:0x300 mux:1                  down 20k
 gpio-37  (Unrequested         ) in     lo pad-57  offset:0x390 mux:1                  down 20k
 gpio-38  (Unrequested         ) in     lo pad-50  offset:0x320 mux:1                  down 20k
 gpio-39  (Unrequested         ) in     lo pad-58  offset:0x3a0 mux:1                  down 20k
 gpio-40  (Unrequested         ) in     lo pad-52  offset:0x340 mux:1                  up   20k
 gpio-41  (Unrequested         ) in     lo pad-53  offset:0x350 mux:1                  down 20k
 gpio-42  (Unrequested         ) in     lo pad-59  offset:0x3b0 mux:1                  up   20k
 gpio-43  (Unrequested         ) in     lo pad-40  offset:0x280 mux:1                  down 20k

GPIOs 382-409, platform/INT33FC:01, INT33FC:01:
 gpio-0   (Unrequested         ) in     lo pad-19  offset:0x130 mux:2                           
 gpio-1   (Unrequested         ) in     lo pad-18  offset:0x120 mux:2                           
 gpio-2   (Unrequested         ) in     lo pad-17  offset:0x110 mux:2                           
 gpio-3   (Unrequested         )        lo pad-20  offset:0x140 mux:2                           
 gpio-4   (Unrequested         )        lo pad-21  offset:0x150 mux:2                           
 gpio-5   (Unrequested         )        lo pad-22  offset:0x160 mux:2                           
 gpio-6   (Unrequested         ) in     lo pad-24  offset:0x180 mux:2                  up   20k
 gpio-7   (Unrequested         ) in     lo pad-25  offset:0x190 mux:2                           
 gpio-8   (Unrequested         )        lo pad-23  offset:0x170 mux:0                           
 gpio-9   (Unrequested         ) in     lo pad-16  offset:0x100 mux:2                  down 20k
 gpio-10  (Unrequested         ) in     lo pad-14  offset:0x0e0 mux:2                  down 20k
 gpio-11  (Unrequested         ) in     lo pad-15  offset:0x0f0 mux:2                  down 20k
 gpio-12  (Unrequested         )        lo pad-12  offset:0x0c0 mux:0                           
 gpio-13  (Unrequested         )        lo pad-26  offset:0x1a0 mux:1                           
 gpio-14  (Unrequested         )        lo pad-27  offset:0x1b0 mux:1                           
 gpio-15  (Unrequested         )        lo pad-1   offset:0x010 mux:0                           
 gpio-16  (Unrequested         ) in out lo pad-4   offset:0x040 mux:0                           
 gpio-17  (Unrequested         )        lo pad-8   offset:0x080 mux:0                           
 gpio-18  (Unrequested         )        lo pad-11  offset:0x0b0 mux:0                           
 gpio-19  (Unrequested         ) in out lo pad-0   offset:0x000 mux:0                           
 gpio-20  (Unrequested         ) in out lo pad-3   offset:0x030 mux:0                           
 gpio-21  (Unrequested         )        lo pad-6   offset:0x060 mux:0                           
 gpio-22  (Unrequested         ) in out lo pad-10  offset:0x0a0 mux:0                           
 gpio-23  (Unrequested         )        lo pad-13  offset:0x0d0 mux:0                           
 gpio-24  (Unrequested         ) in out lo pad-2   offset:0x020 mux:0                           
 gpio-25  (Unrequested         ) in out lo pad-5   offset:0x050 mux:0                           
 gpio-26  (Unrequested         )        lo pad-9   offset:0x090 mux:0                           
 gpio-27  (Unrequested         )        lo pad-7   offset:0x070 mux:0                  down 20k
GPIOs 410-511, platform/INT33FC:00, INT33FC:00:
 gpio-0   (Unrequested         )        lo pad-85  offset:0x550 mux:0                           
 gpio-1   (reset               ) in out hi pad-89  offset:0x590 mux:0                           
 gpio-2   (Unrequested         ) in     hi pad-93  offset:0x5d0 mux:0  fall rise       up   20k
 gpio-3   (Unrequested         )    out lo pad-96  offset:0x600 mux:0                           
 gpio-4   (Unrequested         ) in     hi pad-99  offset:0x630 mux:0  fall rise       up   20k
 gpio-5   (Unrequested         ) in     hi pad-102 offset:0x660 mux:0  fall rise       up   20k
 gpio-6   (Unrequested         ) in     hi pad-98  offset:0x620 mux:0  fall rise       up   20k
 gpio-7   (Unrequested         ) in     hi pad-101 offset:0x650 mux:2                  up   20k
 gpio-8   (Unrequested         ) in     hi pad-34  offset:0x220 mux:1                  down 20k
 gpio-9   (Unrequested         ) in     lo pad-37  offset:0x250 mux:1                  down 20k
 gpio-10  (Unrequested         ) in out lo pad-36  offset:0x240 mux:0                           
 gpio-11  (Unrequested         ) in     lo pad-38  offset:0x260 mux:1                  down 20k
 gpio-12  (Unrequested         ) in     lo pad-39  offset:0x270 mux:1                  down 20k
 gpio-13  (Unrequested         ) in     lo pad-35  offset:0x230 mux:1                  down 20k
 gpio-14  (Unrequested         ) in     hi pad-40  offset:0x280 mux:1                  down 20k
 gpio-15  (Unrequested         ) in     hi pad-84  offset:0x540 mux:1                  down 20k
 gpio-16  (Unrequested         ) in     lo pad-62  offset:0x3e0 mux:3                  down 20k
 gpio-17  (Unrequested         ) in     lo pad-61  offset:0x3d0 mux:3                  up   20k
 gpio-18  (Unrequested         ) in     lo pad-64  offset:0x400 mux:3                  up   20k
 gpio-19  (Unrequested         ) in     lo pad-59  offset:0x3b0 mux:3                  up   20k
 gpio-20  (Unrequested         ) in     hi pad-54  offset:0x360 mux:3                  up   20k
 gpio-21  (Unrequested         ) in     lo pad-56  offset:0x380 mux:3                  up   20k
 gpio-22  (Unrequested         ) in     lo pad-60  offset:0x3c0 mux:3                  up   20k
 gpio-23  (Unrequested         ) in     lo pad-55  offset:0x370 mux:3                  up   20k
 gpio-24  (Unrequested         ) in     lo pad-63  offset:0x3f0 mux:3                  up   20k
 gpio-25  (Unrequested         ) in     lo pad-57  offset:0x390 mux:3                  up   20k
 gpio-26  (Unrequested         ) in     hi pad-51  offset:0x330 mux:3                  down 20k
 gpio-27  (Unrequested         ) in     lo pad-50  offset:0x320 mux:1                  down 20k
 gpio-28  (Unrequested         ) in     lo pad-53  offset:0x350 mux:1                  up   20k
 gpio-29  (Unrequested         ) in     lo pad-47  offset:0x2f0 mux:1                  up   20k
 gpio-30  (Unrequested         ) in     lo pad-52  offset:0x340 mux:1                  up   20k
 gpio-31  (Unrequested         ) in     hi pad-49  offset:0x310 mux:1                  up   20k
 gpio-32  (Unrequested         ) in     lo pad-48  offset:0x300 mux:1                  up   20k
 gpio-33  (Unrequested         ) in     lo pad-43  offset:0x2b0 mux:1                  down 20k
 gpio-34  (Unrequested         ) in     lo pad-46  offset:0x2e0 mux:1                  up   20k
 gpio-35  (Unrequested         ) in     lo pad-41  offset:0x290 mux:1                  up   20k
 gpio-36  (Unrequested         ) in     lo pad-45  offset:0x2d0 mux:1                  up   20k
 gpio-37  (Unrequested         ) in     lo pad-42  offset:0x2a0 mux:1                  up   20k
 gpio-38  (80860F14:01 cd      ) in     hi pad-58  offset:0x3a0 mux:0  fall rise                
 gpio-39  (Unrequested         ) in     lo pad-44  offset:0x2c0 mux:1                  up   20k
 gpio-40  (Unrequested         ) in     lo pad-95  offset:0x5f0 mux:1                  down 20k
 gpio-41  (Unrequested         ) in     hi pad-105 offset:0x690 mux:1                  up   20k
 gpio-42  (Unrequested         ) in     hi pad-70  offset:0x460 mux:0                  up   20k
 gpio-43  (Unrequested         ) in     hi pad-68  offset:0x440 mux:0                  up   20k
 gpio-44  (Unrequested         ) in     hi pad-67  offset:0x430 mux:0                  up   20k
 gpio-45  (Unrequested         ) in     hi pad-66  offset:0x420 mux:0                  up   20k
 gpio-46  (Unrequested         ) in     hi pad-69  offset:0x450 mux:0                  up   20k
 gpio-47  (Unrequested         ) in     hi pad-71  offset:0x470 mux:0                  up   20k
 gpio-48  (Unrequested         ) in     hi pad-65  offset:0x410 mux:0                  up   20k
 gpio-49  (Unrequested         ) in     hi pad-72  offset:0x480 mux:0                  up   20k
 gpio-50  (Unrequested         ) in     hi pad-86  offset:0x560 mux:0                  up   20k
 gpio-51  (Unrequested         ) in out hi pad-90  offset:0x5a0 mux:0                           
 gpio-52  (Unrequested         ) in out lo pad-88  offset:0x580 mux:0                           
 gpio-53  (Unrequested         )    out lo pad-92  offset:0x5c0 mux:0                           
 gpio-54  (Unrequested         ) in out hi pad-103 offset:0x670 mux:0                           
 gpio-55  (Unrequested         )    out lo pad-77  offset:0x4d0 mux:0                           
 gpio-56  (?                   ) in     lo pad-79  offset:0x4f0 mux:0                  up   20k
 gpio-57  (Unrequested         ) in     lo pad-83  offset:0x530 mux:1                  up   20k
 gpio-58  (Unrequested         ) in out lo pad-78  offset:0x4e0 mux:0                           
 gpio-59  (ACPI:OpRegion       ) in out lo pad-81  offset:0x510 mux:0                           
 gpio-60  (ACPI:OpRegion       ) in out hi pad-80  offset:0x500 mux:0                           
 gpio-61  (Unrequested         ) in     lo pad-82  offset:0x520 mux:1                  down 20k
 gpio-62  (Unrequested         ) in     lo pad-13  offset:0x0d0 mux:1                  down 20k
 gpio-63  (Unrequested         ) in     lo pad-12  offset:0x0c0 mux:1                  down 20k
 gpio-64  (Unrequested         ) in     lo pad-15  offset:0x0f0 mux:1                  down 20k
 gpio-65  (Unrequested         ) in     lo pad-14  offset:0x0e0 mux:1                  down 20k
 gpio-66  (Unrequested         ) in     hi pad-17  offset:0x110 mux:1                  up   20k
 gpio-67  (Unrequested         ) in     lo pad-18  offset:0x120 mux:1                  up   20k
 gpio-68  (Unrequested         ) in     lo pad-19  offset:0x130 mux:1                  up   20k
 gpio-69  (Unrequested         ) in     lo pad-16  offset:0x100 mux:1                  down 20k
 gpio-70  (Unrequested         ) in     lo pad-2   offset:0x020 mux:1                  up   20k
 gpio-71  (Unrequested         ) in     lo pad-1   offset:0x010 mux:1                  up   20k
 gpio-72  (Unrequested         ) in     hi pad-0   offset:0x000 mux:1                  up   20k
 gpio-73  (Unrequested         ) in     hi pad-4   offset:0x040 mux:1                           
 gpio-74  (Unrequested         ) in     lo pad-6   offset:0x060 mux:1                  up   20k
 gpio-75  (Unrequested         ) in     lo pad-7   offset:0x070 mux:1                  up   20k
 gpio-76  (Unrequested         ) in     hi pad-9   offset:0x090 mux:1                  up   20k
 gpio-77  (Unrequested         ) in     hi pad-8   offset:0x080 mux:1                           
 gpio-78  (Unrequested         ) in     lo pad-33  offset:0x210 mux:1                  up   2k 
 gpio-79  (Unrequested         ) in     lo pad-32  offset:0x200 mux:1                  up   2k 
 gpio-80  (Unrequested         ) in     lo pad-31  offset:0x1f0 mux:1                  up   2k 
 gpio-81  (Unrequested         ) in     lo pad-30  offset:0x1e0 mux:1                  up   2k 
 gpio-82  (Unrequested         ) in     lo pad-29  offset:0x1d0 mux:1                  up   2k 
 gpio-83  (Unrequested         ) in     lo pad-27  offset:0x1b0 mux:1                  up   2k 
 gpio-84  (Unrequested         ) in     lo pad-25  offset:0x190 mux:1                  up   2k 
 gpio-85  (Unrequested         ) in     lo pad-28  offset:0x1c0 mux:1                  up   2k 
 gpio-86  (Unrequested         ) in     lo pad-26  offset:0x1a0 mux:1                  up   2k 
 gpio-87  (Unrequested         ) in     lo pad-23  offset:0x170 mux:1                  up   2k 
 gpio-88  (Unrequested         ) in     lo pad-21  offset:0x150 mux:1                  up   2k 
 gpio-89  (Unrequested         ) in     lo pad-20  offset:0x140 mux:1                  up   2k 
 gpio-90  (Unrequested         ) in     lo pad-24  offset:0x180 mux:1                  up   2k 
 gpio-91  (Unrequested         ) in     lo pad-22  offset:0x160 mux:1                  up   2k 
 gpio-92  (Unrequested         ) in     lo pad-5   offset:0x050 mux:0                  up   2k 
 gpio-93  (Unrequested         ) in     lo pad-3   offset:0x030 mux:0                  up   2k 
 gpio-94  (ACPI:Event          ) in     hi pad-10  offset:0x0a0 mux:0  fall rise       down 20k
 gpio-95  (Unrequested         ) in out hi pad-11  offset:0x0b0 mux:0                           
 gpio-96  (Unrequested         ) in     lo pad-106 offset:0x6a0 mux:1                  down 20k
 gpio-97  (Unrequested         ) in     lo pad-87  offset:0x570 mux:1                  down 20k
 gpio-98  (Unrequested         )        lo pad-91  offset:0x5b0 mux:0                           
 gpio-99  (Unrequested         ) in     lo pad-104 offset:0x680 mux:1                  down 20k
 gpio-100 (Unrequested         )        lo pad-97  offset:0x610 mux:0                           
 gpio-101 (Unrequested         )        lo pad-100 offset:0x640 mux:0                           

--------------040309040302020103080608--
