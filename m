Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E823D5643
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036006; cv=none; b=GmBskbPSs+pWoZd6sjtm7SxsIz9rBetCF9OBLG385yinjDxKBo/sFfL9ZkJ8y9wb2i0YbhaqdfFfWYU4KdSoh53Io7eYLS2x3agAMZyYL81CLooYM/2Yypou+2mxpsYpBE9y/ETb6dpCCuWYtCrjFUogDZxGIUtj3/EMFqHv4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036006; c=relaxed/simple;
	bh=xDz8HnxtoSS7BvkCxUqPFCO0G7r4f6HDRA2qgtkA9v4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H8QS8ZeElR7Qiw/AipB1Ss5vKMeBTzBEc80CS89DeX4hg30COvHRzO97IglNORHyej/NQADC8RRV6MAcrkbpCBPWa9wEB6KzHXpl3HOtl3E/jHWqeLHdu5Q7idTczSe0fBGqchJidOjjpPuhAhkWHPo99trNa8KcdVvK0WHN9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d7fd0be5e3so1875207a34.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036001; x=1775640801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+npAoHfDDyMlZp8Vlbt+ESblko0cyD5GzzlpK9zwZU=;
        b=JmUR7UWOCzNrJFeQvrd+3dvpb2fOqXoQNCYMA73Wka7MBQ9nG+M8dsU4soQ2KqHiYy
         tAX7/UMxkB+fdVeCZvmxsABin4ND6HFom1D+N3/IDQexzC8O31+7uLizZLM9uuRqbYKJ
         7KBJGE+jSGenuHMrreqpnj0+bekdU5n3U6b/aVwmFJCkLwOnBBuD0EIw+pRfIv7ZiXSX
         t4/rcSE0mQ55BLSTZsMMmY8Y6gNViHT4VX/ouYhpD6NewXQnWlJLrGuA1EwGXbk6TrkE
         y748nimgqxs6SUMP8lAnJg0wQ7MRPFZcdBGvuG3xUHh3I6rTJO0lamyBtbANFyyo6iFc
         fN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+E0RdTW+jMNtr981uH10Z7erh438ejgKSTc+Whf+bRkI78KVQ+GomhzGMClQats9Vb7QeU12s8LN6Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaWszsHD7w95tDvYy4d1eBd8D+C1mEPE0vLjcE88oF2cUDTiA
	A2HWEN38nzgYAIZqFGxxUDlaf5A3N/Odg4BwCwBmUo2fXzg4XSVIkIUw05rULX2HSM810NqEccx
	k7iUUrKtPfvNazjy4ZCQ5hswjByP7LS9sYXrZQb+Vz1BAw91aBLN9DMhd4cI=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d8c4:0:b0:67b:b738:59b4 with SMTP id
 006d021491bc7-67e3d95fa0emr3416551eaf.32.1775036001170; Wed, 01 Apr 2026
 02:33:21 -0700 (PDT)
Date: Wed, 01 Apr 2026 02:33:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cce661.a70a0220.97f31.02b0.GAE@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in
 hiddev_disconnect (4)
From: syzbot <syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    46b513250491 Merge tag 'v7.0-rc5-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177c11da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-46b51325.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22fdb6baf246/vmlinux-46b51325.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3a69d9008ed/bzImage-46b51325.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com

usb 6-1: USB disconnect, device number 25
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x23b/0x260 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff8880289f981c by task kworker/1:3/6000

