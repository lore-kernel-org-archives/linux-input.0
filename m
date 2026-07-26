Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67463630AE
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785026312; cv=none; b=jsujGtozVtOO1ySPrHiVrv/VI+lHDBQ1PlLb7b3oZyq/CKQBsgGXyBLMKDuH92IDKIh3OH4YclSXRPKjBWjZT7lzSmk3tWIZDwI6SisW5nPahdfH9nNzwjx2lbXY7QjRT89dHdr7UbMfV05Ao9W/90olBlXsaEFAq59uBMyMDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785026312; c=relaxed/simple;
	bh=x2FNiL3Vx2tibEuM62MxjxOdjnH5C0ox9s0pm5tWxVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YUugaQCTeGdy+8e+ljPgeDRMBCNspTdwkjnkPcMlHhQjTBgQfHbtgg+xOsfDEKpNs/GY8ecO/34vDjJNhbebL1GQPcnnHNI2BMSMgu5FYtUPs/6Zc6OaVS+9DpeL4AvhZRT0QTUcj7NGAXGTMDLRgdliEHY/Y154CXniWkyXhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49ab6a82cd5so2228504b6e.2
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 17:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785026309; x=1785631109;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wd9UQhRoyucgyMpON1mC8F2CDIvEJR07Tz/2iev0IDg=;
        b=jY/qJr505Ef9wSAD4EsSD2TCDWIalMRNkaQ9PDkx41gGynh7W5jxP/6Rdf99EKlKvJ
         igIi2OkNK2KTj06+VbE48i50iH0gV/jchISZ5sPY3uVuxQ4NqdU+pwMxSs2wyjC4DEEv
         0qVSEu8xwNP/JdGr4n36WyB8g8aYJD6HVCAQhCWXunBJaCB6akOEEd0vXXBuf9ukBc0+
         HuXSYpKR6fJWYpoRi1qMPTViPU3mOH3SCEZMpeWzEIOS7NnRL3DeiDK5OigpErwYayXz
         G7MjOlYCG2yZpp3S1hgQtISFLJFU7IiW3ulj21CgrK0Wo98HRxcb8kmC+8T9jgl8qAUi
         zhVg==
X-Forwarded-Encrypted: i=1; AHgh+RpFjjlZV38gcA1M9hxx3qoD5jdBWd7RSvAobpwVbZlimm0gzBU+2eMis0RpC21rNSqhxW5pwELGbWzUNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI612+mbZ7yPeirbfCeQOcazFnalL2zaOMlEebd4Mq0KETXS/M
	vFV8CWe3WvH+71X3gO3L5JVGjSPlCwYew7eKWX4Nyo16Fo85B3dZCn2AAaQfZ99hvpxJBiufK8t
	lJHsSW+dg/eXg2XsDEpZ4SjQ5u9d4LKmY0wq7tfXg6Bm1z8W7uif4swbQQqs=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198a:b0:497:d574:6155 with SMTP id
 5614622812f47-4ab6a3130e1mr4096206b6e.33.1785026308897; Sat, 25 Jul 2026
 17:38:28 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:38:28 -0700
In-Reply-To: <6a0de9e2.050a0220.18b3cb.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a655704.70955b6c.323240.0028.GAE@google.com>
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
From: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, dmitry.torokhov@gmail.com, hdanton@sina.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d446b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2290ccbf984c524f
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d7ab56d43de3fd5aac
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1310a232580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c3b2ea580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6836f8efb1da/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0109d3477cc7/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2e49e350bbf/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.2.50/6022 is trying to acquire lock:
ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_lock_callback kernel/softirq.c:881 [inline]
ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_action_common+0xc5/0x600 kernel/softirq.c:931

but task is already holding lock:
ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:620 [inline]
ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: input_inject_event+0xab/0x310 drivers/input/input.c:419

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->event_lock#2){+.+.}-{3:3}:
       rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       class_spinlock_irqsave_constructor include/linux/spinlock.h:620 [inline]
       input_inject_event+0xab/0x310 drivers/input/input.c:419
       led_trigger_event+0x13b/0x220 drivers/leds/led-triggers.c:420
       kbd_propagate_led_state drivers/tty/vt/keyboard.c:1124 [inline]
       kbd_bh+0x1b4/0x2c0 drivers/tty/vt/keyboard.c:1303
       tasklet_action_common+0x31c/0x600 kernel/softirq.c:942
       handle_softirqs+0x1d9/0x6c0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       run_ktimerd+0x69/0x100 kernel/softirq.c:1155
       smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (tasklet_sync_callback.cb_lock){+...}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5906
       rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       tasklet_lock_callback kernel/softirq.c:881 [inline]
       tasklet_action_common+0xc5/0x600 kernel/softirq.c:931
       handle_softirqs+0x1d9/0x6c0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       __alloc_skb+0x1ad/0x7a0 net/core/skbuff.c:699
       alloc_skb include/linux/skbuff.h:1384 [inline]
       hidp_send_message+0xb5/0x230 net/bluetooth/hidp/core.c:108
       hidp_send_intr_message net/bluetooth/hidp/core.c:140 [inline]
       hidp_input_event+0x2a4/0x380 net/bluetooth/hidp/core.c:172
       input_event_dispose+0x80/0x6b0 drivers/input/input.c:322
       input_inject_event+0x1fa/0x310 drivers/input/input.c:424
       kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1080
       led_trigger_set+0x52b/0x940 drivers/leds/led-triggers.c:220
       led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
       led_trigger_set_default+0x269/0x2a0 drivers/leds/led-triggers.c:300
       led_classdev_register_ext+0x761/0x990 drivers/leds/led-class.c:596
       led_classdev_register include/linux/leds.h:274 [inline]
       input_leds_connect+0x4de/0x750 drivers/input/input-leds.c:145
       input_attach_handler drivers/input/input.c:1011 [inline]
       input_register_device+0xd08/0x1150 drivers/input/input.c:2398
       hidp_session_dev_add net/bluetooth/hidp/core.c:871 [inline]
       hidp_session_probe+0x1a5/0x8b0 net/bluetooth/hidp/core.c:1149
       l2cap_register_user+0xbd/0x1d0 net/bluetooth/l2cap_core.c:1754
       hidp_connection_add+0x1582/0x1a10 net/bluetooth/hidp/core.c:1421
       do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:78 [inline]
       hidp_sock_ioctl+0x403/0x650 net/bluetooth/hidp/sock.c:125
       sock_do_ioctl+0x101/0x320 net/socket.c:1340
       sock_ioctl+0x57d/0x7f0 net/socket.c:1461
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
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

