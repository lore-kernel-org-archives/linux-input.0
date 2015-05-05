From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 5 May 2015 23:16:40 +0200
Message-ID: <20150505211640.GA10272@amd>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
 <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57011 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161035AbbEEVQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 17:16:43 -0400
Content-Disposition: inline
In-Reply-To: <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi!

> Add a fixed-up HID descriptor for the Sony motion controller and enable
> controls for the LED light as well as force-feedback.
> 
> The LED is multi-colored (red, green, blue) and has a 'global' control to
> allow it to be flashed or switched on an off atomically.
> 
> The motion controller has a single rumble motor so the higher of the left and
> right values is used to set the speed.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
>  Pavel, can you please test this and make sure it works?  

I tried (on 4.1-rc2), and got this (full dmesg in attachment)

Best regards,
										Pavel


[ 1036.146757] perf interrupt took too long (2508 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
[12720.492126] usb 4-1: new full-speed USB device number 2 using uhci_hcd
[12720.659184] usb 4-1: New USB device found, idVendor=054c, idProduct=03d5
[12720.659194] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[12720.659199] usb 4-1: Product: Motion Controller
[12720.659205] usb 4-1: Manufacturer: Sony Computer Entertainment
[12739.603968] input: Sony Computer Entertainment Motion Controller as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/0003:054C:03D5.0001/input/input9
[12739.605801] sony 0003:054C:03D5.0001: input,hidraw0: USB HID v1.10 Joystick [Sony Computer Entertainment Motion Controller] on usb-0000:00:1d.2-1/input0
[12739.605810] sony 0003:054C:03D5.0001: failed to allocate the output report buffer
[12739.605814] ------------[ cut here ]------------
[12739.605827] WARNING: CPU: 1 PID: 10116 at lib/idr.c:1051 ida_remove+0xc7/0x100()
[12739.605830] ida_remove called for id=0 which is not allocated.
[12739.605832] Modules linked in: hid_sony(+)
[12739.605841] CPU: 1 PID: 10116 Comm: insmod Tainted: G        W       4.1.0-rc2+ #71
[12739.605844] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
[12739.605848]  00000001 00000000 c1051c70 c489988f c1051c9c c1051c8c c403da7b 0000041b
[12739.605861]  c42be347 00000000 00000000 f85b20c0 c1051ca4 c403dad6 00000009 c1051c9c
[12739.605873]  c4b040dc c1051cb8 c1051cd0 c42be347 c4b04063 0000041b c4b040dc 00000000
[12739.605885] Call Trace:
[12739.605892]  [<c489988f>] dump_stack+0x41/0x52
[12739.605900]  [<c403da7b>] warn_slowpath_common+0x6b/0xa0
[12739.605905]  [<c42be347>] ? ida_remove+0xc7/0x100
[12739.605909]  [<c403dad6>] warn_slowpath_fmt+0x26/0x30
[12739.605914]  [<c42be347>] ida_remove+0xc7/0x100
[12739.605918]  [<c42becf3>] ida_simple_remove+0x23/0x40
[12739.605926]  [<f85b00ea>] sony_probe+0x45a/0xdc0 [hid_sony]
[12739.605933]  [<c4645668>] ? hid_match_device+0x68/0x80
[12739.605938]  [<c4645676>] ? hid_match_device+0x76/0x80
[12739.605944]  [<f85afc90>] ? sony_led_set_brightness+0xb0/0xb0 [hid_sony]
[12739.605948]  [<c464572b>] hid_device_probe+0xab/0x120
[12739.605954]  [<c44610de>] driver_probe_device+0x11e/0x400
[12739.605958]  [<c4645676>] ? hid_match_device+0x76/0x80
[12739.605962]  [<c4461479>] __driver_attach+0x79/0x80
[12739.605966]  [<c4461479>] ? __driver_attach+0x79/0x80
[12739.605970]  [<c4461400>] ? __device_attach+0x40/0x40
[12739.605975]  [<c445f4ff>] bus_for_each_dev+0x4f/0x80
[12739.605980]  [<c4460b44>] driver_attach+0x14/0x20
[12739.605983]  [<c4461400>] ? __device_attach+0x40/0x40
[12739.605987]  [<c44607bf>] bus_add_driver+0x14f/0x220
[12739.605991]  [<c42bf9dd>] ? kset_find_obj+0x4d/0xa0
[12739.605995]  [<c44619e1>] driver_register+0x51/0xd0
[12739.605998]  [<f85bd000>] ? 0xf85bd000
[12739.606002]  [<c44619e1>] ? driver_register+0x51/0xd0
[12739.606006]  [<c46433fe>] __hid_register_driver+0x3e/0x80
[12739.606012]  [<f85bd037>] sony_init+0x37/0x1000 [hid_sony]
[12739.606017]  [<c4000442>] do_one_initcall+0xc2/0x1c0
[12739.606024]  [<c40f948f>] ? cache_free_debugcheck+0xff/0x340
[12739.606029]  [<c40f8609>] ? cache_alloc_debugcheck_after.isra.62+0x59/0x270
[12739.606035]  [<c4898eaf>] ? do_init_module+0x17/0x190
[12739.606039]  [<c4898eaf>] ? do_init_module+0x17/0x190
[12739.606044]  [<c4898ede>] do_init_module+0x46/0x190
[12739.606048]  [<c4898ede>] ? do_init_module+0x46/0x190
[12739.606055]  [<c40ac9b3>] load_module+0x1813/0x1f30
[12739.606060]  [<c40ad276>] SyS_finit_module+0x86/0xb0
[12739.606065]  [<c40ad276>] ? SyS_finit_module+0x86/0xb0
[12739.606071]  [<c4076f76>] ? up_write+0x16/0x40
[12739.606077]  [<c48a205e>] syscall_call+0x7/0x7
[12739.606081]  [<c48a205e>] ? syscall_call+0x7/0x7
[12739.606084] ---[ end trace ea8932ed620e4999 ]---
[12739.637922] sony: probe of 0003:054C:03D5.0001 failed with error -12



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
