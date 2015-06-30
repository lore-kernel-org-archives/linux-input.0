From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Tue, 30 Jun 2015 17:56:49 +0200
Message-ID: <1435679809.2612.13.camel@hadess.net>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
	 <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2015-06-29 at 19:28 +0300, Irina Tirdea wrote:
> After power on, it is recommended that the driver resets the device.
> The reset procedure timing is described in the datasheet and is used
> at device init (before writing device configuration) and
> for power management. It is a sequence of setting the interrupt
> and reset pins high/low at specific timing intervals. This procedure
> also includes setting the slave address to the one specified in the
> ACPI/device tree.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> For reset the driver needs to control the interrupt and
> reset gpio pins (configured through ACPI/device tree). For devices
> that do not have the gpio pins declared, the functionality depending
> on these pins will not be available, but the device can still be used
> with basic functionality.


I'm having a little trouble with this first patch, on a 4.2 "pre" Linus
tree and on a 4.1 kernel.

[    6.720214] ------------[ cut here ]------------
[    6.720230] WARNING: CPU: 2 PID: 475 at drivers/pinctrl/intel/pinctrl-baytrail.c:338 byt_gpio_direction_output+0x97/0xa0()
[    6.720234] Potential Error: Setting GPIO with direct_irq_en to output
[    6.720238] Modules linked in:
[    6.720241]  regmap_i2c intel_soc_dts_iosf int340x_thermal_zone soundcore industrialio battery iosf_mbi acpi_thermal_rel dell_smo8800 snd_soc_sst_acpi goodix_backport(OE+) i2c_hid acpi_pad ac rfkill_gpio i2c_designware_platform rfkill pwm_lpss_platform pwm_lpss i2c_designware_core nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 mmc_block i2c_algo_bit drm_kms_helper drm video sdhci_acpi sdhci mmc_core
[    6.720292] CPU: 2 PID: 475 Comm: systemd-udevd Tainted: G        W  OE   4.2.0-0.rc0.git2.2.fc22.i686 #1
[    6.720295] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
[    6.720299]  c0d39967 11197204 00000000 f6d37bc8 c0a9ce3c f6d37c08 f6d37bf8 c045c677
[    6.720311]  c0cb62a4 f6d37c28 000001db c0cb62e0 00000152 c073bfc7 c073bfc7 f7c580b8
[    6.720321]  f441409c f7c580b0 f6d37c14 c045c6ee 00000009 f6d37c08 c0cb62a4 f6d37c28
[    6.720331] Call Trace:
[    6.720342]  [<c0a9ce3c>] dump_stack+0x41/0x52
[    6.720349]  [<c045c677>] warn_slowpath_common+0x87/0xc0
[    6.720355]  [<c073bfc7>] ? byt_gpio_direction_output+0x97/0xa0
[    6.720360]  [<c073bfc7>] ? byt_gpio_direction_output+0x97/0xa0
[    6.720365]  [<c045c6ee>] warn_slowpath_fmt+0x3e/0x60
[    6.720370]  [<c073bfc7>] byt_gpio_direction_output+0x97/0xa0
[    6.720376]  [<c073bf30>] ? byt_gpio_irq_handler+0xc0/0xc0
[    6.720382]  [<c073e939>] _gpiod_direction_output_raw+0x59/0x1c0
[    6.720388]  [<c0aa202d>] ? _raw_spin_unlock_irqrestore+0xd/0x10
[    6.720393]  [<c073bb73>] ? byt_gpio_direction_input+0x43/0x50
[    6.720398]  [<c073bb30>] ? byt_gpio_set+0x70/0x70
[    6.720404]  [<c073eb0a>] gpiod_direction_output+0x2a/0x50
[    6.720413]  [<f7fe768b>] goodix_ts_probe+0x2fb/0x5fd [goodix_backport]
[    6.720422]  [<c0909691>] i2c_device_probe+0x101/0x1b0
[    6.720428]  [<c0612e95>] ? sysfs_create_link+0x25/0x50
[    6.720436]  [<f7fe7390>] ? goodix_ts_irq_handler+0x1f0/0x1f0 [goodix_backport]
[    6.720442]  [<c0819c52>] ? driver_sysfs_add+0x62/0x80
[    6.720448]  [<c081a56a>] driver_probe_device+0x1ca/0x460
[    6.720454]  [<c081a800>] ? driver_probe_device+0x460/0x460
[    6.720461]  [<c078d0b1>] ? acpi_driver_match_device+0x36/0x3f
[    6.720467]  [<c081a879>] __driver_attach+0x79/0x80
[    6.720473]  [<c081a800>] ? driver_probe_device+0x460/0x460
[    6.720478]  [<c0818467>] bus_for_each_dev+0x57/0xa0
[    6.720484]  [<c0819dfe>] driver_attach+0x1e/0x20
[    6.720489]  [<c081a800>] ? driver_probe_device+0x460/0x460
[    6.720494]  [<c08199bf>] bus_add_driver+0x1ef/0x290
[    6.720501]  [<f7ca7000>] ? 0xf7ca7000
[    6.720506]  [<f7ca7000>] ? 0xf7ca7000
[    6.720512]  [<c081b07d>] driver_register+0x5d/0xf0
[    6.720518]  [<c090a3ca>] i2c_register_driver+0x2a/0xa0
[    6.720524]  [<c040046f>] ? do_one_initcall+0x9f/0x200
[    6.720531]  [<f7ca7012>] goodix_ts_driver_init+0x12/0x1000 [goodix_backport]
[    6.720536]  [<c040047a>] do_one_initcall+0xaa/0x200
[    6.720541]  [<f7ca7000>] ? 0xf7ca7000
[    6.720547]  [<c05801c8>] ? free_vmap_area_noflush+0x38/0x80
[    6.720554]  [<c0594b95>] ? kmem_cache_alloc_trace+0x175/0x1f0
[    6.720560]  [<c0a9c64f>] ? do_init_module+0x21/0x1a1
[    6.720565]  [<c0a9c64f>] ? do_init_module+0x21/0x1a1
[    6.720572]  [<c0a9c67e>] do_init_module+0x50/0x1a1
[    6.720578]  [<c04d917b>] load_module+0x1ceb/0x22f0
[    6.720585]  [<c04d6159>] ? copy_module_from_fd.isra.47+0xf9/0x190
[    6.720592]  [<c04d99a5>] SyS_finit_module+0xa5/0xf0
[    6.720598]  [<c056490b>] ? vm_mmap_pgoff+0x9b/0xc0
[    6.720605]  [<c0aa26df>] sysenter_do_call+0x12/0x12
[    6.720610] ---[ end trace d5183b3e60f0f675 ]---
