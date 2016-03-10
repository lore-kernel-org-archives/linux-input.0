From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Thu, 10 Mar 2016 21:11:35 +0000
Message-ID: <CA+V1LzotRUczT=G5tGHATpBOUc8PK00gPMfQPejEWESoxpd74g@mail.gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36701 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbcCJVLh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 16:11:37 -0500
Received: by mail-qk0-f170.google.com with SMTP id s68so39900446qkh.3
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2016 13:11:36 -0800 (PST)
In-Reply-To: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi ALL,
Results of testing my code on Chuwi Vi10 rev11 with different
combinations of define
#TS_I2C_BUS  - i2c bus (i2c-dev)
#define TS_I2C_ADDR  - chip address on i2c bus
#define CTP_RST_PORT 393 - wakeup gpio. Actually have chosen 393
because it is the same as it was on Chuwi Vi8. Also may be for Chuwi
Vi10 could be used 391, 392 gpios. All 391-393 gpios by setting them
to 0 and then to 1 do the same - turn on\off screen.


Results of testing: dmesg output:
Procedure of testing: modprobe i2c-dev gpio && insmod myicn,ko

i2c-3 0x30:   (last lines looks strange like battery is resided on this address)


-- Logs begin at Thu 2016-03-10 17:49:10 UTC, end at Thu 2016-03-10
17:49:58 UTC. --
Mar 10 17:49:56 archiso kernel: device: 'i2c-0': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:i2c-0
Mar 10 17:49:56 archiso kernel: device: 'i2c-1': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:i2c-1
Mar 10 17:49:56 archiso kernel: device: 'i2c-2': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:i2c-2
Mar 10 17:49:56 archiso kernel: device: 'i2c-3': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:i2c-3
Mar 10 17:49:56 archiso kernel: device: 'i2c-4': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:i2c-4
Mar 10 17:49:56 archiso kernel: device class 'mtd': registering
Mar 10 17:49:56 archiso kernel: device: 'mtd': device_add
Mar 10 17:49:56 archiso kernel: PM: Adding info for No Bus:mtd
Mar 10 17:49:56 archiso kernel: bus: 'platform': add driver gpio-nand
Mar 10 17:49:57 archiso kernel:
                                INIT icn MODULE,func ts_init
                                 get pwr gpio in func ts_init
