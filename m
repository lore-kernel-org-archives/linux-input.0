From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v3] hid-sony: Prevent crash when rumble effects are still loaded at USB disconnect
Date: Tue, 7 Jun 2016 00:38:52 -0500
Message-ID: <650C9404-0604-4783-B8AC-A7FEC9A73676@gmail.com>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de> <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com> <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de> <01146ebc-3710-e3cd-812a-ca4f0ef84372@m-reimer.de> <768f4bf0-4b8d-7036-7ddd-1dc9ff4a171b@m-reimer.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34217 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcFGFiz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2016 01:38:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id r4so9391095oib.1
        for <linux-input@vger.kernel.org>; Mon, 06 Jun 2016 22:38:55 -0700 (PDT)
In-Reply-To: <768f4bf0-4b8d-7036-7ddd-1dc9ff4a171b@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org

This looks like the ff-memless effect timer is going off and invoking your effect callback
after sony_remove() has returned. No amount of locking is going to fix a callback to a
device that has been freed.

I took a look in ff-memless.c and I did not see any obvious code path where the effect
timer is stopped when the device is destroyed. That would explain the crashes you are
getting. Maybe I am missing something though.

Someone with some experience in the force feedback code could probably be more helpful.

I tried for a little while to reproduce this bug with fftest and xpad and never managed it.
What were you doing to trigger the bug?


Cameron

