From: ulrik.debie-os@e2big.org
Subject: Re: Elantech touchpad on Fujitsu E554 not working at all
Date: Wed, 17 Dec 2014 23:09:58 +0100
Message-ID: <20141217220956.GA3730@lantern>
References: <CANWhK-ikUMJ8ZuX6VjoKgtb+o_OMKEU33y8ed=EQ9H-o2bOGLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:42181 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbaLQWK3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 17:10:29 -0500
Content-Disposition: inline
In-Reply-To: <CANWhK-ikUMJ8ZuX6VjoKgtb+o_OMKEU33y8ed=EQ9H-o2bOGLQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincent Jaubert <contact@vjaubert.com>
Cc: linux-input@vger.kernel.org

Hi,

could you provide the dmesg lines after startup (or at least those that=
 contain
the word "elantech") ?

Can you describe your mouse buttons please ? Are some located above/und=
er
the touchpad ?

Maybe next week I'll find some time to look into it, I'm currently on s=
ki
holidays.

Ulrik
On Wed, Dec 17, 2014 at 10:09:22PM +0100, Vincent Jaubert wrote:
> Date:	Wed, 17 Dec 2014 22:09:22 +0100
> From: Vincent Jaubert <contact@vjaubert.com>
> To: linux-input@vger.kernel.org
> Subject: Elantech touchpad on Fujitsu E554 not working at all
> X-Mailing-List:	linux-input@vger.kernel.org
>=20
> My touchpad on my brand new Fujitsu E554 doesn't work at all.
> Bios flashed with latest version.
> The touchpad works correctly under windows 7.
>=20
> Here is the partial output from "xinput -list" :
>=20
> Virtual core pointer                     id=3D2 [master pointer  (3)]
> =E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer               id=3D4=
 [slave  pointer  (2)]
> =E2=8E=9C   =E2=86=B3 USB Optical Mouse                       id=3D12=
 [slave  pointer  (2)]
