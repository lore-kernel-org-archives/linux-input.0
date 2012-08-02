From: Fabio Estevam <festevam@gmail.com>
Subject: imx51 crashes at gpio_keys_probe
Date: Thu, 2 Aug 2012 19:49:32 -0300
Message-ID: <CAOMZO5D9CZ2=ON2zNxcMa+PW549NE12=aeS522cor67F8Soaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58972 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab2HBWtd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Aug 2012 18:49:33 -0400
Received: by obbuo13 with SMTP id uo13so93850obb.19
        for <linux-input@vger.kernel.org>; Thu, 02 Aug 2012 15:49:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, rob.herring@calxeda.com
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

Running today's linux-next on a imx51-babbage board I get the
following (with a dt kernel):

...
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 805 [#1] ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0-next-20120802+ #1366)
PC is at gpio_keys_probe+0x154/0x8c0
LR is at of_gpiochip_find_and_xlate+0x54/0x70
pc : [<803ddbac>]    lr : [<801ed2f4>]    psr: 60000013
sp : 9f851df8  ip : 00000002  fp : 9f851e5c
r10: 9f873d00  r9 : 00000001  r8 : 9fa2f900
r7 : 809c0920  r6 : 9f873d08  r5 : 00000000  r4 : 809c09d4
r3 : 805af10c  r2 : 000000c0  r1 : 9f851db4  r0 : 000000d5
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 90004019  DAC: 00000015
Process swapper (pid: 1, stack limit = 0x9f8502e8)
Stack: (0x9f851df8 to 0x9f852000)
1de0:                                                       809c0920 00000000
1e00: 9f851e1c 8055d780 81ff1ad0 0000000a 9f879180 00000000 9f873d08 9f873d10
1e20: 00000000 8055d6f8 8052173c 00000000 9f851e4c 805b4380 8055d6f8 9f873d08
1e40: 8055d6f8 8052173c 0000008b 00000000 9f851e6c 9f851e60 8022f32c 803dda64
1e60: 9f851e94 9f851e70 8022de48 8022f318 9f873d08 8055d6f8 9f873d3c 00000000
1e80: 8052173c 0000008b 9f851eb4 9f851e98 8022e060 8022ddd4 8055d6f8 9f851eb8
1ea0: 8022dfcc 00000000 9f851edc 9f851eb8 8022c790 8022dfd8 9f83234c 9f8776b0
1ec0: 8055d6f8 80557f58 9fa2f880 00000000 9f851eec 9f851ee0 8022dcac 8022c734
1ee0: 9f851f14 9f851ef0 8022cf6c 8022dc94 8049a254 9f851f00 8052d1e4 8055d6f8
1f00: 805668c0 00000008 9f851f3c 9f851f18 8022e698 8022cdf4 8052d1e4 805668c0
1f20: 805668c0 00000008 8052173c 0000008b 9f851f4c 9f851f40 8022f6d0 8022e624
1f40: 9f851f5c 9f851f50 80521750 8022f690 9f851fb4 9f851f60 80008608 80521748
1f60: 9f851fb4 9f851f70 80035ec8 8052173c 80503ea8 00000007 00000007 805035f8
1f80: 80495b48 60000013 9f851fb4 8052d1e4 80536c88 805668c0 00000008 80504214
1fa0: 0000008b 8052d1e8 9f851ff4 9f851fb8 80504380 800085d8 00000007 00000007
1fc0: 80504214 8050429c 8002171c 00000000 8050429c 8002171c 00000013 00000000
1fe0: 00000000 00000000 00000000 9f851ff8 8002171c 805042a8 00000000 00000000
Backtrace:
[<803dda58>] (gpio_keys_probe+0x0/0x8c0) from [<8022f32c>] (platform_drv_probe+)
[<8022f30c>] (platform_drv_probe+0x0/0x24) from [<8022de48>] (driver_probe_devi)
[<8022ddc8>] (driver_probe_device+0x0/0x204) from [<8022e060>] (__driver_attach)
 r9:0000008b r8:8052173c r7:00000000 r6:9f873d3c r5:8055d6f8
r4:9f873d08
[<8022dfcc>] (__driver_attach+0x0/0x98) from [<8022c790>] (bus_for_each_dev+0x6)
 r7:00000000 r6:8022dfcc r5:9f851eb8 r4:8055d6f8
[<8022c728>] (bus_for_each_dev+0x0/0x94) from [<8022dcac>] (driver_attach+0x24/)
 r7:00000000 r6:9fa2f880 r5:80557f58 r4:8055d6f8
[<8022dc88>] (driver_attach+0x0/0x28) from [<8022cf6c>] (bus_add_driver+0x184/0)
[<8022cde8>] (bus_add_driver+0x0/0x23c) from [<8022e698>] (driver_register+0x80)
 r7:00000008 r6:805668c0 r5:8055d6f8 r4:8052d1e4
[<8022e618>] (driver_register+0x0/0x148) from [<8022f6d0>] (platform_driver_reg)
 r9:0000008b r8:8052173c r7:00000008 r6:805668c0 r5:805668c0
r4:8052d1e4
[<8022f684>] (platform_driver_register+0x0/0x60) from [<80521750>] (gpio_keys_i)
[<8052173c>] (gpio_keys_init+0x0/0x1c) from [<80008608>] (do_one_initcall+0x3c/)
[<800085cc>] (do_one_initcall+0x0/0x190) from [<80504380>] (kernel_init+0xe4/0x)
[<8050429c>] (kernel_init+0x0/0x1b8) from [<8002171c>] (do_exit+0x0/0x6ec)
Code: e24b3030 e1a00004 e2899001 ebf83e54 (e5850004)
---[ end trace 243f51918d3c031e ]---
Kernel panic - not syncing: Attempted

Any ideas or any recent patch I am missing?

Regards,

Fabio Estevam
