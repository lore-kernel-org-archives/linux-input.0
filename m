Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AD346FA7
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402941; cv=none; b=JQDqkI8514graTOWKb3ZGmKN5DbVymNzmE4bNPIc72LAmpwbuqCWW0wDCixhlfA/vP94RcsqDzlm/4MwjX8vobAwIWMo7hEGNGe3sNIqayFFAkzdGIViEUNlJdH36QBQJwUYri/MA+BMCn9vJ1ukRMvP+d7OTeD0u02V7gaN5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402941; c=relaxed/simple;
	bh=qdMfnvr8Z89+G6dY59XhDbSO49CTSZxRrv6V6wEkSzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXfE4/PNiaxfoLEgOiTxaTF2r8XljxOC0lSXdB5KMwMXy3UI+eszuRzCqfqgElPxPR1oUt6O/CwQd28HS5k+j5InCok6rw7Mfsg1tfjDTnmH8MNk1gl61rlYssIn3VcbOXiiClWykXZCwiFoGxBRyq3lxaUO4W6YBphBGdnuLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KsscsLeT; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KsscsLeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1779402937;
	bh=68rquSJvAqsQCigXp9oyX0K4pZ6QVUltXLlaIsci0nA=;
	h=From:Subject:Date:Message-ID;
	b=KsscsLeT7JPIToKgCv23Wtlu2S0E6+rUTr+ROMeSj2v5H84ccxzbvdW1D6W+fJ4Ow
	 SWzuVJVPEEDMhK0t1hp+ApsYuQEEyAGNdW5ZcxyNp9ayG1dnvSfl81U31DOclrDkaN
	 tmbXTX5ttBMN3DgU1e9JVgfXP63UdN5GKDsyUZUU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A0F88AD00005D1F; Thu, 22 May 2026 06:35:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3092586685229
