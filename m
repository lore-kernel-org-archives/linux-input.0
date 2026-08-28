Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B8175A64
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877874; cv=none; b=UJsOBBnlovPDXHFq8amiq/m1CMzp5EQYzwA8KpmNZnYpUlJX1nglHJSePdWXZJsbQHFj95aOzh6vjkJx/KjUQf9cObZ0yQbSHrzFCrm1Pb3eMFj/hn8mqRKRGdcE9BwFZfx/dOnrHbzzHgxVAmJ2WFqdBHJcuVIM5ayLaDpWDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877874; c=relaxed/simple;
	bh=oDdOcM4c0PUxV9fZcTCLGXYh0paK5Qe+z032CMgCLvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=raAq//kZiWWg7SdZkssPxA/diWxFHn9GyNrXbJjCKPAn2Z44si+b1mvbkqp7SZ7d6BRgt52nYBopTmsFvq2deZahu13M3X3EnBR8nDFNnGH/At/RVEktJ7p6p9Gj4m41dqHePvvIenSlqh4Mc71IQVFRKLU5/+l2LDSe6FNlAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-4b374c2cf2cso58086b6e.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 17:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787877872; x=1788482672;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gse5OUdJ0qL//gU6TWSciLnOHTIyR7Cfo69Pd4BBSc=;
        b=mjeKR1SuGgUviMNcVqqH9R3q+qgwmi767WVeBakRJ9uNdjhN4E7AeWDq54PinZ8a+H
         r2c5B6TN94x0xiL5WjcTYlFfqdYcFGS01H+xQlolkKjoEaD0MTHw+8C5f51I4j+pIiyX
         vv8O7usPw7vNvhu9o2Rg4+Di8F/0kXApqkMG4/gfQvD5h07yDWF5jQGQT30MwEdVU40a
         K0PJEZVioJvdhojJBJOs//8QhFbnmCNJjxqdPtgnrRIhMda1nTARVxofT1eITOHBVAjR
         rX/0gDJRL9aEjoHM0QzNx7ZD4EqYgGXu5/TBY2GGjq98eyK4tQGhNfmUyBOwOcsL1tgr
         aHHw==
X-Forwarded-Encrypted: i=1; AHgh+RqgNxusLLjg3E0nrBoyiqDvPYUe4hPW/RdRVvPFeFQDOQ9WLBbm/XxB29dtrM4iDydMHvNOApQ5GPByaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mWTtNjNBQ8Znbu50mVqzAeq/fECWCfp3NzcxnhwZaetCdsFC2z
	PbncNqHlYx9wHkl4+dB0xksoe2vxl9oPZh8Gw6LP4lo09E9OM+jQ/H71nQMlNDXlJDhe2adNhFk
	zhSdm2cKAiIWEO3HzpY3Zx23d587erjYHp9sIFcQ99CoNOgHDIo0UevsupMQ=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0b:b0:4ab:318c:6b38 with SMTP id
 5614622812f47-4b397f71712mr3424821b6e.1.1787877872000; Thu, 27 Aug 2026
 17:44:32 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:44:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
From: syzbot <syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12982979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a23a38e38809c577
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a022f59dd04/disk-66498c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90c31928a9a3/vmlinux-66498c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd7c7f0fb67e/bzImage-66498c75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in atkbd_set_repeat_rate.isra.0+0x44a/0x4e0 drivers/input/keyboard/atkbd.c:578
Read of size 4 at addr ffff888029cda164 by task kworker/1:1/29

CPU: 1 UID: 0 PID: 29 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Workqueue: events atkbd_event_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 atkbd_set_repeat_rate.isra.0+0x44a/0x4e0 drivers/input/keyboard/atkbd.c:578
 atkbd_event_work+0x12c/0x160 drivers/input/keyboard/atkbd.c:640
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5718:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 input_allocate_device+0x44/0x350 drivers/input/input.c:1960
 atkbd_connect+0x9e/0x9c0 drivers/input/keyboard/atkbd.c:1258
 serio_connect_driver drivers/input/serio/serio.c:44 [inline]
 serio_driver_probe+0x77/0xa0 drivers/input/serio/serio.c:748
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 serio_add_port drivers/input/serio/serio.c:512 [inline]
 serio_handle_event+0x593/0x970 drivers/input/serio/serio.c:197
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5984:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6792
 input_dev_release+0xab/0xd0 drivers/input/input.c:1644
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 input_put_device include/linux/input.h:391 [inline]
 input_unregister_device+0xd8/0x110 drivers/input/input.c:2492
 atkbd_disconnect+0xcb/0x150 drivers/input/keyboard/atkbd.c:966
 serio_disconnect_driver drivers/input/serio/serio.c:62 [inline]
 serio_driver_remove+0x7b/0xa0 drivers/input/serio/serio.c:755
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 serio_unregister_port+0x23/0x40 drivers/input/serio/serio.c:679
 userio_char_release+0x91/0xe0 drivers/input/serio/userio.c:105
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029cda000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 356 bytes inside of
 freed 4096-byte region [ffff888029cda000, ffff888029cdb000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29cd8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c030140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801c030140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4964, tgid 4964 (udevadm), ts 21467278812
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35b0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 selinux_genfs_get_sid security/selinux/hooks.c:1341 [inline]
 inode_doinit_with_dentry+0x7b1/0x1340 security/selinux/hooks.c:1565
 selinux_d_instantiate+0x26/0x40 security/selinux/hooks.c:6685
 security_d_instantiate+0x14c/0x1b0 security/security.c:3703
 d_splice_alias_ops+0xd7/0x15b0 fs/dcache.c:3249
 kernfs_iop_lookup+0x23f/0x2d0 fs/kernfs/dir.c:1288
 lookup_open+0xa79/0x1990 fs/namei.c:4528
 open_last_lookups fs/namei.c:4767 [inline]
 path_openat+0xa2c/0x2440 fs/namei.c:4997
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
page last free pid 4964 tgid 4964 ts 21458354491 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __kmalloc_cache_noprof+0x278/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kernfs_fop_open+0x23d/0xd50 fs/kernfs/file.c:634
 do_dentry_open+0x6ab/0x14d0 fs/open.c:996
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029cda000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029cda080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029cda100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888029cda180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029cda200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
