Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B214DA544
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856820; cv=none; b=FGOCJ6iwSK15rcP0pQs8Kf7As50g5/aCE2syPcro6429uwcvd3IlZRXU6/WxLsL+hbv2peWWlSstVltBMOe3qiiMz0nugehra+3rfkWVriTFDqSvB96d7aCjBd4dzX0EtxW74KaKQR8aiwaz5MobLKRz3vk2YHu2UHIfoMvS6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856820; c=relaxed/simple;
	bh=3evSWErH5X9gbxTM+X5A5VAKoMQxNhR3lW84sXuwYgA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CEwXhsDGIyn/D1sPeEvBrhebEWF3oKq3zCn+7Mr4TjHGAEaHjnUEFFpuy1OyomzpIFipS0TQuLli456wjEuLcfw+3wDeOBy3CDWIj99n8gWoo+fFLggxKxJLeyTkxMVWc/UVg348Kp8HirgNuUj4WVy8Darg+e7fD2AWOU2UQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 46e09a7af769-7f193d62888so26692a34.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856804; x=1788461604;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ClyFyv+LzA9R4j6L5nlr5tYhByGpJNxBtzqsdMJIEs=;
        b=VOG+vSMwb6Rgsonm0sRhw7Rn8JyxZC59bklzNSZkBlajWlI613hPiRyX+PdIXN8BBc
         gagsFg+l+BOoclykODmtUtYsBanTzaYrhFlKTGBM80Og0UDqq01ywF9yIYtN+3fkrevB
         IVz2odP0p36ii1cXbdZ9a/Myc2bzKOheZVtFLtX7ncu2Y7uLkqcyFQUfYpBO0mJo6Pa/
         F+LxajR8bn/TPeuJNxFSPdJvcn1mEKPo6fcA48YGQT3gs3kzVzFvIKiUexgRQygq4gUJ
         C7U39CAzC8eywOeHwjCDKr8WLfgPtKUIPf5aW80le23y2stRo4yI8WaZIZ2de8xZ+JYL
         P02w==
X-Forwarded-Encrypted: i=1; AHgh+Rqt+QOnXmlIRj5LrexfLQwLOOTXWCWU/WDVkzAHSetCWQAzu67VqXIVcSrJdPstKowMpEkSAJZMsSGvAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++naz1N9+Vo4n8LxJY8ilaCCNRkx9vqFMDGsZi53KuU/p0YZk61J
	Vg0fbnAhjd8ljONo0nc8SzpwDq1YASbXg386IC5buPgOOIHdxZzDhy25tzeGH1fklnCMYNGGOtW
	U+zAElMQFer7cPnXWClggdtYBaHVBWYeJ2mOkP40P9vLXlxjyqqnm7JvwQTg=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1787:b0:6b1:3f1e:64a6 with SMTP id
 006d021491bc7-6b1c6700c7bmr561031eaf.23.1787856803909; Thu, 27 Aug 2026
 11:53:23 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9087a3.4d659fcc.734b4.0012.GAE@google.com>
Subject: [syzbot] [usb?] [input?] INFO: task hung in trigger_card_free
From: syzbot <syzbot+a149ad38eaf1930d3e31@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2709dd5ae32f Merge tag 'sched-urgent-2026-08-22' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f7a415580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0978f5ed2905b98
dashboard link: https://syzkaller.appspot.com/bug?extid=a149ad38eaf1930d3e31
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15418979580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b8578cfc5d0/disk-2709dd5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08516f9ee501/vmlinux-2709dd5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94796f512f2e/bzImage-2709dd5a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a149ad38eaf1930d3e31@syzkaller.appspotmail.com

INFO: task syz.0.17:5991 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25192 pid:5991  tgid:5991  ppid:5810   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1259/0x6920 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7362
 schedule_timeout+0x1b2/0x280 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2e7/0x4c0 kernel/sched/completion.c:121
 snd_card_free sound/core/init.c:665 [inline]
 trigger_card_free+0x127/0x190 sound/core/init.c:868
 release_nodes+0xa5/0x120 drivers/base/devres.c:546
 devres_release_all+0x112/0x180 drivers/base/devres.c:576
 device_unbind_cleanup+0x81/0x270 drivers/base/dd.c:597
 __device_release_driver drivers/base/dd.c:1354 [inline]
 device_release_driver_internal+0x4c4/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f948ef9e0d9
RSP: 002b:00007ffeb02836d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f948f225fa0 RCX: 00007f948ef9e0d9
RDX: 000000000000000b RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f948f035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f948f225fac R14: 00007f948f225fa0 R15: 00007f948f225fa0
 </TASK>

Showing all locks held in the system:
locks held by kworker/u8:1/13: 4, last CPU#0:
 #0: ffff88801c08c140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3362
 #1: ffffc90000127d08 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3363
 #2: ffffffff8ec7a830 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_disable+0x12/0x20 kernel/jump_label.c:247
 #3: ffffffff8ef3d400 (jump_label_mutex){+.+.}-{4:4}, at: jump_label_lock kernel/jump_label.c:27 [inline]
 #3: ffffffff8ef3d400 (jump_label_mutex){+.+.}-{4:4}, at: static_key_disable_cpuslocked+0x110/0x1c0 kernel/jump_label.c:238
locks held by khungtaskd/31: 1, last CPU#1:
 #0: ffffffff8ede9d40 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8ede9d40 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8ede9d40 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6793
locks held by getty/5355: 2, on CPU#1:
 #0: ffff88803848c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
locks held by syz.0.17/5991: 3, on CPU#1:
 #0: ffff8880302a4460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880273d4080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff8880338ca138 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff8880338ca138 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #2: ffff8880338ca138 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x21f/0x2a0 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xcb1/0x1030 kernel/hung_task.c:561
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 08 a1 02 e9 43 4f 03 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 83 e0 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8ea07cf0 EFLAGS: 00000246
RAX: 00000000002e8403 RBX: ffffffff8ea91500 RCX: ffffffff8bc9c115
RDX: 0000000000000001 RSI: ffffffff8e3dfa2f RDI: ffffffff8c619080
RBP: fffffbfff1d522a0 R08: 0000000000000001 R09: ffffed101708678d
R10: ffff8880b8433c6b R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffffffff1d40fa2 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888123b88000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe96a6cff8 CR3: 000000007cb49000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3ae/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:454
 rest_init+0x2d3/0x2e0 init/main.c:723
 start_kernel+0x48e/0x490 init/main.c:1181
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x158
 </TASK>


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
