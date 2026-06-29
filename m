Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2E3B47FF
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767445; cv=none; b=FM5l/jeCTS9ArF11AJ5ucRyzwABCYG+qArblmRZMC5Cw5BNe1YVEOlr+FfEQx8Q++Kzt4AP0Ehr8rpN7Qky+xHal0BSlQbvvVS7N7duzM21h4I1c1zCPSX5sEnHLIyCFyKUhtjhm8frq3yR755J82wS8+VRf4n9fvvghBx2axBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767445; c=relaxed/simple;
	bh=Zl1/xEBIw+egt5C3VQfBT5k0/AzReNfN6LeruAkcvYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nvatABFMLvTR/IAGyTY7GyNtcexWl9TixTefI1mFITMho0yZbD+WonpC8/a6s6enWFksoIBqlapmnSHDFE1AR36y2Z7eUBlTN06Bg5gaCVb5A6979b2lkGcVFzOJ3lLa2WcivMdLUjPjMm1kIlmKvtA23cO29KT0t7XpFhgDWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48952d1c293so6289773b6e.3
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767426; x=1783372226;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2mkhHHLoqmi5pRfIjLfqLO6LHfAh+h6wjUk8zDr+A0=;
        b=qkdvTb8c7GUxdPGTU1XMUMvMZz634NPBrkmvvm7V10pX9ilrO7BOnEAFRWYH1/QkFe
         HmdYYczgSK2/oKLw2B/oFtG8+JLzgwXo9FfBy9TnUychhTO2cIzfc4VVU4AP2itiQW4S
         MGfLbBepr3dAb8OgjNZr4txga4ylDRuxdX1CApEks8Aj5Yl7kahfVhvUOfISjEEmSHuS
         S53y59rGwP4A3RuAIk4rgrxczLaDvpUaUnQ40MHe66kbwIKe9hZvBpawP93x8a2kvl9/
         b+Qj3JfCGIf+9GU+z9P5bG2PfArHbbgGL8/aacZieISVboqGcYJC0gfF1OMQc1+8jgUS
         Ee0g==
X-Forwarded-Encrypted: i=1; AFNElJ8tOALW8CA4xaH3PGCCCUMKqlKV2+GsgQNLuOpmo9qh/cGgweiz6QFN3N2GROaz8sp4NuzWEkKniOPl+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZEa1kEbjv70Fv5PhzMpJN72VJAM5sNgjMEHmqCxDakL8OSsr
	gW+DUZtnfyJq/Z1qWFxexWHKTaortpxBo+q4FynRY+tt8PJdH8KvX2eSC7OmT6WhECkdhTm01ru
	7k20Dvuzx3EZxPLBvbci5TDMRCSzKxyN25jXB6fdlEJCgu512050IY2w6+xc=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:8957:b0:495:e69b:2ff2 with SMTP id
 5614622812f47-495eaf1f2b1mr1028994b6e.24.1782767426589; Mon, 29 Jun 2026
 14:10:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a42df42.854d4ab9.360e1d.000e.GAE@google.com>
Subject: [syzbot] [mm?] [usb?] [input?] INFO: rcu detected stall in
 sys_epoll_wait (9)
