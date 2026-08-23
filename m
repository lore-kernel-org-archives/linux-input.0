Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC1369D57
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787455413; cv=none; b=LiqL0NNX3vQe+2fp/iAUoMMBlz2FnSinEQdBSW9g2kzJZF29Cs1IIU00L8ZZOQGSd+Pg4GGViUhX9MO73QNsJGWmZN4b2y5fWLfuN7tH5fKbYuIPRNqt9e2XYNpa5GpR2dGSFwsVV48249juYELHC3ZSTrHlfLbhrJGIDiGEBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787455413; c=relaxed/simple;
	bh=mUNCGUauvzblBdSwOBREqqLfRUQykoK2gjgnu77KoH8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uR3i3fIhnNmRDxGY0ydKv6zzx503hc1tJiZkdxMAAWsGweGBOSuIir6h+3X2QKIffk9hgeiPhg9ml2gaK1Khb1norDLJ2yHGPR42xg2PRrGIZnz8eiKV2hCy01STOqf7pZ4moe/Fgp2dJvNoN3h9jd+/x1Z+lEGWh3A5Ybmkyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso1168218b6e.1
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 20:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787455410; x=1788060210;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=reYCA9texGA+i4hhGkr84lFQt3J7gOmzTWCCQAJBp5U=;
        b=HgIe59jcMo6ukbE0n2o1rx+BzVoN+qtfWLu+zbAk2D1FhkaFaRIWer2tz517IcUp9c
         uXIrSsr/XknQj3X11DPoOUcWL/G/hHfyjWFtSQGJZGDv5PiGVhipsIoUleDy18PmvYs0
         MkDIn3WVs2NSSb9Jik9/aDsQiE5JOqn1QzfpFyArbYhw/TxMLD/QkaN1jCeYkD+s8IB/
         tUg7UlZyBRmiZJ2hpdflGD0Q9fmCW37sFl1C1QSWiJ8EeS+8vNw3Vjxi9Q7EkwourYr+
         HxjlddnymTg8Qqf1oiqJZLqfufuA5I/A+m5vamIk6WM0TS4bGS/l5Tq7GASyzGSSAt2K
         Pbvg==
X-Forwarded-Encrypted: i=1; AHgh+RpRrCQNAi54fUlxzCTJSinD6YrQUem6F1q0pTszIA8YLxNmkJOTqTiGM0rRlNNXVAQMYCEYKfl/zO4pdA==@vger.kernel.org
X-Gm-Message-State: AFuF++mBzRIKHqPnxH9S8HEjRGm/xnE/FK1tV/3eg7RKHOqo1CU67QOf
	oPXaBTm0anvZzRBNKkReXHKjy/SqniKQ+DEeuMa/ZXIrZrE/oe39E9x6CuJ6Bw/Jiw0RrHXLjBl
	nVRLJqQ8SS6BuTV2a+bpDGBjz47mNHT0ZkY1nLK8aGjeqrC+RH04WUP9mz7o=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c145:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4b2ef242470mr19647197b6e.8.1787455410663; Sat, 22 Aug 2026
 20:23:30 -0700 (PDT)
Date: Sat, 22 Aug 2026 20:23:30 -0700
In-Reply-To: <699fe31c.050a0220.2fcbed.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8a67b2.ae6ddae5.3da009.0060.GAE@google.com>
Subject: Re: [syzbot] [input?] possible deadlock in __kernfs_remove (3)
From: syzbot <syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66fb95a52111 Merge tag 'caps-pr-20260820' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ca4625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0978f5ed2905b98
dashboard link: https://syzkaller.appspot.com/bug?extid=1075f6dc93f398c1857e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10815549580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7d9049723b0/disk-66fb95a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a04d6efe59a0/vmlinux-66fb95a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81e3f2b9c049/bzImage-66fb95a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6104 is trying to acquire lock:
ffff888035f1b008 (kn->active#59){++++}-{0:0}, at: __kernfs_remove+0x34c/0xb80 fs/kernfs/dir.c:1579

but task is already holding lock:
ffffffff904d00c0 (serio_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
ffffffff904d00c0 (serio_mutex){+.+.}-{4:4}, at: serio_unregister_port+0x1b/0x40 drivers/input/serio/serio.c:677

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (serio_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
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
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (kn->active#59){++++}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
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
       ptrace_notify+0xf3/0x120 kernel/signal.c:2531
       ptrace_report_syscall include/linux/ptrace.h:416 [inline]
       ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
       arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
       syscall_exit_work include/linux/entry-common.h:266 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
       do_syscall_64+0x5e7/0x790 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(serio_mutex);
                               lock(kn->active#59);
                               lock(serio_mutex);
  lock(kn->active#59);

 *** DEADLOCK ***

locks held by syz.0.17/6104: 1, last CPU#1:
 #0: ffffffff904d00c0 (serio_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffffffff904d00c0 (serio_mutex){+.+.}-{4:4}, at: serio_unregister_port+0x1b/0x40 drivers/input/serio/serio.c:677

stack backtrace:
CPU: 1 UID: 0 PID: 6104 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
 lock_acquire kernel/locking/lockdep.c:5886 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
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
 ptrace_notify+0xf3/0x120 kernel/signal.c:2531
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:233 [inline]
 syscall_exit_work include/linux/entry-common.h:266 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:297 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:334 [inline]
 do_syscall_64+0x5e7/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f094979e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca1bdeb48 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f0949a27da0 RCX: 00007f094979e0d9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f0949a27da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f0949a27cb0 R11: 0000000000000246 R12: 000000000001aa1e
R13: 00007f0949a25fac R14: 000000000001a7d2 R15: 00007ffca1bdec50
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
