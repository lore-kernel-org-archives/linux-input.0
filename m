Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECF4483A2
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917396; cv=none; b=is3LqZvU6VudKE+Qrc/ppp2eMAFGr03S27YQhKFdR1jyvvaH7KicC2ewvAdJjOfACAS10zfhQrFUsc/9gkLoiAcP/5eC0LMnFRwQXAL4WN0inmBxWf9wwLH/h+SqPtCIzVzs+iTl7e5FqNUQN5DZVfe2/5ZwKMwjm+V2fKjbuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917396; c=relaxed/simple;
	bh=ef7ZesCxSn0UAqAsUP7quYBNtDufJnreDTiG6tntL98=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kjzLtkab1AdCpSt7Gi5PZPf1AxnZBx/m426rxZMdDhOM/OBtbYZE1NA/AkjjaCMNy9IjT+jFXgEta8WeNuuRHREAvx2c7m44bZ1ajKkdnzizhq07y2YCm3aRsFHKotbOtGa3H4lUk6oelqV3pBhSk6N5EW1OLVm/A7JTKo47vY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b1bc2e44e0so1716472b6e.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 04:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917356; x=1788522156;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VjVdg7BHNNwNl/12s/lE6xqu37UNm7gWTS+U6geXli0=;
        b=HPq2XphEQKPjbxsgqpaIoLckEuMkjGLAFO4ushv7acwKW7KRaivntaJ8YP9w1nS3ov
         FkSiUuymnAPLqtYQ+zl6MYDpJjBUZzkoBFuGP5ELabGd5Nga8CbN6SkS1/sdytMEFeiD
         dROIRi/6qmsdf9/chBn6qjZz7ioBrHzfBYWDF+9WcWAltM8j3uBbCCJF0v7RWY52D/Ub
         qmAbg32yhy1O4Xp7j4zuoqTv48Mf1r0g1VW6MrgY+UKOPnzXIly+/dhQ0H41RTus/ySi
         QBziuEj0cT+efF8CYkgNVW7RkFaVjGXkWmDSQfHSj28MZOBdEd4C5uudc2O0b1rppQWN
         uF9w==
X-Forwarded-Encrypted: i=1; AHgh+RpYdrMIae450maH9rA6B7kY3L+ABGoi+V1fBoqtsF8ovWeLbQcLrwZaLkop8sTo2Z1O3bGZlUPnpk5StA==@vger.kernel.org
X-Gm-Message-State: AFuF++lDJlfhqcFdsb80jvk8NdIyVI59JN4YTlFMfNVGjjHSOmMIkhCP
	Ptsf54pIUGkQrGZYM60DqA8cYPjModdNuV9x5ARHY8804IDiGCNDDHWemf18Lnk741uYuncI1FG
	wM3yArJRHssf+Z1UujiqM1k2mcgbOW++xQF/TIgEvuDmzT8tt8zQ3+Wgzk2Y=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:87d3:b0:4b3:8bdc:30fc with SMTP id
 5614622812f47-4b3981cff2amr6926561b6e.11.1787917355816; Fri, 28 Aug 2026
 04:42:35 -0700 (PDT)
Date: Fri, 28 Aug 2026 04:42:35 -0700
In-Reply-To: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a91742b.1d9ded08.62e62.00ea.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in atkbd_set_repeat_rate
From: syzbot <syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, jeffinphilip14@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1237fd79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f75d79580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in atkbd_set_repeat_rate.isra.0+0x44a/0x4e0 drivers/input/keyboard/atkbd.c:578
Read of size 4 at addr ffff888036712164 by task kworker/1:2/850

CPU: 1 UID: 0 PID: 850 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
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

Allocated by task 29:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e7/0x6b0 mm/slub.c:5484
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
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

Freed by task 6032:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2678 [inline]
 slab_free mm/slub.c:6372 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6687
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
 fput_close_sync+0x118/0x250 fs/file_table.c:617
 __do_sys_close fs/open.c:1560 [inline]
 __se_sys_close fs/open.c:1545 [inline]
 __x64_sys_close+0x8b/0x120 fs/open.c:1545
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888036712000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 356 bytes inside of
 freed 4096-byte region [ffff888036712000, ffff888036713000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36710
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c043040 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801c043040 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5138, tgid 5138 (udevd), ts 23156728902
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35b0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3267 [inline]
 allocate_slab mm/slub.c:3382 [inline]
 new_slab+0xa5/0x640 mm/slub.c:3428
 refill_objects+0xe3/0x410 mm/slub.c:7305
 refill_sheaf mm/slub.c:2805 [inline]
 __pcs_replace_empty_main+0x372/0x680 mm/slub.c:4677
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4907 [inline]
 __do_kmalloc_node mm/slub.c:5336 [inline]
 __kmalloc_noprof+0x66b/0x820 mm/slub.c:5362
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 tomoyo_realpath_from_path+0xb6/0x690 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2739
 do_dentry_open+0x588/0x14d0 fs/open.c:973
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
page last free pid 5139 tgid 5139 ts 23149284278 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4586 [inline]
 slab_alloc_node mm/slub.c:4919 [inline]
 kmem_cache_alloc_noprof+0x26b/0x6a0 mm/slub.c:4933
 alloc_empty_file+0x5b/0x1c0 fs/file_table.c:262
 path_openat+0xdb/0x2440 fs/namei.c:4986
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
 ffff888036712000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036712080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888036712100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888036712180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036712200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