From: syzbot <syzbot+80b9ecbb1485ef700f5e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5a66900afbd6 Merge tag 'drm-fixes-2026-06-27' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d4f4ea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77808e35144e725c
dashboard link: https://syzkaller.appspot.com/bug?extid=80b9ecbb1485ef700f5e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1383f861580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110809fe580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c925e1d8ab0/disk-5a66900a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c3d8d08cec4/vmlinux-5a66900a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af26ca154146/bzImage-5a66900a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80b9ecbb1485ef700f5e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10506 jiffies, g=18441, q=1765 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10482 (4294969112-4294958630), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10482 jiffies! g18441 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:27672 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_timeout+0x127/0x280 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1a9/0x900 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x179/0x230 kernel/rcu/tree.c:2325
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6473 Comm: rm Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/10/2026
RIP: 0010:_prb_read_valid+0x0/0x880 kernel/printk/printk_ringbuffer.c:2169
Code: e8 d5 3f b4 09 48 89 df e8 5d 77 91 00 e9 54 ff ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <41> 57 49 89 ff 41 56 49 89 f6 41 55 41 54 55 53 48 bb 00 00 00 00
RSP: 0000:ffffc90000a07e80 EFLAGS: 00000046
RAX: 0000000000000000 RBX: fffff52000140fd1 RCX: 0000000000000000
RDX: ffffc90000a07f50 RSI: ffffc90000a07ea8 RDI: ffffffff8e8f2100
RBP: ffffffff8e8f2100 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a07f50
R13: ffffc90000a07f90 R14: ffffc90000a07f50 R15: 0000000000000800
FS:  00007f80ef612c80(0000) GS:ffff8881241e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80ef7c74d0 CR3: 00000000274dc000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 prb_read_valid+0x78/0xa0 kernel/printk/printk_ringbuffer.c:2245
 printk_get_next_message+0x15b/0x6c0 kernel/printk/printk.c:3052
 console_emit_next_record kernel/printk/printk.c:3137 [inline]
 console_flush_one_record+0x67c/0xe50 kernel/printk/printk.c:3269
 console_flush_all kernel/printk/printk.c:3343 [inline]
 __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
 console_unlock+0x103/0x260 kernel/printk/printk.c:3413
 vprintk_emit+0x407/0x6b0 kernel/printk/printk.c:2479
 _printk+0xcf/0x110 kernel/printk/printk.c:2504
 printk_stack_address arch/x86/kernel/dumpstack.c:70 [inline]
 __show_trace_log_lvl+0x22d/0x2c4 arch/x86/kernel/dumpstack.c:282
 show_trace_log_lvl arch/x86/kernel/dumpstack.c:319 [inline]
 show_stack+0x47/0x70 arch/x86/kernel/dumpstack.c:337
 sched_show_task kernel/sched/core.c:8184 [inline]
 sched_show_task+0x471/0x610 kernel/sched/core.c:8159
 show_state_filter+0xee/0x390 kernel/sched/core.c:8229
 k_spec drivers/tty/vt/keyboard.c:659 [inline]
 k_spec+0x100/0x140 drivers/tty/vt/keyboard.c:648
 kbd_keycode drivers/tty/vt/keyboard.c:1565 [inline]
 kbd_event+0xe4c/0x1b70 drivers/tty/vt/keyboard.c:1583
 input_handle_events_default+0x119/0x1b0 drivers/input/input.c:2561
 input_pass_values+0x753/0x880 drivers/input/input.c:128
 input_event_dispose drivers/input/input.c:353 [inline]
 input_handle_event+0x37f/0x1500 drivers/input/input.c:370
 input_event drivers/input/input.c:396 [inline]
 input_event+0x83/0xb0 drivers/input/input.c:391
 hidinput_hid_event+0x5ec/0x24b0 drivers/hid/hid-input.c:1777
 hid_process_event+0x4bc/0x5a0 drivers/hid/hid-core.c:1576
 hid_input_array_field+0x303/0x6d0 drivers/hid/hid-core.c:1680
 hid_process_report drivers/hid/hid-core.c:1730 [inline]
 hid_report_raw_event+0xb43/0x1420 drivers/hid/hid-core.c:2095
 __hid_input_report.constprop.0+0x349/0x470 drivers/hid/hid-core.c:2166
 hid_irq_in+0x55d/0x710 drivers/hid/usbhid/hid-core.c:287
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xda1/0x36c0 drivers/usb/gadget/udc/dummy_hcd.c:2005
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17d/0x2c0 kernel/time/hrtimer.c:2113
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x70 kernel/kcov.c:217
Code: 2a 12 a9 00 01 ff 00 74 1b f6 c4 01 74 07 a9 00 00 ff 00 74 05 e9 11 81 96 09 8b 82 24 17 00 00 85 c0 74 f1 8b 82 f8 16 00 00 <83> f8 02 75 e6 48 8b 8a 00 17 00 00 8b 92 fc 16 00 00 48 8b 01 48
RSP: 0000:ffffc90004227968 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88807e33ce10 RCX: 000000001435d025
RDX: ffff8880233f2540 RSI: ffffffff828626fa RDI: ffff88807eee8cc0
RBP: ffff88807eee8cc0 R08: 0000000000000001 R09: 0000000000002000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 1ffff92000844f30
 __page_table_check_ptes_set+0x8a/0x4e0 mm/page_table_check.c:207
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 set_pte_range+0x99b/0xbd0 mm/memory.c:5588
 filemap_map_order0_folio mm/filemap.c:3874 [inline]
 filemap_map_pages+0x756/0x1fe0 mm/filemap.c:3944
 do_fault_around mm/memory.c:5818 [inline]
 do_read_fault mm/memory.c:5851 [inline]
 do_fault+0x985/0x1750 mm/memory.c:5994
 do_pte_missing mm/memory.c:4566 [inline]
 handle_pte_fault mm/memory.c:6379 [inline]
 __handle_mm_fault+0x187d/0x2a00 mm/memory.c:6517
 handle_mm_fault+0x37b/0xa30 mm/memory.c:6686
 do_user_addr_fault+0x5a3/0x12f0 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6f/0xd0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0033:0x7f80ef7c74d0
