Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262D3F5BE1
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296741; cv=none; b=oxs7nWNQt6sGS9SApiBtkHi/i4SJp3yB4TJPqfwjgPm/i7FQPNQTduPBo+L7c3jUPSHn1bxiPwqRyDPCZzUHYP8sydm7zBG9h+AgModq4wCkw4vSLlFf/PkEmXRHgoJoQdCcJynT021oxebeMQZzO0bh+llrD5vJnP4UjBXqajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296741; c=relaxed/simple;
	bh=UmRNDaGlgfAIqIbxHwng1eAB1GzkWWa7M1ZnYWApj5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gcHKQKHW3+SD0BCZIX+D2SiGmwgQG0m8qqnrYeiKn6Z7KRqBOAiX4jEYkucxts2ghy5zLD9f54RWsmFDWCzNtQTeXxFvGZ+MCCsLRGCncdDqG8Uq3ndv+y5iIDpUrx8pssBhjKsjZ4mXQEILNeNG96l89UEMMDjEWIeGqmsPn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6961163ad6aso13540468eaf.1
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 10:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296739; x=1779901539;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DtNsBOrYpeB2rnZC0wNTP4qsMtdriuLddaqFV/gRfw=;
        b=L6MahF22nYeaKgS8BPKO18nNIWnXavpJHZFR7UHpvUO2z+kpEP4FTaEITvWjK1G+NU
         oNH7GZF2yJGyTXydFmQGY6/O4jFcaMyOKZrhEDiCUPG7k2v6dkRezqX21LF/2z77vXvP
         UX9RG0Mqi9iIOHi682PkG1gEytvmwMEAJ1wmZquDozYujvM3nn3iAQ9VdCTY8tz3+Q16
         JI/S9LnNgEISs4fNMvvZhiT7nSu6heTf9Dm9s+NClScKsO+I4RXh/7c5gS9sL2w+VRa5
         2oFydn2IfiI1RosqATOJ/Oo6HCwA6Ldi27qsAHqlhUDkI6dQXkj5ejsmGcAJ3DM1Mzn8
         cR3A==
X-Forwarded-Encrypted: i=1; AFNElJ/sXzg/rSlcicgMcnO/gdKeERcNdNCY0apk2I71Yxdo4t3yJaGkiNdEpxZwOYxGvg3nuua0aY+XxuJhGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9eT6/RhFk+tLiMCX2rsPxjcvLtCNC4RxCuWQ4XXtHW8hxjyS
	0rTbnM9kAZC0pFz/2ujty7fpG6DrUBPZXGPc1etm6pwlgaAkqtj9XNKtcbYbHhsa7TOiY4K9bRB
	EFdm1VSkvS/WiNN5GLWy31AR/AOXJAqKP4QZXUjV6slG7GfXAwebUZPhWckY=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f07:b0:67e:16b4:aa0d with SMTP id
 006d021491bc7-69c9437c154mr14159899eaf.30.1779296738894; Wed, 20 May 2026
 10:05:38 -0700 (PDT)
Date: Wed, 20 May 2026 10:05:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0de9e2.050a0220.18b3cb.000d.GAE@google.com>
Subject: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
From: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e98d21c170b0 Add linux-next specific files for 20260508
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1354bfce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59b98218d9b2edf4
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d7ab56d43de3fd5aac
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66f2a00ee290/disk-e98d21c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b982257ce9e/vmlinux-e98d21c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a73fbea43e1a/bzImage-e98d21c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.4328/32663 is trying to acquire lock:
ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_lock_callback kernel/softirq.c:881 [inline]
ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_action_common+0xc5/0x610 kernel/softirq.c:931

