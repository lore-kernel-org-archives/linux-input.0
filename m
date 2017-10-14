From: Hendrik Langer <hendrik.langer@gmx.de>
Subject: Bug report: hid-rmi: kernel Oops / freeze on keyboard dock attach
Date: Sat, 14 Oct 2017 15:17:49 +0200
Message-ID: <dc71a4d2-b4ac-0bfb-697d-8adb89d812cd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59420 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdJNNR5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 14 Oct 2017 09:17:57 -0400
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org

Dear developer/maintainers,

there seems to be a problem with the Lenovo X1 Tablet (Skylake) keyboard
cover and the hid-rmi kernel module causing random crashes.

Since the Lenovo Thinkpad X1 Tablet dock is supported using hid-rmi
(kernel 4.11),
the system either freezes when I attach the dock (in this case no kernel
messages make it to the harddrive) or the kernel reports an "Oops" and
keeps running (without the keyboard though).
I've had it working two times after attaching it during the gdm login
screen, but after a restart the system froze again.

I'm not sure if the non-reproducible behaviour is affected by the way
the dock is attached and the contacts are made.

Up to Linux 4.10 the keyboard cover works with some kind of generic
driver, but it works.

Maybe related commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7821d0f3d81ef91aff037cef4e23c56bab30d26

Hardware: Thinkpad X1 Tablet (Skylake)

Affected Versions:
since the inclusion of the hid-rmi(?) module in Linux 4.11

# uname -a
Linux machine 4.14.0-rc3-amd64 #1 SMP Debian 4.14~rc3-1~exp1
(2017-10-02) x86_64 GNU/Linux

Since this is my first kernel bugreport and I don't know what to include
in case the system just crashes and nothing is logged: Please let me
know what kind of information i can provide to help solve the problem.


dmesg output on connecting the keyboard dock:

[  111.334490] usb 1-7: new full-speed USB device number 41 using xhci_hcd
[  111.334739] usb 1-7: Device not responding to setup address.
[  111.542708] usb 1-7: Device not responding to setup address.
[  111.750392] usb 1-7: device not accepting address 41, error -71
[  111.878428] usb 1-7: new full-speed USB device number 42 using xhci_hcd
[  111.878658] usb 1-7: Device not responding to setup address.
[  112.086642] usb 1-7: Device not responding to setup address.
[  112.294052] usb 1-7: device not accepting address 42, error -71
[  112.294125] usb usb1-port7: unable to enumerate USB device
[  115.254490] usb 1-7: new full-speed USB device number 43 using xhci_hcd
[  115.382672] usb 1-7: device descriptor read/64, error -71
[  115.618636] usb 1-7: device descriptor read/64, error -71
[  115.854628] usb 1-7: new full-speed USB device number 44 using xhci_hcd
[  116.007134] usb 1-7: New USB device found, idVendor=17ef, idProduct=6085
[  116.007142] usb 1-7: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  116.007147] usb 1-7: Product: ThinkPad X1 Tablet Thin Keyboard
[  116.007151] usb 1-7: Manufacturer: PRIMAX
[  116.572380] input: PRIMAX ThinkPad X1 Tablet Thin Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/0003:17EF:6085.0004/input/input20
[  116.630750] hid-rmi 0003:17EF:6085.0004: input,hidraw1: USB HID v1.11
Keyboard [PRIMAX ThinkPad X1 Tablet Thin Keyboard] on
usb-0000:00:14.0-7/input0
[  116.631085] input: PRIMAX ThinkPad X1 Tablet Thin Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.1/0003:17EF:6085.0005/input/input21
[  116.691275] hid-rmi 0003:17EF:6085.0005: input,hiddev1,hidraw2: USB
HID v1.11 Device [PRIMAX ThinkPad X1 Tablet Thin Keyboard] on
usb-0000:00:14.0-7/input1
[  117.030822] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3203-003, fw id: 2186154
[  117.454329] input: Synaptics TM3203-003 as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.2/0003:17EF:6085.0006/input/input22
[  117.454963] hid-rmi 0003:17EF:6085.0006: input,hiddev2,hidraw3: USB
HID v1.11 Mouse [PRIMAX ThinkPad X1 Tablet Thin Keyboard] on
usb-0000:00:14.0-7/input2
[  117.501628] usb 1-7: USB disconnect, device number 44
[  117.501718] BUG: unable to handle kernel NULL pointer dereference at
         (null)
