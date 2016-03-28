From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH 0/1] Fix DMA_API_DEBUG warning in hid-lenovo
Date: Mon, 28 Mar 2016 09:22:13 -0400
Message-ID: <1459171334-22943-1-git-send-email-jwboyer@fedoraproject.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We've had a report[1] in Fedora of the hid-lenovo driver throwing
the backtrace below when CONFIG_DMA_API_DEBUG is set.  The following
patch should fix this.

WARNING: CPU: 3 PID: 385 at lib/dma-debug.c:1169 check_for_stack+0x90/0xd0
ohci-pci 0000:00:13.0: DMA-API: device driver maps memory from stack [addr=ffff880426cafa7d]
Modules linked in: serio_raw amdkfd amd_iommu_v2 alx mdio radeon(+) hid_lenovo(+) ax88179_178a(+) pata_atiixp usbnet i2c_algo_bit drm_kms_helper ttm drm r8169 mii fjes
CPU: 3 PID: 385 Comm: systemd-udevd Not tainted 4.6.0-0.rc0.git20.1.fc25.x86_64 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./FM2A88X-ITX+, BIOS P3.20 12/03/2015
 0000000000000286 00000000a490d2cf ffff880426caf670 ffffffff8145b265
 ffff880426caf6c0 0000000000000000 ffff880426caf6b0 ffffffff810b2f2b
 0000049126caf708 ffff880426cafa7d ffff88042d6a9098 ffff88042d6277a0
Call Trace:
 [<ffffffff8145b265>] dump_stack+0x86/0xc1
 [<ffffffff810b2f2b>] __warn+0xcb/0xf0
 [<ffffffff810b2faf>] warn_slowpath_fmt+0x5f/0x80
 [<ffffffff8148d2a0>] check_for_stack+0x90/0xd0
 [<ffffffff8148d899>] debug_dma_map_page+0xf9/0x150
 [<ffffffff816678db>] usb_hcd_map_urb_for_dma+0x5db/0x780
 [<ffffffff8166808b>] usb_hcd_submit_urb+0x37b/0xb60
 [<ffffffff815bcbef>] ? dev_vprintk_emit+0xbf/0x230
 [<ffffffff81118771>] ? __raw_spin_lock_init+0x21/0x60
 [<ffffffff8110f034>] ? lockdep_init_map+0x64/0x6c0
 [<ffffffff811121a5>] ? trace_hardirqs_on_caller+0xf5/0x1b0
 [<ffffffff81669a74>] usb_submit_urb+0x2f4/0x550
 [<ffffffff8166a3f4>] usb_start_wait_urb+0x74/0x180
 [<ffffffff8166a5dc>] usb_control_msg+0xdc/0x120
 [<ffffffff8173dad9>] usbhid_raw_request+0xa9/0x180
 [<ffffffffc02930a1>] lenovo_send_cmd_cptkbd+0xa1/0xc0 [hid_lenovo]
 [<ffffffffc02941c3>] lenovo_probe+0x313/0x460 [hid_lenovo]
 [<ffffffff81730e30>] ? hid_match_device+0xa0/0xb0
 [<ffffffff81733207>] hid_device_probe+0xd7/0x160
 [<ffffffff815c18cc>] driver_probe_device+0x22c/0x440
 [<ffffffff815c1bb5>] __driver_attach+0xd5/0x100
 [<ffffffff815c1ae0>] ? driver_probe_device+0x440/0x440
 [<ffffffff815bf113>] bus_for_each_dev+0x73/0xc0
 [<ffffffff815c0f9e>] driver_attach+0x1e/0x20
 [<ffffffff815c09c6>] bus_add_driver+0x1c6/0x290
 [<ffffffffc00bf000>] ? 0xffffffffc00bf000
 [<ffffffff815c2880>] driver_register+0x60/0xe0
 [<ffffffff81732106>] __hid_register_driver+0x66/0xa0
 [<ffffffffc00bf01e>] lenovo_driver_init+0x1e/0x1000 [hid_lenovo]
 [<ffffffff81002123>] do_one_initcall+0xb3/0x1f0
 [<ffffffff81131df5>] ? rcu_read_lock_sched_held+0x45/0x80
 [<ffffffff8126b6fc>] ? kmem_cache_alloc_trace+0x2ac/0x310
 [<ffffffff811f3f4e>] ? do_init_module+0x27/0x1da
 [<ffffffff811f3f86>] do_init_module+0x5f/0x1da
 [<ffffffff8115e588>] load_module+0x21e8/0x2950
 [<ffffffff8115ab30>] ? __symbol_put+0x70/0x70
 [<ffffffff81159b30>] ? show_coresize+0x30/0x30
 [<ffffffff8103fd19>] ? sched_clock+0x9/0x10
 [<ffffffff8115ee62>] SYSC_init_module+0x172/0x1b0
 [<ffffffff8115efce>] SyS_init_module+0xe/0x10
 [<ffffffff81004039>] do_syscall_64+0x69/0x190
 [<ffffffff818ce5ff>] entry_SYSCALL64_slow_path+0x25/0x25

josh

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1321421
