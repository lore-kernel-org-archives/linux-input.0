Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7215678FE
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191055; cv=none; b=M01h2MgWDwu1GR/LE9Vk74Cug4l0AAQnOi+NOn0mktmJwFPOF2wcXh8cghNtODOUbb2gzNDfSAUqXAa1xIi9yjfARfVpyVIRoHbGokATDl+sC5kYcwFqzNLcFw+cB3IDuvjEtOtW8NjlkZXlRc+u2YDCh2HfwbdAOounC0ObBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191055; c=relaxed/simple;
	bh=KNeZYqv1qqBmNXGjtRN/RTiEqIORcMewUNE2mQ6sVsA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g5axLxcBJ3Fz6CmjaelU4yRrdkH9Yn7JIni4ZmHZXVIBAdPcR0EYp5MYzHc10n0/JvPIzPLxYsqcQ/J8g854eaO3tqRjEVOlj/yZFF2OpqOtek0xmJj/hzjUwYs73vVlLn/rM9+GEYrQsQzJOFT7af4N1DxGiK8l1sTOVDteY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f9.google.com with SMTP id 46e09a7af769-7f66624aa21so304135a34.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 12:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191052; x=1790795852;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OblOzNeCp6MZCxaIVDhBcy5pXcmm1x7ohpRP9JKByGM=;
        b=qIGVAGsziNthx3mSvsQLOw4cbSyjPy0G3R8MUB0+mFujuw8urfFMBonBDR61RRwOEv
         Cc9Cq3W0HFOm9uM9mnFsveNHOLd2Rwr5msHcaPs/XhjBCO36RPCxOxX6mW6SINGP8hzQ
         govAAEI14czkA+xWCxLevulVTXr+0RTFNQ9BcXPxCaJQk78qcHo0hMIAfE7O68Ls/EyE
         cGe/rFVTc1AQ5JLdKlhl4Vf0QXJLPRq/AM8+2yuks2zaR5fNbWVv3i29JMDFF6EJzM1P
         iOpZxKAKZXAHo1Bx/cpDEWgHh3reSwfk2iLl90k5nPA1rOCjH+iBaG5S60lvledQudyv
         AKCQ==
X-Forwarded-Encrypted: i=1; AKwUvByGS83ufsl9ACgmaBBuWuHSCPY6apDUxN3iLIQMSC/r+jmWOjUtI2faYXhKwjyzmccci4ipmpGfPumnRg==@vger.kernel.org
X-Gm-Message-State: AFuF++nj5pJO/JKzGz0iQ2iqWJ47G/+z3XntCZecTzqJ1X5Q7EpzzJBs
	788dd0rhKvhIfF60DspgfYYeQZYH7BrvEafjoFeRpHjfMb6nSIwiaHRqwJGk+DoEF6lL0FmQRw8
	XfOQrT4QZBYy41baYLKBDQHeROo4pVpRMBOvkrsHlg3sh6DA/47v/QE7fx6o=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81cf:b0:6be:4eb3:e1c0 with SMTP id
 006d021491bc7-6d4411d1ecemr218095eaf.45.1790191052103; Wed, 23 Sep 2026
 12:17:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:17:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab425cc.7428d045.30104c.0003.GAE@google.com>
Subject: [syzbot] [input?] general protection fault in wacom_intuos_irq
From: syzbot <syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jason.gerecke@wacom.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ping.cheng@wacom.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a02405580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=b5a7cd83622c747977de
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a02405580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f57805580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/303a0ade8f9e/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70b8ca71442b/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000065: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000328-0x000000000000032f]
CPU: 0 UID: 0 PID: 6729 Comm: syz-executor606 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:wacom_intuos_irq+0x62b/0x3430 drivers/hid/wacom_wac.c:1036
Code: c3 cc cc cc cc e8 25 81 f3 f8 48 8b 04 24 44 0f b6 c5 48 8d b8 28 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 27 00 00 48 8b 04 24 48 c7 c7 78 ea 3e 91 48
RSP: 0018:ffffc90006fcf9e0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880574900ae RCX: 0000000000000000
RDX: 0000000000000065 RSI: ffffffff8917e0ab RDI: 0000000000000328
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000011
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
R13: ffff88804f755048 R14: 0000000000000000 R15: 0000000000000021
FS:  0000000000000000(0000) GS:ffff888096960000(0063) knlGS:0000000057c2a3c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004c95e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 wacom_bpt_irq drivers/hid/wacom_wac.c:3290 [inline]
 wacom_wac_irq+0x196b/0xab80 drivers/hid/wacom_wac.c:3560
 wacom_raw_event+0x6db/0xbf0 drivers/hid/wacom_sys.c:182
 __hid_input_report.constprop.0+0x319/0x470 drivers/hid/hid-core.c:2175
 uhid_dev_input2 drivers/hid/uhid.c:609 [inline]
 uhid_char_write+0x9dc/0xfe0 drivers/hid/uhid.c:767
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x1f8/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7e60fec
Code: Unable to access opcode bytes at 0xf7e60fc2.
RSP: 002b:00000000ff8b597c EFLAGS: 00000213 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000080000300
RDX: 0000000000000010 RSI: 00000000000000a2 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:wacom_intuos_irq+0x62b/0x3430 drivers/hid/wacom_wac.c:1036
Code: c3 cc cc cc cc e8 25 81 f3 f8 48 8b 04 24 44 0f b6 c5 48 8d b8 28 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 27 00 00 48 8b 04 24 48 c7 c7 78 ea 3e 91 48
RSP: 0018:ffffc90006fcf9e0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880574900ae RCX: 0000000000000000
RDX: 0000000000000065 RSI: ffffffff8917e0ab RDI: 0000000000000328
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000011
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
R13: ffff88804f755048 R14: 0000000000000000 R15: 0000000000000021
FS:  0000000000000000(0000) GS:ffff888096960000(0063) knlGS:0000000057c2a3c0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7e61000 CR3: 000000004c95e000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	e8 25 81 f3 f8       	call   0xf8f3812f
   a:	48 8b 04 24          	mov    (%rsp),%rax
   e:	44 0f b6 c5          	movzbl %bpl,%r8d
  12:	48 8d b8 28 03 00 00 	lea    0x328(%rax),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d4 27 00 00    	jne    0x2808
  34:	48 8b 04 24          	mov    (%rsp),%rax
  38:	48 c7 c7 78 ea 3e 91 	mov    $0xffffffff913eea78,%rdi
  3f:	48                   	rex.W


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