[  117.501730] IP: device_del+0x17/0x320
[  117.501732] PGD 0 P4D 0
[  117.501736] Oops: 0000 [#1] SMP
[  117.501739] Modules linked in: psmouse hid_rmi rmi_core fuse rfcomm
acpi_call(O) ctr ccm cmac bnep nls_ascii nls_cp437 vfat fat qcserial
usb_wwan btusb btrtl btbcm btintel bluetooth drbg ansi_cprng
ecdh_generic cdc_mbim cdc_wdm cdc_ncm usbnet mii usbserial joydev wacom
usbhid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
msr spi_pxa2xx_platform arc4 i2c_designware_platform i2c_designware_core
wmi_bmof intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_soc_skl intel_cstate intel_uncore
intel_rapl_perf snd_soc_skl_ipc snd_soc_sst_ipc efi_pstore
snd_soc_sst_dsp iwlmvm snd_hda_ext_core snd_soc_sst_match snd_soc_core
snd_compress mac80211 pcspkr evdev serio_raw efivars snd_hda_intel
snd_hda_codec iTCO_wdt
[  117.501823]  iTCO_vendor_support snd_hda_core iwlwifi snd_hwdep
snd_pcm snd_timer cfg80211 rtsx_pci_ms memstick shpchp sg mei_me mei
hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_als hid_sensor_gyro_3d
hid_sensor_trigger hid_sensor_iio_common industrialio_triggered_buffer
i915 kfifo_buf industrialio drm_kms_helper idma64 drm thinkpad_acpi
processor_thermal_device intel_lpss_pci nvram snd soundcore i2c_algo_bit
intel_soc_dts_iosf wmi tpm_crb battery ac rfkill soc_button_array
intel_vbtn int3403_thermal intel_hid video sparse_keymap intel_lpss_acpi
intel_lpss int3400_thermal int3402_thermal int340x_thermal_zone button
acpi_thermal_rel parport_pc ppdev lp parport efivarfs ip_tables x_tables
autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb sd_mod
hid_sensor_custom hid_sensor_hub intel_ishtp_hid
[  117.501875]  rtsx_pci_sdmmc mmc_core crc32c_intel aesni_intel
aes_x86_64 crypto_simd cryptd glue_helper i2c_i801 ahci libahci libata
xhci_pci rtsx_pci mfd_core xhci_hcd scsi_mod usbcore intel_ish_ipc
usb_common intel_ishtp thermal i2c_hid hid
[  117.501897] CPU: 3 PID: 302 Comm: kworker/3:3 Tainted: G           O
  4.14.0-rc3-amd64 #1 Debian 4.14~rc3-1~exp1
[  117.501899] Hardware name: LENOVO 20GG002CGE/20GG002CGE, BIOS
N1LET63W (1.63 ) 02/17/2017
[  117.501915] Workqueue: usb_hub_wq hub_event [usbcore]
[  117.501918] task: ffff92b50983c000 task.stack: ffffa27381da8000
[  117.501923] RIP: 0010:device_del+0x17/0x320
[  117.501925] RSP: 0018:ffffa27381daba38 EFLAGS: 00010292
[  117.501928] RAX: ffffffffaf042400 RBX: 0000000000000000 RCX:
0000000000000000
[  117.501930] RDX: 0000000080000000 RSI: 000000007fffffff RDI:
0000000000000000
[  117.501931] RBP: ffffa27381daba70 R08: 0000000000000000 R09:
ffff92b4b7a45538
[  117.501933] R10: 0000000000000032 R11: ffff92b4b7a45559 R12:
0000000000000000
[  117.501935] R13: 0000000000000000 R14: ffff92b4d17a78b8 R15:
0000000000000060
[  117.501937] FS:  0000000000000000(0000) GS:ffff92b521580000(0000)
knlGS:0000000000000000
[  117.501939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.501941] CR2: 0000000000000000 CR3: 000000040d58d001 CR4:
00000000003606e0
[  117.501943] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  117.501945] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  117.501946] Call Trace:
[  117.501953]  ? kernfs_name_hash+0x17/0x80
[  117.501960]  rmi_unregister_transport_device+0x16/0x30 [rmi_core]
[  117.501964]  rmi_remove+0x33/0x40 [hid_rmi]
[  117.501969]  hid_device_remove+0x52/0xb0 [hid]
[  117.501974]  device_release_driver_internal+0x155/0x220
[  117.501977]  device_release_driver+0x12/0x20
[  117.501979]  bus_remove_device+0xe9/0x160
[  117.501983]  device_del+0x1e2/0x320
[  117.501988]  hid_destroy_device+0x27/0x60 [hid]
[  117.501993]  usbhid_disconnect+0x51/0x70 [usbhid]
[  117.502006]  usb_unbind_interface+0x72/0x260 [usbcore]
[  117.502010]  device_release_driver_internal+0x155/0x220
[  117.502012]  device_release_driver+0x12/0x20
[  117.502015]  bus_remove_device+0xe9/0x160
[  117.502018]  device_del+0x1e2/0x320
[  117.502029]  ? usb_remove_ep_devs+0x1f/0x30 [usbcore]
[  117.502040]  usb_disable_device+0x9e/0x270 [usbcore]
[  117.502052]  usb_disconnect+0x92/0x270 [usbcore]
[  117.502066]  hub_event+0x968/0x1580 [usbcore]
[  117.502072]  ? dequeue_task_fair+0x51b/0x680
[  117.502077]  process_one_work+0x191/0x380
[  117.502081]  worker_thread+0x4e/0x3c0
[  117.502086]  kthread+0x109/0x140
[  117.502089]  ? process_one_work+0x380/0x380
[  117.502094]  ? kthread_create_on_node+0x70/0x70
[  117.502099]  ret_from_fork+0x25/0x30
[  117.502102] Code: 00 00 00 00 00 41 5c 41 5d 5d c3 66 0f 1f 84 00 00
00 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 53 49 89 fc 48 83
ec 18 &lt;4c&gt; 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 45 d8 31 c0 48
8b 87
[  117.502159] RIP: device_del+0x17/0x320 RSP: ffffa27381daba38
[  117.502161] CR2: 0000000000000000
[  117.502164] ---[ end trace a175d02daea1bf31 ]---
[  117.674661] thinkpad_acpi: unhandled HKEY event 0x4013
[  117.674671] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  117.675002] acpi INT3400:00: Unsupported event [0x88]
[  117.675010] acpi INT3400:00: Unsupported event [0x87]
[  117.675763] int3403 thermal INT3403:01: Unsupported event [0x91]
[  117.675771] int3403 thermal INT3403:00: Unsupported event [0x91]
[  120.107287] thinkpad_acpi: unhandled HKEY event 0x4012
[  120.107303] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  120.107825] acpi INT3400:00: Unsupported event [0x88]
[  120.107837] acpi INT3400:00: Unsupported event [0x87]
[  120.108733] int3403 thermal INT3403:01: Unsupported event [0x91]
[  120.108745] int3403 thermal INT3403:00: Unsupported event [0x91]


