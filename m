From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 5/5] input: twl6040-vibra: remove mutex
Date: Wed, 20 Apr 2016 11:22:53 +0200
Message-ID: <F2C0A9CB-843C-4A4D-92FD-CA1DBBF3EC41@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <592912a81a86fe0c9b5eaf3407cc5c4e1bfef9fe.1461009340.git.hns@goldelico.com> <20160418212048.GB1006@dtor-ws> <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com> <20160419080150.GB13933@dtor-ws> <3B181EC4-29FA-4C65-B33A-CC0D09E26E4D@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:9470 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcDTJXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 05:23:03 -0400
In-Reply-To: <3B181EC4-29FA-4C65-B33A-CC0D09E26E4D@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>


> Am 19.04.2016 um 10:08 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> 
>> Am 19.04.2016 um 10:01 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> 
>> On Tue, Apr 19, 2016 at 09:49:01AM +0200, H. Nikolaus Schaller wrote:
>>> 
>>>> Am 18.04.2016 um 23:20 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>> 
>>>> On Mon, Apr 18, 2016 at 09:55:41PM +0200, H. Nikolaus Schaller wrote:
>>>>> The mutex does not seem to be needed.
>>>> 
>>>> twl6040_vibra_suspend() and vibra_play_work() may run concurrently, no?
>>> 
>>> Hm. I don't know about the rule that would give an answer to this question...
>> 
>> Sorry, that was actually a statement, not really a question.
> 
> Indeed. In doubt about the answer we should take measures for the worst case.
> 
>> It is
>> possible (although very unlikely) that userspace posts play request and
>> workqueue will not run until after suspend callback.
>> 
>> Thinking about it some more I wonder if we better do what
>> twl6040_vibra_close() does and cancel the work before shutting off the
>> device, so that there is no chance of work executing after suspend
>> callback and reenabling the device. This way we can indeed remove the
>> mutex.
> 
> Ok, I am fine with this.
> 
> Will post an update ASAP.

While doing testing I did run again into another locking related issue which I
had not yet tried to address with my patch set. It is a:

	BUG: scheduling while atomic

report which sometimes ends in a kernel panic.

I have attached such a log. vibra.py is here:

	http://git.goldelico.com/?p=gta04-kernel.git;a=blob;f=Letux/root/vibra.py;hb=refs/heads/letux-4.6-rc4

Basically it does an ioctl(EVIOCSFF) which triggers vibra_play.

Maybe, can you decipher from the log what the reason could be?

I only conjecture that it happens when vibra_play tries to read the regmap
of the twl6040 to get twl6040_get_vibralr_status (which has no pendant
in the twl4030 driver).

Do we have to configure the twl6040 regmap differently?

BR and thanks,
Nikolaus


root@letux:~# ./vibra.py 
[  503.058501] BUG: scheduling while atomic: python/2591/0x00000002
[  503.064866] 4 locks held by python/2591:
[  503.069010]  #0:  (&evdev->mutex){+.+.+.}, at: [<c068e9b0>] evdev_write+0x38/0xc0
[  503.077000]  #1:  (&(&dev->event_lock)->rlock){......}, at: [<c0688ba4>] input_inject_event+0x40/0x1ac
[  503.086913]  #2:  (rcu_read_lock){......}, at: [<c0688b98>] input_inject_event+0x34/0x1ac
[  503.095616]  #3:  (twl6040:642:(&twl6040_regmap_config)->lock){+.+...}, at: [<c05c5500>] regmap_read+0x30/0x58
[  503.106269] Modules linked in: bluetooth autofs4 usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs ipv6 arc4 wl18xx wlcore mac80211 omapdrm cfg80211 drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect snd_soc_omap_hdmi_audio sysimgblt panel_mipi_debug fb_sys_fops dwc3 cfbcopyarea drm connector_hdmi encoder_tpd12s015 snd_soc_omap_abe_twl6040 w2cbw003_bluetooth snd_soc_twl6040 omapdss wwan_on_off leds_gpio wlcore_sdio pwm_bl pwm_omap_dmtimer ehci_omap dwc3_omap snd_soc_ts3a225e leds_is31fl319x leds_tca6507 tsc2007 bq27xxx_battery_i2c bq2429x_charger bq27xxx_battery gpio_twl6040 twl6040_vibra ina2xx palmas_gpadc tca8418_keypad bmp085_i2c palmas_pwrbutton as5013 bmg160_i2c usb3503 bmp280 bmp085 bma150 bmg160_core input_polldev snd_soc_omap_mcbsp snd_soc_omap_mcpdm snd_soc
 _omap snd_pcm_dmaengine
