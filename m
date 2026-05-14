Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785073DFC6A;
	Thu, 14 May 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763995; cv=none; b=LXCSnhAaKadue/ZjTDRKFE2S4KUKfm7UPj6Hp3GV5UHreAnft8SI3d2Ch/cq70HkDck0Ht3ofSQDWFuaaNmdT6BEJBrjRgaMfEoIyAHOIt9ct9zFrdXpzoOT/1bzCkt0YJwJ2mu9sHHvAIKFve/MFMhSODbc6n9BnL9rwELVolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763995; c=relaxed/simple;
	bh=ltgg05gxntb9Tdh6HIncXesEHP1s3UI9PX5+3LFl/u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhT3iOdc+IG4GHSuc3dRcnZ/AepLWhNUwFCUTyWRZT+fTdb/t3agQPch9LIMHNLR6raTCewffSv5dmHtTymcNKcGIMbzeyE2vS7OSiu7MekRCjtCnJco5fK/BpMJ7DiWzz7HRUV4HxRKCyIAqh1IoomhXq+Ipz7Gj+9UV0cyczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=VTqVMpbI; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="VTqVMpbI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lyLt+7s54bW+GsjkrgJ7A/pLRjddsyio/ohtHkqUh78=; b=VTqVMpbI5XwKSini7UFwBNESDn
	GcXfAAekCFJFjlAhsKbwYpmHFIVO1MDCpmw6A7WnDSJKjDxx8JPRSrZOBVM61ha32NEWZo+dFJHwI
	Xkxw+YccV47rU6CDo5xgeaG1CZRe0YUeS0ZuoAox/xwQ3l6YtYbCPUxcOa6Lb6qfT/GYFPIZOIn5F
	z+0IM2YvGfjT/XgndpNoPb2wwDsi/bT1+tTFEvgm9XcaAgU3XEDdrxbp8ucWJ0cqWjGBR9+zXeNf1
	RF3wJBmFy3zdVeTkeBoyVfz31Tmn+MXdt2vyiGhVnYdRvJJQBxzD2IUJzbUQgAaFdk9YNw87AiIZD
	v6uagE6A==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wNVlc-0000000046a-2i8K;
	Thu, 14 May 2026 09:06:20 -0400
Date: Thu, 14 May 2026 09:06:19 -0400
From: Rik van Riel <riel@surriel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] input/evdev: move kill_fasync() outside buffer_lock to
 fix SOFTIRQ deadlock
Message-ID: <20260514090619.3d2a669c@fangorn>
In-Reply-To: <agTXYr_fFGiJ7lAe@google.com>
References: <20260513115000.77ec5975@fangorn>
	<agTXYr_fFGiJ7lAe@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 13:01:58 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Wed, May 13, 2026 at 11:50:00AM -0400, Rik van Riel wrote:
> > buffer_lock is a SOFTIRQ-safe spinlock. kill_fasync() acquires fa_lock
> > (SOFTIRQ-unsafe), creating a potential SOFTIRQ-safe->SOFTIRQ-unsafe lock
> > ordering violation that lockdep flags as a deadlock.
> > 
> > Fix by moving the kill_fasync() call to evdev_pass_values() after
> > buffer_lock is released, alongside the existing wake_up_interruptible_poll().
> > 
> > The wakeup condition check is the same in __pass_event() and
> > evdev_pass_values()  
> 
> Does this really fix anything? This code is running holding
> input->event_lock with IRQs off...

You're right. The bug is real, but this patch does not fix it.
Would the Sashiko suggestion work, or is there a better way to
tackle it?

For reference, the lockdep splat is below:

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
7.0.0-rc6-00259-g427a4f9708ee #82 Not tainted
-----------------------------------------------------
syz.6.15929/30382 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888101324558 (&new->fa_lock){...-}-{3:3}, at: kill_fasync_rcu fs/fcntl.c:1135 [inline]
ffff888101324558 (&new->fa_lock){...-}-{3:3}, at: kill_fasync fs/fcntl.c:1159 [inline]
ffff888101324558 (&new->fa_lock){...-}-{3:3}, at: kill_fasync+0x137/0x590 fs/fcntl.c:1152

