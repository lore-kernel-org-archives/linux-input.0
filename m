Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EC2E401
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219653; cv=none; b=afjKkFG+zQfIJ8kFD6/or1qcRtvj4ieJIkQZ7RWtUgXCZdGGfyDn6RFGbt/ze4sWXfqmUtxgDpbvnykDpYW45H2t7UD7CZeAi0trqAuA5jpgEpZLe0SZ52lNwdQ1vVWu+tOTkZ9bVuxfcB8Xe786NIOWVFiX6iB7jN3hc31E1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219653; c=relaxed/simple;
	bh=G4llWDQ9kUCfEFMhmukLQHocHThdOaA51Sp7Z6uxBuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H5FvCMafTUrQGB4MrPygwwas/1uDNPgEuFJmbDIIasG3njpSUjdQDErYs0ms34U113Bjjx4BFWahPa4lXMQNMj60J7NRTTvjcKzzy2G8iQf0GdNS+GBn8C2yhWqb6Hgs/Sx0bqQUlm9NH4LEdY0aOta3nxu03LtEjqjdR/HKByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab4dd46ddeso394897b6e.3
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219650; x=1786824450;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOKcx8og/vzi2kWnyCOC3U9gzBKfuk51ZFJIQMBx+CA=;
        b=r0g6fQGpPbd61TOn+hJsmPc30WN+WfLQTX5jB+kEgS6yIpHkclApy4yeCBr3Fjnwo6
         IDzAstHNdCyXnl8JBxNEsyIo4P7qgzrBcRCzFfDiwD5iOBhmEhZOiFwVgqWdOgCIAwfo
         3vQVQ0BR6Ky+Dq1A4uP2RXAy85bOK/Fp1RF+/8ttbiTXlDV7xlN7pp0QcJdQzl/dduhZ
         A7OH6690eTkjcpdl5csh/foYjtFJ1YrWLo8Iu2LMXBGF6dhWJZ2H3vQfY9YMIYjUALC1
         r0bV4fGCakPuJjNJi2hQlG6mM+9lcIJ2ek446y5XneDbISgynPxLHXXVxwqRopKSmscZ
         znIA==
X-Gm-Message-State: AOJu0Ywn40QBAo+Nil2bY8i8WA5ovedz6qDLkLo60OKaG4VA2QrGLlw7
	gnO2MMI2ytDnqCCNSEE45Vbt1XhgLV0yiBFpcz3adxsW7kNW5s3jt7Eth0E7/gJfCl6b0oFNPW6
	qzkFd27Q48i6WcbyoECb/sXxbAZJY85H8NfMKoT1wAp6NXxngYQulFysrB+8LsA==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f88:b0:495:fa73:2e44 with SMTP id
 5614622812f47-4b1ab9fe7eamr5609664b6e.15.1786219650546; Sat, 08 Aug 2026
 13:07:30 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:07:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778c82.01d0871a.3a0d52.0069.GAE@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-out-of-bounds Read in hid_dump_input
From: syzbot <syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1265cfb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e8a402093abe6b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a942efa43c928a1e3daa
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13520fb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ccbe49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/137c48a5e559/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7597f78ad1c4/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a79fc123166/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com

hid-picolcd 0003:04D8:C002.0001: offset (1) exceeds report_count (1)
==================================================================
BUG: KASAN: slab-out-of-bounds in hid_dump_input+0xcb/0xd0 drivers/hid/hid-debug.c:3132
Read of size 4 at addr ffff88802ab28fc0 by task kworker/1:2/48

CPU: 1 UID: 0 PID: 48 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events fb_deferred_io_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 hid_dump_input+0xcb/0xd0 drivers/hid/hid-debug.c:3132
 hid_set_field+0xd3/0x440 drivers/hid/hid-core.c:1936
 picolcd_fb_send_tile drivers/hid/hid-picolcd_fb.c:112 [inline]
 picolcd_fb_update drivers/hid/hid-picolcd_fb.c:268 [inline]
 picolcd_fb_deferred_io+0x6d5/0x1880 drivers/hid/hid-picolcd_fb.c:403
 fb_deferred_io_work+0x1cf/0x310 drivers/video/fbdev/core/fb_defio.c:405
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 24:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kvmalloc_node_noprof+0x53f/0x860 mm/slub.c:6905
 hid_register_field drivers/hid/hid-core.c:133 [inline]
 hid_add_field+0x70a/0x1840 drivers/hid/hid-core.c:340
 hid_parser_main+0x2e1/0xd50 drivers/hid/hid-core.c:-1
 hid_parse_collections drivers/hid/hid-core.c:1291 [inline]
 hid_open_report+0x884/0xf00 drivers/hid/hid-core.c:1384
 hid_parse include/linux/hid.h:1206 [inline]
 picolcd_probe+0x177/0x16c0 drivers/hid/hid-picolcd_core.c:547
 __hid_device_probe drivers/hid/hid-core.c:2829 [inline]
 hid_device_probe+0x42c/0x7c0 drivers/hid/hid-core.c:2866
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3010
 usbhid_probe+0x9d4/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x653/0xc60 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3772
 usb_new_device+0x99d/0x1620 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802ab28f00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes to the right of
 allocated 176-byte region [ffff88802ab28f00, ffff88802ab28fb0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ab28
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe3e3c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 12816571384, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x485/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 usb_alloc_urb+0x46/0x150 drivers/usb/core/urb.c:75
 usb_internal_control_msg drivers/usb/core/message.c:110 [inline]
 usb_control_msg+0x118/0x3e0 drivers/usb/core/message.c:167
 usb_get_string+0xa2/0x3e0 drivers/usb/core/message.c:902
 usb_string_sub+0x76/0x420 drivers/usb/core/message.c:941
 usb_string+0x34f/0x790 drivers/usb/core/message.c:1046
 usb_cache_string+0x7d/0xf0 drivers/usb/core/message.c:1090
 usb_enumerate_device drivers/usb/core/hub.c:2537 [inline]
 usb_new_device+0x27c/0x1620 drivers/usb/core/hub.c:2665
 register_root_hub+0x250/0x5c0 drivers/usb/core/hcd.c:990
 usb_add_hcd+0xac7/0xf80 drivers/usb/core/hcd.c:2987
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802ab28e80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88802ab28f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802ab28f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff88802ab29000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802ab29080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
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
