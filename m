From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Mon, 25 Jul 2016 12:16:21 +0200
Message-ID: <20160725101621.GJ19383@mail.corp.redhat.com>
References: <20160617211142.GH24234@mail.corp.redhat.com>
 <1466275994.2669.11.camel@gmail.com>
 <20160618194534.GI24234@mail.corp.redhat.com>
 <1466369282.15726.7.camel@gmail.com>
 <20160620095934.GN24234@mail.corp.redhat.com>
 <1466739490.3464.8.camel@gmail.com>
 <20160624071419.GO24234@mail.corp.redhat.com>
 <1466840940.28419.6.camel@gmail.com>
 <20160701145212.GA24234@mail.corp.redhat.com>
 <1469304819.3131.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbcGYKQ0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 06:16:26 -0400
Content-Disposition: inline
In-Reply-To: <1469304819.3131.4.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Jul 23 2016 or thereabouts, Dennis Chen wrote:
>=20
> On Fri, 2016-07-01 at 16:52 +0200, Benjamin Tissoires wrote:
> >=C2=A0
> > I spent a good amount of time trying to figure out where the bug wa=
s,
> > and I couldn't reproduce it either with uhid or even with usb_gadge=
t.
> > Even KASan doesn't gives any wrong memory access, and I can't
> > understand why you get this faulty behavior.
> >=20
> > So I must say, I am puzzled on why you end up calling
> > usbhid_init_reports() while the quirk HID_QUIRK_NO_INIT_REPORTS
> > should be in place.
> > Would you mind adding some printk() in hid-multitouch to dump the
> > value of hdev->quirks before and after calling hid_hw_start() in
> > mt_probe()?
> >=20
> > Also, ideally, if you could add a dump_stack() in
> > drivers/hid/usbhid/hid-core.c, right before leaving
> > usbhid_init_reports(), that would be awesome.
> >=20
>=20
> Here's a dmesg dump. It seems the quirks aren't cleared.

Thanks for the logs. They confirm the hid-core patch is not
interfering, but there is somethign weird:

>=20
> [    3.787730] Pre-hid_hw_start hdev->quirks: -2147483328

This should hopefully translate to 0x80000140 which means:
  HID_QUIRK_NO_INPUT_SYNC |=20
  HID_QUIRK_MULTI_INPUT |
  HID_QUIRK_NO_EMPTY_INPUT

The issue is that HID_QUIRK_NO_INIT_REPORTS is not set, and this should
be set by usbhid through the table hid_blacklist.
Did you also amend this table while applying the patches?

If not, I'd like to see the value of the quirks just at the beginning o=
f
mt_probe to understand where we clear the quirk.

Cheers,
Benjamin