and this task is already holding:
ffff88812f3d8028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:341 [inline]
ffff88812f3d8028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values.part.0+0xf6/0x950 drivers/input/evdev.c:261
which would create a new lock dependency:
 (&client->buffer_lock){....}-{3:3} -> (&new->fa_lock){...-}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->event_lock){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
  input_inject_event+0x9f/0x420 drivers/input/input.c:419
  __led_set_brightness drivers/leds/led-core.c:52 [inline]
  led_set_brightness_nopm drivers/leds/led-core.c:335 [inline]
  led_set_brightness_nosleep drivers/leds/led-core.c:369 [inline]
  led_set_brightness+0x217/0x290 drivers/leds/led-core.c:328
  led_trigger_event drivers/leds/led-triggers.c:420 [inline]
  led_trigger_event+0xda/0x2b0 drivers/leds/led-triggers.c:408
  kbd_propagate_led_state drivers/tty/vt/keyboard.c:1065 [inline]
  kbd_bh+0x263/0x350 drivers/tty/vt/keyboard.c:1244
  tasklet_action_common+0x240/0x3c0 kernel/softirq.c:925
  handle_softirqs+0x1b0/0x8d0 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0xc4/0x100 kernel/softirq.c:723
  irq_exit_rcu+0x9/0x20 kernel/softirq.c:739
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
  sysvec_apic_timer_interrupt+0x70/0x80 arch/x86/kernel/apic/apic.c:1056
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:729
  __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:95 [inline]
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
  _raw_spin_unlock_irqrestore+0x34/0x50 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:407 [inline]
  class_spinlock_irqsave_destructor include/linux/spinlock.h:618 [inline]
  input_inject_event+0x1bd/0x420 drivers/input/input.c:419
  evdev_write+0x30a/0x460 drivers/input/evdev.c:528
  vfs_write+0x2b1/0x11a0 fs/read_write.c:686
  ksys_write+0x1ef/0x240 fs/read_write.c:740
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5868 [inline]
  lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
  __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
  _raw_read_lock+0x5c/0x70 kernel/locking/spinlock.c:228
  __do_wait+0x105/0x880 kernel/exit.c:1678
  do_wait+0x1cb/0x5a0 kernel/exit.c:1722
  kernel_wait+0x9f/0x160 kernel/exit.c:1898
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:163
  process_one_work+0x920/0x1ac0 kernel/workqueue.c:3276
  process_scheduled_works kernel/workqueue.c:3359 [inline]
  worker_thread+0x693/0xeb0 kernel/workqueue.c:3440
  kthread+0x385/0x490 kernel/kthread.c:436
  ret_from_fork+0x67a/0xab0 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &dev->event_lock --> &client->buffer_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock);
                               lock(&client->buffer_lock);
  <Interrupt>
    lock(&dev->event_lock);

 *** DEADLOCK ***

