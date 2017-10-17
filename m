From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Bug report: hid-rmi: kernel Oops / freeze on keyboard dock
 attach
Date: Tue, 17 Oct 2017 14:58:11 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710171456100.9294@jbgna.fhfr.qr>
References: <dc71a4d2-b4ac-0bfb-697d-8adb89d812cd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbdJQM6N (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Oct 2017 08:58:13 -0400
In-Reply-To: <dc71a4d2-b4ac-0bfb-697d-8adb89d812cd@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hendrik Langer <hendrik.langer@gmx.de>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org

On Sat, 14 Oct 2017, Hendrik Langer wrote:

> Dear developer/maintainers,
> 
> there seems to be a problem with the Lenovo X1 Tablet (Skylake) keyboard
> cover and the hid-rmi kernel module causing random crashes.
[ ... snip ... ]
> [  117.501718] BUG: unable to handle kernel NULL pointer dereference at
>          (null)
> [  117.501730] IP: device_del+0x17/0x320
> [  117.501732] PGD 0 P4D 0
> [  117.501736] Oops: 0000 [#1] SMP
> [  117.501739] Modules linked in: psmouse hid_rmi rmi_core fuse rfcomm
> acpi_call(O) ctr ccm cmac bnep nls_ascii nls_cp437 vfat fat qcserial
> usb_wwan btusb btrtl btbcm btintel bluetooth drbg ansi_cprng
> ecdh_generic cdc_mbim cdc_wdm cdc_ncm usbnet mii usbserial joydev wacom
> usbhid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
> msr spi_pxa2xx_platform arc4 i2c_designware_platform i2c_designware_core
> wmi_bmof intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp
> kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel snd_soc_skl intel_cstate intel_uncore
> intel_rapl_perf snd_soc_skl_ipc snd_soc_sst_ipc efi_pstore
> snd_soc_sst_dsp iwlmvm snd_hda_ext_core snd_soc_sst_match snd_soc_core
> snd_compress mac80211 pcspkr evdev serio_raw efivars snd_hda_intel
> snd_hda_codec iTCO_wdt
> [  117.501823]  iTCO_vendor_support snd_hda_core iwlwifi snd_hwdep
> snd_pcm snd_timer cfg80211 rtsx_pci_ms memstick shpchp sg mei_me mei
> hid_sensor_magn_3d hid_sensor_accel_3d hid_sensor_als hid_sensor_gyro_3d
> hid_sensor_trigger hid_sensor_iio_common industrialio_triggered_buffer
> i915 kfifo_buf industrialio drm_kms_helper idma64 drm thinkpad_acpi
> processor_thermal_device intel_lpss_pci nvram snd soundcore i2c_algo_bit
> intel_soc_dts_iosf wmi tpm_crb battery ac rfkill soc_button_array
> intel_vbtn int3403_thermal intel_hid video sparse_keymap intel_lpss_acpi
> intel_lpss int3400_thermal int3402_thermal int340x_thermal_zone button
> acpi_thermal_rel parport_pc ppdev lp parport efivarfs ip_tables x_tables
> autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb sd_mod
> hid_sensor_custom hid_sensor_hub intel_ishtp_hid
> [  117.501875]  rtsx_pci_sdmmc mmc_core crc32c_intel aesni_intel
> aes_x86_64 crypto_simd cryptd glue_helper i2c_i801 ahci libahci libata
> xhci_pci rtsx_pci mfd_core xhci_hcd scsi_mod usbcore intel_ish_ipc
> usb_common intel_ishtp thermal i2c_hid hid
> [  117.501897] CPU: 3 PID: 302 Comm: kworker/3:3 Tainted: G           O
>   4.14.0-rc3-amd64 #1 Debian 4.14~rc3-1~exp1
> [  117.501899] Hardware name: LENOVO 20GG002CGE/20GG002CGE, BIOS
> N1LET63W (1.63 ) 02/17/2017
> [  117.501915] Workqueue: usb_hub_wq hub_event [usbcore]
> [  117.501918] task: ffff92b50983c000 task.stack: ffffa27381da8000
> [  117.501923] RIP: 0010:device_del+0x17/0x320
> [  117.501925] RSP: 0018:ffffa27381daba38 EFLAGS: 00010292
> [  117.501928] RAX: ffffffffaf042400 RBX: 0000000000000000 RCX:
> 0000000000000000
> [  117.501930] RDX: 0000000080000000 RSI: 000000007fffffff RDI:
> 0000000000000000
> [  117.501931] RBP: ffffa27381daba70 R08: 0000000000000000 R09:
> ffff92b4b7a45538
> [  117.501933] R10: 0000000000000032 R11: ffff92b4b7a45559 R12:
> 0000000000000000
> [  117.501935] R13: 0000000000000000 R14: ffff92b4d17a78b8 R15:
> 0000000000000060
> [  117.501937] FS:  0000000000000000(0000) GS:ffff92b521580000(0000)
> knlGS:0000000000000000
> [  117.501939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  117.501941] CR2: 0000000000000000 CR3: 000000040d58d001 CR4:
> 00000000003606e0
> [  117.501943] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  117.501945] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  117.501946] Call Trace:
> [  117.501953]  ? kernfs_name_hash+0x17/0x80
> [  117.501960]  rmi_unregister_transport_device+0x16/0x30 [rmi_core]
> [  117.501964]  rmi_remove+0x33/0x40 [hid_rmi]
> [  117.501969]  hid_device_remove+0x52/0xb0 [hid]
> [  117.501974]  device_release_driver_internal+0x155/0x220
> [  117.501977]  device_release_driver+0x12/0x20
> [  117.501979]  bus_remove_device+0xe9/0x160
> [  117.501983]  device_del+0x1e2/0x320
> [  117.501988]  hid_destroy_device+0x27/0x60 [hid]
> [  117.501993]  usbhid_disconnect+0x51/0x70 [usbhid]
> [  117.502006]  usb_unbind_interface+0x72/0x260 [usbcore]
> [  117.502010]  device_release_driver_internal+0x155/0x220
> [  117.502012]  device_release_driver+0x12/0x20
> [  117.502015]  bus_remove_device+0xe9/0x160
> [  117.502018]  device_del+0x1e2/0x320
> [  117.502029]  ? usb_remove_ep_devs+0x1f/0x30 [usbcore]
> [  117.502040]  usb_disable_device+0x9e/0x270 [usbcore]
> [  117.502052]  usb_disconnect+0x92/0x270 [usbcore]
> [  117.502066]  hub_event+0x968/0x1580 [usbcore]
> [  117.502072]  ? dequeue_task_fair+0x51b/0x680
> [  117.502077]  process_one_work+0x191/0x380
> [  117.502081]  worker_thread+0x4e/0x3c0
> [  117.502086]  kthread+0x109/0x140
> [  117.502089]  ? process_one_work+0x380/0x380
> [  117.502094]  ? kthread_create_on_node+0x70/0x70
> [  117.502099]  ret_from_fork+0x25/0x30

Andrew, this looks like rmi_unregister_transport_device() is being called 
for device for which rmi_register_transport_device() never happened.

Could this be because ->input_configured() callback has been skipped for 
this particular device for some reason in hidinput_connect()?

-- 
Jiri Kosina
SUSE Labs

