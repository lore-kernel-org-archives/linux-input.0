From: Borislav Petkov <bp@alien8.de>
Subject: Re: psmouse_disconnect lockdep splat
Date: Tue, 18 Oct 2016 14:09:22 +0200
Message-ID: <20161018120921.dhlo76bbkdhlm7ey@pd.tnic>
References: <20160828093011.GA2842@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160828093011.GA2842@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Richard Pospesel <pospeselr@gmail.com>
List-Id: linux-input@vger.kernel.org

Adding more people to CC.

I still see this after 4.8 is out.

So PeterZ suggested something like this:

---
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index fb4b185dea96..9112c3cecad7 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1420,14 +1420,16 @@ static void psmouse_disconnect(struct serio *serio)
 		psmouse_deactivate(parent);
 	}
 
-	if (psmouse->disconnect)
-		psmouse->disconnect(psmouse);
-
 	if (parent && parent->pt_deactivate)
 		parent->pt_deactivate(parent);
 
 	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
+	mutex_unlock(&psmouse_mutex);
+	if (psmouse->disconnect)
+		psmouse->disconnect(psmouse);
+	mutex_lock(&psmouse_mutex);
+
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	input_unregister_device(psmouse->dev);
---

to fix the lock inversion but that might have the other problem of
being racy by maybe ->reconnect() accessing psmouse->private in
trackpoint_sync() outside of the psmouse_mutex lock and that won't be
nice.

But someone more knowledgeable with this code should take a look and
suggest a proper fix.

Thanks!

(Leaving in the rest for reference).

