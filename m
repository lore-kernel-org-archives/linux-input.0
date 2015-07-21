From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 21 Jul 2015 13:14:39 +0200
Message-ID: <55AE299F.3010002@suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56834 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbbGULOm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 07:14:42 -0400
In-Reply-To: <20150609174211.GH6338@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 06/09/2015 07:42 PM, Dmitry Torokhov wrote:
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> This change creates a new input handler called "leds" that exports LEDs on input
> devices as standard LED class devices in sysfs and allows controlling their
> ptate via sysfs or via any of the standard LED triggers. This allows to
> re-purpose and reassign LDEs on the keyboards to represent states other
> than the standard keyboard states (CapsLock, NumLock, etc).
> 
> The old API of controlling input LEDs by writing into /dev/input/eventX
> devices is still present and will take precedence over acessing via LEDs
> subsystem (i.e. it may override state set by a trigger). If input device is
> "grabbed" then requests coming through LED subsystem will be ignored.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

> +	led_no = 0;
> +	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
> +		struct input_led *led = &leds->leds[led_no];
> +
> +		led->handle = &leds->handle;
> +		led->code = led_code;
> +
> +		if (WARN_ON(!input_led_info[led_code].name))
> +			continue;
> +

Hi,
I get several warnings on booting 4.2-rc2 here. Should I be worried?

[    2.782432] ------------[ cut here ]------------
[    2.782440] WARNING: CPU: 2 PID: 356 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()
[    2.782441] Modules linked in: btrfs xor raid6_pq crc32c_intel radeon i2c_algo_bit sr_mod cdrom drm_kms_helper ttm e1000e drm xhci_pci ptp pps_core xhci_hcd sg
[    2.782453] CPU: 2 PID: 356 Comm: kworker/2:2 Not tainted 4.2.0-rc2-1.g288d56b-desktop #1
[    2.782454] Hardware name: Dell Inc. OptiPlex 9010/0M9KCM, BIOS A13 03/27/2013
[    2.782458] Workqueue: usb_hub_wq hub_event
[    2.782459]  ffffffff81a917b7 ffff880213ecf298 ffffffff8169f19d 0000000000000007
[    2.782462]  0000000000000000 ffff880213ecf2d8 ffffffff810674f6 ffff880213ecf2f8
[    2.782463]  ffff8802132fb000 0000000000000003 000000000000000b ffff8800369ff000
[    2.782465] Call Trace:
[    2.782470]  [<ffffffff8169f19d>] dump_stack+0x4c/0x6e
[    2.782474]  [<ffffffff810674f6>] warn_slowpath_common+0x86/0xc0
[    2.782476]  [<ffffffff810675ea>] warn_slowpath_null+0x1a/0x20
[    2.782478]  [<ffffffff8152ccdb>] input_leds_connect+0x22b/0x260
[    2.782480]  [<ffffffff815281b2>] input_attach_handler+0x1a2/0x1f0
[    2.782483]  [<ffffffff81528640>] input_register_device+0x440/0x4f0
[    2.782486]  [<ffffffff8156e494>] hidinput_connect+0x334/0x5d0
[    2.782488]  [<ffffffff815683d4>] hid_connect+0x324/0x400
[    2.782490]  [<ffffffff81578b7a>] ? usbhid_start+0x54a/0x780
[    2.782492]  [<ffffffff81569858>] hid_device_probe+0x118/0x140
[    2.782495]  [<ffffffff81482134>] driver_probe_device+0x1f4/0x460
[    2.782497]  [<ffffffff814824b9>] __device_attach_driver+0x79/0xa0
[    2.782499]  [<ffffffff81482440>] ? __driver_attach+0xa0/0xa0
[    2.782501]  [<ffffffff8147ff6b>] bus_for_each_drv+0x5b/0x90
[    2.782502]  [<ffffffff81481e58>] __device_attach+0xa8/0x120
[    2.782504]  [<ffffffff81482523>] device_initial_probe+0x13/0x20
[    2.782506]  [<ffffffff8148116a>] bus_probe_device+0x9a/0xb0
[    2.782508]  [<ffffffff8147edee>] device_add+0x3fe/0x670
[    2.782511]  [<ffffffff812bf9d3>] ? debugfs_create_file+0xd3/0x110
[    2.782513]  [<ffffffff8156956c>] hid_add_device+0xcc/0x2a0
[    2.782515]  [<ffffffff81578404>] usbhid_probe+0x2e4/0x410
[    2.782518]  [<ffffffff814fe0d2>] usb_probe_interface+0x1b2/0x2d0
[    2.782519]  [<ffffffff81482134>] driver_probe_device+0x1f4/0x460
[    2.782521]  [<ffffffff814824b9>] __device_attach_driver+0x79/0xa0
[    2.782523]  [<ffffffff81482440>] ? __driver_attach+0xa0/0xa0
[    2.782525]  [<ffffffff8147ff6b>] bus_for_each_drv+0x5b/0x90
[    2.782526]  [<ffffffff81481e58>] __device_attach+0xa8/0x120
[    2.782528]  [<ffffffff81482523>] device_initial_probe+0x13/0x20
[    2.782530]  [<ffffffff8148116a>] bus_probe_device+0x9a/0xb0
[    2.782531]  [<ffffffff8147edee>] device_add+0x3fe/0x670
[    2.782533]  [<ffffffff814fbfb1>] usb_set_configuration+0x501/0x8e0
[    2.782535]  [<ffffffff81253efe>] ? kernfs_add_one+0xee/0x140
[    2.782537]  [<ffffffff8150656e>] generic_probe+0x2e/0x80
[    2.782539]  [<ffffffff814fdee2>] usb_probe_device+0x32/0x70
[    2.782541]  [<ffffffff81482134>] driver_probe_device+0x1f4/0x460
[    2.782542]  [<ffffffff814824b9>] __device_attach_driver+0x79/0xa0
[    2.782544]  [<ffffffff81482440>] ? __driver_attach+0xa0/0xa0
[    2.782546]  [<ffffffff8147ff6b>] bus_for_each_drv+0x5b/0x90
[    2.782547]  [<ffffffff81481e58>] __device_attach+0xa8/0x120
[    2.782549]  [<ffffffff81482523>] device_initial_probe+0x13/0x20
[    2.782551]  [<ffffffff8148116a>] bus_probe_device+0x9a/0xb0
[    2.782552]  [<ffffffff8147edee>] device_add+0x3fe/0x670
[    2.782554]  [<ffffffff814f15c6>] ? usb_new_device+0x216/0x5d0
[    2.782556]  [<ffffffff814f164e>] usb_new_device+0x29e/0x5d0
[    2.782559]  [<ffffffff8148cff1>] ? pm_runtime_set_autosuspend_delay+0x51/0x60
[    2.782561]  [<ffffffff81506612>] ? __usb_detect_quirks+0x52/0x110
[    2.782563]  [<ffffffff814f2c3f>] hub_port_connect+0x31f/0x9c0
[    2.782565]  [<ffffffff814f39b1>] hub_event+0x6d1/0xb10
[    2.782568]  [<ffffffff8107f039>] process_one_work+0x159/0x470
[    2.782570]  [<ffffffff8107f398>] worker_thread+0x48/0x4a0
[    2.782572]  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
[    2.782574]  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
[    2.782576]  [<ffffffff81085089>] kthread+0xc9/0xe0
[    2.782579]  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
[    2.782581]  [<ffffffff816a55df>] ret_from_fork+0x3f/0x70
[    2.782583]  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
[    2.782585] ---[ end trace ce1cb4ca0f2cbd0b ]---
[    2.782586] ------------[ cut here ]------------

