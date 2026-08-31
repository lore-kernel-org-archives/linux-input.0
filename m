Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E543AFCF3
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788150943; cv=none; b=qNvZCjwg1iVuztDFS2CFjSmeH0/5YC84d/aXoK2D640lJIgTz1zdUEYZyTYBZmLvxjTpDrTITg2jAA60HFvN1KJJNGqbWq5ribQ/NmDhsZDNDnyl3YVxYmRQzQdoG2JJM4wsgR0fkYvCb2U6w4KZ94SY6nVdhW5tGRVz8p+Ic1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788150943; c=relaxed/simple;
	bh=mZudXeSm4wixxGmHzIJMNiPoCt3Yf058kY91/Dju/sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=afdb2ZjFdPzKk3gfjoGQzWaow4FPeuL3GaUcAT8VrvRK8eOYTYWcGmLrVKiamlRGVz4DMp60TWtTZ1OSldPVZ6mRcTDCOMCKr465YHCGOUOgzKmKjMlUp+tvtU60z/OTS1YnBfnW61YGgSBvi2LIWSAh0JCK7pdz12XlYCQiqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f7.google.com with SMTP id 006d021491bc7-6aafac56856so288112eaf.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788150941; x=1788755741;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DEOX5VODYUFxyjaa1tIkIASzzIdKDucmCLNhz41YVH0=;
        b=PCVmEEPctNYibhCgV9wYGpLBU0Eg3axhWppRKdHV3BkJCZ8/gsLYHtxu8v8duavCwn
         DO1OE+Y10gr4gWzgj+XE+9sQw+4WhTyfe0bLbgioRIWgiD5OFUymSGpFlVWEha6EAFxF
         H7qfraVFXENyG+iP/u8sULTeTIUpwwgBl35AyEGFjSa4alyg7Qz/ZYb04xYI8zOlv6ed
         6xPWMcpq/4ElTIl+yzxhPd1sTDqeBy1pWksYwIPUSw2+e2Ax8rmQhbG2e3DE++6ifG5e
         By1/hFZz57Ec8aNmg8CYzmoVPrGLQkfVRwOQISORWY2BiL0Jtof1W9tnG9ycZAom00UB
         Qeyg==
X-Forwarded-Encrypted: i=1; AHgh+Rrwne7hDi6GXWbs2SKgJkIvHxLjX5mL9S3iGwJFmzcWPNujjQQufgbbsl5KhSaIAyGBSmBWVU8HBCxgOw==@vger.kernel.org
X-Gm-Message-State: AFuF++nQe2dG7p6cj15vFa9G9pdMt4cgcCPPtYV1kFRzBRiQMpnIfIuU
	GAEhZEH9VECE6OZYz5zzSjbskcsvuE4S4l+8p9XleWUbe41TZqWnGxZ27fHwQhtNDSXPECz7MoD
	jCi3tVc/NKh64vU8qku05xlsEaBLppKupNky0eh7RBa0p7ZES99IhG06xa3k=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c85:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6b36cf0ed9bmr360004eaf.6.1788150940829; Sun, 30 Aug 2026
 21:35:40 -0700 (PDT)
Date: Sun, 30 Aug 2026 21:35:40 -0700
In-Reply-To: <6a802643.9ebadd4d.20b15e.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a95049c.7724083a.12295.0001.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING: ODEBUG bug in hid_device_remove
From: syzbot <syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a23cbb05744b Merge tag 'timers-urgent-2026-08-30' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0be25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16538349580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1569ec15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c5de4682137/disk-a23cbb05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f36f9cbaac4c/vmlinux-a23cbb05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44ee07331725/bzImage-a23cbb05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com

corsair 0003:1B1C:1B02.0022: hidraw0: USB HID v0.00 Device [HID 1b1c:1b02] on usb-dummy_hcd.0-1/input0
corsair 0003:1B1C:1B02.0022: Failed to get K90 initial state (error -71).
usb 1-1: USB disconnect, device number 35
------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880369b5ab8 object type: work_struct hint: k90_backlight_work+0x0/0x1c0 drivers/hid/hid-corsair.c:-1
WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230 lib/debugobjects.c:629, CPU#0: kworker/0:3/5621
Modules linked in:
CPU: 0 UID: 0 PID: 5621 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x18a/0x230 lib/debugobjects.c:629
Code: f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 ed ff 59 fd 4d 8b 0f 4c 89 ef 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f0 ff 34 24 <67> 48 0f b9 3a 48 83 c4 08 ff 05 c3 ca d9 0a 48 83 c4 10 5b 41 5c
RSP: 0018:ffffc90005507008 EFLAGS: 00010246
RAX: 1ffffffff16d7268 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffffff8bcc2c40 RSI: ffffffff8bcc26c0 RDI: ffffffff8fbc6db0
RBP: ffffffff8bcc2c40 R08: ffff8880369b5ab8 R09: ffffffff8b6ba560
R10: dffffc0000000000 R11: ffffffff818f4a70 R12: 0000000000000000
R13: ffffffff8fbc6db0 R14: ffff8880369b5ab8 R15: ffffffff8b6b9340
FS:  0000000000000000(0000) GS:ffff888125bd6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc6a1eafb8 CR3: 000000003e4e6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2679 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x13e/0x6d0 mm/slub.c:6792
 hid_device_remove+0xc8/0x1d0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
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
   e:	e8 ed ff 59 fd       	call   0xfd5a0000
  13:	4d 8b 0f             	mov    (%r15),%r9
  16:	4c 89 ef             	mov    %r13,%rdi
  19:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1e:	48 89 ea             	mov    %rbp,%rdx
  21:	44 89 e1             	mov    %r12d,%ecx
  24:	4d 89 f0             	mov    %r14,%r8
  27:	ff 34 24             	push   (%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	ff 05 c3 ca d9 0a    	incl   0xad9cac3(%rip)        # 0xad9cafc
  39:	48 83 c4 10          	add    $0x10,%rsp
  3d:	5b                   	pop    %rbx
  3e:	41 5c                	pop    %r12


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