> On Jun 5, 2016, at 7:59 AM, Manuel Reimer <mail+linux-input@m-reimer.de> wrote:
> 
> Hello,
> 
> in the meantime, I got private mail with the suggestion, that I should have a look at spinlocks for my last change, so this is what I came up with:
> 
> 
> 
> 
> --- a/drivers/hid/hid-sony.c	2016-05-13 16:13:00.339346161 +0200
> +++ b/drivers/hid/hid-sony.c	2016-06-03 16:56:13.642143935 +0200
> @@ -1023,6 +1023,7 @@ static DEFINE_IDA(sony_device_id_allocat
> 
> struct sony_sc {
> 	spinlock_t lock;
> +	spinlock_t worker_initialized_lock;
> 	struct list_head list_node;
> 	struct hid_device *hdev;
> 	struct led_classdev *leds[MAX_LEDS];
> @@ -1051,6 +1052,20 @@ struct sony_sc {
> 	__u8 led_count;
> };
> 
> +static inline void sony_schedule_work(struct sony_sc *sc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sc->worker_initialized_lock, flags);
> +
> +	if (sc->worker_initialized)
> +		schedule_work(&sc->state_worker);
> +	else
> +		printk(KERN_ERR "hid-sony: Sending to uninitialized device failed!\n");
> +
> +	spin_unlock_irqrestore(&sc->worker_initialized_lock, flags);
> +}
> +
> static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
> 			     unsigned int *rsize)
> {
> @@ -1542,7 +1557,7 @@ static void buzz_set_leds(struct sony_sc
> static void sony_set_leds(struct sony_sc *sc)
> {
> 	if (!(sc->quirks & BUZZ_CONTROLLER))
> -		schedule_work(&sc->state_worker);
> +		sony_schedule_work(sc);
> 	else
> 		buzz_set_leds(sc);
> }
> @@ -1653,7 +1668,7 @@ static int sony_led_blink_set(struct led
> 		new_off != drv_data->led_delay_off[n]) {
> 		drv_data->led_delay_on[n] = new_on;
> 		drv_data->led_delay_off[n] = new_off;
> -		schedule_work(&drv_data->state_worker);
> +		sony_schedule_work(drv_data);
> 	}
> 
> 	return 0;
> @@ -1963,7 +1978,7 @@ static int sony_play_effect(struct input
> 	sc->left = effect->u.rumble.strong_magnitude / 256;
> 	sc->right = effect->u.rumble.weak_magnitude / 256;
> 
> -	schedule_work(&sc->state_worker);
> +	sony_schedule_work(sc);
> 	return 0;
> }
> 
> @@ -2255,18 +2270,30 @@ static void sony_release_device_id(struc
> static inline void sony_init_output_report(struct sony_sc *sc,
> 				void(*send_output_report)(struct sony_sc*))
> {
> +	unsigned long flags;
> +
> 	sc->send_output_report = send_output_report;
> 
> +	spin_lock_irqsave(&sc->worker_initialized_lock, flags);
> +
> 	if (!sc->worker_initialized)
> 		INIT_WORK(&sc->state_worker, sony_state_worker);
> 
> 	sc->worker_initialized = 1;
> +
> +	spin_unlock_irqrestore(&sc->worker_initialized_lock, flags);
> }
> 
> static inline void sony_cancel_work_sync(struct sony_sc *sc)
> {
> -	if (sc->worker_initialized)
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sc->worker_initialized_lock, flags);
> +	if (sc->worker_initialized) {
> +		sc->worker_initialized = 0;
> 		cancel_work_sync(&sc->state_worker);
> +	}
> +	spin_unlock_irqrestore(&sc->worker_initialized_lock, flags);
> }
> 
> static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
> @@ -2283,6 +2310,7 @@ static int sony_probe(struct hid_device
> 	}
> 
> 	spin_lock_init(&sc->lock);
> +	spin_lock_init(&sc->worker_initialized_lock);
> 
> 	sc->quirks = quirks;
> 	hid_set_drvdata(hdev, sc);
> 
> 
> 
> 
> 
> 
> Result:
> 
> 
> 
> 
> 
> [   67.956856] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d8
> [   68.380234] IP: [<ffffffffa036933d>] sony_play_effect+0x2d/0x90 [hid_sony]
> [   68.380234] PGD 0
> [   68.380234] Oops: 0002 [#1] PREEMPT SMP
> [   68.380234] Modules linked in: hid_sony ff_memless cfg80211 rfkill crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 ppdev lrw gf128mul glue_helper ablk_helper cryptd psmouse input_leds joydev led_class acpi_cpufreq serio_raw mousedev pcspkr mac_hid i2c_piix4 e1000 intel_agp intel_gtt tpm_tis tpm fjes video battery parport_pc parport button processor ac evdev sch_fq_codel vboxvideo(O) ttm drm_kms_helper drm syscopyarea sysfillrect sysimgblt fb_sys_fops vboxsf(O) vboxguest(O) ip_tables x_tables xfs libcrc32c hid_generic usbhid hid sr_mod cdrom sd_mod ata_generic pata_acpi atkbd libps2 ohci_pci ohci_hcd ata_piix ahci libahci usbcore crc32c_intel usb_common libata scsi_mod i8042 serio
> [   68.380234] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O 4.5.4-1-ARCH #1
> [   68.380234] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [   68.380234] task: ffffffff81811500 ti: ffffffff81800000 task.ti: ffffffff81800000
> [   68.380234] RIP: 0010:[<ffffffffa036933d>]  [<ffffffffa036933d>] sony_play_effect+0x2d/0x90 [hid_sony]
> [   68.380234] RSP: 0018:ffff88003fc03da0  EFLAGS: 00010046
> [   68.380234] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000ffff
> [   68.380234] RDX: ffff88003fc03df0 RSI: 0000000000000000 RDI: ffff88003d09d800
> [   68.380234] RBP: ffff88003fc03db8 R08: ffff880037bf3100 R09: 0000000000000000
> [   68.380234] R10: 0000000000000020 R11: 0000000000000000 R12: 0000000000000004
> [   68.380234] R13: ffff880039980c00 R14: ffff88003fc03df0 R15: 00000000000000b4
> [   68.380234] FS:  00007f1a3b54a780(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
> [   68.380234] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [   68.380234] CR2: 00000000000000d8 CR3: 000000003ceb7000 CR4: 00000000000406f0
> [   68.380234] Stack:
> [   68.380234]  0000000000000010 ffff880039980f08 ffff880039980c00 ffff88003fc03e50
> [   68.380234]  ffffffffa036475a 0000000000000002 0000000000015740 0000000000000046
> [   68.380234]  ffff880039980c08 000000000000ffff 0000000000000050 0000000000000000
> [   68.380234] Call Trace:
> [   68.380234]  <IRQ>
> [   68.380234]  [<ffffffffa036475a>] ml_play_effects+0x10a/0x700 [ff_memless]
> [   68.380234]  [<ffffffffa0364e90>] ? ml_ff_playback+0x100/0x100 [ff_memless]
> [   68.380234]  [<ffffffffa0364ecf>] ml_effect_timer+0x3f/0x170 [ff_memless]
> [   68.380234]  [<ffffffff810e3cc5>] call_timer_fn+0x35/0x150
> [   68.380234]  [<ffffffffa0364e90>] ? ml_ff_playback+0x100/0x100 [ff_memless]
> [   68.380234]  [<ffffffff810e4016>] run_timer_softirq+0x236/0x2e0
> [   68.380234]  [<ffffffff8107d3e6>] __do_softirq+0xe6/0x2f0
> [   68.380234]  [<ffffffff8107d763>] irq_exit+0xa3/0xb0
> [   68.380234]  [<ffffffff815b8112>] smp_apic_timer_interrupt+0x42/0x50
> [   68.380234]  [<ffffffff815b63f2>] apic_timer_interrupt+0x82/0x90
> [   68.380234]  <EOI>
> [   68.380234]  [<ffffffff8105f896>] ? native_safe_halt+0x6/0x10
> [   68.380234]  [<ffffffff81021c30>] default_idle+0x20/0x110
> [   68.380234]  [<ffffffff8102246f>] arch_cpu_idle+0xf/0x20
> [   68.380234]  [<ffffffff810baf0a>] default_idle_call+0x2a/0x40
> [   68.380234]  [<ffffffff810bb264>] cpu_startup_entry+0x344/0x3b0
> [   68.380234]  [<ffffffff815a8c19>] rest_init+0x89/0x90
> [   68.380234]  [<ffffffff8190c012>] start_kernel+0x46a/0x48b
> [   68.380234]  [<ffffffff8190b120>] ? early_idt_handler_array+0x120/0x120
> [   68.380234]  [<ffffffff8190b332>] x86_64_start_reservations+0x2a/0x2c
> [   68.380234]  [<ffffffff8190b480>] x86_64_start_kernel+0x14c/0x16f
> [   68.380234] Code: 44 00 00 66 83 3a 50 74 03 31 c0 c3 55 48 89 e5 41 55 41 54 53 48 8b 87 e8 02 00 00 48 8b 98 88 19 00 00 0f b6 42 11 4c 8d 63 04 <88> 83 d8 00 00 00 0f b6 42 13 4c 89 e7 88 83 d9 00 00 00 e8 2b
> [   68.380234] RIP  [<ffffffffa036933d>] sony_play_effect+0x2d/0x90 [hid_sony]
> [   68.380234]  RSP <ffff88003fc03da0>
> [   68.380234] CR2: 00000000000000d8
> [   68.380234] ---[ end trace 3e201de0e22c4c6e ]---
> [   68.380234] Kernel panic - not syncing: Fatal exception in interrupt
> [   68.380234] Kernel Offset: disabled
> [   68.380234] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> 
> 
> 
> 
> 
> So either the underlying bug is still there or my usage of spinlocks is totally wrong.
> 
> I would be really happy to get some feedback....
> 
> Thank you very much in advance.
> 
> Manuel

