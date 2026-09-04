Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1A3E9C17
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528209; cv=none; b=WnBBbO43CbFBsNjFiRfRUNrn9qtuAPaVklLY8EiE7AbIuY4bdpKQ3shVpM6kF5VjofDbNdbr05x9ILsS9GaDtrjpFwho1rrxqh/RF3bD6xJGMJMmvHoW6G8KJdMXfD5fNVe48RMVMjJo/B+8pG8tZepIkp2eh15eW5qcDJ93bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528209; c=relaxed/simple;
	bh=/ZMGV+Tq9YQEhi5E0fB9Px8KIpMbJDnj2xN/sZO4mIs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i6FWz7HGpCjryNo+r9jKyO2+B7o7PNS0cdZ0XIaBLb9si5KPoShkow64ktxv9s0208CsYuN/+hIFT9p/X+azTzOiQtYZKs3E/41TGVfqyO2CVoK0FUhjgw6r1OTsWHGhR3LsxN7JOxcORiUWlVUs8BqUqog2uNpS3XcfiUxUUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6b1b27d7ab2so1483683eaf.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528207; x=1789133007;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tPWs0J/yR1/MDs2tl/WtpFPxtDIZv/lubzYq38C2/30=;
        b=Zmlje2JTfQeWWqBdPMoPT67oFDynw2xSw6u+dwdf9/bhTy5NKj4Si0MRSv3ZGfkAAS
         v+RyRh1XP4OP2i+vWra5Ly3dJ5QNBsi7hO+Xp4sc8lQ80MEPnopHxV6IH7bscXjIQqrO
         6RMGNY5O8dFGCF8aku4FIW2dgidiB5GLppvZnmPeglRB9whrJvKQO4wIp4crhi75W5MS
         CRVb7qiTvF3k2huNJC3In/rh2TmEVBhxXOpvuWQmlPQMI3LGKeVp0swbkDX20Li2lfbu
         /l8cUB+H3UxWxCSIkzcyScYdUI9JPGHSMwge2YgMEMDk0tPuX/DvxR9cFFEhzLb2mMXl
         K6MA==
X-Forwarded-Encrypted: i=1; AKwUvByoI1xsTJpIz/w28AwVY/bfhf4fpJ4HafiTDYv837L6UpdUy0T4PvVWub/dAwb3eTnNnP9qHu7uc3MPBQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kfmNDEJNe5JGxdNJTHKZNG8TNVZ0d8F9yPmydssDSWyUi8JUNo
	C5byxOFYlRj5oI4epLwuFIBjEr1tIe1FJ8HeXaoU6WPZXUPayvLXhlcifJi2w7oxEKkgwr3mxzf
	+b3by4+QlwVvDmcHI83JqIClyXFl736ccY5aAy9s1+CyQVnME48jywvHqSms=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:603:b0:6b7:46fa:168f with SMTP id
 006d021491bc7-6b746fa1a3emr2540327eaf.36.1788528206725; Fri, 04 Sep 2026
 06:23:26 -0700 (PDT)
Date: Fri, 04 Sep 2026 06:23:26 -0700
In-Reply-To: <6a8fd9c8.50659fcc.60cd.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ac64e.04649fcc.10325f.0001.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in roccat_open
From: syzbot <syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com>
To: bentiss@kernel.org, dmantipov@yandex.ru, jeffinphilip14@gmail.com, 
	jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bc35965f6940 Merge tag 'mm-hotfixes-stable-2026-09-03-17-4..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14be38f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d628f9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:625 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x15c5/0x1bd0 kernel/locking/mutex.c:821
Read of size 8 at addr ffff88803681f0d8 by task syz-executor287/6028

CPU: 0 UID: 0 PID: 6028 Comm: syz-executor287 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:625 [inline]
 __mutex_lock+0x15c5/0x1bd0 kernel/locking/mutex.c:821
 roccat_open+0x105/0x660 drivers/hid/hid-roccat.c:178
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
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
RIP: 0033:0x7f0b937c669e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f0b92f51158 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0b92f516c0 RCX: 00007f0b937c669e
RDX: 0000000000000000 RSI: 00007f0b9380e896 RDI: ffffffffffffff9c
RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000002 R14: 00007ffcc54aca60 R15: 00007ffcc54acb48
 </TASK>

Allocated by task 5880:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 roccat_connect+0x57/0x530 drivers/hid/hid-roccat.c:315
 savu_init_specials drivers/hid/hid-roccat-savu.c:84 [inline]
 savu_probe+0x222/0x310 drivers/hid/hid-roccat-savu.c:134
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x4fe/0x850 drivers/hid/hid-core.c:2878
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
 hid_add_device+0x2bf/0x440 drivers/hid/hid-core.c:3065
 usbhid_probe+0xa64/0x10b0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
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
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
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
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
 usb_new_device include/linux/workqueue.h:715 [inline]
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event.cold+0x1e3/0xe90 drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6028:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6792
 roccat_free_device drivers/hid/hid-roccat.c:79 [inline]
 roccat_release+0x3b4/0x4c0 drivers/hid/hid-roccat.c:238
 __fput+0x3ff/0xb50 fs/file_table.c:512
 fput_close_sync+0x118/0x250 fs/file_table.c:617
 __do_sys_close fs/open.c:1560 [inline]
 __se_sys_close fs/open.c:1545 [inline]
 __x64_sys_close+0x8b/0x120 fs/open.c:1545
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803681f000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 216 bytes inside of
 freed 1024-byte region [ffff88803681f000, ffff88803681f400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803681c000 pfn:0x36818
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801c042dc0 ffffea0000d30210 ffffea0000df4c10
raw: ffff88803681c000 000000000010000c 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801c042dc0 ffffea0000d30210 ffffea0000df4c10
head: ffff88803681c000 000000000010000c 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5793, tgid 5793 (syz-executor), ts 51017986373
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kvmalloc_node_noprof+0x7bb/0x9b0 mm/slub.c:7005
 bucket_table_alloc.isra.0+0x88/0x460 lib/rhashtable.c:196
 __rhashtable_init_noprof+0x43a/0x890 lib/rhashtable.c:1214
 ipc_init_ids+0x99/0x280 ipc/util.c:120
 msg_init_ns+0x13d/0x190 ipc/msg.c:1320
 create_ipc_ns ipc/namespace.c:84 [inline]
 copy_ipcs+0x59c/0x7e0 ipc/namespace.c:116
 create_new_namespaces+0x20a/0xac0 kernel/nsproxy.c:112
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
 ksys_unshare+0x4a2/0xa70 kernel/fork.c:3292
 __do_sys_unshare kernel/fork.c:3356 [inline]
 __se_sys_unshare kernel/fork.c:3354 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3354
page last free pid 5138 tgid 5138 ts 50994111388 stack trace:
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
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 alloc_filename fs/namei.c:147 [inline]
 do_getname+0x35/0x390 fs/namei.c:187
 class_filename_flags_constructor include/linux/fs.h:2586 [inline]
 do_readlinkat+0xa9/0x370 fs/stat.c:569
 __do_sys_readlink fs/stat.c:605 [inline]
 __se_sys_readlink fs/stat.c:602 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:602
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803681ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803681f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803681f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88803681f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803681f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