[  503.182770] irq event stamp: 29172
[  503.186366] hardirqs last  enabled at (29171): [<c0809f94>] _raw_spin_unlock_irq+0x24/0x60
[  503.195114] hardirqs last disabled at (29172): [<c08097e8>] _raw_spin_lock_irqsave+0x18/0x54
[  503.204028] softirqs last  enabled at (29154): [<c024ff80>] __do_softirq+0x5bc/0x66c
[  503.212216] softirqs last disabled at (29041): [<c0250328>] irq_exit+0x98/0x118
[  503.219954] Preemption disabled at:[<  (null)>]   (null)
[  503.225571] 
[  503.227162] CPU: 1 PID: 2591 Comm: python Tainted: G        W       4.6.0-rc4-letux+ #69
[  503.235693] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  503.242062] [<c022789c>] (unwind_backtrace) from [<c022403c>] (show_stack+0x10/0x14)
[  503.250259] [<c022403c>] (show_stack) from [<c0517e44>] (dump_stack+0x88/0xc0)
[  503.257897] [<c0517e44>] (dump_stack) from [<c0318e38>] (__schedule_bug+0xa8/0xcc)
[  503.265900] [<c0318e38>] (__schedule_bug) from [<c08042e4>] (__schedule+0x70/0x7fc)
[  503.273993] [<c08042e4>] (__schedule) from [<c0804ca8>] (schedule+0x9c/0xc0)
[  503.281451] [<c0804ca8>] (schedule) from [<c0804ed4>] (schedule_preempt_disabled+0x14/0x20)
[  503.290278] [<c0804ed4>] (schedule_preempt_disabled) from [<c0806ab4>] (mutex_lock_nested+0x258/0x43c)
[  503.300115] [<c0806ab4>] (mutex_lock_nested) from [<c05c5500>] (regmap_read+0x30/0x58)
[  503.308488] [<c05c5500>] (regmap_read) from [<c05d5208>] (twl6040_get_vibralr_status+0x18/0x48)
[  503.317680] [<c05d5208>] (twl6040_get_vibralr_status) from [<bf080674>] (vibra_play+0x18/0x7c [twl6040_vibra])
[  503.328333] [<bf080674>] (vibra_play [twl6040_vibra]) from [<c068a94c>] (ml_play_effects+0x34/0x5c)
[  503.337897] [<c068a94c>] (ml_play_effects) from [<c068aa2c>] (ml_ff_playback+0x88/0x94)
[  503.346359] [<c068aa2c>] (ml_ff_playback) from [<c0689bf4>] (input_ff_event+0x9c/0xa4)
[  503.354722] [<c0689bf4>] (input_ff_event) from [<c0688a7c>] (input_handle_event+0x4c/0x134)
[  503.363543] [<c0688a7c>] (input_handle_event) from [<c0688c7c>] (input_inject_event+0x118/0x1ac)
[  503.372824] [<c0688c7c>] (input_inject_event) from [<c068ea00>] (evdev_write+0x88/0xc0)
[  503.381281] [<c068ea00>] (evdev_write) from [<c036eff8>] (__vfs_write+0x18/0x38)
[  503.389092] [<c036eff8>] (__vfs_write) from [<c036fdc8>] (vfs_write+0xac/0x130)
[  503.396819] [<c036fdc8>] (vfs_write) from [<c036ffec>] (SyS_write+0x40/0x78)
[  503.404275] [<c036ffec>] (SyS_write) from [<c0220740>] (ret_fast_syscall+0x0/0x1c)
[  503.414230] 
[  503.415818] =========================================================
[  503.422608] [ INFO: possible irq lock inversion dependency detected ]
[  503.429403] 4.6.0-rc4-letux+ #69 Tainted: G        W      
[  503.435207] ---------------------------------------------------------
[  503.441998] swapper/1/0 just changed the state of lock:
[  503.447510]  (&(&dev->event_lock)->rlock){..-...}, at: [<c068aa50>] ml_effect_timer+0x18/0x34
[  503.456578] but this lock took another, SOFTIRQ-unsafe lock in the past:
[  503.463646]  (twl6040:642:(&twl6040_regmap_config)->lock){+.+...}

and interrupts could create inverse lock ordering between them.