Code: Unable to access opcode bytes at 0x7f80ef7c74a6.
RSP: 002b:00007fff9128fe28 EFLAGS: 00010246
RAX: 0000000000000090 RBX: 00007f80ef9bba80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000be
RBP: 00007fff91290150 R08: ffffffffffffffff R09: 0000000000000000
R10: 00007fff9128fe80 R11: 0000000000000246 R12: fffffffffffffff8
R13: 000000bb5f81c458 R14: 0000000000000000 R15: 00007f80ef9bd310
 </TASK>
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a19061bd0
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:kworker/u8:10   state:I stack:27208 pid:6043  tgid:6043  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 worker_thread+0x53b/0xe50 kernel/workqueue.c:3501
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:syz-executor    state:S stack:26920 pid:6044  tgid:6044  ppid:5640   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_wait+0x1a7/0x570 kernel/exit.c:1756
 kernel_wait4+0x16d/0x280 kernel/exit.c:1910
 __do_sys_wait4+0x161/0x170 kernel/exit.c:1938
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d8d757fd7
RSP: 002b:00007fff82e8f620 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00005555903a2500 RCX: 00007f2d8d757fd7
RDX: 0000000040000000 RSI: 00007fff82e8f67c RDI: ffffffffffffffff
RBP: 00007fff82e8f67c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff82e8f6f8
R13: 0000000000000002 R14: 00007fff82e8f8d8 R15: 0000000000000000
 </TASK>
task:kworker/u8:11   state:I stack:27096 pid:6045  tgid:6045  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 worker_thread+0x53b/0xe50 kernel/workqueue.c:3501
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:syz-executor    state:S stack:26552 pid:6046  tgid:6046  ppid:5640   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_wait+0x1a7/0x570 kernel/exit.c:1756
 kernel_wait4+0x16d/0x280 kernel/exit.c:1910
 __do_sys_wait4+0x161/0x170 kernel/exit.c:1938
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d4c357fd7
RSP: 002b:00007fffbb734a90 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00005555953cb500 RCX: 00007f4d4c357fd7
RDX: 0000000040000000 RSI: 00007fffbb734aec RDI: ffffffffffffffff
RBP: 00007fffbb734aec R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffbb734b68
R13: 0000000000000002 R14: 00007fffbb734d48 R15: 0000000000000000
 </TASK>
task:syz-executor    state:S stack:26040 pid:6047  tgid:6047  ppid:5640   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_wait+0x1a7/0x570 kernel/exit.c:1756
 kernel_wait4+0x16d/0x280 kernel/exit.c:1910
 __do_sys_wait4+0x161/0x170 kernel/exit.c:1938
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d26957fd7
RSP: 002b:00007fff2be14380 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000555579950500 RCX: 00007f4d26957fd7
RDX: 0000000040000000 RSI: 00007fff2be143dc RDI: ffffffffffffffff
RBP: 00007fff2be143dc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff2be14458
R13: 0000000000000002 R14: 00007fff2be14638 R15: 0000000000000000
 </TASK>
task:syz-executor    state:R  running task     stack:23528 pid:6048  tgid:6048  ppid:6035   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_nanosleep+0x113/0x500 kernel/time/hrtimer.c:2399
 hrtimer_nanosleep+0x14f/0x350 kernel/time/hrtimer.c:2445
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1360
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1383 [inline]
 __x64_sys_clock_nanosleep+0x336/0x480 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8eb955d68e
RSP: 002b:00007ffdb9c419c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000555559f80500 RCX: 00007f8eb955d68e
RDX: 00007ffdb9c41a20 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffdb9c41a8c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 00000000000344d1 R15: 00007ffdb9c41ae0
 </TASK>
task:syz-executor    state:R  running task     stack:23872 pid:6049  tgid:6049  ppid:6044   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_nanosleep+0x113/0x500 kernel/time/hrtimer.c:2399
 hrtimer_nanosleep+0x14f/0x350 kernel/time/hrtimer.c:2445
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1360
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1383 [inline]
 __x64_sys_clock_nanosleep+0x336/0x480 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d8d75d68e
