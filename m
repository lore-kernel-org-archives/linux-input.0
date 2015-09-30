From: Carlos Garnacho <carlosg-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Wed, 30 Sep 2015 16:01:47 +0200
Message-ID: <CAEiaqW1vOaHjXrd1-sK-W_hJ9jxuFOx7N3x+DGp3hqavD9bEGQ@mail.gmail.com>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
	<1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
	<1435679809.2612.13.camel@hadess.net>
	<1F3AC3675D538145B1661F571FE1805F2F0AC0D3@irsmsx105.ger.corp.intel.com>
	<1441818159.27328.30.camel@hadess.net>
	<1F3AC3675D538145B1661F571FE1805F2F0C9F85@irsmsx105.ger.corp.intel.com>
	<1443192251.17020.29.camel@hadess.net>
	<1F3AC3675D538145B1661F571FE1805F2F0E98FC@irsmsx105.ger.corp.intel.com>
	<1443492265.17930.9.camel@hadess.net>
	<1F3AC3675D538145B1661F571FE1805F2F0EBB24@irsmsx105.ger.corp.intel.com>
	<1443611739.5056.8.camel@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b33956d1749520520f75fb0
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443611739.5056.8.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cosimo Cecchi <cosimoc-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>, Christian Hergert <christian-7XSPgEYZchhBDLzU/O5InQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--047d7b33956d1749520520f75fb0
Content-Type: text/plain; charset=UTF-8

Hey,

On Wed, Sep 30, 2015 at 1:15 PM, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
> On Tue, 2015-09-29 at 17:47 +0000, Tirdea, Irina wrote:
>>
>> > -----Original Message-----
>> > From: Bastien Nocera [mailto:hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org]
>> > Sent: 29 September, 2015 5:04
>> > To: Tirdea, Irina; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob Herring; Pawel Moll; Ian
>> > Campbell; Kumar Gala; Purdila, Octavian; Dmitry Torokhov; Mark
>> > Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
>> >
>> > On Fri, 2015-09-25 at 21:04 +0000, Tirdea, Irina wrote:
>> > >
>> <snip>
>> > >
>> > > The warning from your dmesg output will not cause probe to fail.
>> > > If you look at the code for byt_gpio_direction_output, it will
>> > > just
>> > > print
>> > > a warning and continue [1]:
>> > >   WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
>> > >           "Potential Error: Setting GPIO with direct_irq_en to
>> > > output");
>> > > I thought probe finishes successfully, but due to the warning in
>> > > dmesg you
>> > > are not sure whether the IRQ GPIO pin can be used as output.
>> > > If probe fails, it must be for another reason than the
>> > > direct_irq_en
>> > > warning.
>> > >
>> > > > Would you have a patch for me to test that would bypass this
>> > > > error,
>> > > > or
>> > > > at least fallback gracefully to not resetting, not probing
>> > > > GPIOs if
>> > > > they're badly setup?
>> > >
>> > > If the driver fails to initialize the GPIOs, it will at least
>> > > print
>> > > some
>> > > "Failed to get GPIO" warnings in dmesg. Do you have such messages
>> > > in
>> > > dmesg or any additional information on why probe fails?
>> > >
>> > > The current code will ignore GPIOs if they are not defined in
>> > > ACPI
>> > > (see the check for -ENOENT), but does not ignore other error
>> > > codes.
>> > > If you want to bypass all GPIO errors, you can use the code
>> > > below.
>> >
>> > The failure isn't there, it's when running goodix_i2c_test():
>> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test
>> > failed attempt 1: -121
>> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test
>> > failed attempt 2: -121
>> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: I2C
>> > communication failure: -121
>> > Sep 25 16:39:20 winbook kernel: Goodix-TS: probe of i2c-GDIX1001:00
>> > failed with error -121
>> >
>>
>> Are you using v6 of the patches? There was an issue with reset that
>> Aleksei reported
>> and was fixed in v6 (although he had a different i2c error and a
>> different scenario).
>
> Pretty certain. Your current patchset is at:
> https://github.com/hadess/gt9xx/tree/irina-tirdea
>
> And the patches are yours, with the prefix and Documentation removed.
>
>> > The GPIO setup seems to work (bar the warnings), and the reset as
>> > well,
>> > but then the device fails to communicate. Likely a fallout from the
>> > reset actually failing.
>> >
>> > Swapping around the RST and INT pins leads to the same problem.
>> > Either
>> > this device's GPIO PINs aren't actually functional, and the
>> > firmware
>> > contains garbage, or something else is wrong.
>> >
>>
>> I agree. Either the interrupt pin cannot be used as output in your
>> configuration
>> or there are some specifics in the ACPI tables that prevent using
>> these pins.
>>
>> > I'm not sure how we can detect, and blacklist, those devices. At
>> > least
>> > my original device, the Onda v975w, and the WinBook TW100 would
>> > have
>> > those problems.
>> >
>>
>> I can use DMI quirks to exclude these devices from using the features
>> that
>> depend on the gpio pins. I already have the DMI information for
>> WinBook TW100
>> and WinBook TW700. Could you tell me the DMI_SYS_VENDOR and
>> DMI_PRODUCT_NAME for Onda v975w so I can add it as well?
>
> I don't have access to the Onda v975w anymore, but let me CC: a few
> people that could also help with testing.
>
> Carlos, Cosimo, Christian, there's a patchset for you to test on the
> Onda v975w at:
> https://github.com/hadess/gt9xx/commits/irina-tirdea
>
> Doing an "rmmod goodix ; insmod ./goodix_backport.ko" should be enough
> to test whether the patch set works. If it doesn't work correctly,
> you'll need to reboot the machine, swap the irq_idx and rst_idx values
> at:
> https://github.com/hadess/gt9xx/commit/c27de79f494c2b2e7a198ff4d27976ae93669dbd#diff-dddc2849e36327439530f3e2faacec4fR321
>
> and try again.

Unswapped does fail with:

sep 30 15:37:29 tablet kernel: Goodix-TS i2c-GDIX1001:00: i2c test
failed attempt 1: -121
sep 30 15:37:29 tablet kernel: Goodix-TS i2c-GDIX1001:00: i2c test
failed attempt 2: -121
sep 30 15:37:29 tablet kernel: Goodix-TS i2c-GDIX1001:00: I2C
communication failure: -121
sep 30 15:37:29 tablet kernel: Goodix-TS: probe of i2c-GDIX1001:00
failed with error -121

Swapping the values triggers some errors:

