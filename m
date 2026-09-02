Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679C4A92CB
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375451; cv=none; b=ZFquRLg6C+B6SzpD2UPkI0KkOFCbIzoAJ7nl8zbCnTEdtsp5lTRS+/FFvZvoWuTAEPgslHTryBvddxJkWmwhSXjd3cT7uVsWmwim+Adq2s/API2ec29P/b3r1+TPvk5ia+SaocnwqkXirxRD3dxkt5DjQxM5NpJhgVw5TWFOMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375451; c=relaxed/simple;
	bh=kiesjv3DAnooB5mKW2mH3QVtjU/2LZnbgwV+XWb8zOM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ATfzHUbCqEjEgGHsGwTQE0mzM9/8/ZDLoR7d54MHicBVK9kEWN0spioXPqm3OBAM2Nf+azx/tcy+8C4rUUjR9f+NxjyNTlDcv9CC58bB1raDeZlED//y66r0Ben2CGNLJWogi1kbDH0p1uaXG+hY+VtAXchEX1Bb884wqP5rXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a4492f5cd1so130894b6e.1
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 11:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375448; x=1788980248;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXHpZOtfqy/6MQ0L0wo4gDzYilLZQj6Ff+oumc0GfnQ=;
        b=eG9pUmJVsn1MqczVE91ixSSx0rQrb3c6KqCqMBEWtPorO+rhTsJ80oA17pWnnWYbJ5
         tEy2ca/jGOFRqIa954A4ZiMHzEzcJlsf8S+MvaoZ5DDZqocynce7sPeb9Y0NrxPUQLKm
         aq7r/vjSn0/zxRBHB2zzWLBBnFh29FAKTDiTSCEisT9uoXW6n6gh1M5DuiTuvKryL7fj
         bLqKb0tFdVJ0WPToWM7ffgcbpxs1t2fPLT/5yIN/ysjcUFXZxzEM1/wzVjjO1GLOuD17
         Jvlx3GpUFBiAl3op933gLHMfmNuo6KQ/71mFz11A/UClPgpHlG79u1UUgdK2ABI2TH95
         QMww==
X-Gm-Message-State: AFuF++l72h1q1YOG9JRkx0EoCMC/dUKUCIo8qszbIofX0B80/0Ozir1r
	X8XmO/lBjtzbI9WovG7/tHMZS9f4D+iJLMHoKd+CCMfpIg283p2PBYLvBHYCnx80NqKtd/Cd7r2
	0kQbQuSBDaw+qn5sDB/sO+3jewkQlHE4e3KgYgIz15cbFnDrLfDXWqzgE4cCNPg==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1515:b0:6ae:ab01:9199 with SMTP id
 006d021491bc7-6b48222d424mr5180730eaf.34.1788375447625; Wed, 02 Sep 2026
 11:57:27 -0700 (PDT)
Date: Wed, 02 Sep 2026 11:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a987197.9266084e.bf0d7.000d.GAE@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in roccat_disconnect
From: syzbot <syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786262be6048 Merge tag 'edac_updates_for_v7.3_rc2' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14479f79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3e779580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c88125580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3e528ebf709/disk-786262be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46f3418d2828/vmlinux-786262be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60ab8a27c4f7/bzImage-786262be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in roccat_disconnect+0x246/0x250 drivers/hid/hid-roccat.c:382
Read of size 4 at addr ffff888040392808 by task kworker/0:2/197

CPU: 0 UID: 0 PID: 197 Comm: kworker/0:2 Not tainted syzk
CPU: 0 UID: 0 PID: 197 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 roccat_disconnect+0x246/0x250 drivers/hid/hid-roccat.c:382
 savu_remove_specials drivers/hid/hid-roccat-savu.c:110 [inline]
 savu_remove+0xe9/0x160 drivers/hid/hid-roccat-savu.c:150
 hid_device_remove+0xc8/0x1d0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 9:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 roccat_connect+0x5d/0x4b0 drivers/hid/hid-roccat.c:315
 savu_init_specials drivers/hid/hid-roccat-savu.c:84 [inline]
 savu_probe+0x18e/0x340 drivers/hid/hid-roccat-savu.c:134
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3065
 usbhid_probe+0x9dc/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x99a/0x1680 drivers/usb/core/hub.c:2708
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x28cf/0x4cf0 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5626:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6792
 roccat_release+0x2b3/0x380 drivers/hid/hid-roccat.c:238
 __fput+0x42a/0xa80 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1008
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1151
 __do_sys_exit_group kernel/exit.c:1162 [inline]
 __se_sys_exit_group kernel/exit.c:1160 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1160
 x64_sys_call+0x18c6/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888040392800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff888040392800, ffff888040392c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40390
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ffbbdc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ffbbdc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 997, tgid 997 (kworker/1:2), ts 104151206576
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x46f/0x680 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 roccat_connect+0x5d/0x4b0 drivers/hid/hid-roccat.c:315
 savu_init_specials drivers/hid/hid-roccat-savu.c:84 [inline]
 savu_probe+0x18e/0x340 drivers/hid/hid-roccat-savu.c:134
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
page last free pid 4949 tgid 4949 ts 104086626399 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x250/0x2a0 mm/slub.c:5815
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_node_noprof+0x3fc/0x660 mm/slub.c:5068
 __alloc_skb+0x1db/0x7a0 net/core/skbuff.c:704
 netlink_sendmsg+0x5d4/0xb40 net/netlink/af_netlink.c:1875
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888040392700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888040392780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888040392800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888040392880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040392900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