detaching and attaching several times:

[   58.368835] usb 1-7: USB disconnect, device number 3
[   58.369055] BUG: unable to handle kernel NULL pointer dereference at
         (null)
[   58.369070] IP: device_del+0x17/0x320
[   58.369073] PGD 0 P4D 0
[   58.369078] Oops: 0000 [#1] SMP
[   58.369082] Modules linked in: fuse acpi_call(O) ctr ccm psmouse bnep
nls_ascii nls_cp437 vfat fat hid_rmi rmi_core qcserial usb_wwan btusb
btrtl btbcm btintel bluetooth drbg ansi_cprng ecdh_generic cdc_mbim
cdc_wdm cdc_ncm usbnet mii usbserial joydev snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic wacom usbhid msr
spi_pxa2xx_platform arc4 i2c_designware_platform i2c_designware_core
wmi_bmof intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm snd_soc_skl irqbypass snd_soc_skl_ipc snd_soc_sst_ipc
snd_soc_sst_dsp snd_hda_ext_core crct10dif_pclmul crc32_pclmul
snd_soc_sst_match snd_soc_core ghash_clmulni_intel snd_compress
intel_cstate iwlmvm efi_pstore mac80211 intel_uncore intel_rapl_perf
evdev iwlwifi serio_raw pcspkr efivars snd_hda_intel snd_hda_codec
snd_hda_core
[   58.369150]  snd_hwdep iTCO_wdt iTCO_vendor_support snd_pcm cfg80211
rtsx_pci_ms snd_timer mei_me sg memstick shpchp i915 mei
hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_als hid_sensor_accel_3d
hid_sensor_trigger idma64 hid_sensor_iio_common
industrialio_triggered_buffer kfifo_buf industrialio thinkpad_acpi
intel_lpss_pci nvram snd soundcore wmi rfkill battery ac
soc_button_array intel_vbtn int3403_thermal video button drm_kms_helper
intel_hid int3400_thermal processor_thermal_device int3402_thermal drm
intel_lpss_acpi acpi_thermal_rel intel_soc_dts_iosf int340x_thermal_zone
intel_lpss i2c_algo_bit tpm_crb sparse_keymap parport_pc ppdev lp
parport efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
crc32c_generic fscrypto ecb sd_mod hid_sensor_custom hid_sensor_hub
intel_ishtp_hid crc32c_intel
[   58.369213]  rtsx_pci_sdmmc mmc_core ahci libahci aesni_intel
aes_x86_64 libata crypto_simd cryptd glue_helper scsi_mod i2c_i801
rtsx_pci xhci_pci mfd_core xhci_hcd usbcore intel_ish_ipc intel_ishtp
usb_common thermal i2c_hid hid
[   58.369238] CPU: 2 PID: 300 Comm: kworker/2:4 Tainted: G           O
  4.14.0-rc3-amd64 #1 Debian 4.14~rc3-1~exp1
[   58.369240] Hardware name: LENOVO 20GG002CGE/20GG002CGE, BIOS
N1LET63W (1.63 ) 02/17/2017
[   58.369259] Workqueue: usb_hub_wq hub_event [usbcore]
[   58.369264] task: ffff92c588d18040 task.stack: ffffa2db81e38000
[   58.369269] RIP: 0010:device_del+0x17/0x320
[   58.369272] RSP: 0018:ffffa2db81e3ba38 EFLAGS: 00010292
[   58.369275] RAX: ffffffff94842400 RBX: 0000000000000000 RCX:
0000000000000000
[   58.369277] RDX: 0000000080000000 RSI: 000000007fffffff RDI:
0000000000000000
[   58.369279] RBP: ffffa2db81e3ba70 R08: 0000000000000000 R09:
ffff92c58c28b118
[   58.369281] R10: 000000000000000b R11: ffff92c58c28b139 R12:
0000000000000000
[   58.369283] R13: 0000000000000000 R14: ffff92c58cbcd8b8 R15:
0000000000000060
[   58.369286] FS:  0000000000000000(0000) GS:ffff92c5a1500000(0000)
knlGS:0000000000000000
[   58.369289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.369291] CR2: 0000000000000000 CR3: 000000040ded5006 CR4:
00000000003606e0
[   58.369293] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   58.369296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   58.369297] Call Trace:
[   58.369306]  ? kernfs_name_hash+0x17/0x80
[   58.369313]  rmi_unregister_transport_device+0x16/0x30 [rmi_core]
[   58.369318]  rmi_remove+0x33/0x40 [hid_rmi]
[   58.369326]  hid_device_remove+0x52/0xb0 [hid]
[   58.369331]  device_release_driver_internal+0x155/0x220
[   58.369335]  device_release_driver+0x12/0x20
[   58.369338]  bus_remove_device+0xe9/0x160
[   58.369342]  device_del+0x1e2/0x320
[   58.369348]  hid_destroy_device+0x27/0x60 [hid]
[   58.369355]  usbhid_disconnect+0x51/0x70 [usbhid]
[   58.369371]  usb_unbind_interface+0x72/0x260 [usbcore]
[   58.369375]  device_release_driver_internal+0x155/0x220
[   58.369379]  device_release_driver+0x12/0x20
[   58.369382]  bus_remove_device+0xe9/0x160
[   58.369386]  device_del+0x1e2/0x320
[   58.369401]  ? usb_remove_ep_devs+0x1f/0x30 [usbcore]
[   58.369415]  usb_disable_device+0x9e/0x270 [usbcore]
[   58.369428]  usb_disconnect+0x92/0x270 [usbcore]
[   58.369442]  hub_event+0x968/0x1580 [usbcore]
[   58.369447]  ? dequeue_task_fair+0x51b/0x680
[   58.369454]  process_one_work+0x191/0x380
[   58.369458]  worker_thread+0x4e/0x3c0
[   58.369463]  kthread+0x109/0x140
[   58.369466]  ? process_one_work+0x380/0x380
[   58.369471]  ? kthread_create_on_node+0x70/0x70
[   58.369478]  ret_from_fork+0x25/0x30
[   58.369488] Code: 00 00 00 00 00 41 5c 41 5d 5d c3 66 0f 1f 84 00 00
00 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 53 49 89 fc 48 83
ec 18 &lt;4c&gt; 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 45 d8 31 c0 48
8b 87
[   58.369551] RIP: device_del+0x17/0x320 RSP: ffffa2db81e3ba38
[   58.369553] CR2: 0000000000000000
[   58.369556] ---[ end trace f1fa498733367be2 ]---
[   58.551666] thinkpad_acpi: unhandled HKEY event 0x4013
[   58.551669] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   58.552312] acpi INT3400:00: Unsupported event [0x88]
[   58.552332] acpi INT3400:00: Unsupported event [0x87]
[   58.593510] int3403 thermal INT3403:01: Unsupported event [0x91]
[   58.593521] int3403 thermal INT3403:00: Unsupported event [0x91]
[   63.928340] thinkpad_acpi: unhandled HKEY event 0x4012
[   63.928349] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   63.928726] acpi INT3400:00: Unsupported event [0x88]
[   63.928734] acpi INT3400:00: Unsupported event [0x87]
[   63.929400] int3403 thermal INT3403:01: Unsupported event [0x91]
[   63.929407] int3403 thermal INT3403:00: Unsupported event [0x91]
[   64.977070] thinkpad_acpi: unhandled HKEY event 0x4013
[   64.977079] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   64.977457] acpi INT3400:00: Unsupported event [0x88]
[   64.977465] acpi INT3400:00: Unsupported event [0x87]
[   64.978124] int3403 thermal INT3403:01: Unsupported event [0x91]
[   64.978131] int3403 thermal INT3403:00: Unsupported event [0x91]
[   67.241170] thinkpad_acpi: unhandled HKEY event 0x4012
[   67.241179] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   67.241693] acpi INT3400:00: Unsupported event [0x88]
[   67.241701] acpi INT3400:00: Unsupported event [0x87]
[   67.242355] int3403 thermal INT3403:01: Unsupported event [0x91]
[   67.242361] int3403 thermal INT3403:00: Unsupported event [0x91]
[   67.788365] thinkpad_acpi: unhandled HKEY event 0x4013
[   67.788374] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   67.788891] acpi INT3400:00: Unsupported event [0x88]
[   67.788899] acpi INT3400:00: Unsupported event [0x87]
[   67.789629] int3403 thermal INT3403:01: Unsupported event [0x91]
[   67.789635] int3403 thermal INT3403:00: Unsupported event [0x91]
[   68.735583] thinkpad_acpi: unhandled HKEY event 0x4012
[   68.735592] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   68.736107] acpi INT3400:00: Unsupported event [0x88]
[   68.736114] acpi INT3400:00: Unsupported event [0x87]
[   68.736767] int3403 thermal INT3403:01: Unsupported event [0x91]
[   68.736773] int3403 thermal INT3403:00: Unsupported event [0x91]
[   81.869742] thinkpad_acpi: unhandled HKEY event 0x4013
[   81.869751] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[   81.870287] acpi INT3400:00: Unsupported event [0x88]
[   81.870295] acpi INT3400:00: Unsupported event [0x87]
[   81.870955] int3403 thermal INT3403:01: Unsupported event [0x91]
[   81.870961] int3403 thermal INT3403:00: Unsupported event [0x91]
[  110.926294] thinkpad_acpi: unhandled HKEY event 0x4012
[  110.926299] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  110.926610] acpi INT3400:00: Unsupported event [0x88]
[  110.926613] acpi INT3400:00: Unsupported event [0x87]
[  110.927000] int3403 thermal INT3403:01: Unsupported event [0x91]
[  110.927002] int3403 thermal INT3403:00: Unsupported event [0x91]
[  161.088709] thinkpad_acpi: unhandled HKEY event 0x4013
[  161.088718] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  161.089106] acpi INT3400:00: Unsupported event [0x88]
[  161.089115] acpi INT3400:00: Unsupported event [0x87]
[  161.128673] int3403 thermal INT3403:01: Unsupported event [0x91]
[  161.128683] int3403 thermal INT3403:00: Unsupported event [0x91]
[  164.764926] thinkpad_acpi: unhandled HKEY event 0x4012
[  164.764935] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  164.765449] acpi INT3400:00: Unsupported event [0x88]
[  164.765457] acpi INT3400:00: Unsupported event [0x87]
[  164.766102] int3403 thermal INT3403:01: Unsupported event [0x91]
[  164.766108] int3403 thermal INT3403:00: Unsupported event [0x91]
[  165.964877] thinkpad_acpi: unhandled HKEY event 0x4013
[  165.964886] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  165.965409] acpi INT3400:00: Unsupported event [0x88]
[  165.965417] acpi INT3400:00: Unsupported event [0x87]
[  165.966070] int3403 thermal INT3403:01: Unsupported event [0x91]
[  165.966076] int3403 thermal INT3403:00: Unsupported event [0x91]
[  166.261014] thinkpad_acpi: unhandled HKEY event 0x4012
[  166.261022] thinkpad_acpi: please report the conditions when this
event happened to ibm-acpi-devel@lists.sourceforge.net
[  166.261616] acpi INT3400:00: Unsupported event [0x88]
[  166.261626] acpi INT3400:00: Unsupported event [0x87]
[  166.262303] int3403 thermal INT3403:01: Unsupported event [0x91]
[  166.262309] int3403 thermal INT3403:00: Unsupported event [0x91]

Regards,
Hendrik