but task is already holding lock:
ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: input_inject_event+0xa4/0x320 drivers/input/input.c:419

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->event_lock#2){+.+.}-{3:3}:
       rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
       input_inject_event+0xa4/0x320 drivers/input/input.c:419
       led_trigger_event+0x13b/0x220 drivers/leds/led-triggers.c:420
       kbd_propagate_led_state drivers/tty/vt/keyboard.c:1118 [inline]
       kbd_bh+0x1b4/0x2c0 drivers/tty/vt/keyboard.c:1297
       tasklet_action_common+0x31c/0x610 kernel/softirq.c:942
       handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       run_ktimerd+0x69/0x100 kernel/softirq.c:1155
       smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (tasklet_sync_callback.cb_lock){+...}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       tasklet_lock_callback kernel/softirq.c:881 [inline]
       tasklet_action_common+0xc5/0x610 kernel/softirq.c:931
       handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       __alloc_skb+0x1aa/0x7d0 net/core/skbuff.c:697
       alloc_skb include/linux/skbuff.h:1381 [inline]
       hidp_send_message+0xb5/0x230 net/bluetooth/hidp/core.c:111
       hidp_send_intr_message net/bluetooth/hidp/core.c:143 [inline]
       hidp_input_event+0x2a4/0x380 net/bluetooth/hidp/core.c:175
       input_event_dispose+0x80/0x6b0 drivers/input/input.c:322
       input_inject_event+0x1d7/0x320 drivers/input/input.c:424
       kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1074
       led_trigger_set+0x53b/0x960 drivers/leds/led-triggers.c:220
       led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
       led_trigger_set_default+0x266/0x2a0 drivers/leds/led-triggers.c:300
       led_classdev_register_ext+0x787/0x9c0 drivers/leds/led-class.c:581
       led_classdev_register include/linux/leds.h:274 [inline]
       input_leds_connect+0x517/0x790 drivers/input/input-leds.c:145
       input_attach_handler drivers/input/input.c:1011 [inline]
       input_register_device+0xce0/0x1140 drivers/input/input.c:2395
       hidp_session_dev_add net/bluetooth/hidp/core.c:861 [inline]
       hidp_session_probe+0x1a5/0x8a0 net/bluetooth/hidp/core.c:1139
       l2cap_register_user+0xc2/0x1d0 net/bluetooth/l2cap_core.c:1725
       hidp_connection_add+0x158b/0x1a20 net/bluetooth/hidp/core.c:1411
       do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:81 [inline]
       hidp_sock_ioctl+0x403/0x650 net/bluetooth/hidp/sock.c:128
       sock_do_ioctl+0x101/0x320 net/socket.c:1328
       sock_ioctl+0x5c9/0x7f0 net/socket.c:1449
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev->event_lock#2);
                               lock(tasklet_sync_callback.cb_lock);
                               lock(&dev->event_lock#2);
  lock(tasklet_sync_callback.cb_lock);

 *** DEADLOCK ***

10 locks held by syz.2.4328/32663:
 #0: ffff88805ebb3370 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_register_user+0x35/0x1d0 net/bluetooth/l2cap_core.c:1712
 #1: ffffffff8f73d960 (hidp_session_sem){++++}-{4:4}, at: hidp_session_probe+0x98/0x8a0 net/bluetooth/hidp/core.c:1129
 #2: ffffffff8f006e58 (input_mutex){+.+.}-{4:4}, at: class_mutex_intr_constructor include/linux/mutex.h:255 [inline]
 #2: ffffffff8f006e58 (input_mutex){+.+.}-{4:4}, at: input_register_device+0xa56/0x1140 drivers/input/input.c:2391
 #3: ffff8880125ea860 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x484/0x9c0 drivers/leds/led-class.c:539
 #4: ffffffff8e9c4400 (triggers_list_lock){++++}-{4:4}, at: led_trigger_set_default+0x77/0x2a0 drivers/leds/led-triggers.c:297
 #5: ffff8880125ea788 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_set_default+0x87/0x2a0 drivers/leds/led-triggers.c:298
 #6: ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #6: ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
 #6: ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: input_inject_event+0xa4/0x320 drivers/input/input.c:419
 #7: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #7: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #7: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #8: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #8: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #8: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1181 [inline]
 #8: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xb0/0x320 drivers/input/input.c:420
 #9: ffffffff8e1c8240 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163

stack backtrace:
CPU: 1 UID: 0 PID: 32663 Comm: syz.2.4328 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2045
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3286 [inline]
 validate_chain kernel/locking/lockdep.c:3910 [inline]
 __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 tasklet_lock_callback kernel/softirq.c:881 [inline]
 tasklet_action_common+0xc5/0x610 kernel/softirq.c:931
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x1aa/0x7d0 net/core/skbuff.c:697
 alloc_skb include/linux/skbuff.h:1381 [inline]
 hidp_send_message+0xb5/0x230 net/bluetooth/hidp/core.c:111
 hidp_send_intr_message net/bluetooth/hidp/core.c:143 [inline]
 hidp_input_event+0x2a4/0x380 net/bluetooth/hidp/core.c:175
 input_event_dispose+0x80/0x6b0 drivers/input/input.c:322
 input_inject_event+0x1d7/0x320 drivers/input/input.c:424
 kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1074
 led_trigger_set+0x53b/0x960 drivers/leds/led-triggers.c:220
 led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
 led_trigger_set_default+0x266/0x2a0 drivers/leds/led-triggers.c:300
 led_classdev_register_ext+0x787/0x9c0 drivers/leds/led-class.c:581
 led_classdev_register include/linux/leds.h:274 [inline]
 input_leds_connect+0x517/0x790 drivers/input/input-leds.c:145
 input_attach_handler drivers/input/input.c:1011 [inline]
 input_register_device+0xce0/0x1140 drivers/input/input.c:2395
 hidp_session_dev_add net/bluetooth/hidp/core.c:861 [inline]
 hidp_session_probe+0x1a5/0x8a0 net/bluetooth/hidp/core.c:1139
 l2cap_register_user+0xc2/0x1d0 net/bluetooth/l2cap_core.c:1725
 hidp_connection_add+0x158b/0x1a20 net/bluetooth/hidp/core.c:1411
 do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:81 [inline]
 hidp_sock_ioctl+0x403/0x650 net/bluetooth/hidp/sock.c:128
 sock_do_ioctl+0x101/0x320 net/socket.c:1328
 sock_ioctl+0x5c9/0x7f0 net/socket.c:1449
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb5e6cce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcb5c905028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcb5e946090 RCX: 00007fcb5e6cce59
RDX: 00002000000000c0 RSI: 00000000400448c8 RDI: 0000000000000009
RBP: 00007fcb5e762d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcb5e946128 R14: 00007fcb5e946090 R15: 00007ffddb8adae8
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