RSP: 002b:00007fff82e8f418 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00005555903a2500 RCX: 00007f2d8d75d68e
RDX: 00007fff82e8f470 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fff82e8f4dc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 0000000000034625 R15: 00007fff82e8f530
 </TASK>
task:syz-executor    state:S stack:26520 pid:6050  tgid:6050  ppid:5640   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_wait+0x1a7/0x570 kernel/exit.c:1756
 kernel_wait4+0x16d/0x280 kernel/exit.c:1910
 __do_sys_wait4+0x161/0x170 kernel/exit.c:1938
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a52557fd7
RSP: 002b:00007ffc9b2ffdd0 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000555580266500 RCX: 00007f4a52557fd7
RDX: 0000000040000000 RSI: 00007ffc9b2ffe2c RDI: ffffffffffffffff
RBP: 00007ffc9b2ffe2c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc9b2ffea8
R13: 0000000000000002 R14: 00007ffc9b300088 R15: 0000000000000000
 </TASK>
task:syz-executor    state:R  running task     stack:23864 pid:6052  tgid:6052  ppid:6050   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_nanosleep+0x113/0x500 kernel/time/hrtimer.c:2399
 hrtimer_nanosleep+0x14f/0x350 kernel/time/hrtimer.c:2445
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1360
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1383 [inline]
 __x64_sys_clock_nanosleep+0x336/0x480 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a5255d68e
RSP: 002b:00007ffc9b2ffbc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000555580266500 RCX: 00007f4a5255d68e
RDX: 00007ffc9b2ffc20 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffc9b2ffc8c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 0000000000034648 R15: 00007ffc9b2ffce0
 </TASK>
task:syz-executor    state:R  running task     stack:23960 pid:6053  tgid:6053  ppid:6046   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_nanosleep+0x113/0x500 kernel/time/hrtimer.c:2399
 hrtimer_nanosleep+0x14f/0x350 kernel/time/hrtimer.c:2445
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1360
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1383 [inline]
 __x64_sys_clock_nanosleep+0x336/0x480 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d4c35d68e
RSP: 002b:00007fffbb734888 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00005555953cb500 RCX: 00007f4d4c35d68e
RDX: 00007fffbb7348e0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fffbb73494c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 0000000000034507 R15: 00007fffbb7349a0
 </TASK>
task:syz-executor    state:R  running task     stack:23928 pid:6056  tgid:6056  ppid:6047   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_nanosleep+0x113/0x500 kernel/time/hrtimer.c:2399
 hrtimer_nanosleep+0x14f/0x350 kernel/time/hrtimer.c:2445
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1360
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1383 [inline]
 __x64_sys_clock_nanosleep+0x336/0x480 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d2695d68e
RSP: 002b:00007fff2be14178 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000555579950500 RCX: 00007f4d2695d68e
RDX: 00007fff2be141d0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fff2be1423c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000064 R14: 0000000000034573 R15: 00007fff2be14290
 </TASK>
