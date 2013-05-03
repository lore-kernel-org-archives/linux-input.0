From: majianpeng <majianpeng@gmail.com>
Subject: [BUG]  suspicious RCU usage
Date: Fri, 03 May 2013 14:53:49 +0800
Message-ID: <51835EFD.2070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58630 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab3ECGxz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 02:53:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so780384pac.14
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 23:53:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi,
    I found some message about input subsystem.
[  167.518470] ===============================
[  167.518471] [ INFO: suspicious RCU usage. ]
[  167.518473] 3.9.0+ #94 Not tainted
[  167.518474] -------------------------------
[  167.518475] include/linux/rcupdate.h:476 Illegal context switch in RCU read-side critical section!
[  167.518476]
[  167.518476] other info that might help us debug this:
[  167.518476]
[  167.518478]
[  167.518478] rcu_scheduler_active = 1, debug_locks = 0
[  167.518479] 4 locks held by Xorg/5502:
[  167.518480]  #0:  (&evdev->mutex){+.+...}, at: [<ffffffff81512c3d>] evdev_write+0x6d/0x160
[  167.518488]  #1:  (&(&dev->event_lock)->rlock#2){-.-...}, at: [<ffffffff8150dd9b>] input_inject_event+0x5b/0x230
[  167.518493]  #2:  (rcu_read_lock){.+.+..}, at: [<ffffffff8150dd82>] input_inject_event+0x42/0x230
[  167.518496]  #3:  (&(&usbhid->lock)->rlock){-.....}, at: [<ffffffff81565289>] usb_hidinput_input_event+0x89/0x120
[  167.518501]
[  167.518501] stack backtrace:
[  167.518503] CPU: 0 PID: 5502 Comm: Xorg Not tainted 3.9.0+ #94
[  167.518505] Hardware name: Dell Inc. OptiPlex 390/0M5DCD, BIOS A09 07/24/2012
[  167.518506]  0000000000000001 ffff8800689c7c38 ffffffff816f249f ffff8800689c7c68
[  167.518509]  ffffffff810acb1d 0000000000000000 ffffffff81a03ac7 000000000000019d
[  167.518511]  0000000000000000 ffff8800689c7c90 ffffffff8107cda7 0000000000000000
[  167.518514] Call Trace:
[  167.518517]  [<ffffffff816f249f>] dump_stack+0x19/0x1b
[  167.518521]  [<ffffffff810acb1d>] lockdep_rcu_suspicious+0xfd/0x130
[  167.518524]  [<ffffffff8107cda7>] __might_sleep+0xc7/0x230
[  167.518526]  [<ffffffff816f7770>] mutex_lock_nested+0x40/0x3a0
[  167.518530]  [<ffffffff81312ac4>] ? vsnprintf+0x354/0x640
[  167.518533]  [<ffffffff81553cc4>] hid_debug_event+0x34/0x100
[  167.518535]  [<ffffffff81554197>] hid_dump_input+0x67/0xa0
[  167.518537]  [<ffffffff81556430>] hid_set_field+0x50/0x120
[  167.518539]  [<ffffffff8156529a>] usb_hidinput_input_event+0x9a/0x120
[  167.518541]  [<ffffffff8150d89e>] input_handle_event+0x8e/0x530
[  167.518543]  [<ffffffff8150df10>] input_inject_event+0x1d0/0x230
[  167.518545]  [<ffffffff8150dd82>] ? input_inject_event+0x42/0x230
[  167.518548]  [<ffffffff81512cae>] evdev_write+0xde/0x160
[  167.518551]  [<ffffffff81185038>] vfs_write+0xc8/0x1f0
[  167.518553]  [<ffffffff81185535>] SyS_write+0x55/0xa0
[  167.518555]  [<ffffffff81704482>] system_call_fastpath+0x16/0x1b
[  167.518557] BUG: sleeping function called from invalid context at kernel/mutex.c:413
[  167.518558] in_atomic(): 1, irqs_disabled(): 1, pid: 5502, name: Xorg
[  167.518559] INFO: lockdep is turned off.
[  167.518560] irq event stamp: 1098574
[  167.518561] hardirqs last  enabled at (1098573): [<ffffffff816fb53f>] _raw_spin_unlock_irqrestore+0x3f/0x70
[  167.518563] hardirqs last disabled at (1098574): [<ffffffff816faaf5>] _raw_spin_lock_irqsave+0x25/0xa0
[  167.518565] softirqs last  enabled at (1098306): [<ffffffff8104971f>] __do_softirq+0x18f/0x3c0
[  167.518568] softirqs last disabled at (1097867): [<ffffffff81049ad5>] irq_exit+0xa5/0xb0
[  167.518570] CPU: 0 PID: 5502 Comm: Xorg Not tainted 3.9.0+ #94
[  167.518571] Hardware name: Dell Inc. OptiPlex 390/0M5DCD, BIOS A09 07/24/2012
[  167.518572]  ffffffff81a03ac7 ffff8800689c7c68 ffffffff816f249f ffff8800689c7c90
[  167.518574]  ffffffff8107ce60 0000000000000000 ffff8800689c7fd8 ffff88006a62c800
[  167.518577]  ffff8800689c7d10 ffffffff816f7770 ffff8800689c7d00 ffffffff81312ac4
[  167.518579] Call Trace:
[  167.518581]  [<ffffffff816f249f>] dump_stack+0x19/0x1b
[  167.518583]  [<ffffffff8107ce60>] __might_sleep+0x180/0x230
[  167.518585]  [<ffffffff816f7770>] mutex_lock_nested+0x40/0x3a0
[  167.518587]  [<ffffffff81312ac4>] ? vsnprintf+0x354/0x640
[  167.518590]  [<ffffffff81553cc4>] hid_debug_event+0x34/0x100
[  167.518592]  [<ffffffff81554197>] hid_dump_input+0x67/0xa0
[  167.518594]  [<ffffffff81556430>] hid_set_field+0x50/0x120
[  167.518596]  [<ffffffff8156529a>] usb_hidinput_input_event+0x9a/0x120
[  167.518598]  [<ffffffff8150d89e>] input_handle_event+0x8e/0x530
[  167.518600]  [<ffffffff8150df10>] input_inject_event+0x1d0/0x230
[  167.518602]  [<ffffffff8150dd82>] ? input_inject_event+0x42/0x230
[  167.518604]  [<ffffffff81512cae>] evdev_write+0xde/0x160
[  167.518606]  [<ffffffff81185038>] vfs_write+0xc8/0x1f0
[  167.518608]  [<ffffffff81185535>] SyS_write+0x55/0xa0
[  167.518610]  [<ffffffff81704482>] system_call_fastpath+0x16/0x1b


Thanks!
Jianpeng Ma

