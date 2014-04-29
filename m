From: Vincent Fortier <th0ma7@gmail.com>
Subject: PROBLEM (RESEND): [HP Split 13-m110ca x2 PC] Touchpad not
 working/recognized & keyboard LEDS not functional
Date: Tue, 29 Apr 2014 12:54:57 -0400
Message-ID: <CALAySuJ1qhJ_1p8dJ_sbDeO0M4YJN_8w8cqyZ8oWqBgTyym8-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:54592 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbaD2QzA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2014 12:55:00 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so556447igq.13
        for <linux-input@vger.kernel.org>; Tue, 29 Apr 2014 09:54:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vincent Fortier <th0ma7@gmail.com>

RESEND in order to be more self-explanatory:

PROBLEM 1) Touchpad not working nor recognized
PROBLEM 2) keyboard LEDS (wifi & mute) not functional

Model: HP Split 13-m110ca x2 PC

Tested with upstream 3.15.0-rc3.

I did noticed USB errors at boot time which may be relevant (dmesg at
the end below):

[ 4.078636] usb 2-6: device descriptor read/64, error -71
[ 4.182641] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command
for slot 3.
[ 4.182726] usb 2-6: hub failed to enable device, error -22
[ 4.406874] usb 2-6: device descriptor read/64, error -71
[ 4.510833] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command
for slot 4.
[ 4.510919] usb 2-6: hub failed to enable device, error -22
[ 5.031131] usb 2-6: device not accepting address 6, error -71
[ 5.551425] usb 2-6: device not accepting address 7, error -71

Hopefully below all the relevant info that may be helpfull.  Let me
know if you need anything else to help diagnosing the issue.