sep 30 15:48:17 tablet kernel: ------------[ cut here ]------------
sep 30 15:48:17 tablet kernel: WARNING: CPU: 1 PID: 2341 at
drivers/pinctrl/intel/pinctrl-baytrail.c:342
byt_gpio_direction_output+0xa1/0xb0()
sep 30 15:48:17 tablet kernel: Potential Error: Setting GPIO with
direct_irq_en to output
sep 30 15:48:17 tablet kernel: Modules linked in:
sep 30 15:48:17 tablet kernel:  goodix_backport(OE+) r8723bs(OE) nfsd
lockd grace sunrpc [last unloaded: goodix]
sep 30 15:48:17 tablet kernel: CPU: 1 PID: 2341 Comm: insmod Tainted:
G           OE   4.3.0-rc1+ #36
sep 30 15:48:17 tablet kernel: Hardware name: To be filled by O.E.M.
To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
sep 30 15:48:17 tablet kernel:  00000000 00000000 d3f61c08 c13b347f
d3f61c48 d3f61c38 c10a9e1d c20f10e0
sep 30 15:48:17 tablet kernel:  d3f61c64 00000925 c20f111c 00000156
c13e7ce1 c13e7ce1 f80580b8 f53a4b0c
sep 30 15:48:17 tablet kernel:  00000156 d3f61c50 c10a9e93 00000009
d3f61c48 c20f10e0 d3f61c64 d3f61c78
sep 30 15:48:17 tablet kernel: Call Trace:
sep 30 15:48:17 tablet kernel:  [<c13b347f>] dump_stack+0x48/0x69
sep 30 15:48:17 tablet kernel:  [<c10a9e1d>] warn_slowpath_common+0x8d/0xd0
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c10a9e93>] warn_slowpath_fmt+0x33/0x40
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c13e7c40>] ? byt_gpio_irq_handler+0xb0/0xb0
sep 30 15:48:17 tablet kernel:  [<c13eabc3>]
_gpiod_direction_output_raw+0x63/0x350
sep 30 15:48:17 tablet kernel:  [<c13eaf1a>] gpiod_direction_output+0x2a/0x50
sep 30 15:48:17 tablet kernel:  [<c112b846>] ? msleep+0x36/0x40
sep 30 15:48:17 tablet kernel:  [<f9ff38ae>] goodix_reset+0x3e/0x90
[goodix_backport]
sep 30 15:48:17 tablet kernel:  [<f9ff40fa>]
goodix_ts_probe+0x12a/0x5aa [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c142a5a4>] ? acpi_device_wakeup+0x7a/0x80
sep 30 15:48:17 tablet kernel:  [<c142ad84>] ? acpi_dev_pm_attach+0x71/0x87
sep 30 15:48:17 tablet kernel:  [<c1924271>] i2c_device_probe+0x121/0x1d0
sep 30 15:48:17 tablet kernel:  [<c1c77da2>] ? _raw_spin_unlock+0x22/0x30
sep 30 15:48:17 tablet kernel:  [<f9ff3fd0>] ?
goodix_config_cb+0xc0/0xc0 [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c15b2125>] ? driver_sysfs_add+0x75/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2b24>] driver_probe_device+0x204/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b2e3c>] ? __driver_attach+0x5c/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2e3c>] ? __driver_attach+0x5c/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2e79>] __driver_attach+0x99/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2de0>] ? driver_probe_device+0x4c0/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b092f>] bus_for_each_dev+0x4f/0x80
sep 30 15:48:17 tablet kernel:  [<c15b22de>] driver_attach+0x1e/0x20
sep 30 15:48:17 tablet kernel:  [<c15b2de0>] ? driver_probe_device+0x4c0/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b1e77>] bus_add_driver+0x1f7/0x2a0
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<c15b398d>] driver_register+0x5d/0xf0
sep 30 15:48:17 tablet kernel:  [<c1924daa>] i2c_register_driver+0x2a/0xa0
sep 30 15:48:17 tablet kernel:  [<c100045f>] ? do_one_initcall+0x9f/0x1f0
sep 30 15:48:17 tablet kernel:  [<f9ff7012>]
goodix_ts_driver_init+0x12/0x14 [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c100046a>] do_one_initcall+0xaa/0x1f0
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<c10d2486>] ? __might_sleep+0x36/0xa0
sep 30 15:48:17 tablet kernel:  [<c1103fd4>] ?
trace_hardirqs_on_caller+0x14/0x220
sep 30 15:48:17 tablet kernel:  [<c11c1c5c>] ? free_pages_prepare+0x19c/0x380
sep 30 15:48:17 tablet kernel:  [<c120bce8>] ? kmem_cache_alloc_trace+0xa8/0x2a0
sep 30 15:48:17 tablet kernel:  [<c11bac3f>] ? do_init_module+0x21/0x1b0
sep 30 15:48:17 tablet kernel:  [<c11bac6e>] do_init_module+0x50/0x1b0
sep 30 15:48:17 tablet kernel:  [<c114b69b>] load_module+0x13db/0x1980
sep 30 15:48:17 tablet kernel:  [<c114be29>] SyS_finit_module+0x89/0xd0
sep 30 15:48:17 tablet kernel:  [<c11d9532>] ? vm_mmap_pgoff+0x62/0x80
sep 30 15:48:17 tablet kernel:  [<c1c787f0>] sysenter_do_call+0x12/0x12
sep 30 15:48:17 tablet kernel: ---[ end trace e0f66305648b0639 ]---
sep 30 15:48:17 tablet kernel: ------------[ cut here ]------------
sep 30 15:48:17 tablet kernel: WARNING: CPU: 1 PID: 2341 at
drivers/pinctrl/intel/pinctrl-baytrail.c:342
byt_gpio_direction_output+0xa1/0xb0()
sep 30 15:48:17 tablet kernel: Potential Error: Setting GPIO with
direct_irq_en to output
sep 30 15:48:17 tablet kernel: Modules linked in:
sep 30 15:48:17 tablet kernel:  goodix_backport(OE+) r8723bs(OE) nfsd
lockd grace sunrpc [last unloaded: goodix]
sep 30 15:48:17 tablet kernel: CPU: 1 PID: 2341 Comm: insmod Tainted:
G        W  OE   4.3.0-rc1+ #36
sep 30 15:48:17 tablet kernel: Hardware name: To be filled by O.E.M.
To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
sep 30 15:48:17 tablet kernel:  00000000 00000000 d3f61bfc c13b347f
d3f61c3c d3f61c2c c10a9e1d c20f10e0
sep 30 15:48:17 tablet kernel:  d3f61c58 00000925 c20f111c 00000156
c13e7ce1 c13e7ce1 f80580b8 f53a4b0c
sep 30 15:48:17 tablet kernel:  00000156 d3f61c44 c10a9e93 00000009
d3f61c3c c20f10e0 d3f61c58 d3f61c6c
sep 30 15:48:17 tablet kernel: Call Trace:
sep 30 15:48:17 tablet kernel:  [<c13b347f>] dump_stack+0x48/0x69
sep 30 15:48:17 tablet kernel:  [<c10a9e1d>] warn_slowpath_common+0x8d/0xd0
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c10a9e93>] warn_slowpath_fmt+0x33/0x40
sep 30 15:48:17 tablet kernel:  [<c13e7ce1>] byt_gpio_direction_output+0xa1/0xb0
sep 30 15:48:17 tablet kernel:  [<c13e7c40>] ? byt_gpio_irq_handler+0xb0/0xb0
sep 30 15:48:17 tablet kernel:  [<c13eabc3>]
_gpiod_direction_output_raw+0x63/0x350
sep 30 15:48:17 tablet kernel:  [<c13e7853>] ?
byt_gpio_direction_input+0x43/0x50
sep 30 15:48:17 tablet kernel:  [<c13eaf1a>] gpiod_direction_output+0x2a/0x50
sep 30 15:48:17 tablet kernel:  [<f9ff37e4>]
goodix_int_sync.isra.4+0x14/0x30 [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<f9ff38f5>] goodix_reset+0x85/0x90
[goodix_backport]
sep 30 15:48:17 tablet kernel:  [<f9ff40fa>]
goodix_ts_probe+0x12a/0x5aa [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c142a5a4>] ? acpi_device_wakeup+0x7a/0x80
sep 30 15:48:17 tablet kernel:  [<c142ad84>] ? acpi_dev_pm_attach+0x71/0x87
sep 30 15:48:17 tablet kernel:  [<c1924271>] i2c_device_probe+0x121/0x1d0
sep 30 15:48:17 tablet kernel:  [<c1c77da2>] ? _raw_spin_unlock+0x22/0x30
sep 30 15:48:17 tablet kernel:  [<f9ff3fd0>] ?
goodix_config_cb+0xc0/0xc0 [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c15b2125>] ? driver_sysfs_add+0x75/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2b24>] driver_probe_device+0x204/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b2e3c>] ? __driver_attach+0x5c/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2e3c>] ? __driver_attach+0x5c/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2e79>] __driver_attach+0x99/0xa0
sep 30 15:48:17 tablet kernel:  [<c15b2de0>] ? driver_probe_device+0x4c0/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b092f>] bus_for_each_dev+0x4f/0x80
sep 30 15:48:17 tablet kernel:  [<c15b22de>] driver_attach+0x1e/0x20
sep 30 15:48:17 tablet kernel:  [<c15b2de0>] ? driver_probe_device+0x4c0/0x4c0
sep 30 15:48:17 tablet kernel:  [<c15b1e77>] bus_add_driver+0x1f7/0x2a0
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<c15b398d>] driver_register+0x5d/0xf0
sep 30 15:48:17 tablet kernel:  [<c1924daa>] i2c_register_driver+0x2a/0xa0
sep 30 15:48:17 tablet kernel:  [<c100045f>] ? do_one_initcall+0x9f/0x1f0
sep 30 15:48:17 tablet kernel:  [<f9ff7012>]
goodix_ts_driver_init+0x12/0x14 [goodix_backport]
sep 30 15:48:17 tablet kernel:  [<c100046a>] do_one_initcall+0xaa/0x1f0
sep 30 15:48:17 tablet kernel:  [<f9ff7000>] ? 0xf9ff7000
sep 30 15:48:17 tablet kernel:  [<c10d2486>] ? __might_sleep+0x36/0xa0
sep 30 15:48:17 tablet kernel:  [<c1103fd4>] ?
trace_hardirqs_on_caller+0x14/0x220
sep 30 15:48:17 tablet kernel:  [<c11c1c5c>] ? free_pages_prepare+0x19c/0x380
sep 30 15:48:17 tablet kernel:  [<c120bce8>] ? kmem_cache_alloc_trace+0xa8/0x2a0
sep 30 15:48:17 tablet kernel:  [<c11bac3f>] ? do_init_module+0x21/0x1b0
sep 30 15:48:17 tablet kernel:  [<c11bac6e>] do_init_module+0x50/0x1b0
sep 30 15:48:17 tablet kernel:  [<c114b69b>] load_module+0x13db/0x1980
sep 30 15:48:17 tablet kernel:  [<c114be29>] SyS_finit_module+0x89/0xd0
sep 30 15:48:17 tablet kernel:  [<c11d9532>] ? vm_mmap_pgoff+0x62/0x80
sep 30 15:48:17 tablet kernel:  [<c1c787f0>] sysenter_do_call+0x12/0x12
sep 30 15:48:17 tablet kernel: ---[ end trace e0f66305648b063a ]---
sep 30 15:48:17 tablet kernel: Goodix-TS i2c-GDIX1001:00: ID 9271, version: 1020
sep 30 15:48:17 tablet kernel: Goodix-TS i2c-GDIX1001:00: Direct
firmware load for goodix_9271_cfg.bin failed with error -2
sep 30 15:48:17 tablet kernel: Goodix-TS i2c-GDIX1001:00: Falling back
to user helper

