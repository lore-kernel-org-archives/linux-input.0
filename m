From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 15:12:19 +0200
Message-ID: <55AF96B3.8070507@suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws> <20150721210850.GA13242@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721210850.GA13242@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, =?windows-1252?Q?Pali?= =?windows-1252?Q?_Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On 07/21/2015 11:08 PM, Pavel Machek wrote:
> On Tue 2015-07-21 10:01:33, Dmitry Torokhov wrote:
>> On Tue, Jul 21, 2015 at 01:14:39PM +0200, Vlastimil Babka wrote:
>>> On 06/09/2015 07:42 PM, Dmitry Torokhov wrote:
>>>> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>>>
>>>> This change creates a new input handler called "leds" that exports LEDs on input
>>>> devices as standard LED class devices in sysfs and allows controlling their
>>>> ptate via sysfs or via any of the standard LED triggers. This allows to
>>>> re-purpose and reassign LDEs on the keyboards to represent states other
>>>> than the standard keyboard states (CapsLock, NumLock, etc).
>>>>
>>>> The old API of controlling input LEDs by writing into /dev/input/eventX
>>>> devices is still present and will take precedence over acessing via LEDs
>>>> subsystem (i.e. it may override state set by a trigger). If input device is
>>>> "grabbed" then requests coming through LED subsystem will be ignored.
>>>>
>>>> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> ---
>>>
>>>> +	led_no = 0;
>>>> +	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
>>>> +		struct input_led *led = &leds->leds[led_no];
>>>> +
>>>> +		led->handle = &leds->handle;
>>>> +		led->code = led_code;
>>>> +
>>>> +		if (WARN_ON(!input_led_info[led_code].name))
>>>> +			continue;
>>>> +
>>>
>>> Hi,
>>> I get several warnings on booting 4.2-rc2 here. Should I be worried?
>>>
>>> [    2.782432] ------------[ cut here ]------------
>>> [    2.782440] WARNING: CPU: 2 PID: 356 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()
>>> [    2.782441] Modules linked in: btrfs xor raid6_pq crc32c_intel radeon i2c_algo_bit sr_mod cdrom drm_kms_helper ttm e1000e drm xhci_pci ptp pps_core xhci_hcd sg
>>> [    2.782453] CPU: 2 PID: 356 Comm: kworker/2:2 Not tainted 4.2.0-rc2-1.g288d56b-desktop #1
>>> [    2.782454] Hardware name: Dell Inc. OptiPlex 9010/0M9KCM, BIOS A13 03/27/2013
>>> [    2.782458] Workqueue: usb_hub_wq hub_event
>>> [    2.782459]  ffffffff81a917b7 ffff880213ecf298 ffffffff8169f19d 0000000000000007
>>> [    2.782462]  0000000000000000 ffff880213ecf2d8 ffffffff810674f6 ffff880213ecf2f8
>>> [    2.782463]  ffff8802132fb000 0000000000000003 000000000000000b ffff8800369ff000
>>> [    2.782465] Call Trace:
>>> [    2.782470]  [<ffffffff8169f19d>] dump_stack+0x4c/0x6e
>>> [    2.782474]  [<ffffffff810674f6>] warn_slowpath_common+0x86/0xc0
>>> [    2.782476]  [<ffffffff810675ea>] warn_slowpath_null+0x1a/0x20
>>> [    2.782478]  [<ffffffff8152ccdb>] input_leds_connect+0x22b/0x260
>>> [    2.782480]  [<ffffffff815281b2>] input_attach_handler+0x1a2/0x1f0
>>> [    2.782483]  [<ffffffff81528640>] input_register_device+0x440/0x4f0
>>> [    2.782486]  [<ffffffff8156e494>] hidinput_connect+0x334/0x5d0
>>> [    2.782488]  [<ffffffff815683d4>] hid_connect+0x324/0x400
>>
>> No, this is benign. I guess your keyboard has more LEDs than input
>> system has defined or several usages refer to the same LED.

It's a mouse actually:

[   69.413682] usb 3-4: new low-speed USB device number 3 using xhci_hcd
[   69.587651] usb 3-4: New USB device found, idVendor=046d, idProduct=c50e
[   69.587656] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   69.587659] usb 3-4: Product: USB Receiver
[   69.587661] usb 3-4: Manufacturer: Logitech
[   69.587865] usb 3-4: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[   69.596494] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:046D:C50E.0003/input/input14

