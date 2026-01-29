Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EC2FBDE6
	for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712273; cv=none; b=F47ccK0p22ZTTqMyMrx7rqVmjSmTbbvEJX1fBpDj9GIVv8N1JYUysaBHP3ek3INGZE4HxRzMOxocsmZk+IIciAguFbhVYYfnqAmORL769teliAwQPgTg37w8XLdy+3puzGfppZ9bhAuBQNgTAy+L+LSNw5Bdt/kKs9ZZjTAmjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712273; c=relaxed/simple;
	bh=bWZcG3PhHWyEILrgRKgek4RXtox4Z9NBBlfHZDqy/YE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WoXaYAo79OGTvFEQwBYO4T7Vruv6izb4pAghB9iXvbvXQcUmcTSz5Hg2YJg5NdkOu4eaYr6mTFx26us3VlqLSTM0I8kGjWOroyTQ3XibZpVMyDDIZqwzw9lhJTOAHsYugRSCTatMlQG/DE1CmilT5SXaxZKe7deoWeD6SyWKB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-662f738c3bfso5625168eaf.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2026 10:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769712271; x=1770317071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDgL1MYSweSbEh3ZjY29CfIHSUPIEI6ynbuw1xTqXA0=;
        b=RFJM6rdglnV0eeMH3+09v27UUw6vJXdvKRl41uQZsdxed4oal+qq5uQzSCXUBzOJZe
         6FT6x5zTFvIH/DAdZ5G/8L5S9GV1NlkxVyZPzke2srBreqEQCOo2dKNikDOqajmajj3m
         y42vaYydoB/rjPhpoqsVgG9XvpTaN5siubhtlSHkh0auvFAKPsQ7AJqXQNfd8lc0PuUk
         Ribq+k3ZHxUSJd8UstXp5ankrQBMADY2dLZPef+O1ho/RkJ9e/xnWbSHVrbWYzu7jg2g
         IHySZ18ltJsELJj5/6Xpdo24xEes4RR8xV6QIXZVl4DFOnr9cmr13j70nDi8ZUk9xT58
         MfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq9+ECr/SwCQAoJ9JGJQAUCR8uMkeGcDAe/y2V2ixOJiQaJ1agJGdjDJb+Mapfg8SbbO048tU9zcFnKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwczUObRobl+8C95AxCeR/idLWbTr3wo2SkvaaTEAYcBQwWQj
	7aUppMwtwGdJgKIFtxF3AxpIMxaX5fmXsL2Pek/gYYq5CYkegC1/Ycd+QLQqVbFk7x18evtlDML
	kqFeGW4ksgMtpCpTaTERzAXA6y/v7JwWNm3//RtuJzDyWDoOK98i4ysEWlfE=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a9:b0:663:e8d:cf8 with SMTP id
 006d021491bc7-6630f04f928mr241287eaf.35.1769712271028; Thu, 29 Jan 2026
 10:44:31 -0800 (PST)
Date: Thu, 29 Jan 2026 10:44:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697baa8f.a70a0220.9914.001f.GAE@google.com>
Subject: [syzbot] [input?] [usb?] WARNING in asus_remove
From: syzbot <syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f24e4edcd1b Add linux-next specific files for 20260128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f4b694580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=750532df2c47a03
dashboard link: https://syzkaller.appspot.com/bug?extid=13f8286fa2de04a7cd48
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1188e9b2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1526fd8a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce84e32318c2/disk-3f24e4ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7eafc98224fb/vmlinux-3f24e4ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b186eb6f05d2/bzImage-3f24e4ed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13f8286fa2de04a7cd48@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
asus 0003:0B05:19B6.0001: hidraw0: USB HID v0.00 Device [HID 0b05:19b6] on usb-dummy_hcd.0-1/input0
usb 1-1: USB disconnect, device number 2
------------[ cut here ]------------
!work->func
WARNING: kernel/workqueue.c:4292 at __flush_work+0xb43/0xc50 kernel/workqueue.c:4292, CPU#1: kworker/1:1/29
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0xb43/0xc50 kernel/workqueue.c:4292
Code: 75 54 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 5c 87 37 00 90 0f 0b 90 e9 7c ff ff ff e8 4e 87 37 00 90 <0f> 0b 90 31 c0 48 bb f8 f8 f8 f8 f8 f8 f8 f8 e9 64 ff ff ff e8 34
RSP: 0018:ffffc90000a47080 EFLAGS: 00010293
RAX: ffffffff818da1c2 RBX: 1ffff1100b3dc19c RCX: ffff88801e2f8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888059ee0cc8
RBP: ffffc90000a47238 R08: ffffffff90324cb7 R09: 1ffffffff2064996
R10: dffffc0000000000 R11: fffffbfff2064997 R12: dffffc0000000000
R13: ffff888059ee0ce0 R14: 1ffff92000148e18 R15: ffff888059ee0cc8
FS:  0000000000000000(0000) GS:ffff88812515a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe2dd70d64 CR3: 0000000077d5a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4451
 asus_remove+0x143/0x180 drivers/hid/hid-asus.c:1347
 hid_device_remove+0x228/0x370 drivers/hid/hid-core.c:-1
 device_remove drivers/base/dd.c:571 [inline]
 __device_release_driver drivers/base/dd.c:1284 [inline]
 device_release_driver_internal+0x46f/0x860 drivers/base/dd.c:1307
 bus_remove_device+0x34d/0x440 drivers/base/bus.c:616
 device_del+0x527/0x8f0 drivers/base/core.c:3878
 hid_remove_device drivers/hid/hid-core.c:3008 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3030
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1477
 usb_unbind_interface+0x26e/0x910 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:573 [inline]
 __device_release_driver drivers/base/dd.c:1284 [inline]
 device_release_driver_internal+0x4d9/0x860 drivers/base/dd.c:1307
 bus_remove_device+0x34d/0x440 drivers/base/bus.c:616
 device_del+0x527/0x8f0 drivers/base/core.c:3878
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x32f/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1cc9/0x4f30 drivers/usb/core/hub.c:5953
 process_one_work+0x949/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