(attempt #3, previous emails to mailing list may have contained too much info?)

$  cat /proc/version
Linux version 3.15.0-031500rc3-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201404280035 SMP Mon Apr 28
04:36:21 UTC 2014

$  lsb_release -rd
Description:    Ubuntu 14.04 LTS
Release:    14.04

$ /usr/src/linux-headers-3.15.0-
031500rc3/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux brutus 3.15.0-031500rc3-generic #201404280035 SMP Mon Apr 28
04:36:21 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         ctr ccm snd_hda_codec_hdmi snd_hda_codec_idt
snd_hda_codec_generic hid_sensor_accel_3d hid_sensor_magn_3d
hid_sensor_gyro_3d hid_sensor_als hid_sensor_trigger
industrialio_triggered_buffer kfifo_buf industrialio
hid_sensor_iio_common joydev hid_generic hid_sensor_hub hid_multitouch
hp_wmi sparse_keymap intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel rfcomm kvm bnep bluetooth crct10dif_pclmul uvcvideo
crc32_pclmul videobuf2_vmalloc ghash_clmulni_intel videobuf2_memops
snd_hda_intel snd_hda_controller snd_hda_codec aesni_intel snd_hwdep
aes_x86_64 lrw gf128mul videobuf2_core videodev glue_helper snd_pcm
ablk_helper cryptd arc4 rt2800pci rt2800mmio rt2800lib rt2x00pci
rt2x00mmio rt2x00lib usbhid hid mac80211 serio_raw snd_seq_midi
cfg80211 snd_seq_midi_event i915 snd_rawmidi eeprom_93cx6 crc_ccitt
wmi snd_seq drm_kms_helper snd_seq_device mei_me snd_timer drm mei
i2c_algo_bit video lpc_ich snd soundcore mac_hid parport_pc ppdev
nls_iso8859_1 lp parport ahci libahci rtsx_pci



$ dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.15.0-031500rc3-generic (apw@gomeisa)
(gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201404280035 SMP
Mon Apr 28 04:36:21 UTC 2014
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-3.15.0-031500rc3-generic
root=UUID=01199aaf-45ab-40c4-9f1f-b0dd8c069a68 ro quiet splash
vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000006efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000006f000-0x000000000006ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000070000-0x0000000000087fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000088000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000009269efff] usable
[    0.000000] BIOS-e820: [mem 0x000000009269f000-0x000000009289efff] type 20
[    0.000000] BIOS-e820: [mem 0x000000009289f000-0x0000000092eaefff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000092eaf000-0x0000000092faefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000092faf000-0x0000000092ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000092fff000-0x0000000092ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000093000000-0x000000009f9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe101000-0x00000000fe112fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000015f5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by INSYDE Corp.
[    0.000000] efi:  ACPI=0x92ffe000  ACPI 2.0=0x92ffe014  SMBIOS=0x92eaef98
[    0.000000] efi: mem00: type=3, attr=0xf,
range=[0x0000000000000000-0x0000000000001000) (0MB)
[    0.000000] efi: mem01: type=7, attr=0xf,
range=[0x0000000000001000-0x000000000006f000) (0MB)
[    0.000000] efi: mem02: type=0, attr=0xf,
range=[0x000000000006f000-0x0000000000070000) (0MB)
[    0.000000] efi: mem03: type=7, attr=0xf,
range=[0x0000000000070000-0x0000000000088000) (0MB)
[    0.000000] efi: mem04: type=6, attr=0x800000000000000f,
range=[0x0000000000088000-0x000000000009f000) (0MB)
[    0.000000] efi: mem05: type=0, attr=0xf,
range=[0x000000000009f000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem06: type=2, attr=0xf,
range=[0x0000000000100000-0x0000000001506000) (20MB)
[    0.000000] efi: mem07: type=7, attr=0xf,
range=[0x0000000001506000-0x0000000002000000) (10MB)
[    0.000000] efi: mem08: type=2, attr=0xf,
range=[0x0000000002000000-0x0000000003406000) (20MB)
[    0.000000] efi: mem09: type=7, attr=0xf,
range=[0x0000000003406000-0x0000000035cc0000) (808MB)
[    0.000000] efi: mem10: type=2, attr=0xf,
range=[0x0000000035cc0000-0x0000000036e58000) (17MB)
[    0.000000] efi: mem11: type=7, attr=0xf,
range=[0x0000000036e58000-0x0000000044ada000) (220MB)
[    0.000000] efi: mem12: type=2, attr=0xf,
range=[0x0000000044ada000-0x00000000686b0000) (571MB)
[    0.000000] efi: mem13: type=4, attr=0xf,
range=[0x00000000686b0000-0x00000000686d0000) (0MB)
[    0.000000] efi: mem14: type=7, attr=0xf,
range=[0x00000000686d0000-0x0000000072c3f000) (165MB)
[    0.000000] efi: mem15: type=2, attr=0xf,
range=[0x0000000072c3f000-0x0000000072e13000) (1MB)
[    0.000000] efi: mem16: type=4, attr=0xf,
range=[0x0000000072e13000-0x00000000736a0000) (8MB)
[    0.000000] efi: mem17: type=7, attr=0xf,
range=[0x00000000736a0000-0x00000000736ad000) (0MB)
[    0.000000] efi: mem18: type=2, attr=0xf,
range=[0x00000000736ad000-0x00000000736af000) (0MB)
[    0.000000] efi: mem19: type=7, attr=0xf,
range=[0x00000000736af000-0x000000007377b000) (0MB)
[    0.000000] efi: mem20: type=1, attr=0xf,
range=[0x000000007377b000-0x00000000738af000) (1MB)
[    0.000000] efi: mem21: type=7, attr=0xf,
range=[0x00000000738af000-0x00000000777aa000) (62MB)
[    0.000000] efi: mem22: type=4, attr=0xf,
range=[0x00000000777aa000-0x000000007802c000) (8MB)
[    0.000000] efi: mem23: type=7, attr=0xf,
range=[0x000000007802c000-0x0000000078229000) (1MB)
[    0.000000] efi: mem24: type=4, attr=0xf,
range=[0x0000000078229000-0x00000000783b0000) (1MB)
[    0.000000] efi: mem25: type=7, attr=0xf,
range=[0x00000000783b0000-0x00000000783b3000) (0MB)
[    0.000000] efi: mem26: type=4, attr=0xf,
range=[0x00000000783b3000-0x00000000783b9000) (0MB)
[    0.000000] efi: mem27: type=7, attr=0xf,
range=[0x00000000783b9000-0x00000000783ba000) (0MB)
[    0.000000] efi: mem28: type=4, attr=0xf,
range=[0x00000000783ba000-0x00000000783e5000) (0MB)
[    0.000000] efi: mem29: type=7, attr=0xf,
range=[0x00000000783e5000-0x00000000783e6000) (0MB)
[    0.000000] efi: mem30: type=4, attr=0xf,
range=[0x00000000783e6000-0x0000000078539000) (1MB)
[    0.000000] efi: mem31: type=7, attr=0xf,
range=[0x0000000078539000-0x000000007853c000) (0MB)
[    0.000000] efi: mem32: type=4, attr=0xf,
range=[0x000000007853c000-0x0000000078565000) (0MB)
[    0.000000] efi: mem33: type=7, attr=0xf,
range=[0x0000000078565000-0x0000000078567000) (0MB)
[    0.000000] efi: mem34: type=4, attr=0xf,
range=[0x0000000078567000-0x0000000078568000) (0MB)
[    0.000000] efi: mem35: type=7, attr=0xf,
range=[0x0000000078568000-0x000000007856b000) (0MB)
[    0.000000] efi: mem36: type=4, attr=0xf,
range=[0x000000007856b000-0x000000007856f000) (0MB)
[    0.000000] efi: mem37: type=7, attr=0xf,
range=[0x000000007856f000-0x0000000078570000) (0MB)
[    0.000000] efi: mem38: type=4, attr=0xf,
range=[0x0000000078570000-0x00000000785a3000) (0MB)
[    0.000000] efi: mem39: type=7, attr=0xf,
range=[0x00000000785a3000-0x00000000785a5000) (0MB)
[    0.000000] efi: mem40: type=4, attr=0xf,
range=[0x00000000785a5000-0x00000000785a8000) (0MB)
[    0.000000] efi: mem41: type=7, attr=0xf,
range=[0x00000000785a8000-0x00000000785b4000) (0MB)
[    0.000000] efi: mem42: type=4, attr=0xf,
range=[0x00000000785b4000-0x00000000785b5000) (0MB)
[    0.000000] efi: mem43: type=7, attr=0xf,
range=[0x00000000785b5000-0x00000000785b9000) (0MB)
[    0.000000] efi: mem44: type=4, attr=0xf,
range=[0x00000000785b9000-0x0000000078611000) (0MB)
[    0.000000] efi: mem45: type=7, attr=0xf,
range=[0x0000000078611000-0x0000000078612000) (0MB)
[    0.000000] efi: mem46: type=4, attr=0xf,
range=[0x0000000078612000-0x0000000078613000) (0MB)
[    0.000000] efi: mem47: type=7, attr=0xf,
range=[0x0000000078613000-0x0000000078614000) (0MB)
[    0.000000] efi: mem48: type=4, attr=0xf,
range=[0x0000000078614000-0x0000000078615000) (0MB)
[    0.000000] efi: mem49: type=7, attr=0xf,
range=[0x0000000078615000-0x0000000078616000) (0MB)
[    0.000000] efi: mem50: type=4, attr=0xf,
range=[0x0000000078616000-0x000000007861e000) (0MB)
[    0.000000] efi: mem51: type=7, attr=0xf,
range=[0x000000007861e000-0x000000007861f000) (0MB)
[    0.000000] efi: mem52: type=4, attr=0xf,
range=[0x000000007861f000-0x0000000078637000) (0MB)
[    0.000000] efi: mem53: type=7, attr=0xf,
range=[0x0000000078637000-0x0000000078638000) (0MB)
[    0.000000] efi: mem54: type=4, attr=0xf,
range=[0x0000000078638000-0x0000000078677000) (0MB)
[    0.000000] efi: mem55: type=7, attr=0xf,
range=[0x0000000078677000-0x0000000078686000) (0MB)
[    0.000000] efi: mem56: type=4, attr=0xf,
range=[0x0000000078686000-0x00000000787a1000) (1MB)
[    0.000000] efi: mem57: type=7, attr=0xf,
range=[0x00000000787a1000-0x00000000787a2000) (0MB)
[    0.000000] efi: mem58: type=4, attr=0xf,
range=[0x00000000787a2000-0x0000000079fcf000) (24MB)
[    0.000000] efi: mem59: type=7, attr=0xf,
range=[0x0000000079fcf000-0x00000000921ff000) (386MB)
[    0.000000] efi: mem60: type=2, attr=0xf,
range=[0x00000000921ff000-0x000000009220b000) (0MB)
[    0.000000] efi: mem61: type=3, attr=0xf,
range=[0x000000009220b000-0x000000009269f000) (4MB)
[    0.000000] efi: mem62: type=5, attr=0x800000000000000f,
range=[0x000000009269f000-0x000000009289f000) (2MB)
[    0.000000] efi: mem63: type=6, attr=0x800000000000000f,
range=[0x000000009289f000-0x0000000092aaf000) (2MB)
[    0.000000] efi: mem64: type=0, attr=0xf,
range=[0x0000000092aaf000-0x0000000092eaf000) (4MB)
[    0.000000] efi: mem65: type=10, attr=0xf,
range=[0x0000000092eaf000-0x0000000092faf000) (1MB)
[    0.000000] efi: mem66: type=9, attr=0xf,
range=[0x0000000092faf000-0x0000000092fff000) (0MB)
[    0.000000] efi: mem67: type=4, attr=0xf,
range=[0x0000000092fff000-0x0000000093000000) (0MB)
[    0.000000] efi: mem68: type=7, attr=0xf,
range=[0x0000000100000000-0x000000015f600000) (1526MB)
[    0.000000] efi: mem69: type=0, attr=0x0,
range=[0x00000000000a0000-0x00000000000c0000) (0MB)
[    0.000000] efi: mem70: type=0, attr=0x0,
range=[0x0000000093000000-0x000000009fa00000) (202MB)
[    0.000000] efi: mem71: type=11, attr=0x8000000000000001,
range=[0x00000000e0000000-0x00000000f0000000) (256MB)
[    0.000000] efi: mem72: type=0, attr=0x0,
range=[0x00000000fe101000-0x00000000fe113000) (0MB)
[    0.000000] efi: mem73: type=11, attr=0x8000000000000001,
range=[0x00000000feb00000-0x00000000feb10000) (0MB)
[    0.000000] efi: mem74: type=11, attr=0x8000000000000001,
range=[0x00000000fec00000-0x00000000fec01000) (0MB)
[    0.000000] efi: mem75: type=11, attr=0x8000000000000001,
range=[0x00000000fed00000-0x00000000fed1c000) (0MB)
[    0.000000] efi: mem76: type=11, attr=0x8000000000000000,
range=[0x00000000fed1c000-0x00000000fed20000) (0MB)
[    0.000000] efi: mem77: type=11, attr=0x8000000000000001,
range=[0x00000000fed20000-0x00000000fee01000) (0MB)
[    0.000000] efi: mem78: type=11, attr=0x8000000000000001,
range=[0x00000000ffb00000-0x0000000100000000) (5MB)
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Hewlett-Packard HP Split 13 x2 PC/215B, BIOS F.24 11/26/2013
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x15f600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-E7FFF write-protect
[    0.000000]   E8000-EFFFF write-combining
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7E00000000 write-back
[    0.000000]   1 base 0093000000 mask 7FFF000000 uncachable
[    0.000000]   2 base 0094000000 mask 7FFC000000 uncachable
[    0.000000]   3 base 0098000000 mask 7FF8000000 uncachable
[    0.000000]   4 base 00A0000000 mask 7FE0000000 uncachable
[    0.000000]   5 base 00C0000000 mask 7FC0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 8GB, type WB
[    0.000000] reg 1, base: 2352MB, range: 16MB, type UC
[    0.000000] reg 2, base: 2368MB, range: 64MB, type UC
[    0.000000] reg 3, base: 2432MB, range: 128MB, type UC
[    0.000000] reg 4, base: 2560MB, range: 512MB, type UC
[    0.000000] reg 5, base: 3GB, range: 1GB, type UC
[    0.000000] total RAM covered: 6448M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K     chunk_size: 64K     num_reg: 5
lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 256MB, type WB
[    0.000000] reg 2, base: 2304MB, range: 32MB, type WB
[    0.000000] reg 3, base: 2336MB, range: 16MB, type WB
[    0.000000] reg 4, base: 4GB, range: 4GB, type WB
[    0.000000] e820: update [mem 0x93000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x93000 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff88000007c000] 7c000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02fe4000, 0x02fe4fff] PGTABLE
[    0.000000] BRK [0x02fe5000, 0x02fe5fff] PGTABLE
[    0.000000] BRK [0x02fe6000, 0x02fe6fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x15f400000-0x15f5fffff]
[    0.000000]  [mem 0x15f400000-0x15f5fffff] page 2M
[    0.000000] BRK [0x02fe7000, 0x02fe7fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x15c000000-0x15f3fffff]
[    0.000000]  [mem 0x15c000000-0x15f3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x100000000-0x15bffffff]
[    0.000000]  [mem 0x100000000-0x13fffffff] page 1G
[    0.000000]  [mem 0x140000000-0x15bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x9269efff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0x925fffff] page 2M
[    0.000000]  [mem 0x92600000-0x9269efff] page 4k
[    0.000000] init_memory_mapping: [mem 0x92fff000-0x92ffffff]
[    0.000000]  [mem 0x92fff000-0x92ffffff] page 4k
[    0.000000] BRK [0x02fe8000, 0x02fe8fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x35cc0000-0x36e57fff]
[    0.000000] ACPI: RSDP 0x0000000092FFE014 000024 (v02 HPQOEM)
[    0.000000] ACPI: XSDT 0x0000000092FFE210 0000AC (v01 HPQOEM
SLIC-MPC 00000001 HP   01000013)
[    0.000000] ACPI: FACP 0x0000000092FF8000 00010C (v05 HPQOEM
SLIC-MPC 00000001 HP   00040000)
[    0.000000] ACPI: DSDT 0x0000000092FE4000 010ECC (v01 HPQOEM 215B
  00000000 ACPI 00040000)
[    0.000000] ACPI: FACS 0x0000000092FAA000 000040
[    0.000000] ACPI: UEFI 0x0000000092FFD000 000236 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: FPDT 0x0000000092FFB000 000044 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: MSDM 0x0000000092FFA000 000055 (v03 HPQOEM
SLIC-MPC 00000001 HP   00040000)
[    0.000000] ACPI: ASF! 0x0000000092FF9000 0000A5 (v32 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: HPET 0x0000000092FF7000 000038 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: APIC 0x0000000092FF6000 00008C (v03 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: MCFG 0x0000000092FF5000 00003C (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: SSDT 0x0000000092FE2000 0010BF (v01 HPQOEM 215B
  00001000 ACPI 00040000)
[    0.000000] ACPI: BOOT 0x0000000092FE0000 000028 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: LPIT 0x0000000092FDF000 00005C (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: ASPT 0x0000000092FDD000 000034 (v07 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: DBGP 0x0000000092FDC000 000034 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: SSDT 0x0000000092FDB000 000452 (v01 HPQOEM 215B
  00003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x0000000092FDA000 000AD8 (v01 HPQOEM 215B
  00003000 ACPI 00040000)
[    0.000000] ACPI: SSDT 0x0000000092FD7000 002A63 (v01 HPQOEM 215B
  00003000 ACPI 00040000)
[    0.000000] ACPI: BGRT 0x0000000092FD6000 000038 (v01 HPQOEM 215B
  00000001 HP   00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000015f5fffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x15f5fffff]
[    0.000000]   NODE_DATA [mem 0x15f5f9000-0x15f5fdfff]
[    0.000000]  [ffffea0000000000-ffffea00057fffff] PMD ->
[ffff88015ae00000-ffff88015ebfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x15f5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0006efff]
[    0.000000]   node   0: [mem 0x00070000-0x00087fff]
[    0.000000]   node   0: [mem 0x00100000-0x9269efff]
[    0.000000]   node   0: [mem 0x92fff000-0x92ffffff]
[    0.000000]   node   0: [mem 0x100000000-0x15f5fffff]
[    0.000000] On node 0 totalpages: 990246
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3974 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 9307 pages used for memmap
[    0.000000]   DMA32 zone: 595616 pages, LIFO batch:31
[    0.000000]   Normal zone: 6104 pages used for memmap
[    0.000000]   Normal zone: 390656 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0x9da00000-0x9f9fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 56
[    0.000000] PM: Registered nosave memory: [mem 0x0006f000-0x0006ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x00088000-0x000bffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x9269f000-0x9289efff]
[    0.000000] PM: Registered nosave memory: [mem 0x9289f000-0x92eaefff]
[    0.000000] PM: Registered nosave memory: [mem 0x92eaf000-0x92faefff]
[    0.000000] PM: Registered nosave memory: [mem 0x92faf000-0x92ffefff]
[    0.000000] PM: Registered nosave memory: [mem 0x93000000-0x9f9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x9fa00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfe100fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe101000-0xfe112fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe113000-0xfeafffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfeb0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb10000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffafffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffb00000-0xffffffff]
[    0.000000] e820: [mem 0x9fa00000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88015f200000 s86592
r8192 d24000 u262144
[    0.000000] pcpu-alloc: s86592 r8192 d24000 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 974749
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-3.15.0-031500rc3-generic
root=UUID=01199aaf-45ab-40c4-9f1f-b0dd8c069a68 ro quiet splash
vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 3743400K/3960984K available (7620K kernel code,
1143K rwdata, 3624K rodata, 1356K init, 1444K bss, 217584K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]     RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000]     Offload RCU callbacks from all CPUs
[    0.000000]     Offload RCU callbacks from CPUs: 0-7.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS:16640 nr_irqs:1016 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 16252928 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1296.919 MHz processor
[    0.000091] Calibrating delay loop (skipped), value calculated
using timer frequency.. 2593.83 BogoMIPS (lpj=5187676)
[    0.000099] pid_max: default: 32768 minimum: 301
[    0.000119] ACPI: Core revision 20140214
[    0.040175] ACPI: All ACPI Tables successfully acquired
[    0.087020] Security Framework initialized
[    0.087053] AppArmor: AppArmor initialized
[    0.087055] Yama: becoming mindful.
[    0.088025] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.090856] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.092630] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.092647] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.093291] Initializing cgroup subsys memory
[    0.093303] Initializing cgroup subsys devices
[    0.093307] Initializing cgroup subsys freezer
[    0.093311] Initializing cgroup subsys net_cls
[    0.093315] Initializing cgroup subsys blkio
[    0.093319] Initializing cgroup subsys perf_event
[    0.093323] Initializing cgroup subsys hugetlb
[    0.093378] CPU: Physical Processor ID: 0
[    0.093380] CPU: Processor Core ID: 0
[    0.093393] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.093393] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.095830] mce: CPU supports 7 MCE banks
[    0.095871] CPU0: Thermal monitoring enabled (TM1)
[    0.095903] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.095903] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.095903] tlb_flushall_shift: 6
[    0.096200] Freeing SMP alternatives memory: 28K (ffffffff81e72000
- ffffffff81e79000)
[    0.104815] ftrace: allocating 31792 entries in 125 pages
[    0.144256] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.183974] smpboot: CPU0: Intel(R) Core(TM) i3-4010Y CPU @ 1.30GHz
(fam: 06, model: 45, stepping: 01)
[    0.183993] TSC deadline timer enabled
[    0.184018] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell
events, full-width counters, Intel PMU driver.
[    0.184036] ... version:                3
[    0.184039] ... bit width:              48
[    0.184042] ... generic registers:      4
[    0.184045] ... value mask:             0000ffffffffffff
[    0.184047] ... max period:             0000ffffffffffff
[    0.184050] ... fixed-purpose events:   3
[    0.184053] ... event mask:             000000070000000f
[    0.188754] x86: Booting SMP configuration:
[    0.188759] .... node  #0, CPUs:      #1
[    0.205109] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.205330]  #2 #3
[    0.237139] x86: Booted up 1 node, 4 CPUs
[    0.237148] smpboot: Total of 4 processors activated (10375.35 BogoMIPS)
[    0.248932] devtmpfs: initialized
[    0.259445] evm: security.selinux
[    0.259449] evm: security.SMACK64
[    0.259451] evm: security.ima
[    0.259454] evm: security.capability
[    0.259587] PM: Registering ACPI NVS region [mem
0x92eaf000-0x92faefff] (1048576 bytes)
[    0.261905] pinctrl core: initialized pinctrl subsystem
[    0.262075] regulator-dummy: no parameters
[    0.262134] RTC time: 16:56:03, date: 04/28/14
[    0.262239] NET: Registered protocol family 16
[    0.262543] cpuidle: using governor ladder
[    0.262547] cpuidle: using governor menu
[    0.262654] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.262658] ACPI: bus type PCI registered
[    0.262662] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.262819] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.262825] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.335546] PCI: Using configuration type 1 for base access
[    0.339519] ACPI: Added _OSI(Module Device)
[    0.339526] ACPI: Added _OSI(Processor Device)
[    0.339530] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.339533] ACPI: Added _OSI(Processor Aggregator Device)
[    0.349561] ACPI: Executed 1 blocks of module-level executable AML code
[    0.359281] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.364958] ACPI: SSDT 0x0000000092E71C18 0003D3 (v01 PmRef
Cpu0Cst  00003001 INTL 20120816)
[    0.366247] ACPI: Dynamic OEM Table Load:
[    0.366253] ACPI: SSDT 0x0000000000000000 0003D3 (v01 PmRef
Cpu0Cst  00003001 INTL 20120816)
[    0.369311] ACPI: SSDT 0x0000000092E71618 0005AA (v01 PmRef  ApIst
  00003000 INTL 20120816)