followed by 5 warnings as the one I posted (all look the same at first
glance) and then:

[   69.648581] hid-generic 0003:046D:C50E.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-4/input0

The mouse has 3 green leds and one red to indicate battery status, but I think
they operate autonomously.

> Can we get rid of WARN_ON, then? It is nasty to flood logs, and people
> are likely to flood our inboxes, soon. printk(KERN_ERR) should be
> adequate...

I agree warning like this is inappropriate. But unfortunately things get worse
when I try to unplug the receiver...

Jul 22 14:46:11 gusiac kernel: BUG: unable to handle kernel NULL pointer dereference at           (null)
Jul 22 14:46:11 gusiac kernel: IP: [<ffffffff8147d807>] device_del+0x17/0x260
Jul 22 14:46:11 gusiac kernel: PGD 0 
Jul 22 14:46:12 gusiac kernel: Oops: 0000 [#1] PREEMPT SMP 
Jul 22 14:46:12 gusiac kernel: Modules linked in: bnep bluetooth rfkill fuse nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache iscsi_ibft iscsi_boo
Jul 22 14:46:12 gusiac kernel:  drm xhci_hcd sg
Jul 22 14:46:12 gusiac kernel: CPU: 6 PID: 194 Comm: kworker/6:1 Tainted: G        W       4.2.0-rc2-2.g7010139-desktop #1
Jul 22 14:46:12 gusiac kernel: Hardware name: Dell Inc. OptiPlex 9010/0M9KCM, BIOS A13 03/27/2013
Jul 22 14:46:12 gusiac kernel: Workqueue: usb_hub_wq hub_event
Jul 22 14:46:12 gusiac kernel: task: ffff880213d28100 ti: ffff880213c8c000 task.ti: ffff880213c8c000
Jul 22 14:46:12 gusiac kernel: RIP: 0010:[<ffffffff8147d807>]  [<ffffffff8147d807>] device_del+0x17/0x260
Jul 22 14:46:12 gusiac kernel: RSP: 0018:ffff880213c8f828  EFLAGS: 00010286
Jul 22 14:46:12 gusiac kernel: RAX: 00000000ffffffea RBX: 0000000000000000 RCX: 0000000000000000
Jul 22 14:46:12 gusiac kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
Jul 22 14:46:12 gusiac kernel: RBP: ffff880213c8f868 R08: 0000000000000000 R09: ffffffff8135b2b0
Jul 22 14:46:12 gusiac kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
Jul 22 14:46:12 gusiac kernel: R13: ffff880213622000 R14: ffff880213622000 R15: ffff880213d618d0
Jul 22 14:46:12 gusiac kernel: FS:  0000000000000000(0000) GS:ffff88021dd80000(0000) knlGS:0000000000000000
Jul 22 14:46:12 gusiac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 22 14:46:12 gusiac kernel: CR2: 0000000000000000 CR3: 0000000001c0c000 CR4: 00000000001407e0
Jul 22 14:46:12 gusiac kernel: Stack:
Jul 22 14:46:12 gusiac kernel:  ffff88003697dc10 0000000000000292 ffff880213622540 ffff8802136225c8
Jul 22 14:46:12 gusiac kernel:  0000000000000000 ffff8802136225c8 ffff880213622000 ffff880213622000
Jul 22 14:46:12 gusiac kernel:  ffff880213c8f888 ffffffff8147da72 ffff880213c8f888 ffff8802136224d0
Jul 22 14:46:12 gusiac kernel: Call Trace:
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147da72>] device_unregister+0x22/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81560c61>] led_classdev_unregister+0x61/0xb0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8152ca1a>] input_leds_disconnect+0x3a/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81529e2c>] __input_unregister_device+0xac/0x170
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81529faf>] input_unregister_device+0x4f/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8156b358>] hidinput_disconnect+0x98/0xd0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81568526>] hid_disconnect+0x76/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff815685ea>] hid_device_remove+0xba/0xd0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481b11>] __device_release_driver+0xa1/0x150
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481be3>] device_release_driver+0x23/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481285>] bus_remove_device+0x105/0x180
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147d929>] device_del+0x139/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81568687>] hid_destroy_device+0x27/0x60
Jul 22 14:46:12 gusiac kernel:  [<ffffffff815766cd>] usbhid_disconnect+0x4d/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814fd8c3>] usb_unbind_interface+0x83/0x270
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8148c57b>] ? rpm_idle+0x5b/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481b11>] __device_release_driver+0xa1/0x150
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481be3>] device_release_driver+0x23/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481285>] bus_remove_device+0x105/0x180
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147d929>] device_del+0x139/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814fb169>] usb_disable_device+0x89/0x270
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f0d02>] usb_disconnect+0x92/0x2b0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f2993>] hub_port_connect+0x73/0x9c0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f39b1>] hub_event+0x6d1/0xb10
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8109dd5b>] ? dequeue_task_fair+0x36b/0x700
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8109d121>] ? put_prev_entity+0x31/0x420
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f039>] process_one_work+0x159/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f398>] worker_thread+0x48/0x4a0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81085089>] kthread+0xc9/0xe0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
Jul 22 14:46:12 gusiac kernel:  [<ffffffff816a55df>] ret_from_fork+0x3f/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
Jul 22 14:46:12 gusiac kernel: Code: 48 89 d7 48 89 e5 e8 89 ff ff ff 5d c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 53 49 89 fc 48 83 ec 20 <4c> 8b 2f 65 48 8b 04 
Jul 22 14:46:12 gusiac kernel: RIP  [<ffffffff8147d807>] device_del+0x17/0x260
Jul 22 14:46:12 gusiac kernel:  RSP <ffff880213c8f828>
Jul 22 14:46:12 gusiac kernel: CR2: 0000000000000000
Jul 22 14:46:12 gusiac kernel: ---[ end trace 0f333fa3e11a3225 ]---
Jul 22 14:46:12 gusiac kernel: BUG: unable to handle kernel paging request at ffffffffffffffd8
Jul 22 14:46:12 gusiac kernel: IP: [<ffffffff810854f0>] kthread_data+0x10/0x20
Jul 22 14:46:12 gusiac kernel: PGD 1c0d067 PUD 1c0f067 PMD 0 
Jul 22 14:46:12 gusiac kernel: Oops: 0000 [#2] PREEMPT SMP 
Jul 22 14:46:12 gusiac kernel: Modules linked in: bnep bluetooth rfkill fuse nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache iscsi_ibft iscsi_boo
Jul 22 14:46:12 gusiac kernel:  drm xhci_hcd sg
Jul 22 14:46:12 gusiac kernel: CPU: 6 PID: 194 Comm: kworker/6:1 Tainted: G      D W       4.2.0-rc2-2.g7010139-desktop #1
Jul 22 14:46:12 gusiac kernel: Hardware name: Dell Inc. OptiPlex 9010/0M9KCM, BIOS A13 03/27/2013
Jul 22 14:46:12 gusiac kernel: task: ffff880213d28100 ti: ffff880213c8c000 task.ti: ffff880213c8c000
Jul 22 14:46:12 gusiac kernel: RIP: 0010:[<ffffffff810854f0>]  [<ffffffff810854f0>] kthread_data+0x10/0x20
Jul 22 14:46:12 gusiac kernel: RSP: 0018:ffff880213c8f4c8  EFLAGS: 00010096
Jul 22 14:46:12 gusiac kernel: RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000005
Jul 22 14:46:12 gusiac kernel: RDX: 0000000000000005 RSI: 0000000000000006 RDI: ffff880213d28100
Jul 22 14:46:12 gusiac kernel: RBP: ffff880213c8f4c8 R08: 00000000ffffffff R09: 0000000000000000
Jul 22 14:46:12 gusiac kernel: R10: 0000000073f4002f R11: 000000000000002f R12: 0000000000015600
Jul 22 14:46:12 gusiac kernel: R13: ffff88021dd95600 R14: ffff880213d28100 R15: 0000000000000006
Jul 22 14:46:12 gusiac kernel: FS:  0000000000000000(0000) GS:ffff88021dd80000(0000) knlGS:0000000000000000
Jul 22 14:46:12 gusiac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 22 14:46:12 gusiac kernel: CR2: 0000000000000028 CR3: 0000000001c0c000 CR4: 00000000001407e0
Jul 22 14:46:12 gusiac kernel: Stack:
Jul 22 14:46:12 gusiac kernel:  ffff880213c8f4e8 ffffffff8107fd55 ffff880213c8f4e8 ffff88021dd95600
Jul 22 14:46:12 gusiac kernel:  ffff880213c8f538 ffffffff816a0bc7 ffff880200000000 ffff880213d28100
Jul 22 14:46:12 gusiac kernel:  ffff880036d77cc0 ffff880213c90000 ffff880213d28d70 ffff880213c8f0c0
Jul 22 14:46:12 gusiac kernel: Call Trace:
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107fd55>] wq_worker_sleeping+0x15/0xa0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff816a0bc7>] __schedule+0x667/0x970
Jul 22 14:46:12 gusiac kernel:  [<ffffffff816a0f0e>] schedule+0x3e/0x90
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8106a096>] do_exit+0x806/0xb00
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8100753e>] oops_end+0x9e/0xd0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff810532eb>] no_context+0x10b/0x360
Jul 22 14:46:12 gusiac kernel:  [<ffffffff810535c0>] __bad_area_nosemaphore+0x80/0x1f0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81053743>] bad_area_nosemaphore+0x13/0x20
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81053a29>] __do_page_fault+0xb9/0x410
Jul 22 14:46:12 gusiac kernel:  [<ffffffff815d8186>] ? netlink_broadcast_filtered+0x136/0x3b0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81053da2>] do_page_fault+0x22/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff816a6f88>] page_fault+0x28/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8135b2b0>] ? cleanup_uevent_env+0x10/0x10
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147d807>] ? device_del+0x17/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff810d0f3f>] ? try_to_del_timer_sync+0x4f/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147da72>] device_unregister+0x22/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81560c61>] led_classdev_unregister+0x61/0xb0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8152ca1a>] input_leds_disconnect+0x3a/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81529e2c>] __input_unregister_device+0xac/0x170
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81529faf>] input_unregister_device+0x4f/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8156b358>] hidinput_disconnect+0x98/0xd0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81568526>] hid_disconnect+0x76/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff815685ea>] hid_device_remove+0xba/0xd0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481b11>] __device_release_driver+0xa1/0x150
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481be3>] device_release_driver+0x23/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481285>] bus_remove_device+0x105/0x180
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147d929>] device_del+0x139/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81568687>] hid_destroy_device+0x27/0x60
Jul 22 14:46:12 gusiac kernel:  [<ffffffff815766cd>] usbhid_disconnect+0x4d/0x80
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814fd8c3>] usb_unbind_interface+0x83/0x270
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8148c57b>] ? rpm_idle+0x5b/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481b11>] __device_release_driver+0xa1/0x150
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481be3>] device_release_driver+0x23/0x30
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81481285>] bus_remove_device+0x105/0x180
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8147d929>] device_del+0x139/0x260
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814fb169>] usb_disable_device+0x89/0x270
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f0d02>] usb_disconnect+0x92/0x2b0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f2993>] hub_port_connect+0x73/0x9c0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff814f39b1>] hub_event+0x6d1/0xb10
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8109dd5b>] ? dequeue_task_fair+0x36b/0x700
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8109d121>] ? put_prev_entity+0x31/0x420
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f039>] process_one_work+0x159/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f398>] worker_thread+0x48/0x4a0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff8107f350>] ? process_one_work+0x470/0x470
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81085089>] kthread+0xc9/0xe0
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
Jul 22 14:46:12 gusiac kernel:  [<ffffffff816a55df>] ret_from_fork+0x3f/0x70
Jul 22 14:46:12 gusiac kernel:  [<ffffffff81084fc0>] ? kthread_worker_fn+0x170/0x170
Jul 22 14:46:12 gusiac kernel: Code: 00 48 89 e5 5d 48 8b 40 c8 48 c1 e8 02 83 e0 01 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 60 05 00 00 55 48 89 e5 <48> 8b 40 d8 5d c3 66 
Jul 22 14:46:12 gusiac kernel: RIP  [<ffffffff810854f0>] kthread_data+0x10/0x20
Jul 22 14:46:12 gusiac kernel:  RSP <ffff880213c8f4c8>
Jul 22 14:46:12 gusiac kernel: CR2: ffffffffffffffd8
Jul 22 14:46:12 gusiac kernel: ---[ end trace 0f333fa3e11a3226 ]---
Jul 22 14:46:12 gusiac kernel: Fixing recursive fault but reboot is needed!

I think some more followed including rcu stall etc, but were not
logged permanently. I suspect the warnings and the bugs are
related :)

I'll now try collect the debug prints you suggested.


> Thanks,
> 									Pavel
> 
