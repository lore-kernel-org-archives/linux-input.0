Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2F3A3835
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788038553; cv=none; b=o8OGXSWZ67ELqME3Yunmw8+btRktLsg3N2PnJ5ntujhKyjZwlhKN70OhC19YYEeVhTzfkGnM0NP2GkRVNTjyjEHRSBk3P+CtlyYj6/vxWle9FiyUC1Ux8BoiEX4hPATLd4+/6Bvq2cTjMMXSmfFz6EQfcWRLcoSoBngi9KEPuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788038553; c=relaxed/simple;
	bh=WI7AZhtEqr9xVlLFzEDYIIFNWQlxz9PEtDtkd4+D4f0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bWmGx5MepBZ4EeKu+onzdkQ5DunhXG10fdp2a0Cld790CD4eN/OW9cN00L+VUod+CDD1nomVGqRMyw2DUc6pN06Da2C5CBDzYcjjdvjg4SW4jSkOsfA5glwXFqzM6KkRBP6IG7gIbGvOOIEuSUsbIPjgu3ARPX7vxML0vu85A9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so726420b6e.1
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 14:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788038550; x=1788643350;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LJMEXdlk7d61VrtM7qDRU6Bog3O/MwGb1q5vlyd9SZA=;
        b=iUa9fE7AtS0V/mGIsJL0n1X8D5rkqNr8NpT47Li72eebeJGL/G29CQfp6S++3afmBp
         JkhEe05rWx0mUFEDRFtkyDlrYAArgUnXlanjIpSBfvx39GtPwM8lvzaJpp3f23trbLJw
         vVpLqZKndKB/FvV3ZMRHOMmDncUc20arJ2kretkhB3acUQxmcOobPdsAIs8UbPy54iDh
         jIuezWKpXvg9AkFuHf3gWLoZjvwTpKkBKKqPY2I2gg4oDMJf+Eflc9f8cxGd4jRP5/Sl
         3YTSP5LbKCpvXT+RiGKKlNyTWPpAPTEHelm0sk3t7fhOYk/L9TZO3G5rDS1Wm0rrq4bJ
         mUGw==
X-Forwarded-Encrypted: i=1; AHgh+RqH5ABepOpqK/ayFRI4EiR2YuzZYAiZcsBCy5cnZc8IFgjUQRnYsj8E2rMnDiGW7FgSXs+z+XH6QzSgUg==@vger.kernel.org
X-Gm-Message-State: AFuF++kIGIrihDQmPxjCshtw9UeyAmGNwgpDv0VglFLw9lXZEujhGnm8
	5P3pEIaHHkor6Y32Fo0TiNpgToMgcuvheIY2PR5Si3WpdwpWbzjOePMlpXQIy3AYLb5wDg9RZS0
	Hh1NQURPoZ7jiFeGbFGmSV6WNXbrMdQCNdb0NIclYxwrsTaDP/+ML7MT8Ffg=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:10c8:b0:4b2:8d89:6a40 with SMTP id
 5614622812f47-4b397ffa6e9mr16173861b6e.7.1788038550449; Sat, 29 Aug 2026
 14:22:30 -0700 (PDT)
Date: Sat, 29 Aug 2026 14:22:30 -0700
In-Reply-To: <699fe31c.050a0220.2fcbed.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a934d96.08e933ee.dbf97.00aa.GAE@google.com>
Subject: Re: [syzbot] [input?] possible deadlock in __kernfs_remove (3)
From: syzbot <syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cf72cbb39da8 Merge tag 'io_uring-7.3-20260828' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c09d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161fae25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1084c379580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cf72cbb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/755d053ff703/vmlinux-cf72cbb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0837738ba281/bzImage-cf72cbb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6098 is trying to acquire lock:
ffff88804e56bf08 (kn->active#66){++++}-{0:0}, at: __kernfs_remove+0x34c/0xb80 fs/kernfs/dir.c:1579

but task is already holding lock:
ffffffff904e2360 (serio_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
ffffffff904e2360 (serio_mutex){+.+.}-{4:4}, at: serio_unregister_port+0x1b/0x40 drivers/input/serio/serio.c:677

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (serio_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       class_mutex_intr_constructor include/linux/mutex.h:255 [inline]
       drvctl_store+0x3c/0x350 drivers/input/serio/serio.c:360
       dev_attr_store+0x58/0x80 drivers/base/core.c:2509
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (kn->active#66){++++}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       kernfs_drain+0x4f0/0x600 fs/kernfs/dir.c:532
       __kernfs_remove+0x34c/0xb80 fs/kernfs/dir.c:1579
       kernfs_remove_by_name_ns+0x7c/0x120 fs/kernfs/dir.c:1797
       kernfs_remove_by_name include/linux/kernfs.h:644 [inline]
       remove_files+0x96/0x1c0 fs/sysfs/group.c:28
       sysfs_remove_group+0x8b/0x1b0 fs/sysfs/group.c:328
       sysfs_remove_groups fs/sysfs/group.c:352 [inline]
       sysfs_remove_groups+0x60/0xb0 fs/sysfs/group.c:344
       device_remove_groups drivers/base/core.c:2918 [inline]
       device_remove_attrs+0x192/0x290 drivers/base/core.c:3048
       device_del+0x36e/0x9b0 drivers/base/core.c:3964
       serio_destroy_port+0x476/0x590 drivers/input/serio/serio.c:543
       serio_unregister_port+0x2b/0x40 drivers/input/serio/serio.c:680
       userio_char_release+0x91/0xe0 drivers/input/serio/userio.c:105
       __fput+0x3ff/0xb50 fs/file_table.c:512
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
       exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
       __do_fast_syscall_32+0x59f/0x8b0 arch/x86/entry/syscall_32.c:294
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(serio_mutex);
                               lock(kn->active#66);
                               lock(serio_mutex);
  lock(kn->active#66);

 *** DEADLOCK ***

locks held by syz.0.17/6098: 1, last CPU#2:
 #0: ffffffff904e2360 (serio_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffffffff904e2360 (serio_mutex){+.+.}-{4:4}, at: serio_unregister_port+0x1b/0x40 drivers/input/serio/serio.c:677

stack backtrace:
CPU: 2 UID: 0 PID: 6098 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
 lock_acquire kernel/locking/lockdep.c:5908 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
 kernfs_drain+0x4f0/0x600 fs/kernfs/dir.c:532
 __kernfs_remove+0x34c/0xb80 fs/kernfs/dir.c:1579
 kernfs_remove_by_name_ns+0x7c/0x120 fs/kernfs/dir.c:1797
 kernfs_remove_by_name include/linux/kernfs.h:644 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x8b/0x1b0 fs/sysfs/group.c:328
 sysfs_remove_groups fs/sysfs/group.c:352 [inline]
 sysfs_remove_groups+0x60/0xb0 fs/sysfs/group.c:344
 device_remove_groups drivers/base/core.c:2918 [inline]
 device_remove_attrs+0x192/0x290 drivers/base/core.c:3048
 device_del+0x36e/0x9b0 drivers/base/core.c:3964
 serio_destroy_port+0x476/0x590 drivers/input/serio/serio.c:543
 serio_unregister_port+0x2b/0x40 drivers/input/serio/serio.c:680
 userio_char_release+0x91/0xe0 drivers/input/serio/userio.c:105
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 __do_fast_syscall_32+0x59f/0x8b0 arch/x86/entry/syscall_32.c:294
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf6ffefec
Code: Unable to access opcode bytes at 0xf6ffefc2.
RSP: 002b:00000000ffbd8fbc EFLAGS: 00000202 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