7 locks held by syz.6.15929/30382:
 #0: ffff88810452a118 (&evdev->mutex){+.+.}-{4:4}, at: evdev_write+0x161/0x460 drivers/input/evdev.c:511
 #1: ffff8881038c5230 (&dev->event_lock){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
 #1: ffff8881038c5230 (&dev->event_lock){..-.}-{3:3}, at: input_inject_event+0x9f/0x420 drivers/input/input.c:419
 #2: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #2: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #2: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 #2: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xbb/0x420 drivers/input/input.c:420
 #3: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #3: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #3: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 #3: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: input_pass_values+0x80/0x8b0 drivers/input/input.c:119
 #4: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #4: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #4: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: evdev_events+0x80/0x4e0 drivers/input/evdev.c:298
 #5: ffff88812f3d8028 (&client->buffer_lock){....}-{3:3}, at: spin_lock include/linux/spinlock.h:341 [inline]
 #5: ffff88812f3d8028 (&client->buffer_lock){....}-{3:3}, at: evdev_pass_values.part.0+0xf6/0x950 drivers/input/evdev.c:261
 #6: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #6: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #6: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: kill_fasync fs/fcntl.c:1158 [inline]
 #6: ffffffffbbcac800 (rcu_read_lock){....}-{1:3}, at: kill_fasync+0x61/0x590 fs/fcntl.c:1152

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&dev->event_lock){..-.}-{3:3} {
    IN-SOFTIRQ-W at:
                      lock_acquire kernel/locking/lockdep.c:5868 [inline]
                      lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
                      _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                      class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
                      input_inject_event+0x9f/0x420 drivers/input/input.c:419
                      __led_set_brightness drivers/leds/led-core.c:52 [inline]
                      led_set_brightness_nopm drivers/leds/led-core.c:335 [inline]
                      led_set_brightness_nosleep drivers/leds/led-core.c:369 [inline]
                      led_set_brightness+0x217/0x290 drivers/leds/led-core.c:328
                      led_trigger_event drivers/leds/led-triggers.c:420 [inline]
                      led_trigger_event+0xda/0x2b0 drivers/leds/led-triggers.c:408
                      kbd_propagate_led_state drivers/tty/vt/keyboard.c:1065 [inline]
                      kbd_bh+0x263/0x350 drivers/tty/vt/keyboard.c:1244
                      tasklet_action_common+0x240/0x3c0 kernel/softirq.c:925
                      handle_softirqs+0x1b0/0x8d0 kernel/softirq.c:622
                      __do_softirq kernel/softirq.c:656 [inline]
                      invoke_softirq kernel/softirq.c:496 [inline]
                      __irq_exit_rcu+0xc4/0x100 kernel/softirq.c:723
                      irq_exit_rcu+0x9/0x20 kernel/softirq.c:739
                      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
                      sysvec_apic_timer_interrupt+0x70/0x80 arch/x86/kernel/apic/apic.c:1056
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:729
                      __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:95 [inline]
                      __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
                      _raw_spin_unlock_irqrestore+0x34/0x50 kernel/locking/spinlock.c:194
                      spin_unlock_irqrestore include/linux/spinlock.h:407 [inline]
                      class_spinlock_irqsave_destructor include/linux/spinlock.h:618 [inline]
                      input_inject_event+0x1bd/0x420 drivers/input/input.c:419
                      evdev_write+0x30a/0x460 drivers/input/evdev.c:528
                      vfs_write+0x2b1/0x11a0 fs/read_write.c:686
                      ksys_write+0x1ef/0x240 fs/read_write.c:740
                      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                      do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                      entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5868 [inline]
                     lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
                     _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                     class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
                     input_inject_event+0x9f/0x420 drivers/input/input.c:419
                     __led_set_brightness drivers/leds/led-core.c:52 [inline]
                     led_set_brightness_nopm drivers/leds/led-core.c:335 [inline]
                     led_set_brightness_nosleep drivers/leds/led-core.c:369 [inline]
                     led_set_brightness+0x217/0x290 drivers/leds/led-core.c:328
                     kbd_led_trigger_activate+0xcd/0x110 drivers/tty/vt/keyboard.c:1021
                     led_trigger_set+0x4c9/0xaa0 drivers/leds/led-triggers.c:220
                     led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
                     led_match_default_trigger drivers/leds/led-triggers.c:271 [inline]
                     led_trigger_set_default drivers/leds/led-triggers.c:300 [inline]
                     led_trigger_set_default+0x1e7/0x2e0 drivers/leds/led-triggers.c:284
                     led_classdev_register_ext+0x63a/0x980 drivers/leds/led-class.c:578
                     led_classdev_register include/linux/leds.h:274 [inline]
                     input_leds_connect+0x4c5/0x900 drivers/input/input-leds.c:145
                     input_attach_handler+0x17b/0x260 drivers/input/input.c:994
                     input_register_device+0xa1e/0x1070 drivers/input/input.c:2378
                     atkbd_connect+0x6c2/0xb60 drivers/input/keyboard/atkbd.c:1340
                     serio_connect_driver drivers/input/serio/serio.c:44 [inline]
                     serio_driver_probe+0x84/0xe0 drivers/input/serio/serio.c:748
                     call_driver_probe drivers/base/dd.c:643 [inline]
                     really_probe+0x260/0x840 drivers/base/dd.c:721
                     __driver_probe_device+0x1e7/0x390 drivers/base/dd.c:863
                     driver_probe_device+0x4e/0x2e0 drivers/base/dd.c:893
                     __driver_attach drivers/base/dd.c:1287 [inline]
                     __driver_attach+0x1d6/0x5d0 drivers/base/dd.c:1227
                     bus_for_each_dev+0x12c/0x1c0 drivers/base/bus.c:383
                     serio_attach_driver drivers/input/serio/serio.c:777 [inline]
                     serio_handle_event+0x234/0x980 drivers/input/serio/serio.c:214
                     process_one_work+0x920/0x1ac0 kernel/workqueue.c:3276
                     process_scheduled_works kernel/workqueue.c:3359 [inline]
                     worker_thread+0x693/0xeb0 kernel/workqueue.c:3440
                     kthread+0x385/0x490 kernel/kthread.c:436
                     ret_from_fork+0x67a/0xab0 arch/x86/kernel/process.c:158
                     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
  }
  ... key      at: [<ffffffffbe892e60>] __key.4+0x0/0x40