task:udevd           state:S stack:26552 pid:6062  tgid:6062  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a19069750
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27160 pid:6069  tgid:6069  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a19061bd0
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27464 pid:6072  tgid:6072  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a1907a870
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27832 pid:6073  tgid:6073  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a1907acf0
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27504 pid:6076  tgid:6076  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a1907a870
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27160 pid:6078  tgid:6078  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a19121cb0
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:udevd           state:S stack:27200 pid:6079  tgid:6079  ppid:4977   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 ep_poll fs/eventpoll.c:2332 [inline]
 do_epoll_wait+0x13f4/0x1770 fs/eventpoll.c:2811
 __do_sys_epoll_wait fs/eventpoll.c:2819 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2814 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2814
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd555fd2407
RSP: 002b:00007ffdc03e9e40 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fd555f46880 RCX: 00007fd555fd2407
RDX: 0000000000000004 RSI: 00007ffdc03e9ed0 RDI: 0000000000000004
RBP: 0000555a18e2c2c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000555a190e6b10
R13: 00007ffdc03e9ed0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:krxrpcio/7001   state:S stack:30504 pid:6107  tgid:6107  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rxrpc_io_thread+0x1950/0x3820 net/rxrpc/io_thread.c:574
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:krxrpcio/7001   state:S stack:30504 pid:6108  tgid:6108  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rxrpc_io_thread+0x1950/0x3820 net/rxrpc/io_thread.c:574
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:krxrpcio/7001   state:S stack:29840 pid:6109  tgid:6109  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rxrpc_io_thread+0x1950/0x3820 net/rxrpc/io_thread.c:574
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-bond0 state:I stack:31008 pid:6110  tgid:6110  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:krxrpcio/7001   state:S stack:30416 pid:6111  tgid:6111  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rxrpc_io_thread+0x1950/0x3820 net/rxrpc/io_thread.c:574
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:krxrpcio/7001   state:S stack:30552 pid:6112  tgid:6112  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rxrpc_io_thread+0x1950/0x3820 net/rxrpc/io_thread.c:574
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-bond0 state:I stack:29568 pid:6114  tgid:6114  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-bond0 state:I stack:30952 pid:6116  tgid:6116  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-bond0 state:I stack:30952 pid:6133  tgid:6133  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-bond0 state:I stack:30936 pid:6135  tgid:6135  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:29888 pid:6140  tgid:6140  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30952 pid:6141  tgid:6141  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6143  tgid:6143  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6144  tgid:6144  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30952 pid:6145  tgid:6145  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6146  tgid:6146  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6147  tgid:6147  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6148  tgid:6148  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30952 pid:6150  tgid:6150  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30952 pid:6155  tgid:6155  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:29840 pid:6156  tgid:6156  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30840 pid:6157  tgid:6157  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6167  tgid:6167  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:30952 pid:6168  tgid:6168  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:kworker/R-wg-cr state:I stack:31008 pid:6169  tgid:6169  ppid:2      task_flags:0x4208060 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 rescuer_thread+0xceb/0x14a0 kernel/workqueue.c:3678
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6207  tgid:6207  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6208  tgid:6208  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:S stack:29496 pid:6210  tgid:6210  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:R  running task     stack:26872 pid:6211  tgid:6211  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:29496 pid:6213  tgid:6213  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:26872 pid:6214  tgid:6214  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6219  tgid:6219  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6220  tgid:6220  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:S stack:29496 pid:6221  tgid:6221  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:R  running task     stack:26872 pid:6222  tgid:6222  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:29496 pid:6223  tgid:6223  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:26872 pid:6224  tgid:6224  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:dhcpcd          state:S stack:27160 pid:6226  tgid:6226  ppid:5272   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 poll_schedule_timeout.constprop.0+0xbe/0x1b0 fs/select.c:241
 do_poll fs/select.c:965 [inline]
 do_sys_poll+0x9a9/0xe90 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1112 [inline]
 __se_sys_ppoll fs/select.c:1092 [inline]
 __x64_sys_ppoll+0x2b5/0x350 fs/select.c:1092
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1ee648407
RSP: 002b:00007fff01bf4cb0 EFLAGS: 00000202 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00007fa1ee5be780 RCX: 00007fa1ee648407
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005561a1a191e0
RBP: 00007fff01bf4ff0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fff01bf4ff0 R11: 0000000000000202 R12: 00005561739395e0
R13: 00005561a1a07d40 R14: 0000000000000000 R15: 00007fff01bf4da0
 </TASK>
task:dhcpcd          state:S stack:27160 pid:6227  tgid:6227  ppid:5272   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_hrtimeout_range_clock+0x2d0/0x310 kernel/time/sleep_timeout.c:207
 poll_schedule_timeout.constprop.0+0xbe/0x1b0 fs/select.c:241
 do_poll fs/select.c:965 [inline]
 do_sys_poll+0x9a9/0xe90 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1112 [inline]
 __se_sys_ppoll fs/select.c:1092 [inline]
 __x64_sys_ppoll+0x2b5/0x350 fs/select.c:1092
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1ee648407
RSP: 002b:00007fff01bf4cb0 EFLAGS: 00000202 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00007fa1ee5be780 RCX: 00007fa1ee648407
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005561a1a191e0
RBP: 00007fff01bf4ff0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fff01bf4ff0 R11: 0000000000000202 R12: 00005561739395e0
R13: 00005561a1a07d40 R14: 0000000000000000 R15: 00007fff01bf4da0
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6229  tgid:6229  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6230  tgid:6230  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:S stack:29496 pid:6231  tgid:6231  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg1-0      state:R  running task     stack:26872 pid:6232  tgid:6232  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:29496 pid:6233  tgid:6233  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg2-0      state:R  running task     stack:26872 pid:6234  tgid:6234  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6247  tgid:6247  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
task:napi/wg0-0      state:S stack:29496 pid:6248  tgid:6248  ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 napi_thread_wait net/core/dev.c:7823 [inline]
 napi_threaded_poll+0x16f/0x4b0 net/core/dev.c:7891


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
