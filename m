Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA921E5B63
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260515; cv=none; b=JWslq5/1r70jf8Wd9Cypm5TS29cz82gta2K5nJh3ve7cEL9nPvLnlor68gW3IPKy7ZQaJHlxjvjw5l1+hEDoheU6n3BvYzLXMXBPpALDL8HaDrgdOPKuSmH/MFtCck2SHnINMV8GwMovZn5ZXt2B12abqeckSq4r/oGlEX3kXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260515; c=relaxed/simple;
	bh=KZt1l95KYaYrGNeQ55BeMk6zjKlixFqJueDM1jFxBKY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Oxp0Pg2/E66DLwlw+O1/fHyHx98A/BzfzXmx5TgMEBxZ679JBgNnn7AkPrlMg5SU5jXlK1SVK3cxSETZ2oh+9WruxZ7NggaNnT8iuCdISMrvIveCXhqRs8/UExRxnjnUCEY5RpQSY2rq/5X8f6UB53c97lexbAgi/xNmA/hyosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6961cacdd3aso3668153eaf.0
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 20:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260512; x=1777865312;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwUgSkDU4P2JlN6hg5pdMco8+cIjVuyM4O3ngYoaJJ4=;
        b=IstyFXx3GgTI46wtnRnILfMFRo34fHPCInGRr3uGnPQa0lrVMtZv41Cc9l+ezNwJix
         mJVn2FrwelY6SBSEgOYZyr+EZMgjQqAjCHwohgfhjEFsPBF80xkkngnTzVH5MmaNB2Gt
         jneU3Rzy3NoDnmxkGWuViJkJX4KEBUIWNLblCp5T7AEDBNFjJhC86eTUDzOgcN9Lznp3
         d+d+0bCh9AGtBuuDrdumTmKbjm+HqRYSTCEol/yEUeRgmowYgTsQGkWFsCyi51b5YvEU
         Rrx3R5ztVKotCcJNhL0NzQbvLfmu9gdkqQ8ORxRGDjelSKswGGfRYY8K+jABKPd2NGl7
         wJmg==
X-Forwarded-Encrypted: i=1; AFNElJ9I4oTk3EQmT55/4WADMDvGB8X2yJEE51F+zjn+z8kYJf+sYBy0SmZkRjOCQUS2liWrnLISQ2eq+JFTng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1ZpsCHuQ67oVV/oE+/RSeavzCR4WdCnHL2DdtzkbnKI472tX
	11K2nrpluSkqD2VusqzjTgg8ZcXbO/SgBOpFtzV+bBIgiSmFUcificUxDICrz2DrDX3MJKsus7v
	eETFQpA36AJvecylxUdaor3Bpf+Lb7LV4p4KKJTsP24DWp9T3/cJSLVrWOUI=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1842:b0:67c:1e60:3e90 with SMTP id
 006d021491bc7-69462e16c99mr20054082eaf.6.1777260512383; Sun, 26 Apr 2026
 20:28:32 -0700 (PDT)
Date: Sun, 26 Apr 2026 20:28:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in hidraw_report_event
From: syzbot <syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7080e32d3f09 Add linux-next specific files for 20260424
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d8b2d2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d941ac7f11ceb230
dashboard link: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d309ba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a082ce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bbfdd86f73d/disk-7080e32d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1257e4300d9e/vmlinux-7080e32d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2588b431811/bzImage-7080e32d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
Read of size 1 at addr ffff888039a26d08 by task ktimers/0/16

CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
 rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 hidraw_report_event+0x5d/0x3a0 drivers/hid/hidraw.c:577
 hid_report_raw_event+0x311/0x1730 drivers/hid/hid-core.c:2076
 __hid_input_report drivers/hid/hid-core.c:2152 [inline]
 hid_input_report+0x44e/0x580 drivers/hid/hid-core.c:2174
 hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
 __usb_hcd_giveback_urb+0x3b3/0x5e0 drivers/usb/core/hcd.c:1657
 dummy_timer+0x8a9/0x47d0 drivers/usb/gadget/udc/dummy_hcd.c:2005
 __run_hrtimer kernel/time/hrtimer.c:1930 [inline]
 __hrtimer_run_queues+0x405/0xb10 kernel/time/hrtimer.c:1994
 hrtimer_run_softirq+0x18f/0x260 kernel/time/hrtimer.c:2011
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 run_ktimerd+0x69/0x100 kernel/softirq.c:1155
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 10:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 hidraw_connect+0x57/0x430 drivers/hid/hidraw.c:606
 hid_connect+0x5bf/0x19d0 drivers/hid/hid-core.c:2277
 hid_hw_start+0xa8/0x120 drivers/hid/hid-core.c:2387
 corsairpsu_probe+0xd9/0x3c0 drivers/hwmon/corsair-psu.c:782
 __hid_device_probe drivers/hid/hid-core.c:2783 [inline]
 hid_device_probe+0x416/0x7a0 drivers/hid/hid-core.c:2820
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:2964
 usbhid_probe+0xbb3/0x1080 drivers/hid/usbhid/hid-core.c:1448
 usb_probe_interface+0x659/0xc70 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_new_device+0x9f8/0x16e0 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x2a49/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 10:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6561
 hidraw_disconnect+0x4f/0x60 drivers/hid/hidraw.c:662
 hid_disconnect drivers/hid/hid-core.c:2362 [inline]
 hid_hw_stop+0x101/0x1e0 drivers/hid/hid-core.c:2407
 corsairpsu_probe+0x327/0x3c0 drivers/hwmon/corsair-psu.c:826
 __hid_device_probe drivers/hid/hid-core.c:2783 [inline]
 hid_device_probe+0x416/0x7a0 drivers/hid/hid-core.c:2820
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:2964
 usbhid_probe+0xbb3/0x1080 drivers/hid/usbhid/hid-core.c:1448
 usb_probe_interface+0x659/0xc70 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:709
 __driver_probe_device+0x1ef/0x380 drivers/base/dd.c:871
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:901
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:1029
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1101
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1156
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:613
 device_add+0x7e9/0xbb0 drivers/base/core.c:3706
 usb_new_device+0x9f8/0x16e0 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x2a49/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3312
 process_scheduled_works kernel/workqueue.c:3403 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3489
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888039a26c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 264 bytes inside of
 freed 512-byte region [ffff888039a26c00, ffff888039a26e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x39a24
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813fe14c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813fe14c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0080000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5865, tgid 5865 (syz-executor), ts 158390292947, free_ts 156250708543
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x27d6/0x2850 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x44e/0x690 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 tc_action_net_init include/net/act_api.h:163 [inline]
 nat_init_net+0x65/0x1a0 net/sched/act_nat.c:332
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0x118/0x340 net/core/net_namespace.c:446
 copy_net_ns+0x50e/0x730 net/core/net_namespace.c:579
 create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0x149/0x190 kernel/nsproxy.c:234
 ksys_unshare+0x57d/0x9f0 kernel/fork.c:3244
 __do_sys_unshare kernel/fork.c:3318 [inline]
 __se_sys_unshare kernel/fork.c:3316 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3316
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
page last free pid 5848 tgid 5848 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xf9b/0x10f0 mm/page_alloc.c:2943
 __folio_put+0x2eb/0x3a0 mm/swap.c:112
 folio_put include/linux/mm.h:2090 [inline]
 put_page include/linux/mm.h:2159 [inline]
 put_netmem include/net/netmem.h:394 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x544/0xa60 net/core/skbuff.c:1108
 skb_release_all net/core/skbuff.c:1189 [inline]
 __kfree_skb+0x5d/0x210 net/core/skbuff.c:1203
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3698 [inline]
 tcp_ack+0x284f/0x7e00 net/ipv4/tcp_input.c:4370
 tcp_rcv_established+0x8c4/0x2800 net/ipv4/tcp_input.c:6645
 tcp_v4_do_rcv+0x755/0x13f0 net/ipv4/tcp_ipv4.c:1852
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x285/0x3d0 net/core/sock.c:3216
 __sk_flush_backlog+0x4b/0xe0 net/core/sock.c:3239
 sk_flush_backlog include/net/sock.h:1253 [inline]
 tcp_sendmsg_locked+0x4167/0x5370 net/ipv4/tcp.c:1256
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1455
 sock_sendmsg_nosec+0xf9/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 sock_write_iter+0x308/0x410 net/socket.c:1269
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff888039a26c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039a26c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888039a26d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888039a26d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039a26e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