... and after a while:

sep 30 15:49:17 tablet kernel: input: Goodix Capacitive TouchScreen as
/devices/platform/80860F41:05/i2c-5/i2c-GDIX1001:00/input/input6
sep 30 15:49:17 tablet kernel: ------------[ cut here ]------------
sep 30 15:49:17 tablet kernel: WARNING: CPU: 1 PID: 75 at
drivers/pinctrl/intel/pinctrl-baytrail.c:342
byt_gpio_direction_output+0xa1/0xb0()
sep 30 15:49:17 tablet kernel: Potential Error: Setting GPIO with
direct_irq_en to output
sep 30 15:49:17 tablet kernel: Modules linked in:
sep 30 15:49:17 tablet kernel:  goodix_backport(OE) r8723bs(OE) nfsd
lockd grace sunrpc [last unloaded: goodix]
sep 30 15:49:17 tablet kernel: CPU: 1 PID: 75 Comm: kworker/1:2
Tainted: G        W  OE   4.3.0-rc1+ #36
sep 30 15:49:17 tablet kernel: Hardware name: To be filled by O.E.M.
To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
sep 30 15:49:17 tablet kernel: Workqueue: events request_firmware_work_func
sep 30 15:49:17 tablet kernel:  00000000 00000000 f7219ce8 c13b347f
f7219d28 f7219d18 c10a9e1d c20f10e0
sep 30 15:49:17 tablet kernel:  f7219d44 0000004b c20f111c 00000156
c13e7ce1 c13e7ce1 f80580b8 f53a4b0c
sep 30 15:49:17 tablet kernel:  00000156 f7219d30 c10a9e93 00000009
f7219d28 c20f10e0 f7219d44 f7219d58
sep 30 15:49:17 tablet kernel: Call Trace:
sep 30 15:49:17 tablet kernel:  [<c13b347f>] dump_stack+0x48/0x69
sep 30 15:49:17 tablet kernel:  [<c10a9e1d>] warn_slowpath_common+0x8d/0xd0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c10a9e93>] warn_slowpath_fmt+0x33/0x40
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7c40>] ? byt_gpio_irq_handler+0xb0/0xb0
sep 30 15:49:17 tablet kernel:  [<c13eabc3>]
_gpiod_direction_output_raw+0x63/0x350
sep 30 15:49:17 tablet kernel:  [<c111d30b>] ? free_irq+0x4b/0xc0
sep 30 15:49:17 tablet kernel:  [<c142a87d>] ?
acpi_dev_runtime_suspend+0x7b/0x7b
sep 30 15:49:17 tablet kernel:  [<c13eaf1a>] gpiod_direction_output+0x2a/0x50
sep 30 15:49:17 tablet kernel:  [<f9ff32d0>] goodix_suspend+0x50/0x100
[goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c15bc0fd>] ? __rpm_callback+0x5d/0x80
sep 30 15:49:17 tablet kernel:  [<c15ba3a2>]
pm_generic_runtime_suspend+0x22/0x40
sep 30 15:49:17 tablet kernel:  [<c142a88d>]
acpi_subsys_runtime_suspend+0x10/0x1e
sep 30 15:49:17 tablet kernel:  [<c15bc0d2>] __rpm_callback+0x32/0x80
sep 30 15:49:17 tablet kernel:  [<c142a87d>] ?
acpi_dev_runtime_suspend+0x7b/0x7b
sep 30 15:49:17 tablet kernel:  [<c15bc148>] rpm_callback+0x28/0x90
sep 30 15:49:17 tablet kernel:  [<c142a87d>] ?
acpi_dev_runtime_suspend+0x7b/0x7b
sep 30 15:49:17 tablet kernel:  [<c15bce3a>] rpm_suspend+0x12a/0x720
sep 30 15:49:17 tablet kernel:  [<c10fffbb>] ? trace_hardirqs_off+0xb/0x10
sep 30 15:49:17 tablet kernel:  [<c10f3fd4>] ? __wake_up+0x44/0x50
sep 30 15:49:17 tablet kernel:  [<c15bd5a6>] rpm_idle+0xa6/0x410
sep 30 15:49:17 tablet kernel:  [<c15be1ab>] update_autosuspend+0x3b/0x60
sep 30 15:49:17 tablet kernel:  [<c15be218>]
pm_runtime_set_autosuspend_delay+0x48/0x60
sep 30 15:49:17 tablet kernel:  [<c10c4942>] ? process_one_work+0x132/0x5e0
sep 30 15:49:17 tablet kernel:  [<f9ff3f82>]
goodix_config_cb+0x72/0xc0 [goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c15c81ab>]
request_firmware_work_func+0x2b/0x50
sep 30 15:49:17 tablet kernel:  [<c10c49e0>] process_one_work+0x1d0/0x5e0
sep 30 15:49:17 tablet kernel:  [<c10c4942>] ? process_one_work+0x132/0x5e0
sep 30 15:49:17 tablet kernel:  [<c10c4e29>] worker_thread+0x39/0x430
sep 30 15:49:17 tablet kernel:  [<c10c4df0>] ? process_one_work+0x5e0/0x5e0
sep 30 15:49:17 tablet kernel:  [<c10cae16>] kthread+0xa6/0xc0
sep 30 15:49:17 tablet kernel:  [<c1c77e17>] ? _raw_spin_unlock_irq+0x27/0x40
sep 30 15:49:17 tablet kernel:  [<c1c78721>] ret_from_kernel_thread+0x21/0x30
sep 30 15:49:17 tablet kernel:  [<c10cad70>] ?
kthread_create_on_node+0x130/0x130
sep 30 15:49:17 tablet kernel: ---[ end trace e0f66305648b063b ]---
sep 30 15:49:17 tablet kernel: ------------[ cut here ]------------
sep 30 15:49:17 tablet kernel: WARNING: CPU: 2 PID: 2353 at
drivers/pinctrl/intel/pinctrl-baytrail.c:342
byt_gpio_direction_output+0xa1/0xb0()
sep 30 15:49:17 tablet kernel: Potential Error: Setting GPIO with
direct_irq_en to output
sep 30 15:49:17 tablet kernel: Modules linked in:
sep 30 15:49:17 tablet kernel:  goodix_backport(OE) r8723bs(OE) nfsd
lockd grace sunrpc [last unloaded: goodix]
sep 30 15:49:17 tablet kernel: CPU: 2 PID: 2353 Comm: systemd-udevd
Tainted: G        W  OE   4.3.0-rc1+ #36
sep 30 15:49:17 tablet kernel: Hardware name: To be filled by O.E.M.
To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
sep 30 15:49:17 tablet kernel:  00000000 00000000 d8bbdc70 c13b347f
d8bbdcb0 d8bbdca0 c10a9e1d c20f10e0
sep 30 15:49:17 tablet kernel:  d8bbdccc 00000931 c20f111c 00000156
c13e7ce1 c13e7ce1 f80580b8 f53a4b0c
sep 30 15:49:17 tablet kernel:  00000156 d8bbdcb8 c10a9e93 00000009
d8bbdcb0 c20f10e0 d8bbdccc d8bbdce0
sep 30 15:49:17 tablet kernel: Call Trace:
sep 30 15:49:17 tablet kernel:  [<c13b347f>] dump_stack+0x48/0x69
sep 30 15:49:17 tablet kernel:  [<c10a9e1d>] warn_slowpath_common+0x8d/0xd0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c10a9e93>] warn_slowpath_fmt+0x33/0x40
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7c40>] ? byt_gpio_irq_handler+0xb0/0xb0
sep 30 15:49:17 tablet kernel:  [<c13eabc3>]
_gpiod_direction_output_raw+0x63/0x350
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c13eaf1a>] gpiod_direction_output+0x2a/0x50
sep 30 15:49:17 tablet kernel:  [<c142a5a4>] ? acpi_device_wakeup+0x7a/0x80
sep 30 15:49:17 tablet kernel:  [<f9ff3827>] goodix_resume+0x27/0x70
[goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c15ba3e2>] pm_generic_runtime_resume+0x22/0x40
sep 30 15:49:17 tablet kernel:  [<c142a6c5>]
acpi_subsys_runtime_resume+0x1b/0x1e
sep 30 15:49:17 tablet kernel:  [<c15bc0d2>] __rpm_callback+0x32/0x80
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c15bc148>] rpm_callback+0x28/0x90
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c15bcab3>] rpm_resume+0x503/0x760
sep 30 15:49:17 tablet kernel:  [<c10f4710>] ? wake_atomic_t_function+0x70/0x70
sep 30 15:49:17 tablet kernel:  [<c15bde1e>] __pm_runtime_resume+0x4e/0x90
sep 30 15:49:17 tablet kernel:  [<f9ff3777>] goodix_open+0x37/0x90
[goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c18f9e3f>] input_open_device+0x7f/0xa0
sep 30 15:49:17 tablet kernel:  [<c1902c5b>] evdev_open+0x16b/0x1a0
sep 30 15:49:17 tablet kernel:  [<c121b9fd>] chrdev_open+0x8d/0x1a0
sep 30 15:49:17 tablet kernel:  [<c121b970>] ? cdev_put+0x20/0x20
sep 30 15:49:17 tablet kernel:  [<c1215230>] do_dentry_open.isra.16+0x130/0x2d0
sep 30 15:49:17 tablet kernel:  [<c121b970>] ? cdev_put+0x20/0x20
sep 30 15:49:17 tablet kernel:  [<c121670f>] vfs_open+0x4f/0x60
sep 30 15:49:17 tablet kernel:  [<c1225e22>] path_openat+0x1a2/0x10b0
sep 30 15:49:17 tablet kernel:  [<c11e9224>] ? unmap_single_vma+0x3d4/0x560
sep 30 15:49:17 tablet kernel:  [<c11cb182>] ? release_pages+0xb2/0x1c0
sep 30 15:49:17 tablet kernel:  [<c1227d42>] do_filp_open+0x62/0xc0
sep 30 15:49:17 tablet kernel:  [<c1c77da2>] ? _raw_spin_unlock+0x22/0x30
sep 30 15:49:17 tablet kernel:  [<c12381b7>] ? __alloc_fd+0x97/0x160
sep 30 15:49:17 tablet kernel:  [<c1216ac8>] do_sys_open+0x118/0x210
sep 30 15:49:17 tablet kernel:  [<c1216be2>] SyS_open+0x22/0x30
sep 30 15:49:17 tablet kernel:  [<c1c787f0>] sysenter_do_call+0x12/0x12
sep 30 15:49:17 tablet kernel: ---[ end trace e0f66305648b063c ]---
sep 30 15:49:17 tablet kernel: ------------[ cut here ]------------
sep 30 15:49:17 tablet kernel: WARNING: CPU: 2 PID: 2353 at
drivers/pinctrl/intel/pinctrl-baytrail.c:342
byt_gpio_direction_output+0xa1/0xb0()
sep 30 15:49:17 tablet kernel: Potential Error: Setting GPIO with
direct_irq_en to output
sep 30 15:49:17 tablet kernel: Modules linked in:
sep 30 15:49:17 tablet kernel:  goodix_backport(OE) r8723bs(OE) nfsd
lockd grace sunrpc [last unloaded: goodix]
sep 30 15:49:17 tablet kernel: CPU: 2 PID: 2353 Comm: systemd-udevd
Tainted: G        W  OE   4.3.0-rc1+ #36
sep 30 15:49:17 tablet kernel: Hardware name: To be filled by O.E.M.
To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/25/2014
sep 30 15:49:17 tablet kernel:  00000000 00000000 d8bbdc64 c13b347f
d8bbdca4 d8bbdc94 c10a9e1d c20f10e0
sep 30 15:49:17 tablet kernel:  d8bbdcc0 00000931 c20f111c 00000156
c13e7ce1 c13e7ce1 f80580b8 f53a4b0c
sep 30 15:49:17 tablet kernel:  00000156 d8bbdcac c10a9e93 00000009
d8bbdca4 c20f10e0 d8bbdcc0 d8bbdcd4
sep 30 15:49:17 tablet kernel: Call Trace:
sep 30 15:49:17 tablet kernel:  [<c13b347f>] dump_stack+0x48/0x69
sep 30 15:49:17 tablet kernel:  [<c10a9e1d>] warn_slowpath_common+0x8d/0xd0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] ?
byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c10a9e93>] warn_slowpath_fmt+0x33/0x40
sep 30 15:49:17 tablet kernel:  [<c13e7ce1>] byt_gpio_direction_output+0xa1/0xb0
sep 30 15:49:17 tablet kernel:  [<c13e7c40>] ? byt_gpio_irq_handler+0xb0/0xb0
sep 30 15:49:17 tablet kernel:  [<c13eabc3>]
_gpiod_direction_output_raw+0x63/0x350
sep 30 15:49:17 tablet kernel:  [<c1c76ef4>] ?
schedule_hrtimeout_range_clock+0x104/0x280
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c13eaf1a>] gpiod_direction_output+0x2a/0x50
sep 30 15:49:17 tablet kernel:  [<f9ff37e4>]
goodix_int_sync.isra.4+0x14/0x30 [goodix_backport]
sep 30 15:49:17 tablet kernel:  [<f9ff3847>] goodix_resume+0x47/0x70
[goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c15ba3e2>] pm_generic_runtime_resume+0x22/0x40
sep 30 15:49:17 tablet kernel:  [<c142a6c5>]
acpi_subsys_runtime_resume+0x1b/0x1e
sep 30 15:49:17 tablet kernel:  [<c15bc0d2>] __rpm_callback+0x32/0x80
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c15bc148>] rpm_callback+0x28/0x90
sep 30 15:49:17 tablet kernel:  [<c142a6aa>] ? acpi_dev_runtime_resume+0x37/0x37
sep 30 15:49:17 tablet kernel:  [<c15bcab3>] rpm_resume+0x503/0x760
sep 30 15:49:17 tablet kernel:  [<c10f4710>] ? wake_atomic_t_function+0x70/0x70
sep 30 15:49:17 tablet kernel:  [<c15bde1e>] __pm_runtime_resume+0x4e/0x90
sep 30 15:49:17 tablet kernel:  [<f9ff3777>] goodix_open+0x37/0x90
[goodix_backport]
sep 30 15:49:17 tablet kernel:  [<c18f9e3f>] input_open_device+0x7f/0xa0
sep 30 15:49:17 tablet kernel:  [<c1902c5b>] evdev_open+0x16b/0x1a0
sep 30 15:49:17 tablet kernel:  [<c121b9fd>] chrdev_open+0x8d/0x1a0
sep 30 15:49:17 tablet kernel:  [<c121b970>] ? cdev_put+0x20/0x20
sep 30 15:49:17 tablet kernel:  [<c1215230>] do_dentry_open.isra.16+0x130/0x2d0
sep 30 15:49:17 tablet kernel:  [<c121b970>] ? cdev_put+0x20/0x20
sep 30 15:49:17 tablet kernel:  [<c121670f>] vfs_open+0x4f/0x60
sep 30 15:49:17 tablet kernel:  [<c1225e22>] path_openat+0x1a2/0x10b0
sep 30 15:49:17 tablet kernel:  [<c11e9224>] ? unmap_single_vma+0x3d4/0x560
sep 30 15:49:17 tablet kernel:  [<c11cb182>] ? release_pages+0xb2/0x1c0
sep 30 15:49:17 tablet kernel:  [<c1227d42>] do_filp_open+0x62/0xc0
sep 30 15:49:17 tablet kernel:  [<c1c77da2>] ? _raw_spin_unlock+0x22/0x30
sep 30 15:49:17 tablet kernel:  [<c12381b7>] ? __alloc_fd+0x97/0x160
sep 30 15:49:17 tablet kernel:  [<c1216ac8>] do_sys_open+0x118/0x210
sep 30 15:49:17 tablet kernel:  [<c1216be2>] SyS_open+0x22/0x30
sep 30 15:49:17 tablet kernel:  [<c1c787f0>] sysenter_do_call+0x12/0x12
sep 30 15:49:17 tablet kernel: ---[ end trace e0f66305648b063d ]---

