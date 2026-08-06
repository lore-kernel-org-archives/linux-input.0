Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CCCA6B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974494; cv=none; b=oggy3N8MpR+7sGB3flLEEm6MXnXK01Ukj7YLaGG++ieNdkiHbj36BBEnWLg08ju9QCbr7r0bY9rV0VoMc1WJKku5HZxKkPLZtGA4NX3hQzwaYNd5OglciGmSoja4df3hLTQ+v9B/VY4WVKjpyXwF+iPiQtxTQnvVMWD3UNUXMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974494; c=relaxed/simple;
	bh=B04ygfIgQXOvi69UA5sVP7pGlaMwq5/5VQpk4MreyBA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q4441z5IFQ5Rvrua8G65KgrCFGawxcL4g/tSXhWYFncW+8fEq6+i0pbGk8MuxBVPvLo2STJYEp1ZA9IdZuV6X9SaTkPWdNbR93uYq3Nx21xiAwPADNcST+sUlZXDR+m1yuWlMy8LwGTftqp12+WCjEve6I4F1/yZxRS1S0aO9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9fc6dc091so1276227a34.2
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 17:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974491; x=1786579291;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31zx18yk6ThXUw/fy3wZUkl6sFqEwujzgZRw5o7QV0I=;
        b=pIW1XnuOFD3/HR+7APYQ/jG/mQoA6UwYsoXpAggPqQ6+R5lcHur5q2DnfryPHbSXOj
         dWWPTHBtL/nzNbOFQeJ97TDTOD3fxGVzFYoRmnpeYV2m+C6Y/1RGsctH/fbccpDK8wxv
         gWlONYyB2oH8MhQLVjhG7eUzCjzfvzUPyrWf0sNjv/UTVwR1oBIDNDAQ03WTim4oYpRR
         duoxiKFDwVHesToaV1elbzsvhlFatkdYNORjeII37u0UQk2uTdS3xYst26NUjycmkjjb
         Jh4EeLwwZyO0YUwKHUv8elEFhbuW8uvEoY122Yaz8bE4+xS/YTT1uQ3jSsZxbh4KV2Au
         Prug==
X-Forwarded-Encrypted: i=1; AHgh+RqFF0G4TjhFll0kFw6VrT9hnC1+J20xPjMXvNBYlQtkDflowe1yC/aiDzz2gV/ubeihrXsYqet1zOGqng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxggk2rmtfjBx8u2fWBSSUlS2ptwhBRQQQSHprVZ4vCONGHJlUb
	EKL8CPDZ0z6T4a+CBCbzNhOa96Npk+T41XbC8SqtAIijoLDNeTpRDHAEuFF6u2ULTh9HcUoo00b
	arcDCGvxMwABtsR2QI68jeeRGQDVcqtXk2zTOc9lI6+vJpDUO/uY91SpRazk=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e841:0:b0:6aa:e10e:649c with SMTP id
 006d021491bc7-6ae96f8076amr5657475eaf.26.1785974491110; Wed, 05 Aug 2026
 17:01:31 -0700 (PDT)
Date: Wed, 05 Aug 2026 17:01:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73cedb.5aeeccc9.207e63.0009.GAE@google.com>
Subject: [syzbot] [input?] general protection fault in rmi_driver_suspend
From: syzbot <syzbot+09103639e39c989e3ed3@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12094bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=09103639e39c989e3ed3
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b27649580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/375d27e96ecb/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ba19a656b9d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c2a17aaee7c/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09103639e39c989e3ed3@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 1 UID: 0 PID: 1035 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: pm pm_runtime_work
RIP: 0010:dev_get_drvdata include/linux/device.h:989 [inline]
RIP: 0010:rmi_suspend_functions drivers/input/rmi4/rmi_driver.c:283 [inline]
RIP: 0010:rmi_driver_suspend+0x30/0x180 drivers/input/rmi4/rmi_driver.c:994
Code: 57 41 56 41 55 41 54 53 50 89 74 24 04 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 6b c7 5e fa 4c 8d 73 78 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 e2 3a c8 fa 4d 8b 36 4c 89 f0 48 c1
RSP: 0018:ffffc90005f67670 EFLAGS: 00010206
RAX: 000000000000000f RBX: 0000000000000000 RCX: ffff888027c58000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff88838110 R12: dffffc0000000000
R13: 0000000000000003 R14: 0000000000000078 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cc63fff CR3: 000000003c77c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rmi_suspend+0xa7/0xf0 drivers/hid/hid-rmi.c:448
 hid_suspend+0x4a3/0x530 drivers/hid/usbhid/hid-core.c:1618
 usb_suspend_interface drivers/usb/core/driver.c:1323 [inline]
 usb_suspend_both+0x285/0x1040 drivers/usb/core/driver.c:1446
 usb_runtime_suspend+0x58/0x110 drivers/usb/core/driver.c:2000
 __rpm_callback+0x2d6/0x930 drivers/base/power/runtime.c:406
 rpm_callback drivers/base/power/runtime.c:460 [inline]
 rpm_suspend+0x8a0/0x17a0 drivers/base/power/runtime.c:698
 pm_runtime_work+0x132/0x1b0 drivers/base/power/runtime.c:-1
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_get_drvdata include/linux/device.h:989 [inline]
RIP: 0010:rmi_suspend_functions drivers/input/rmi4/rmi_driver.c:283 [inline]
RIP: 0010:rmi_driver_suspend+0x30/0x180 drivers/input/rmi4/rmi_driver.c:994
Code: 57 41 56 41 55 41 54 53 50 89 74 24 04 48 89 fb 48 bd 00 00 00 00 00 fc ff df e8 6b c7 5e fa 4c 8d 73 78 4c 89 f0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 f7 e8 e2 3a c8 fa 4d 8b 36 4c 89 f0 48 c1
RSP: 0018:ffffc90005f67670 EFLAGS: 00010206
RAX: 000000000000000f RBX: 0000000000000000 RCX: ffff888027c58000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff88838110 R12: dffffc0000000000
R13: 0000000000000003 R14: 0000000000000078 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cc63fff CR3: 000000003c77c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	57                   	push   %rdi
   1:	41 56                	push   %r14
   3:	41 55                	push   %r13
   5:	41 54                	push   %r12
   7:	53                   	push   %rbx
   8:	50                   	push   %rax
   9:	89 74 24 04          	mov    %esi,0x4(%rsp)
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  17:	fc ff df
  1a:	e8 6b c7 5e fa       	call   0xfa5ec78a
  1f:	4c 8d 73 78          	lea    0x78(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 e2 3a c8 fa       	call   0xfac83b1a
  38:	4d 8b 36             	mov    (%r14),%r14
  3b:	4c 89 f0             	mov    %r14,%rax
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1


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
