Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6830C168
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660455; cv=none; b=L5Bb/3QYPTxBJcox7TQkPwbPDSyDDGIP+c5Sc7ZzgJIF+Vj0I16QReIVk1MhLyuC0jWBzcEaextUDNrhDY8PFl7KGCrcI6t6gO/mnw+Q1s6SjqTYeeCM12KegHzOWSpyPfx+de+vSj0W1JGkU9S7rAhtrOtn0okvBdcDLTbPs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660455; c=relaxed/simple;
	bh=gztWfCq/vgHwaRddjXmXRhV5bycCMcFDGUBN8zECPXI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=To47Ij6TCKknHnfRevQMQEkhzZbbenTcL1hv/+hbCaLr4wYKeU6yDdzyl/L5E41bC77E87VfBByQiXxE7oqsKAtFpeNbQpiNOKNlXpb44eTSQVapJ8Tu+Uu0itm2M74ZAoc4xGffLVrrh1Oviih2AsiQB3lEZGCBaQSDOBNrx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-46adea418f3so781001fac.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 19:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788660452; x=1789265252;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srPOfqJi5oSn7adtwegC18uxRYHW7fCgQ8V5uhp5GPk=;
        b=k0+IXfacokw85ZIATDUxjPGoxE05EeMlGWHMho0WU43mP0F189uE1olULAK1eBP3rl
         QDFNM5eym+WZYlwX109qUThOrkZHixL1XrLb2MHlEZ8xo3r65dAjrMGvVbd3LmaSfEm/
         Nnuc7JqxCo+CXWeeoHIiLZr34y8VmUwXLxZP3ORQBI9Jyf/dfai/0SJV/zejf1mgkar6
         uZEBBMEUbvDvZ6O8V80qEITCGEeFvwTwfMPFBxdJaI1fyOkIDisrEBXVO6LRq7nCd5B3
         RuAFDxOrQWpoAU8CUS4bJ764v1H4OHRn5HUzxwDkfmIlnms3JMmd4O7EAwQFn3xTP2Vl
         Wgqg==
X-Forwarded-Encrypted: i=1; AKwUvBxxKud5qtP/tJ/PN/NggBzefx5pERAvmZasuDF6zuzn56/VcBLeEa4YoIKPNAafzlBjETP8tAyDl+VBeA==@vger.kernel.org
X-Gm-Message-State: AFuF++nf88KW0scU1lgDFk5tu+djHeHIbQao19h3LJL4yj4LV2XbOMH+
	oOmoVp8ZUNg2lNdJvtRHc/PMdSDBlQMzySSMmYu/dLiSkG4QOCT+e+L5fjSm77QrwnzbqxIy/VM
	5qsyEQd3GHpuw5SD3RU5RJpNfxHPybi7NYylIfjoYekl1mvOl8KnQpmANCZw=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c2c1:10b0:6b7:46fc:1e4 with SMTP id
 006d021491bc7-6b746fc0349mr6003032eaf.67.1788660452543; Sat, 05 Sep 2026
 19:07:32 -0700 (PDT)
Date: Sat, 05 Sep 2026 19:07:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ccae4.37659fcc.e790.0006.GAE@google.com>
Subject: [syzbot] [input?] INFO: trying to register non-static key in roccat_open
From: syzbot <syzbot+9f7405999979761b6cfc@syzkaller.appspotmail.com>
To: bentiss@kernel.org, erazor_de@users.sourceforge.net, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc35965f6940 Merge tag 'mm-hotfixes-stable-2026-09-03-17-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1066ab49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=9f7405999979761b6cfc
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8cbf7acceedb/disk-bc35965f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/203c0c282c1c/vmlinux-bc35965f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de1170205619/bzImage-bc35965f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f7405999979761b6cfc@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 7946 Comm: syz.4.562 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:1000
 register_lock_class+0xcc/0x2e0 kernel/locking/lockdep.c:1315
 __lock_acquire+0xaf/0x2e40 kernel/locking/lockdep.c:5128
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 roccat_open+0xf6/0x5d0 drivers/hid/hid-roccat.c:178
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:996
 vfs_open+0x3b/0x350 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1448/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde12ede159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde11136028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fde13165fa0 RCX: 00007fde12ede159
RDX: 0000000000000002 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007fde12f75024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fde13166038 R14: 00007fde13165fa0 R15: 00007ffe150b2898
 </TASK>


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
