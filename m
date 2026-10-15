Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174B3DBD60
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053158; cv=none; b=O3O3W+mjWmkSyvcZDlmlj0OzBRsyjQEyrqLb3OZ+tgw4KTJMTicOctAnDuww+Kez8/aakU/VxR2z8I4wS3yolX+yC7GoE2DLJW05FFxMEsEiDhWVVmQa7+Rls94mZYwc3Ag/IXcmcUbStiGac6AcLWpH3izzHhFAeKkSjb3cDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053158; c=relaxed/simple;
	bh=trsxjJs4a5p0t0lDB7Iuc9bAOM8VgarbgPTTsfU4A9E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qy6dfxjTYtPrJdlVhU9sSuVL7nDtLVL/wswcN3mNxK1JJI0ZKcaQG56e8ax6srT7gttap+wGtmsk8gEl2+qxmQM4bVpw5XZgaXRxIAD0k+aWXJ+gzUD2RiqNxNfygW2rwrYcvcoRgXeM+7jT9chGcfM8vgJ71tJxfVeem/NKLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4f8281066c4so8098294b6e.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 01:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053155; x=1792657955;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rr8KpN9JHoF6KJIZzWxfKkUMUAtkKXqxWnSrskXy1Q=;
        b=UPNOhaQBEmB4LkqztkDDEscMhjQoXyI2Eg6cqkP4nHLc5rcScWCv09/cwWUysnegxE
         YMlTidMvSAifDA8tsEWVYPG1FHYhSQjxhq0F900vYKoSSkAQrE8EcGTxGCDqEL45NPnQ
         12SCMfbI2mKLxFZM1HDVOFXsLW90cLG0fPR53dpeo19LM22Auqs7NcMI4H2lhkZFKmSF
         HzOdeuOmNQQFp79SiRziOjLWC4H+EOJQPYzWDS7JV2iH/2WRJBJmdevPy5CYLnTG/h7j
         8DFh49G81SFxnEPLC7VovOqbGrEmkwTzB+ujqYKsEb4owkVu+tOv/Iy+Bw+8N73FDVQF
         1KgQ==
X-Gm-Message-State: AFq9FYLhBFSlpI67EmiM7Kx2n4XmhfvVu4vkjbraAapd81Bt0wSvmZq7
	KBhuSgAQ2jmaXeiMIbb28YIknljjQExwBylLGs6TTW80/Nt+2gAr/OLT7ShiNs3/XVBZK4kBfdq
	0zb/gX+kW20zxXhRHnJQyCqz0HXuP64+A4UO6/VvcmOJo4uv9VycgrLZRIO0=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8c:b0:4c1:f40e:b697 with SMTP id
 5614622812f47-50c56bf8ed8mr15803938b6e.38.1792053155521; Thu, 15 Oct 2026
 01:32:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 01:32:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad08fa3.a150a118.27e199.006c.GAE@google.com>
Subject: [syzbot] [input?] [usb?] general protection fault in saitek_event
From: syzbot <syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5ebb76233b7 Merge tag 'edac_urgent_for_v7.3_rc7' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fa29c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4118aaa2d227be26
dashboard link: https://syzkaller.appspot.com/bug?extid=eba2b3201bd25a97cddf
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158511d1580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733f435580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2a7c6a3f91d/disk-a5ebb762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d9d6d2a348b/vmlinux-a5ebb762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/454e9cb8662e/bzImage-a5ebb762.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
RIP: 0010:saitek_event+0x51/0x2b0 drivers/hid/hid-saitek.c:154
Code: aa f8 49 83 c6 78 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 4d 5a 1b f9 4d 8b 36 49 83 c6 18 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 30 5a 1b f9 49 8b 06 48 89 04 24
RSP: 0018:ffffc90000007830 EFLAGS: 00010006
RAX: 0000000000000003 RBX: ffff88801c7ed988 RCX: ffffffff8fa8f000
RDX: 0000000000000100 RSI: 0000000000000100 RDI: ffff8880773c8000
RBP: 000000000000008d R08: 0000000000000000 R09: 0000000000000000
R10: ffff88801c7ed9a8 R11: ffffffff891d95c0 R12: ffffffff910c0c68
R13: dffffc0000000000 R14: 0000000000000018 R15: ffff8880773c8000
FS:  0000000000000000(0000) GS:ffff888123abf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50c9650ff8 CR3: 000000007ea2a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 hid_process_event+0x436/0x620 drivers/hid/hid-core.c:1572
 hid_process_report drivers/hid/hid-core.c:1730 [inline]
 hid_report_raw_event+0xf6a/0x1900 drivers/hid/hid-core.c:2109
 __hid_input_report+0x454/0x580 drivers/hid/hid-core.c:2180
 hid_ctrl+0x204/0x580 drivers/hid/usbhid/hid-core.c:486
 __usb_hcd_giveback_urb+0x378/0x540 drivers/usb/core/hcd.c:1657
 dummy_timer+0xa91/0x4cc0 drivers/usb/gadget/udc/dummy_hcd.c:2023
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2131
 hrtimer_run_softirq+0x1e3/0x2e0 kernel/time/hrtimer.c:2148
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: 0b 8b 02 e9 c3 08 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e3 c5 20 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8fa07ca0 EFLAGS: 00000246
RAX: 00000000000a1669 RBX: ffffffff819becb0 RCX: 8000000000000001
RDX: 0000000000000001 RSI: ffffffff8e4696a9 RDI: ffffffff8c6dde80
RBP: ffffffff8fa07d78 R08: ffff8880b8433a1b R09: 1ffff11017086743
R10: dffffc0000000000 R11: ffffed1017086744 R12: 0000000000000000
R13: 1ffffffff1f51e00 R14: 1ffffffff1f40f9c R15: dffffc0000000000
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 rest_init+0x378/0x3a0 init/main.c:732
 start_kernel+0x392/0x3e0 init/main.c:1190
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x157
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:saitek_event+0x51/0x2b0 drivers/hid/hid-saitek.c:154
Code: aa f8 49 83 c6 78 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 4d 5a 1b f9 4d 8b 36 49 83 c6 18 4c 89 f0 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 30 5a 1b f9 49 8b 06 48 89 04 24
RSP: 0018:ffffc90000007830 EFLAGS: 00010006
RAX: 0000000000000003 RBX: ffff88801c7ed988 RCX: ffffffff8fa8f000
RDX: 0000000000000100 RSI: 0000000000000100 RDI: ffff8880773c8000
RBP: 000000000000008d R08: 0000000000000000 R09: 0000000000000000
R10: ffff88801c7ed9a8 R11: ffffffff891d95c0 R12: ffffffff910c0c68
R13: dffffc0000000000 R14: 0000000000000018 R15: ffff8880773c8000
FS:  0000000000000000(0000) GS:ffff888123abf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50c9650ff8 CR3: 000000007ea2a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	aa                   	stos   %al,%es:(%rdi)
   1:	f8                   	clc
   2:	49 83 c6 78          	add    $0x78,%r14
   6:	4c 89 f0             	mov    %r14,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 4d 5a 1b f9       	call   0xf91b5a69
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	49 83 c6 18          	add    $0x18,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 30 5a 1b f9       	call   0xf91b5a69
  39:	49 8b 06             	mov    (%r14),%rax
  3c:	48 89 04 24          	mov    %rax,(%rsp)


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
