Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3F4FE2E5
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961279; cv=none; b=KpUwoilrp2RBa0OSQbKVgS8N4w4T3MZmyzgFUx3+GJcl//lUJIUYWgoVn/hVArAL/v6V8B3XuDKhn+zZqCBKvPCsE316CiSTw7pdmrgFNRWBKZ534aZ1obqgH5zgPKSo/oA2NrQSQlZkcTEIFNPn4qzxjPeuCPZJKtULPHMJv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961279; c=relaxed/simple;
	bh=+vncWgQ6RHhInwvFrSmJgHuUpYGRXfOxCpKNO2Ia5uE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y31IagEc8j4DvSxiKlX3z3wAEVYcIeIW1Zu/iKlkR50IAo9pm3YMFaulvw5+ksykB5+tLVFtAupMNEgiQJexDdIFUIRJP2L/j8hY3AJ3xJInjZCgEx8A6NqNIpt0x0tu+MxZmEjvSB9Gb34nLiDihzAzpv5F8PsHoWdUFmLz83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-80491594629so346246a34.1
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961273; x=1791566073;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Q00aSGiQepRYUiBsI7bdVcwGR1B6Hy8Kx2ra8qrs6w=;
        b=YL6LltYeOdXzKLtwi6FPZ2GZgEcvk5hjYEJGhI/eVZPf4tALVWPpgA2K/pESPKfC7N
         xdt6UEHvcAwtGuPaRfHbaQTKlzdufa9h6XzgbYYMStjr5447zc476vusi0jdrW2t7zXq
         J23Ajx2lgM3k3XPgECSdJoxZRYlYKycMTuXTAZBez0tdpZ/RZChJ23IcQA5GaGmm94X9
         SRoYns4uYqO4SDlIlVYV5LQqJUizal+u6klNNUs1zrvQ1Ro09GNyzaZhtg68Km5YQbEx
         HHSv8ryblSFMMSKVMfY1lGtl4PgfjfF/dONyye9blROvijO3NFJT2v4xQHJFnbzpYBES
         akmw==
X-Gm-Message-State: AFuF++km2o716HMVIb6E47HwiDq/xhR3d7yWV97xhFx0DlQzu0r3t1vD
	yU4reN9egxDyfYVAstxE0aC94iVQ1ZYYBc6aRNOOB4vVSZ41pTgvBN4ybHeYUnJ4NTH3o36eReW
	Na1QL9ZMirjYFvJIGNOqneRdP07vpRwfb4ZaQme/ZhflFtP7pDFO0EVpAn04=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2e4f:b0:4ec:1bf1:fa82 with SMTP id
 5614622812f47-4f30c3c40d8mr5361372b6e.46.1790961273477; Fri, 02 Oct 2026
 10:14:33 -0700 (PDT)
Date: Fri, 02 Oct 2026 10:14:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abfe679.b50370da.302ea9.000e.GAE@google.com>
Subject: [syzbot] [input?] [usb?] general protection fault in magicmouse_event
From: syzbot <syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    647f31f34d40 usb: typec: mux: ps883x: disable USB4 on inco..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1520e725580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad4fc9c8360b68e353f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1304e035580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14395b15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c172bce0fc8c/disk-647f31f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca35b0e9104a/vmlinux-647f31f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78549b92644c/bzImage-647f31f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 3980 Comm: syz.3.17 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:magicmouse_event+0x6d/0x160 drivers/hid/hid-magicmouse.c:556
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 f6 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 aa
RSP: 0018:ffffc900000079c8 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
RDX: 0000000000000003 RSI: ffffffff8600e461 RDI: 000000000000001c
RBP: ffff888114d0a900 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: ffffffff8ab25860
R13: ffff888114d0a988 R14: ffff888114d0a900 R15: ffff88812176c000
FS:  00007f20d2fee6c0(0000) GS:ffff8882683e2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20d2fedff8 CR3: 0000000114910000 CR4: 00000000003506f0
Call Trace:
 <IRQ>
 hid_process_event+0x37d/0x5a0 drivers/hid/hid-core.c:1572
 hid_process_report drivers/hid/hid-core.c:1730 [inline]
 hid_report_raw_event+0xb14/0x14c0 drivers/hid/hid-core.c:2109
 __hid_input_report.constprop.0+0x349/0x470 drivers/hid/hid-core.c:2180
 hid_ctrl+0x4a4/0x560 drivers/hid/usbhid/hid-core.c:486
 __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xdb2/0x3700 drivers/usb/gadget/udc/dummy_hcd.c:2019
 __run_hrtimer kernel/time/hrtimer.c:2067 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2124
 hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2141
 handle_softirqs+0x1d9/0x9b0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x168/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:211 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:221
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 56 e7 05 fa 48 89 df e8 de 3d 06 fa f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 65 93 f8 f9 65 48 83 3d d4 fe 98 05 00 74 16 5b
RSP: 0018:ffffc90001ec79f0 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff8881f5625fc0 RCX: 0000000000000040
RDX: 0000000000000001 RSI: ffffffff89329f40 RDI: ffffffff87d2b780
RBP: 0000000000000287 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881f5625fc0
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8881f5626008
 __mod_timer+0x409/0xca0 kernel/time/timer.c:1139
 add_timer+0x62/0x90 kernel/time/timer.c:1249
 schedule_timeout+0x122/0x280 kernel/time/sleep_timeout.c:98
 usbhid_wait_io+0x24e/0x420 drivers/hid/usbhid/hid-core.c:648
 usbhid_init_reports+0x1a7/0x390 drivers/hid/usbhid/hid-core.c:787
 hiddev_ioctl+0xddb/0x15b0 drivers/hid/usbhid/hiddev.c:794
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x119/0x710 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f20d31ae159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f20d2fee028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f20d3436090 RCX: 00007f20d31ae159
RDX: 0000000000000000 RSI: 00000000c018480b RDI: 0000000000000004
RBP: 00007f20d324506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f20d3436128 R14: 00007f20d3436090 R15: 00007fffb4a203d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:magicmouse_event+0x6d/0x160 drivers/hid/hid-magicmouse.c:556
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 f6 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 aa
RSP: 0018:ffffc900000079c8 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
RDX: 0000000000000003 RSI: ffffffff8600e461 RDI: 000000000000001c
RBP: ffff888114d0a900 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: ffffffff8ab25860
R13: ffff888114d0a988 R14: ffff888114d0a900 R15: ffff88812176c000
FS:  00007f20d2fee6c0(0000) GS:ffff8882683e2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20d2fedff8 CR3: 0000000114910000 CR4: 00000000003506f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 89 da             	mov    %rbx,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 f6 00 00 00    	jne    0x107
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 1b             	mov    (%rbx),%rbx
  1e:	48 8d 7b 1c          	lea    0x1c(%rbx),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2d:	48 89 f8             	mov    %rdi,%rax
  30:	83 e0 07             	and    $0x7,%eax
  33:	83 c0 01             	add    $0x1,%eax
  36:	38 d0                	cmp    %dl,%al
  38:	7c 08                	jl     0x42
  3a:	84 d2                	test   %dl,%dl
  3c:	0f                   	.byte 0xf
  3d:	85                   	.byte 0x85
  3e:	aa                   	stos   %al,%es:(%rdi)


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
