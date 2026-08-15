Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC553890FC
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783302; cv=none; b=X0sdI6tVi7yd22tfoOIv/PK+cLIwO6SMcV+L0vaJ70fUIXRskMdhw0bRgNZFKwAEgk5dFA65vBaHyYzaed0L10Jj9s15DzwciAD7j6RmwqdtrmY45V2jHKcWL93sgSjJLvOdT0VuXl1ff5WUigrN84CcBRYAkvshfia+8b16IjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783302; c=relaxed/simple;
	bh=AmBwXzfDbGtuWgDRAjiU7VBytuCs27oMeoYEJUSEk3E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PWG0faIyj+So3dTzs1ZY3hrplklmydFVGBt925Lu9pKDJWIQx3mnoUB8As4W6RNx7TIwS+RHKJmLxOiXIBWeaVR6kJyIzlQ+3nU9VJphgk5D9wta8BLpTv7ahjVG8OMLqrJz73JnhQK16yW41z0M9WjIqKo42g6V0Gs5ImJ2j5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6b0e26855f9so1151592eaf.3
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 01:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783299; x=1787388099;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VdJBlXtqy/A9lcaW/cqt6SDkLm7snHEaVFfxMxGJFk=;
        b=A+UqaNw1znOUOngxTRt5ylFt+3G40ipNxUyAJSLAWJ8VOUOLu3IJFJ+ce5+WONhsDZ
         tF5TTDNtrlXjXmGZjbgsIciXkEwBotRnT6oWvLdT887PqS8imcNNas9g/6X6kJcn4KAr
         kXam9s4d6GW9uEjaMbjbVmjRhDtCS7gaBkYKIxTVdupFm6lbHH0q92ZtEHr/LpJCpV45
         E4zVGHnjWVvYEstu4sDlIUUzugS/lCtNxMvpK8gKTQ10ZV4Gdkgm+iG7mlFP0w80Jwlk
         Mv/0/Qu4FRwS5A8m1F4O3cCLhmMWQaykJhJFRJfeFQSmQzIJaPRB73s/kPETAS+W04Sj
         dGPQ==
X-Gm-Message-State: AOJu0YxXeTLXisd+Ng3/IjYBwl4HSodYdu2vWhGBwIsBd8/mblFmK1nH
	BdFuuDvKSnlfRP1jz4ymHf7ThKlJZ45ptMCLoaygdT9cGbmf8q2xDOP7ALov/iIoGDCuHaBIKlz
	HZazuopjTrSCM8f5yxslTLfQy5Gqs7RdtyHATtlNlGTKLn4ityaeLBAi6rErlJg==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:188c:b0:6b0:5742:9c32 with SMTP id
 006d021491bc7-6b0d61a1646mr10708849eaf.15.1786783299719; Sat, 15 Aug 2026
 01:41:39 -0700 (PDT)
Date: Sat, 15 Aug 2026 01:41:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a802643.9ebadd4d.20b15e.000b.GAE@google.com>
Subject: [syzbot] [input?] [usb?] WARNING: ODEBUG bug in hid_device_remove
From: syzbot <syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28d012efb432 Add linux-next specific files for 20260812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1613f479580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a13c7bc480b5c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bc1c79580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de882be6df4b/disk-28d012ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/412cb9fb7e2d/vmlinux-28d012ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d7096c27f1b/bzImage-28d012ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88801faaf2c8 object type: work_struct hint: k90_backlight_work+0x0/0x1c0 drivers/hid/hid-corsair.c:-1
WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230 lib/debugobjects.c:629, CPU#1: kworker/1:3/5638
Modules linked in:
CPU: 1 UID: 0 PID: 5638 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x18a/0x230 lib/debugobjects.c:629
Code: f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 3d dc 4f fd 4d 8b 0f 4c 89 ef 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f0 ff 34 24 <67> 48 0f b9 3a 48 83 c4 08 ff 05 b3 78 93 0b 48 83 c4 10 5b 41 5c
RSP: 0018:ffffc90003a77008 EFLAGS: 00010246
RAX: 1ffffffff1816f44 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffffff8c6cc240 RSI: ffffffff8c6cbcc0 RDI: ffffffff9084a330
RBP: ffffffff8c6cc240 R08: ffff88801faaf2c8 R09: ffffffff8c0b8be0
R10: dffffc0000000000 R11: ffffffff818f4a00 R12: 0000000000000000
R13: ffffffff9084a330 R14: ffff88801faaf2c8 R15: ffffffff8c0b7a20
FS:  0000000000000000(0000) GS:ffff888124dfc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0bbdb3000 CR3: 000000007a984000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2679 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x13e/0x650 mm/slub.c:6792
 hid_device_remove+0xc5/0x1c0 drivers/hid/hid-core.c:2901
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3130 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3152
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	48 c1 e8 03          	shr    $0x3,%rax
   5:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   9:	74 08                	je     0x13
   b:	4c 89 ff             	mov    %r15,%rdi
   e:	e8 3d dc 4f fd       	call   0xfd4fdc50
  13:	4d 8b 0f             	mov    (%r15),%r9
  16:	4c 89 ef             	mov    %r13,%rdi
  19:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1e:	48 89 ea             	mov    %rbp,%rdx
  21:	44 89 e1             	mov    %r12d,%ecx
  24:	4d 89 f0             	mov    %r14,%r8
  27:	ff 34 24             	push   (%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	ff 05 b3 78 93 0b    	incl   0xb9378b3(%rip)        # 0xb9378ec
  39:	48 83 c4 10          	add    $0x10,%rsp
  3d:	5b                   	pop    %rbx
  3e:	41 5c                	pop    %r12


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
