From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Lockdep violation in 2.6.28-rc4 + gregkh-all
Date: Thu, 13 Nov 2008 12:50:45 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811131244320.32143@jikos.suse.cz>
References: <Pine.LNX.4.44L0.0811121650090.2186-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:37407 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751797AbYKMLur (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 06:50:47 -0500
In-Reply-To: <Pine.LNX.4.44L0.0811121650090.2186-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, 12 Nov 2008, Alan Stern wrote:

> [  795.103175] =======================================================
> [  795.103347] [ INFO: possible circular locking dependency detected ]
> [  795.103439] 2.6.28-rc4 #1
> [  795.103522] -------------------------------------------------------
> [  795.103614] rmmod/2553 is trying to acquire lock:
> [  795.103703]  (&dev->mutex){--..}, at: [<c054680e>] input_unregister_device+0x16/0x15d
> [  795.103957] 
> [  795.103958] but task is already holding lock:
> [  795.104060]  (&usbhid->setup){--..}, at: [<f077a69e>] usbhid_stop+0x40/0xf8 [usbhid]
> [  795.104060] which lock already depends on the new lock.

Hmm, I don't think I really understand the root cause here on a first 
sight. We always take usbhid->setup mutex in usbhid_stop() and after that 
call into input_unregister_device(), which acquires the corresponding 
input_dev->mutex.

But I don't seem to be able find where we take input_dev->mutex before 
taking usbhid->setup mutex ... I somehow don't see that neither from the 
lockdep traces nor the code.

> [  795.104060] 
> [  795.104060] 
> [  795.104060] the existing dependency chain (in reverse order) is:
> [  795.104060] 
> [  795.104060] -> #2 (&usbhid->setup){--..}:
> [  795.104060]        [<c043b2b1>] __lock_acquire+0x89d/0x9fa
> [  795.104060]        [<c043b456>] lock_acquire+0x48/0x64
> [  795.104060]        [<c05a71da>] __mutex_lock_common+0xb8/0x2c9
> [  795.104060]        [<c05a7474>] mutex_lock_nested+0x29/0x31
> [  795.104060]        [<f077a2d5>] hid_suspend+0x24/0x7d [usbhid]
> [  795.104060]        [<f0662291>] usb_suspend_both+0xc6/0x21b [usbcore]
> [  795.104060]        [<f0662913>] usb_external_suspend_device+0x27/0x36 [usbcore]
> [  795.104060]        [<f0662953>] usb_suspend+0x31/0x37 [usbcore]
> [  795.104060]        [<f06590fc>] usb_dev_suspend+0xd/0xf [usbcore]
> [  795.104060]        [<c052f4ec>] pm_op+0x45/0xb0
> [  795.104060]        [<c052f971>] device_suspend+0x280/0x3f1
> [  795.104060]        [<c0442a89>] suspend_devices_and_enter+0x38/0x158
> [  795.104060]        [<c0442cfb>] enter_state+0x12a/0x182
> [  795.104060]        [<c0442de9>] state_store+0x96/0xaa
> [  795.104060]        [<c04d8b04>] kobj_attr_store+0x1a/0x22
> [  795.104060]        [<c049dc21>] sysfs_write_file+0xad/0xdf
> [  795.104060]        [<c046a5af>] vfs_write+0x7a/0xaa
> [  795.104060]        [<c046a673>] sys_write+0x3b/0x5d
> [  795.104060]        [<c04030c9>] sysenter_do_call+0x12/0x35
> [  795.104060]        [<ffffffff>] 0xffffffff
> [  795.104060] 
> [  795.104060] -> #1 (&dev->pm_mutex/2){--..}:
> [  795.104060]        [<c043b2b1>] __lock_acquire+0x89d/0x9fa
> [  795.104060]        [<c043b456>] lock_acquire+0x48/0x64
> [  795.104060]        [<c05a71da>] __mutex_lock_common+0xb8/0x2c9
> [  795.104060]        [<c05a7474>] mutex_lock_nested+0x29/0x31
> [  795.104060]        [<f0661cd6>] usb_pm_lock+0x14/0x16 [usbcore]
> [  795.104060]        [<f0662406>] usb_autopm_do_interface+0x20/0xad [usbcore]
> [  795.104060]        [<f06624ac>] usb_autopm_get_interface+0xd/0xf [usbcore]
> [  795.104060]        [<f077ab44>] usbhid_open+0x24/0x50 [usbhid]
> [  795.104060]        [<f07569c4>] hidinput_open+0x12/0x14 [hid]
> [  795.104060]        [<c054652c>] input_open_device+0x55/0x81
> [  795.104060]        [<c051740a>] kbd_connect+0x74/0x90
> [  795.104060]        [<c0545e4c>] input_attach_handler+0x33/0x66
> [  795.104060]        [<c054797d>] input_register_device+0x12e/0x15c
> [  795.104060]        [<f0758b4c>] hidinput_connect+0x1f29/0x1f53 [hid]
> [  795.104060]        [<f07556d9>] hid_connect+0x41/0x1fa [hid]
> [  795.104060]        [<f0755921>] hid_device_probe+0x8f/0xb1 [hid]
> [  795.104060]        [<c052cf9d>] driver_probe_device+0xb8/0x133
> [  795.104060]        [<c052d08b>] __device_attach+0x8/0xa
> [  795.104060]        [<c052c583>] bus_for_each_drv+0x39/0x63
> [  795.104060]        [<c052d0fd>] device_attach+0x51/0x68
> [  795.104060]        [<c052c523>] bus_attach_device+0x24/0x4b
> [  795.104060]        [<c052b569>] device_add+0x2ca/0x435
> [  795.104060]        [<f075567e>] hid_add_device+0xae/0xc8 [hid]
> [  795.104060]        [<f077b402>] hid_probe+0x1e4/0x229 [usbhid]
> [  795.104060]        [<f0662c83>] usb_probe_interface+0x11e/0x151 [usbcore]
> [  795.104060]        [<c052cf9d>] driver_probe_device+0xb8/0x133
> [  795.104060]        [<c052d064>] __driver_attach+0x4c/0x6b
> [  795.104060]        [<c052c7b0>] bus_for_each_dev+0x37/0x5b
> [  795.104060]        [<c052ce28>] driver_attach+0x14/0x16
> [  795.104060]        [<c052c3ac>] bus_add_driver+0x93/0x1b9
> [  795.104060]        [<c052d1df>] driver_register+0x71/0xcc
> [  795.104060]        [<f066269d>] usb_register_driver+0x71/0xce [usbcore]
> [  795.104060]        [<f070f042>] 0xf070f042
> [  795.104060]        [<c0401130>] _stext+0x48/0x10d
> [  795.104060]        [<c044215c>] sys_init_module+0x89/0x181
> [  795.104060]        [<c04030c9>] sysenter_do_call+0x12/0x35
> [  795.104060]        [<ffffffff>] 0xffffffff
> [  795.104060] 
> [  795.104060] -> #0 (&dev->mutex){--..}:
> [  795.104060]        [<c043b187>] __lock_acquire+0x773/0x9fa
> [  795.104060]        [<c043b456>] lock_acquire+0x48/0x64
> [  795.104060]        [<c05a71da>] __mutex_lock_common+0xb8/0x2c9
> [  795.104060]        [<c05a7474>] mutex_lock_nested+0x29/0x31
> [  795.104060]        [<c054680e>] input_unregister_device+0x16/0x15d
> [  795.104060]        [<f0756862>] hidinput_disconnect+0x21/0x3b [hid]
> [  795.104060]        [<f077a70b>] usbhid_stop+0xad/0xf8 [usbhid]
> [  795.104060]        [<f075518b>] hid_device_remove+0x2c/0x3b [hid]
> [  795.104060]        [<c052cd3d>] __device_release_driver+0x5d/0x7a
> [  795.104060]        [<c052ce09>] device_release_driver+0x1b/0x26
> [  795.104060]        [<c052cb18>] bus_remove_device+0x60/0x6f
> [  795.104060]        [<c052b1bd>] device_del+0xd1/0x154
> [  795.104060]        [<f0755350>] hid_destroy_device+0x1a/0x2f [hid]
> [  795.104060]        [<f077a366>] hid_disconnect+0x2a/0x34 [usbhid]
> [  795.104060]        [<f0662dd6>] usb_unbind_interface+0x4e/0xd4 [usbcore]
> [  795.104060]        [<c052cd3d>] __device_release_driver+0x5d/0x7a
> [  795.104060]        [<c052cdca>] driver_detach+0x70/0x94
> [  795.104060]        [<c052c2df>] bus_remove_driver+0x63/0x7f
> [  795.104060]        [<c052d15d>] driver_unregister+0x2a/0x2e
> [  795.104060]        [<f0662599>] usb_deregister+0x77/0x84 [usbcore]
> [  795.104060]        [<f077bdeb>] hid_exit+0xd/0x1e [usbhid]
> [  795.104060]        [<c0442085>] sys_delete_module+0x186/0x1d4
> [  795.104060]        [<c04030c9>] sysenter_do_call+0x12/0x35
> [  795.104060]        [<ffffffff>] 0xffffffff
> [  795.104060] 
> [  795.104060] other info that might help us debug this:
> [  795.104060] 
> [  795.104060] 1 lock held by rmmod/2553:
> [  795.104060]  #0:  (&usbhid->setup){--..}, at: [<f077a69e>] usbhid_stop+0x40/0xf8 [usbhid]
> [  795.104060] 
> [  795.104060] stack backtrace:
> [  795.104060] Pid: 2553, comm: rmmod Not tainted 2.6.28-rc4 #1
> [  795.104060] Call Trace:
> [  795.104060]  [<c0439d3d>] print_circular_bug_tail+0x5d/0x68
> [  795.104060]  [<c043b187>] __lock_acquire+0x773/0x9fa
> [  795.104060]  [<c043b456>] lock_acquire+0x48/0x64
> [  795.104060]  [<c054680e>] ? input_unregister_device+0x16/0x15d
> [  795.104060]  [<c05a71da>] __mutex_lock_common+0xb8/0x2c9
> [  795.104060]  [<c054680e>] ? input_unregister_device+0x16/0x15d
> [  795.104060]  [<c05a7474>] mutex_lock_nested+0x29/0x31
> [  795.104060]  [<c054680e>] ? input_unregister_device+0x16/0x15d
> [  795.104060]  [<c054680e>] input_unregister_device+0x16/0x15d
> [  795.104060]  [<f0756862>] hidinput_disconnect+0x21/0x3b [hid]
> [  795.104060]  [<f077a70b>] usbhid_stop+0xad/0xf8 [usbhid]
> [  795.104060]  [<f075518b>] hid_device_remove+0x2c/0x3b [hid]
> [  795.104060]  [<c052cd3d>] __device_release_driver+0x5d/0x7a
> [  795.104060]  [<c052ce09>] device_release_driver+0x1b/0x26
> [  795.104060]  [<c052cb18>] bus_remove_device+0x60/0x6f
> [  795.104060]  [<c052b1bd>] device_del+0xd1/0x154
> [  795.104060]  [<f0755350>] hid_destroy_device+0x1a/0x2f [hid]
> [  795.104060]  [<f077a366>] hid_disconnect+0x2a/0x34 [usbhid]
> [  795.104060]  [<f0662dd6>] usb_unbind_interface+0x4e/0xd4 [usbcore]
> [  795.104060]  [<c052cd3d>] __device_release_driver+0x5d/0x7a
> [  795.104060]  [<c052cdca>] driver_detach+0x70/0x94
> [  795.104060]  [<c052c2df>] bus_remove_driver+0x63/0x7f
> [  795.104060]  [<c052d15d>] driver_unregister+0x2a/0x2e
> [  795.104060]  [<f0662599>] usb_deregister+0x77/0x84 [usbcore]
> [  795.104060]  [<f077bdeb>] hid_exit+0xd/0x1e [usbhid]
> [  795.104060]  [<c0442085>] sys_delete_module+0x186/0x1d4
> [  795.104060]  [<c05aa409>] ? do_page_fault+0x1f1/0x599
> [  795.104060]  [<c05aa4fe>] ? do_page_fault+0x2e6/0x599
> [  795.104060]  [<c0403190>] ? restore_nocheck_notrace+0x0/0xe
> [  795.104060]  [<c05aa218>] ? do_page_fault+0x0/0x599
> [  795.104060]  [<c04030c9>] sysenter_do_call+0x12/0x35
> 
> 

-- 
Jiri Kosina
SUSE Labs