On Sun, Aug 28, 2016 at 11:30:11AM +0200, Borislav Petkov wrote:
> Hi,
> 
> just saw this while booting rc3+tip/master. Thought I should report it
> in case it hasn't been caught and fixed yet.
> 
> ---
> 
> ...
> [    6.257924] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [    6.280232] iTCO_vendor_support: vendor-support=0
> [    6.282063] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops)
> [    6.285810] psmouse serio2: Failed to deactivate mouse on synaptics-pt/serio0
> [    6.286331] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [    6.286392] iTCO_wdt: Found a Panther Point TCO device (Version=2, TCOBASE=0x0460)
> [    6.290473] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
> [    6.293635] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
> [    6.298520] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
> [    6.300605] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [    6.303861] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
> [    6.307117] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
> [    6.310045] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
> [    6.311645] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
> [    6.312865] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
> [    6.346990] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
> [    6.348316] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    6.350870] hub 1-1:1.0: USB hub found
> [    6.352530] hub 1-1:1.0: 6 ports detected
> [    6.390558] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
> [    6.391706] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    6.393209] hub 2-1:1.0: USB hub found
> [    6.394534] hub 2-1:1.0: 8 ports detected
> [    6.415139] random: crng init done
> [    6.590812] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    6.749939] psmouse serio2: Failed to enable mouse on synaptics-pt/serio0
> 
> [    7.000430] ======================================================
> [    7.001447] [ INFO: possible circular locking dependency detected ]
> [    7.002453] 4.8.0-rc3+ #1 Not tainted
> [    7.003420] -------------------------------------------------------
> [    7.004366] kworker/0:1/45 is trying to acquire lock:
> [    7.005291]  (s_active#41){++++.+}, at: [<ffffffff812675e5>] kernfs_remove_by_name_ns+0x45/0xa0
> [    7.006243] 
>                but task is already holding lock:
> [    7.008074]  (psmouse_mutex){+.+.+.}, at: [<ffffffff815dedfc>] psmouse_disconnect+0x6c/0x150
> [    7.009011] 
>                which lock already depends on the new lock.
> 
> [    7.011753] 
>                the existing dependency chain (in reverse order) is:
> [    7.013576] 
>                -> #1 (psmouse_mutex){+.+.+.}:
> [    7.015456]        [<ffffffff810bbf42>] lock_acquire+0xb2/0x200
> [    7.016400]        [<ffffffff8174a4c4>] mutex_lock_interruptible_nested+0x64/0x440
> [    7.017340]        [<ffffffff815debb1>] psmouse_attr_set_helper+0x31/0x110
> [    7.018292]        [<ffffffff8152e038>] dev_attr_store+0x18/0x30
> [    7.019214]        [<ffffffff81268f25>] sysfs_kf_write+0x45/0x60
> [    7.020125]        [<ffffffff812681d5>] kernfs_fop_write+0x135/0x1c0
> [    7.021023]        [<ffffffff811e8358>] __vfs_write+0x28/0x120
> [    7.021917]        [<ffffffff811e9498>] vfs_write+0xb8/0x1b0
> [    7.022793]        [<ffffffff811ea7e9>] SyS_write+0x49/0xa0
> [    7.023650]        [<ffffffff8174e9e9>] entry_SYSCALL_64_fastpath+0x1c/0xac
> [    7.024500] 
>                -> #0 (s_active#41){++++.+}:
> [    7.026151]        [<ffffffff810bb8f9>] __lock_acquire+0x1249/0x1480
> [    7.026995]        [<ffffffff810bbf42>] lock_acquire+0xb2/0x200
> [    7.027845]        [<ffffffff81266795>] __kernfs_remove+0x225/0x2f0
> [    7.028681]        [<ffffffff812675e5>] kernfs_remove_by_name_ns+0x45/0xa0
> [    7.029517]        [<ffffffff81269f16>] remove_files.isra.1+0x36/0x70
> [    7.030349]        [<ffffffff8126a2e4>] sysfs_remove_group+0x44/0x90
> [    7.031185]        [<ffffffff815eae04>] trackpoint_disconnect+0x24/0x40
> [    7.032014]        [<ffffffff815dee2a>] psmouse_disconnect+0x9a/0x150
> [    7.032843]        [<ffffffff815cca52>] serio_disconnect_driver+0x32/0x40
> [    7.033664]        [<ffffffff815cca75>] serio_driver_remove+0x15/0x20
> [    7.034490]        [<ffffffff81532cf1>] __device_release_driver+0xa1/0x160
> [    7.035316]        [<ffffffff81532dd5>] device_release_driver+0x25/0x40
> [    7.036139]        [<ffffffff815ccdfa>] serio_disconnect_port+0x7a/0xb0
> [    7.036955]        [<ffffffff815cd8d1>] serio_reconnect_subtree+0x51/0xb0
> [    7.037762]        [<ffffffff815cdac2>] serio_handle_event+0x192/0x210
> [    7.038568]        [<ffffffff810836d8>] process_one_work+0x1e8/0x740
> [    7.039350]        [<ffffffff81083c78>] worker_thread+0x48/0x4e0
> [    7.040111]        [<ffffffff8108a323>] kthread+0xf3/0x110
> [    7.040863]        [<ffffffff8174ec2f>] ret_from_fork+0x1f/0x40
> [    7.041610] 
>                other info that might help us debug this:
> 
> [    7.043777]  Possible unsafe locking scenario:
> 
> [    7.045191]        CPU0                    CPU1
> [    7.045883]        ----                    ----
> [    7.046549]   lock(psmouse_mutex);
> [    7.047216]                                lock(s_active#41);
> [    7.047881]                                lock(psmouse_mutex);
> [    7.048526]   lock(s_active#41);
> [    7.049165] 
>                 *** DEADLOCK ***
> 
> [    7.051023] 6 locks held by kworker/0:1/45:
> [    7.051638]  #0:  ("events_long"){.+.+.+}, at: [<ffffffff81083659>] process_one_work+0x169/0x740
> [    7.052298]  #1:  (serio_event_work){+.+.+.}, at: [<ffffffff81083659>] process_one_work+0x169/0x740
> [    7.052964]  #2:  (serio_mutex){+.+.+.}, at: [<ffffffff815cd950>] serio_handle_event+0x20/0x210
> [    7.053633]  #3:  (&dev->mutex){......}, at: [<ffffffff81532dcd>] device_release_driver+0x1d/0x40
> [    7.054312]  #4:  (&serio->drv_mutex){+.+.+.}, at: [<ffffffff815cca40>] serio_disconnect_driver+0x20/0x40
> [    7.055002]  #5:  (psmouse_mutex){+.+.+.}, at: [<ffffffff815dedfc>] psmouse_disconnect+0x6c/0x150
> [    7.055702] 
>                stack backtrace:
> [    7.057050] CPU: 0 PID: 45 Comm: kworker/0:1 Not tainted 4.8.0-rc3+ #1
> [    7.057745] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
> [    7.058462] Workqueue: events_long serio_handle_event
> [    7.059179]  0000000000000000 ffff880213537a20 ffffffff81336955 ffffffff825e1190
> [    7.059917]  ffffffff825e1190 ffff880213537a60 ffffffff810b8dd3 ffff880213537aa0
> [    7.060657]  ffff880213540828 ffff880213540850 0000000000000006 ffff880213540760
> [    7.061390] Call Trace:
> [    7.062113]  [<ffffffff81336955>] dump_stack+0x67/0x92
> [    7.062843]  [<ffffffff810b8dd3>] print_circular_bug+0x1e3/0x250
> [    7.063576]  [<ffffffff810bb8f9>] __lock_acquire+0x1249/0x1480
> [    7.064305]  [<ffffffff810ba20f>] ? mark_held_locks+0x6f/0xa0
> [    7.065033]  [<ffffffff8174b7a8>] ? __mutex_unlock_slowpath+0xf8/0x1a0
> [    7.065764]  [<ffffffff810bbf42>] lock_acquire+0xb2/0x200
> [    7.066495]  [<ffffffff812675e5>] ? kernfs_remove_by_name_ns+0x45/0xa0
> [    7.067229]  [<ffffffff81266795>] __kernfs_remove+0x225/0x2f0
> [    7.067959]  [<ffffffff812675e5>] ? kernfs_remove_by_name_ns+0x45/0xa0
> [    7.068691]  [<ffffffff812662c4>] ? kernfs_find_ns+0x94/0x140
> [    7.069416]  [<ffffffff812675e5>] kernfs_remove_by_name_ns+0x45/0xa0
> [    7.070148]  [<ffffffff81269f16>] remove_files.isra.1+0x36/0x70
> [    7.070876]  [<ffffffff8126a2e4>] sysfs_remove_group+0x44/0x90
> [    7.071605]  [<ffffffff815eae04>] trackpoint_disconnect+0x24/0x40
> [    7.072334]  [<ffffffff815dee2a>] psmouse_disconnect+0x9a/0x150
> [    7.073063]  [<ffffffff815cca52>] serio_disconnect_driver+0x32/0x40
> [    7.073795]  [<ffffffff815cca75>] serio_driver_remove+0x15/0x20
> [    7.074528]  [<ffffffff81532cf1>] __device_release_driver+0xa1/0x160
> [    7.075260]  [<ffffffff81532dd5>] device_release_driver+0x25/0x40
> [    7.075991]  [<ffffffff815ccdfa>] serio_disconnect_port+0x7a/0xb0
> [    7.076721]  [<ffffffff815cd8d1>] serio_reconnect_subtree+0x51/0xb0
> [    7.077451]  [<ffffffff815cdac2>] serio_handle_event+0x192/0x210
> [    7.078183]  [<ffffffff810836d8>] process_one_work+0x1e8/0x740
> [    7.078919]  [<ffffffff81083659>] ? process_one_work+0x169/0x740
> [    7.079663]  [<ffffffff81083c78>] worker_thread+0x48/0x4e0
> [    7.080407]  [<ffffffff81748119>] ? schedule+0x49/0xa0
> [    7.081148]  [<ffffffff81091201>] ? preempt_count_sub+0xa1/0x110
> [    7.081901]  [<ffffffff81083c30>] ? process_one_work+0x740/0x740
> [    7.082649]  [<ffffffff8108a323>] kthread+0xf3/0x110
> [    7.083397]  [<ffffffff8174ec2f>] ret_from_fork+0x1f/0x40
> [    7.084152]  [<ffffffff8108a230>] ? kthread_create_on_node+0x230/0x230
> [    7.391560] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
> [    7.412104] loop: module loaded
> [    7.771919] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [    7.961843] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input18
> [    8.474792] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input19
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> ECO tip #101: Trim your mails when you reply.
> --
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