Mar 10 17:49:57 archiso kernel: ------------[ cut here ]------------
Mar 10 17:49:57 archiso kernel: WARNING: CPU: 2 PID: 714 at
drivers/pinctrl/intel/pinctrl-baytrail.c:214
byt_gpio_request+0xaf/0xe0()
Mar 10 17:49:57 archiso kernel: Modules linked in: myicn(O+) gpio nand
nand_ecc nand_ids mtd i2c_dev intel_rapl intel_soc_dts_thermal
intel_soc_dts_iosf intel_powerclamp iTCO_wdt iTCO_vendor_support
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
i915 brcmfmac uio_pdrv_genirq uio joydev cfg80211 i2c_algo_bit
input_leds rfkill drm_kms_helper brcmutil efi_pstore
snd_intel_sst_acpi snd_intel_sst_core snd_soc_sst_mfld_platform
efivars drm pcspkr dw_dmac dw_dmac_core snd_soc_core snd_compress
evdev myicn_ts_acpi(O) intel_gtt kxcjk_1013 i2c_hid snd_pcm_dmaengine
industrialio_triggered_buffer mei_txe kfifo_buf syscopyarea
sysfillrect snd_pcm industrialio mei sysimgblt tpm_tis snd_timer snd
lpc_ich battery fb_sys_fops tpm i2c_designware_platform
Mar 10 17:49:57 archiso kernel:  i2c_designware_core ac acpi_pad
soundcore spi_pxa2xx_platform i2c_core snd_soc_sst_acpi processor
thermal 8250_dw sch_fq_codel nfs lockd grace sunrpc fscache ip_tables
x_tables overlay squashfs isofs nls_iso8859_1 nls_cp437 vfat fat
sd_mod hid_generic usbhid hid uas usb_storage scsi_mod xhci_pci
xhci_hcd usbcore crc32c_intel usb_common button serio wmi video
sdhci_acpi sdhci led_class loop
Mar 10 17:49:57 archiso kernel: CPU: 2 PID: 714 Comm: insmod Tainted:
G        W  O    4.4.2-2-ARCH #2
Mar 10 17:49:57 archiso kernel: Hardware name: ilife S165/BYT-PF02,
BIOS J1D_S165C_206 10/29/2014
Mar 10 17:49:57 archiso kernel:  0000000000000000 00000000bde94ada
ffff8800736efb68 ffffffff812b324b
Mar 10 17:49:57 archiso kernel:  0000000000000000 ffff8800736efba0
ffffffff8105dc53 ffffc9000036a0f0
Mar 10 17:49:57 archiso kernel:  ffff88007c056e18 000000000000000b
0000000000000002 ffff88007c056f20
Mar 10 17:49:57 archiso kernel: Call Trace:
Mar 10 17:49:57 archiso kernel:  [<ffffffff812b324b>] dump_stack+0x4b/0x70
Mar 10 17:49:57 archiso kernel:  [<ffffffff8105dc53>]
warn_slowpath_common+0x83/0xc0
Mar 10 17:49:57 archiso kernel:  [<ffffffff8105ddab>]
warn_slowpath_null+0x1b/0x20
Mar 10 17:49:57 archiso kernel:  [<ffffffff812e683f>] byt_gpio_request+0xaf/0xe0
Mar 10 17:49:57 archiso kernel:  [<ffffffffa00d8000>] ? 0xffffffffa00d8000
Mar 10 17:49:57 archiso kernel:  [<ffffffff812e7004>] __gpiod_request+0x74/0x100
Mar 10 17:49:57 archiso kernel:  [<ffffffff812e9dad>] gpiod_request+0x5d/0x100
Mar 10 17:49:57 archiso kernel:  [<ffffffff812e9101>] ? gpio_to_desc+0x91/0xe0
Mar 10 17:49:57 archiso kernel:  [<ffffffff812ea8c4>] gpio_request+0x34/0x40
Mar 10 17:49:57 archiso kernel:  [<ffffffffa00d803c>]
ts_init+0x3c/0x1000 [myicn]
Mar 10 17:49:57 archiso kernel:  [<ffffffff810003e2>] do_one_initcall+0xb2/0x1f0
Mar 10 17:49:57 archiso kernel:  [<ffffffff8118cd52>] ? __vunmap+0x92/0xf0
Mar 10 17:49:57 archiso kernel:  [<ffffffff811aabce>] ? kfree+0x14e/0x160
Mar 10 17:49:57 archiso kernel:  [<ffffffff8114966f>] do_init_module+0x5f/0x1f0
Mar 10 17:49:57 archiso kernel:  [<ffffffff810e7d01>] load_module+0x2231/0x28a0
Mar 10 17:49:57 archiso kernel:  [<ffffffff810e4b10>] ?
symbol_put_addr+0x50/0x50
Mar 10 17:49:57 archiso kernel:  [<ffffffff811cdec1>] ? kernel_read+0x51/0x80
Mar 10 17:49:57 archiso kernel:  [<ffffffff810e85cd>] SyS_finit_module+0xbd/0xf0
Mar 10 17:49:57 archiso kernel:  [<ffffffff8157a217>]
entry_SYSCALL_64_fastpath+0x12/0x66
Mar 10 17:49:57 archiso kernel: ---[ end trace dcb1f480a2bec481 ]---
Mar 10 17:49:57 archiso kernel: byt_gpio INT33FC:01: pin 11 forcibly
re-configured as GPIO
Mar 10 17:49:58 archiso kernel: ==icn85xx ts_init 280 at i2cbus: 3!!!!!!!!
Mar 10 17:49:58 archiso kernel: device: '3-0030': device_add
Mar 10 17:49:58 archiso kernel: bus: 'i2c': add device 3-0030
Mar 10 17:49:58 archiso kernel: PM: Adding info for i2c:3-0030
Mar 10 17:49:58 archiso kernel: bus: 'i2c': add driver chipone-ts
Mar 10 17:49:58 archiso kernel: bus: 'i2c': driver_probe_device:
matched device 3-0030 with driver chipone-ts
Mar 10 17:49:58 archiso kernel: bus: 'i2c': really_probe: probing
driver chipone-ts with device 3-0030
Mar 10 17:49:58 archiso kernel: chipone-ts 3-0030: no default pinctrl state
Mar 10 17:49:58 archiso kernel: devices_kset: Moving 3-0030 to end of list
Mar 10 17:49:58 archiso kernel:
                                hello from i2cprobe,icn85xx_ts_probe
                                ====icn85xx_ts_probe begin=====.