locks held by syz.2.50/6022: 10, last CPU#0:
 #0: ffff88802a6afb70 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_register_user+0x34/0x1d0 net/bluetooth/l2cap_core.c:1741
 #1: ffffffff8f973720 (hidp_session_sem){++++}-{4:4}, at: hidp_session_probe+0x98/0x8b0 net/bluetooth/hidp/core.c:1139
 #2: ffffffff8f236758 (input_mutex){+.+.}-{4:4}, at: class_mutex_intr_constructor include/linux/mutex.h:255 [inline]
 #2: ffffffff8f236758 (input_mutex){+.+.}-{4:4}, at: input_register_device+0xa7f/0x1150 drivers/input/input.c:2394
 #3: ffff88803c562860 (&led_cdev->led_access){+.+.}-{4:4}, at: led_classdev_register_ext+0x45e/0x990 drivers/leds/led-class.c:554
 #4: ffffffff8ebefde0 (triggers_list_lock){++++}-{4:4}, at: led_trigger_set_default+0x7b/0x2a0 drivers/leds/led-triggers.c:297
 #5: ffff88803c562788 (&led_cdev->trigger_lock){+.+.}-{4:4}, at: led_trigger_set_default+0x8b/0x2a0 drivers/leds/led-triggers.c:298
 #6: ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #6: ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:620 [inline]
 #6: ffff88802bcbc270 (&dev->event_lock#2){+.+.}-{3:3}, at: input_inject_event+0xab/0x310 drivers/input/input.c:419
 #7: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #7: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #7: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #8: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #8: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #8: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 #8: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xb7/0x310 drivers/input/input.c:420
 #9: ffffffff8e3c3880 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163

stack backtrace:
CPU: 0 UID: 0 PID: 6022 Comm: syz.2.50 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5906
 rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 tasklet_lock_callback kernel/softirq.c:881 [inline]
 tasklet_action_common+0xc5/0x600 kernel/softirq.c:931
 handle_softirqs+0x1d9/0x6c0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x1ad/0x7a0 net/core/skbuff.c:699
 alloc_skb include/linux/skbuff.h:1384 [inline]
 hidp_send_message+0xb5/0x230 net/bluetooth/hidp/core.c:108
 hidp_send_intr_message net/bluetooth/hidp/core.c:140 [inline]
 hidp_input_event+0x2a4/0x380 net/bluetooth/hidp/core.c:172
 input_event_dispose+0x80/0x6b0 drivers/input/input.c:322
 input_inject_event+0x1fa/0x310 drivers/input/input.c:424
 kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1080
 led_trigger_set+0x52b/0x940 drivers/leds/led-triggers.c:220
 led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
 led_trigger_set_default+0x269/0x2a0 drivers/leds/led-triggers.c:300
 led_classdev_register_ext+0x761/0x990 drivers/leds/led-class.c:596
 led_classdev_register include/linux/leds.h:274 [inline]
 input_leds_connect+0x4de/0x750 drivers/input/input-leds.c:145
 input_attach_handler drivers/input/input.c:1011 [inline]
 input_register_device+0xd08/0x1150 drivers/input/input.c:2398
 hidp_session_dev_add net/bluetooth/hidp/core.c:871 [inline]
 hidp_session_probe+0x1a5/0x8b0 net/bluetooth/hidp/core.c:1149
 l2cap_register_user+0xbd/0x1d0 net/bluetooth/l2cap_core.c:1754
 hidp_connection_add+0x1582/0x1a10 net/bluetooth/hidp/core.c:1421
 do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:78 [inline]
 hidp_sock_ioctl+0x403/0x650 net/bluetooth/hidp/sock.c:125
 sock_do_ioctl+0x101/0x320 net/socket.c:1340
 sock_ioctl+0x57d/0x7f0 net/socket.c:1461
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f272c33de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff0d71338 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f272c5c5fa0 RCX: 00007f272c33de99
RDX: 0000200000000200 RSI: 00000000400448c8 RDI: 0000000000000004
RBP: 00007f272c3d3eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f272c5c5fac R14: 00007f272c5c5fa0 R15: 00007f272c5c5fa0
 </TASK>
raw-gadget.1 gadget.0: ignoring, device is not running


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