> [    3.787731] clocksource: Switched to clocksource tsc
> [    4.217617] scsi 4:0:0:0: Direct-Access     Generic- USB3.0 CRW   =
-SD 1.00 PQ: 0 ANSI: 6
> [    4.218413] sd 4:0:0:0: Attached scsi generic sg2 type 0
> [    5.011924] Console: switching to colour frame buffer device 270x9=
0
> [    5.030415] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [    5.471214] sd 4:0:0:0: [sdc] 31116288 512-byte logical blocks: (1=
5.9 GB/14.8 GiB)
> [    5.474542] sd 4:0:0:0: [sdc] Write Protect is off
> [    5.474547] sd 4:0:0:0: [sdc] Mode Sense: 2f 00 00 00
> [    5.477097] sd 4:0:0:0: [sdc] Write cache: disabled, read cache: e=
nabled, doesn't support DPO or FUA
> [    5.492349]  sdc: sdc1
> [    5.494359] sd 4:0:0:0: [sdc] Attached SCSI removable disk
> [    7.817402] CPU: 3 PID: 338 Comm: systemd-udevd Not tainted 4.7.0-=
rc7+ #7
> [    7.817409] Hardware name: Microsoft Corporation Surface Pro 3/Sur=
face Pro 3, BIOS 3.11.0850 04/07/2015
> [    7.817413]  0000000000000286 000000007db35b48 ffff880145c839f8 ff=
ffffff813d618f
> [    7.817420]  0000000000000000 ffff880149404000 ffff880145c83a28 ff=
ffffff81688b7e
> [    7.817425]  ffff880145c68350 0000000000000002 ffff880149404000 ff=
ff88003fb5ad08
> [    7.817430] Call Trace:
> [    7.817443]  [<ffffffff813d618f>] dump_stack+0x63/0x84
> [    7.817453]  [<ffffffff81688b7e>] usbhid_init_reports+0xde/0x110
> [    7.817459]  [<ffffffff816890da>] usbhid_start+0x52a/0x770
> [    7.817465]  [<ffffffff81686fc0>] ? hid_retry_timeout+0x60/0x60
> [    7.817471]  [<ffffffff81686710>] ? usbhid_restart_out_queue+0x110=
/0x110
> [    7.817481]  [<ffffffffa00535f5>] mt_probe+0x1b5/0x263 [hid_multit=
ouch]
> [    7.817487]  [<ffffffff8167c707>] hid_device_probe+0xd7/0x150
> [    7.817492]  [<ffffffff8151cbac>] driver_probe_device+0x22c/0x440
> [    7.817496]  [<ffffffff8151ce91>] __driver_attach+0xd1/0xf0
> [    7.817500]  [<ffffffff8151cdc0>] ? driver_probe_device+0x440/0x44=
0
> [    7.817508]  [<ffffffff8151a4dc>] bus_for_each_dev+0x6c/0xc0
> [    7.817512]  [<ffffffff8151c29e>] driver_attach+0x1e/0x20
> [    7.817517]  [<ffffffff8151bce3>] bus_add_driver+0x1c3/0x280
> [    7.817522]  [<ffffffffa0011000>] ? 0xffffffffa0011000
> [    7.817526]  [<ffffffff8151d7e0>] driver_register+0x60/0xe0
> [    7.817529]  [<ffffffffa0011000>] ? 0xffffffffa0011000
> [    7.817533]  [<ffffffff8167b543>] __hid_register_driver+0x53/0x90
> [    7.817540]  [<ffffffffa001101e>] mt_driver_init+0x1e/0x1000 [hid_=
multitouch]
> [    7.817547]  [<ffffffff81002190>] do_one_initcall+0x50/0x180
> [    7.817554]  [<ffffffff811d9cba>] ? kvfree+0x2a/0x40
> [    7.817561]  [<ffffffff81221099>] ? kfree+0x159/0x170
> [    7.817567]  [<ffffffff8121fb82>] ? kmem_cache_alloc_trace+0x182/0=
x1d0
> [    7.817574]  [<ffffffff811b6116>] ? do_init_module+0x27/0x1d8
> [    7.817580]  [<ffffffff811b614e>] do_init_module+0x5f/0x1d8
> [    7.817589]  [<ffffffff8112ecdc>] load_module+0x1fdc/0x27d0
> [    7.817595]  [<ffffffff8112bbb0>] ? __symbol_put+0x60/0x60
> [    7.817605]  [<ffffffff8124555b>] ? vfs_read+0x11b/0x130
> [    7.817612]  [<ffffffff8112f746>] SYSC_finit_module+0xe6/0x120
> [    7.817619]  [<ffffffff8112f79e>] SyS_finit_module+0xe/0x10
> [    7.817623]  [<ffffffff81003d52>] do_syscall_64+0x62/0x110
> [    7.817631]  [<ffffffff817e0ca1>] entry_SYSCALL64_slow_path+0x25/0=
x25
> [    7.818076] input: Microsoft Surface Type Cover Keyboard as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001/input/i=
nput2
> [    7.869886] input: Microsoft Surface Type Cover Consumer Control a=
s /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001=
/input/input4
> [    7.870276] input: Microsoft Surface Type Cover Touchpad as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001/input/i=
nput6
> [    7.870849] hid-multitouch 0003:045E:07DC.0001: input,hiddev0,hidr=
aw0: USB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:=
00:14.0-3/input0
> [    7.870857] Post-hid_hw_start hdev->quirks: -2147483328
>=20
> Sincerely,
> Dennis Chen




--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