[  503.476449] 
[  503.476449] other info that might help us debug this:
[  503.483339]  Possible interrupt unsafe locking scenario:
[  503.483339] 
[  503.490516]        CPU0                    CPU1
[  503.495307]        ----                    ----
[  503.500094]   lock(twl6040:642:(&twl6040_regmap_config)->lock);
[  503.506370]                                local_irq_disable();
[  503.512627]                                lock(&(&dev->event_lock)->rlock);
[  503.520092]                                lock(twl6040:642:(&twl6040_regmap_config)->lock);
[  503.529020]   <Interrupt>
[  503.531793]     lock(&(&dev->event_lock)->rlock);
[  503.536781] 
[  503.536781]  *** DEADLOCK ***
[  503.536781] 
[  503.543033] 1 lock held by swapper/1/0:
[  503.547090]  #0:  (((&ml->timer))){+.-...}, at: [<c02b75b8>] call_timer_fn+0x0/0x47c
[  503.555344] 
[  503.555344] the shortest dependencies between 2nd lock and 1st lock:
[  503.563643]  -> (twl6040:642:(&twl6040_regmap_config)->lock){+.+...} ops: 93 {
[  503.571339]     HARDIRQ-ON-W at:
[  503.574757]                       [<c0299fc8>] lock_acquire+0x25c/0x290
[  503.581785]                       [<c08068a8>] mutex_lock_nested+0x4c/0x43c
[  503.589162]                       [<c05c78f8>] regmap_register_patch+0xa0/0xfc
[  503.596819]                       [<c05d53a4>] twl6040_probe+0x150/0x414
[  503.603917]                       [<c0698dc8>] i2c_device_probe+0x198/0x1ec
[  503.611304]                       [<c05aa3ac>] really_probe+0xfc/0x258
[  503.618227]                       [<c05aa6ac>] driver_probe_device+0x44/0x70
[  503.625706]                       [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  503.632916]                       [<c05aa5d4>] __device_attach+0x84/0xf8
[  503.640025]                       [<c05a99e8>] bus_probe_device+0x28/0x84
[  503.647218]                       [<c05a8068>] device_add+0x204/0x34c
[  503.654050]                       [<c0699e7c>] i2c_new_device+0x10c/0x18c
[  503.661253]                       [<c069a1d8>] of_i2c_register_device+0x15c/0x180
[  503.669187]                       [<c069a49c>] i2c_register_adapter+0x1e0/0x30c
[  503.676947]                       [<c069e8e4>] omap_i2c_probe+0x330/0x42c
[  503.684148]                       [<c05ac2d8>] platform_drv_probe+0x50/0x98
[  503.691531]                       [<c05aa3ac>] really_probe+0xfc/0x258
[  503.698455]                       [<c05aa6ac>] driver_probe_device+0x44/0x70
[  503.705926]                       [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  503.713119]                       [<c05aa5d4>] __device_attach+0x84/0xf8
[  503.720221]                       [<c05a99e8>] bus_probe_device+0x28/0x84
[  503.727418]                       [<c05a9e50>] deferred_probe_work_func+0x5c/0x8c
[  503.735351]                       [<c02653c8>] process_one_work+0x3fc/0x770
[  503.742738]                       [<c0265964>] worker_thread+0x1f8/0x2fc
[  503.749840]                       [<c026ad08>] kthread+0xdc/0xf0
[  503.756210]                       [<c02207c8>] ret_from_fork+0x14/0x2c
[  503.763126]     SOFTIRQ-ON-W at:
[  503.766544]                       [<c0299fc8>] lock_acquire+0x25c/0x290
[  503.773562]                       [<c08068a8>] mutex_lock_nested+0x4c/0x43c
[  503.780953]                       [<c05c78f8>] regmap_register_patch+0xa0/0xfc
[  503.788594]                       [<c05d53a4>] twl6040_probe+0x150/0x414
[  503.795698]                       [<c0698dc8>] i2c_device_probe+0x198/0x1ec
[  503.803069]                       [<c05aa3ac>] really_probe+0xfc/0x258
[  503.809972]                       [<c05aa6ac>] driver_probe_device+0x44/0x70
[  503.817440]                       [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  503.824627]                       [<c05aa5d4>] __device_attach+0x84/0xf8
[  503.831726]                       [<c05a99e8>] bus_probe_device+0x28/0x84
[  503.838929]                       [<c05a8068>] device_add+0x204/0x34c
[  503.845762]                       [<c0699e7c>] i2c_new_device+0x10c/0x18c
[  503.852949]                       [<c069a1d8>] of_i2c_register_device+0x15c/0x180
[  503.860874]                       [<c069a49c>] i2c_register_adapter+0x1e0/0x30c
[  503.868634]                       [<c069e8e4>] omap_i2c_probe+0x330/0x42c
[  503.875836]                       [<c05ac2d8>] platform_drv_probe+0x50/0x98
[  503.883211]                       [<c05aa3ac>] really_probe+0xfc/0x258
[  503.890130]                       [<c05aa6ac>] driver_probe_device+0x44/0x70
[  503.897602]                       [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  503.904794]                       [<c05aa5d4>] __device_attach+0x84/0xf8
[  503.911903]                       [<c05a99e8>] bus_probe_device+0x28/0x84
[  503.919104]                       [<c05a9e50>] deferred_probe_work_func+0x5c/0x8c
[  503.927034]                       [<c02653c8>] process_one_work+0x3fc/0x770
[  503.934418]                       [<c0265964>] worker_thread+0x1f8/0x2fc
[  503.941537]                       [<c026ad08>] kthread+0xdc/0xf0
[  503.947902]                       [<c02207c8>] ret_from_fork+0x14/0x2c
[  503.954815]     INITIAL USE at:
[  503.958145]                      [<c08068a8>] mutex_lock_nested+0x4c/0x43c
[  503.965433]                      [<c05c78f8>] regmap_register_patch+0xa0/0xfc
[  503.973003]                      [<c05d53a4>] twl6040_probe+0x150/0x414
[  503.980022]                      [<c0698dc8>] i2c_device_probe+0x198/0x1ec
[  503.987314]                      [<c05aa3ac>] really_probe+0xfc/0x258
[  503.994145]                      [<c05aa6ac>] driver_probe_device+0x44/0x70
[  504.001518]                      [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  504.008629]                      [<c05aa5d4>] __device_attach+0x84/0xf8
[  504.015643]                      [<c05a99e8>] bus_probe_device+0x28/0x84
[  504.022734]                      [<c05a8068>] device_add+0x204/0x34c
[  504.029475]                      [<c0699e7c>] i2c_new_device+0x10c/0x18c
[  504.036577]                      [<c069a1d8>] of_i2c_register_device+0x15c/0x180
[  504.044421]                      [<c069a49c>] i2c_register_adapter+0x1e0/0x30c
[  504.052072]                      [<c069e8e4>] omap_i2c_probe+0x330/0x42c
[  504.059173]                      [<c05ac2d8>] platform_drv_probe+0x50/0x98
[  504.066472]                      [<c05aa3ac>] really_probe+0xfc/0x258
[  504.073285]                      [<c05aa6ac>] driver_probe_device+0x44/0x70
[  504.080657]                      [<c05a8e2c>] bus_for_each_drv+0x4c/0x84
[  504.087760]                      [<c05aa5d4>] __device_attach+0x84/0xf8
[  504.094773]                      [<c05a99e8>] bus_probe_device+0x28/0x84
[  504.101880]                      [<c05a9e50>] deferred_probe_work_func+0x5c/0x8c
[  504.109712]                      [<c02653c8>] process_one_work+0x3fc/0x770
[  504.117007]                      [<c0265964>] worker_thread+0x1f8/0x2fc
[  504.124021]                      [<c026ad08>] kthread+0xdc/0xf0
[  504.130299]                      [<c02207c8>] ret_from_fork+0x14/0x2c
[  504.137126]   }
[  504.138974]   ... key      at: [<c186b9e0>] _key.26438+0x0/0x8
[  504.145144]   ... acquired at:
[  504.148371]    [<c0299748>] __lock_acquire+0x7d0/0x8d0
[  504.153806]    [<c0299fc8>] lock_acquire+0x25c/0x290
[  504.159060]    [<c08068a8>] mutex_lock_nested+0x4c/0x43c
[  504.164674]    [<c05c5500>] regmap_read+0x30/0x58
[  504.169655]    [<c05d5208>] twl6040_get_vibralr_status+0x18/0x48
[  504.176007]    [<bf080674>] vibra_play+0x18/0x7c [twl6040_vibra]
[  504.182368]    [<c068a94c>] ml_play_effects+0x34/0x5c
[  504.187726]    [<c068aa2c>] ml_ff_playback+0x88/0x94
[  504.192985]    [<c0689bf4>] input_ff_event+0x9c/0xa4
[  504.198246]    [<c0688a7c>] input_handle_event+0x4c/0x134
[  504.203968]    [<c0688c7c>] input_inject_event+0x118/0x1ac
[  504.209777]    [<c068ea00>] evdev_write+0x88/0xc0
[  504.214755]    [<c036eff8>] __vfs_write+0x18/0x38
[  504.219735]    [<c036fdc8>] vfs_write+0xac/0x130
[  504.224623]    [<c036ffec>] SyS_write+0x40/0x78
[  504.229417]    [<c0220740>] ret_fast_syscall+0x0/0x1c
[  504.234763] 
[  504.236341] -> (&(&dev->event_lock)->rlock){..-...} ops: 95 {
[  504.242479]    IN-SOFTIRQ-W at:
[  504.245808]                     [<c0299fc8>] lock_acquire+0x25c/0x290
[  504.252636]                     [<c0809810>] _raw_spin_lock_irqsave+0x40/0x54
[  504.260195]                     [<c068aa50>] ml_effect_timer+0x18/0x34
[  504.267124]                     [<c02b77dc>] call_timer_fn+0x224/0x47c
[  504.274044]                     [<c02b7dc4>] run_timer_softirq+0x390/0x3f8
[  504.281320]                     [<c024fca8>] __do_softirq+0x2e4/0x66c
[  504.288147]                     [<c0250328>] irq_exit+0x98/0x118
[  504.294521]                     [<c02a5a78>] __handle_domain_irq+0xa0/0xdc
[  504.301801]                     [<c0201578>] gic_handle_irq+0x50/0x8c
[  504.308629]                     [<c080af04>] __irq_svc+0x44/0x7c
[  504.314996]                     [<c0809f98>] _raw_spin_unlock_irq+0x28/0x60
[  504.322364]                     [<c0809f98>] _raw_spin_unlock_irq+0x28/0x60
[  504.329749]                     [<c0271eb8>] finish_task_switch+0x188/0x2c0
[  504.337136]                     [<c08049a8>] __schedule+0x734/0x7fc
[  504.343790]                     [<c0804ca8>] schedule+0x9c/0xc0
[  504.350073]                     [<c0804ed4>] schedule_preempt_disabled+0x14/0x20
[  504.357911]                     [<c028f4d4>] cpu_idle_loop+0x37c/0x3ac
[  504.364840]                     [<c028f51c>] cpupri_find+0x0/0xe4
[  504.371296]    INITIAL USE at:
[  504.374529]                    [<c0809810>] _raw_spin_lock_irqsave+0x40/0x54
[  504.382004]                    [<c0688d48>] input_event+0x38/0x60
[  504.388460]                    [<c0691a60>] gpio_keys_gpio_report_event+0x88/0xa4
[  504.396390]                    [<c0691ab8>] gpio_keys_report_state+0x3c/0x68
[  504.403879]                    [<c0691b14>] gpio_keys_open+0x30/0x38
[  504.410621]                    [<c0686a88>] input_open_device+0x68/0xa4
[  504.417634]                    [<c0589d58>] kbd_connect+0x50/0x7c
[  504.424098]                    [<c0686e80>] input_attach_handler+0x34/0x64
[  504.431397]                    [<c0687428>] input_register_device+0x18c/0x248
[  504.438974]                    [<c0692674>] gpio_keys_probe+0x198/0x208
[  504.445981]                    [<c05ac2d8>] platform_drv_probe+0x50/0x98
[  504.453090]                    [<c05aa3ac>] really_probe+0xfc/0x258
[  504.459728]                    [<c05aa6ac>] driver_probe_device+0x44/0x70
[  504.466921]                    [<c05aa760>] __driver_attach+0x88/0xac
[  504.473738]                    [<c05a8eb4>] bus_for_each_dev+0x50/0x84
[  504.480659]                    [<c05a9bfc>] bus_add_driver+0xcc/0x1e4
[  504.487485]                    [<c05ab6d0>] driver_register+0xac/0xf4
[  504.494321]                    [<c02018c0>] do_one_initcall+0x100/0x1b8
[  504.501331]                    [<c0e00d28>] do_basic_setup+0x98/0xd4
[  504.508077]                    [<c0e00de8>] kernel_init_freeable+0x84/0x124
[  504.515458]                    [<c080381c>] kernel_init+0x8/0x110
[  504.521923]                    [<c02207c8>] ret_from_fork+0x14/0x2c
[  504.528570]  }
[  504.530327]  ... key      at: [<c186df3c>] __key.23309+0x0/0x8
[  504.536498]  ... acquired at:
[  504.539636]    [<c031a9f8>] mark_lock_irq+0xec/0x28c
[  504.544897]    [<c0298c8c>] mark_lock+0x2e8/0x448
[  504.549875]    [<c0298e8c>] mark_irqflags+0xa0/0x18c
[  504.555126]    [<c02995b8>] __lock_acquire+0x640/0x8d0
[  504.560559]    [<c0299fc8>] lock_acquire+0x25c/0x290
[  504.565809]    [<c0809810>] _raw_spin_lock_irqsave+0x40/0x54
[  504.571798]    [<c068aa50>] ml_effect_timer+0x18/0x34
[  504.577147]    [<c02b77dc>] call_timer_fn+0x224/0x47c
[  504.582495]    [<c02b7dc4>] run_timer_softirq+0x390/0x3f8
[  504.588209]    [<c024fca8>] __do_softirq+0x2e4/0x66c
[  504.593465]    [<c0250328>] irq_exit+0x98/0x118
[  504.598264]    [<c02a5a78>] __handle_domain_irq+0xa0/0xdc
[  504.603984]    [<c0201578>] gic_handle_irq+0x50/0x8c
[  504.609241]    [<c080af04>] __irq_svc+0x44/0x7c
[  504.614037]    [<c0809f98>] _raw_spin_unlock_irq+0x28/0x60
[  504.619845]    [<c0809f98>] _raw_spin_unlock_irq+0x28/0x60
[  504.625649]    [<c0271eb8>] finish_task_switch+0x188/0x2c0
[  504.631465]    [<c08049a8>] __schedule+0x734/0x7fc
[  504.636533]    [<c0804ca8>] schedule+0x9c/0xc0
[  504.641238]    [<c0804ed4>] schedule_preempt_disabled+0x14/0x20
[  504.647503]    [<c028f4d4>] cpu_idle_loop+0x37c/0x3ac
[  504.652856]    [<c028f51c>] cpupri_find+0x0/0xe4
[  504.657756] 
[  504.659341] 
[  504.659341] stack backtrace:
[  504.663948] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.6.0-rc4-letux+ #69
[  504.672497] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  504.678871] [<c022789c>] (unwind_backtrace) from [<c022403c>] (show_stack+0x10/0x14)
[  504.687083] [<c022403c>] (show_stack) from [<c0517e44>] (dump_stack+0x88/0xc0)
[  504.694743] [<c0517e44>] (dump_stack) from [<c031a6b8>] (print_irq_inversion_bug.part.12+0x16c/0x1a4)
[  504.704509] [<c031a6b8>] (print_irq_inversion_bug.part.12) from [<c029726c>] (print_irq_inversion_bug+0x74/0x84)
[  504.715299] [<c029726c>] (print_irq_inversion_bug) from [<c029735c>] (check_usage_forwards+0xe0/0x10c)
[  504.725152] [<c029735c>] (check_usage_forwards) from [<c031a9f8>] (mark_lock_irq+0xec/0x28c)
[  504.734094] [<c031a9f8>] (mark_lock_irq) from [<c0298c8c>] (mark_lock+0x2e8/0x448)
[  504.742114] [<c0298c8c>] (mark_lock) from [<c0298e8c>] (mark_irqflags+0xa0/0x18c)
[  504.750026] [<c0298e8c>] (mark_irqflags) from [<c02995b8>] (__lock_acquire+0x640/0x8d0)
[  504.758491] [<c02995b8>] (__lock_acquire) from [<c0299fc8>] (lock_acquire+0x25c/0x290)
[  504.766878] [<c0299fc8>] (lock_acquire) from [<c0809810>] (_raw_spin_lock_irqsave+0x40/0x54)
[  504.775823] [<c0809810>] (_raw_spin_lock_irqsave) from [<c068aa50>] (ml_effect_timer+0x18/0x34)
[  504.785043] [<c068aa50>] (ml_effect_timer) from [<c02b77dc>] (call_timer_fn+0x224/0x47c)
[  504.793613] [<c02b77dc>] (call_timer_fn) from [<c02b7dc4>] (run_timer_softirq+0x390/0x3f8)
[  504.802367] [<c02b7dc4>] (run_timer_softirq) from [<c024fca8>] (__do_softirq+0x2e4/0x66c)
[  504.811025] [<c024fca8>] (__do_softirq) from [<c0250328>] (irq_exit+0x98/0x118)
[  504.818768] [<c0250328>] (irq_exit) from [<c02a5a78>] (__handle_domain_irq+0xa0/0xdc)
[  504.827062] [<c02a5a78>] (__handle_domain_irq) from [<c0201578>] (gic_handle_irq+0x50/0x8c)
[  504.835910] [<c0201578>] (gic_handle_irq) from [<c080af04>] (__irq_svc+0x44/0x7c)
[  504.843825] Exception stack(0xee0dbee8 to 0xee0dbf30)
[  504.849178] bee0:                   00000001 00000004 00000000 ee0d8e80 eefab600 eefab600
[  504.857845] bf00: 00000000 ee0d8e80 c08049a8 00000000 00000002 ee0dbf74 00000000 ee0dbf38
[  504.866504] bf20: c029aa18 c0809f98 200f0013 ffffffff
[  504.871860] [<c080af04>] (__irq_svc) from [<c0809f98>] (_raw_spin_unlock_irq+0x28/0x60)
[  504.880338] [<c0809f98>] (_raw_spin_unlock_irq) from [<c0271eb8>] (finish_task_switch+0x188/0x2c0)
[  504.889829] [<c0271eb8>] (finish_task_switch) from [<c08049a8>] (__schedule+0x734/0x7fc)
[  504.898398] [<c08049a8>] (__schedule) from [<c0804ca8>] (schedule+0x9c/0xc0)
[  504.905871] [<c0804ca8>] (schedule) from [<c0804ed4>] (schedule_preempt_disabled+0x14/0x20)
[  504.914720] [<c0804ed4>] (schedule_preempt_disabled) from [<c028f4d4>] (cpu_idle_loop+0x37c/0x3ac)
[  504.924210] [<c028f4d4>] (cpu_idle_loop) from [<c028f51c>] (cpupri_find+0x0/0xe4)
[  506.142849] BUG: spinlock lockup suspected on CPU#1, swapper/1/0
[  506.149219]  lock: 0xed1a019c, .magic: dead4ead, .owner: python/2591, .owner_cpu: 1
[  506.157338] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.6.0-rc4-letux+ #69
[  506.165873] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  506.172231] [<c022789c>] (unwind_backtrace) from [<c022403c>] (show_stack+0x10/0x14)
[  506.180427] [<c022403c>] (show_stack) from [<c0517e44>] (dump_stack+0x88/0xc0)
[  506.188081] [<c0517e44>] (dump_stack) from [<c031ae24>] (__spin_lock_debug+0x8c/0xdc)
[  506.196384] [<c031ae24>] (__spin_lock_debug) from [<c029d15c>] (do_raw_spin_lock+0xa8/0xd8)
[  506.205230] [<c029d15c>] (do_raw_spin_lock) from [<c0809818>] (_raw_spin_lock_irqsave+0x48/0x54)
[  506.214539] [<c0809818>] (_raw_spin_lock_irqsave) from [<c068aa50>] (ml_effect_timer+0x18/0x34)
[  506.223742] [<c068aa50>] (ml_effect_timer) from [<c02b77dc>] (call_timer_fn+0x224/0x47c)
[  506.232311] [<c02b77dc>] (call_timer_fn) from [<c02b7dc4>] (run_timer_softirq+0x390/0x3f8)
[  506.241070] [<c02b7dc4>] (run_timer_softirq) from [<c024fca8>] (__do_softirq+0x2e4/0x66c)
[  506.249730] [<c024fca8>] (__do_softirq) from [<c0250328>] (irq_exit+0x98/0x118)
[  506.257483] [<c0250328>] (irq_exit) from [<c02a5a78>] (__handle_domain_irq+0xa0/0xdc)
[  506.265788] [<c02a5a78>] (__handle_domain_irq) from [<c0201578>] (gic_handle_irq+0x50/0x8c)
[  506.274637] [<c0201578>] (gic_handle_irq) from [<c080af04>] (__irq_svc+0x44/0x7c)
[  506.282558] Exception stack(0xee0dbee8 to 0xee0dbf30)
[  506.287891] bee0:                   00000001 00000004 00000000 ee0d8e80 eefab600 eefab600
[  506.296529] bf00: 00000000 ee0d8e80 c08049a8 00000000 00000002 ee0dbf74 00000000 ee0dbf38
[  506.305162] bf20: c029aa18 c0809f98 200f0013 ffffffff
[  506.310501] [<c080af04>] (__irq_svc) from [<c0809f98>] (_raw_spin_unlock_irq+0x28/0x60)
[  506.318972] [<c0809f98>] (_raw_spin_unlock_irq) from [<c0271eb8>] (finish_task_switch+0x188/0x2c0)
[  506.328460] [<c0271eb8>] (finish_task_switch) from [<c08049a8>] (__schedule+0x734/0x7fc)
[  506.337041] [<c08049a8>] (__schedule) from [<c0804ca8>] (schedule+0x9c/0xc0)
[  506.344512] [<c0804ca8>] (schedule) from [<c0804ed4>] (schedule_preempt_disabled+0x14/0x20)
[  506.353359] [<c0804ed4>] (schedule_preempt_disabled) from [<c028f4d4>] (cpu_idle_loop+0x37c/0x3ac)
[  506.362845] [<c028f4d4>] (cpu_idle_loop) from [<c028f51c>] (cpupri_find+0x0/0xe4)
[  506.370766] Sending NMI to all CPUs:
[  506.375928] NMI backtrace for cpu 0
[  506.379616] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.6.0-rc4-letux+ #69
[  506.388171] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  506.394529] task: c1005e80 ti: c1000000 task.ti: c1000000
[  506.400238] PC is at arch_cpu_idle+0x30/0x3c
[  506.404752] LR is at arch_cpu_idle+0x2c/0x3c
[  506.409277] pc : [<c02211e0>]    lr : [<c02211dc>]    psr: 60000013
[  506.415916] sp : c1001fa8  ip : c1001f88  fp : 00000000
[  506.421453] r10: 00000000  r9 : 412fc0f2  r8 : 80007000
[  506.426981] r7 : c1009a00  r6 : c10025d4  r5 : c100256c  r4 : 0000002b
[  506.433886] r3 : 00000000  r2 : fe600000  r1 : c1001fa8  r0 : c02211dc
[  506.440799] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[  506.448528] Control: 30c5387d  Table: a8b8ff00  DAC: fffffffd
[  506.454608] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.6.0-rc4-letux+ #69
[  506.463165] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  506.469520] [<c022789c>] (unwind_backtrace) from [<c022403c>] (show_stack+0x10/0x14)
[  506.477714] [<c022403c>] (show_stack) from [<c0517e44>] (dump_stack+0x88/0xc0)
[  506.485354] [<c0517e44>] (dump_stack) from [<c051c0ec>] (nmi_cpu_backtrace+0xc4/0x108)
[  506.493715] [<c051c0ec>] (nmi_cpu_backtrace) from [<c0225f50>] (handle_IPI+0x240/0x3dc)
[  506.502180] [<c0225f50>] (handle_IPI) from [<c02015a8>] (gic_handle_irq+0x80/0x8c)
[  506.510189] [<c02015a8>] (gic_handle_irq) from [<c080af04>] (__irq_svc+0x44/0x7c)
[  506.518102] Exception stack(0xc1001f58 to 0xc1001fa0)
[  506.523444] 1f40:                                                       c02211dc c1001fa8
[  506.532097] 1f60: fe600000 00000000 0000002b c100256c c10025d4 c1009a00 80007000 412fc0f2
[  506.540754] 1f80: 00000000 00000000 c1001f88 c1001fa8 c02211dc c02211e0 60000013 ffffffff
[  506.549403] [<c080af04>] (__irq_svc) from [<c02211e0>] (arch_cpu_idle+0x30/0x3c)
[  506.557234] [<c02211e0>] (arch_cpu_idle) from [<c028f470>] (cpu_idle_loop+0x318/0x3ac)
[  506.565615] [<c028f470>] (cpu_idle_loop) from [<c028f51c>] (cpupri_find+0x0/0xe4)
[  506.573528] [<c028f51c>] (cpupri_find) from [<c10a54c0>] (processor_id+0x0/0x40)
[  506.581346] NMI backtrace for cpu 1
[  506.585033] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.6.0-rc4-letux+ #69
[  506.593591] Hardware name: Generic OMAP5 (Flattened Device Tree)
[  506.599949] [<c022789c>] (unwind_backtrace) from [<c022403c>] (show_stack+0x10/0x14)
[  506.608147] [<c022403c>] (show_stack) from [<c0517e44>] (dump_stack+0x88/0xc0)
[  506.615784] [<c0517e44>] (dump_stack) from [<c051c0f4>] (nmi_cpu_backtrace+0xcc/0x108)
[  506.624155] [<c051c0f4>] (nmi_cpu_backtrace) from [<c0225598>] (raise_nmi+0x44/0x54)
[  506.632343] [<c0225598>] (raise_nmi) from [<c051c280>] (nmi_trigger_all_cpu_backtrace+0xf0/0x254)
[  506.641732] [<c051c280>] (nmi_trigger_all_cpu_backtrace) from [<c031ae2c>] (__spin_lock_debug+0x94/0xdc)
[  506.651766] [<c031ae2c>] (__spin_lock_debug) from [<c029d15c>] (do_raw_spin_lock+0xa8/0xd8)
[  506.660607] [<c029d15c>] (do_raw_spin_lock) from [<c0809818>] (_raw_spin_lock_irqsave+0x48/0x54)
[  506.669901] [<c0809818>] (_raw_spin_lock_irqsave) from [<c068aa50>] (ml_effect_timer+0x18/0x34)
[  506.679103] [<c068aa50>] (ml_effect_timer) from [<c02b77dc>] (call_timer_fn+0x224/0x47c)
[  506.687655] [<c02b77dc>] (call_timer_fn) from [<c02b7dc4>] (run_timer_softirq+0x390/0x3f8)
[  506.696407] [<c02b7dc4>] (run_timer_softirq) from [<c024fca8>] (__do_softirq+0x2e4/0x66c)
[  506.705067] [<c024fca8>] (__do_softirq) from [<c0250328>] (irq_exit+0x98/0x118)
[  506.712807] [<c0250328>] (irq_exit) from [<c02a5a78>] (__handle_domain_irq+0xa0/0xdc)
[  506.721086] [<c02a5a78>] (__handle_domain_irq) from [<c0201578>] (gic_handle_irq+0x50/0x8c)
[  506.729911] [<c0201578>] (gic_handle_irq) from [<c080af04>] (__irq_svc+0x44/0x7c)
[  506.737818] Exception stack(0xee0dbee8 to 0xee0dbf30)
[  506.743169] bee0:                   00000001 00000004 00000000 ee0d8e80 eefab600 eefab600
[  506.751820] bf00: 00000000 ee0d8e80 c08049a8 00000000 00000002 ee0dbf74 00000000 ee0dbf38
[  506.760464] bf20: c029aa18 c0809f98 200f0013 ffffffff
[  506.765800] [<c080af04>] (__irq_svc) from [<c0809f98>] (_raw_spin_unlock_irq+0x28/0x60)
[  506.774273] [<c0809f98>] (_raw_spin_unlock_irq) from [<c0271eb8>] (finish_task_switch+0x188/0x2c0)
[  506.783731] [<c0271eb8>] (finish_task_switch) from [<c08049a8>] (__schedule+0x734/0x7fc)
[  506.792279] [<c08049a8>] (__schedule) from [<c0804ca8>] (schedule+0x9c/0xc0)
[  506.799745] [<c0804ca8>] (schedule) from [<c0804ed4>] (schedule_preempt_disabled+0x14/0x20)
[  506.808577] [<c0804ed4>] (schedule_preempt_disabled) from [<c028f4d4>] (cpu_idle_loop+0x37c/0x3ac)
[  506.818058] [<c028f4d4>] (cpu_idle_loop) from [<c028f51c>] (cpupri_find+0x0/0xe4)



