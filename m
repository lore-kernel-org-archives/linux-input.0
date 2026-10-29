Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277874;
	b=VGdBQn3X1AxdmHa8nOcEBApBcMtGnuL/BsIDu9sL73ey5Y+W/ItkrG74kxromgGQGSXU
	 Bw/+FsHjZh9kVn7FHiR/nRIi8YCrDPvhPkRaekiTElF//fo0wi5rHHEMjwSlKChCIAfhh
	 XNhDs2rje6Ilhn4RSOR5xsGfQmHaI531hhIsRXQvG2YZHDKxuNongB1kUTCRtnv8ZBKgm
	 t7NGLmvoitcJQkKPRA25rNAFbYHKjASBxaqoCr4GFuzf6S/1GjSTYwm1xU3jSqfiQoU1l
	 Q84YXV96Kk35yHdcwuWtIufXCZRUNnp57oC7eAdGvqnbVSHFUsbmQyFe3cFhBS2pVrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277874;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=FovyKoW229/ssIodbKSmr878FfMZGbrQjeq+W9gevBU=;
	b=E1Xbi6Dx1s+f+xam9YKCYHpo+xQgzDU7hC20rqQEfeyXB4oV2r1cXTRRMZx5p8mRtlAc
	 uhhJ1knL/H6yY2BKDZbRo5xZbLnrOWsxUaY9sbT0SA1ECd8WHqWltB4frzhYcmOlQzVKG
	 c65js7OavkJ4N40J0TUhauvJOUPOI0bbXvvyf7kNl3AfN7V+jDo/UZRpCH1O9vbGMnpVt
	 btatscTTPsVQwl3V40dJtn5JRodixN14gogrcElpzQD7eXWwCy9/tOyapXF5MhuOAOLWO
	 OnZCPm4obQTWHqsTEhVkjJ4sKQgYH/Iv6fhtEaeQKwnw496aPARGh1dH/GIS8eimRjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192C606A31D
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 12:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4192C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-54d6281f6dbso2566512b6e.2
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 05:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277873; x=1793882673;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FovyKoW229/ssIodbKSmr878FfMZGbrQjeq+W9gevBU=;
        b=vZhhF2pP8dvctf4J1E+gGSyIkgpfwW7H83VsxP6pUEvUJEVpVzXbXY7nVtPoxn4257
         GPeepu907UqjxIalR5w00Plpz7pW+1dJAzzqU10ijkm9MtaCRXpf0IzCfH0iKH7FDUpf
         PyXBQHe1OZHyFO3jx+JVDNt0RC31dxLTDkWeyzJHO3vLvOyzgvNsXyZDSr6W8MGLyXdG
         feSGxJengMgizzAZ+vpWxi5cB+PxVT3hcB2PSWwlTVak9QOZkNV7kdrGqurelfUmvocX
         9njaZiZV1gEhxuriZ7ckYF8syGEHnxeySY7C9UVkBdP9GIh6PYvZ40uG70QhPCRGHtlR
         xqkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMx+CKLkzKe8kUh2XDignyd0goIYj0I/bfBYzWuNZ2uXVUyh4IrxNJcV5wFyvED2ey6ZEdp/XwiPKIMQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLukuuoIm4t/ZMqPyrgJED9w6GH2N9+x96+DidWia0SzQZ+zBqq
	9fsjtgnqBVd/c5g0d+VL5iAg0PezPtFV3ZqkfLCd8yqwx6LI1LXmV1ewMA2JiedADCbzptFLG8W
	1n7jKPzeHFLIMlXy6rTgFHozPjTGh4MWL6YAQhN7k9Zzi+W/Bxs0PrBtKSI4=
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1713:b0:4d6:90d3:e184 with SMTP id
 5614622812f47-56383c86218mr3191631b6e.45.1793277873353; Thu, 29 Oct 2026
 05:44:33 -0700 (PDT)
Date: Thu, 29 Oct 2026 05:44:33 -0700
In-Reply-To: <6aadf047.71f81b7d.15fa6d.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae33fb1.5c4929c8.32e0e.00aa.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in seq_printf
From: syzbot <syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, habilerenturker@gmail.com, 
	habilerenturker@hotmail.com, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c339f4010dea Merge tag 'platform-drivers-x86-v7.4-1' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15488659580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d30e1495ee3ac817
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6b37960b1d13f68f9f
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14629c2d580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:650 [inline]
BUG: KASAN: slab-use-after-free in string+0x216/0x2d0 lib/vsprintf.c:732
Read of size 1 at addr ffff8880280552a0 by task syz-executor119/5994

