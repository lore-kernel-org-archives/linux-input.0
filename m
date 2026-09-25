Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B135839C
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305959; cv=none; b=MhmIsQjdKuW2wd9hdXc8G6jzVuooL1AHqBvMNyOMe1Kn6f/vdkZ73CyRZf2gVTlgGXxQrYH7l+Tj5A4WkX87aEsU5JkefU+tZGkMxrvEHB6vrQLMJoatcEM2In90j/AdX+yCPy34uegkIykl43BqfAffp7m5ayg+1t+Ird0ixz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305959; c=relaxed/simple;
	bh=BEGQyAViAFvo9buNB17wzKBw6fwyufkWzHqjSUbgeUY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D6bkKoUta6Pjc/iv9LtrJ5Hrbh51QPo83I7HAD2t+JoYZDYypH6qXDJMDTUCRUDYf3okPTt8l0bHdNGHpnE7dVk20UXU/qr3yirSE1A9bL6jl1N67m8pHVaaDey+bARqADfmSFv4mL0tuKDcq2JjdxgmSYgKv2Pg4G5G8+GtGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4dc57e2a3f2so416295b6e.0
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 20:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790305957; x=1790910757;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY0NX4ApRysCA7uTZsdZ7zWqUDLZEMeIYv6ocAtfnU0=;
        b=eb4/Ger3NxhcIBK2ajCAtNRldXGIcPcNSpjMmNc0hpFKsI//Um7jL7YB7Q10N9IsQR
         BvdOldJ6BO9A+fKh7wVczTlTNJ/Zfrx9w8S4RO5oEs3R5seUPoyro30P0gO9GngEhL1r
         6K6YOjVZ+l8aeARpWxHp78kooL+lLAEtpAjosGe/sYxAZGSJh9c4axt8pBM4Um933HJw
         TVEQxIVbqbX09YAiAHbqcALKqhbu5lBeg+heYdIPH+rFxaLdFLt+8UF5Q2zKXJZUwD6C
         loSHsxG2VgT0z04r4XwHZuugrxX6jKwgPpuLc/gz+1q3T3hAfLFt+xtKApmrySn2lGj/
         2dTg==
X-Forwarded-Encrypted: i=1; AKwUvBxsJ+91mkmjOQZMOD4y/0rVdqElmAtyjdLJD4rLR4rKDrs2LqNLXuxPMK7l8VkX4Lb9FnhPcr7AyeS15w==@vger.kernel.org
X-Gm-Message-State: AFuF++m1hk8UnASL0t5MbxRo2KI4jDh/8CFAmsHOkG/FwXoxf9j+QpXY
	yQnXjYHk7zak5mgL0P5N/Ef7WOwz2pMKL1HW1PBGum3xr1XhEccsIQjILMZtRjH/e9oyhuYTR12
	mS8khCJ3S/WKmL7T48mEveCBXFTymnmAqdJa7d5jMD1OQuLw/KQb3leu6gxQ=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:190c:b0:4d6:92d4:c804 with SMTP id
 5614622812f47-4d72bc45aacmr5565913b6e.60.1790305957037; Thu, 24 Sep 2026
 20:12:37 -0700 (PDT)
Date: Thu, 24 Sep 2026 20:12:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab5e6a5.80e1c6cc.1e8e5f.0022.GAE@google.com>
Subject: [syzbot] [input?] general protection fault in wacom_report_numbered_buttons
From: syzbot <syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jason.gerecke@wacom.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ping.cheng@wacom.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62f4c998b297 Merge tag 'parisc-for-7.3-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135c9d15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae7f998154426e723cbf
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bb9c05580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fdc2c9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-62f4c998.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c666932d3795/vmlinux-62f4c998.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70accf49dc19/bzImage-62f4c998.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000006c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
CPU: 2 UID: 0 PID: 6256 Comm: syz.0.237 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dev_get_drvdata include/linux/device.h:991 [inline]
RIP: 0010:input_get_drvdata include/linux/input.h:396 [inline]
RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wac.c:4225
Code: f5 53 48 89 fb 48 83 ec 10 48 89 3c 24 e8 71 92 f1 f8 48 8d bb 60 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 b7 01 00 00 48 8b 04 24 4c 8b a0 60 03 00 00 49
RSP: 0018:ffffc90027b5f9a0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000006c RSI: ffffffff891a901f RDI: 0000000000000360
RBP: 0000000000000008 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000002a8 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558f635500(0000) GS:ffff8880d5d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000003797a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 wacom_intuos_pad drivers/hid/wacom_wac.c:643 [inline]
 wacom_intuos_irq+0x2f8/0x3430 drivers/hid/wacom_wac.c:1042
 wacom_bpt_irq drivers/hid/wacom_wac.c:3290 [inline]
 wacom_wac_irq+0x196b/0xab80 drivers/hid/wacom_wac.c:3560
 wacom_raw_event+0x6bb/0xba0 drivers/hid/wacom_sys.c:183
 __hid_input_report.constprop.0+0x319/0x470 drivers/hid/hid-core.c:2175
 uhid_dev_input2 drivers/hid/uhid.c:609 [inline]
 uhid_char_write+0xb6b/0x10e0 drivers/hid/uhid.c:767
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x1f8/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e4899e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee1ed0688 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6e48c25fa0 RCX: 00007f6e4899e159
RDX: 0000000000000010 RSI: 0000200000000300 RDI: 0000000000000003
RBP: 00007f6e48a3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6e48c25fac R14: 00007f6e48c25fa0 R15: 00007f6e48c25fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_get_drvdata include/linux/device.h:991 [inline]
RIP: 0010:input_get_drvdata include/linux/input.h:396 [inline]
RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wac.c:4225
Code: f5 53 48 89 fb 48 83 ec 10 48 89 3c 24 e8 71 92 f1 f8 48 8d bb 60 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 b7 01 00 00 48 8b 04 24 4c 8b a0 60 03 00 00 49
RSP: 0018:ffffc90027b5f9a0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000006c RSI: ffffffff891a901f RDI: 0000000000000360
RBP: 0000000000000008 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000002a8 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558f635500(0000) GS:ffff8880d5d53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000003797a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 89 fb             	mov    %rdi,%rbx
   5:	48 83 ec 10          	sub    $0x10,%rsp
   9:	48 89 3c 24          	mov    %rdi,(%rsp)
   d:	e8 71 92 f1 f8       	call   0xf8f19283
  12:	48 8d bb 60 03 00 00 	lea    0x360(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 b7 01 00 00    	jne    0x1eb
  34:	48 8b 04 24          	mov    (%rsp),%rax
  38:	4c 8b a0 60 03 00 00 	mov    0x360(%rax),%r12
  3f:	49                   	rex.WB


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
