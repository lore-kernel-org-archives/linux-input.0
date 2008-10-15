From: Adrian Bunk <bunk@kernel.org>
Subject: usbhid_set_leds problems
Date: Wed, 15 Oct 2008 07:13:46 +0300
Message-ID: <20081015041346.GE4710@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:51894 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbYJOENr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 00:13:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

With CONFIG_USB_HID=n I'm getting the following build error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `bright_probe':
drivers/hid/hid-bright.c:38: undefined reference to `usbhid_set_leds'
drivers/hid/hid-bright.c:38: undefined reference to `usbhid_set_leds'
drivers/built-in.o: In function `dell_probe':
drivers/hid/hid-dell.c:41: undefined reference to `usbhid_set_leds'
drivers/hid/hid-dell.c:41: undefined reference to `usbhid_set_leds'
drivers/built-in.o: In function `lg_probe':
drivers/hid/hid-lg.c:252: undefined reference to `usbhid_set_leds'
drivers/hid/hid-lg.c:252: more undefined references to `usbhid_set_leds' follow
...
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


And I'm not sure commit 6edfa8dc33803a49ad936ead9840e453bee6ca3b
(HID: move reset leds quirk) was a good idea at all since I don't
see cases like HID_DELL=y, CONFIG_USB_HID=m could now work at all.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

