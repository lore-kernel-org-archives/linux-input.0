From: gregory@auburndaletech.com
Subject: Touchpad message about hid-rmi
Date: Thu, 05 Oct 2017 10:23:04 -0400
Message-ID: <1507213384.5910.1.camel@auburndaletech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46464 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEOXI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 10:23:08 -0400
Received: by mail-qt0-f172.google.com with SMTP id 6so16543680qtw.3
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 07:23:08 -0700 (PDT)
Received: from g2001-4878-a000-3000-3331-68cb-c5f6-9333.deploy.static.akamaitechnologies.com ([2001:4878:a000:3000:3331:68cb:c5f6:9333])
        by smtp.gmail.com with ESMTPSA id c7sm11762368qtg.30.2017.10.05.07.23.06
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 07:23:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Kernel input hackers,

I recently got  a System76 Galaga Pro that I've been having some issues
with the touchpad on.   One of the main oddities was the following
messages:

[  784.876080] psmouse serio2: TouchPad at isa0060/serio2/input0 lost
synchronization, throwing 4 bytes away.
[  794.324013] psmouse serio2: TouchPad at isa0060/serio2/input0 lost
synchronization, throwing 4 bytes away.
[  820.126753] psmouse serio2: TouchPad at isa0060/serio2/input0 lost
synchronization, throwing 4 bytes away.
[  828.493701] psmouse serio2: TouchPad at isa0060/serio2/input0 lost
synchronization, throwing 4 bytes away

 I did notice the following message today:

[  631.408929] psmouse serio2: synaptics: Your touchpad (PNP: SYN1221
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.k
ernel.org.
			

I'm currently running on the 4.13.3 kernel.

I set synaptics_intertouch=1 in /etc/modprobe.d/psmouse.cconf and then
did an rmmod psmouse && modprobe psmouse, which seems to have helped
with those synchronization messages.  It did trigger the following
though:

[  948.079251] ------------[ cut here ]------------
[  948.079269] WARNING: CPU: 2 PID: 137 at
drivers/gpu/drm/i915/intel_display.c:12844
intel_atomic_commit_tail+0xf6f/0xf80 [i915]
[  948.079269] Modules linked in: psmouse hid_rmi rmi_core tun rfcomm
xt_nat xt_tcpudp veth vxlan ip6_udp_tunnel udp_tunnel iptable_mangle
xt_mark fuse ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack
nf_nat nf_conntrack libcrc32c crc32c_generic br_netfilter bridge stp
llc overlay joydev mousedev snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic bnep snd_soc_skl snd_soc_skl_ipc arc4
snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core snd_soc_sst_match
snd_soc_core snd_compress snd_pcm_dmaengine ac97_bus iTCO_wdt
iTCO_vendor_support snd_hda_intel i915 snd_hda_codec intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp uvcvideo
videobuf2_vmalloc videobuf2_memops
[  948.079294]  videobuf2_v4l2 iwlmvm videobuf2_core mac80211 kvm_intel
nls_iso8859_1 drm_kms_helper videodev nls_cp437 snd_hda_core vfat fat
snd_hwdep media iwlwifi kvm drm snd_pcm irqbypass snd_timer
intel_cstate mei_me intel_rapl_perf evdev input_leds led_class mac_hid
snd intel_gtt pcspkr hci_uart cfg80211 syscopyarea soundcore
sysfillrect sysimgblt fb_sys_fops btusb btrtl rtsx_pci_ms i2c_i801 mei
memstick r8169 i2c_algo_bit btbcm mii btqca btintel intel_pch_thermal
shpchp tpm_tis tpm_tis_core tpm wmi thermal bluetooth ecdh_generic
intel_lpss_acpi i2c_hid rfkill pinctrl_sunrisepoint video pinctrl_intel
hid intel_lpss battery ac acpi_pad button sch_fq_codel sg crypto_user
ip_tables x_tables algif_skcipher af_alg rtsx_pci_sdmmc mmc_core
serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel
[  948.079328]  ghash_clmulni_intel pcbc aesni_intel crypto_simd
glue_helper cryptd ahci libahci xhci_pci libata nvme nvme_core xhci_hcd
rtsx_pci scsi_mod usbcore usb_common i8042 serio aes_x86_64 ext4 crc16
mbcache jbd2 fscrypto dm_crypt dm_mod dax [last unloaded: psmouse]
[  948.079341] CPU: 2 PID: 137 Comm: kworker/u8:3 Not tainted 4.13.3-1-
ARCH #1
[  948.079342] Hardware name: System76 Galago Pro/Galago Pro, BIOS
1.05.06RSA 07/12/2017
[  948.079355] Workqueue: events_unbound intel_atomic_commit_work
[i915]
[  948.079356] task: ffffa08428104d80 task.stack: ffffbbb741e4c000
[  948.079367] RIP: 0010:intel_atomic_commit_tail+0xf6f/0xf80 [i915]
[  948.079368] RSP: 0018:ffffbbb741e4fd88 EFLAGS: 00010282
[  948.079369] RAX: 000000000000001c RBX: 0000000000000000 RCX:
0000000000000000
[  948.079369] RDX: 0000000000000000 RSI: ffffa0843ed0dc78 RDI:
ffffa0843ed0dc78
[  948.079370] RBP: ffffbbb741e4fe40 R08: 0000000000000395 R09:
0000000000000004
[  948.079370] R10: ffffbbb741e4fd88 R11: 0000000000000001 R12:
000000000000db7a
[  948.079371] R13: ffffa0842abe0000 R14: ffffa08429370000 R15:
0000000000000001
[  948.079372] FS:  0000000000000000(0000) GS:ffffa0843ed00000(0000)
knlGS:0000000000000000
[  948.079373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  948.079373] CR2: 00000fbfa4a35000 CR3: 0000000370a09000 CR4:
00000000003406e0
[  948.079374] Call Trace:
[  948.079378]  ? dequeue_task_fair+0x49f/0x640
[  948.079379]  ? wait_woken+0x80/0x80
[  948.079391]  intel_atomic_commit_work+0x12/0x20 [i915]
[  948.079393]  process_one_work+0x1de/0x430
[  948.079394]  worker_thread+0x47/0x3f0
[  948.079396]  kthread+0x125/0x140
[  948.079397]  ? process_one_work+0x430/0x430
[  948.079398]  ? kthread_create_on_node+0x70/0x70
[  948.079400]  ret_from_fork+0x25/0x30
[  948.079401] Code: ff ff ff 48 83 c7 08 e8 20 54 3c c8 4c 8b 85 70 ff
ff ff 4d 85 c0 0f 85 7b fa ff ff 8d 73 41 48 c7 c7 b8 ac dc c0 e8 82 0a
3e c8 <0f> ff e9 65 fa ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 
[  948.079422] ---[ end trace f49dd79648f7efcd ]---