Mar 10 17:49:58 archiso kernel:
                                begin icn85xx_iic_test
                                 BEGIN test another way of reading CurrFW ver
                                 CurrFW ver=43360
                                 END test another way of reading
CurrFW verFrom icn85xx_read_reg -  addr: 0xa: 0x42
Mar 10 17:49:58 archiso kernel:
                                Begin read fw ver from iictestFrom
icn85xx_read_reg -  addr: 0xc: 0x7
Mar 10 17:49:58 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestFrom
icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 17:49:58 archiso kernel:
                                End read IC subver from iictestiic
test error! 1 in icn85xx_iic_test
Mar 10 17:49:58 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x11
Mar 10 17:49:58 archiso kernel:
                                Begin read fw ver from iictestFrom
icn85xx_read_reg -  addr: 0xc: 0x28
Mar 10 17:49:58 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestFrom
icn85xx_read_reg -  addr: 0xb: 0x8
Mar 10 17:49:58 archiso kernel:
                                End read IC subver from iictestiic
test error! 2 in icn85xx_iic_test
Mar 10 17:49:58 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x4a
Mar 10 17:49:58 archiso kernel:
                                Begin read fw ver from iictestFrom
icn85xx_read_reg -  addr: 0xc: 0x74
Mar 10 17:49:58 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestFrom
icn85xx_read_reg -  addr: 0xb: 0x4
Mar 10 17:49:58 archiso kernel:
                                End read IC subver from iictestiic
test error! 3 in icn85xx_iic_test
Mar 10 17:49:58 archiso kernel:
                                end icn85xx_iic_testiic communication ok: 0x0
Mar 10 17:49:58 archiso kernel:
                                Bye from i2cprobe,icn85xx_ts_probe
Mar 10 17:49:58 archiso kernel: driver: 'chipone-ts': driver_bound:
bound to device '3-0030'
Mar 10 17:49:58 archiso kernel: bus: 'i2c': really_probe: bound device
3-0030 to driver chipone-ts
Mar 10 17:49:58 archiso kernel: PM: Moving acpi:PNP0C0A:01 to end of list
Mar 10 17:49:58 archiso kernel: acpi PNP0C0A:01: Retrying from deferred list
Mar 10 17:49:58 archiso kernel: bus: 'acpi': driver_probe_device:
matched device PNP0C0A:01 with driver battery
Mar 10 17:49:58 archiso kernel: bus: 'acpi': really_probe: probing
driver battery with device PNP0C0A:01
Mar 10 17:49:58 archiso kernel: battery PNP0C0A:01: no default pinctrl state
Mar 10 17:49:58 archiso kernel: devices_kset: Moving PNP0C0A:01 to end of list
Mar 10 17:49:58 archiso kernel: acpi PNP0C0A:01: Driver battery
requests probe deferral

