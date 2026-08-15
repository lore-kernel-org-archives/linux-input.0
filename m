Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577631E847
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783302; cv=none; b=Vr7JjjK4BzNnXieifKkaNt+A707sGP8JCi2qhmzRvV90wi6rKExmG2Kopm9hBBJj7+NB3bGpXlUi1vcO0BRT9JQOSV2YpKuuYQ0LEPshCZiAgH8BgKidhSe1aCNc1xGqDAe0CoWzzN7uLLkWENOEMKpfZmuZAne/Ac5Kh0GrSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783302; c=relaxed/simple;
	bh=lYY0NXJw+cjG+Q2P5DXOzzhvYjtXTkNYZvhcPJwRMIk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sloH4yBL/GL7FVyIO2Cb8ZhoMBVwxKhxa8SEQ0ql2xX4QOXPcriwkbCcNxrZ/4vXiLWU1o26ODfom7XvJw0JZC4iuvWUjL7dP8DRU3ALEWC8+bYOgIYGZo/wu1IoHC3J8lnuW9D1b+Jbrbq6Rq9Cbs1IQHNUJObbsJlJdp5Hb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a416619e8dso2477204b6e.1
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 01:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783299; x=1787388099;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGWnJvOM6klQVvoCId+6k02e56MYqGzZqx9S8RLU4EY=;
        b=SGjF708ujWrXg4j0lrszLgLybe8CDoI6+56oJeO3GMyrOAQmRePxDy+/hdXL02B8Im
         3BQ24jhZPJcgMlYy93ZZOQS/va3hhmcJt+FAFJliWcsCwP5NVvPfgp1MBpVkOxp0OeaX
         Fir31Lql8rtOqPzFLTRuTChn031NeUbx9+BumK4esSPeNXEPMl8BdDjhaYjACtaiOBWH
         2Rnvus30KxFfEr+xxGc653ZfVr6QnbiHi3mv2KQWZ2eqYb7P3U+Kdc4Jhyd9NUziO78k
         gAbCC80uEiD0cdakwoh55xjft3zuFkZlR6DBZgqUXFeFsp4RkCh+FybWaJnOTNpEItw4
         HvlA==
X-Gm-Message-State: AOJu0YzJgIZPu77lJklMo3XeYcuFKRW4fU7hxQ5tPAXXciZLTEukPxd+
	q/Q2GCwhdo0GPoofcn8tPN9sTvqTXkdnaYQKE5fid2ZsnH3LaA7XG1Qe/Gw9OM8E6ALoQ1iZFsm
	tOU7gJmAZBic4/hSQIUAH64wlFD/8h/K5ScpOYnWtTyiI4+2irWvSLu4Y3Q/TQw==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:158f:b0:4af:aaca:7be3 with SMTP id
 5614622812f47-4b228257383mr11735100b6e.12.1786783299395; Sat, 15 Aug 2026
 01:41:39 -0700 (PDT)
Date: Sat, 15 Aug 2026 01:41:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a802643.9ebadd4d.20b15e.000a.GAE@google.com>
Subject: [syzbot] [input?] [usb?] WARNING: ODEBUG bug in corsair_remove
From: syzbot <syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2697ef8943c9 Add linux-next specific files for 20260813
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b5ac79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b15c0e5cf4b66b8
dashboard link: https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1305d149580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cbe50aa5264/disk-2697ef89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcf42545947a/vmlinux-2697ef89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aef0f9050c29/bzImage-2697ef89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com

corsair 0003:1B1C:1B02.0001: hidraw0: USB HID v0.00 Device [HID 1b1c:1b02] on usb-dummy_hcd.0-1/input0
corsair 0003:1B1C:1B02.0001: Failed to get K90 initial state (error -71).
usb 1-1: USB disconnect, device number 2
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88807780a2c8 object type: work_struct hint: k90_record_led_work+0x0/0x1e0 drivers/hid/hid-corsair.c:-1
WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230 lib/debugobjects.c:629, CPU#0: kworker/0:3/5733
Modules linked in:
CPU: 0 UID: 0 PID: 5733 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x18a/0x230 lib/debugobjects.c:629
Code: f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 dd 25 50 fd 4d 8b 0f 4c 89 ef 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f0 ff 34 24 <67> 48 0f b9 3a 48 83 c4 08 ff 05 13 3b 93 0b 48 83 c4 10 5b 41 5c
RSP: 0018:ffffc90002f7efd0 EFLAGS: 00010246
RAX: 1ffffffff1816f44 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffffff8c6cbd40 RSI: ffffffff8c6cb7c0 RDI: ffffffff90843b50
RBP: ffffffff8c6cbd40 R08: ffff88807780a2c8 R09: ffffffff8c0b8c40
R10: dffffc0000000000 R11: ffffffff818f5880 R12: 0000000000000000
R13: ffffffff90843b50 R14: ffff88807780a2c8 R15: ffffffff8c0b7a20
FS:  0000000000000000(0000) GS:ffff888124d03000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562675362520 CR3: 000000007f9c2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2679 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x13e/0x650 mm/slub.c:6792
 k90_cleanup_macro_functions drivers/hid/hid-corsair.c:547 [inline]
 corsair_remove+0xfd/0x260 drivers/hid/hid-corsair.c:602
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
 process_one_work kernel/workqueue.c:3386 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3469
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3550
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
   e:	e8 dd 25 50 fd       	call   0xfd5025f0
  13:	4d 8b 0f             	mov    (%r15),%r9
  16:	4c 89 ef             	mov    %r13,%rdi
  19:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1e:	48 89 ea             	mov    %rbp,%rdx
  21:	44 89 e1             	mov    %r12d,%ecx
  24:	4d 89 f0             	mov    %r14,%r8
  27:	ff 34 24             	push   (%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	ff 05 13 3b 93 0b    	incl   0xb933b13(%rip)        # 0xb933b4c
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
