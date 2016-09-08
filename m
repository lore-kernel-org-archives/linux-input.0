From: Colin Johnstone <johnstone.colin@gmail.com>
Subject: Re: PROBLEM: i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
Date: Thu, 08 Sep 2016 18:40:35 -0400
Message-ID: <1473374435.4936.0.camel@gmail.com>
References: <CABgo8p4OPGzbezWde_s2p467YGtFSemFqxfUY9J6B-3GH4+1iQ@mail.gmail.com>
         <CAN+gG=EiFgVKdwc0J-UBDtAg2SkGqJQB9--CL7BL8ZDn7dXD7g@mail.gmail.com>
         <1473200056.6178.1.camel@gmail.com>
         <3d89b80c-d211-11ba-a3c5-a1c6e754f1e1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36584 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcIHWkk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2016 18:40:40 -0400
Received: by mail-oi0-f43.google.com with SMTP id x125so43023437oia.3
        for <linux-input@vger.kernel.org>; Thu, 08 Sep 2016 15:40:39 -0700 (PDT)
In-Reply-To: <3d89b80c-d211-11ba-a3c5-a1c6e754f1e1@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Wed, 2016-09-07 at 11:30 +0200, Benjamin Tissoires wrote:
> 
> On 09/07/2016 12:14 AM, Colin Johnstone wrote:
> > 
> > On Mon, 2016-09-05 at 12:19 +0200, Benjamin Tissoires wrote:
> > > 
> > > > 
> > > > Hi Colin,
> > > > 
> > > > On Sat, Sep 3, 2016 at 8:33 PM, Colin Johnstone
> > > > <johnstone.colin@gmail.com> wrote:
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > [1.] One line summary of the problem: Touchscreen does not
> > > > > > work,
> > > > > > dmesg
> > > > > > shows errors "i2c_hid i2c-ELAN0732:00: failed to reset
> > > > > > device",
> > > > > > "i2c_hid i2c-ELAN0732:00: can't add hid device: -61", and
> > > > > > "i2c_hid:
> > > > > > probe of i2c-ELAN0732:00 failed with error -61" occur
> > > > > > during boot.
> > > > 
> > > > -61 is -ENODATA, which is raised when we timed-out when waiting
> > > > for
> > > > the interrupt line.
> > > > 
> > > > To confirm this, please provide a dmesg from the boot with
> > > > i2c_hid.debug=1 appended to the kernel command line.
> > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > [2.] Full description of the problem/report: This is on an
> > > > > > HP Eny
> > > > > > x360
> > > > > > M6-AR004DX laptop with 7th-generation AMD FX CPU. The
> > > > > > touchscreen
> > > > > > is
> > > > > > not recognized at all; it appears the screen is using GPIO
> > > > > > interrupts
> > > > > > as I have to build with AMD GPIO support to receive these
> > > > > > errors,
> > > > > > otherwise I see a "failed to get GPIO interrupt" error.
> > > > > > 
> > > > 
> > > > So this is more likely either a failure of us retrieving the
> > > > GPIO, or
> > > > a misconfiguration of those. I'd be interested if you could
> > > > share the
> > > > output of acpidump (as root) as well.
> > > > 
> > > > Cheers,
> > > > Benjamin
> > My apologies, the previous dmesg output was incorrect. I had an
> > issue
> > with my grub config and was booting the wrong kernel build. Here's
> > the
> > correct output, with AMD GPIO support:
> 
> Thanks for the updated dmesg.
> 
> So it looks like the interrupt is never served, which leads to
> timeout while
> resetting the device.
> 
> The question now is: are we enabling the GPIO as Interrupt properly
> or is the
> bug in AMD GPIO?
> 
> Could you try applying the following patch? It should retrieve the
> information
> of level trigger from ACPI which might help (though I have no big
> hope):
> 
> ---
> 
> commit ebdb645c5cbf70c745527169c99b82c01e74231e
> Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date:   Wed Sep 7 10:59:58 2016 +0200
> 
>     HID: i2c-hid: retrieve the GPIO parameters from ACPI
>     
>     Instead of forcing the level triggers of the GPIO INT,
>     we can count on ACPI to set it up for us.
>     
>     *NOTE: this currently breaks other Int sources than GpioInt*
>     
>     Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-
> hid.c
> index d0b1355..feacd9f 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -145,7 +145,6 @@ struct i2c_hid {
>  	unsigned long		flags;		/* device
> flags */
>  
>  	wait_queue_head_t	wait;		/* For waiting
> the interrupt */
> -	struct gpio_desc	*desc;
>  	int			irq;
>  
>  	struct i2c_hid_platform_data pdata;
> @@ -819,9 +818,8 @@ static int i2c_hid_init_irq(struct i2c_client
> *client)
>  
>  	dev_dbg(&client->dev, "Requesting IRQ: %d\n", ihid->irq);
>  
> -	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
> -			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -			client->name, ihid);
> +	ret = request_threaded_irq(ihid->irq, NULL, i2c_hid_irq,
> IRQF_ONESHOT,
> +				   client->name, ihid);
>  	if (ret < 0) {
>  		dev_warn(&client->dev,
>  			"Could not register for %s interrupt, irq =
> %d,"
> @@ -1021,16 +1019,9 @@ static int i2c_hid_probe(struct i2c_client
> *client,
>  	if (client->irq > 0) {
>  		ihid->irq = client->irq;
>  	} else if (ACPI_COMPANION(&client->dev)) {
> -		ihid->desc = gpiod_get(&client->dev, NULL,
> GPIOD_IN);
> -		if (IS_ERR(ihid->desc)) {
> -			dev_err(&client->dev, "Failed to get GPIO
> interrupt\n");
> -			return PTR_ERR(ihid->desc);
> -		}
> -
> -		ihid->irq = gpiod_to_irq(ihid->desc);
> +		ihid->irq =
> acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
>  		if (ihid->irq < 0) {
> -			gpiod_put(ihid->desc);
> -			dev_err(&client->dev, "Failed to convert
> GPIO to IRQ\n");
> +			dev_err(&client->dev, "Failed to request
> IRQ\n");
>  			return ihid->irq;
>  		}
>  	}
> @@ -1108,9 +1099,6 @@ err_pm:
>  	pm_runtime_disable(&client->dev);
>  
>  err:
> -	if (ihid->desc)
> -		gpiod_put(ihid->desc);
> -
>  	i2c_hid_free_buffers(ihid);
>  	kfree(ihid);
>  	return ret;
> @@ -1134,9 +1122,6 @@ static int i2c_hid_remove(struct i2c_client
> *client)
>  	if (ihid->bufsize)
>  		i2c_hid_free_buffers(ihid);
>  
> -	if (ihid->desc)
> -		gpiod_put(ihid->desc);
> -
>  	kfree(ihid);
>  
>  	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
> 
> ---
> 
> I couldn't find a working device in your DSDT that would be using the
> GPIO from your chip
> (HPQ6007 seemed a good candidate, but it fails probing at a different
> step).
> 
> Cheers,
> Benjamin

I've applied the patches, but I'm still seeing the same errors. Dmesg
output is included below.

[    0.000000] Linux version 4.8.0-rc5-custom (colin@Masaq) (gcc
version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.2) ) #3 SMP Wed Sep
7 22:45:18 EDT 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.8.0-rc5-custom
root=/dev/mapper/ubuntu--gnome--vg-root ro quiet splash i2c_hid.debug=1
vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000086fff]
usable
[    0.000000] BIOS-e820: [mem 0x0000000000087000-0x0000000000087fff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000088000-0x000000000009ffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000bffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000def8efff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000def8f000-0x00000000df88efff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000df88f000-0x00000000dfb8efff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dfb8f000-0x00000000dfbfefff]
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dfbff000-0x00000000dfbfffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000000dfc00000-0x00000000dfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0800000-0x00000000f08fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001feffffff]
usable
[    0.000000] BIOS-e820: [mem 0x00000001ff000000-0x000000021effffff]
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xd3509018-0xd3518c57] usable ==>
usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-
0x0000000000086fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000087000-
0x0000000000087fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000088000-
0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-
0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-
0x00000000d3509017] usable
[    0.000000] reserve setup_data: [mem 0x00000000d3509018-
0x00000000d3518c57] usable
[    0.000000] reserve setup_data: [mem 0x00000000d3518c58-
0x00000000def8efff] usable
[    0.000000] reserve setup_data: [mem 0x00000000def8f000-
0x00000000df88efff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000df88f000-
0x00000000dfb8efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000dfb8f000-
0x00000000dfbfefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000dfbff000-
0x00000000dfbfffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dfc00000-
0x00000000dfffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0800000-
0x00000000f08fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-
0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-
0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-
0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-
0x00000000fed80fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-
0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff800000-
0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-
0x00000001feffffff] usable
[    0.000000] reserve setup_data: [mem 0x00000001ff000000-
0x000000021effffff] reserved
[    0.000000] efi: EFI v2.50 by INSYDE Corp.
[    0.000000] efi:  ESRT=0xdf23a4d8  ACPI
2.0=0xdfbfe014  SMBIOS=0xdf234000  PROP=0xd37a92d8 
[    0.000000] esrt: Reserving ESRT space from 0x00000000df23a4d8 to
0x00000000df23a510.
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: HP HP ENVY x360 m6 Convertible/81AA, BIOS F.10
06/29/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==>
reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1ff000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000FF800000 mask FFFFFF800000 write-protect
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000021f000000 aka 8688M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC-
UC  WB  WC  UC- WT  
[    0.000000] e820: last_pfn = 0xdfc00 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff9ed340099000] 99000 size
24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0xcf24b000, 0xcf24bfff] PGTABLE
[    0.000000] BRK [0xcf24c000, 0xcf24cfff] PGTABLE
[    0.000000] BRK [0xcf24d000, 0xcf24dfff] PGTABLE
[    0.000000] BRK [0xcf24e000, 0xcf24efff] PGTABLE
[    0.000000] BRK [0xcf24f000, 0xcf24ffff] PGTABLE
[    0.000000] BRK [0xcf250000, 0xcf250fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3db04000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000DFBFE014 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x00000000DFBBF188 0000EC (v01 HPQOEM SLIC-
MPC 00000001 HP   01000013)
[    0.000000] ACPI: FACP 0x00000000DFBF9000 00010C (v05 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: DSDT 0x00000000DFBE5000 00D7F2 (v01 HPQOEM SLIC-
MPC 00040000 ACPI 00040000)
[    0.000000] ACPI: FACS 0x00000000DFB58000 000040
[    0.000000] ACPI: UEFI 0x00000000DFBFD000 000236 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: MSDM 0x00000000DFBFC000 000055 (v03 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: ASF! 0x00000000DFBFB000 0000A5 (v32 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: BOOT 0x00000000DFBFA000 000028 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: HPET 0x00000000DFBF8000 000038 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: APIC 0x00000000DFBF7000 000090 (v03 HPQOEM SLIC-
MPC 00000001 HP   00040000)
[    0.000000] ACPI: MCFG 0x00000000DFBF6000 00003C (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: SPCR 0x00000000DFBF5000 000050 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: WDAT 0x00000000DFBF4000 00017C (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: WDRT 0x00000000DFBF3000 000047 (v01 HPQOEM
INSYDE   00000000 HP   00040000)
[    0.000000] ACPI: UEFI 0x00000000DFBE4000 000042 (v01 HPQOEM
INSYDE   00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x00000000DFBDF000 004522 (v01 HPQOEM
INSYDE   00001000 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBDE000 0009F8 (v01 HPQOEM
INSYDE   00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000DFBD5000 0087BF (v02 HPQOEM
INSYDE   00000002 MSFT 04000000)
[    0.000000] ACPI: IVRS 0x00000000DFBD4000 0000D0 (v02 HPQOEM
INSYDE   00000001 HP   00000000)
[    0.000000] ACPI: CRAT 0x00000000DFBD3000 000528 (v01 HPQOEM
INSYDE   00000001 HP   00000001)
[    0.000000] ACPI: VFCT 0x00000000DFBC3000 00FC84 (v01 HPQOEM
INSYDE   00000001 HP   31504F47)
[    0.000000] ACPI: SSDT 0x00000000DFBC2000 000482 (v01 HPQOEM
INSYDE   00001000 INTL 20130117)
[    0.000000] ACPI: TPM2 0x00000000DFBC1000 000034 (v03 HPQOEM
INSYDE   00000002 HP   01000013)
[    0.000000] ACPI: SSDT 0x00000000DFBC0000 000692 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBBD000 001492 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: SSDT 0x00000000DFBBB000 001654 (v01 HPQOEM
INSYDE   00000001 INTL 20130117)
[    0.000000] ACPI: FPDT 0x00000000DFBBA000 000044 (v01 HPQOEM SLIC-
MPC 00000002 HP   01000013)
[    0.000000] ACPI: BGRT 0x00000000DFBB9000 000038 (v01 HPQOEM
INSYDE   00000001 HP   00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-
0x00000001feffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1feff9000-0x1feffdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000086fff]
[    0.000000]   node   0: [mem 0x0000000000088000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000def8efff]
[    0.000000]   node   0: [mem 0x00000000dfbff000-0x00000000dfbfffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001feffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-
0x00000001feffffff]
[    0.000000] On node 0 totalpages: 1957678
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14207 pages used for memmap
[    0.000000]   DMA32 zone: 909200 pages, LIFO batch:31
[    0.000000]   Normal zone: 16320 pages used for memmap
[    0.000000]   Normal zone: 1044480 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type
E820_RESERVED
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000,
GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 5, version 33, address 0xfec01000,
GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low
level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-
0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00087000-
0x00087fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-
0x000bffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-
0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd3509000-
0xd3509fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd3518000-
0xd3518fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdef8f000-
0xdf88efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf88f000-
0xdfb8efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfb8f000-
0xdfbfefff]
[    0.000000] PM: Registered nosave memory: [mem 0xdfc00000-
0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-
0xf07fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0800000-
0xf08fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0900000-
0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-
0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-
0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-
0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-
0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-
0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-
0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-
0xfed80fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed81000-
0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-
0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-
0xff7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff800000-
0xffffffff]
[    0.000000] e820: [mem 0xe0000000-0xf07fffff] available for PCI
devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 36 pages/cpu @ffff9ed53ec00000 s107544
r8192 d31720 u524288
[    0.000000] pcpu-alloc: s107544 r8192 d31720 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping
on.  Total pages: 1927065
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.8.0-rc5-
custom root=/dev/mapper/ubuntu--gnome--vg-root ro quiet splash
i2c_hid.debug=1 vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA -
bailing!
[    0.000000] Memory: 7533492K/7830712K available (8599K kernel code,
1421K rwdata, 3788K rodata, 1536K init, 1392K bss, 297220K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4,
Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64,
nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1000 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2694.788 MHz processor
[    0.000025] Calibrating delay loop (skipped), value calculated using
timer frequency.. 5389.57 BogoMIPS (lpj=10779152)
[    0.000027] pid_max: default: 32768 minimum: 301
[    0.000034] ACPI: Core revision 20160422
[    0.012975] ACPI: 8 ACPI AML tables successfully acquired and loaded

[    0.022348] Security Framework initialized
[    0.022350] Yama: becoming mindful.
[    0.022363] AppArmor: AppArmor initialized
[    0.022710] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.025685] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.027172] Mount-cache hash table entries: 16384 (order: 5, 131072
bytes)
[    0.027180] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.027542] [Firmware Info]: CPU: Re-enabling disabled Topology
Extensions Support.
[    0.027549] CPU: Physical Processor ID: 0
[    0.027550] CPU: Processor Core ID: 0
[    0.027562] mce: CPU supports 7 MCE banks
[    0.027570] LVT offset 1 assigned for vector 0xf9
[    0.027579] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.027579] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512,
1GB 0
[    0.028010] Freeing SMP alternatives memory: 32K (ffffffff8d0e5000 -
ffffffff8d0ed000)
[    0.038911] ftrace: allocating 32806 entries in 129 pages
[    0.052285] smpboot: APIC(10) Converting physical 1 to logical
package 0
[    0.052287] smpboot: Max logical packages: 2
[    0.155889] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.301754] smpboot: CPU0: AMD FX-9800P RADEON R7, 12 COMPUTE CORES
4C+8G (family: 0x15, model: 0x65, stepping: 0x1)
[    0.301760] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.301766] ... version:                0
[    0.301766] ... bit width:              48
[    0.301767] ... generic registers:      6
[    0.301767] ... value mask:             0000ffffffffffff
[    0.301768] ... max period:             00007fffffffffff
[    0.301768] ... fixed-purpose events:   0
[    0.301769] ... event mask:             000000000000003f
[    0.302707] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.302819] x86: Booting SMP configuration:
[    0.302820] .... node  #0, CPUs:      #1 #2 #3
[    0.440101] x86: Booted up 1 node, 4 CPUs
[    0.440105] smpboot: Total of 4 processors activated (21507.33
BogoMIPS)
[    0.441697] devtmpfs: initialized
[    0.441810] x86/mm: Memory block size: 128MB
[    0.444184] evm: security.selinux
[    0.444185] evm: security.SMACK64
[    0.444185] evm: security.SMACK64EXEC
[    0.444185] evm: security.SMACK64TRANSMUTE
[    0.444186] evm: security.SMACK64MMAP
[    0.444186] evm: security.ima
[    0.444187] evm: security.capability
[    0.444312] PM: Registering ACPI NVS region [mem 0xdf88f000-
0xdfb8efff] (3145728 bytes)
[    0.444432] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.444507] pinctrl core: initialized pinctrl subsystem
[    0.444674] RTC time: 22:35:03, date: 09/08/16
[    0.445009] NET: Registered protocol family 16
[    0.457933] cpuidle: using governor ladder
[    0.473935] cpuidle: using governor menu
[    0.473938] PCCT header not found.
[    0.474211] Simple Boot Flag at 0x44 set to 0x80
[    0.474237] ACPI FADT declares the system doesn't support PCIe ASPM,
so disable it
[    0.474238] ACPI: bus type PCI registered
[    0.474240] acpiphp: ACPI Hot Plug PCI Controller Driver version:
0.5
[    0.474329] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.474332] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in
E820
[    0.474335] PCI: Using configuration type 1 for base access
[    0.491810] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.491812] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.493536] ACPI: Added _OSI(Module Device)
[    0.493538] ACPI: Added _OSI(Processor Device)
[    0.493539] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.493540] ACPI: Added _OSI(Processor Aggregator Device)
[    0.493750] ACPI: Executed 1 blocks of module-level executable AML
code
[    0.506165] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.509009] ACPI : EC: EC started
[    0.696170] ACPI: Interpreter enabled
[    0.696200] ACPI: (supports S0 S3 S4 S5)
[    0.696202] ACPI: Using IOAPIC for interrupt routing
[    0.696358] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.696767] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    0.697229] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    0.697627] ACPI: Power Resource [P0U2] (off)
[    0.697653] ACPI: Power Resource [P3U2] (off)
[    0.697847] ACPI: Power Resource [P0U3] (off)
[    0.697875] ACPI: Power Resource [P3U3] (off)
[    0.698687] ACPI: Power Resource [P0ST] (on)
[    0.698714] ACPI: Power Resource [P3ST] (on)
[    0.698782] ACPI: Power Resource [P0SA] (off)
[    0.698803] ACPI: Power Resource [P3SA] (off)
[    0.699214] ACPI: Power Resource [P0SD] (off)
[    0.699241] ACPI: Power Resource [P3SD] (off)
[    0.701751] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.701757] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.701901] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.701902] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.701913] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain
0000 [bus 00-3f] only partially covers this bridge
[    0.702100] PCI host bridge to bus 0000:00
[    0.702102] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7
window]
[    0.702103] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff
window]
[    0.702104] pci_bus 0000:00: root bus resource [mem 0x000a0000-
0x000bffff window]
[    0.702106] pci_bus 0000:00: root bus resource [mem 0x000c0000-
0x000c3fff window]
[    0.702106] pci_bus 0000:00: root bus resource [mem 0x000c4000-
0x000c7fff window]
[    0.702107] pci_bus 0000:00: root bus resource [mem 0x000c8000-
0x000cbfff window]
[    0.702108] pci_bus 0000:00: root bus resource [mem 0x000cc000-
0x000cffff window]
[    0.702109] pci_bus 0000:00: root bus resource [mem 0x000d0000-
0x000d3fff window]
[    0.702110] pci_bus 0000:00: root bus resource [mem 0x000d4000-
0x000d7fff window]
[    0.702111] pci_bus 0000:00: root bus resource [mem 0x000d8000-
0x000dbfff window]
[    0.702112] pci_bus 0000:00: root bus resource [mem 0x000dc000-
0x000dffff window]
[    0.702112] pci_bus 0000:00: root bus resource [mem 0x000e0000-
0x000e3fff window]
[    0.702113] pci_bus 0000:00: root bus resource [mem 0x000e4000-
0x000e7fff window]
[    0.702114] pci_bus 0000:00: root bus resource [mem 0x000e8000-
0x000ebfff window]
[    0.702115] pci_bus 0000:00: root bus resource [mem 0x000ec000-
0x000effff window]
[    0.702116] pci_bus 0000:00: root bus resource [mem 0xe0000000-
0xf7ffffff window]
[    0.702117] pci_bus 0000:00: root bus resource [mem 0xfc000000-
0xfed3ffff window]
[    0.702118] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.702126] pci 0000:00:00.0: [1022:1576] type 00 class 0x060000
[    0.702219] pci 0000:00:00.2: [1022:1577] type 00 class 0x080600
[    0.702312] pci 0000:00:01.0: [1002:9874] type 00 class 0x030000
[    0.702324] pci 0000:00:01.0: reg 0x10: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.702332] pci 0000:00:01.0: reg 0x18: [mem 0xf0000000-0xf07fffff
64bit pref]
[    0.702337] pci 0000:00:01.0: reg 0x20: [io  0x2000-0x20ff]
[    0.702342] pci 0000:00:01.0: reg 0x24: [mem 0xf0c00000-0xf0c3ffff]
[    0.702347] pci 0000:00:01.0: reg 0x30: [mem 0xfffe0000-0xffffffff
pref]
[    0.702381] pci 0000:00:01.0: supports D1 D2
[    0.702382] pci 0000:00:01.0: PME# supported from D1 D2 D3hot
[    0.702451] pci 0000:00:01.1: [1002:9840] type 00 class 0x040300
[    0.702462] pci 0000:00:01.1: reg 0x10: [mem 0xf0c60000-0xf0c63fff
64bit]
[    0.702509] pci 0000:00:01.1: supports D1 D2
[    0.702563] pci 0000:00:02.0: [1022:157b] type 00 class 0x060000
[    0.702636] pci 0000:00:02.2: [1022:157c] type 01 class 0x060400
[    0.702697] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.702734] pci 0000:00:02.2: System wakeup disabled by ACPI
[    0.702765] pci 0000:00:02.3: [1022:157c] type 01 class 0x060400
[    0.702824] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.702859] pci 0000:00:02.3: System wakeup disabled by ACPI
[    0.702889] pci 0000:00:03.0: [1022:157b] type 00 class 0x060000
[    0.702971] pci 0000:00:08.0: [1022:1578] type 00 class 0x108000
[    0.702982] pci 0000:00:08.0: reg 0x10: [mem 0xf0c40000-0xf0c5ffff
64bit pref]
[    0.702986] pci 0000:00:08.0: reg 0x18: [mem 0xf0900000-0xf09fffff]
[    0.702990] pci 0000:00:08.0: reg 0x1c: [mem 0xf0c6f000-0xf0c6ffff]
[    0.702998] pci 0000:00:08.0: reg 0x24: [mem 0xf0c6a000-0xf0c6bfff]
[    0.703068] pci 0000:00:09.0: [1022:157d] type 00 class 0x060000
[    0.703136] pci 0000:00:09.2: [1022:157a] type 00 class 0x040300
[    0.703144] pci 0000:00:09.2: reg 0x10: [mem 0xf0c64000-0xf0c67fff]
[    0.703180] pci 0000:00:09.2: PME# supported from D0 D3hot D3cold
[    0.703255] pci 0000:00:10.0: [1022:7914] type 00 class 0x0c0330
[    0.703275] pci 0000:00:10.0: reg 0x10: [mem 0xf0c68000-0xf0c69fff
64bit]
[    0.703371] pci 0000:00:10.0: PME# supported from D0 D3hot D3cold
[    0.703412] pci 0000:00:10.0: System wakeup disabled by ACPI
[    0.703445] pci 0000:00:11.0: [1022:7904] type 00 class 0x010601
[    0.703459] pci 0000:00:11.0: reg 0x10: [io  0x2118-0x211f]
[    0.703467] pci 0000:00:11.0: reg 0x14: [io  0x2124-0x2127]
[    0.703475] pci 0000:00:11.0: reg 0x18: [io  0x2110-0x2117]
[    0.703483] pci 0000:00:11.0: reg 0x1c: [io  0x2120-0x2123]
[    0.703491] pci 0000:00:11.0: reg 0x20: [io  0x2100-0x210f]
[    0.703499] pci 0000:00:11.0: reg 0x24: [mem 0xf0c6c000-0xf0c6c3ff]
[    0.703535] pci 0000:00:11.0: PME# supported from D3hot
[    0.703594] pci 0000:00:12.0: [1022:7908] type 00 class 0x0c0320
[    0.704335] pci 0000:00:12.0: reg 0x10: [mem 0xf0c6d000-0xf0c6d0ff]
[    0.707829] pci 0000:00:12.0: supports D1 D2
[    0.707830] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot
D3cold
[    0.707869] pci 0000:00:12.0: System wakeup disabled by ACPI
[    0.707904] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.708025] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.708152] pci 0000:00:18.0: [1022:1570] type 00 class 0x060000
[    0.708223] pci 0000:00:18.1: [1022:1571] type 00 class 0x060000
[    0.708289] pci 0000:00:18.2: [1022:1572] type 00 class 0x060000
[    0.708363] pci 0000:00:18.3: [1022:1573] type 00 class 0x060000
[    0.708435] pci 0000:00:18.4: [1022:1574] type 00 class 0x060000
[    0.708544] pci 0000:00:18.5: [1022:1575] type 00 class 0x060000
[    0.708667] pci 0000:01:00.0: [10ec:5229] type 00 class 0xff0000
[    0.708684] pci 0000:01:00.0: reg 0x10: [mem 0xf0b00000-0xf0b00fff]
[    0.708802] pci 0000:01:00.0: supports D1 D2
[    0.708803] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.720051] pci 0000:00:02.2: PCI bridge to [bus 01]
[    0.720060] pci 0000:00:02.2:   bridge window [mem 0xf0b00000-
0xf0bfffff]
[    0.720178] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000
[    0.720217] pci 0000:02:00.0: reg 0x10: [mem 0xf0a00000-0xf0a01fff
64bit]
[    0.720399] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.732063] pci 0000:00:02.3: PCI bridge to [bus 02]
[    0.732072] pci 0000:00:02.3:   bridge window [mem 0xf0a00000-
0xf0afffff]
[    0.732386] ACPI: IRQ 7 override to edge, high
[    0.732773] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.732826] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.732867] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.732917] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.732963] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.733001] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.733038] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.733074] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0,
disabled.
[    0.757688] ACPI : EC: EC stopped
[    0.757728] ACPI : EC: GPE = 0x3, I/O: command/status = 0x66, data =
0x62
[    0.757729] ACPI : EC: EC started
[    0.944369] vgaarb: setting as boot device: PCI:0000:00:01.0
[    0.944371] vgaarb: device added:
PCI:0000:00:01.0,decodes=io+mem,owns=io+mem,locks=none
[    0.944378] vgaarb: loaded
[    0.944379] vgaarb: bridge control possible 0000:00:01.0
[    0.944533] SCSI subsystem initialized
[    0.944674] libata version 3.00 loaded.
[    0.944694] ACPI: bus type USB registered
[    0.944712] usbcore: registered new interface driver usbfs
[    0.944721] usbcore: registered new interface driver hub
[    0.944745] usbcore: registered new device driver usb
[    0.983201] PCI: Using ACPI for IRQ routing
[    0.985181] PCI: pci_cache_line_size set to 64 bytes
[    0.985246] e820: reserve RAM buffer [mem 0x00087000-0x0008ffff]
[    0.985247] e820: reserve RAM buffer [mem 0xd3509018-0xd3ffffff]
[    0.985248] e820: reserve RAM buffer [mem 0xdef8f000-0xdfffffff]
[    0.985249] e820: reserve RAM buffer [mem 0xdfc00000-0xdfffffff]
[    0.985249] e820: reserve RAM buffer [mem 0x1ff000000-0x1ffffffff]
[    0.985361] NetLabel: Initializing
[    0.985362] NetLabel:  domain hash size = 128
[    0.985362] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.985375] NetLabel:  unlabeled traffic allowed by default
[    0.986398] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.986403] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.988597] clocksource: Switched to clocksource hpet
[    0.996065] VFS: Disk quotas dquot_6.6.0
[    0.996106] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.996252] AppArmor: AppArmor Filesystem Enabled
[    0.996323] pnp: PnP ACPI init
[    0.996518] system 00:00: [mem 0xfec00000-0xfec01fff] could not be
reserved
[    0.996519] system 00:00: [mem 0xfee00000-0xfee00fff] has been
reserved
[    0.996521] system 00:00: [mem 0xf0800000-0xf08fffff] has been
reserved
[    0.996524] system 00:00: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.996637] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00
(active)
[    0.996674] system 00:02: [io  0x0400-0x04cf] has been reserved
[    0.996675] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.996676] system 00:02: [io  0x04d6] has been reserved
[    0.996677] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.996678] system 00:02: [io  0x0c14] has been reserved
[    0.996679] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.996680] system 00:02: [io  0x0c6c] has been reserved
[    0.996681] system 00:02: [io  0x0c6f] has been reserved
[    0.996682] system 00:02: [io  0x0cd0-0x0cdb] has been reserved
[    0.996684] system 00:02: Plug and Play ACPI device, IDs PNP0c02
(active)
[    0.996734] system 00:03: [mem 0x000e0000-0x000fffff] could not be
reserved
[    0.996735] system 00:03: [mem 0xff800000-0xffffffff] has been
reserved
[    0.996737] system 00:03: Plug and Play ACPI device, IDs PNP0c01
(active)
[    0.996792] pnp 00:04: Plug and Play ACPI device, IDs HPQ8001
PNP0303 (active)
[    0.996815] pnp 00:05: Plug and Play ACPI device, IDs SYN321b
SYN1e00 SYN0002 PNP0f13 (active)
[    0.997212] pnp: PnP ACPI: found 6 devices
[    1.040016] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    1.040026] pci 0000:00:01.0: can't claim BAR 6 [mem 0xfffe0000-
0xffffffff pref]: no compatible bridge window
[    1.040059] pci 0000:00:01.0: BAR 6: assigned [mem 0xf0c80000-
0xf0c9ffff pref]
[    1.040063] pci 0000:00:02.2: PCI bridge to [bus 01]
[    1.040067] pci 0000:00:02.2:   bridge window [mem 0xf0b00000-
0xf0bfffff]
[    1.040073] pci 0000:00:02.3: PCI bridge to [bus 02]
[    1.040076] pci 0000:00:02.3:   bridge window [mem 0xf0a00000-
0xf0afffff]
[    1.040083] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.040085] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.040086] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
window]
[    1.040086] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff
window]
[    1.040087] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff
window]
[    1.040088] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff
window]
[    1.040089] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff
window]
[    1.040090] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff
window]
[    1.040091] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff
window]
[    1.040092] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff
window]
[    1.040092] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff
window]
[    1.040093] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff
window]
[    1.040094] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff
window]
[    1.040095] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff
window]
[    1.040096] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff
window]
[    1.040097] pci_bus 0000:00: resource 19 [mem 0xe0000000-0xf7ffffff
window]
[    1.040098] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfed3ffff
window]
[    1.040099] pci_bus 0000:01: resource 1 [mem 0xf0b00000-0xf0bfffff]
[    1.040100] pci_bus 0000:02: resource 1 [mem 0xf0a00000-0xf0afffff]
[    1.040135] NET: Registered protocol family 2
[    1.040370] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    1.040576] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes)
[    1.040986] TCP: Hash tables configured (established 65536 bind
65536)
[    1.041054] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.041105] UDP-Lite hash table entries: 4096 (order: 5, 131072
bytes)
[    1.041221] NET: Registered protocol family 1
[    1.041249] pci 0000:00:01.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    1.065144] PCI: CLS 64 bytes, default 64
[    1.065218] Trying to unpack rootfs image as initramfs...
[    1.594404] Freeing initrd memory: 37852K (ffff9ed37db04000 -
ffff9ed37fffb000)
[    1.594460] AMD-Vi: IOMMU performance counters supported
[    1.594640] pci 0000:00:00.2: can't derive routing for PCI INT A
[    1.594641] pci 0000:00:00.2: PCI INT A: not connected
[    1.594855] iommu: Adding device 0000:00:01.0 to group 0
[    1.594917] iommu: Using direct mapping for device 0000:00:01.0
[    1.594948] iommu: Adding device 0000:00:01.1 to group 0
[    1.594994] iommu: Adding device 0000:00:02.0 to group 1
[    1.595008] iommu: Adding device 0000:00:02.2 to group 1
[    1.595022] iommu: Adding device 0000:00:02.3 to group 1
[    1.595071] iommu: Adding device 0000:00:03.0 to group 2
[    1.595125] iommu: Adding device 0000:00:08.0 to group 3
[    1.595180] iommu: Adding device 0000:00:09.0 to group 4
[    1.595193] iommu: Adding device 0000:00:09.2 to group 4
[    1.595242] iommu: Adding device 0000:00:10.0 to group 5
[    1.595291] iommu: Adding device 0000:00:11.0 to group 6
[    1.595340] iommu: Adding device 0000:00:12.0 to group 7
[    1.595396] iommu: Adding device 0000:00:14.0 to group 8
[    1.595410] iommu: Adding device 0000:00:14.3 to group 8
[    1.595484] iommu: Adding device 0000:00:18.0 to group 9
[    1.595498] iommu: Adding device 0000:00:18.1 to group 9
[    1.595512] iommu: Adding device 0000:00:18.2 to group 9
[    1.595525] iommu: Adding device 0000:00:18.3 to group 9
[    1.595538] iommu: Adding device 0000:00:18.4 to group 9
[    1.595552] iommu: Adding device 0000:00:18.5 to group 9
[    1.595568] iommu: Adding device 0000:01:00.0 to group 1
[    1.595586] iommu: Adding device 0000:02:00.0 to group 1
[    1.596274] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.596275] AMD-Vi:  Extended features:  PPR NX GT IA GA PC
[    1.596279] AMD-Vi: Interrupt remapping enabled
[    1.596710] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.598098] perf: AMD NB counters detected
[    1.598477] AMD Power PMU detected
[    1.598482] LVT offset 0 assigned for vector 0x400
[    1.598537] perf: AMD IBS detected (0x000007ff)
[    1.598542] perf: amd_iommu: Detected. (0 banks, 0 counters/bank)
[    1.598634] Scanning for low memory corruption every 60 seconds
[    1.599071] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.599105] audit: initializing netlink subsys (disabled)
[    1.599134] audit: type=2000 audit(1473374104.372:1): initialized
[    1.599462] Initialise system trusted keyrings
[    1.600120] workingset: timestamp_bits=40 max_order=21
bucket_order=0
[    1.601637] zbud: loaded
[    1.601942] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.602631] fuse init (API version 7.25)
[    1.602846] Key type big_key registered
[    1.605687] Key type asymmetric registered
[    1.605689] Asymmetric key parser 'x509' registered
[    1.605768] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 248)
[    1.605823] io scheduler noop registered
[    1.605824] io scheduler deadline registered (default)
[    1.605833] io scheduler cfq registered
[    1.606664] pcieport 0000:00:02.2: Signaling PME through PCIe PME
interrupt
[    1.606666] pci 0000:01:00.0: Signaling PME through PCIe PME
interrupt
[    1.606669] pcie_pme 0000:00:02.2:pcie001: service driver pcie_pme
loaded
[    1.606688] pcieport 0000:00:02.3: Signaling PME through PCIe PME
interrupt
[    1.606690] pci 0000:02:00.0: Signaling PME through PCIe PME
interrupt
[    1.606692] pcie_pme 0000:00:02.3:pcie001: service driver pcie_pme
loaded
[    1.606696] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.606699] pciehp: PCI Express Hot Plug Controller Driver version:
0.4
[    1.606726] efifb: probing for efifb
[    1.606742] efifb: framebuffer at 0xe0000000, using 8100k, total
8100k
[    1.606742] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.606743] efifb: scrolling: redraw
[    1.606744] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.610052] Console: switching to colour frame buffer device 240x67
[    1.613193] fb0: EFI VGA frame buffer device
[    1.613297] ACPI: AC Adapter [ADP1] (off-line)
[    1.613349] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.613353] ACPI: Power Button [PWRB]
[    1.613392] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
[    1.613407] ACPI: Lid Switch [LID0]
[    1.613437] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.613438] ACPI: Power Button [PWRF]
[    1.618720] thermal LNXTHERM:00: registered as thermal_zone0
[    1.618723] ACPI: Thermal Zone [TZS0] (65 C)
[    1.618933] thermal LNXTHERM:01: registered as thermal_zone1
[    1.618934] ACPI: Thermal Zone [TZS1] (51 C)
[    1.618995] GHES: HEST is not enabled!
[    1.619309] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.623059] ACPI: Battery Slot [BAT0] (battery present)
[    1.625466] Linux agpgart interface v0.103
[    1.636210] brd: module loaded
[    1.638147] loop: module loaded
[    1.638451] libphy: Fixed MDIO Bus: probed
[    1.638452] tun: Universal TUN/TAP device driver, 1.6
[    1.638452] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.638753] PPP generic driver version 2.4.2
[    1.638810] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
Driver
[    1.638813] ehci-pci: EHCI PCI platform driver
[    1.639028] ehci-pci 0000:00:12.0: EHCI Host Controller
[    1.639035] ehci-pci 0000:00:12.0: new USB bus registered, assigned
bus number 1
[    1.639046] ehci-pci 0000:00:12.0: debug port 2
[    1.639095] ehci-pci 0000:00:12.0: irq 18, io mem 0xf0c6d000
[    1.652907] ehci-pci 0000:00:12.0: USB 2.0 started, EHCI 1.00
[    1.652989] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002
[    1.652990] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.652992] usb usb1: Product: EHCI Host Controller
[    1.652993] usb usb1: Manufacturer: Linux 4.8.0-rc5-custom ehci_hcd
[    1.652994] usb usb1: SerialNumber: 0000:00:12.0
[    1.653207] hub 1-0:1.0: USB hub found
[    1.653215] hub 1-0:1.0: 2 ports detected
[    1.653388] ehci-platform: EHCI generic platform driver
[    1.653417] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.653457] ohci-pci: OHCI PCI platform driver
[    1.653469] ohci-platform: OHCI generic platform driver
[    1.653477] uhci_hcd: USB Universal Host Controller Interface driver
[    1.653601] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.653606] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 2
[    1.653824] xhci_hcd 0000:00:10.0: hcc params 0x014040c3 hci version
0x100 quirks 0x00000410
[    1.654018] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002
[    1.654019] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.654020] usb usb2: Product: xHCI Host Controller
[    1.654021] usb usb2: Manufacturer: Linux 4.8.0-rc5-custom xhci-hcd
[    1.654022] usb usb2: SerialNumber: 0000:00:10.0
[    1.654318] hub 2-0:1.0: USB hub found
[    1.654328] hub 2-0:1.0: 4 ports detected
[    1.654518] xhci_hcd 0000:00:10.0: xHCI Host Controller
[    1.654521] xhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 3
[    1.660729] usb usb3: We don't know the algorithms for LPM for this
host, disabling LPM.
[    1.660747] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0003
[    1.660748] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.660757] usb usb3: Product: xHCI Host Controller
[    1.660758] usb usb3: Manufacturer: Linux 4.8.0-rc5-custom xhci-hcd
[    1.660759] usb usb3: SerialNumber: 0000:00:10.0
[    1.660918] hub 3-0:1.0: USB hub found
[    1.660927] hub 3-0:1.0: 4 ports detected
[    1.661209] i8042: PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    1.667711] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.667714] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.668054] mousedev: PS/2 mouse device common for all mice
[    1.668235] rtc_cmos 00:01: RTC can wake from S4
[    1.668347] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.668377] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram,
hpet irqs
[    1.668383] i2c /dev entries driver
[    1.668446] device-mapper: uevent: version 1.0.3
[    1.668521] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
initialised: dm-devel@redhat.com
[    1.668592] ledtrig-cpu: registered to indicate activity on CPUs
[    1.668593] EFI Variables Facility v0.08 2004-May-17
[    1.678011] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    1.713077] NET: Registered protocol family 10
[    1.713573] NET: Registered protocol family 17
[    1.713585] Key type dns_resolver registered
[    1.714203] microcode: CPU0: patch_level=0x06006113
[    1.714213] microcode: CPU1: patch_level=0x06006113
[    1.714219] microcode: CPU2: patch_level=0x06006113
[    1.714225] microcode: CPU3: patch_level=0x06006113
[    1.714271] microcode: Microcode Update Driver: v2.01 <tigran@aivazi
an.fsnet.co.uk>, Peter Oruba
[    1.714436] registered taskstats version 1
[    1.714440] Loading compiled-in X.509 certificates
[    1.718120] Loaded X.509 cert 'Build time autogenerated kernel key:
5915b196fb118f5f2b98a65b68125e0130265a40'
[    1.718160] zswap: loaded using pool lzo/zbud
[    1.740624] Key type trusted registered
[    1.743321] Key type encrypted registered
[    1.743326] AppArmor: AppArmor sha1 policy hashing enabled
[    1.743329] ima: No TPM chip found, activating TPM-bypass!
[    1.743362] evm: HMAC attrs: 0x1
[    1.743661]   Magic number: 0:982:602
[    1.743772] rtc_cmos 00:01: setting system clock to 2016-09-08
22:35:04 UTC (1473374104)
[    1.743945] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.744124] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.744124] EDD information not available.
[    1.744221] PM: Hibernation image not present or could not be
loaded.
[    1.745784] Freeing unused kernel memory: 1536K (ffffffff8cf65000 -
ffffffff8d0e5000)
[    1.745787] Write protecting the kernel read-only data: 14336k
[    1.746739] Freeing unused kernel memory: 1624K (ffff9ed40e86a000 -
ffff9ed40ea00000)
[    1.747556] Freeing unused kernel memory: 308K (ffff9ed40edb3000 -
ffff9ed40ee00000)
[    1.771911] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.772011] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.772027] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.772045] random: systemd-udevd: uninitialized urandom read (16
bytes read)
[    1.773239] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.773292] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.775611] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.775694] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.775716] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.775820] random: udevadm: uninitialized urandom read (16 bytes
read)
[    1.827428] FUJITSU Extended Socket Network Device Driver - version
1.1 - Copyright (c) 2015 FUJITSU LIMITED
[    1.830399] hidraw: raw HID events driver (C) Jiri Kosina
[    1.834967] ACPI: Video Device [VGA] (multi-head: yes  rom:
no  post: no)
[    1.835007] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness
[    1.835327] acpi device:00: registered as cooling_device4
[    1.835394] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    1.872205] wmi: Mapper loaded
[    1.895383] [drm] Initialized drm 1.1.0 20060810
[    1.897434] ahci 0000:00:11.0: version 3.0
[    1.897653] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 1 ports 6
Gbps 0x1 impl SATA mode
[    1.897656] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo
pmp fbs pio slum part 
[    1.900730] scsi host0: ahci
[    1.900871] ata1: SATA max UDMA/133 abar m1024@0xf0c6c000 port
0xf0c6c100 irq 19
[    1.911317] rtsx_pci 0000:01:00.0: rtsx_pci_acquire_irq: pcr->msi_en 
= 1, pci->irq = 226
[    1.931017] [drm] amdgpu kernel modesetting enabled.
[    1.934501] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.940352] Found CRAT image with size=1320
[    1.940356] Parsing CRAT table with 1 nodes
[    1.940358] Found CU entry in CRAT table with proximity_domain=0
caps=0
[    1.940359] CU CPU: cores=4 id_base=16
[    1.940360] Found CU entry in CRAT table with proximity_domain=0
caps=0
[    1.940360] CU GPU: simds=40 id_base=-2147483648
[    1.940361] Found memory entry in CRAT table with proximity_domain=0
[    1.940362] Found cache entry in CRAT table with processor_id=16
[    1.940363] Found cache entry in CRAT table with processor_id=16
[    1.940365] Found cache entry in CRAT table with processor_id=16
[    1.940365] Found cache entry in CRAT table with processor_id=17
[    1.940366] Found cache entry in CRAT table with processor_id=18
[    1.940366] Found cache entry in CRAT table with processor_id=18
[    1.940367] Found cache entry in CRAT table with processor_id=18
[    1.940367] Found cache entry in CRAT table with processor_id=19
[    1.940368] Found TLB entry in CRAT table (not processing)
[    1.940368] Found TLB entry in CRAT table (not processing)
[    1.940369] Found TLB entry in CRAT table (not processing)
[    1.940369] Found TLB entry in CRAT table (not processing)
[    1.940369] Found TLB entry in CRAT table (not processing)
[    1.940370] Found TLB entry in CRAT table (not processing)
[    1.940370] Found TLB entry in CRAT table (not processing)
[    1.940371] Found TLB entry in CRAT table (not processing)
[    1.940371] Found TLB entry in CRAT table (not processing)
[    1.940372] Found TLB entry in CRAT table (not processing)
[    1.940372] Creating topology SYSFS entries
[    1.940394] Finished initializing topology ret=0
[    1.940422] kfd kfd: Initialized module
[    1.940846] checking generic (e0000000 7e9000) vs hw (e0000000
10000000)
[    1.940849] fb: switching to amdgpudrmfb from EFI VGA
[    1.940900] Console: switching to colour dummy device 80x25
[    1.941564] [drm] initializing kernel modesetting (CARRIZO
0x1002:0x9874 0x103C:0x81AA 0xC8).
[    1.941586] [drm] register mmio base: 0xF0C00000
[    1.941587] [drm] register mmio size: 262144
[    1.941595] [drm] doorbell mmio base: 0xF0000000
[    1.941596] [drm] doorbell mmio size: 8388608
[    1.941608] [drm] UVD is enabled in physical mode
[    1.941615] [drm] ACPI VFCT contains a BIOS for 00:01.0 1002:9874,
size 64512
[    1.941655] ATOM BIOS: CARRIZO
[    1.942037] amdgpu 0000:00:01.0: VRAM: 512M 0x0000000000000000 -
0x000000001FFFFFFF (512M used)
[    1.942039] amdgpu 0000:00:01.0: GTT: 1024M 0x0000000020000000 -
0x000000005FFFFFFF
[    1.942041] [drm] Detected VRAM RAM=512M, BAR=256M
[    1.942042] [drm] RAM width 64bits UNKNOWN
[    1.943003] [TTM] Zone  kernel: Available graphics memory: 3845720
kiB
[    1.943005] [TTM] Zone   dma32: Available graphics memory: 2097152
kiB
[    1.943006] [TTM] Initializing pool allocator
[    1.943013] [TTM] Initializing DMA pool allocator
[    1.943061] [drm] amdgpu: 512M of VRAM memory ready
[    1.943063] [drm] amdgpu: 1024M of GTT memory ready.
[    1.943090] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.944297] [drm] PCIE GART of 1024M enabled (table at
0x0000000000040000).
[    1.944354] [drm] Supports vblank timestamp caching Rev 2
(21.10.2013).
[    1.944355] [drm] Driver supports precise vblank timestamp query.
[    1.944432] amdgpu 0000:00:01.0: amdgpu: using MSI.
[    1.944463] [drm] amdgpu: irq initialized.
[    1.944474] [drm] amdgpu: dpm initialized
[    1.948833] [drm] amdgpu atom DIG backlight initialized
[    1.948839] [drm] AMDGPU Display Connectors
[    1.948840] [drm] Connector 0:
[    1.948841] [drm]   eDP-1
[    1.948842] [drm]   HPD1
[    1.948844] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a
0x486b 0x486b
[    1.948845] [drm]   Encoders:
[    1.948846] [drm]     LCD1: INTERNAL_UNIPHY
[    1.948846] [drm] Connector 1:
[    1.948847] [drm]   HDMI-A-1
[    1.948848] [drm]   HPD2
[    1.948849] [drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e
0x486f 0x486f
[    1.948850] [drm]   Encoders:
[    1.948850] [drm]     DFP1: INTERNAL_UNIPHY
[    1.950961] amdgpu 0000:00:01.0: fence driver on ring 0 use gpu addr
0x0000000020000010, cpu addr 0xffff9ed52d08a010
[    1.952261] amdgpu 0000:00:01.0: fence driver on ring 1 use gpu addr
0x0000000020000020, cpu addr 0xffff9ed52d08a020
[    1.954571] amdgpu 0000:00:01.0: fence driver on ring 2 use gpu addr
0x0000000020000030, cpu addr 0xffff9ed52d08a030
[    1.959171] amdgpu 0000:00:01.0: fence driver on ring 3 use gpu addr
0x0000000020000040, cpu addr 0xffff9ed52d08a040
[    1.959994] AVX2 version of gcm_enc/dec engaged.
[    1.959995] AES CTR mode by8 optimization enabled
[    1.960976] amdgpu 0000:00:01.0: fence driver on ring 4 use gpu addr
0x0000000020000050, cpu addr 0xffff9ed52d08a050
[    1.962617] amdgpu 0000:00:01.0: fence driver on ring 5 use gpu addr
0x0000000020000060, cpu addr 0xffff9ed52d08a060
[    1.965534] amdgpu 0000:00:01.0: fence driver on ring 6 use gpu addr
0x0000000020000070, cpu addr 0xffff9ed52d08a070
[    1.966461] amdgpu 0000:00:01.0: fence driver on ring 7 use gpu addr
0x0000000020000080, cpu addr 0xffff9ed52d08a080
[    1.966535] amdgpu 0000:00:01.0: fence driver on ring 8 use gpu addr
0x0000000020000090, cpu addr 0xffff9ed52d08a090
[    1.966728] amdgpu 0000:00:01.0: fence driver on ring 9 use gpu addr
0x00000000200000a0, cpu addr 0xffff9ed52d08a0a0
[    1.966771] amdgpu 0000:00:01.0: fence driver on ring 10 use gpu
addr 0x00000000200000b0, cpu addr 0xffff9ed52d08a0b0
[    1.966960] [drm] Found UVD firmware Version: 1.80 Family ID: 11
[    1.967772] amdgpu 0000:00:01.0: fence driver on ring 11 use gpu
addr 0x0000000000293ac0, cpu addr 0xffffb88081440ac0
[    1.967942] [drm] Found VCE firmware Version: 50.17 Binary ID: 3
[    1.968102] amdgpu 0000:00:01.0: fence driver on ring 12 use gpu
addr 0x00000000200000d0, cpu addr 0xffff9ed52d08a0d0
[    1.968836] amdgpu 0000:00:01.0: fence driver on ring 13 use gpu
addr 0x00000000200000e0, cpu addr 0xffff9ed52d08a0e0
[    1.974606] [drm] ring test on 0 succeeded in 8 usecs
[    1.974986] [drm] ring test on 1 succeeded in 20 usecs
[    1.975017] [drm] ring test on 2 succeeded in 15 usecs
[    1.975028] [drm] ring test on 3 succeeded in 4 usecs
[    1.975035] [drm] ring test on 4 succeeded in 2 usecs
[    1.975040] [drm] ring test on 5 succeeded in 2 usecs
[    1.975048] [drm] ring test on 6 succeeded in 3 usecs
[    1.975054] [drm] ring test on 7 succeeded in 2 usecs
[    1.975062] [drm] ring test on 8 succeeded in 3 usecs
[    1.975105] [drm] ring test on 9 succeeded in 4 usecs
[    1.975111] [drm] ring test on 10 succeeded in 3 usecs
[    1.980698] usb 1-1: new high-speed USB device number 2 using ehci-
pci
[    2.001048] [drm] ring test on 11 succeeded in 1 usecs
[    2.001051] [drm] UVD initialized successfully.
[    2.129104] usb 1-1: New USB device found, idVendor=0438,
idProduct=7900
[    2.129108] usb 1-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.129369] hub 1-1:1.0: USB hub found
[    2.129457] hub 1-1:1.0: 4 ports detected
[    2.200204] [drm] ring test on 12 succeeded in 13 usecs
[    2.200212] [drm] ring test on 13 succeeded in 2 usecs
[    2.200212] [drm] VCE initialized successfully.
[    2.214364] amdgpu 0000:00:01.0: SMC Failed to send Message.
[    2.380712] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.382348] ata1.00: ATA-9: HGST HTS721010A9E630, JB0OA3T0, max
UDMA/133
[    2.382351] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    2.384075] ata1.00: configured for UDMA/133
[    2.384302] scsi 0:0:0:0: Direct-Access     ATA      HGST
HTS721010A9 A3T0 PQ: 0 ANSI: 5
[    2.416785] usb 1-1.1: new full-speed USB device number 3 using
ehci-pci
[    2.535744] usb 1-1.1: New USB device found, idVendor=8087,
idProduct=0a2a
[    2.535748] usb 1-1.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.616799] usb 1-1.2: new full-speed USB device number 4 using
ehci-pci
[    2.624772] tsc: Refined TSC clocksource calibration: 2694.940 MHz
[    2.624780] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x26d8925c510, max_idle_ns: 440795289566 ns
[    2.735971] usb 1-1.2: New USB device found, idVendor=0483,
idProduct=91d1
[    2.735975] usb 1-1.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    2.735977] usb 1-1.2: Product: ST_SENSOR_HUB
[    2.735980] usb 1-1.2: Manufacturer: STMicroelectronics
[    2.735982] usb 1-1.2: SerialNumber: ST_SENSOR_HUB
[    2.752283] usbcore: registered new interface driver usbhid
[    2.752284] usbhid: USB HID core driver
[    2.832810] usb 1-1.3: new high-speed USB device number 5 using
ehci-pci
[    2.914183] [drm] fb mappable at 0xE0614000
[    2.914184] [drm] vram apper at 0xE0000000
[    2.914185] [drm] size 8294400
[    2.914186] [drm] fb depth is 24
[    2.914187] [drm]    pitch is 7680
[    2.914330] fbcon: amdgpudrmfb (fb0) is primary device
[    2.957742] usb 1-1.3: New USB device found, idVendor=04f2,
idProduct=b56d
[    2.957745] usb 1-1.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.957747] usb 1-1.3: Product: HP Wide Vision HD
[    2.957749] usb 1-1.3: Manufacturer: Chicony Electronics Co.,Ltd.
[    4.281223] clocksource: Switched to clocksource tsc
[    4.285323] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/932 GiB)
[    4.285327] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    4.285398] sd 0:0:0:0: [sda] Write Protect is off
[    4.285402] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.285435] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.285559] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.315287]  sda: sda1 sda2 sda3
[    4.315734] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.456529] random: fast init done
[    5.687787] Console: switching to colour frame buffer device 240x67
[    5.695999] amdgpu 0000:00:01.0: fb0: amdgpudrmfb frame buffer
device
[    5.709513] [drm] ib test on ring 0 succeeded
[    5.709673] [drm] ib test on ring 1 succeeded
[    5.709740] [drm] ib test on ring 2 succeeded
[    5.709834] [drm] ib test on ring 3 succeeded
[    5.709868] [drm] ib test on ring 4 succeeded
[    5.709910] [drm] ib test on ring 5 succeeded
[    5.709954] [drm] ib test on ring 6 succeeded
[    5.709991] [drm] ib test on ring 7 succeeded
[    5.710052] [drm] ib test on ring 8 succeeded
[    5.710076] [drm] ib test on ring 9 succeeded
[    5.710099] [drm] ib test on ring 10 succeeded
[    5.710483] [drm] ib test on ring 11 succeeded
[    5.712352] [drm] ib test on ring 12 succeeded
[    5.909413] psmouse serio1: synaptics: queried max coordinates: x
[..5636], y [..4634]
[    5.936843] psmouse serio1: synaptics: queried min coordinates: x
[1360..], y [1298..]
[    5.990306] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3114, fw
id: 1805562
[    6.024577] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6
[    6.633688] kfd kfd: Allocated 3944480 bytes on gart for
device(1002:9874)
[    6.633707] amdkfd: adding doorbell packet type capability
[    6.633843] kfd kfd: added device (1002:9874)
[    6.633851] [drm] Initialized amdgpu 3.3.0 20150101 for 0000:00:01.0
on minor 0
[   10.733884] random: crng init done
[   12.469960] NET: Registered protocol family 38
[   13.420149] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   14.572164] systemd[1]: systemd 229 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   14.572486] systemd[1]: Detected architecture x86-64.
[   14.579812] systemd[1]: Set hostname to <Masaq>.
[   15.474861] systemd[1]: Listening on fsck to fsckd communication
Socket.
[   15.474975] systemd[1]: Listening on Syslog Socket.
[   15.474998] systemd[1]: Reached target User and Group Name Lookups.
[   15.475048] systemd[1]: Listening on Device-mapper event daemon
FIFOs.
[   15.475108] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[   15.475147] systemd[1]: Listening on udev Kernel Socket.
[   15.475182] systemd[1]: Listening on LVM2 poll daemon socket.
[   16.541809] lp: driver loaded but no devices found
[   16.581105] ppdev: user-space parallel port driver
[   17.604456] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
[   17.678150] systemd-journald[1077]: Received request to flush
runtime journal from PID 1
[   18.113406] kvm: Nested Virtualization enabled
[   18.113409] kvm: Nested Paging enabled
[   18.316730] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[   18.316732] piix4_smbus 0000:00:14.0: Using register 0x2e for SMBus
port selection
[   18.352216] tpm_crb MSFT0101:00: can't request region for resource
[mem 0xdfb89000-0xdfb8cfff]
[   18.352226] tpm_crb: probe of MSFT0101:00 failed with error -16
[   18.383925] AMD0020:00: ttyS4 at MMIO 0xfedc6000 (irq = 10,
base_baud = 3000000) is a 16550A
[   18.414260] i2c_hid i2c-ELAN0732:00: Fetching the HID descriptor
[   18.414263] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=01 00
[   18.415217] i2c_hid i2c-ELAN0732:00: HID Descriptor: 1e 00 00 01 31
02 02 00 03 00 43 00 04 00 ff 00 05 00 06 00 f3 04 28 2b 04 11 00 00 00
00
[   18.415833] i2c_hid i2c-ELAN0732:00: entering i2c_hid_parse
[   18.415836] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   18.415837] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   18.415839] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   18.416014] i2c_hid i2c-ELAN0732:00: resetting...
[   18.416016] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   18.416181] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   18.488264] shpchp: Standard Hot Plug PCI Controller Driver version:
0.4
[   18.559699] hp_accel: laptop model unknown, using default axes
configuration
[   18.576054] lis3lv02d: unknown sensor type 0x0
[   18.576068] hp_accel: probe of HPQ6007:00 failed with error -22
[   18.620947] Initializing HPQ6001 module
[   18.621081] input: HP Wireless hotkeys as
/devices/virtual/input/input7
[   19.086840] Intel(R) Wireless WiFi driver for Linux
[   19.086842] Copyright(c) 2003- 2015 Intel Corporation
[   19.170246] snd_hda_intel 0000:00:01.1: Force to non-snoop mode
[   19.174948] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-24.ucode failed with error -2
[   19.174981] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-23.ucode failed with error -2
[   19.175983] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-22.ucode failed with error -2
[   19.178066] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-21.ucode failed with error -2
[   19.181873] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.1/sound/card0/input8
[   19.183928] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-20.ucode failed with error -2
[   19.184810] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-19.ucode failed with error -2
[   19.184973] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-18.ucode failed with error -2
[   19.184989] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-
7265D-17.ucode failed with error -2
[   19.267431] snd_hda_codec_conexant hdaudioC1D0: CX8200: BIOS auto-
probing.
[   19.267965] snd_hda_codec_conexant hdaudioC1D0: autoconfig for
CX8200: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[   19.267967] snd_hda_codec_conexant hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   19.267969] snd_hda_codec_conexant hdaudioC1D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[   19.267971] snd_hda_codec_conexant hdaudioC1D0:    mono:
mono_out=0x0
[   19.267971] snd_hda_codec_conexant hdaudioC1D0:    inputs:
[   19.267974] snd_hda_codec_conexant hdaudioC1D0:      Internal
Mic=0x1a
[   19.267975] snd_hda_codec_conexant hdaudioC1D0:      Mic=0x19
[   19.272372] input: HD-Audio Generic Mic as
/devices/pci0000:00/0000:00:09.2/sound/card1/input9
[   19.272875] input: HD-Audio Generic Headphone as
/devices/pci0000:00/0000:00:09.2/sound/card1/input10
[   19.406037] iwlwifi 0000:02:00.0: loaded firmware version
16.242414.0 op_mode iwlmvm
[   20.062958] input: HP WMI hotkeys as /devices/virtual/input/input11
[   20.193601] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band
Wireless AC 7265, REV=0x210
[   20.195755] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   20.195913] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   20.407036] ieee80211 phy0: Selected rate control algorithm 'iwl-
mvm-rs'
[   20.519982] iwlwifi 0000:02:00.0 wlo1: renamed from wlan0
[   20.782132] Adding 7831548k swap on /dev/mapper/ubuntu--gnome--vg-
swap_1.  Priority:-1 extents:1 across:7831548k FS
[   21.253833] Bluetooth: Core ver 2.21
[   21.253902] NET: Registered protocol family 31
[   21.253903] Bluetooth: HCI device and connection manager initialized
[   21.253913] Bluetooth: HCI socket layer initialized
[   21.253919] Bluetooth: L2CAP socket layer initialized
[   21.253934] Bluetooth: SCO socket layer initialized
[   21.483595] usbcore: registered new interface driver btusb
[   21.499012] Bluetooth: hci0: read Intel version: 370810011003110e23
[   21.499016] Bluetooth: hci0: Intel device is already patched. patch
num: 23
[   21.505242] EXT4-fs (sda2): mounting ext2 file system using the ext4
subsystem
[   21.589068] EXT4-fs (sda2): mounted filesystem without journal.
Opts: (null)
[   21.838942] media: Linux media interface: v0.10
[   21.885216] Linux video capture interface: v2.00
[   22.250357] uvcvideo: Found UVC 1.00 device HP Wide Vision HD
(04f2:b56d)
[   22.258683] uvcvideo 1-1.3:1.0: Entity type for entity Extension 4
was not initialized!
[   22.258688] uvcvideo 1-1.3:1.0: Entity type for entity Extension 3
was not initialized!
[   22.258691] uvcvideo 1-1.3:1.0: Entity type for entity Processing 2
was not initialized!
[   22.258694] uvcvideo 1-1.3:1.0: Entity type for entity Camera 1 was
not initialized!
[   22.258851] input: HP Wide Vision HD as
/devices/pci0000:00/0000:00:12.0/usb1/1-1/1-1.3/1-1.3:1.0/input/input12
[   22.258985] usbcore: registered new interface driver uvcvideo
[   22.258987] USB Video Class driver (1.1.1)
[   23.490060] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   23.490064] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   23.490070] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   23.490073] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   23.696094] audit: type=1400 audit(1473374126.445:2):
apparmor="STATUS" operation="profile_load" name="/usr/lib/snapd/snap-
confine" pid=2643 comm="apparmor_parser"
[   23.699010] audit: type=1400 audit(1473374126.449:3):
apparmor="STATUS" operation="profile_load" name="/usr/lib/libvirt/virt-
aa-helper" pid=2642 comm="apparmor_parser"
[   23.732490] audit: type=1400 audit(1473374126.481:4):
apparmor="STATUS" operation="profile_load" name="/sbin/dhclient"
pid=2639 comm="apparmor_parser"
[   23.732502] audit: type=1400 audit(1473374126.481:5):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=2639
comm="apparmor_parser"
[   23.732509] audit: type=1400 audit(1473374126.481:6):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=2639
comm="apparmor_parser"
[   23.732516] audit: type=1400 audit(1473374126.481:7):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/connman/scripts/dhclient-script" pid=2639
comm="apparmor_parser"
[   23.743224] audit: type=1400 audit(1473374126.493:8):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/cups-
browsed" pid=2646 comm="apparmor_parser"
[   23.745973] audit: type=1400 audit(1473374126.497:9):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/cups/backend/cups-pdf" pid=2647 comm="apparmor_parser"
[   23.745982] audit: type=1400 audit(1473374126.497:10):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd"
pid=2647 comm="apparmor_parser"
[   23.745989] audit: type=1400 audit(1473374126.497:11):
apparmor="STATUS" operation="profile_load"
name="/usr/sbin/cupsd//third_party" pid=2647 comm="apparmor_parser"
[   24.513978] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   24.513981] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   24.513984] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   24.514401] i2c_hid i2c-ELAN0732:00: resetting...
[   24.514406] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   24.514696] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   24.928666] cgroup: new mount options do not match the existing
superblock, will be ignored
[   27.581530] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   27.581533] Bluetooth: BNEP filters: protocol multicast
[   27.581551] Bluetooth: BNEP socket layer initialized
[   29.634471] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   29.634475] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   29.634482] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   29.634485] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   30.658422] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   30.658427] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   30.658430] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   30.658772] i2c_hid i2c-ELAN0732:00: resetting...
[   30.658778] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   30.659035] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   32.280541] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   32.282581] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   32.282846] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   32.348689] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   32.348955] iwlwifi 0000:02:00.0: L1 Disabled - LTR Disabled
[   32.364410] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   33.574916] IPv6: ADDRCONF(NETDEV_UP): wlo1: link is not ready
[   34.058282] NET: Registered protocol family 24
[   34.243920] l2tp_core: L2TP core driver, V2.0
[   34.257864] l2tp_netlink: L2TP netlink interface
[   34.276570] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   35.778594] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   35.778599] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   35.778607] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   35.778611] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   36.802739] i2c_hid i2c-ELAN0732:00: i2c_hid_hwreset
[   36.802743] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   36.802747] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
08
[   36.803109] i2c_hid i2c-ELAN0732:00: resetting...
[   36.803115] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 00
01
[   36.803298] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: waiting...
[   36.968341] wlo1: authenticate with c4:04:15:42:11:9a
[   36.973289] wlo1: send auth to c4:04:15:42:11:9a (try 1/3)
[   36.975992] wlo1: authenticated
[   36.978876] wlo1: associate with c4:04:15:42:11:9a (try 1/3)
[   36.982706] wlo1: RX AssocResp from c4:04:15:42:11:9a (capab=0x411
status=0 aid=2)
[   36.983694] wlo1: associated
[   36.983752] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[   38.045698] ip_tables: (C) 2000-2006 Netfilter Core Team
[   38.352363] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   38.999964] Ebtables v2.0 registered
[   40.437225] bridge: automatic filtering via arp/ip/ip6tables has
been deprecated. Update your scripts to load br_netfilter if you need
this.
[   40.511070] virbr0: port 1(virbr0-nic) entered blocking state
[   40.511073] virbr0: port 1(virbr0-nic) entered disabled state
[   40.511243] device virbr0-nic entered promiscuous mode
[   41.210735] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   41.536578] virbr0: port 1(virbr0-nic) entered blocking state
[   41.536582] virbr0: port 1(virbr0-nic) entered listening state
[   41.879153] virbr0: port 1(virbr0-nic) entered disabled state
[   41.883018] device virbr0-nic left promiscuous mode
[   41.883047] virbr0: port 1(virbr0-nic) entered disabled state
[   41.923098] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: finished.
[   41.923103] i2c_hid i2c-ELAN0732:00: failed to reset device.
[   41.923111] i2c_hid i2c-ELAN0732:00: i2c_hid_set_power
[   41.923115] i2c_hid i2c-ELAN0732:00: __i2c_hid_command: cmd=05 00 01
08
[   42.947127] i2c_hid i2c-ELAN0732:00: can't add hid device: -61
[   42.963207] i2c_hid: probe of i2c-ELAN0732:00 failed with error -61
[   47.879965] Bluetooth: RFCOMM TTY layer initialized
[   47.879976] Bluetooth: RFCOMM socket layer initialized
[   47.879983] Bluetooth: RFCOMM ver 1.11
[   55.372500] show_signal_msg: 42 callbacks suppressed
[   55.372505] gnome-shell[3229]: segfault at 10 ip 00007efd5dfb8352 sp
00007ffe462b9040 error 4 in amdgpu_dri.so[7efd5d0be000+28a9000]
[   56.785532] Non-volatile memory driver v1.3
[   58.334502] gnome-shell[3568]: segfault at 10 ip 00007f7f65fb8352 sp
00007fffea5498b0 error 4 in amdgpu_dri.so[7f7f650be000+28a9000]
