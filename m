From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v5 3/9] Input: goodix - reset device at init
Date: Wed, 09 Sep 2015 18:57:48 +0200
Message-ID: <1441817868.27328.26.camel@hadess.net>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
	 <1441636583-14188-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441636583-14188-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2015-09-07 at 17:36 +0300, Irina Tirdea wrote:
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

This throws:
Sep 09 18:22:47 winbook kernel: Goodix-TS i2c-GDIX1001:00: ID 9271, version: 1040
Sep 09 18:22:47 winbook kernel: ------------[ cut here ]------------
Sep 09 18:22:47 winbook kernel: WARNING: CPU: 3 PID: 3298 at drivers/pinctrl/intel/pinctrl-baytrail.c:338 byt_gpio_direction_output+0x97/0xa0()
Sep 09 18:22:47 winbook kernel: Potential Error: Setting GPIO with direct_irq_en to output
Sep 09 18:22:47 winbook kernel: Modules linked in:
Sep 09 18:22:47 winbook kernel:  goodix_backport(OE+) hid_logitech_hidpp hid_logitech_dj cdc_mbim cdc_wdm cdc_ncm usbnet mii uvcvideo videobuf2_vmalloc videobuf2_core videobuf2_memops v4l2_common snd_usb_audio v
Sep 09 18:22:47 winbook kernel:  snd_soc_sst_byt_rt5640_mach coretemp snd_soc_sst_baytrail_pcm iTCO_vendor_support snd_soc_sst_ipc kvm_intel snd_soc_sst_dsp gpio_keys kvm snd_intel_sst_acpi snd_intel_sst_core sn
Sep 09 18:22:47 winbook kernel:  lockd grace sunrpc i915 mmc_block i2c_algo_bit drm_kms_helper drm sdhci_acpi video sdhci mmc_core i2c_hid [last unloaded: goodix]
Sep 09 18:22:47 winbook kernel: CPU: 3 PID: 3298 Comm: insmod Tainted: G           OE   4.2.0-0.rc3.git4.2.fc22.i686 #1
Sep 09 18:22:47 winbook kernel: Hardware name: WinBook TW100/TW100, BIOS 1.02.00 08/25/2014
Sep 09 18:22:47 winbook kernel:  c0d439a7 bb4c1aaf 00000000 de2f7bb4 c0aa23b9 de2f7bf4 de2f7be4 c045c677
Sep 09 18:22:47 winbook kernel:  c0cbe3b8 de2f7c14 00000ce2 c0cbe3f4 00000152 c073cd87 c073cd87 f7c5e0b8
Sep 09 18:22:47 winbook kernel:  f4bb309c f7c5e0b0 de2f7c00 c045c6ee 00000009 de2f7bf4 c0cbe3b8 de2f7c14
Sep 09 18:22:47 winbook kernel: Call Trace:
Sep 09 18:22:47 winbook kernel:  [<c0aa23b9>] dump_stack+0x41/0x52
Sep 09 18:22:47 winbook kernel:  [<c045c677>] warn_slowpath_common+0x87/0xc0
Sep 09 18:22:47 winbook kernel:  [<c073cd87>] ? byt_gpio_direction_output+0x97/0xa0
Sep 09 18:22:47 winbook kernel:  [<c073cd87>] ? byt_gpio_direction_output+0x97/0xa0
Sep 09 18:22:47 winbook kernel:  [<c045c6ee>] warn_slowpath_fmt+0x3e/0x60
Sep 09 18:22:47 winbook kernel:  [<c073cd87>] byt_gpio_direction_output+0x97/0xa0
Sep 09 18:22:47 winbook kernel:  [<c073ccf0>] ? byt_gpio_irq_handler+0xc0/0xc0
Sep 09 18:22:47 winbook kernel:  [<c073f6f9>] _gpiod_direction_output_raw+0x59/0x1c0
Sep 09 18:22:47 winbook kernel:  [<c073f8ca>] gpiod_direction_output+0x2a/0x50
Sep 09 18:22:47 winbook kernel:  [<c04bc74b>] ? msleep+0x2b/0x40
Sep 09 18:22:47 winbook kernel:  [<f935a87e>] goodix_reset+0x3e/0x90 [goodix_backport]
Sep 09 18:22:47 winbook kernel:  [<f935b1ae>] goodix_ts_probe+0x27e/0x5a0 [goodix_backport]
Sep 09 18:22:47 winbook kernel:  [<c090ea01>] i2c_device_probe+0x101/0x1b0
Sep 09 18:22:47 winbook kernel:  [<c0613a05>] ? sysfs_create_link+0x25/0x50
Sep 09 18:22:47 winbook kernel:  [<f935af30>] ? goodix_configure_dev+0x1e0/0x1e0 [goodix_backport]

Which is the same error I had previously:
https://lkml.org/lkml/2015/6/30/434

I was testing this on a Onda v975w, but I'm now testing it on a WinBook
TW100.

<snip>
> +/*
> + * ACPI table specifies gpio pins in this order: first rst pin and
> + * then interrupt pin.
> + */
> +static const struct dmi_system_id goodix_rst_pin_first[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		.ident = "WinBook TW100",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "WinBook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW100")
> +		}
> +	},

The DSDT for the WinBook one is here:
https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl

For reference, the DSDT for the Onda, the tablet I tested this on some
months ago:
https://bugzilla.kernel.org/attachment.cgi?id=149331

Cheers
