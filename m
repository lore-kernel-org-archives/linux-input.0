Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFA1CAA78
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783300771; cv=none; b=MXHFqFAZHvmyIECBlC0rO7ocGx94CwVBAC/xWDcXc/5i8J61GEI2aqjQnMVHi/8Aj1iwNc+cwJGIozLNATAFtcEvwrxaYQtFNu3ttTXBmLvUl0pjOHWkV3tahAYSToRZcgZ0eDsOnv2uMM6e6GSHjGLLRoOpTRmnD1S5Jog3J8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783300771; c=relaxed/simple;
	bh=I/NkxZz5o38jEv6X0lcV9k6xlI1MXUrGdI7zgEEO14k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i91ccMWYZEXtijnFHAjC4d7PrGtElNBfztI5WzSOr5cyNvC+SAXSllfMAkMJ8/SdbwZfeQ+e0NB29m8mm/5UEpKkgYOx2X8aTjjWRAr2jKtj6d81CFJk2DrRw9bUEK/e2aEfBntOeXo+6CYco6Tyy1otlW9z9evEA5TW75vb7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-486cc29e03bso2952432b6e.3
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 18:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783300769; x=1783905569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAUt6Bbi85yFbjh/7KOZdJLeYmM40/k5N0XvknzUWlM=;
        b=qa5fjiKLQzIIruw1O0n6VO7yNFxH+gWD9ENg/GhazlVFidL1BNO1NCCOInuBFVfou7
         1mtGMsVfhIfe0WcqLn72D/Uub3WgeiIZdVzNvl9frLTQr8BbVx3KivNfmbY1HixgW14s
         /cHHlTt03iioLjgQeOReIE/zm4kwaJPffdMNEsEVeP+jJeFP7hNgs7qo77GXAvcpu70S
         /8GqbT/j75ov6FIb5qm4bsvNUL7dGAxFQkBETUn7BMX40K5EwUH+J9FYLZZHoy70dGFU
         YM8PlYqT5ociVeEpfhRlAAvG6/M0ZIi551nLJRh851GHvdGQ7cEHuF9CuMc/YBi6FkYR
         C1iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TsAkQ4p8k9Lj/VJRwlexQcrUKdOpXpDXQn3tbOkaN4uspGJ5f5LreAkD7NuZgbUBp+l5sSSnqShKWGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6BgsEGja2ZP0+iuNukXASjZhxrapwoWaBn8iPN/BB4tMY+ag
	X6BwKb/nbdS2F5JCov6K1ZEBYiKIkYdSmPc+4OFWfYmmeQ2lEwBtyaw6/9KfaAl4FcAHx91qzwm
	QeW3U+75DuuAweiQJjnMwjUQ12/tb19v37gktviMUTQz85DJmS8DK+A1hSAI=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2443:b0:497:df42:1df4 with SMTP id
 5614622812f47-499b666ab8bmr5199549b6e.9.1783300768806; Sun, 05 Jul 2026
 18:19:28 -0700 (PDT)
Date: Sun, 05 Jul 2026 18:19:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4b02a0.b42ede87.8bd1.0017.GAE@google.com>
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in str_to_user (2)
From: syzbot <syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=105fb11c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ec4d592e55f7960
dashboard link: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23fd2bbd359c/disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ffcad9a17ea/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c2fcc6db866/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in strlen+0x85/0xa0 lib/string.c:402
Read of size 1 at addr ffff888112fec220 by task syz.3.1096/9318

CPU: 1 UID: 0 PID: 9318 Comm: syz.3.1096 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 strlen+0x85/0xa0 lib/string.c:402
 __fortify_strlen include/linux/fortify-string.h:218 [inline]
 str_to_user+0x26/0xa0 drivers/input/evdev.c:769
 evdev_do_ioctl+0x1529/0x1b60 drivers/input/evdev.c:1172
 evdev_ioctl_handler drivers/input/evdev.c:1270 [inline]
 evdev_ioctl+0x16f/0x1a0 drivers/input/evdev.c:1279
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4fe1cdde59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4fe0737028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4fe1f65fa0 RCX: 00007f4fe1cdde59
RDX: 0000200000003d80 RSI: 0000000080404507 RDI: 0000000000000008
RBP: 00007f4fe1d73e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4fe1f66038 R14: 00007f4fe1f65fa0 R15: 00007ffc2d29e718
 </TASK>

Allocated by task 5308:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5362 [inline]
 __kmalloc_noprof+0x309/0x7c0 mm/slub.c:5387
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 usb_get_configuration+0x1ac/0x4410 drivers/usb/core/config.c:932
 usb_enumerate_device drivers/usb/core/hub.c:2527 [inline]
 usb_new_device+0x580/0x7d0 drivers/usb/core/hub.c:2665
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5418:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x43/0x70 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free mm/slub.c:6405 [inline]
 kfree+0x20c/0x650 mm/slub.c:6720
 usb_destroy_configuration+0x561/0x700 drivers/usb/core/config.c:896
 usb_release_dev+0x42/0x110 drivers/usb/core/usb.c:494
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1d0c/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888112fec000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 544 bytes inside of
 freed 1024-byte region [ffff888112fec000, ffff888112fec400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x112fe8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100041dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100041dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 16487694787, free_ts 14540795040
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf25/0x3400 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x28f/0x2b90 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab mm/slub.c:3408 [inline]
 new_slab+0xa2/0x670 mm/slub.c:3454
 refill_objects+0xe3/0x410 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 __do_kmalloc_node mm/slub.c:5361 [inline]
 __kmalloc_noprof+0x60d/0x7c0 mm/slub.c:5387
 _kmalloc_noprof include/linux/slab.h:973 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 __alloc_workqueue+0x1bd/0x1940 kernel/workqueue.c:5827
 alloc_workqueue_va kernel/workqueue.c:5946 [inline]
 alloc_workqueue_noprof+0xc7/0x130 kernel/workqueue.c:5962
 init_netconsole+0xf3a/0x1150 drivers/net/netconsole.c:2418
 do_one_initcall+0x11d/0x700 init/main.c:1347
 do_initcall_level init/main.c:1409 [inline]
 do_initcalls init/main.c:1425 [inline]
 do_basic_setup init/main.c:1445 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
 kernel_init+0x1f/0x1e0 init/main.c:1548
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 11 tgid 11 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x558/0xcb0 mm/page_alloc.c:1451
 __free_contig_range_common.constprop.0+0x12c/0x230 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0x126/0x1f0 mm/page_alloc.c:5257
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3439
 vfree mm/vmalloc.c:3488 [inline]
 vfree+0x107/0x750 mm/vmalloc.c:3462
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3392
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888112fec100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888112fec180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888112fec200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888112fec280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888112fec300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