-> (&client->buffer_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock_irq+0x33/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:371 [inline]
                   evdev_fetch_next_event drivers/input/evdev.c:543 [inline]
                   evdev_read+0x4ee/0xc70 drivers/input/evdev.c:584
                   vfs_read+0x1e6/0xc70 fs/read_write.c:572
                   ksys_read+0x1ef/0x240 fs/read_write.c:717
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffffbe893060>] __key.84+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
   __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
   _raw_spin_lock+0x2b/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:341 [inline]
   evdev_handle_get_val+0x70/0x620 drivers/input/evdev.c:898
   evdev_do_ioctl+0x908/0x1a80 drivers/input/evdev.c:1157
   evdev_ioctl_handler drivers/input/evdev.c:1270 [inline]
   evdev_ioctl+0x17e/0x1f0 drivers/input/evdev.c:1279
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl fs/ioctl.c:583 [inline]
   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                        __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x5c/0x70 kernel/locking/spinlock.c:228
                        __do_wait+0x105/0x880 kernel/exit.c:1678
                        do_wait+0x1cb/0x5a0 kernel/exit.c:1722
                        kernel_wait+0x9f/0x160 kernel/exit.c:1898
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:163
                        process_one_work+0x920/0x1ac0 kernel/workqueue.c:3276
                        process_scheduled_works kernel/workqueue.c:3359 [inline]
                        worker_thread+0x693/0xeb0 kernel/workqueue.c:3440
                        kthread+0x385/0x490 kernel/kthread.c:436
                        ret_from_fork+0x67a/0xab0 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     SOFTIRQ-ON-R at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                        __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x5c/0x70 kernel/locking/spinlock.c:228
                        __do_wait+0x105/0x880 kernel/exit.c:1678
                        do_wait+0x1cb/0x5a0 kernel/exit.c:1722
                        kernel_wait+0x9f/0x160 kernel/exit.c:1898
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:163
                        process_one_work+0x920/0x1ac0 kernel/workqueue.c:3276
                        process_scheduled_works kernel/workqueue.c:3359 [inline]
                        worker_thread+0x693/0xeb0 kernel/workqueue.c:3440
                        kthread+0x385/0x490 kernel/kthread.c:436
                        ret_from_fork+0x67a/0xab0 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5868 [inline]
                       lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                       _raw_write_lock_irq+0x33/0x50 kernel/locking/spinlock.c:326
                       copy_process+0x4547/0x7440 kernel/fork.c:2369
                       kernel_clone+0xea/0x830 kernel/fork.c:2653
                       user_mode_thread+0xc8/0x110 kernel/fork.c:2729
                       rest_init+0x25/0x320 init/main.c:725
                       start_kernel+0x400/0x530 init/main.c:1210
                       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
                       x86_64_start_kernel+0x112/0x130 arch/x86/kernel/head64.c:291
                       common_startup_64+0x13e/0x148
     INITIAL READ USE at:
                            lock_acquire kernel/locking/lockdep.c:5868 [inline]
                            lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                            __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                            _raw_read_lock+0x5c/0x70 kernel/locking/spinlock.c:228
                            __do_wait+0x105/0x880 kernel/exit.c:1678
                            do_wait+0x1cb/0x5a0 kernel/exit.c:1722
                            kernel_wait+0x9f/0x160 kernel/exit.c:1898
                            call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:163
                            process_one_work+0x920/0x1ac0 kernel/workqueue.c:3276
                            process_scheduled_works kernel/workqueue.c:3359 [inline]
                            worker_thread+0x693/0xeb0 kernel/workqueue.c:3440
                            kthread+0x385/0x490 kernel/kthread.c:436
                            ret_from_fork+0x67a/0xab0 arch/x86/kernel/process.c:158
                            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   }
   ... key      at: [<ffffffffbba0c098>] tasklist_lock+0x18/0x40
   ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
   __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
   _raw_read_lock+0x5c/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xb8/0x420 fs/fcntl.c:932
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x218/0x590 fs/fcntl.c:1152
   sock_wake_async+0xd6/0x160 net/socket.c:1509
   sk_wake_async_rcu include/net/sock.h:2579 [inline]
   sk_wake_async_rcu include/net/sock.h:2576 [inline]
   sock_def_readable+0x55f/0x660 net/core/sock.c:3613
   __netlink_sendskb net/netlink/af_netlink.c:1263 [inline]
   netlink_sendskb net/netlink/af_netlink.c:1269 [inline]
   netlink_unicast+0x745/0x870 net/netlink/af_netlink.c:1359
   nlmsg_unicast include/net/netlink.h:1198 [inline]
   netlink_ack+0x6b6/0xb90 net/netlink/af_netlink.c:2512
   netlink_rcv_skb+0x344/0x430 net/netlink/af_netlink.c:2556
   nfnetlink_rcv+0x1af/0x420 net/netfilter/nfnetlink.c:669
   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
   netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1344
   netlink_sendmsg+0x8a3/0xda0 net/netlink/af_netlink.c:1894
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg net/socket.c:742 [inline]
   ____sys_sendmsg+0x9c4/0xb30 net/socket.c:2592
   ___sys_sendmsg+0x11c/0x1b0 net/socket.c:2646
   __sys_sendmsg+0x150/0x200 net/socket.c:2678
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5868 [inline]
                     lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                     _raw_write_lock_irq+0x33/0x50 kernel/locking/spinlock.c:326
                     __f_setown+0x60/0x3c0 fs/fcntl.c:136
                     fcntl_dirnotify+0x623/0xb60 fs/notify/dnotify/dnotify.c:369
                     do_fcntl+0x235/0x1580 fs/fcntl.c:538
                     __do_sys_fcntl fs/fcntl.c:602 [inline]
                     __se_sys_fcntl fs/fcntl.c:587 [inline]
                     __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5868 [inline]
                          lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
                          _raw_read_lock_irqsave+0x75/0x90 kernel/locking/spinlock.c:236
                          send_sigio+0x31/0x420 fs/fcntl.c:918
                          kill_fasync_rcu fs/fcntl.c:1144 [inline]
                          kill_fasync fs/fcntl.c:1159 [inline]
                          kill_fasync+0x218/0x590 fs/fcntl.c:1152
                          lease_break_callback+0x23/0x30 fs/locks.c:577
                          __break_lease+0x7e4/0x1b50 fs/locks.c:1657
                          break_lease include/linux/filelock.h:484 [inline]
                          break_lease include/linux/filelock.h:469 [inline]
                          vfs_truncate+0x3e1/0x4e0 fs/open.c:112
                          do_sys_truncate+0xd6/0x180 fs/open.c:142
                          __do_sys_truncate fs/open.c:154 [inline]
                          __se_sys_truncate fs/open.c:152 [inline]
                          __x64_sys_truncate+0x54/0x80 fs/open.c:152
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffffbe845aa0>] __key.1+0x0/0x40
  ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x75/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x31/0x420 fs/fcntl.c:918
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x218/0x590 fs/fcntl.c:1152
   lease_break_callback+0x23/0x30 fs/locks.c:577
   __break_lease+0x7e4/0x1b50 fs/locks.c:1657
   break_lease include/linux/filelock.h:484 [inline]
   break_lease include/linux/filelock.h:469 [inline]
   vfs_truncate+0x3e1/0x4e0 fs/open.c:112
   do_sys_truncate+0xd6/0x180 fs/open.c:142
   __do_sys_truncate fs/open.c:154 [inline]
   __se_sys_truncate fs/open.c:152 [inline]
   __x64_sys_truncate+0x54/0x80 fs/open.c:152
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){...-}-{3:3} {
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5868 [inline]
                    lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
                    _raw_read_lock_irqsave+0x46/0x90 kernel/locking/spinlock.c:236
                    kill_fasync_rcu fs/fcntl.c:1135 [inline]
                    kill_fasync fs/fcntl.c:1159 [inline]
                    kill_fasync+0x137/0x590 fs/fcntl.c:1152
                    sock_wake_async+0xd6/0x160 net/socket.c:1509
                    sk_wake_async_rcu include/net/sock.h:2579 [inline]
                    sk_wake_async_rcu include/net/sock.h:2576 [inline]
                    sock_def_readable+0x55f/0x660 net/core/sock.c:3613
                    packet_rcv+0xec8/0x1740 net/packet/af_packet.c:2209
                    dev_queue_xmit_nit+0x713/0xb00 net/core/dev.c:2606
                    xmit_one net/core/dev.c:3884 [inline]
                    dev_hard_start_xmit+0x605/0x720 net/core/dev.c:3904
                    __dev_queue_xmit+0x1649/0x3f60 net/core/dev.c:4854
                    dev_queue_xmit include/linux/netdevice.h:3385 [inline]
                    neigh_hh_output include/net/neighbour.h:540 [inline]
                    neigh_output include/net/neighbour.h:554 [inline]
                    ip_finish_output2+0xb1c/0x1ce0 net/ipv4/ip_output.c:237
                    __ip_finish_output.part.0+0x1bb/0x350 net/ipv4/ip_output.c:315
                    __ip_finish_output net/ipv4/ip_output.c:303 [inline]
                    ip_finish_output net/ipv4/ip_output.c:325 [inline]
                    NF_HOOK_COND include/linux/netfilter.h:307 [inline]
                    ip_output+0x3a9/0xd00 net/ipv4/ip_output.c:438
                    dst_output include/net/dst.h:470 [inline]
                    ip_local_out+0x1b4/0x200 net/ipv4/ip_output.c:131
                    __ip_queue_xmit+0x899/0x1f40 net/ipv4/ip_output.c:534
                    __tcp_transmit_skb+0x2f93/0x4780 net/ipv4/tcp_output.c:1693
                    __tcp_send_ack.part.0+0x3ce/0x670 net/ipv4/tcp_output.c:4503
                    __tcp_send_ack net/ipv4/tcp_output.c:4509 [inline]
                    tcp_send_ack+0x83/0xa0 net/ipv4/tcp_output.c:4509
                    tcp_delack_timer_handler net/ipv4/tcp_timer.c:345 [inline]
                    tcp_delack_timer_handler+0x2b8/0x460 net/ipv4/tcp_timer.c:308
                    tcp_delack_timer+0x232/0x3c0 net/ipv4/tcp_timer.c:376
                    call_timer_fn+0x189/0x5c0 kernel/time/timer.c:1748
                    expire_timers kernel/time/timer.c:1799 [inline]
                    __run_timers+0x6cd/0xb00 kernel/time/timer.c:2373
                    __run_timer_base kernel/time/timer.c:2385 [inline]
                    __run_timer_base kernel/time/timer.c:2377 [inline]
                    run_timer_base kernel/time/timer.c:2394 [inline]
                    run_timer_softirq+0x117/0x210 kernel/time/timer.c:2404
                    handle_softirqs+0x1b0/0x8d0 kernel/softirq.c:622
                    __do_softirq kernel/softirq.c:656 [inline]
                    invoke_softirq kernel/softirq.c:496 [inline]
                    __irq_exit_rcu+0xc4/0x100 kernel/softirq.c:723
                    irq_exit_rcu+0x9/0x20 kernel/softirq.c:739
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
                    sysvec_apic_timer_interrupt+0x70/0x80 arch/x86/kernel/apic/apic.c:1056
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:729
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    pv_native_safe_halt+0x1e/0x30 arch/x86/kernel/paravirt.c:62
                    arch_safe_halt arch/x86/include/asm/paravirt.h:73 [inline]
                    default_idle+0xe/0x20 arch/x86/kernel/process.c:767
                    default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
                    cpuidle_idle_call kernel/sched/idle.c:199 [inline]
                    do_idle+0x31f/0x580 kernel/sched/idle.c:352
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:451
                    start_secondary+0x1c7/0x230 arch/x86/kernel/smpboot.c:312
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5868 [inline]
                   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                   _raw_write_lock_irq+0x33/0x50 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xb2/0x1e0 fs/fcntl.c:1012
                   fasync_helper+0xa6/0xc0 fs/fcntl.c:1115
                   pipe_fasync+0xce/0x210 fs/pipe.c:758
                   __fput+0x94b/0xb50 fs/file_table.c:466
                   task_work_run+0x16b/0x260 kernel/task_work.c:233
                   exit_task_work include/linux/task_work.h:40 [inline]
                   do_exit+0x8c3/0x29e0 kernel/exit.c:976
                   __do_sys_exit kernel/exit.c:1085 [inline]
                   __se_sys_exit kernel/exit.c:1083 [inline]
                   __x64_sys_exit+0x42/0x50 kernel/exit.c:1083
                   x64_sys_call+0x18d8/0x18e0 arch/x86/include/generated/asm/syscalls_64.h:61
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5868 [inline]
                        lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
                        _raw_read_lock_irqsave+0x75/0x90 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1135 [inline]
                        kill_fasync fs/fcntl.c:1159 [inline]
                        kill_fasync+0x137/0x590 fs/fcntl.c:1152
                        fsnotify_insert_event+0x379/0x480 fs/notify/notification.c:128
                        fsnotify_add_event include/linux/fsnotify_backend.h:739 [inline]
                        inotify_handle_inode_event+0x2a7/0x420 fs/notify/inotify/inotify_fsnotify.c:126
                        fsnotify_handle_inode_event.isra.0+0x1df/0x410 fs/notify/fsnotify.c:272
                        fsnotify_handle_event fs/notify/fsnotify.c:327 [inline]
                        send_to_group fs/notify/fsnotify.c:375 [inline]
                        fsnotify+0x147d/0x1a10 fs/notify/fsnotify.c:592
                        __fsnotify_parent+0x781/0xca0 fs/notify/fsnotify.c:238
                        fsnotify_parent include/linux/fsnotify.h:96 [inline]
                        fsnotify_dentry include/linux/fsnotify.h:108 [inline]
                        fsnotify_change include/linux/fsnotify.h:495 [inline]
                        notify_change+0x96b/0x1330 fs/attr.c:561
                        chown_common+0x3fe/0x690 fs/open.c:778
                        do_fchownat+0x18b/0x1e0 fs/open.c:806
                        __do_sys_lchown fs/open.c:831 [inline]
                        __se_sys_lchown fs/open.c:829 [inline]
                        __x64_sys_lchown+0x7e/0xc0 fs/open.c:829
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                        do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffffbe845a60>] __key.0+0x0/0x40
 ... acquired at:
   check_prevs_add kernel/locking/lockdep.c:3284 [inline]
   validate_chain kernel/locking/lockdep.c:3908 [inline]
   __lock_acquire+0x15c0/0x2030 kernel/locking/lockdep.c:5237
   lock_acquire kernel/locking/lockdep.c:5868 [inline]
   lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x75/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1135 [inline]
   kill_fasync fs/fcntl.c:1159 [inline]
   kill_fasync+0x137/0x590 fs/fcntl.c:1152
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x63a/0x950 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x282/0x4e0 drivers/input/evdev.c:306
   input_pass_values+0x767/0x8b0 drivers/input/input.c:128
   input_event_dispose drivers/input/input.c:342 [inline]
   input_handle_event+0xe43/0x1510 drivers/input/input.c:370
   input_inject_event+0x1e5/0x420 drivers/input/input.c:424
   evdev_write+0x30a/0x460 drivers/input/evdev.c:528
   vfs_write+0x2b1/0x11a0 fs/read_write.c:686
   ksys_write+0x1ef/0x240 fs/read_write.c:740
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 2 UID: 0 PID: 30382 Comm: syz.6.15929 Kdump: loaded Not tainted 7.0.0-rc6-00259-g427a4f9708ee #82 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xca/0x120 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage+0x8a0/0xc50 kernel/locking/lockdep.c:2857
 check_prev_add+0xfd/0xcf0 kernel/locking/lockdep.c:3169
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15c0/0x2030 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x18c/0x300 kernel/locking/lockdep.c:5825
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
 _raw_read_lock_irqsave+0x75/0x90 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1135 [inline]
 kill_fasync fs/fcntl.c:1159 [inline]
 kill_fasync+0x137/0x590 fs/fcntl.c:1152
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values.part.0+0x63a/0x950 drivers/input/evdev.c:278
 evdev_pass_values drivers/input/evdev.c:253 [inline]
 evdev_events+0x282/0x4e0 drivers/input/evdev.c:306
 input_pass_values+0x767/0x8b0 drivers/input/input.c:128
 input_event_dispose drivers/input/input.c:342 [inline]
 input_handle_event+0xe43/0x1510 drivers/input/input.c:370
 input_inject_event+0x1e5/0x420 drivers/input/input.c:424
 evdev_write+0x30a/0x460 drivers/input/evdev.c:528
 vfs_write+0x2b1/0x11a0 fs/read_write.c:686
 ksys_write+0x1ef/0x240 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb7b9b282d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb 15 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007fbb7a499cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000005d61c0 RCX: 00007fbb7b9b282d
RDX: 0000000000000048 RSI: 0000200000000480 RDI: 0000000000000003
RBP: 00000000005d61c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000005d6258 R14: 00007fbb7b934fe0 R15: 0000000000000000
 </TASK>


-- 
All rights reversed.
 
