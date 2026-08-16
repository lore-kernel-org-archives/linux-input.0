Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194AE23D28C
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849408; cv=none; b=OqSr1kDjRLRGm1A+oUk5OXPsX1GHczciWcNBBCMhQzsD/RWHt6jiQS6n4N4/r7GDpE9PQYM9bU5OxhtyRAa8+C1MHmjQPMqBJcb7d1DRVzRJhpsnICRuZh2U2z+wyuF8vfPxUJCcIS0RVLFIlJbVZkI0t7+6yHp7p0UqV5faRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849408; c=relaxed/simple;
	bh=g0KUZMw1u4HQPch5nYUd1lr1LSu5GK06o3lj4XKCLw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MnB9lpZhQLWzzji0pxpj2NPHmoZOLRnLMJlobCJUhBLp4EW8bp4Aq0V9NxfKVOjL1Tv1hMgfqDTSJ34tZhiflLhNNDEj1y9Wt8nsdqsYrfRdDcAfFDzgiZF4b8nA1MkjUxiWQnrIv+FdrTGALjFWIZ+sGlrGrZjBWYspdWFiHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4b19ce23e5cso1574741b6e.1
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 20:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786849406; x=1787454206;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9m520KaLscAfCgGCZaFiJOW4gVCeAekV+h/SU3kvUSk=;
        b=aqWfWEO8H5HAkzVnuSEKRTxj9zcR6X5BfWrlwHHHeXqVKUXP3WffW0lkUix+eYpa+j
         kn7mhtKqHqz2qCN7MQZM2sVIS+sBZg0GhIUiPC8uuHvh0qOl3M+GLBRizk+k8VrTxKAw
         cIXG2q7cmBCKwo2i/YGmlZvKGas3nSCrSdrQz3QSZnhAx9MgaoeEtskhOcNmrzZTkV+Z
         Gci6u+YOmUoF/FH5NqP7K+dV8FoCrnh1Fc3Y4IPfsH/iWV6anqPpIa0UuSNRDEWENU9J
         s70khFvuEMJtk17HzN+Qm6wSiHioQ7HyFBmp/9mteR+bjn29hmuB101kvJUBlV1S/BVX
         u1Nw==
X-Forwarded-Encrypted: i=1; AHgh+RquDkjvdot6ntkg0wa39vGi5+TPmlR68eUDuzEHsepms/zL9ox5JTPP9cHH1KDBIBtwV5wvIh4KSUpBjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHQTkcA4057K46p/rIZocoJscg1EukrFJAJJn65msJMzajfbu
	o/+9J5W81105UeCOmWWEBIDuMm6bRUF0qu3441yecRZ3H0ngWYKwhf/YUnFb616HKlw8ZA4EyDq
	9Q+xC+NmivqZ2adQIPiyvR1eULYa1JaAp5Ijbc7Ba+hI6Hcs12/yohrz7UAA=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1496:b0:497:e7e2:756e with SMTP id
 5614622812f47-4b241e05d17mr16562656b6e.13.1786849406101; Sat, 15 Aug 2026
 20:03:26 -0700 (PDT)
Date: Sat, 15 Aug 2026 20:03:26 -0700
In-Reply-To: <683199ed.a70a0220.29d4a0.07f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a81287e.10853dc7.22f513.000c.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in report_descriptor_read
From: syzbot <syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bdab5605259b usb: gadget: uvc: fix dangling pointers in uv..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=163fb279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bdeea7ee6735f91
dashboard link: https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1108aa25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cb2fdbdd7b7/disk-bdab5605.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f801d31c2001/vmlinux-bdab5605.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9002a6e0ae14/bzImage-bdab5605.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in report_descriptor_read+0xbb/0x100 drivers/hid/hid-core.c:2272
Read of size 24 at addr ffff888120aa1480 by task fido_id/6160

CPU: 1 UID: 0 PID: 6160 Comm: fido_id Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 report_descriptor_read+0xbb/0x100 drivers/hid/hid-core.c:2272
 sysfs_kf_bin_read+0x156/0x210 fs/sysfs/file.c:102
 kernfs_file_read_iter fs/kernfs/file.c:262 [inline]
 kernfs_fop_read_iter+0x32b/0x610 fs/kernfs/file.c:291
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x82e/0xb40 fs/read_write.c:574
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcdd3a5e407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd1213c0d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fcdd3970880 RCX: 00007fcdd3a5e407
RDX: 0000000000001000 RSI: 00007ffd1213c120 RDI: 0000000000000004
RBP: 0000558f17e1d2c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000558f17e1c4c0
R13: 00007ffd1213c120 R14: 0000000000000004 R15: 0000558ee8aae4d8
 </TASK>

Allocated by task 2921:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_track_caller_noprof+0x318/0x7d0 mm/slub.c:5471
 kmemdup_noprof+0x29/0x60 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 hid_open_report+0x214/0x810 drivers/hid/hid-core.c:1376
 hid_parse include/linux/hid.h:1206 [inline]
 lg_probe+0x246/0x7e0 drivers/hid/hid-lg.c:783
 __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
 hid_device_probe+0x50e/0x800 drivers/hid/hid-core.c:2866
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3010
 usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
 usb_new_device drivers/usb/core/hub.c:5833 [inline]
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5966
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888120aa1480
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff888120aa1480, ffff888120aa14a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x120aa1
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100041780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4145, tgid 4145 (modprobe), ts 107921942180, free_ts 107809260171
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf25/0x3400 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x28f/0x2b90 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x670 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __kmalloc_cache_noprof+0x50e/0x670 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 slab_free_hook mm/slub.c:2629 [inline]
 slab_free mm/slub.c:6377 [inline]
 kmem_cache_free+0x3f3/0x650 mm/slub.c:6504
 file_free fs/file_table.c:104 [inline]
 __fput+0x68d/0xb50 fs/file_table.c:525
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x8d2/0x2a50 kernel/exit.c:1009
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1161
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 14 tgid 14 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x716/0xf50 mm/page_alloc.c:2950
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1dd/0x990 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888120aa1380: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888120aa1400: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff888120aa1480: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff888120aa1500: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888120aa1580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