[    0.371156] ACPI: Dynamic OEM Table Load:
[    0.371162] ACPI: SSDT 0x0000000000000000 0005AA (v01 PmRef  ApIst
  00003000 INTL 20120816)
[    0.372876] ACPI: SSDT 0x0000000092E69D98 000119 (v01 PmRef  ApCst
  00003000 INTL 20120816)
[    0.374177] ACPI: Dynamic OEM Table Load:
[    0.374182] ACPI: SSDT 0x0000000000000000 000119 (v01 PmRef  ApCst
  00003000 INTL 20120816)
[    0.886650] ACPI: Interpreter enabled
[    0.886675] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S1_] (20140214/hwxface-580)
[    0.886694] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20140214/hwxface-580)
[    0.886749] ACPI: (supports S0 S3 S4 S5)
[    0.886753] ACPI: Using IOAPIC for interrupt routing
[    0.886833] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.890153] acpi HPQC0003:00: ACPI dock station (docks/bays count: 1)
[    0.903577] ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
[    0.903590] ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
[    0.903599] ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
[    0.903608] ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
[    0.904937] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.904951] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.905158] \_SB_.PCI0:_OSC invalid UUID
[    0.905161] _OSC request data:1 1f 0
[    0.905173] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.906626] PCI host bridge to bus 0000:00
[    0.906635] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.906641] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.906646] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.906650] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.906655] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff]
[    0.906659] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff]
[    0.906663] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff]
[    0.906668] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff]
[    0.906672] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    0.906676] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.906681] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.906685] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    0.906689] pci_bus 0000:00: root bus resource [mem 0x9fa00000-0xfeafffff]
[    0.906712] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.907057] pci 0000:00:02.0: [8086:0a1e] type 00 class 0x030000
[    0.907091] pci 0000:00:02.0: reg 0x10: [mem 0xb0000000-0xb03fffff 64bit]
[    0.907111] pci 0000:00:02.0: reg 0x18: [mem 0xa0000000-0xafffffff
64bit pref]
[    0.907125] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.907462] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.907485] pci 0000:00:03.0: reg 0x10: [mem 0xb0610000-0xb0613fff 64bit]
[    0.907869] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.907904] pci 0000:00:14.0: reg 0x10: [mem 0xb0600000-0xb060ffff 64bit]
[    0.908014] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.908214] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.908320] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.908358] pci 0000:00:16.0: reg 0x10: [mem 0xb0618000-0xb061801f 64bit]
[    0.908479] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.908786] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.908813] pci 0000:00:1b.0: reg 0x10: [mem 0xb0614000-0xb0617fff 64bit]
[    0.908937] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.909223] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.909344] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.909568] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.909666] pci 0000:00:1c.1: [8086:9c12] type 01 class 0x060400
[    0.909787] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.909991] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.910089] pci 0000:00:1c.2: [8086:9c14] type 01 class 0x060400
[    0.910209] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.910413] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.910527] pci 0000:00:1d.0: [8086:9c26] type 00 class 0x0c0320
[    0.910564] pci 0000:00:1d.0: reg 0x10: [mem 0xb061c000-0xb061c3ff]
[    0.910714] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.910945] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.911046] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.911483] pci 0000:00:1f.2: [8086:9c03] type 00 class 0x010601
[    0.911515] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308f]
[    0.911530] pci 0000:00:1f.2: reg 0x14: [io  0x3094-0x3097]
[    0.911545] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x3087]
[    0.911561] pci 0000:00:1f.2: reg 0x1c: [io  0x3090-0x3093]
[    0.911576] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307f]
[    0.911591] pci 0000:00:1f.2: reg 0x24: [mem 0xb061b000-0xb061b7ff]
[    0.911663] pci 0000:00:1f.2: PME# supported from D3hot
[    0.911939] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.911968] pci 0000:00:1f.3: reg 0x10: [mem 0xb0619000-0xb06190ff 64bit]
[    0.912005] pci 0000:00:1f.3: reg 0x20: [io  0x3040-0x305f]
[    0.912393] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.912629] pci 0000:02:00.0: [10ec:5227] type 00 class 0xff0000
[    0.912700] pci 0000:02:00.0: reg 0x10: [mem 0xb0500000-0xb0500fff]
[    0.913208] pci 0000:02:00.0: supports D1 D2
[    0.913213] pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.921451] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.921464] pci 0000:00:1c.1:   bridge window [mem 0xb0500000-0xb05fffff]
[    0.921629] pci 0000:03:00.0: [1814:3290] type 00 class 0x028000
[    0.921671] pci 0000:03:00.0: reg 0x10: [mem 0xb0410000-0xb041ffff]
[    0.921868] pci 0000:03:00.0: PME# supported from D0 D3hot
[    0.922035] pci 0000:03:00.1: [1814:3298] type 00 class 0x0d1100
[    0.922077] pci 0000:03:00.1: reg 0x10: [mem 0xb0400000-0xb040ffff]
[    0.922273] pci 0000:03:00.1: supports D1
[    0.922277] pci 0000:03:00.1: PME# supported from D0 D1 D3hot
[    0.933468] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.933479] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb04fffff]
[    0.934375] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.934501] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.934624] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.934741] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.934854] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.934968] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.935082] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.935195] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.935527] ACPI: Enabled 4 GPEs in block 00 to 7F
[    0.935662] ACPI : EC: GPE = 0x8, I/O: command/status = 0x66, data = 0x62
[    0.935943] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.935953] vgaarb: loaded
[    0.935956] vgaarb: bridge control possible 0000:00:02.0
[    0.936450] SCSI subsystem initialized
[    0.936572] libata version 3.00 loaded.
[    0.936633] ACPI: bus type USB registered
[    0.936680] usbcore: registered new interface driver usbfs
[    0.936703] usbcore: registered new interface driver hub
[    0.936763] usbcore: registered new device driver usb
[    0.937176] PCI: Using ACPI for IRQ routing
[    0.947315] PCI: pci_cache_line_size set to 64 bytes
[    0.947408] e820: reserve RAM buffer [mem 0x0006f000-0x0006ffff]
[    0.947413] e820: reserve RAM buffer [mem 0x00088000-0x0008ffff]
[    0.947416] e820: reserve RAM buffer [mem 0x9269f000-0x93ffffff]
[    0.947421] e820: reserve RAM buffer [mem 0x93000000-0x93ffffff]
[    0.947425] e820: reserve RAM buffer [mem 0x15f600000-0x15fffffff]
[    0.947668] NetLabel: Initializing
[    0.947671] NetLabel:  domain hash size = 128
[    0.947674] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.947705] NetLabel:  unlabeled traffic allowed by default
[    0.947847] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.947862] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.949942] Switched to clocksource hpet
[    0.965424] AppArmor: AppArmor Filesystem Enabled
[    0.965487] pnp: PnP ACPI init
[    0.965522] ACPI: bus type PNP registered
[    0.966534] pnp 00:00: [dma 4]
[    0.966607] pnp 00:00: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.966673] pnp 00:01: Plug and Play ACPI device, IDs INT0800 (active)
[    0.966943] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.967122] system 00:03: [io  0x0680-0x069f] has been reserved
[    0.967128] system 00:03: [io  0xffff] has been reserved
[    0.967133] system 00:03: [io  0xffff] has been reserved
[    0.967143] system 00:03: [io  0xffff] has been reserved
[    0.967149] system 00:03: [io  0x1800-0x18fe] could not be reserved
[    0.967153] system 00:03: [io  0x164e-0x164f] has been reserved
[    0.967158] system 00:03: [io  0x0454-0x0457] has been reserved
[    0.967163] system 00:03: [io  0x0380-0x0387] has been reserved
[    0.967171] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.967294] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.967395] pnp 00:05: Plug and Play ACPI device, IDs HPQ8001
PNP0303 (active)
[    0.968061] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.968068] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.968073] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.968078] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.968084] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    0.968089] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.968094] system 00:06: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.968099] system 00:06: [mem 0xff000000-0xffffffff] could not be reserved
[    0.968105] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.968110] system 00:06: [mem 0x9fa22000-0x9fa22fff] has been reserved
[    0.968115] system 00:06: [mem 0x9fa10000-0x9fa1ffff] has been reserved
[    0.968122] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.968704] pnp 00:07: Plug and Play ACPI device, IDs INTcfd9
PNP0c40 (active)
[    0.968914] pnp: PnP ACPI: found 8 devices
[    0.968917] ACPI: bus type PNP unregistered
[    0.978206] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to
[bus 01] add_size 1000
[    0.978217] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
[    0.978222] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff] to [bus 01] add_size 200000
[    0.978257] pci 0000:00:1c.0: res[14]=[mem 0x00100000-0x000fffff]
get_res_add_size add_size 200000
[    0.978263] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    0.978268] pci 0000:00:1c.0: res[13]=[io  0x1000-0x0fff]
get_res_add_size add_size 1000
[    0.978287] pci 0000:00:1c.0: BAR 14: assigned [mem 0x9fb00000-0x9fcfffff]
[    0.978308] pci 0000:00:1c.0: BAR 15: assigned [mem
0x9fd00000-0x9fefffff 64bit pref]
[    0.978316] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.978323] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.978329] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.978339] pci 0000:00:1c.0:   bridge window [mem 0x9fb00000-0x9fcfffff]
[    0.978347] pci 0000:00:1c.0:   bridge window [mem
0x9fd00000-0x9fefffff 64bit pref]
[    0.978359] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.978369] pci 0000:00:1c.1:   bridge window [mem 0xb0500000-0xb05fffff]
[    0.978384] pci 0000:00:1c.2: PCI bridge to [bus 03]
[    0.978393] pci 0000:00:1c.2:   bridge window [mem 0xb0400000-0xb04fffff]
[    0.978410] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.978415] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.978420] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.978425] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff]
[    0.978429] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff]
[    0.978433] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff]
[    0.978438] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff]
[    0.978442] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff]
[    0.978447] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff]
[    0.978451] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff]
[    0.978455] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff]
[    0.978460] pci_bus 0000:00: resource 15 [mem 0x9fa00000-0xfeafffff]
[    0.978465] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.978469] pci_bus 0000:01: resource 1 [mem 0x9fb00000-0x9fcfffff]
[    0.978474] pci_bus 0000:01: resource 2 [mem 0x9fd00000-0x9fefffff
64bit pref]
[    0.978479] pci_bus 0000:02: resource 1 [mem 0xb0500000-0xb05fffff]
[    0.978484] pci_bus 0000:03: resource 1 [mem 0xb0400000-0xb04fffff]
[    0.978556] NET: Registered protocol family 2
[    0.978948] TCP established hash table entries: 32768 (order: 6,
262144 bytes)
[    0.979260] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.979680] TCP: Hash tables configured (established 32768 bind 32768)
[    0.979728] TCP: reno registered
[    0.979748] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.979817] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.979978] NET: Registered protocol family 1
[    0.980006] pci 0000:00:02.0: Boot video device
[    0.998232] PCI: CLS 64 bytes, default 64
[    0.998375] Trying to unpack rootfs image as initramfs...
[    1.936493] Freeing initrd memory: 18016K (ffff880035cc0000 -
ffff880036e58000)
[    1.936505] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.936512] software IO TLB [mem 0x8e20b000-0x9220b000] (64MB)
mapped at [ffff88008e20b000-ffff88009220afff]
[    1.936642] Simple Boot Flag at 0x44 set to 0x1
[    1.937128] microcode: CPU0 sig=0x40651, pf=0x40, revision=0x14
[    1.937145] microcode: CPU1 sig=0x40651, pf=0x40, revision=0x14
[    1.937163] microcode: CPU2 sig=0x40651, pf=0x40, revision=0x14
[    1.937185] microcode: CPU3 sig=0x40651, pf=0x40, revision=0x14
[    1.937314] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.937359] Scanning for low memory corruption every 60 seconds
[    1.938255] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    1.938332] Initialise system trusted keyring
[    1.938372] audit: initializing netlink subsys (disabled)
[    1.938406] audit: type=2000 audit(1398704164.824:1): initialized
[    2.031283] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.035658] VFS: Disk quotas dquot_6.5.2
[    2.035758] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.036918] fuse init (API version 7.23)
[    2.037135] msgmni has been set to 7448
[    2.037282] Key type big_key registered
[    2.038954] Key type asymmetric registered
[    2.038960] Asymmetric key parser 'x509' registered
[    2.039104] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    2.039188] io scheduler noop registered
[    2.039192] io scheduler deadline registered (default)
[    2.039274] io scheduler cfq registered
[    2.039442] pcieport 0000:00:1c.0: device [8086:9c10] has invalid
IRQ; check vendor BIOS
[    2.039799] pcieport 0000:00:1c.1: device [8086:9c12] has invalid
IRQ; check vendor BIOS
[    2.040070] pcieport 0000:00:1c.2: device [8086:9c14] has invalid
IRQ; check vendor BIOS
[    2.040383] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.040421] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.040547] efifb: probing for efifb
[    2.041815] efifb: framebuffer at 0xa0000000, mapped to
0xffffc90010800000, using 4160k, total 4160k
[    2.041820] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    2.041822] efifb: scrolling: redraw
[    2.041827] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.048742] Console: switching to colour frame buffer device 170x48
[    2.055346] fb0: EFI VGA frame buffer device
[    2.055381] intel_idle: MWAIT substates: 0x11142120
[    2.055384] intel_idle: v0.4 model 0x45
[    2.055387] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.056018] ipmi message handler version 39.2
[    2.056603] ACPI: AC Adapter [ACAD] (on-line)
[    2.056936] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    2.057523] ACPI: Lid Switch [LID0]
[    2.057641] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.057650] ACPI: Power Button [PWRB]
[    2.057779] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    2.057785] ACPI: Power Button [PWRF]
[    2.059466] [Firmware Bug]: Invalid critical threshold (0)
[    2.061319] thermal LNXTHERM:00: registered as thermal_zone0
[    2.061328] ACPI: Thermal Zone [TZ01] (46 C)
[    2.061398] GHES: HEST is not enabled!
[    2.061641] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.066108] Linux agpgart interface v0.103
[    2.069392] brd: module loaded
[    2.071128] loop: module loaded
[    2.072138] libphy: Fixed MDIO Bus: probed
[    2.072400] tun: Universal TUN/TAP device driver, 1.6
[    2.072403] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.072512] PPP generic driver version 2.4.2
[    2.072620] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.072630] ehci-pci: EHCI PCI platform driver
[    2.072922] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    2.072937] ehci-pci 0000:00:1d.0: new USB bus registered, assigned
bus number 1
[    2.072961] ehci-pci 0000:00:1d.0: debug port 2
[    2.076896] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    2.076954] ehci-pci 0000:00:1d.0: irq 23, io mem 0xb061c000
[    2.086648] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    2.086761] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.086766] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.086770] usb usb1: Product: EHCI Host Controller
[    2.086775] usb usb1: Manufacturer: Linux 3.15.0-031500rc3-generic ehci_hcd
[    2.086779] usb usb1: SerialNumber: 0000:00:1d.0
[    2.087131] hub 1-0:1.0: USB hub found
[    2.087148] hub 1-0:1.0: 2 ports detected
[    2.087469] ehci-platform: EHCI generic platform driver
[    2.087494] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.087504] ohci-pci: OHCI PCI platform driver
[    2.087529] ohci-platform: OHCI generic platform driver
[    2.087545] uhci_hcd: USB Universal Host Controller Interface driver
[    2.087857] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.087870] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    2.087998] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.088036] xhci_hcd 0000:00:14.0: irq 56 for MSI/MSI-X
[    2.088174] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.088179] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.088184] usb usb2: Product: xHCI Host Controller
[    2.088188] usb usb2: Manufacturer: Linux 3.15.0-031500rc3-generic xhci_hcd
[    2.088192] usb usb2: SerialNumber: 0000:00:14.0
[    2.088591] hub 2-0:1.0: USB hub found
[    2.088619] hub 2-0:1.0: 9 ports detected
[    2.090360] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.090371] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 3
[    2.090465] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
[    2.090471] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.090475] usb usb3: Product: xHCI Host Controller
[    2.090480] usb usb3: Manufacturer: Linux 3.15.0-031500rc3-generic xhci_hcd
[    2.090484] usb usb3: SerialNumber: 0000:00:14.0
[    2.090876] hub 3-0:1.0: USB hub found
[    2.090896] hub 3-0:1.0: 4 ports detected
[    2.091607] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    2.091612] i8042: PNP: PS/2 appears to have AUX port disabled, if
this is incorrect please boot with i8042.nopnp
[    2.094071] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.094380] mousedev: PS/2 mouse device common for all mice
[    2.094928] rtc_cmos 00:04: RTC can wake from S4
[    2.095195] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    2.095254] rtc_cmos 00:04: alarms up to one month, 242 bytes
nvram, hpet irqs
[    2.095421] device-mapper: uevent: version 1.0.3
[    2.095638] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30)
initialised: dm-devel@redhat.com
[    2.095653] Intel P-state driver initializing.
[    2.095686] Intel pstate controlling: cpu 0
[    2.095765] Intel pstate controlling: cpu 1
[    2.095806] Intel pstate controlling: cpu 2
[    2.095844] Intel pstate controlling: cpu 3
[    2.095910] ledtrig-cpu: registered to indicate activity on CPUs
[    2.095913] EFI Variables Facility v0.08 2004-May-17
[    2.102957] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
[    2.132768] TCP: cubic registered
[    2.132970] NET: Registered protocol family 10
[    2.133077] ACPI: Battery Slot [BAT0] (battery present)
[    2.133340] NET: Registered protocol family 17
[    2.133361] Key type dns_resolver registered
[    2.133993] Loading compiled-in X.509 certificates
[    2.135506] Loaded X.509 cert 'Magrathea: Glacier signing key:
3b6ee6fabf4d42471d6891c3594f54a0c9cb277a'
[    2.135524] registered taskstats version 1
[    2.138487] Key type trusted registered
[    2.141059] Key type encrypted registered
[    2.143578] AppArmor: AppArmor sha1 policy hashing enabled
[    2.143584] ima: No TPM chip found, activating TPM-bypass!
[    2.144149]   Magic number: 10:679:945
[    2.144183] tty tty2: hash matches
[    2.144211] processor cpu0: hash matches
[    2.144260] rtc_cmos 00:04: setting system clock to 2014-04-28
16:56:05 UTC (1398704165)
[    2.144324] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.144326] EDD information not available.
[    2.144412] PM: Hibernation image not present or could not be loaded.
[    2.398986] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.531572] usb 1-1: New USB device found, idVendor=8087, idProduct=8000
[    2.531581] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.532045] hub 1-1:1.0: USB hub found
[    2.532225] hub 1-1:1.0: 8 ports detected
[    2.692674] ACPI: Battery Slot [BAT1] (battery present)
[    2.695261] Freeing unused kernel memory: 1356K (ffffffff81d1f000 -
ffffffff81e72000)
[    2.695264] Write protecting the kernel read-only data: 12288k
[    2.697552] Freeing unused kernel memory: 560K (ffff880002774000 -
ffff880002800000)
[    2.699079] usb 2-3: new high-speed USB device number 2 using xhci_hcd
[    2.699360] Freeing unused kernel memory: 472K (ffff880002b8a000 -
ffff880002c00000)
[    2.722905] systemd-udevd[125]: starting version 204
[    2.756285] rtsx_pci 0000:02:00.0: irq 57 for MSI/MSI-X
[    2.756326] rtsx_pci 0000:02:00.0: rtsx_pci_acquire_irq:
pcr->msi_en = 1, pci->irq = 57
[    2.760398] ahci 0000:00:1f.2: version 3.0
[    2.760609] ahci 0000:00:1f.2: irq 58 for MSI/MSI-X
[    2.760657] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6
Gbps 0x3 impl SATA mode
[    2.760661] ahci 0000:00:1f.2: flags: 64bit ncq ilck pm led clo
only pio slum part deso sadm sds apst
[    2.761589] scsi0 : ahci
[    2.761760] scsi1 : ahci
[    2.763574] scsi2 : ahci
[    2.767087] scsi3 : ahci
[    2.767227] ata1: SATA max UDMA/133 abar m2048@0xb061b000 port
0xb061b100 irq 58
[    2.767233] ata2: SATA max UDMA/133 abar m2048@0xb061b000 port
0xb061b180 irq 58
[    2.767236] ata3: DUMMY
[    2.767239] ata4: DUMMY
[    2.855352] rtsx_pci: probe of 0000:02:00.0 failed with error -110
[    2.901654] usb 2-3: New USB device found, idVendor=1bcf, idProduct=2c40
[    2.901665] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.901670] usb 2-3: Product: HP TrueVision Full HD
[    2.901674] usb 2-3: Manufacturer: DDNKQ019I5A8HS
[    2.935268] tsc: Refined TSC clocksource calibration: 1296.997 MHz
[    3.071417] usb 2-5: new full-speed USB device number 3 using xhci_hcd
[    3.087365] ata2: SATA link down (SStatus 0 SControl 300)
[    3.087400] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.088577] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    3.088586] ata1.00: ATA-9: SAMSUNG MZMTD128HAFV-000H1, DXT41H0Q,
max UDMA/133
[    3.088591] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.089276] ata1.00: failed to get NCQ Send/Recv Log Emask 0x1
[    3.089435] ata1.00: configured for UDMA/133
[    3.089745] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG
MZMTD128 DXT4 PQ: 0 ANSI: 5
[    3.090324] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks:
(128 GB/119 GiB)
[    3.090415] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.090611] sd 0:0:0:0: [sda] Write Protect is off
[    3.090621] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.090697] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.093680]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
[    3.095697] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.143542] EXT4-fs (sda8): mounted filesystem with ordered data
mode. Opts: (null)
[    3.201237] usb 2-5: New USB device found, idVendor=0483, idProduct=91d1
[    3.201246] usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.201251] usb 2-5: Product: ST_SENSOR_HUB
[    3.201255] usb 2-5: Manufacturer: STMicroelectronics
[    3.201259] usb 2-5: SerialNumber: ST_SENSOR_HUB
[    3.367597] usb 2-6: new full-speed USB device number 4 using xhci_hcd
[    3.497497] usb 2-6: New USB device found, idVendor=06cb, idProduct=5710
[    3.497506] usb 2-6: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.497511] usb 2-6: Product: Synaptics Touch Pad V 103S
[    3.663732] usb 2-8: new full-speed USB device number 5 using xhci_hcd
[    3.936035] Switched to clocksource tsc
[    8.796123] usb 2-8: New USB device found, idVendor=04f3, idProduct=0117
[    8.796133] usb 2-8: New USB device strings: Mfr=4, Product=14,
SerialNumber=0
[    8.796138] usb 2-8: Product: Touchscreen
[    8.796142] usb 2-8: Manufacturer: ELAN
[    8.796400] usb 2-8: ep 0x2 - rounding interval to 64 microframes,
ep desc says 80 microframes
[    8.872830] random: init urandom read with 62 bits of entropy available
[    8.910877] init: plymouth-upstart-bridge main process (190)
terminated with status 1
[    8.910905] init: plymouth-upstart-bridge main process ended, respawning
[    8.922092] init: plymouth-upstart-bridge main process (200)
terminated with status 1
[    8.922119] init: plymouth-upstart-bridge main process ended, respawning
[    8.930158] init: ureadahead main process (193) terminated with status 5
[    8.930441] init: plymouth-upstart-bridge main process (203)
terminated with status 1
[    8.930454] init: plymouth-upstart-bridge main process ended, respawning
[    9.139409] Adding 3906556k swap on /dev/sda7.  Priority:-1
extents:1 across:3906556k SSFS
[    9.241870] systemd-udevd[324]: starting version 204
[    9.294645] EXT4-fs (sda8): re-mounted. Opts: errors=remount-ro
[    9.325743] lp: driver loaded but no devices found
[    9.353035] ppdev: user-space parallel port driver
[    9.466815] [drm] Initialized drm 1.1.0 20060810
[    9.476241] mei_me 0000:00:16.0: irq 57 for MSI/MSI-X
[    9.520541] wmi: Mapper loaded
[    9.566851] random: nonblocking pool is initialized
[    9.577872] cfg80211: Calling CRDA to update world regulatory domain
[    9.632162] hidraw: raw HID events driver (C) Jiri Kosina
[    9.643918] [drm] Memory usable by graphics device = 2048M
[    9.643926] checking generic (a0000000 410000) vs hw (a0000000 10000000)
[    9.643930] fb: switching to inteldrmfb from EFI VGA
[    9.643973] Console: switching to colour dummy device 80x25
[    9.678267] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3290,
rev 0015 detected
[    9.681835] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 3290 detected
[    9.701775] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    9.724347] usbcore: registered new interface driver usbhid
[    9.724354] usbhid: USB HID core driver
[    9.752457] i915 0000:00:02.0: irq 59 for MSI/MSI-X
[    9.752482] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.752484] [drm] Driver supports precise vblank timestamp query.
[    9.752530] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    9.769194] Linux video capture interface: v2.00
[    9.808077] AVX2 version of gcm_enc/dec engaged.
[    9.930434] uvcvideo: Found UVC 1.00 device HP TrueVision Full HD (1bcf:2c40)
[    9.953955] fbcon: inteldrmfb (fb0) is primary device
[   10.004533] Bluetooth: Core ver 2.19
[   10.004596] NET: Registered protocol family 31
[   10.004598] Bluetooth: HCI device and connection manager initialized
[   10.004610] Bluetooth: HCI socket layer initialized
[   10.004743] Bluetooth: L2CAP socket layer initialized
[   10.004753] Bluetooth: SCO socket layer initialized
[   10.014835] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.014836] Bluetooth: BNEP filters: protocol multicast
[   10.014847] Bluetooth: BNEP socket layer initialized
[   10.043741] input: HP TrueVision Full HD as
/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/input/input4
[   10.043939] usbcore: registered new interface driver uvcvideo
[   10.043940] USB Video Class driver (1.1.1)
[   10.102621] input: HP WMI hotkeys as /devices/virtual/input/input5
[   10.111756] cfg80211: World regulatory domain updated:
[   10.111759] cfg80211:  DFS Master region: unset
[   10.111760] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   10.111764] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   10.111767] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   10.111769] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   10.111772] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   10.111775] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   10.128262] input: ELAN Touchscreen as
/devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/0003:04F3:0117.0003/input/input6
[   10.128783] hid-multitouch 0003:04F3:0117.0003:
input,hiddev0,hidraw0: USB HID v1.10 Device [ELAN Touchscreen] on
usb-0000:00:14.0-8/input0
[   10.912202] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[   11.036179] Console: switching to colour frame buffer device 170x48
[   11.042893] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   11.042896] i915 0000:00:02.0: registered panic notifier
[   11.044903] Bluetooth: RFCOMM TTY layer initialized
[   11.044918] Bluetooth: RFCOMM socket layer initialized
[   11.044927] Bluetooth: RFCOMM ver 1.11
[   11.058305] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   11.058968] acpi device:2d: registered as cooling_device5
[   11.059148] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[   11.059283] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   11.061452] snd_hda_intel 0000:00:1b.0: irq 60 for MSI/MSI-X
[   11.068215] snd_hda_intel 0000:00:03.0: irq 61 for MSI/MSI-X
[   11.091072] sound hdaudioC1D0: autoconfig: line_outs=1
(0xd/0x0/0x0/0x0/0x0) type:speaker
[   11.091082] sound hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   11.091087] sound hdaudioC1D0:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   11.091091] sound hdaudioC1D0:    mono: mono_out=0x0
[   11.091094] sound hdaudioC1D0:    inputs:
[   11.091099] sound hdaudioC1D0:      Internal Mic=0xe
[   11.091104] sound hdaudioC1D0:      Mic=0xb
[   11.095574] input: HDA Intel HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input9
[   11.095699] input: HDA Intel HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input10
[   11.095833] input: HDA Intel HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input11
[   11.102664] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[   11.102816] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input13
[   11.130931] audit: type=1400 audit(1398718574.478:2):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/cups/backend/cups-pdf" pid=629 comm="apparmor_parser"
[   11.130939] audit: type=1400 audit(1398718574.478:3):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd"
pid=629 comm="apparmor_parser"
[   11.131609] audit: type=1400 audit(1398718574.478:4):
apparmor="STATUS" operation="profile_replace" name="/usr/sbin/cupsd"
pid=629 comm="apparmor_parser"
[   11.230512] audit: type=1400 audit(1398718574.578:5):
apparmor="STATUS" operation="profile_load" name="/sbin/dhclient"
pid=645 comm="apparmor_parser"
[   11.230525] audit: type=1400 audit(1398718574.578:6):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=645
comm="apparmor_parser"
[   11.230533] audit: type=1400 audit(1398718574.578:7):
apparmor="STATUS" operation="profile_load"
name="/usr/lib/connman/scripts/dhclient-script" pid=645
comm="apparmor_parser"
[   11.231383] audit: type=1400 audit(1398718574.578:8):
apparmor="STATUS" operation="profile_replace"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=645
comm="apparmor_parser"
[   11.231392] audit: type=1400 audit(1398718574.578:9):
apparmor="STATUS" operation="profile_replace"
name="/usr/lib/connman/scripts/dhclient-script" pid=645
comm="apparmor_parser"
[   11.231822] audit: type=1400 audit(1398718574.578:10):
apparmor="STATUS" operation="profile_replace"
name="/usr/lib/connman/scripts/dhclient-script" pid=645
comm="apparmor_parser"
[   11.369877] init: failsafe main process (656) killed by TERM signal
[   11.580983] audit: type=1400 audit(1398718574.930:11):
apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient"
pid=779 comm="apparmor_parser"
[   11.743451] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Loading firmware file 'rt3290.bin'
[   11.746073] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Firmware detected - version: 0.37
[   11.792818] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   12.545091] init: plymouth-upstart-bridge main process ended, respawning
[   12.558592] init: plymouth-upstart-bridge main process (1120)
terminated with status 1
[   12.558612] init: plymouth-upstart-bridge main process ended, respawning
[   13.833867] ahci 0000:00:1f.2: port does not support device sleep
[   13.975037] wlan0: authenticate with 64:70:02:e2:9b:99
[   13.990139] wlan0: send auth to 64:70:02:e2:9b:99 (try 1/3)
[   13.992059] wlan0: authenticated
[   13.994029] wlan0: associate with 64:70:02:e2:9b:99 (try 1/3)
[   13.997296] wlan0: RX AssocResp from 64:70:02:e2:9b:99 (capab=0x431
status=0 aid=6)
[   13.997384] wlan0: associated
[   13.997430] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   13.997523] cfg80211: Calling CRDA for country: CA
[   14.003183] cfg80211: Regulatory domain changed to country: CA
[   14.003191] cfg80211:  DFS Master region: unset
[   14.003193] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   14.003200] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2700 mBm), (N/A)
[   14.003204] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 1700 mBm), (N/A)
[   14.003209] cfg80211:   (5250000 KHz - 5330000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (0 s)
[   14.003212] cfg80211:   (5490000 KHz - 5710000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (0 s)
[   14.003216] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 3000 mBm), (N/A)
[   14.124553] wlan0: deauthenticating from 64:70:02:e2:9b:99 by local
choice (Reason: 2=PREV_AUTH_NOT_VALID)
[   14.146190] wlan0: authenticate with 64:70:02:e2:9b:99
[   14.154180] wlan0: send auth to 64:70:02:e2:9b:99 (try 1/3)
[   14.155496] cfg80211: Calling CRDA to update world regulatory domain
[   14.159594] cfg80211: World regulatory domain updated:
[   14.159602] cfg80211:  DFS Master region: unset
[   14.159605] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   14.159611] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   14.159616] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   14.159621] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   14.159625] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   14.159629] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (N/A)
[   14.164806] wlan0: authenticated
[   14.166094] wlan0: associate with 64:70:02:e2:9b:99 (try 1/3)
[   14.169333] wlan0: RX AssocResp from 64:70:02:e2:9b:99 (capab=0x431
status=0 aid=6)
[   14.169444] wlan0: associated
[   14.169745] cfg80211: Calling CRDA for country: CA
[   14.173991] cfg80211: Regulatory domain changed to country: CA
[   14.173999] cfg80211:  DFS Master region: unset
[   14.174002] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[   14.174007] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2700 mBm), (N/A)
[   14.174011] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 1700 mBm), (N/A)
[   14.174015] cfg80211:   (5250000 KHz - 5330000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (0 s)
[   14.174019] cfg80211:   (5490000 KHz - 5710000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm), (0 s)
[   14.174022] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 3000 mBm), (N/A)
[   20.133764] hid-generic 0003:06CB:5710.0002: usb_submit_urb(ctrl) failed: -1
[   20.133781] hid-generic 0003:06CB:5710.0002: timeout initializing reports
[   20.133900] input: Synaptics Touch Pad V 103S  as
/devices/pci0000:00/0000:00:14.0/usb2/2-6/2-6:1.0/0003:06CB:5710.0002/input/input14
[   20.134672] hid-generic 0003:06CB:5710.0002: input,hiddev0,hidraw1:
USB HID v1.11 Pointer [Synaptics Touch Pad V 103S ] on
usb-0000:00:14.0-6/input0
[  299.968830] mce: [Hardware Error]: Machine check events logged