CPU: 1 UID: 0 PID: 6000 Comm: kworker/1:3 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x23b/0x260 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
 __mutex_unlock_slowpath+0x18b/0x790 kernel/locking/mutex.c:963
 hiddev_disconnect+0x15b/0x1d0 drivers/hid/usbhid/hiddev.c:940
 hid_disconnect+0xbe/0x1b0 drivers/hid/hid-core.c:2353
 hid_hw_stop drivers/hid/hid-core.c:2400 [inline]
 hid_device_remove+0x1b2/0x270 drivers/hid/hid-core.c:2834
 device_remove+0xcb/0x180 drivers/base/dd.c:631
 __device_release_driver drivers/base/dd.c:1344 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1367
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:657
 device_del+0x376/0x9b0 drivers/base/core.c:3880
 hid_remove_device drivers/hid/hid-core.c:3009 [inline]
 hid_destroy_device+0x19c/0x240 drivers/hid/hid-core.c:3031
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1477
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:633 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:625
 __device_release_driver drivers/base/dd.c:1344 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1367
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:657
 device_del+0x376/0x9b0 drivers/base/core.c:3880
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1476
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1d0c/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 24:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 hiddev_connect+0x259/0x5d0 drivers/hid/usbhid/hiddev.c:893
 hid_connect+0x241/0x1750 drivers/hid/hid-core.c:2267
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2380
 plantronics_probe+0x2b9/0x3a0 drivers/hid/hid-plantronics.c:209
 __hid_device_probe drivers/hid/hid-core.c:2776 [inline]
 hid_device_probe+0x50e/0x800 drivers/hid/hid-core.c:2813
 call_driver_probe drivers/base/dd.c:643 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:721
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:863
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:893
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1021
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1093
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1148
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x11d9/0x1950 drivers/base/core.c:3691
 hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:2952
 usbhid_probe+0xd57/0x1350 drivers/hid/usbhid/hid-core.c:1450
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:643 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:721
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:863
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:893
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1021
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1093
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1148
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x11d9/0x1950 drivers/base/core.c:3691
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2266
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:643 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:721
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:863
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:893
 __device_attach_driver+0x1df/0x340 drivers/base/dd.c:1021
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1093
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1148
 bus_probe_device+0x64/0x160 drivers/base/bus.c:613
 device_add+0x11d9/0x1950 drivers/base/core.c:3691
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 11803:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1f6/0x6b0 mm/slub.c:6483
 hiddev_release+0x40d/0x520 drivers/hid/usbhid/hiddev.c:232
 __fput+0x3ff/0xb40 fs/file_table.c:469
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x67c/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880289f9800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 28 bytes inside of
 freed 512-byte region [ffff8880289f9800, ffff8880289f9a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880289f8c00 pfn:0x289f8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b842c80 ffffea0000b3f710 ffffea00015f9410
raw: ffff8880289f8c00 0000000800100008 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b842c80 ffffea0000b3f710 ffffea00015f9410
head: ffff8880289f8c00 0000000800100008 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000a27e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 10245, tgid 10245 (udevd), ts 189371739713, free_ts 189294134261
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x111d/0x3140 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x27c/0x2ba0 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab mm/slub.c:3481 [inline]
 new_slab+0xa6/0x6b0 mm/slub.c:3539
 refill_objects+0x26b/0x400 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x1ab/0x660 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __kmalloc_cache_noprof+0x493/0x6f0 mm/slub.c:5375
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 kernfs_fop_open+0x23d/0xd50 fs/kernfs/file.c:641
 do_dentry_open+0x6d8/0x1660 fs/open.c:949
 vfs_open+0x82/0x3f0 fs/open.c:1081
 do_open fs/namei.c:4671 [inline]
 path_openat+0x208c/0x31a0 fs/namei.c:4830
 do_file_open+0x20e/0x430 fs/namei.c:4859
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 11125 tgid 11125 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7e1/0x10d0 mm/page_alloc.c:2978
 stack_depot_save_flags+0x435/0x9d0 lib/stackdepot.c:735
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 ida_alloc_range+0x464/0x830 lib/idr.c:420
 ida_alloc include/linux/idr.h:293 [inline]
 create_worker+0x99/0x750 kernel/workqueue.c:2796
 maybe_create_worker kernel/workqueue.c:3075 [inline]
 manage_workers kernel/workqueue.c:3152 [inline]
 worker_thread+0x8e2/0xe50 kernel/workqueue.c:3415
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880289f9700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880289f9780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880289f9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880289f9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880289f9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
