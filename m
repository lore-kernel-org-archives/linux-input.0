From: Johannes Berg <johannes@sipsolutions.net>
Subject: lockdep report at resume
Date: Sat, 07 Feb 2009 17:01:57 +0100
Message-ID: <1234022517.4175.107.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:58249 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZBGQCH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Feb 2009 11:02:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Nothing special, just suspended/resumed with an external USB mouse,
internal keyboard is USB as well:

[20920.458587] =======================================================
[20920.458944] [ INFO: possible circular locking dependency detected ]
[20920.459231] 2.6.29-rc3-wl-12787-g17d9115-dirty #38
[20920.459449] -------------------------------------------------------
[20920.459736] events/0/9 is trying to acquire lock:
[20920.459951]  (&dev->mutex){--..}, at: [<ffffffff804be0ac>] input_disconnect_device+0x2c/0xf0
[20920.460369] 
[20920.460370] but task is already holding lock:
[20920.460637]  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>] run_workqueue+0xb3/0x250
[20920.461049] 
[20920.461050] which lock already depends on the new lock.
[20920.461051] 
[20920.461425] 
[20920.461425] the existing dependency chain (in reverse order) is:
[20920.461767] 
[20920.461767] -> #4 (&usbhid->reset_work){--..}:
[20920.462068]        [<ffffffff80273c17>] check_prev_add+0x3b7/0x770
[20920.462361]        [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.462653]        [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.462945]        [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.463222]        [<ffffffff8025a97f>] run_workqueue+0xff/0x250
[20920.463506]        [<ffffffff8025ab7f>] worker_thread+0xaf/0x130
[20920.463791]        [<ffffffff8025f1f9>] kthread+0x49/0x90
[20920.464048]        [<ffffffff8020cdba>] child_rip+0xa/0x20
[20920.464310]        [<ffffffffffffffff>] 0xffffffffffffffff
[20920.464572] 
[20920.464572] -> #3 (events){--..}:
[20920.464821]        [<ffffffff80273c17>] check_prev_add+0x3b7/0x770
[20920.465113]        [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.465405]        [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.465697]        [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.465974]        [<ffffffff8025ae0d>] cleanup_workqueue_thread+0x3d/0x80
[20920.466298]        [<ffffffff805a4c45>] workqueue_cpu_callback+0x95/0x12a
[20920.466619]        [<ffffffff805b8dd5>] notifier_call_chain+0x65/0xa0
[20920.466924]        [<ffffffff80264441>] raw_notifier_call_chain+0x11/0x20
[20920.467244]        [<ffffffff805a2be3>] _cpu_down+0x1d3/0x350
[20920.467518]        [<ffffffff802483fd>] disable_nonboot_cpus+0xdd/0x160
[20920.467831]        [<ffffffff80284345>] hibernation_snapshot+0x135/0x170
[20920.468134]        [<ffffffff80287b9d>] snapshot_ioctl+0x41d/0x610
[20920.468134]        [<ffffffff802e8921>] vfs_ioctl+0x31/0xa0
[20920.468134]        [<ffffffff802e8ce9>] do_vfs_ioctl+0x89/0x350
[20920.468134]        [<ffffffff802e8ffa>] sys_ioctl+0x4a/0x80
[20920.468134]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[20920.468134]        [<ffffffffffffffff>] 0xffffffffffffffff
[20920.468134] 
[20920.468134] -> #2 (cpu_add_remove_lock){--..}:
[20920.468134]        [<ffffffff80273c17>] check_prev_add+0x3b7/0x770
[20920.468134]        [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.468134]        [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.468134]        [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.468134]        [<ffffffff805b328c>] mutex_lock_nested+0xec/0x380
[20920.468134]        [<ffffffff80248292>] cpu_maps_update_begin+0x12/0x20
[20920.468134]        [<ffffffff8025ae93>] destroy_workqueue+0x33/0xb0
[20920.468134]        [<ffffffffa0783110>] input_close_polled_device+0x40/0x50 [input_polldev]
[20920.468134]        [<ffffffff804bdb27>] input_close_device+0x57/0x90
[20920.468134]        [<ffffffffa028f1e9>] evdev_release+0xa9/0xd0 [evdev]
[20920.468134]        [<ffffffff802db470>] __fput+0xd0/0x1e0
[20920.468134]        [<ffffffff802db59d>] fput+0x1d/0x30
[20920.468134]        [<ffffffff802d7cf0>] filp_close+0x50/0x80
[20920.468134]        [<ffffffff802d7dd9>] sys_close+0xb9/0x120
[20920.468134]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[20920.468134]        [<ffffffffffffffff>] 0xffffffffffffffff
[20920.468134] 
[20920.468134] -> #1 (polldev_mutex){--..}:
[20920.468134]        [<ffffffff80273c17>] check_prev_add+0x3b7/0x770
[20920.468134]        [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.468134]        [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.468134]        [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.468134]        [<ffffffff805b2e5c>] mutex_lock_interruptible_nested+0xec/0x430
[20920.468134]        [<ffffffffa078313c>] input_open_polled_device+0x1c/0xc0 [input_polldev]
[20920.468134]        [<ffffffff804bdbf8>] input_open_device+0x98/0xc0
[20920.468134]        [<ffffffffa028f460>] evdev_open+0x1c0/0x1e0 [evdev]
[20920.468134]        [<ffffffff804bd08f>] input_open_file+0xff/0x1e0
[20920.468134]        [<ffffffff802dd397>] chrdev_open+0x137/0x210
[20920.468134]        [<ffffffff802d80aa>] __dentry_open+0x10a/0x340
[20920.468134]        [<ffffffff802d83e7>] nameidata_to_filp+0x57/0x70
[20920.468134]        [<ffffffff802e702e>] do_filp_open+0x1fe/0x970
[20920.468134]        [<ffffffff802d7eb8>] do_sys_open+0x78/0x110
[20920.468134]        [<ffffffff802d7f7b>] sys_open+0x1b/0x20
[20920.468134]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[20920.468134]        [<ffffffffffffffff>] 0xffffffffffffffff
[20920.468134] 
[20920.468134] -> #0 (&dev->mutex){--..}:
[20920.468134]        [<ffffffff802738b7>] check_prev_add+0x57/0x770
[20920.468134]        [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.468134]        [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.468134]        [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.468134]        [<ffffffff805b328c>] mutex_lock_nested+0xec/0x380
[20920.468134]        [<ffffffff804be0ac>] input_disconnect_device+0x2c/0xf0
[20920.468134]        [<ffffffff804be18c>] input_unregister_device+0x1c/0x100
[20920.468134]        [<ffffffffa03202f4>] bcm5974_disconnect+0x24/0x90 [bcm5974]
[20920.468134]        [<ffffffffa005c4f8>] usb_unbind_interface+0x68/0x170 [usbcore]
[20920.468134]        [<ffffffff80485eec>] __device_release_driver+0x7c/0xc0
[20920.468134]        [<ffffffff8048603b>] device_release_driver+0x2b/0x40
[20920.468134]        [<ffffffffa005c940>] usb_driver_release_interface+0xc0/0xe0 [usbcore]
[20920.468134]        [<ffffffffa005ca84>] usb_forced_unbind_intf+0x34/0x90 [usbcore]
[20920.468134]        [<ffffffffa0052035>] usb_reset_device+0xd5/0x220 [usbcore]
[20920.468134]        [<ffffffffa02d67ca>] hid_reset+0x18a/0x280 [usbhid]
[20920.468134]        [<ffffffff8025a985>] run_workqueue+0x105/0x250
[20920.468134]        [<ffffffff8025ab7f>] worker_thread+0xaf/0x130
[20920.468134]        [<ffffffff8025f1f9>] kthread+0x49/0x90
[20920.468134]        [<ffffffff8020cdba>] child_rip+0xa/0x20
[20920.468134]        [<ffffffffffffffff>] 0xffffffffffffffff
[20920.468134] 
[20920.468134] other info that might help us debug this:
[20920.468134] 
[20920.468134] 2 locks held by events/0/9:
[20920.468134]  #0:  (events){--..}, at: [<ffffffff8025a933>] run_workqueue+0xb3/0x250
[20920.468134]  #1:  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>] run_workqueue+0xb3/0x250
[20920.468134] 
[20920.468134] stack backtrace:
[20920.468134] Pid: 9, comm: events/0 Not tainted 2.6.29-rc3-wl-12787-g17d9115-dirty #38
[20920.468134] Call Trace:
[20920.468134]  [<ffffffff80273360>] print_circular_bug_tail+0xe0/0xf0
[20920.468134]  [<ffffffff802738b7>] check_prev_add+0x57/0x770
[20920.468134]  [<ffffffff80218afa>] ? save_stack_trace+0x2a/0x50
[20920.468134]  [<ffffffff802745d6>] validate_chain+0x606/0x6c0
[20920.468134]  [<ffffffff80274acf>] __lock_acquire+0x43f/0xa10
[20920.468134]  [<ffffffff80274aed>] ? __lock_acquire+0x45d/0xa10
[20920.468134]  [<ffffffff80275131>] lock_acquire+0x91/0xc0
[20920.468134]  [<ffffffff804be0ac>] ? input_disconnect_device+0x2c/0xf0
[20920.468134]  [<ffffffff805b328c>] mutex_lock_nested+0xec/0x380
[20920.468134]  [<ffffffff804be0ac>] ? input_disconnect_device+0x2c/0xf0
[20920.468134]  [<ffffffff80272d52>] ? trace_hardirqs_on_caller+0x182/0x1e0
[20920.468134]  [<ffffffff804be0ac>] ? input_disconnect_device+0x2c/0xf0
[20920.468134]  [<ffffffffa0056264>] ? usb_hcd_flush_endpoint+0x84/0x200 [usbcore]
[20920.468134]  [<ffffffff805b2b0d>] ? __mutex_unlock_slowpath+0x12d/0x1a0
[20920.468134]  [<ffffffff804be0ac>] input_disconnect_device+0x2c/0xf0
[20920.468134]  [<ffffffff804be18c>] input_unregister_device+0x1c/0x100
[20920.468134]  [<ffffffffa03202f4>] bcm5974_disconnect+0x24/0x90 [bcm5974]
[20920.468134]  [<ffffffffa005c4f8>] usb_unbind_interface+0x68/0x170 [usbcore]
[20920.468134]  [<ffffffff80485eec>] __device_release_driver+0x7c/0xc0
[20920.468134]  [<ffffffff8048603b>] device_release_driver+0x2b/0x40
[20920.468134]  [<ffffffffa005c940>] usb_driver_release_interface+0xc0/0xe0 [usbcore]
[20920.468134]  [<ffffffffa005ca84>] usb_forced_unbind_intf+0x34/0x90 [usbcore]
[20920.468134]  [<ffffffffa0052035>] usb_reset_device+0xd5/0x220 [usbcore]
[20920.468134]  [<ffffffffa02d67ca>] hid_reset+0x18a/0x280 [usbhid]
[20920.468134]  [<ffffffffa02d6640>] ? hid_reset+0x0/0x280 [usbhid]
[20920.468134]  [<ffffffff8025a985>] run_workqueue+0x105/0x250
[20920.468134]  [<ffffffff8025a933>] ? run_workqueue+0xb3/0x250
[20920.468134]  [<ffffffff8025ab7f>] worker_thread+0xaf/0x130
[20920.468134]  [<ffffffff8025f6c0>] ? autoremove_wake_function+0x0/0x40
[20920.468134]  [<ffffffff8025aad0>] ? worker_thread+0x0/0x130
[20920.468134]  [<ffffffff8025f1f9>] kthread+0x49/0x90
[20920.468134]  [<ffffffff8020cdba>] child_rip+0xa/0x20
[20920.468134]  [<ffffffff8020c780>] ? restore_args+0x0/0x30
[20920.468134]  [<ffffffff8025f1b0>] ? kthread+0x0/0x90
[20920.468134]  [<ffffffff8020cdb0>] ? child_rip+0x0/0x20