-----------------
i2c-4 0x48  - this is etalon because Android and Windows using these
params!!! And :( failed to probe!
-----------------

Mar 10 20:53:53 archiso kernel: i2c /dev entries driver
Mar 10 20:53:53 archiso kernel: device class 'i2c-dev': registering
Mar 10 20:53:53 archiso kernel: device: 'i2c-0': device_add
Mar 10 20:53:53 archiso kernel: PM: Adding info for No Bus:i2c-0
Mar 10 20:53:53 archiso kernel: device: 'i2c-1': device_add
Mar 10 20:53:53 archiso kernel: PM: Adding info for No Bus:i2c-1
Mar 10 20:53:53 archiso kernel: device: 'i2c-2': device_add
Mar 10 20:53:53 archiso kernel: PM: Adding info for No Bus:i2c-2
Mar 10 20:53:53 archiso kernel: device: 'i2c-3': device_add
Mar 10 20:53:53 archiso kernel: PM: Adding info for No Bus:i2c-3
Mar 10 20:53:53 archiso kernel: device: 'i2c-4': device_add
Mar 10 20:53:53 archiso kernel: PM: Adding info for No Bus:i2c-4
Mar 10 20:53:55 archiso kernel: device class 'mtd': registering
Mar 10 20:53:55 archiso kernel: device: 'mtd': device_add
Mar 10 20:53:55 archiso kernel: PM: Adding info for No Bus:mtd
Mar 10 20:53:55 archiso kernel: bus: 'platform': add driver gpio-nand
Mar 10 20:53:58 archiso kernel:
                                INIT icn MODULE,func ts_init
                                 get pwr gpio in func ts_init
Mar 10 20:53:58 archiso kernel: ------------[ cut here ]------------
Mar 10 20:53:58 archiso kernel: WARNING: CPU: 2 PID: 696 at
drivers/pinctrl/intel/pinctrl-baytrail.c:214
byt_gpio_request+0xaf/0xe0()
Mar 10 20:53:58 archiso kernel: Modules linked in: myicn(O+) gpio nand
nand_ecc nand_ids mtd i2c_dev intel_rapl intel_soc_dts_thermal
intel_soc_dts_iosf intel_powerclamp iTCO_wdt coretemp
iTCO_vendor_support kvm_intel brcmfmac i915 kvm cfg80211 irqbypass
crct10dif_pclmul crc32_pclmul i2c_algo_bit aesni_intel aes_x86_64
joydev lrw rfkill gf128mul input_leds efi_pstore brcmutil glue_helper
ablk_helper drm_kms_helper uio_pdrv_genirq efivars uio cryptd pcspkr
myicn_ts_acpi(O) drm kxcjk_1013 industrialio_triggered_buffer
kfifo_buf thermal i2c_hid evdev industrialio snd_intel_sst_acpi
dw_dmac snd_intel_sst_core snd_soc_sst_mfld_platform dw_dmac_core
battery intel_gtt mei_txe syscopyarea sysfillrect sysimgblt
fb_sys_fops i2c_designware_platform snd_soc_core snd_compress
snd_pcm_dmaengine ac acpi_pad tpm_tis snd_pcm tpm spi_pxa2xx_platform
Mar 10 20:53:58 archiso kernel:  lpc_ich i2c_designware_core mei
snd_timer snd i2c_core processor soundcore 8250_dw snd_soc_sst_acpi
sch_fq_codel nfs lockd grace sunrpc fscache ip_tables x_tables overlay
squashfs isofs nls_iso8859_1 nls_cp437 vfat fat sd_mod hid_generic
usbhid hid uas usb_storage scsi_mod xhci_pci xhci_hcd usbcore
crc32c_intel usb_common button serio video wmi sdhci_acpi sdhci
led_class loop
Mar 10 20:53:58 archiso kernel: CPU: 2 PID: 696 Comm: insmod Tainted:
G        W  O    4.4.2-2-ARCH #2
Mar 10 20:53:58 archiso kernel: Hardware name: ilife S165/BYT-PF02,
BIOS J1D_S165C_206 10/29/2014
Mar 10 20:53:58 archiso kernel:  0000000000000000 00000000deb7bf9d
ffff88007799fb68 ffffffff812b324b
Mar 10 20:53:58 archiso kernel:  0000000000000000 ffff88007799fba0
ffffffff8105dc53 ffffc9000036a0f0
Mar 10 20:53:58 archiso kernel:  ffff88007c056e18 000000000000000b
0000000000000002 ffff88007c056f20
Mar 10 20:53:58 archiso kernel: Call Trace:
Mar 10 20:53:58 archiso kernel:  [<ffffffff812b324b>] dump_stack+0x4b/0x70
Mar 10 20:53:58 archiso kernel:  [<ffffffff8105dc53>]
warn_slowpath_common+0x83/0xc0
Mar 10 20:53:58 archiso kernel:  [<ffffffff8105ddab>]
warn_slowpath_null+0x1b/0x20
Mar 10 20:53:58 archiso kernel:  [<ffffffff812e683f>] byt_gpio_request+0xaf/0xe0
Mar 10 20:53:58 archiso kernel:  [<ffffffffa002a000>] ? 0xffffffffa002a000
Mar 10 20:53:58 archiso kernel:  [<ffffffff812e7004>] __gpiod_request+0x74/0x100
Mar 10 20:53:58 archiso kernel:  [<ffffffff812e9dad>] gpiod_request+0x5d/0x100
Mar 10 20:53:58 archiso kernel:  [<ffffffff812e9101>] ? gpio_to_desc+0x91/0xe0
Mar 10 20:53:58 archiso kernel:  [<ffffffff812ea8c4>] gpio_request+0x34/0x40
Mar 10 20:53:58 archiso kernel:  [<ffffffffa002a03c>]
ts_init+0x3c/0x1000 [myicn]
Mar 10 20:53:58 archiso kernel:  [<ffffffff810003e2>] do_one_initcall+0xb2/0x1f0
Mar 10 20:53:58 archiso kernel:  [<ffffffff8114966f>] do_init_module+0x5f/0x1f0
Mar 10 20:53:58 archiso kernel:  [<ffffffff810e7d01>] load_module+0x2231/0x28a0
Mar 10 20:53:58 archiso kernel:  [<ffffffff810e4b10>] ?
symbol_put_addr+0x50/0x50
Mar 10 20:53:58 archiso kernel:  [<ffffffff811cdec1>] ? kernel_read+0x51/0x80
Mar 10 20:53:58 archiso kernel:  [<ffffffff810e85cd>] SyS_finit_module+0xbd/0xf0
Mar 10 20:53:58 archiso kernel:  [<ffffffff8157a217>]
entry_SYSCALL_64_fastpath+0x12/0x66
Mar 10 20:53:58 archiso kernel: ---[ end trace 50506b677151cf1f ]---
Mar 10 20:53:58 archiso kernel: byt_gpio INT33FC:01: pin 11 forcibly
re-configured as GPIO
Mar 10 20:53:59 archiso kernel: ==icn85xx ts_init 280 at i2cbus: 4!!!!!!!!
Mar 10 20:53:59 archiso kernel: device: '4-0048': device_add
Mar 10 20:53:59 archiso kernel: bus: 'i2c': add device 4-0048
Mar 10 20:53:59 archiso kernel: PM: Adding info for i2c:4-0048
Mar 10 20:53:59 archiso kernel: bus: 'i2c': add driver chipone-ts
Mar 10 20:53:59 archiso kernel: bus: 'i2c': driver_probe_device:
matched device 4-0048 with driver chipone-ts
Mar 10 20:53:59 archiso kernel: bus: 'i2c': really_probe: probing
driver chipone-ts with device 4-0048
Mar 10 20:53:59 archiso kernel: chipone-ts 4-0048: no default pinctrl state
Mar 10 20:53:59 archiso kernel: devices_kset: Moving 4-0048 to end of list
Mar 10 20:53:59 archiso kernel:
                                hello from i2cprobe,icn85xx_ts_probe
                                ====icn85xx_ts_probe begin=====.
Mar 10 20:53:59 archiso kernel:
                                begin icn85xx_iic_test
                                 BEGIN test another way of reading
CurrFW verfrom icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel:
                                 CurrFW ver=0
                                 END test another way of reading
CurrFW verfrom icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 20:53:59 archiso kernel:
                                Begin read fw ver from iictestFrom
icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read IC subver from iictestiic
test error! 1 in icn85xx_iic_test
Mar 10 20:53:59 archiso kernel: from icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 20:53:59 archiso kernel:
                                Begin read fw ver from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read IC subver from iictestiic
test error! 2 in icn85xx_iic_test
Mar 10 20:53:59 archiso kernel: from icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 20:53:59 archiso kernel:
                                Begin read fw ver from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 20:53:59 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 20:53:59 archiso kernel:
                                End read IC subver from iictestiic
test error! 3 in icn85xx_iic_test
Mar 10 20:53:59 archiso kernel:
                                end icn85xx_iic_testfunc
icn85xx_ts_probe: icn85xx_iic_test  failed.
Mar 10 20:53:59 archiso kernel: chipone-ts: probe of 4-0048 failed with error -1

-----
i2c-4, 0x30 - just as written in ACPI DSDT - again failed
-----
-- Logs begin at Thu 2016-03-10 21:03:40 UTC, end at Thu 2016-03-10
21:04:41 UTC. --
Mar 10 21:04:39 archiso kernel: i2c /dev entries driver
Mar 10 21:04:39 archiso kernel: device class 'i2c-dev': registering
Mar 10 21:04:39 archiso kernel: device: 'i2c-0': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:i2c-0
Mar 10 21:04:39 archiso kernel: device: 'i2c-1': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:i2c-1
Mar 10 21:04:39 archiso kernel: device: 'i2c-2': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:i2c-2
Mar 10 21:04:39 archiso kernel: device: 'i2c-3': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:i2c-3
Mar 10 21:04:39 archiso kernel: device: 'i2c-4': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:i2c-4
Mar 10 21:04:39 archiso kernel: device class 'mtd': registering
Mar 10 21:04:39 archiso kernel: device: 'mtd': device_add
Mar 10 21:04:39 archiso kernel: PM: Adding info for No Bus:mtd
Mar 10 21:04:39 archiso kernel: bus: 'platform': add driver gpio-nand
Mar 10 21:04:40 archiso kernel:
                                INIT icn MODULE,func ts_init
                                 get pwr gpio in func ts_init
Mar 10 21:04:40 archiso kernel: ------------[ cut here ]------------
Mar 10 21:04:40 archiso kernel: WARNING: CPU: 3 PID: 703 at
drivers/pinctrl/intel/pinctrl-baytrail.c:214
byt_gpio_request+0xaf/0xe0()
Mar 10 21:04:40 archiso kernel: Modules linked in: myicn(O+) gpio nand
nand_ecc nand_ids mtd i2c_dev iTCO_wdt iTCO_vendor_support intel_rapl
intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp coretemp
kvm_intel kvm brcmfmac i915 irqbypass crct10dif_pclmul crc32_pclmul
joydev input_leds cfg80211 i2c_algo_bit aesni_intel aes_x86_64 lrw
gf128mul drm_kms_helper glue_helper rfkill ablk_helper brcmutil drm
cryptd snd_intel_sst_acpi uio_pdrv_genirq snd_intel_sst_core
efi_pstore uio snd_soc_sst_mfld_platform pcspkr efivars intel_gtt
snd_soc_core snd_compress snd_pcm_dmaengine thermal snd_pcm evdev
dw_dmac myicn_ts_acpi(O) dw_dmac_core syscopyarea kxcjk_1013
industrialio_triggered_buffer mei_txe spi_pxa2xx_platform sysfillrect
kfifo_buf i2c_hid sysimgblt battery industrialio snd_timer acpi_pad ac
mei lpc_ich fb_sys_fops
Mar 10 21:04:40 archiso kernel:  snd tpm_tis 8250_dw tpm processor
i2c_designware_platform i2c_designware_core soundcore snd_soc_sst_acpi
i2c_core sch_fq_codel nfs lockd grace sunrpc fscache ip_tables
x_tables overlay squashfs isofs nls_iso8859_1 nls_cp437 vfat fat
sd_mod hid_generic usbhid hid uas usb_storage scsi_mod xhci_pci
xhci_hcd usbcore crc32c_intel usb_common button serio wmi video
sdhci_acpi sdhci led_class loop
Mar 10 21:04:40 archiso kernel: CPU: 3 PID: 703 Comm: insmod Tainted:
G        W  O    4.4.2-2-ARCH #2
Mar 10 21:04:40 archiso kernel: Hardware name: ilife S165/BYT-PF02,
BIOS J1D_S165C_206 10/29/2014
Mar 10 21:04:40 archiso kernel:  0000000000000000 000000001e8b0650
ffff880073abbb68 ffffffff812b324b
Mar 10 21:04:40 archiso kernel:  0000000000000000 ffff880073abbba0
ffffffff8105dc53 ffffc9000036a0f0
Mar 10 21:04:40 archiso kernel:  ffff88007c066e18 000000000000000b
0000000000000002 ffff88007c066f20
Mar 10 21:04:40 archiso kernel: Call Trace:
Mar 10 21:04:40 archiso kernel:  [<ffffffff812b324b>] dump_stack+0x4b/0x70
Mar 10 21:04:40 archiso kernel:  [<ffffffff8105dc53>]
warn_slowpath_common+0x83/0xc0
Mar 10 21:04:40 archiso kernel:  [<ffffffff8105ddab>]
warn_slowpath_null+0x1b/0x20
Mar 10 21:04:40 archiso kernel:  [<ffffffff812e683f>] byt_gpio_request+0xaf/0xe0
Mar 10 21:04:40 archiso kernel:  [<ffffffffa0059000>] ? 0xffffffffa0059000
Mar 10 21:04:40 archiso kernel:  [<ffffffff812e7004>] __gpiod_request+0x74/0x100
Mar 10 21:04:40 archiso kernel:  [<ffffffff812e9dad>] gpiod_request+0x5d/0x100
Mar 10 21:04:40 archiso kernel:  [<ffffffff812e9101>] ? gpio_to_desc+0x91/0xe0
Mar 10 21:04:40 archiso kernel:  [<ffffffff812ea8c4>] gpio_request+0x34/0x40
Mar 10 21:04:40 archiso kernel:  [<ffffffffa005903c>]
ts_init+0x3c/0x1000 [myicn]
Mar 10 21:04:40 archiso kernel:  [<ffffffff810003e2>] do_one_initcall+0xb2/0x1f0
Mar 10 21:04:40 archiso kernel:  [<ffffffff8114966f>] do_init_module+0x5f/0x1f0
Mar 10 21:04:40 archiso kernel:  [<ffffffff810e7d01>] load_module+0x2231/0x28a0
Mar 10 21:04:40 archiso kernel:  [<ffffffff810e4b10>] ?
symbol_put_addr+0x50/0x50
Mar 10 21:04:40 archiso kernel:  [<ffffffff811cdec1>] ? kernel_read+0x51/0x80
Mar 10 21:04:40 archiso kernel:  [<ffffffff810e85cd>] SyS_finit_module+0xbd/0xf0
Mar 10 21:04:40 archiso kernel:  [<ffffffff8157a217>]
entry_SYSCALL_64_fastpath+0x12/0x66
Mar 10 21:04:40 archiso kernel: ---[ end trace c17ab1bcd4ba3d1e ]---
Mar 10 21:04:40 archiso kernel: byt_gpio INT33FC:01: pin 11 forcibly
re-configured as GPIO
Mar 10 21:04:41 archiso kernel: ==icn85xx ts_init 280 at i2cbus: 4!!!!!!!!
Mar 10 21:04:41 archiso kernel: device: '4-0030': device_add
Mar 10 21:04:41 archiso kernel: bus: 'i2c': add device 4-0030
Mar 10 21:04:41 archiso kernel: PM: Adding info for i2c:4-0030
Mar 10 21:04:41 archiso kernel: bus: 'i2c': add driver chipone-ts
Mar 10 21:04:41 archiso kernel: bus: 'i2c': driver_probe_device:
matched device 4-0030 with driver chipone-ts
Mar 10 21:04:41 archiso kernel: bus: 'i2c': really_probe: probing
driver chipone-ts with device 4-0030
Mar 10 21:04:41 archiso kernel: chipone-ts 4-0030: no default pinctrl state
Mar 10 21:04:41 archiso kernel: devices_kset: Moving 4-0030 to end of list
Mar 10 21:04:41 archiso kernel:
                                hello from i2cprobe,icn85xx_ts_probe
                                ====icn85xx_ts_probe begin=====.
Mar 10 21:04:41 archiso kernel:
                                begin icn85xx_iic_test
                                 BEGIN test another way of reading
CurrFW verfrom icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel:
                                 CurrFW ver=0
                                 END test another way of reading
CurrFW verfrom icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 21:04:41 archiso kernel:
                                Begin read fw ver from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read IC subver from iictestiic
test error! 1 in icn85xx_iic_test
Mar 10 21:04:41 archiso kernel: from icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 21:04:41 archiso kernel:
                                Begin read fw ver from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read IC subver from iictestiic
test error! 2 in icn85xx_iic_test
Mar 10 21:04:41 archiso kernel: from icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xa: 0x0
Mar 10 21:04:41 archiso kernel:
                                Begin read fw ver from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xc: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read fw ver from iictest
                                Begin read IC subver  from iictestfrom
icn85xx_i2c_rxdata: i2c read error: -121
Mar 10 21:04:41 archiso kernel: From icn85xx_read_reg -  addr: 0xb: 0x0
Mar 10 21:04:41 archiso kernel:
                                End read IC subver from iictestiic
test error! 3 in icn85xx_iic_test
Mar 10 21:04:41 archiso kernel:
                                end icn85xx_iic_testfunc
icn85xx_ts_probe: icn85xx_iic_test  failed.
Mar 10 21:04:41 archiso kernel: chipone-ts: probe of 4-0030 failed with error -1