> =E2=8E=9C   =E2=86=B3 Elantech PS/2 TrackPoint                 id=3D1=
4 [slave  pointer  (2)]
> =E2=8E=9C   =E2=86=B3 ETPS/2 Elantech Touchpad                 id=3D1=
5 [slave  pointer  (2)]
>=20
> The trackpoint is working correctly since 3.18.0.
> The touchpad doen't work at all.
>=20
> With "dmesg | grep mouse", i got lot of :
>=20
> [  377.818193] psmouse serio2: Touchpad at isa0060/serio2/input0 lost
> sync at byte 6
> [  377.818204] psmouse serio2: issuing reconnect request
>=20
> I'm on Ubuntu 14.10 x86-64, with 3.18.0 kernel compiled from kernel.o=
rg sources.
>=20
>=20
>=20
> Output of cat /proc/info :
> Linux version 3.18.0-vanillaice (root@vincent-LIFEBOOK-E554) (gcc
> version 4.9.1 (Ubuntu 4.9.1-16ubuntu6) ) #1 SMP Wed Dec 17 19:54:23
> CET 2014
>=20
> Outuput of lsb_release -rd  :
> Description: Ubuntu 14.10
> Release: 14.10
>=20
> Outuput of ver_linux :
>=20
> Linux vincent-LIFEBOOK-E554 3.18.0-vanillaice #1 SMP Wed Dec 17
> 19:54:23 CET 2014 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Gnu C                  4.9.1
> Gnu make               4.0
> binutils               2.24.90.20141014
> util-linux             2.25.1
> mount                  debug
> module-init-tools      18
> e2fsprogs              1.42.10
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.19
> Dynamic linker (ldd)   2.19
> Procps                 3.3.9
> Net-tools              1.60
> Kbd                    1.15.5
> Sh-utils               8.23
> wireless-tools         30
> Modules Loaded         isofs hid_generic usbhid hid ctr ccm arc4
> snd_hda_codec_hdmi iwlmvm mac80211 snd_hda_codec_realtek
> snd_hda_codec_generic iwlwifi rtsx_pci_ms memstick cfg80211 intel_rap=
l
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
> aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd snd_hda_intel
> snd_hda_controller snd_hda_codec snd_hwdep joydev snd_pcm serio_raw
> snd_seq_midi snd_seq_midi_event uvcvideo videobuf2_vmalloc snd_rawmid=
i
> videobuf2_memops videobuf2_core snd_seq cdc_mbim qcserial cdc_wdm
> v4l2_common cdc_ncm usb_wwan usbnet usbserial videodev media
> snd_seq_device snd_timer snd btusb mei_me mei soundcore lpc_ich shpch=
p
> i915 mac_hid drm_kms_helper ie31200_edac drm video i2c_algo_bit
> edac_core intel_rst fujitsu_laptop rfcomm bnep bluetooth parport_pc
> ppdev lp parport binfmt_misc rtsx_pci_sdmmc ahci libahci psmouse r816=
9
> rtsx_pci mii
>=20
> Output of cat /proc/cpuinfo
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
> stepping : 3
> microcode : 0x1c
> cpu MHz : 800.007
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monito=
r
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbas=
e
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 5188.49
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>=20
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
> stepping : 3
> microcode : 0x1c
> cpu MHz : 800.312
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monito=
r
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbas=
e
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 5188.49
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>=20
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
> stepping : 3
> microcode : 0x1c
> cpu MHz : 800.007
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 2
> initial apicid : 2
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monito=
r
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbas=
e
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 5188.49
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>=20
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 60
> model name : Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
> stepping : 3
> microcode : 0x1c
> cpu MHz : 800.109
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 3
> initial apicid : 3
> fpu : yes
> fpu_exception : yes
> cpuid level : 13
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monito=
r
> ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida
> arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbas=
e
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
> bugs :
> bogomips : 5188.49
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>=20
> output of cat /proc/modules
> isofs 39720 1 - Live 0x0000000000000000
> hid_generic 12559 0 - Live 0x0000000000000000
> usbhid 52565 0 - Live 0x0000000000000000
> hid 110066 2 hid_generic,usbhid, Live 0x0000000000000000
> ctr 13049 1 - Live 0x0000000000000000
> ccm 17731 1 - Live 0x0000000000000000
> arc4 12608 2 - Live 0x0000000000000000
> snd_hda_codec_hdmi 51974 1 - Live 0x0000000000000000
> iwlmvm 251094 0 - Live 0x0000000000000000
> mac80211 674115 1 iwlmvm, Live 0x0000000000000000
> snd_hda_codec_realtek 79613 1 - Live 0x0000000000000000
> snd_hda_codec_generic 68875 1 snd_hda_codec_realtek, Live 0x000000000=
0000000
> iwlwifi 186039 1 iwlmvm, Live 0x0000000000000000
> rtsx_pci_ms 18168 0 - Live 0x0000000000000000
> memstick 16966 1 rtsx_pci_ms, Live 0x0000000000000000
> cfg80211 513009 3 iwlmvm,mac80211,iwlwifi, Live 0x0000000000000000
> intel_rapl 18783 0 - Live 0x0000000000000000
> x86_pkg_temp_thermal 14205 0 - Live 0x0000000000000000
> intel_powerclamp 18786 0 - Live 0x0000000000000000
> coretemp 13441 0 - Live 0x0000000000000000
> kvm_intel 148273 0 - Live 0x0000000000000000
> kvm 466035 1 kvm_intel, Live 0x0000000000000000
> crct10dif_pclmul 14307 0 - Live 0x0000000000000000
> crc32_pclmul 13133 0 - Live 0x0000000000000000
> ghash_clmulni_intel 13230 0 - Live 0x0000000000000000
> aesni_intel 169590 2 - Live 0x0000000000000000
> aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
> lrw 13287 1 aesni_intel, Live 0x0000000000000000
> gf128mul 14951 1 lrw, Live 0x0000000000000000
> glue_helper 13944 1 aesni_intel, Live 0x0000000000000000
> ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
> cryptd 20360 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
> 0x0000000000000000
> snd_hda_intel 30520 6 - Live 0x0000000000000000
> snd_hda_controller 31872 1 snd_hda_intel, Live 0x0000000000000000
> snd_hda_codec 139421 5
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hd=
a_intel,snd_hda_controller,
> Live 0x0000000000000000
> snd_hwdep 17698 1 snd_hda_codec, Live 0x0000000000000000
> joydev 17344 0 - Live 0x0000000000000000
> snd_pcm 105335 5
> snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,
> Live 0x0000000000000000
> serio_raw 13434 0 - Live 0x0000000000000000
> snd_seq_midi 13564 0 - Live 0x0000000000000000
> snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
> uvcvideo 81109 0 - Live 0x0000000000000000
> videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
> snd_rawmidi 30876 1 snd_seq_midi, Live 0x0000000000000000
> videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
> videobuf2_core 47079 1 uvcvideo, Live 0x0000000000000000
> snd_seq 67178 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000=
000
> cdc_mbim 13400 0 - Live 0x0000000000000000
> qcserial 17286 0 - Live 0x0000000000000000
> cdc_wdm 23109 1 cdc_mbim, Live 0x0000000000000000
> v4l2_common 15682 1 videobuf2_core, Live 0x0000000000000000
> cdc_ncm 30903 1 cdc_mbim, Live 0x0000000000000000
> usb_wwan 19865 1 qcserial, Live 0x0000000000000000
> usbnet 43806 2 cdc_mbim,cdc_ncm, Live 0x0000000000000000
> usbserial 45100 2 qcserial,usb_wwan, Live 0x0000000000000000
> videodev 158682 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000=
000000000
> media 21963 2 uvcvideo,videodev, Live 0x0000000000000000
> snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000=
00000000000
> snd_timer 29458 2 snd_pcm,snd_seq, Live 0x0000000000000000
> snd 87611 22 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_g=
eneric,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_se=
q,snd_seq_device,snd_timer,
> Live 0x0000000000000000
> btusb 32336 0 - Live 0x0000000000000000
> mei_me 19568 0 - Live 0x0000000000000000
> mei 87928 1 mei_me, Live 0x0000000000000000
> soundcore 15052 2 snd_hda_codec,snd, Live 0x0000000000000000
> lpc_ich 21093 0 - Live 0x0000000000000000
> shpchp 37040 0 - Live 0x0000000000000000
> i915 997306 6 - Live 0x0000000000000000
> mac_hid 13227 0 - Live 0x0000000000000000
> drm_kms_helper 98384 1 i915, Live 0x0000000000000000
> ie31200_edac 12728 0 - Live 0x0000000000000000
> drm 317398 5 i915,drm_kms_helper, Live 0x0000000000000000
> video 20205 1 i915, Live 0x0000000000000000
> i2c_algo_bit 13406 1 i915, Live 0x0000000000000000
> edac_core 51809 1 ie31200_edac, Live 0x0000000000000000
> intel_rst 12900 0 - Live 0x0000000000000000
> fujitsu_laptop 18743 0 - Live 0x0000000000000000
> rfcomm 69427 8 - Live 0x0000000000000000
> bnep 19543 2 - Live 0x0000000000000000
> bluetooth 461507 22 btusb,rfcomm,bnep, Live 0x0000000000000000
> parport_pc 32741 0 - Live 0x0000000000000000
> ppdev 17635 0 - Live 0x0000000000000000
> lp 17759 0 - Live 0x0000000000000000
> parport 42264 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> binfmt_misc 17424 1 - Live 0x0000000000000000
> rtsx_pci_sdmmc 23190 0 - Live 0x0000000000000000
> ahci 34019 3 - Live 0x0000000000000000
> libahci 32190 1 ahci, Live 0x0000000000000000
> psmouse 111475 0 - Live 0x0000000000000000
> r8169 84648 0 - Live 0x0000000000000000
> rtsx_pci 46889 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
> mii 13934 2 usbnet,r8169, Live 0x0000000000000000
>=20
> cat /proc/ioports
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0061-0061 : PNP0800:00
>   0062-0062 : PNP0C09:00
>     0062-0062 : EC data
>   0064-0064 : keyboard
>   0066-0066 : PNP0C09:00
>     0066-0066 : EC cmd
>   0070-0077 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : fpu
>     00f0-00f0 : PNP0C04:00
>   03c0-03df : vesafb
>   0410-0415 : ACPI CPU throttle
>   04d0-04d1 : pnp 00:01
>   0600-0603 : pnp 00:01
>   0604-0607 : pnp 00:01
>   0800-087f : pnp 00:01
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   1640-164f : pnp 00:01
>   1800-187f : pnp 00:01
>     1800-1803 : ACPI PM1a_EVT_BLK
>     1804-1805 : ACPI PM1a_CNT_BLK
>     1808-180b : ACPI PM_TMR
>     1820-182f : ACPI GPE0_BLK
>     1830-1833 : iTCO_wdt
>     1850-1850 : ACPI PM2_CNT_BLK
>     1860-187f : iTCO_wdt
>   1880-18ff : pnp 00:01
>   2000-2003 : pnp 00:01
>   2100-217f : pnp 00:01
>   2180-21ff : pnp 00:01
>   3000-3fff : PCI Bus 0000:02
>     3000-30ff : 0000:02:00.0
>       3000-30ff : r8169
>   4000-403f : 0000:00:02.0
>   4060-407f : 0000:00:1f.2
>     4060-407f : ahci
>   4080-4087 : 0000:00:1f.2
>     4080-4087 : ahci
>   4088-408f : 0000:00:1f.2
>     4088-408f : ahci
>   4090-4093 : 0000:00:1f.2
>     4090-4093 : ahci
>   4094-4097 : 0000:00:1f.2
>     4094-4097 : ahci
>   efa0-efbf : 0000:00:1f.3
>   f800-f87f : pnp 00:01
>   f880-f8ff : pnp 00:01
>   fc00-fc7f : pnp 00:01
>   fc80-fcff : pnp 00:01
>   fd00-fd7f : pnp 00:01
>=20
>=20
> cat /proc/iomem
> 00000000-00000fff : reserved
> 00001000-0009cfff : System RAM
> 0009d000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000cebff : Video ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-c431bfff : System RAM
>   01000000-017a4a44 : Kernel code
>   017a4a45-01d302ff : Kernel data
>   01e95000-01fdffff : Kernel bss
> c431c000-c451dfff : reserved
> c451e000-da64efff : System RAM
> da64f000-dce3efff : reserved
> dce3f000-dcf9efff : ACPI Non-volatile Storage
> dcf9f000-dcffefff : ACPI Tables
> dcfff000-dcffffff : System RAM
> dd000000-df9fffff : reserved
>   dda00000-df9fffff : Graphics Stolen Memory
> dfa00000-feafffff : PCI Bus 0000:00
>   dfa10000-dfa1ffff : pnp 00:00
>   e0000000-efffffff : 0000:00:02.0
>   f0000000-f03fffff : 0000:00:02.0
>   f0400000-f04fffff : PCI Bus 0000:02
>     f0400000-f0403fff : 0000:02:00.0
>       f0400000-f0403fff : r8169
>   f0500000-f05fffff : PCI Bus 0000:04
>     f0500000-f0500fff : 0000:04:00.0
>       f0500000-f0500fff : rtsx_pci
>   f0600000-f06fffff : PCI Bus 0000:03
>     f0600000-f0601fff : 0000:03:00.0
>       f0600000-f0601fff : iwlwifi
>   f0700000-f07fffff : PCI Bus 0000:02
>     f0700000-f0700fff : 0000:02:00.0
>       f0700000-f0700fff : r8169
>   f0800000-f080ffff : 0000:00:14.0
>     f0800000-f080ffff : xhci-hcd
>   f0810000-f0813fff : 0000:00:03.0
>     f0810000-f0813fff : ICH HD audio
>   f0814000-f0817fff : 0000:00:1b.0
>     f0814000-f0817fff : ICH HD audio
>   f0818000-f08180ff : 0000:00:1f.3
>   f0819000-f081900f : 0000:00:16.0
>     f0819000-f081900f : mei_me
>   f081c000-f081c7ff : 0000:00:1f.2
>     f081c000-f081c7ff : ahci
>   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
>     f8000000-fbffffff : reserved
>       f8000000-fbffffff : pnp 00:00
> fec00000-fec00fff : reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : pnp 00:05
> fed08000-fed08fff : reserved
>   fed08000-fed08fff : pnp 00:00
> fed10000-fed19fff : reserved
>   fed10000-fed17fff : pnp 00:00
>   fed18000-fed18fff : pnp 00:00
>   fed19000-fed19fff : pnp 00:00
> fed1c000-fed1ffff : reserved
>   fed1c000-fed1ffff : pnp 00:00
>     fed1f410-fed1f414 : iTCO_wdt
> fed20000-fed3ffff : pnp 00:00
> fed40000-fed44fff : pnp 00:00
> fed45000-fed8ffff : pnp 00:00
> fed90000-fed93fff : pnp 00:00
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : reserved
> fef00000-feffffff : pnp 00:00
> ffa20000-ffffffff : reserved
> 100000000-41f5fffff : System RAM
> 41f600000-41fffffff : RAM buffer
>=20
> lspci -vvv
>=20
> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor DRAM Controller (rev 06)
> Subsystem: Fujitsu Limited. Device 17a6
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
>=20
> 00:02.0 VGA compatible controller: Intel Corporation 4th Gen Core
> Processor Integrated Graphics Controller (rev 06) (prog-if 00 [VGA
> controller])
> Subsystem: Fujitsu Limited. Device 17af
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 28
> Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=3D4M]
> Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
> Region 4: I/O ports at 4000 [size=3D64]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee0f00c  Data: 41b1
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
>=20
> 00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> Processor HD Audio Controller (rev 06)
> Subsystem: Fujitsu Limited. Device 17c6
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 30
> Region 0: Memory at f0810000 (64-bit, non-prefetchable) [size=3D16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee0f00c  Data: 41d1
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI=
 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> Kernel driver in use: snd_hda_intel
>=20
> 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipse=
t
> Family USB xHCI (rev 04) (prog-if 30 [XHCI])
> Subsystem: Fujitsu Limited. Device 17e1
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 24
> Region 0: Memory at f0800000 (64-bit, non-prefetchable) [size=3D64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
> Address: 00000000fee0300c  Data: 4171
> Kernel driver in use: xhci_hcd
>=20
> 00:16.0 Communication controller: Intel Corporation 8 Series/C220
> Series Chipset Family MEI Controller #1 (rev 04)
> Subsystem: Fujitsu Limited. Device 17dd
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 29
> Region 0: Memory at f0819000 (64-bit, non-prefetchable) [size=3D16]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 41c1
> Kernel driver in use: mei_me
>=20
> 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
> High Definition Audio Controller (rev 04)
> Subsystem: Fujitsu Limited. Device 17ff
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 31
> Region 0: Memory at f0814000 (64-bit, non-prefetchable) [size=3D16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4122
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI=
 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=3DFixed
> Status: InProgress-
> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
> Status: NegoPending- InProgress-
> VC1: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D2 ArbSelect=3DFixed TC/VC=3D04
> Status: NegoPending- InProgress-
> Kernel driver in use: snd_hda_intel
>=20
> 00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #1 (rev d4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <1us, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via
> WAKE# ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
>=20
> 00:1c.3 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #4 (rev d4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
> I/O behind bridge: 00003000-00003fff
> Memory behind bridge: f0700000-f07fffff
> Prefetchable memory behind bridge: 00000000f0400000-00000000f04fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
>=20
> 00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #6 (rev d4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: f0600000-f06fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #5, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
>=20
> 00:1c.7 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> Family PCI Express Root Port #8 (rev d4) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: f0500000-f05fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+
> BWMgmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not
> Supported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> Disabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000  Data: 0000
> Capabilities: [90] Subsystem: Fujitsu Limited. Device 17d3
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
>=20
> 00:1f.0 ISA bridge: Intel Corporation HM86 Express LPC Controller (re=
v 04)
> Subsystem: Fujitsu Limited. Device 17c7
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> Kernel driver in use: lpc_ich
>=20
> 00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
> Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 04) (prog-if
> 01 [AHCI 1.0])
> Subsystem: Fujitsu Limited. Device 17c9
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 26
> Region 0: I/O ports at 4088 [size=3D8]
> Region 1: I/O ports at 4094 [size=3D4]
> Region 2: I/O ports at 4080 [size=3D8]
> Region 3: I/O ports at 4090 [size=3D4]
> Region 4: I/O ports at 4060 [size=3D32]
> Region 5: Memory at f081c000 (32-bit, non-prefetchable) [size=3D2K]
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee0300c  Data: 4191
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> Kernel driver in use: ahci
>=20
> 00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
> SMBus Controller (rev 04)
> Subsystem: Fujitsu Limited. Device 17cf
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 7
> Region 0: Memory at f0818000 (64-bit, non-prefetchable) [size=3D256]
> Region 4: I/O ports at efa0 [size=3D32]
>=20
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> Subsystem: Fujitsu Limited. Device 17a2
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 27
> Region 0: I/O ports at 3000 [size=3D256]
> Region 2: Memory at f0700000 (64-bit, non-prefetchable) [size=3D4K]
> Region 4: Memory at f0400000 (64-bit, prefetchable) [size=3D16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 41a1
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64=
us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via
> message/WAKE#
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
> Vector table: BAR=3D4 offset=3D00000000
> PBA: BAR=3D4 offset=3D00000800
> Capabilities: [d0] Vital Product Data
> Unknown small resource type 00, will not decode more.
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=3DFixed
> Status: InProgress-
> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 02-4a-11-fe-ff-b2-7f-e4
> Capabilities: [170 v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Kernel driver in use: r8169
>=20
> 03:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
> Subsystem: Intel Corporation Wireless-N 7260
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 32
> Region 0: Memory at f0600000 (64-bit, non-prefetchable) [size=3D8K]
> Capabilities: [c8] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0100c  Data: 4142
> Capabilities: [40] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unl=
imited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s <4us, L1 <32us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAK=
E#
> DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR+, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP+ BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Device Serial Number a0-a8-cd-ff-ff-a7-be-3a
> Capabilities: [14c v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [154 v1] Vendor Specific Information: ID=3Dcafe Rev=3D1=
 Len=3D014 <?>
> Kernel driver in use: iwlwifi
>=20
> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> RTS5227 PCI Express Card Reader (rev 01)
> Subsystem: Fujitsu Limited. Device 187f
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 25
> Region 0: Memory at f0500000 (32-bit, non-prefetchable) [size=3D4K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee0f00c  Data: 4181
> Capabilities: [70] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
unlimited
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> L0s unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
> Via message/WAKE#
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> EqualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v2] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> MalfTLP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
> Capabilities: [150 v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [158 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
>  PortCommonModeRestoreTime=3D60us PortTPowerOnTime=3D60us
> Kernel driver in use: rtsx_pci
>=20
> --------------------------------------------------
>=20
> cat /proc/scsi/scsi
> Attached devices:
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: TSSTcorp Model: CDDVDW SU-208CB  Rev: FU01
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> Host: scsi4 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: SAMSUNG MZ7TE256 Rev: 200Q
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
