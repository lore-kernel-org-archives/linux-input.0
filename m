From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: Kernel-Panic when using Apple-Magic-Trackpad
Date: Thu, 30 Jan 2014 11:57:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401301156090.31013@pobox.suse.cz>
References: <52E96F57.30903@addiks.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39754 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbaA3K5J (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 05:57:09 -0500
In-Reply-To: <52E96F57.30903@addiks.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerrit Addiks <gerrit@addiks.de>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>

On Wed, 29 Jan 2014, Gerrit Addiks wrote:

> [1.] Kernel-Panic when using Apple-Magic-Trackpad

[ some CCs added ]

Could you please check whether patch from

	http://www.spinics.net/lists/linux-bluetooth/msg41725.html

works around the issue for you?

Thanks.

> 
> [2.] When the Linux-Kernel (>v3.11-rc1 in my case) gets used with the
>      Apple Magic Trackpad, it will Kernel-Panic in one of three ways:
> 
>       1. Switch to text-based UI and 'display' the panic.
>          (Photos of that can be found in [7.9.])
> 
>       2. Restore from the panic and dump all info from above into syslog.
>          I dont really know if that is really the same kernel-panic,
>          but it was triggered the exact same way and to my untrained eye it
>          looks related somehow. Also it just occoured just once and then
>          never again. The exact output frim syslog can be found in [7.8.]
> 
>       3. Freeze the whole computer to the point where not even the
>          numpad-LED works.
> 
>      It does not matter what computer is used. I have reproduced this panic
>      on two very different computers (A MacMini5.1 and a Dell MidTower) and
>      two physical instances of the trackpad, so i strongly assume
>      that this is only about the software, not caused by hardware fault.
> 
>      I have reproduced this kernel-panic in many versions between [v3.11-rc1]
>      and [v3.13]. I have also done a git bisect (which has eaten up my whole
>      weekend) and after 13 long steps i could find the first bad commit:
>        [b1a1442a23776756b254b69786848a94d92445ba]
>        [HID: core: fix reporting of raw events]
> 
>      For those who dont know (or dont want to know):
>       The Apple Magic Trackpad is a wireless pointing (and gestures) device
>       that connects using bluetooth. It is like a big notebook trackpad as
>       an own device. The linux driver for that thing is synaptics.
>       (But from the first bad commit it looks like hid is at fault)
> 
>      This report is based on the launchpad-report #1269600:
>        https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1269600
>        A few photos of the kernel-panic in textmode as well as some more
>        info's can be found there.
> 
>      This report was created according to the following guide:
>       https://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
> 
>      Because this is the first time for me to ever submit a report,
>      please do not think bad of me if i did something wrong.
>      I can be contacted via [gerrit@addiks.de] for any questions,
>      thank you for paying attention to this.
> 
> [3.] trackpad, synaptics, bluetooth, kernel-panic
> 
> [4.] /proc/version :
>       Linux version 3.13.0-031300-generic (apw@gomeisa)
>        (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
>        #201401192235 SMP Mon Jan 20 03:36:48 UTC 2014
> 
>      (This is a mainline-kernel acquired from:
>       [http://kernel.ubuntu.com/~kernel-ppa/mainline/?C=N;O=D])
> 
> [5.] I judge myself waaay too low-skilled to understand the oops-tracing.txt
>      in a short time, but i will try to understand it in the future.
>      I can just barely code C++ and have little to no internal knowledge about
>      the internal kernel.
>      Maybe someone can help me out here and tell me what to do, thanks.
> 
> [6.] I think it is impossible to test this without an Apple-Magic-Trackpad.
>      But if you do have one: just connect it, use it a while and see the
>      kernel cry in agony. (You may need to watch the syslog in case the kernel
>      survives the panic and just reports about it). In rare cases it can took
>      a few hours of use until it breaks, but in the very most cases it breaks
>      very in the first minutes.
> 
> [7.] Environment:
> 
>       The following information are collected while the trackpad is connected
>       and the linux version from [4.] is used and while the author (me) does
>       not dare to touch the trackpad to not cause another kernel-panic.
> 
> [7.1.] ver_linux :
> 
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux gerrit-testing-1404 3.13.0-031300-generic #201401192235 SMP Mon Jan 20
> 03:36:48 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
> 
> Gnu C                  4.8
> Gnu make               3.81
> binutils               2.24
> util-linux             2.20.1
> mount                  support
> module-init-tools      15
> e2fsprogs              1.42.9
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.18
> Dynamic linker (ldd)   2.18
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.21
> wireless-tools         30
> Modules Loaded         parport_pc ppdev bnep rfcomm intel_rapl
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm b43
> snd_hda_codec_hdmi snd_hda_codec_cirrus crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel aesni_intel aes_x86_64 mac80211 lrw snd_hda_intel gf128mul
> snd_hda_codec glue_helper snd_usb_audio i915 snd_usbmidi_lib ablk_helper
> snd_hwdep cryptd cfg80211 snd_seq_midi btusb snd_seq_midi_event
> hid_roccat_koneplus snd_rawmidi bluetooth hid_roccat snd_seq snd_pcm ssb
> drm_kms_helper applesmc hid_roccat_common hid_appleir snd_seq_device
> snd_page_alloc joydev drm input_polldev snd_timer microcode i2c_algo_bit snd
> apple_gmux shpchp soundcore lpc_ich lp mei_me mei apple_bl parport bcma
> mac_hid video hid_generic usbhid hid tg3 ptp firewire_ohci pps_core
> firewire_core sdhci_pci crc_itu_t sdhci
> 
> [7.2.] /proc/cpuinfo :
> 
> processor    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 42
> model name    : Intel(R) Core(TM) i5-2415M CPU @ 2.30GHz
> stepping    : 7
> microcode    : 0x1a
> cpu MHz        : 1269.582
> cache size    : 3072 KB
> physical id    : 0
> siblings    : 4
> core id        : 0
> cpu cores    : 2
> apicid        : 0
> initial apicid    : 0
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 13
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
> aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16
> xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx
> lahf_lm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
> bogomips    : 4589.28
> clflush size    : 64
> cache_alignment    : 64
> address sizes    : 36 bits physical, 48 bits virtual
> power management:
> 
> processor    : 1
> [... trimmed down, same as processor 0... ]
> 
> processor    : 2
> [... trimmed down, same as processor 0... ]
> 
> processor    : 3
> [... trimmed down, same as processor 0... ]
> 
> [7.3.] /proc/modules :
> 
> hid_magicmouse 13722 0 - Live 0x0000000000000000
> hidp 24353 1 - Live 0x0000000000000000
> parport_pc 36962 0 - Live 0x0000000000000000
> ppdev 17711 0 - Live 0x0000000000000000
> bnep 19884 2 - Live 0x0000000000000000
> rfcomm 74748 12 - Live 0x0000000000000000
> intel_rapl 19228 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14269 0 - Live 0x0000000000000000
> intel_powerclamp 19031 0 - Live 0x0000000000000000
> coretemp 17728 0 - Live 0x0000000000000000
> kvm_intel 144426 0 - Live 0x0000000000000000
> kvm 468147 1 kvm_intel, Live 0x0000000000000000
> b43 397438 0 - Live 0x0000000000000000
> snd_hda_codec_hdmi 46898 1 - Live 0x0000000000000000
> snd_hda_codec_cirrus 18855 1 - Live 0x0000000000000000
> crct10dif_pclmul 14250 0 - Live 0x0000000000000000
> crc32_pclmul 13160 0 - Live 0x0000000000000000
> ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
> aesni_intel 55720 0 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> mac80211 654124 1 b43, Live 0x0000000000000000
> lrw 13323 1 aesni_intel, Live 0x0000000000000000
> snd_hda_intel 57222 3 - Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> snd_hda_codec 199156 3 snd_hda_codec_hdmi,snd_hda_codec_cirrus,snd_hda_intel,
> Live 0x0000000000000000
> glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
> snd_usb_audio 156119 3 - Live 0x0000000000000000
> i915 816869 3 - Live 0x0000000000000000
> snd_usbmidi_lib 29576 1 snd_usb_audio, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> snd_hwdep 13613 2 snd_hda_codec,snd_usb_audio, Live 0x0000000000000000
> cryptd 20530 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> cfg80211 509407 2 b43,mac80211, Live 0x0000000000000000
> snd_seq_midi 13324 0 - Live 0x0000000000000000
> btusb 28326 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> hid_roccat_koneplus 15270 0 - Live 0x0000000000000000
> snd_rawmidi 30465 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
> bluetooth 411140 27 hidp,bnep,rfcomm,btusb, Live 0x0000000000000000
> hid_roccat 13485 1 hid_roccat_koneplus, Live 0x0000000000000000
> snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
> snd_pcm 107140 5 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_usb_audio,
> Live 0x0000000000000000
> ssb 63241 1 b43, Live 0x0000000000000000
> drm_kms_helper 53224 1 i915, Live 0x0000000000000000
> applesmc 19564 0 - Live 0x0000000000000000
> hid_roccat_common 13791 1 hid_roccat_koneplus, Live 0x0000000000000000
> hid_appleir 13010 0 - Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
> 0x0000000000000000
> snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
> joydev 17575 0 - Live 0x0000000000000000
> drm 308397 4 i915,drm_kms_helper, Live 0x0000000000000000
> input_polldev 13896 1 applesmc, Live 0x0000000000000000
> snd_timer 30038 2 snd_seq,snd_pcm, Live 0x0000000000000000
> microcode 23788 0 - Live 0x0000000000000000
> i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
> snd 73850 24
> snd_hda_codec_hdmi,snd_hda_codec_cirrus,snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_usbmidi_lib,snd_hwdep,snd_seq_midi,snd_rawmidi,snd_seq,snd_pcm,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> apple_gmux 13690 0 - Live 0x0000000000000000
> shpchp 37201 0 - Live 0x0000000000000000
> soundcore 12680 1 snd, Live 0x0000000000000000
> lpc_ich 21163 0 - Live 0x0000000000000000
> lp 17799 0 - Live 0x0000000000000000
> mei_me 18578 0 - Live 0x0000000000000000
> mei 82671 1 mei_me, Live 0x0000000000000000
> apple_bl 13993 1 apple_gmux, Live 0x0000000000000000
> parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> bcma 52421 1 b43, Live 0x0000000000000000
> mac_hid 13253 0 - Live 0x0000000000000000
> video 19859 2 i915,apple_gmux, Live 0x0000000000000000
> hid_generic 12548 0 - Live 0x0000000000000000
> usbhid 53067 0 - Live 0x0000000000000000
> hid 106254 6
> hid_magicmouse,hidp,hid_roccat_koneplus,hid_appleir,hid_generic,usbhid, Live
> 0x0000000000000000
> tg3 174880 0 - Live 0x0000000000000000
> ptp 18980 1 tg3, Live 0x0000000000000000
> firewire_ohci 45158 0 - Live 0x0000000000000000
> pps_core 19381 1 ptp, Live 0x0000000000000000
> firewire_core 69362 1 firewire_ohci, Live 0x0000000000000000
> sdhci_pci 19241 0 - Live 0x0000000000000000
> crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
> sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
> 
> [7.4.] A: /proc/ioports
> 
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>   0300-031f : applesmc
>   0400-0403 : ACPI PM1a_EVT_BLK
>   0404-0405 : ACPI PM1a_CNT_BLK
>   0408-040b : ACPI PM_TMR
>   0410-0415 : ACPI CPU throttle
>   0420-042f : ACPI GPE0_BLK
>   0430-0433 : iTCO_wdt
>   0450-0450 : ACPI PM2_CNT_BLK
>   0460-047f : iTCO_wdt
>   0500-057f : pnp 00:04
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   1000-100f : pnp 00:04
>   2000-203f : 0000:00:02.0
>   2060-206f : 0000:00:1f.2
>     2060-206f : ata_piix
>   20c0-20df : 0000:00:1d.0
>     20c0-20df : uhci_hcd
>   2120-213f : 0000:00:1a.0
>     2120-213f : uhci_hcd
>   2140-2147 : 0000:00:1f.2
>     2140-2147 : ata_piix
>   2148-214f : 0000:00:1f.2
>     2148-214f : ata_piix
>   2158-215b : 0000:00:1f.2
>     2158-215b : ata_piix
>   215c-215f : 0000:00:1f.2
>     215c-215f : ata_piix
>   3000-3fff : PCI Bus 0000:06
>   efa0-efbf : 0000:00:1f.3
>   ffe0-ffef : 0000:00:1f.2
>     ffe0-ffef : ata_piix
> 
> [7.4.] B: /proc/iomem
> 
> 00000000-00000fff : reserved
> 00001000-0008efff : System RAM
> 0008f000-0008ffff : reserved
> 00090000-0009fbff : System RAM
> 0009fc00-000fffff : reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000c0000-000cedff : Video ROM
>   000f0000-000fffff : System ROM
> 00100000-1fffffff : System RAM
>   01000000-0174d25d : Kernel code
>   0174d25e-01d1a3bf : Kernel data
>   01e74000-01fdafff : Kernel bss
> 20000000-201fffff : reserved
>   20000000-201fffff : pnp 00:09
> 20200000-3fffffff : System RAM
> 40000000-401fffff : reserved
>   40000000-401fffff : pnp 00:09
> 40200000-8ad33fff : System RAM
> 8ad34000-8ad5efff : ACPI Non-volatile Storage
> 8ad5f000-8afa1fff : ACPI Tables
> 8afa2000-8affefff : reserved
> 8afff000-8affffff : ACPI Tables
> 8b000000-8f9fffff : reserved
>   8ba00000-8f9fffff : Graphics Stolen Memory
> 8fa00000-feafffff : PCI Bus 0000:00
>   90000000-9fffffff : 0000:00:02.0
>     90000000-9012bfff : BOOTFB
>   a0000000-a03fffff : 0000:00:02.0
>   a0400000-a04fffff : PCI Bus 0000:02
>     a0400000-a040ffff : 0000:02:00.0
>       a0400000-a040ffff : tg3
>     a0410000-a041ffff : 0000:02:00.0
>       a0410000-a041ffff : tg3
>     a0420000-a042ffff : 0000:02:00.1
>       a0420000-a042ffff : mmc0
>   a0500000-a05fffff : PCI Bus 0000:04
>     a0500000-a05fffff : PCI Bus 0000:05
>       a0500000-a0503fff : 0000:05:00.0
>       a0504000-a05047ff : 0000:05:00.0
>         a0504000-a05047ff : firewire_ohci
>   a0600000-a06fffff : PCI Bus 0000:03
>     a0600000-a0603fff : 0000:03:00.0
>       a0600000-a0603fff : bcma-pci-bridge
>   a0700000-a07fffff : PCI Bus 0000:02
>   a0800000-a08fffff : PCI Bus 0000:01
>   a0900000-a0903fff : 0000:00:1b.0
>     a0900000-a0903fff : ICH HD audio
>   a0906800-a0906bff : 0000:00:1d.7
>     a0906800-a0906bff : ehci_hcd
>   a0906c00-a0906fff : 0000:00:1a.7
>     a0906c00-a0906fff : ehci_hcd
>   a0907000-a09070ff : 0000:00:1f.3
>   a0907100-a090710f : 0000:00:16.0
>     a0907100-a090710f : mei_me
>   a0a00000-a4efffff : PCI Bus 0000:06
>   a4f00000-a8efffff : PCI Bus 0000:06
>   e0000000-efffffff : reserved
>     e0000000-efffffff : pnp 00:08
>       e0000000-e9cfffff : PCI MMCONFIG 0000 [bus 00-9c]
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : pnp 00:02
> fed10000-fed13fff : reserved
> fed18000-fed19fff : reserved
>   fed18000-fed18fff : pnp 00:08
>   fed19000-fed19fff : pnp 00:08
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:08
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:08
> fed40000-fed44fff : PCI Bus 0000:00
> fed45000-fed8ffff : pnp 00:08
> fed90000-fed93fff : pnp 00:08
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> ff800000-ffffffff : reserved
> 100000000-26fdfffff : System RAM
> 26fe00000-26fffffff : RAM buffer
> 
> [7.5.] lspci -vvv
> 
> 00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family
> DRAM Controller (rev 09)
>     Subsystem: Apple Inc. Device 00e6
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
> Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: a0800000-a08fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [88] Subsystem: Apple Inc. Device 00e6
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 4191
>     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>         LnkCap:    Port #2, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0
> <1us, L1 <4us
>             ClockPM- Surprise- LLActRep- BwNot+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>             Changed: MRL- PresDet- LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [140 v1] Root Complex Link
>         Desc:    PortNumber=02 ComponentID=01 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed19000
>     Kernel driver in use: pcieport
> 
> 00:01.1 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core
> Processor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=00, secondary=06, subordinate=9c, sec-latency=0
>     I/O behind bridge: 00003000-00003fff
>     Memory behind bridge: a0a00000-a4efffff
>     Prefetchable memory behind bridge: 00000000a4f00000-00000000a8efffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [88] Subsystem: Apple Inc. Device 00e6
>     Capabilities: [80] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 41a1
>     Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>         LnkCap:    Port #3, Speed 5GT/s, Width x8, ASPM L0s L1, Latency L0
> <256ns, L1 <4us
>             ClockPM- Surprise- LLActRep- BwNot+
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled+ Retrain- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive-
> BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet+ LinkState-
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -3.5dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [140 v1] Root Complex Link
>         Desc:    PortNumber=03 ComponentID=01 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed19000
>     Kernel driver in use: pcieport
> 
> 00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core
> Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA
> controller])
>     Subsystem: Apple Inc. Device 00e6
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 46
>     Region 0: Memory at a0000000 (64-bit, non-prefetchable) [size=4M]
>     Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
>     Region 4: I/O ports at 2000 [size=64]
>     Expansion ROM at <unassigned> [disabled]
>     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 4152
>     Capabilities: [d0] Power Management version 2
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [a4] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: i915
> 
> 00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series
> Chipset Family MEI Controller #1 (rev 04)
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 45
>     Region 0: Memory at a0907100 (64-bit, non-prefetchable) [size=16]
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0f00c  Data: 4142
>     Kernel driver in use: mei_me
> 
> 00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family
> USB Universal Host Controller #5 (rev 05) (prog-if 00 [UHCI])
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 21
>     Region 4: I/O ports at 2120 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1a.7 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family
> USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 23
>     Region 0: Memory at a0906c00 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP+
>     Kernel driver in use: ehci-pci
> 
> 00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family
> High Definition Audio Controller (rev 05)
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 47
>     Region 0: Memory at a0900000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Address: 00000000fee0f00c  Data: 4162
>     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE- FLReset+
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
> <64ns, L1 <1us
>             ClockPM- Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
> BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>             Status:    NegoPending- InProgress-
>         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=22
>             Status:    NegoPending- InProgress-
>     Capabilities: [130 v1] Root Complex Link
>         Desc:    PortNumber=0f ComponentID=00 EltType=Config
>         Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
> LinkType=MemMapped LinkValid+
>             Addr:    00000000fed1c000
>     Kernel driver in use: snd_hda_intel
> 
> 00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI
> Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: a0700000-a07fffff
>     Prefetchable memory behind bridge: 00000000a0400000-00000000a04fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet- LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 41b1
>     Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2 [Core
> i7, 15", 2011]
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
> 
> 00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI
> Express Root Port 2 (rev b5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: a0600000-a06fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet- LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 41d1
>     Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2 [Core
> i7, 15", 2011]
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
> 
> 00:1c.2 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI
> Express Root Port 3 (rev b5) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: a0500000-a05fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 128 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
>             ClockPM- Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>             Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
> LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>             Changed: MRL- PresDet- LinkState+
>         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
> CRSVisible-
>         RootCap: CRSVisible-
>         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>         DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
>         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
>         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Address: fee0f00c  Data: 4122
>     Capabilities: [90] Subsystem: Intel Corporation Apple MacBookPro8,2 [Core
> i7, 15", 2011]
>     Capabilities: [a0] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Kernel driver in use: pcieport
> 
> 00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family
> USB Universal Host Controller #1 (rev 05) (prog-if 00 [UHCI])
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 19
>     Region 4: I/O ports at 20c0 [size=32]
>     Capabilities: [50] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: uhci_hcd
> 
> 00:1d.7 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family
> USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin A routed to IRQ 22
>     Region 0: Memory at a0906800 (32-bit, non-prefetchable) [size=1K]
>     Capabilities: [50] Power Management version 2
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [58] Debug port: BAR=1 offset=00a0
>     Capabilities: [98] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ehci-pci
> 
> 00:1f.0 ISA bridge: Intel Corporation HM65 Express Chipset Family LPC
> Controller (rev 05)
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>     Kernel driver in use: lpc_ich
> 
> 00:1f.2 IDE interface: Intel Corporation 6 Series/C200 Series Chipset Family 4
> port SATA IDE Controller (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
>     Subsystem: Intel Corporation Device 7270
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0
>     Interrupt: pin B routed to IRQ 19
>     Region 0: I/O ports at 2148 [size=8]
>     Region 1: I/O ports at 215c [size=4]
>     Region 2: I/O ports at 2140 [size=8]
>     Region 3: I/O ports at 2158 [size=4]
>     Region 4: I/O ports at 2060 [size=16]
>     Region 5: I/O ports at ffe0 [size=16]
>     Capabilities: [70] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [b0] PCI Advanced Features
>         AFCap: TP+ FLR+
>         AFCtrl: FLR-
>         AFStatus: TP-
>     Kernel driver in use: ata_piix
> 
> 00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus
> Controller (rev 05)
>     Subsystem: Intel Corporation Apple MacBookPro8,2 [Core i7, 15", 2011]
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin C routed to IRQ 11
>     Region 0: Memory at a0907000 (64-bit, non-prefetchable) [size=256]
>     Region 4: I/O ports at efa0 [size=32]
> 
> 02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57765 Gigabit
> Ethernet PCIe (rev 10)
>     Subsystem: Broadcom Corporation NetXtreme BCM57765 Gigabit Ethernet PCIe
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 16
>     Region 0: Memory at a0400000 (64-bit, prefetchable) [size=64K]
>     Region 2: Memory at a0410000 (64-bit, prefetchable) [size=64K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
>         Vector table: BAR=2 offset=00000000
>         PBA: BAR=2 offset=00000120
>     Capabilities: [ac] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> <64us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 4096 bytes
>         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [13c v1] Device Serial Number 00-00-3c-07-54-53-3a-a7
>     Capabilities: [150 v1] Power Budgeting <?>
>     Capabilities: [160 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: tg3
> 
> 02:00.1 SD Host controller: Broadcom Corporation BCM57765/57785 SDXC/MMC Card
> Reader (rev 10) (prog-if 01)
>     Subsystem: Broadcom Corporation Device 0000
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin B routed to IRQ 17
>     Region 0: Memory at a0420000 (64-bit, prefetchable) [size=64K]
>     Capabilities: [48] Power Management version 3
>         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>     Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [ac] Express (v2) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> <64us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
>             MaxPayload 128 bytes, MaxReadReq 4096 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <64us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
> Selectable De-emphasis: -6dB
>              Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> ComplianceSOS-
>              Compliance De-emphasis: -6dB
>         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
>              EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [150 v1] Power Budgeting <?>
>     Capabilities: [160 v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Kernel driver in use: sdhci-pci
> 
> 03:00.0 Network controller: Broadcom Corporation BCM4331 802.11a/b/g/n (rev
> 02)
>     Subsystem: Broadcom Corporation BCM4331 802.11a/b/g/n
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Interrupt: pin A routed to IRQ 17
>     Region 0: Memory at a0600000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [40] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
>     Capabilities: [58] Vendor Specific Information: Len=78 <?>
>     Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [d0] Express (v1) Endpoint, MSI 00
>         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1
> unlimited
>             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <2us, L1 <32us
>             ClockPM+ Surprise- LLActRep+ BwNot-
>         LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>     Capabilities: [13c v1] Virtual Channel
>         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
>         Arb:    Fixed- WRR32- WRR64- WRR128-
>         Ctrl:    ArbSelect=Fixed
>         Status:    InProgress-
>         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>             Status:    NegoPending- InProgress-
>     Capabilities: [160 v1] Device Serial Number 00-00-00-ff-ff-00-00-00
>     Capabilities: [16c v1] Power Budgeting <?>
>     Kernel driver in use: bcma-pci-bridge
> 
> 04:00.0 PCI bridge: Texas Instruments XIO2213A/B/XIO2221 PCI Express to PCI
> Bridge [Cheetah Express] (rev 01) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 0, Cache Line Size: 256 bytes
>     Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
>     I/O behind bridge: 0000f000-00000fff
>     Memory behind bridge: a0500000-a05fffff
>     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>     Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort+ <SERR- <PERR-
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>     Capabilities: [50] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Bridge: PM- B3+
>     Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
>         Address: 0000000000000000  Data: 0000
>     Capabilities: [80] Subsystem: Device 0000:0000
>     Capabilities: [90] Express (v1) PCI/PCI-X Bridge, MSI 00
>         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1
> <1us
>             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
>             MaxPayload 128 bytes, MaxReadReq 512 bytes
>         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
> <512ns, L1 <16us
>             ClockPM+ Surprise- LLActRep- BwNot-
>         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk+
>             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
>     Capabilities: [100 v1] Advanced Error Reporting
>         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq+ ACSViol-
>         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
>         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
>         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>         AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
> 
> 05:00.0 FireWire (IEEE 1394): Texas Instruments XIO2213A/B/XIO2221 IEEE-1394b
> OHCI Controller [Cheetah Express] (rev 01) (prog-if 10 [OHCI])
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>     Latency: 248 (500ns min, 1000ns max), Cache Line Size: 64 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at a0504000 (32-bit, non-prefetchable) [size=2K]
>     Region 1: Memory at a0500000 (32-bit, non-prefetchable) [size=16K]
>     Capabilities: [44] Power Management version 3
>         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
>     Kernel driver in use: firewire_ohci
> 
> [7.6.] /proc/scsi/scsi :
> 
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Hitachi HTS54505 Rev: PB4A
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> 
> [7.7.] git bisect log
> 
> git bisect start
> # good: [8bb495e3f02401ee6f76d1b1d77f3ac9f079e376] Linux 3.10
> git bisect good 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376
> # bad: [ad81f0545ef01ea651886dddac4bef6cec930092] Linux 3.11-rc1
> git bisect bad ad81f0545ef01ea651886dddac4bef6cec930092
> # good: [1286da8bc009cb2aee7f285e94623fc974c0c983] Merge tag 'sound-3.11' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good 1286da8bc009cb2aee7f285e94623fc974c0c983
> # bad: [1b375dc30710180c4b88cc59caba6e3481ec5c8b] mutex: Move ww_mutex
> definitions to ww_mutex.h
> git bisect bad 1b375dc30710180c4b88cc59caba6e3481ec5c8b
> # bad: [899dd388853071f5c8848545209d4e2c5d95b1d9] Merge tag
> 'for-linus-3.11-merge-window-part-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs
> git bisect bad 899dd388853071f5c8848545209d4e2c5d95b1d9
> # bad: [f5b63ac0f77ecab46796ba5d368ea5dd51834e6e] Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> git bisect bad f5b63ac0f77ecab46796ba5d368ea5dd51834e6e
> # bad: [3366dd9fa887ebbda4872e9554f853eaeda764be] Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid
> git bisect bad 3366dd9fa887ebbda4872e9554f853eaeda764be
> # good: [c039e3a8ddd52139d0f81711ecd757772f868b22] powerpc: Handle both new
> style and old style reserve maps
> git bisect good c039e3a8ddd52139d0f81711ecd757772f868b22
> # good: [e61aca5158a84932cf9fbbcbf8aef9cef63f5026] Merge branch 'kconfig-diet'
> from Dave Hansen
> git bisect good e61aca5158a84932cf9fbbcbf8aef9cef63f5026
> # good: [b8e0fe31a7c8623741f91bc27f925220341fdf81] HID: wiimote: support
> Nintendo Wii U Pro Controller
> git bisect good b8e0fe31a7c8623741f91bc27f925220341fdf81
> # bad: [08ec2dcc3527a20c619aca2fb36f800908256bac] Merge branches
> 'for-3.11/multitouch', 'for-3.11/sony' and 'for-3.11/upstream' into for-linus
> git bisect bad 08ec2dcc3527a20c619aca2fb36f800908256bac
> # good: [db58316892a5e9034efe718d4c1630788db7528f] Merge branches
> 'for-3.11/battery', 'for-3.11/elo', 'for-3.11/holtek' and
> 'for-3.11/i2c-hid-fixed' into for-linus
> git bisect good db58316892a5e9034efe718d4c1630788db7528f
> # bad: [a688393bd3fb27690a77f7ae8607b4969039bac5] HID: explain out-of-range
> check better
> git bisect bad a688393bd3fb27690a77f7ae8607b4969039bac5
> # bad: [b1a1442a23776756b254b69786848a94d92445ba] HID: core: fix reporting of
> raw events
> git bisect bad b1a1442a23776756b254b69786848a94d92445ba
> # good: [68e353fe476e7dab4644b9e7b4979b72726397ae] HID: add support for Huion
> 580 tablet
> git bisect good 68e353fe476e7dab4644b9e7b4979b72726397ae
> # first bad commit: [b1a1442a23776756b254b69786848a94d92445ba] HID: core: fix
> reporting of raw events
> 
> [7.8.] Information from syslog when kernel recovers
> 
> Jan 26 00:55:46 gerrit-testing-1404 colord: Profile added:
> icc-e78de847fc92f70fe2135cbd74d84353
> Jan 26 00:55:48 gerrit-testing-1404 dbus[617]: [system] Activating service
> name='org.freedesktop.UDisks2' (using servicehelper)
> Jan 26 00:55:48 gerrit-testing-1404 udisksd[2304]: udisks daemon version 2.1.2
> starting
> Jan 26 00:55:48 gerrit-testing-1404 dbus[617]: [system] Successfully activated
> service 'org.freedesktop.UDisks2'
> Jan 26 00:55:48 gerrit-testing-1404 udisksd[2304]: Acquired the name
> org.freedesktop.UDisks2 on the system message bus
> Jan 26 00:55:49 gerrit-testing-1404 udisksd[2304]: Cleaning up mount point
> /media/gerrit/a0632e71-0eb0-47f5-878c-20d0533ba044 (device 8:6 is not mounted)
> Jan 26 00:56:04 gerrit-testing-1404 bluetoothd[647]: Endpoint unregistered:
> sender=:1.45 path=/MediaEndpoint/HFPAG
> Jan 26 00:56:04 gerrit-testing-1404 bluetoothd[647]: Endpoint unregistered:
> sender=:1.45 path=/MediaEndpoint/HFPHS
> Jan 26 00:56:04 gerrit-testing-1404 bluetoothd[647]: Endpoint unregistered:
> sender=:1.45 path=/MediaEndpoint/A2DPSource
> Jan 26 00:56:04 gerrit-testing-1404 bluetoothd[647]: Endpoint unregistered:
> sender=:1.45 path=/MediaEndpoint/A2DPSink
> Jan 26 00:56:24 gerrit-testing-1404 kernel: [  174.632667] Bluetooth: HIDP
> (Human Interface Emulation) ver 1.2
> Jan 26 00:56:24 gerrit-testing-1404 kernel: [  174.632685] Bluetooth: HIDP
> socket layer initialized
> Jan 26 00:56:27 gerrit-testing-1404 kernel: [  177.740013] magicmouse
> 0005:05AC:030E.0008: unknown main item tag 0x0
> Jan 26 00:56:27 gerrit-testing-1404 kernel: [  177.740083] input: as
> /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/bluetooth/hci0/hci0:12/input17
> Jan 26 00:56:27 gerrit-testing-1404 kernel: [  177.740236] magicmouse
> 0005:05AC:030E.0008: input,hidraw2: BLUETOOTH HID v1.60 Mouse [] on
> 68:a8:6d:57:8f:80
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211489] BUG: unable to
> handle kernel NULL pointer dereference at 0000000000000048
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211556] IP:
> [<ffffffff8105cb16>] do_exit+0x2e6/0xa30
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211592] PGD 0
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211607] Thread overran
> stack, or stack corrupted
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211635] Oops: 0000 [#1] SMP
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.211659] Modules linked in:
> hid_magicmouse hidp parport_pc ppdev rfcomm bnep b43 mac80211 i915
> intel_powerclamp coretemp kvm_intel kvm cfg80211 snd_hda_codec_hdmi
> snd_hda_codec_cirrus snd_hda_intel snd_hda_codec snd_usb_audio snd_usbmidi_lib
> drm_kms_helper snd_hwdep snd_pcm btusb drm bluetooth snd_page_alloc
> snd_seq_midi snd_seq_midi_event crc32_pclmul snd_rawmidi ghash_clmulni_intel
> snd_seq aesni_intel ssb aes_x86_64 lrw gf128mul glue_helper ablk_helper
> snd_seq_device cryptd snd_timer snd applesmc mei_me hid_roccat_koneplus mei
> input_polldev hid_roccat joydev hid_roccat_common hid_appleir microcode
> apple_gmux shpchp soundcore bcma i2c_algo_bit lp apple_bl parport video
> lpc_ich mac_hid hid_generic tg3 firewire_ohci usbhid firewire_core ptp hid
> sdhci_pci sdhci crc_itu_t pps_core
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212207] CPU: 0 PID: 2506
> Comm: syndaemon Not tainted 3.10.0-custom-step5 #6
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212247] Hardware name:
> Apple Inc. Macmini5,1/Mac-8ED6AF5B48C039E1, BIOS MM51.88Z.0077.B10.1201241549
> 01/24/2012
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212303] task:
> ffff88021e128000 ti: ffff88021e338000 task.ti: ffff88021e338000
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212343] RIP:
> 0010:[<ffffffff8105cb16>]  [<ffffffff8105cb16>] do_exit+0x2e6/0xa30
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212389] RSP:
> 0018:ffff88021e339ec8  EFLAGS: 00010246
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212419] RAX:
> 0000000000000000 RBX: ffff88021e128000 RCX: 00000000000000b6
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212458] RDX:
> 00000000000000b6 RSI: 0000000000000001 RDI: 0000000000000001
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212496] RBP:
> ffff88021e339f38 R08: ffffffff81edc800 R09: 0000000000000001
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212534] R10:
> 0000000000000000 R11: ffffea0008798840 R12: ffff880253789a40
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212573] R13:
> ffff88021e128630 R14: ffff880253789aa8 R15: 00007fff52b704f8
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212612] FS:
> 0000000000000000(0000) GS:ffff88026fa00000(0000) knlGS:0000000000000000
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212655] CS:  0010 DS: 0000
> ES: 0000 CR0: 0000000080050033
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212686] CR2:
> 0000000000000048 CR3: 0000000001c0e000 CR4: 00000000000407f0
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212725] Stack:
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212738] ffff88021e128634
> 0000000101bec410 ffff88021e339f00 ffffffff8108f679
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212788] 0000000000000246
> 00007f7cb316e848 00007f7cb3173e80 ffff88021e339f18
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212836] 0000000000000246
> ffff88026436d500 0000000000000100 ffff88021e128000
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212884] Call Trace:
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212904]
> [<ffffffff8108f679>] ? vtime_account_user+0x69/0x80
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212939]
> [<ffffffff8105d2df>] do_group_exit+0x3f/0xa0
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.212971]
> [<ffffffff8105d354>] SyS_exit_group+0x14/0x20
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.213006]
> [<ffffffff816d7d2f>] tracesys+0xe1/0xe6
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.213034] Code: ff 48 89 df
> e8 5c d1 0c 00 be 01 00 00 00 48 89 df e8 9f f5 06 00 44 8b 4d 9c 45 85 c9 0f
> 85 8b 04 00 00 48 8b 43 08 48 8b 40 08 <48> 8b 78 48 e8 31 dc 05 00 48 89 df
> e8 a9 f3 3e 00 48 89 df e8
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.213289] RIP
> [<ffffffff8105cb16>] do_exit+0x2e6/0xa30
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.213324]  RSP
> <ffff88021e339ec8>
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.213344] CR2:
> 0000000000000048
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.226977] ---[ end trace
> 79422433cc8a77d4 ]---
> Jan 26 00:56:29 gerrit-testing-1404 kernel: [  180.226986] Fixing recursive
> fault but reboot is needed!
> 

-- 
Jiri Kosina
SUSE Labs