The touchscreen works though after this. This is all over ~4.3.0-rc1
(a7d5c1897198, a couple of weeks old)

>
> If all that fails, could you please send the output of "dmidecode" to
> Irina?

Attached.

Cheers,
  Carlos

--047d7b33956d1749520520f75fb0
Content-Type: text/plain; charset=US-ASCII; name="dmidecode.txt"
Content-Disposition: attachment; filename="dmidecode.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_if6uy0vg0

IyBkbWlkZWNvZGUgMi4xMgojIFNNQklPUyBlbnRyeSBwb2ludCBhdCAweDVkYzc5MjkwClNNQklP
UyAyLjcgcHJlc2VudC4KNTEgc3RydWN0dXJlcyBvY2N1cHlpbmcgMjA0MSBieXRlcy4KVGFibGUg
YXQgMHg1REEwQTAxMC4KCkhhbmRsZSAweDAwMDAsIERNSSB0eXBlIDAsIDI0IGJ5dGVzCkJJT1Mg
SW5mb3JtYXRpb24KCVZlbmRvcjogQW1lcmljYW4gTWVnYXRyZW5kcyBJbmMuCglWZXJzaW9uOiA1
LjYuNQoJUmVsZWFzZSBEYXRlOiAwNy8yNS8yMDE0CglBZGRyZXNzOiAweEYwMDAwCglSdW50aW1l
IFNpemU6IDY0IGtCCglST00gU2l6ZTogMTAyNCBrQgoJQ2hhcmFjdGVyaXN0aWNzOgoJCVBDSSBp
cyBzdXBwb3J0ZWQKCQlCSU9TIGlzIHVwZ3JhZGVhYmxlCgkJQklPUyBzaGFkb3dpbmcgaXMgYWxs
b3dlZAoJCUJvb3QgZnJvbSBDRCBpcyBzdXBwb3J0ZWQKCQlTZWxlY3RhYmxlIGJvb3QgaXMgc3Vw
cG9ydGVkCgkJQklPUyBST00gaXMgc29ja2V0ZWQKCQlFREQgaXMgc3VwcG9ydGVkCgkJNS4yNSIv
MS4yIE1CIGZsb3BweSBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTNoKQoJCTMuNSIvNzIw
IGtCIGZsb3BweSBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTNoKQoJCTMuNSIvMi44OCBN
QiBmbG9wcHkgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50IDEzaCkKCQlQcmludCBzY3JlZW4g
c2VydmljZSBpcyBzdXBwb3J0ZWQgKGludCA1aCkKCQlTZXJpYWwgc2VydmljZXMgYXJlIHN1cHBv
cnRlZCAoaW50IDE0aCkKCQlQcmludGVyIHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxN2gp
CgkJQUNQSSBpcyBzdXBwb3J0ZWQKCQlVU0IgbGVnYWN5IGlzIHN1cHBvcnRlZAoJCUJJT1MgYm9v
dCBzcGVjaWZpY2F0aW9uIGlzIHN1cHBvcnRlZAoJCVRhcmdldGVkIGNvbnRlbnQgZGlzdHJpYnV0
aW9uIGlzIHN1cHBvcnRlZAoJCVVFRkkgaXMgc3VwcG9ydGVkCglCSU9TIFJldmlzaW9uOiA1LjYK
CkhhbmRsZSAweDAwMDEsIERNSSB0eXBlIDEsIDI3IGJ5dGVzClN5c3RlbSBJbmZvcm1hdGlvbgoJ
TWFudWZhY3R1cmVyOiBUbyBiZSBmaWxsZWQgYnkgTy5FLk0uCglQcm9kdWN0IE5hbWU6IFRvIGJl
IGZpbGxlZCBieSBPLkUuTS4KCVZlcnNpb246IFRvIGJlIGZpbGxlZCBieSBPLkUuTS4KCVNlcmlh
bCBOdW1iZXI6IFRvIGJlIGZpbGxlZCBieSBPLkUuTS4KCVVVSUQ6IDAzMDAwMjAwLTA0MDAtMDUw
MC0wMDA2LTAwMDcwMDA4MDAwOQoJV2FrZS11cCBUeXBlOiBQb3dlciBTd2l0Y2gKCVNLVSBOdW1i
ZXI6IFRvIGJlIGZpbGxlZCBieSBPLkUuTS4KCUZhbWlseTogVG8gYmUgZmlsbGVkIGJ5IE8uRS5N
LgoKSGFuZGxlIDB4MDAwMiwgRE1JIHR5cGUgMiwgMTUgYnl0ZXMKQmFzZSBCb2FyZCBJbmZvcm1h
dGlvbgoJTWFudWZhY3R1cmVyOiBBTUkgQ29ycG9yYXRpb24KCVByb2R1Y3QgTmFtZTogQXB0aW8g
Q1JCCglWZXJzaW9uOiBUbyBiZSBmaWxsZWQgYnkgTy5FLk0uCglTZXJpYWwgTnVtYmVyOiBUbyBi
ZSBmaWxsZWQgYnkgTy5FLk0uCglBc3NldCBUYWc6IFRvIGJlIGZpbGxlZCBieSBPLkUuTS4KCUZl
YXR1cmVzOgoJCUJvYXJkIGlzIGEgaG9zdGluZyBib2FyZAoJCUJvYXJkIGlzIHJlcGxhY2VhYmxl
CglMb2NhdGlvbiBJbiBDaGFzc2lzOiBUbyBiZSBmaWxsZWQgYnkgTy5FLk0uCglDaGFzc2lzIEhh
bmRsZTogMHgwMDAzCglUeXBlOiBNb3RoZXJib2FyZAoJQ29udGFpbmVkIE9iamVjdCBIYW5kbGVz
OiAwCgpIYW5kbGUgMHgwMDAzLCBETUkgdHlwZSAzLCAyMiBieXRlcwpDaGFzc2lzIEluZm9ybWF0
aW9uCglNYW51ZmFjdHVyZXI6IFRvIEJlIEZpbGxlZCBCeSBPLkUuTS4KCVR5cGU6IERlc2t0b3AK
CUxvY2s6IE5vdCBQcmVzZW50CglWZXJzaW9uOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uCglTZXJp
YWwgTnVtYmVyOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uCglBc3NldCBUYWc6IFRvIEJlIEZpbGxl
ZCBCeSBPLkUuTS4KCUJvb3QtdXAgU3RhdGU6IFNhZmUKCVBvd2VyIFN1cHBseSBTdGF0ZTogU2Fm
ZQoJVGhlcm1hbCBTdGF0ZTogU2FmZQoJU2VjdXJpdHkgU3RhdHVzOiBOb25lCglPRU0gSW5mb3Jt
YXRpb246IDB4MDAwMDAwMDAKCUhlaWdodDogVW5zcGVjaWZpZWQKCU51bWJlciBPZiBQb3dlciBD
b3JkczogMQoJQ29udGFpbmVkIEVsZW1lbnRzOiAwCglTS1UgTnVtYmVyOiBUbyBiZSBmaWxsZWQg
YnkgTy5FLk0uCgpIYW5kbGUgMHgwMDA4LCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVj
dG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjFBMQoJSW50
ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9y
OiBQUzJNb3VzZQoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IFBTLzIKCVBvcnQgVHlwZTogTW91
c2UgUG9ydAoKSGFuZGxlIDB4MDAwOSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3Rv
ciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEoxQTEKCUludGVy
bmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjog
S2V5Ym9hcmQKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBQUy8yCglQb3J0IFR5cGU6IEtleWJv
YXJkIFBvcnQKCkhhbmRsZSAweDAwMEEsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0
b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKMkExCglJbnRl
cm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6
IFRWIE91dAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE1pbmkgQ2VudHJvbmljcyBUeXBlLTE0
CglQb3J0IFR5cGU6IE90aGVyCgpIYW5kbGUgMHgwMDBCLCBETUkgdHlwZSA4LCA5IGJ5dGVzClBv
cnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjog
SjJBMkEKCUludGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglFeHRlcm5hbCBSZWZlcmVuY2Ug
RGVzaWduYXRvcjogQ09NIEEKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBEQi05IG1hbGUKCVBv
cnQgVHlwZTogU2VyaWFsIFBvcnQgMTY1NTBBIENvbXBhdGlibGUKCkhhbmRsZSAweDAwMEMsIERN
SSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJl
ZmVyZW5jZSBEZXNpZ25hdG9yOiBKMkEyQgoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUK
CUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBWaWRlbwoJRXh0ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IERCLTE1IGZlbWFsZQoJUG9ydCBUeXBlOiBWaWRlbyBQb3J0CgpIYW5kbGUgMHgwMDBE
LCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5h
bCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjNBMQoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5v
bmUKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBVU0IxCglFeHRlcm5hbCBDb25uZWN0
b3IgVHlwZTogQWNjZXNzIEJ1cyAoVVNCKQoJUG9ydCBUeXBlOiBVU0IKCkhhbmRsZSAweDAwMEUs
IERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFs
IFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKM0ExCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9u
ZQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFVTQjIKCUV4dGVybmFsIENvbm5lY3Rv
ciBUeXBlOiBBY2Nlc3MgQnVzIChVU0IpCglQb3J0IFR5cGU6IFVTQgoKSGFuZGxlIDB4MDAwRiwg
RE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwg
UmVmZXJlbmNlIERlc2lnbmF0b3I6IEozQTEKCUludGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25l
CglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogVVNCMwoJRXh0ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IEFjY2VzcyBCdXMgKFVTQikKCVBvcnQgVHlwZTogVVNCCgpIYW5kbGUgMHgwMDEwLCBE
TUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBS
ZWZlcmVuY2UgRGVzaWduYXRvcjogSjlBMSAtIFRQTSBIRFIKCUludGVybmFsIENvbm5lY3RvciBU
eXBlOiBPdGhlcgoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE5vdCBTcGVjaWZpZWQK
CUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0IFR5cGU6IE90aGVyCgpIYW5kbGUg
MHgwMDExLCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJ
bnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjlDMSAtIFBDSUUgRE9DS0lORyBDT05OCglJ
bnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25h
dG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBU
eXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMiwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5l
Y3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEoyQjMgLSBD
UFUgRkFOCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5j
ZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9u
ZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMywgRE1JIHR5cGUgOCwgOSBieXRlcwpQ
b3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6
IEo2QzIgLSBFWFQgSERNSQoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5h
bCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTQsIERNSSB0eXBlIDgs
IDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBE
ZXNpZ25hdG9yOiBKM0MxIC0gR01DSCBGQU4KCUludGVybmFsIENvbm5lY3RvciBUeXBlOiBPdGhl
cgoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE5vdCBTcGVjaWZpZWQKCUV4dGVybmFs
IENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0IFR5cGU6IE90aGVyCgpIYW5kbGUgMHgwMDE1LCBE
TUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBS
ZWZlcmVuY2UgRGVzaWduYXRvcjogSjFEMSAtIElUUAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6
IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0
ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAw
MTYsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVy
bmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUUyIC0gTURDIElOVFBTUgoJSW50ZXJuYWwgQ29u
bmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNw
ZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIK
CkhhbmRsZSAweDAwMTcsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3Jt
YXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUU0IC0gTURDIElOVFBTUgoJ
SW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWdu
YXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQg
VHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTgsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25u
ZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUUzIC0g
TFBDIEhPVCBET0NLSU5HCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVybmFs
IFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0b3Ig
VHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxOSwgRE1JIHR5cGUgOCwg
OSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERl
c2lnbmF0b3I6IEo5RTEgLSBTQ0FOIE1BVFJJWAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90
aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUEs
IERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFs
IFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUcxIC0gTFBDIFNJREUgQkFORAoJSW50ZXJuYWwgQ29u
bmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNw
ZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIK
CkhhbmRsZSAweDAwMUIsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3Jt
YXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOEYxIC0gVU5JRklFRAoJSW50
ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRv
cjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlw
ZTogT3RoZXIKCkhhbmRsZSAweDAwMUMsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0
b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKNkYxIC0gTFZE
UwoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVz
aWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBv
cnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUQsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBD
b25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKMkYx
IC0gTEFJIEZBTgoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZl
cmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6
IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUUsIERNSSB0eXBlIDgsIDkgYnl0
ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25h
dG9yOiBKMkcxIC0gR0ZYIFZJRAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRl
cm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVj
dG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUYsIERNSSB0eXBl
IDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5j
ZSBEZXNpZ25hdG9yOiBKMUc2IC0gQUMgSkFDSwoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90
aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMjAs
IERNSSB0eXBlIDksIDE3IGJ5dGVzClN5c3RlbSBTbG90IEluZm9ybWF0aW9uCglEZXNpZ25hdGlv
bjogSjZCMgoJVHlwZTogeDE2IFBDSSBFeHByZXNzCglDdXJyZW50IFVzYWdlOiBJbiBVc2UKCUxl
bmd0aDogTG9uZwoJSUQ6IDAKCUNoYXJhY3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRlZAoJ
CU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNz
OiAwMDAwOjAwOjAxLjAKCkhhbmRsZSAweDAwMjEsIERNSSB0eXBlIDksIDE3IGJ5dGVzClN5c3Rl
bSBTbG90IEluZm9ybWF0aW9uCglEZXNpZ25hdGlvbjogSjZCMQoJVHlwZTogeDEgUENJIEV4cHJl
c3MKCUN1cnJlbnQgVXNhZ2U6IEluIFVzZQoJTGVuZ3RoOiBTaG9ydAoJSUQ6IDEKCUNoYXJhY3Rl
cmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRlZAoJCU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNp
Z25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjFjLjMKCkhhbmRsZSAweDAw
MjIsIERNSSB0eXBlIDksIDE3IGJ5dGVzClN5c3RlbSBTbG90IEluZm9ybWF0aW9uCglEZXNpZ25h
dGlvbjogSjZEMQoJVHlwZTogeDEgUENJIEV4cHJlc3MKCUN1cnJlbnQgVXNhZ2U6IEluIFVzZQoJ
TGVuZ3RoOiBTaG9ydAoJSUQ6IDIKCUNoYXJhY3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRl
ZAoJCU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRy
ZXNzOiAwMDAwOjAwOjFjLjQKCkhhbmRsZSAweDAwMjMsIERNSSB0eXBlIDksIDE3IGJ5dGVzClN5
c3RlbSBTbG90IEluZm9ybWF0aW9uCglEZXNpZ25hdGlvbjogSjdCMQoJVHlwZTogeDEgUENJIEV4
cHJlc3MKCUN1cnJlbnQgVXNhZ2U6IEluIFVzZQoJTGVuZ3RoOiBTaG9ydAoJSUQ6IDMKCUNoYXJh
Y3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRlZAoJCU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1F
IHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjFjLjUKCkhhbmRsZSAw
eDAwMjQsIERNSSB0eXBlIDksIDE3IGJ5dGVzClN5c3RlbSBTbG90IEluZm9ybWF0aW9uCglEZXNp
Z25hdGlvbjogSjhCNAoJVHlwZTogeDEgUENJIEV4cHJlc3MKCUN1cnJlbnQgVXNhZ2U6IEluIFVz
ZQoJTGVuZ3RoOiBTaG9ydAoJSUQ6IDQKCUNoYXJhY3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92
aWRlZAoJCU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBB
ZGRyZXNzOiAwMDAwOjAwOjFjLjYKCkhhbmRsZSAweDAwMjUsIERNSSB0eXBlIDEwLCA2IGJ5dGVz
Ck9uIEJvYXJkIERldmljZSBJbmZvcm1hdGlvbgoJVHlwZTogVmlkZW8KCVN0YXR1czogRW5hYmxl
ZAoJRGVzY3JpcHRpb246ICAgIFRvIEJlIEZpbGxlZCBCeSBPLkUuTS4KCkhhbmRsZSAweDAwMjYs
IERNSSB0eXBlIDExLCA1IGJ5dGVzCk9FTSBTdHJpbmdzCglTdHJpbmcgMTogVG8gQmUgRmlsbGVk
IEJ5IE8uRS5NLgoKSGFuZGxlIDB4MDAyNywgRE1JIHR5cGUgMTIsIDUgYnl0ZXMKU3lzdGVtIENv
bmZpZ3VyYXRpb24gT3B0aW9ucwoJT3B0aW9uIDE6IFRvIEJlIEZpbGxlZCBCeSBPLkUuTS4KCkhh
bmRsZSAweDAwMjgsIERNSSB0eXBlIDE2LCAyMyBieXRlcwpQaHlzaWNhbCBNZW1vcnkgQXJyYXkK
CUxvY2F0aW9uOiBTeXN0ZW0gQm9hcmQgT3IgTW90aGVyYm9hcmQKCVVzZTogU3lzdGVtIE1lbW9y
eQoJRXJyb3IgQ29ycmVjdGlvbiBUeXBlOiBNdWx0aS1iaXQgRUNDCglNYXhpbXVtIENhcGFjaXR5
OiA0IEdCCglFcnJvciBJbmZvcm1hdGlvbiBIYW5kbGU6IE5vdCBQcm92aWRlZAoJTnVtYmVyIE9m
IERldmljZXM6IDIKCkhhbmRsZSAweDAwMjksIERNSSB0eXBlIDE5LCAzMSBieXRlcwpNZW1vcnkg
QXJyYXkgTWFwcGVkIEFkZHJlc3MKCVN0YXJ0aW5nIEFkZHJlc3M6IDB4MDAwMDAwMDAwMDAKCUVu
ZGluZyBBZGRyZXNzOiAweDAwMDdGRkZGRkZGCglSYW5nZSBTaXplOiAyIEdCCglQaHlzaWNhbCBB
cnJheSBIYW5kbGU6IDB4MDAyOAoJUGFydGl0aW9uIFdpZHRoOiAyCgpIYW5kbGUgMHgwMDJBLCBE
TUkgdHlwZSAxNywgMzQgYnl0ZXMKTWVtb3J5IERldmljZQoJQXJyYXkgSGFuZGxlOiAweDAwMjgK
CUVycm9yIEluZm9ybWF0aW9uIEhhbmRsZTogTm90IFByb3ZpZGVkCglUb3RhbCBXaWR0aDogNjQg
Yml0cwoJRGF0YSBXaWR0aDogNjQgYml0cwoJU2l6ZTogMjA0OCBNQgoJRm9ybSBGYWN0b3I6IERJ
TU0KCVNldDogTm9uZQoJTG9jYXRvcjogQTFfRElNTTAKCUJhbmsgTG9jYXRvcjogQTFfQkFOSzAK
CVR5cGU6IEREUjMKCVR5cGUgRGV0YWlsOiBVbmtub3duCglTcGVlZDogMTMzMyBNSHoKCU1hbnVm
YWN0dXJlcjogQTFfTWFudWZhY3R1cmVyMAoJU2VyaWFsIE51bWJlcjogQTFfU2VyTnVtMAoJQXNz
ZXQgVGFnOiBBMV9Bc3NldFRhZ051bTAKCVBhcnQgTnVtYmVyOiBBcnJheTFfUGFydE51bWJlcjAK
CVJhbms6IFVua25vd24KCUNvbmZpZ3VyZWQgQ2xvY2sgU3BlZWQ6IDEzMzMgTUh6CgpIYW5kbGUg
MHgwMDJCLCBETUkgdHlwZSAyMCwgMzUgYnl0ZXMKTWVtb3J5IERldmljZSBNYXBwZWQgQWRkcmVz
cwoJU3RhcnRpbmcgQWRkcmVzczogMHgwMDAwMDAwMDAwMAoJRW5kaW5nIEFkZHJlc3M6IDB4MDAw
N0ZGRkZGRkYKCVJhbmdlIFNpemU6IDIgR0IKCVBoeXNpY2FsIERldmljZSBIYW5kbGU6IDB4MDAy
QQoJTWVtb3J5IEFycmF5IE1hcHBlZCBBZGRyZXNzIEhhbmRsZTogMHgwMDI5CglQYXJ0aXRpb24g
Um93IFBvc2l0aW9uOiA8T1VUIE9GIFNQRUM+CglJbnRlcmxlYXZlIFBvc2l0aW9uOiBVbmtub3du
CglJbnRlcmxlYXZlZCBEYXRhIERlcHRoOiBVbmtub3duCgpIYW5kbGUgMHgwMDJDLCBETUkgdHlw
ZSAxNywgMzQgYnl0ZXMKTWVtb3J5IERldmljZQoJQXJyYXkgSGFuZGxlOiAweDAwMjgKCUVycm9y
IEluZm9ybWF0aW9uIEhhbmRsZTogTm90IFByb3ZpZGVkCglUb3RhbCBXaWR0aDogOCBiaXRzCglE
YXRhIFdpZHRoOiA2NCBiaXRzCglTaXplOiBObyBNb2R1bGUgSW5zdGFsbGVkCglGb3JtIEZhY3Rv
cjogRElNTQoJU2V0OiBOb25lCglMb2NhdG9yOiBBMV9ESU1NMQoJQmFuayBMb2NhdG9yOiBBMV9C
QU5LMQoJVHlwZTogVW5rbm93bgoJVHlwZSBEZXRhaWw6IFVua25vd24KCVNwZWVkOiBVbmtub3du
CglNYW51ZmFjdHVyZXI6IEExX01hbnVmYWN0dXJlcjEKCVNlcmlhbCBOdW1iZXI6IEExX1Nlck51
bTEKCUFzc2V0IFRhZzogQTFfQXNzZXRUYWdOdW0xCglQYXJ0IE51bWJlcjogQXJyYXkxX1BhcnRO
dW1iZXIxCglSYW5rOiBVbmtub3duCglDb25maWd1cmVkIENsb2NrIFNwZWVkOiAxMzMzIE1IegoK
SGFuZGxlIDB4MDAyRCwgRE1JIHR5cGUgMTI2LCAzNSBieXRlcwpJbmFjdGl2ZQoKSGFuZGxlIDB4
MDAyRSwgRE1JIHR5cGUgMzIsIDIwIGJ5dGVzClN5c3RlbSBCb290IEluZm9ybWF0aW9uCglTdGF0
dXM6IE5vIGVycm9ycyBkZXRlY3RlZAoKSGFuZGxlIDB4MDAyRiwgRE1JIHR5cGUgNDEsIDExIGJ5
dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246ICBPbmJvYXJkIElHRAoJ
VHlwZTogVmlkZW8KCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMQoJQnVzIEFkZHJl
c3M6IDAwMDA6MDA6MDIuMAoKSGFuZGxlIDB4MDAzMCwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9u
Ym9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246ICBPbmJvYXJkIExBTgoJVHlwZTog
RXRoZXJuZXQKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMQoJQnVzIEFkZHJlc3M6
IDAwMDA6MDA6MTkuMAoKSGFuZGxlIDB4MDAzMSwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9h
cmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246ICBPbmJvYXJkIDEzOTQKCVR5cGU6IE90
aGVyCglTdGF0dXM6IEVuYWJsZWQKCVR5cGUgSW5zdGFuY2U6IDEKCUJ1cyBBZGRyZXNzOiAwMDAw
OjAzOjFjLjIKCkhhbmRsZSAweDAwMzIsIERNSSB0eXBlIDcsIDE5IGJ5dGVzCkNhY2hlIEluZm9y
bWF0aW9uCglTb2NrZXQgRGVzaWduYXRpb246IENQVSBJbnRlcm5hbCBMMQoJQ29uZmlndXJhdGlv
bjogRW5hYmxlZCwgTm90IFNvY2tldGVkLCBMZXZlbCAxCglPcGVyYXRpb25hbCBNb2RlOiBXcml0
ZSBCYWNrCglMb2NhdGlvbjogSW50ZXJuYWwKCUluc3RhbGxlZCBTaXplOiAyMjQga0IKCU1heGlt
dW0gU2l6ZTogMjI0IGtCCglTdXBwb3J0ZWQgU1JBTSBUeXBlczoKCQlVbmtub3duCglJbnN0YWxs
ZWQgU1JBTSBUeXBlOiBVbmtub3duCglTcGVlZDogVW5rbm93bgoJRXJyb3IgQ29ycmVjdGlvbiBU
eXBlOiBTaW5nbGUtYml0IEVDQwoJU3lzdGVtIFR5cGU6IE90aGVyCglBc3NvY2lhdGl2aXR5OiBP
dGhlcgoKSGFuZGxlIDB4MDAzMywgRE1JIHR5cGUgNywgMTkgYnl0ZXMKQ2FjaGUgSW5mb3JtYXRp
b24KCVNvY2tldCBEZXNpZ25hdGlvbjogQ1BVIEludGVybmFsIEwyCglDb25maWd1cmF0aW9uOiBF
bmFibGVkLCBOb3QgU29ja2V0ZWQsIExldmVsIDIKCU9wZXJhdGlvbmFsIE1vZGU6IFdyaXRlIEJh
Y2sKCUxvY2F0aW9uOiBJbnRlcm5hbAoJSW5zdGFsbGVkIFNpemU6IDIwNDgga0IKCU1heGltdW0g
U2l6ZTogMjA0OCBrQgoJU3VwcG9ydGVkIFNSQU0gVHlwZXM6CgkJVW5rbm93bgoJSW5zdGFsbGVk
IFNSQU0gVHlwZTogVW5rbm93bgoJU3BlZWQ6IFVua25vd24KCUVycm9yIENvcnJlY3Rpb24gVHlw
ZTogU2luZ2xlLWJpdCBFQ0MKCVN5c3RlbSBUeXBlOiBVbmlmaWVkCglBc3NvY2lhdGl2aXR5OiAx
Ni13YXkgU2V0LWFzc29jaWF0aXZlCgpIYW5kbGUgMHgwMDM0LCBETUkgdHlwZSA0LCA0MiBieXRl
cwpQcm9jZXNzb3IgSW5mb3JtYXRpb24KCVNvY2tldCBEZXNpZ25hdGlvbjogU09DS0VUIDAKCVR5
cGU6IENlbnRyYWwgUHJvY2Vzc29yCglGYW1pbHk6IENvcmUgaTUKCU1hbnVmYWN0dXJlcjogSW50
ZWwKCUlEOiA3OCAwNiAwMyAwMCBGRiBGQiBFQiBCRgoJU2lnbmF0dXJlOiBUeXBlIDAsIEZhbWls
eSA2LCBNb2RlbCA1NSwgU3RlcHBpbmcgOAoJRmxhZ3M6CgkJRlBVIChGbG9hdGluZy1wb2ludCB1
bml0IG9uLWNoaXApCgkJVk1FIChWaXJ0dWFsIG1vZGUgZXh0ZW5zaW9uKQoJCURFIChEZWJ1Z2dp
bmcgZXh0ZW5zaW9uKQoJCVBTRSAoUGFnZSBzaXplIGV4dGVuc2lvbikKCQlUU0MgKFRpbWUgc3Rh
bXAgY291bnRlcikKCQlNU1IgKE1vZGVsIHNwZWNpZmljIHJlZ2lzdGVycykKCQlQQUUgKFBoeXNp
Y2FsIGFkZHJlc3MgZXh0ZW5zaW9uKQoJCU1DRSAoTWFjaGluZSBjaGVjayBleGNlcHRpb24pCgkJ
Q1g4IChDTVBYQ0hHOCBpbnN0cnVjdGlvbiBzdXBwb3J0ZWQpCgkJQVBJQyAoT24tY2hpcCBBUElD
IGhhcmR3YXJlIHN1cHBvcnRlZCkKCQlTRVAgKEZhc3Qgc3lzdGVtIGNhbGwpCgkJTVRSUiAoTWVt
b3J5IHR5cGUgcmFuZ2UgcmVnaXN0ZXJzKQoJCVBHRSAoUGFnZSBnbG9iYWwgZW5hYmxlKQoJCU1D
QSAoTWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUpCgkJQ01PViAoQ29uZGl0aW9uYWwgbW92ZSBp
bnN0cnVjdGlvbiBzdXBwb3J0ZWQpCgkJUEFUIChQYWdlIGF0dHJpYnV0ZSB0YWJsZSkKCQlQU0Ut
MzYgKDM2LWJpdCBwYWdlIHNpemUgZXh0ZW5zaW9uKQoJCUNMRlNIIChDTEZMVVNIIGluc3RydWN0
aW9uIHN1cHBvcnRlZCkKCQlEUyAoRGVidWcgc3RvcmUpCgkJQUNQSSAoQUNQSSBzdXBwb3J0ZWQp
CgkJTU1YIChNTVggdGVjaG5vbG9neSBzdXBwb3J0ZWQpCgkJRlhTUiAoRlhTQVZFIGFuZCBGWFNU
T1IgaW5zdHJ1Y3Rpb25zIHN1cHBvcnRlZCkKCQlTU0UgKFN0cmVhbWluZyBTSU1EIGV4dGVuc2lv
bnMpCgkJU1NFMiAoU3RyZWFtaW5nIFNJTUQgZXh0ZW5zaW9ucyAyKQoJCVNTIChTZWxmLXNub29w
KQoJCUhUVCAoTXVsdGktdGhyZWFkaW5nKQoJCVRNIChUaGVybWFsIG1vbml0b3Igc3VwcG9ydGVk
KQoJCVBCRSAoUGVuZGluZyBicmVhayBlbmFibGVkKQoJVmVyc2lvbjogSW50ZWwoUikgQXRvbShU
TSkgQ1BVIFozNzM1RCBAIDEuMzNHSHoKCVZvbHRhZ2U6IDEuMiBWCglFeHRlcm5hbCBDbG9jazog
ODMgTUh6CglNYXggU3BlZWQ6IDI0MDAgTUh6CglDdXJyZW50IFNwZWVkOiAxMzMwIE1IegoJU3Rh
dHVzOiBQb3B1bGF0ZWQsIEVuYWJsZWQKCVVwZ3JhZGU6IFNvY2tldCBCR0ExMTU1CglMMSBDYWNo
ZSBIYW5kbGU6IDB4MDAzMgoJTDIgQ2FjaGUgSGFuZGxlOiAweDAwMzMKCUwzIENhY2hlIEhhbmRs
ZTogTm90IFByb3ZpZGVkCglTZXJpYWwgTnVtYmVyOiBOb3QgU3BlY2lmaWVkCglBc3NldCBUYWc6
IEZpbGwgQnkgT0VNCglQYXJ0IE51bWJlcjogRmlsbCBCeSBPRU0KCUNvcmUgQ291bnQ6IDQKCUNv
cmUgRW5hYmxlZDogNAoJVGhyZWFkIENvdW50OiA0CglDaGFyYWN0ZXJpc3RpY3M6CgkJNjQtYml0
IGNhcGFibGUKCkhhbmRsZSAweDAwMzUsIERNSSB0eXBlIDEzMSwgNjQgYnl0ZXMKT0VNLXNwZWNp
ZmljIFR5cGUKCUhlYWRlciBhbmQgRGF0YToKCQk4MyA0MCAzNSAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMAoJCTAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAxIDAwIDAwIDAw
IDAwIDAwIDAxIDAwCgkJMjQgMDQgMDIgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKCQkwMCAwMCAwMCAwMCA1MCAwMCAwMCAwMCA3NiA1MCA3MiA2RiAwMCAwMCAwMCAwMAoK
SGFuZGxlIDB4MDAzNiwgRE1JIHR5cGUgMTI3LCA0IGJ5dGVzCkVuZCBPZiBUYWJsZQoK
--047d7b33956d1749520520f75fb0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