CPU: 1 UID: 0 PID: 5994 Comm: syz-executor119 Tainted: G                   Y syzkaller #0 PREEMPT(full) 
Tainted: [Y]=FORCED_BIND
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 string_nocheck lib/vsprintf.c:650 [inline]
 string+0x216/0x2d0 lib/vsprintf.c:732
 vsnprintf+0x74a/0xef0 lib/vsprintf.c:2948
 seq_vprintf fs/seq_file.c:392 [inline]
 seq_printf+0x188/0x290 fs/seq_file.c:407
 irq_seq_show+0x5fc/0x820 kernel/irq/proc.c:600
 traverse+0x229/0x620 fs/seq_file.c:112
 seq_lseek+0x134/0x260 fs/seq_file.c:324
 proc_reg_llseek+0x1bc/0x290 fs/proc/inode.c:283
 vfs_llseek fs/read_write.c:391 [inline]
 ksys_lseek fs/read_write.c:404 [inline]
 __do_sys_lseek fs/read_write.c:414 [inline]
 __se_sys_lseek fs/read_write.c:412 [inline]
 __x64_sys_lseek+0x14f/0x1e0 fs/read_write.c:412
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2161683707
Code: 77 01 c3 48 c7 c2 d0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 d0 ff ff ff f7 d8 64 89 02 48
RSP: 002b:00007f215fe441e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f2161683707
RDX: 0000000000000000 RSI: 0000000200000008 RDI: 0000000000000007
RBP: 00007f21616ea034 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000200000008
R13: 00007f215fe441f0 R14: 00007fff37c40200 R15: 00007fff37c402e8
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5531 [inline]
 __kmalloc_node_track_caller_noprof+0x4af/0x720 mm/slub.c:5662
 kvasprintf+0xeb/0x1a0 lib/kasprintf.c:25
 kasprintf+0xe2/0x140 lib/kasprintf.c:59
 serial_core_add_one_port drivers/tty/serial/serial_core.c:3138 [inline]
 serial_core_register_port+0x611/0x2b80 drivers/tty/serial/serial_core.c:3366
 __serial8250_register_8250_port drivers/tty/serial/8250/8250_core.c:862 [inline]
 serial8250_register_8250_port+0x1a2c/0x2400 drivers/tty/serial/8250/8250_core.c:929
 serial_pnp_probe+0x576/0x7d0 drivers/tty/serial/8250/8250_pnp.c:480
 pnp_device_probe+0x313/0x4d0 drivers/pnp/driver.c:111
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:707
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __driver_attach+0x34e/0x630 drivers/base/dd.c:1300
 bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:386
 bus_add_driver+0x38f/0x6e0 drivers/base/bus.c:785
 driver_register+0x23a/0x320 drivers/base/driver.c:174
 serial8250_init+0x8f/0x160 drivers/tty/serial/8250/8250_platform.c:316
 do_one_initcall+0x250/0x870 init/main.c:1419
 do_initcall_level+0x10a/0x1a0 init/main.c:1481
 do_initcalls+0x59/0xa0 init/main.c:1497
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
 kernel_init+0x22/0x1d0 init/main.c:1622
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5990:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6923
 serial_core_remove_one_port drivers/tty/serial/serial_core.c:3261 [inline]
 serial_core_unregister_port+0x500/0xb80 drivers/tty/serial/serial_core.c:3409
 serial8250_unregister_port+0x250/0x770 drivers/tty/serial/8250/8250_core.c:955
 pnp_device_remove+0x82/0x260 drivers/pnp/driver.c:133
 device_remove drivers/base/dd.c:617 [inline]
 __device_release_driver drivers/base/dd.c:1357 [inline]
 device_release_driver_internal+0x42b/0x7d0 drivers/base/dd.c:1380
 unbind_store+0x1cb/0x200 drivers/base/bus.c:246
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880280552a0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff8880280552a0, ffff8880280552a8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880280553a0 pfn:0x28055
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813ff22500 ffffea0000a14610 ffffea000083dc50
raw: ffff8880280553a0 000000000080007a 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 6950794147
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1856
 prep_new_page mm/page_alloc.c:1864 [inline]
 get_page_from_freelist+0x220f/0x2280 mm/page_alloc.c:3935
 __alloc_frozen_pages_noprof+0x1fe/0x410 mm/page_alloc.c:5444
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __do_kmalloc_node mm/slub.c:5530 [inline]
 __kmalloc_node_track_caller_noprof+0x543/0x720 mm/slub.c:5662
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 __kernfs_new_node+0xa9/0x980 fs/kernfs/dir.c:663
 kernfs_new_node+0xeb/0x140 fs/kernfs/dir.c:759
 kernfs_create_link+0xe3/0x240 fs/kernfs/symlink.c:50
 sysfs_do_create_link_sd+0x83/0x110 fs/sysfs/symlink.c:44
 driver_sysfs_add+0x89/0x210 drivers/base/dd.c:490
 really_probe+0x142/0xae0 drivers/base/dd.c:695
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
page last free pid 12 tgid 12 ts 6949306649 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1403 [inline]
 __free_frozen_pages+0xc97/0xd90 mm/page_alloc.c:2954
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:393 [inline]
 __kasan_populate_vmalloc+0x1a8/0x1c0 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:580 [inline]
 alloc_vmap_area+0xd10/0x1410 mm/vmalloc.c:2151
 __get_vm_area_node+0x200/0x2f0 mm/vmalloc.c:3281
 __vmalloc_node_range_noprof+0x36e/0x16f0 mm/vmalloc.c:4112
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4213
 alloc_thread_stack_node kernel/fork.c:359 [inline]
 dup_task_struct+0x2c6/0xa00 kernel/fork.c:931
 copy_process+0x7ea/0x44b0 kernel/fork.c:2142
 kernel_clone+0x2d7/0x940 kernel/fork.c:2784
 user_mode_thread+0x115/0x180 kernel/fork.c:2861
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:169
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888028055180: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888028055200: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
>ffff888028055280: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
                               ^
 ffff888028055300: fa fc fc fc fa fc fc fc fa fc fc fc 06 fc fc fc
 ffff888028055380: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
