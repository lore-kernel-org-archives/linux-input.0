Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0273ACA4E
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451116; cv=none; b=AGeJCySxVUmLcSAhYwbEa+FtBulGf1sjhjFXdHAo7lrcs+1KuNlmh8y9mA76+2VyFcd/JF8OqZa6h9CxKSWMFBz1emG0svFT/6N5ytGoF9UeK1lDIfkB0W8VPm60hCqlFmLheEJhvYFmCBMaogZ29pzIoc5jXa6NpDqLK14d+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451116; c=relaxed/simple;
	bh=5w3uSfJaIBrZw+waj4F921tJffJaJeBAayDo58EvVYo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OdfA/YNHw+FZsf99WK5DixvKOChhBdNcVerUrq8rmJ8cKXKDglAlLLOcXzP34BuTNYMrAp8+4bsXcrEdGfXo9u+1T/wQUokX2z4bYRDS/snMITLbB+a6KSJoS/XsLoTb4d+84fjlq4QYaoE/X49WHI51WaGdoWif5mpPqOJ9cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-46adea418f3so480110fac.1
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451113; x=1789055913;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOzGqp3OwBh6k+SZ5NV8DGENeJLmQwfLAYI0Ib0FeE0=;
        b=F/ucPn5TWamYKKc0JIHoC77S6UmyF5tvNHrokJySMjFMNnJL7q5Woe2Nt8ENHgCju9
         YxgaR8m+AKArfdxlhC05JRzlH5/vSj0ITth55ObA2ZI40sqnbwsyBvZJj7LOtaRItAAL
         loA83M84Jy0/hi1kzOKThmiip07TsYeo79geYqQ/0VHzrrmBoHwrtahgP13cZ0F3N4Sc
         QIf2pdmbNeG94rqZVDjlC5BmMVeCAc0MoliR1DuVRFGTUZe/gg90wdw6vR5ly51kqzWK
         yFLgPQFidQ2canme55SRdOMkkT4hPHzQPQrANmPAaCoOqRH2dfadVF3wORgoAIlC6Eh5
         ke8g==
X-Forwarded-Encrypted: i=1; AKwUvBxh4HAc6fVCnWRDueW1iISdUpr4EZTft6vxJ3nwrDLw6D62xhFikGZNoRXzXa44rtW+Ph4k/KQ4cMBRMQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n85IE2ZckQAg+XlOSnUl5iu0GI097TQTWeQucUYj5pV/RSUzYt
	F+fOs1AG1CPoenCrG2K+Ju9oaDspt8W3qjVtI3r5Y/itqhA1nxfjCF7Z5dxnipdLfnso4GIVIvK
	GSno7SziacSPAulqNl7SubycH7vwxmb59QeW3OPQuLDYKJ6XjcKgKmiWjr/I=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:820:b0:6a1:3e91:dcac with SMTP id
 006d021491bc7-6b481b368cfmr9221469eaf.31.1788451113296; Thu, 03 Sep 2026
 08:58:33 -0700 (PDT)
Date: Thu, 03 Sep 2026 08:58:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a999929.f03f19fe.169578.0006.GAE@google.com>
Subject: [syzbot] [input?] WARNING in roccat_open
From: syzbot <syzbot+e7b6bbf6cf88d7d932c3@syzkaller.appspotmail.com>
To: bentiss@kernel.org, erazor_de@users.sourceforge.net, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf1079577a11 Merge tag 'sched_ext-for-7.3-rc1-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a93b79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=e7b6bbf6cf88d7d932c3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de4b27952d35/disk-bf107957.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b26d9a76bae1/vmlinux-bf107957.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b66563d96cd9/bzImage-bf107957.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7b6bbf6cf88d7d932c3@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#1: syz.2.2708/15053
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x944/0x1bd0 kernel/locking/mutex.c:821, CPU#1: syz.2.2708/15053
Modules linked in:
CPU: 1 UID: 0 PID: 15053 Comm: syz.2.2708 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x94b/0x1bd0 kernel/locking/mutex.c:821
Code: 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 c0 10 00 00 44 8b 05 e8 16 74 05 45 85 c0 75 13 48 8d 3d ac 21 77 05 48 c7 c6 e0 f3 ef 8b <67> 48 0f b9 3a 90 e9 1b f8 ff ff 4d 8d a7 f0 0a 00 00 4c 89 e7 e8
RSP: 0018:ffffc90002dc7790 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff88807e76b080 RCX: 1ffffffff228a580
RDX: 0000000000000000 RSI: ffffffff8beff3e0 RDI: ffffffff914836d0
RBP: ffffc90002dc7900 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88807e76b008
FS:  00007f7de7f066c0(0000) GS:ffff888123c64000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f0aff8 CR3: 0000000033da6000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 20000000000001f8 DR2: 0000000000000002
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 roccat_open+0x105/0x660 drivers/hid/hid-roccat.c:178
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
 do_dentry_open+0x6ab/0x14d0 fs/open.c:996
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7de6f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7de7f06028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7de7225fa0 RCX: 00007f7de6f9e159
RDX: 0000000000000002 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007f7de7035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7de7226038 R14: 00007f7de7225fa0 R15: 00007ffdf6e37348
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	38 d0                	cmp    %dl,%al
   6:	7c 08                	jl     0x10
   8:	84 d2                	test   %dl,%dl
   a:	0f 85 c0 10 00 00    	jne    0x10d0
  10:	44 8b 05 e8 16 74 05 	mov    0x57416e8(%rip),%r8d        # 0x57416ff
  17:	45 85 c0             	test   %r8d,%r8d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d ac 21 77 05 	lea    0x57721ac(%rip),%rdi        # 0x57721cf
  23:	48 c7 c6 e0 f3 ef 8b 	mov    $0xffffffff8beff3e0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1b f8 ff ff       	jmp    0xfffff850
  35:	4d 8d a7 f0 0a 00 00 	lea    0xaf0(%r15),%r12
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
