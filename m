Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AD3CB574
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822053; cv=none; b=pltJR11atJojWDirgXJ4y57u/jW6QZ0GucLroj9S4Xg5uxVFv7dEAN8mV3EpPgGGfxUjXbXQf7h3eyOa3eoeRq44ui9vHvig8Ge2+/x2/OsZN5U5lRGMfPZG7PS+3+3QSnsOHFqrbkfJcHqeg9GZ1XSmwHDqwKLrAyNENzUTxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822053; c=relaxed/simple;
	bh=J4xn9O+g2OZ4L5d1a1jzA/HlAmJ24kHi6bA8ODY8FwU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XDkEi5KRUU7DzcrDwtXpl2pJxvMUDzRTjRFIsNbXrIwsyI7jlPU3xbHhbGoAOXWZzCNTW2aSvwcGeKX+QkQ3gvdDXAFw5oHi4GyYwbiqzvx+iBz3Sbq29jmOqg6jzLjSe+Z2UU/afKphrb1bf2uvQiGlWskpPGUPuK2v/sfK130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-485ebc5706cso1449872b6e.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 02:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822042; x=1788426842;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tupVC5CtadLwyxSFxoKFPPFEOJCSsdKyeBUr2+76O2k=;
        b=DCioN3rTXFgdHSTJ5uGzxhOoIBlTXyAHtdG7Dg/iB4ZqZ6xmf46ZbUuKdGueD8yD7+
         3yrNPvfCXEkh8vzepIcF8wmq6aWCaKDlKeOMTjQEay9/X35XcMf8+iv4wZrzM2xR+ngg
         Dp8WrcJcoh3ersxLAKWRag1rUeX/1F07hvw8AvxMSnDk/C1GIPVICfCACzq5eCkbp1j4
         jgygGUFinvfMf17v7HdmAbUgAXkE0BfDBmwc5IUa37voQfntDeyK2BYut8hBt3UXEwFh
         KCU0sfM65981oXR07PSd2NWAlE2nEdoavq0kLGSeXhmCWUN92j8ibvLMctSb87ufAcsT
         78og==
X-Forwarded-Encrypted: i=1; AHgh+Rp5WGeObtJdlzV6FW7iThidOGzDJD3Np2UQeI9qeVdtQcLxDXJQNMI/8Bx7jN1aGoaH8OT/fnQJFGydsg==@vger.kernel.org
X-Gm-Message-State: AFuF++ls7+KzNQl4puYHEfX1oN5p1vn4r/YNy1yOFDjQmWgWejxppx27
	9F9IqWUkran2d23aDB1pzzrXfXJv7tuotmpaRQ1XU8XwDSvFaLUvqwV2WKKFPdy7+V28oNfCSl5
	1ummlEHJ35a4/vItIOPa0xf+YKroaI4MlK7pBOExYayTMLBQnMPzrfKyYJXg=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c4:b0:4b3:18d2:5fa0 with SMTP id
 5614622812f47-4b37ca840ddmr4641202b6e.14.1787822042334; Thu, 27 Aug 2026
 02:14:02 -0700 (PDT)
Date: Thu, 27 Aug 2026 02:14:02 -0700
In-Reply-To: <20260827081639.17185-1-jeffinphilip14@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8fffda.1d9ded08.62e62.00ca.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in roccat_open
From: syzbot <syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com>
To: jeffinphilip14@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in roccat_disconnect

==================================================================
BUG: KASAN: slab-use-after-free in roccat_disconnect+0x23d/0x250 drivers/hid/hid-roccat.c:383
Read of size 4 at addr ffff888077548808 by task kworker/1:6/6493

CPU: 1 UID: 0 PID: 6493 Comm: kworker/1:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 roccat_disconnect+0x23d/0x250 drivers/hid/hid-roccat.c:383
 savu_remove_specials drivers/hid/hid-roccat-savu.c:110 [inline]
 savu_remove+0xe9/0x160 drivers/hid/hid-roccat-savu.c:150
 hid_device_remove+0xc5/0x1c0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5753:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x600 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 roccat_connect+0x5d/0x4a0 drivers/hid/hid-roccat.c:316
 savu_init_specials drivers/hid/hid-roccat-savu.c:84 [inline]
 savu_probe+0x18e/0x340 drivers/hid/hid-roccat-savu.c:134
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3065
 usbhid_probe+0x9d4/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2708
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6614:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6792
 roccat_release+0x2cb/0x3e0 drivers/hid/hid-roccat.c:238
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077548800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff888077548800, ffff888077548c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77548
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ff15dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813ff15dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5647, tgid 5647 (syz-executor), ts 102104974711
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x47b/0x720 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 tomoyo_init_log+0x1aae/0x1fa0 security/tomoyo/audit.c:273
 tomoyo_supervisor+0x35f/0x1560 security/tomoyo/common.c:2232
 tomoyo_audit_path_log security/tomoyo/file.c:169 [inline]
 tomoyo_path_permission+0x262/0x3b0 security/tomoyo/file.c:592
 tomoyo_check_open_permission+0x2b2/0x470 security/tomoyo/file.c:782
 security_file_open+0xa9/0x240 security/security.c:2739
 do_dentry_open+0x4a0/0x1380 fs/open.c:973
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
page last free pid 5635 tgid 5635 ts 102024326874 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xc93/0xd90 mm/page_alloc.c:2962
 __slab_free+0x274/0x2c0 mm/slub.c:5815
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x2b9/0x600 mm/slub.c:5010
 ext4_inode_attach_jinode+0xea/0x1c0 fs/ext4/inode.c:4575
 ext4_file_open+0x3f6/0xab0 fs/ext4/file.c:990
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888077548700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077548780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888077548800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888077548880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888077548900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         903c1cf6 Add linux-next specific files for 20260821
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb5625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbaf6d30cb97db
dashboard link: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17924579580000

