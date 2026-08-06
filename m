Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DF38655B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974438; cv=none; b=WmbAaG9EFY4h1F0HB4RVm2CDO/EuAQt8cjK3rJhTGa6SPFN7DfVICJEmGJEE+C1S2YlTivnUZ7jOS/54ETG79HgBJn5PkoGJpUjvUpHlhy7d4jNS6DN4gmONrjy5LQiEJfIV8YtIvEpoG0R48pc4Xs5QtLcs4pMF00Zv3B3jhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974438; c=relaxed/simple;
	bh=ZxZV3TDFyleb86SarNtgHWoODXKqUlzNnZt4gPJsl+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FPlRZEnq/jjqrhaQh71r5Sjus3BmBsZ0hhRdN7kHU/3Ya6/CUOeQthLRS5rNP3BhD6Xt3qhA5qc58LMkXeLR0f//rtzMjWxuqbl/ztVKPLcKwFNePQKFBZDVGUIMXY8c5TTFuroOh6cw6f4BJkLyBOhoAQQbHd6AwkFrtOdqtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6ae34317b7eso673467eaf.1
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 17:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974435; x=1786579235;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXNbBpbB6EeM4W3a/x6PI9fwbf7x9crUiXQMnX5Ba3Q=;
        b=N1qL90QqD+JaX9/pgyuseEkGsW75DSpqgckiCpVPRIoAa/dcL+D3Bp7K9EKSpbOH9+
         QHt1Otq1F8Er188jUgZwxDdO7NmRFCd9TYE6gMaL1cSMpdhx/mGcUo4wzeC9zYLy5eNj
         kYPdfsmkXwUM8aaAa/W5OEUwWNPchDFmloznN4X2/XYrMTJYcbcnyaDQXtAMdwEuIPgW
         tSndbq/fP8IQYsO2YHab7X87ixlzGYng2BFtlaV1ovVLBaqmIilyy6Mvt3+GpYw6z4gZ
         cXo+ac2B0o6ybZWDppBDSZqZfMiBVPHPprn2+t09CzDEaVyjd2wLdSbMgfNJM7qE+b8e
         5FAg==
X-Forwarded-Encrypted: i=1; AHgh+RolRHWUyGOM3nxq3h4d8FbGaFSNeb6Mk8YsQxswN+qW3x1vZygp9Hs45JAblgpksaFjBZ+ULCVt2wZQGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2XpQGwhSumYeuM2jje8Mv85TQIx36uhh8Ju6+sUvoQDjg2Cx
	h07Lsxetgq3z4nSJKv1rFkwTDE1pPLPJyTXaCK+gDCjxpQkCe+BQvCYXm7DWIJUkDQjI5iBIatr
	Ife1ipOVcMvUYJJGOoksLh4/Fn5PL1v7EV/1sthcy2xkxM2am+Lm1YlufXGY=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b14:b0:6a3:7ad3:e728 with SMTP id
 006d021491bc7-6ae96f3a250mr4948396eaf.28.1785974434718; Wed, 05 Aug 2026
 17:00:34 -0700 (PDT)
Date: Wed, 05 Aug 2026 17:00:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73cea2.01d0871a.3a0d52.000c.GAE@google.com>
Subject: [syzbot] [usb?] [input?] KASAN: slab-use-after-free Read in sur40_open
From: syzbot <syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130a53b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=683f6c071b5abfc266c1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1557cbb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099fe32580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sur40_init drivers/input/touchscreen/sur40.c:352 [inline]
BUG: KASAN: slab-use-after-free in sur40_open+0x46c/0x500 drivers/input/touchscreen/sur40.c:397
Read of size 8 at addr ffff88807a69a000 by task udevd/5642

CPU: 0 UID: 0 PID: 5642 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 sur40_init drivers/input/touchscreen/sur40.c:352 [inline]
 sur40_open+0x46c/0x500 drivers/input/touchscreen/sur40.c:397
 input_open_device+0x24c/0x3d0 drivers/input/input.c:601
 evdev_open_device drivers/input/evdev.c:391 [inline]
 evdev_open+0x52f/0x690 drivers/input/evdev.c:478
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
 do_dentry_open+0x6ab/0x14d0 fs/open.c:947
 vfs_open+0x82/0x3f0 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2873/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06732a7407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fffba81d070 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0673a07880 RCX: 00007f06732a7407
RDX: 0000000000080000 RSI: 0000560bc61336f0 RDI: ffffffffffffff9c
RBP: 0000560bc6115500 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000560b97aa50c8
R13: 0000560b97aa50ce R14: 00007fffba81d670 R15: 0000560b97aabbcc
 </TASK>

Allocated by task 5634:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 sur40_probe+0x1a8/0x1580 drivers/input/touchscreen/sur40.c:675
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
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
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
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
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5634:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 sur40_probe+0xc36/0x1580 drivers/input/touchscreen/sur40.c:816
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
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
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
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
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807a69a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 freed 4096-byte region [ffff88807a69a000, ffff88807a69b000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a698
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe28140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe28140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4985, tgid 4985 (udevd), ts 22813655696, free_ts 18627306281
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x66d/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 tomoyo_realpath_from_path+0xb6/0x690 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2739
 do_dentry_open+0x588/0x14d0 fs/open.c:924
 vfs_open+0x82/0x3f0 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2873/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x586/0xd80 mm/page_alloc.c:1451
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:6897
 debug_vm_pgtable_free_huge_page mm/debug_vm_pgtable.c:980 [inline]
 destroy_args+0xa8/0x7a0 mm/debug_vm_pgtable.c:993
 debug_vm_pgtable+0x1d69/0x3490 mm/debug_vm_pgtable.c:1368
 do_one_initcall+0x11d/0x700 init/main.c:1347
 do_initcall_level init/main.c:1409 [inline]
 do_initcalls init/main.c:1425 [inline]
 do_basic_setup init/main.c:1445 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
 kernel_init+0x1f/0x1e0 init/main.c:1548
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88807a699f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a699f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807a69a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807a69a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a69a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