X-SMAIL-UIID: 15AD6BA3CC3F4C79B7B47BE4E23F4198-20260522-063527-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
Date: Fri, 22 May 2026 06:35:14 +0800
Message-ID: <20260521223516.914-1-hdanton@sina.com>
In-Reply-To: <20260521143414.P7XZgsrN@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 16:34:14 +0200 Sebastian Andrzej Siewior wrote:
>On 2026-05-21 09:52:32 [+0800], Hillf Danton wrote:
>> > Date: Wed, 20 May 2026 10:05:38 -0700	[thread overview]
>> > Hello,
>> > 
>> > syzbot found the following issue on:
>> > 
>> > HEAD commit:    e98d21c170b0 Add linux-next specific files for 20260508
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=1354bfce580000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=59b98218d9b2edf4
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=b5d7ab56d43de3fd5aac
>> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>> > 
>> > Unfortunately, I don't have any reproducer for this issue yet.
>> > 
>> > Downloadable assets:
>> > disk image: https://storage.googleapis.com/syzbot-assets/66f2a00ee290/disk-e98d21c1.raw.xz
>> > vmlinux: https://storage.googleapis.com/syzbot-assets/6b982257ce9e/vmlinux-e98d21c1.xz
>> > kernel image: https://storage.googleapis.com/syzbot-assets/a73fbea43e1a/bzImage-e98d21c1.xz
>> > 
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com
>> > 
>> > ======================================================
>> > WARNING: possible circular locking dependency detected
>> > syzkaller #0 Tainted: G             L     
>> > ------------------------------------------------------
>> > syz.2.4328/32663 is trying to acquire lock:
>> > ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
>> > ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_lock_callback kernel/softirq.c:881 [inline]
>> > ffff8880b8724168 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_action_common+0xc5/0x610 kernel/softirq.c:931
>> > 
>> > but task is already holding lock:
>> > ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
>> > ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
>> > ffff888058598270 (&dev->event_lock#2){+.+.}-{3:3}, at: input_inject_event+0xa4/0x320 drivers/input/input.c:419
>> > 
>> > which lock already depends on the new lock.
>> > 
>> > 
>> > the existing dependency chain (in reverse order) is:
>> > 
>> > -> #1 (&dev->event_lock#2){+.+.}-{3:3}:
>> >        rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
>> >        spin_lock include/linux/spinlock_rt.h:45 [inline]
>> >        class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
>> >        input_inject_event+0xa4/0x320 drivers/input/input.c:419
>> >        led_trigger_event+0x13b/0x220 drivers/leds/led-triggers.c:420
>> >        kbd_propagate_led_state drivers/tty/vt/keyboard.c:1118 [inline]
>> >        kbd_bh+0x1b4/0x2c0 drivers/tty/vt/keyboard.c:1297
>> >        tasklet_action_common+0x31c/0x610 kernel/softirq.c:942
>> >        handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
>> >        __do_softirq kernel/softirq.c:660 [inline]
>> >        run_ktimerd+0x69/0x100 kernel/softirq.c:1155
>> >        smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>> >        kthread+0x388/0x470 kernel/kthread.c:436
>> >        ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> This is obvious and looks fine.
>
>> Deadlock if the timer thread is preempted
>> 
>> 	timer thread
>> 	tasklet_sync_callback.cb_lock
>> 
>> 	// preempted
>> 		&dev->event_lock
>> 		do softirq
>> 		acquire tasklet_sync_callback.cb_lock
>> 
>> 	acquire &dev->event_lock
>
> This shouldn't happen.
>
>> > -> #0 (tasklet_sync_callback.cb_lock){+...}-{3:3}:
>> >        check_prev_add kernel/locking/lockdep.c:3167 [inline]
>> >        check_prevs_add kernel/locking/lockdep.c:3286 [inline]
>> >        validate_chain kernel/locking/lockdep.c:3910 [inline]
>> >        __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
>> >        lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
>> >        rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
>> >        spin_lock include/linux/spinlock_rt.h:45 [inline]
>> >        tasklet_lock_callback kernel/softirq.c:881 [inline]
>> >        tasklet_action_common+0xc5/0x610 kernel/softirq.c:931
>> >        handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
>> >        __do_softirq kernel/softirq.c:660 [inline]
>> >        __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
>> >        local_bh_enable include/linux/bottom_half.h:33 [inline]
>> >        __alloc_skb+0x1aa/0x7d0 net/core/skbuff.c:697
>> >        alloc_skb include/linux/skbuff.h:1381 [inline]
>> >        hidp_send_message+0xb5/0x230 net/bluetooth/hidp/core.c:111
>> >        hidp_send_intr_message net/bluetooth/hidp/core.c:143 [inline]
>> >        hidp_input_event+0x2a4/0x380 net/bluetooth/hidp/core.c:175
>> >        input_event_dispose+0x80/0x6b0 drivers/input/input.c:322
>> >        input_inject_event+0x1d7/0x320 drivers/input/input.c:424
>
> up to kbd_led_trigger_activate(), I can follow. In
> kbd_led_trigger_activate() it disables the keyboard tasklet and then
> does led_set_brightness(). Not sure how it ends up in
> input_inject_event().
>
input_inject_event() is invoked in the brightness_set callback [1] for
example.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/input-leds.c#n142

> Now, input_inject_event() does spin_lock_irqsave() and alloc_skb() does
> local_bh_disable()/ local_bh_enable(). On !RT this is not legal. On RT

Can you please specify why that is illegal on !RT?

> it is okay but then local_bh_enable() here should not invoke any
> softirqs because none were raised within the section (alloc_skb()).

On RT spinlock is replaced with mutex, and softirq can be raised in the
irq that could come any moment after spin_lock_irqsave().

> Not sure if this really did occur as such or lockdep comes with the
> shortest backtrace based on the lockclass and this is it.
>
>> >        kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1074
>> >        led_trigger_set+0x53b/0x960 drivers/leds/led-triggers.c:220
>> >        led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
>> >        led_trigger_set_default+0x266/0x2a0 drivers/leds/led-triggers.c:300
>> >        led_classdev_register_ext+0x787/0x9c0 drivers/leds/led-class.c:581
>> >        led_classdev_register include/linux/leds.h:274 [inline]
>> >        input_leds_connect+0x517/0x790 drivers/input/input-leds.c:145
>> >        input_attach_handler drivers/input/input.c:1011 [inline]
>> >        input_register_device+0xce0/0x1140 drivers/input/input.c:2395
>> >        hidp_session_dev_add net/bluetooth/hidp/core.c:861 [inline]
>> >        hidp_session_probe+0x1a5/0x8a0 net/bluetooth/hidp/core.c:1139
>> >        l2cap_register_user+0xc2/0x1d0 net/bluetooth/l2cap_core.c:1725
>> >        hidp_connection_add+0x158b/0x1a20 net/bluetooth/hidp/core.c:1411
>> >        do_hidp_sock_ioctl net/bluetooth/hidp/sock.c:81 [inline]
>> >        hidp_sock_ioctl+0x403/0x650 net/bluetooth/hidp/sock.c:128
>> >        sock_do_ioctl+0x101/0x320 net/socket.c:1328
>> >        sock_ioctl+0x5c9/0x7f0 net/socket.c:1449
>> >        vfs_ioctl fs/ioctl.c:51 [inline]
>> >        __do_sys_ioctl fs/ioctl.c:597 [inline]
>> >        __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
>> >        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>> >        do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
>
>Sebastian
