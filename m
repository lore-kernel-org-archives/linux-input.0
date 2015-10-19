From: Mike Mestnik <cheako@mikemestnik.net>
Subject: Re: PROBLEM: ETPS/2 Elantech Touchpad dies after resume from suspend
 to RAM
Date: Mon, 19 Oct 2015 09:53:02 -0500
Message-ID: <CAF8px57iCSgvcO86JiGc5d+hG00_NO9G6GUqnTcfwhq5+yR4eg@mail.gmail.com>
References: <BAY169-W118D215BEBF901F03D30DC1F73A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36286 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbJSOxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 10:53:05 -0400
Received: by lffz202 with SMTP id z202so11316528lff.3
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2015 07:53:03 -0700 (PDT)
In-Reply-To: <BAY169-W118D215BEBF901F03D30DC1F73A0@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: WBH <biscuit_2014@outlook.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Smells like a known issue with gnome, fixed in recent releases.

On Sun, Oct 18, 2015 at 10:59 PM, WBH <biscuit_2014@outlook.com> wrote:
> [1.] One line summary of the problem:
> ETPS/2 Elantech Touchpad dies after resume from suspend to RAM
>
> [2.] Full description of the problem/report:
> When the system startup, the touchpad works well, but after it resume=
d from a suspend, the touchpad hardware will disappear from xinput and =
cat /proc/bus/input/devices.
>
> Before suspend, xinput output
> =E2=8E=A1 Virtual core pointer id=3D2 [master pointer (3)]
> =E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4 [slave pointer =
(2)]
> =E2=8E=9C =E2=86=B3 USB OPTICAL MOUSE id=3D10 [slave pointer (2)]
> =E2=8E=9C =E2=86=B3 ETPS/2 Elantech Touchpad id=3D14 [slave pointer (=
2)]
> =E2=8E=A3 Virtual core keyboard id=3D3 [master keyboard (2)]
> =E2=86=B3 Virtual core XTEST keyboard id=3D5 [slave keyboard (3)]
> =E2=86=B3 Power Button id=3D6 [slave keyboard (3)]
> =E2=86=B3 Video Bus id=3D7 [slave keyboard (3)]
> =E2=86=B3 Video Bus id=3D8 [slave keyboard (3)]
> =E2=86=B3 Sleep Button id=3D9 [slave keyboard (3)]
> =E2=86=B3 USB2.0 VGA UVC WebCam id=3D11 [slave keyboard (3)]
> =E2=86=B3 Asus WMI hotkeys id=3D12 [slave keyboard (3)]
> =E2=86=B3 AT Translated Set 2 keyboard id=3D13 [slave keyboard (3)]
>
> after suspend, the output
> =E2=8E=A1 Virtual core pointer id=3D2 [master pointer (3)]
> =E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4 [slave pointer =
(2)]
> =E2=8E=9C =E2=86=B3 USB OPTICAL MOUSE id=3D10 [slave pointer (2)]
> =E2=8E=A3 Virtual core keyboard id=3D3 [master keyboard (2)]
> =E2=86=B3 Virtual core XTEST keyboard id=3D5 [slave keyboard (3)]
> =E2=86=B3 Power Button id=3D6 [slave keyboard (3)]
> =E2=86=B3 Video Bus id=3D7 [slave keyboard (3)]
> =E2=86=B3 Video Bus id=3D8 [slave keyboard (3)]
> =E2=86=B3 Sleep Button id=3D9 [slave keyboard (3)]
> =E2=86=B3 USB2.0 VGA UVC WebCam id=3D11 [slave keyboard (3)]
> =E2=86=B3 Asus WMI hotkeys id=3D12 [slave keyboard (3)]
> =E2=86=B3 AT Translated Set 2 keyboard id=3D13 [slave keyboard (3)]
> And you can find that the " ETPS/2 Elantech Touchpad" is missing
> output of dmesg:
> dmesg|grep mouse
> [ 0.512423] mousedev: PS/2 mouse device common for all mice
> [ 1.114531] psmouse serio1: elantech: assuming hardware version 4 (wi=
th firmware version 0x381f00)
> [ 1.128082] psmouse serio1: elantech: Synaptics capabilities query re=
sult 0x10, 0x14, 0x0e.
>
> After a reboot, everything works well again.
>
> When I using s2disk with this conf file, the touchpad works well afte=
r resume. But if the "shutdown method" is set to platform, the hibernat=
e process will hang after snapshotting the system.
> # /etc/uswsusp.conf(5) -- Configuration file for s2disk/s2both
> resume device =3D /dev/disk/by-uuid/7b13204e-719a-4ee4-a523-909e75b56=
507
> compress =3D y
> early writeout =3D y
> image size =3D 0
> RSA key file =3D /etc/uswsusp.key
> shutdown method =3D shutdown
> compute checksum =3D y
> suspend loglevel =3D 1
> max loglevel =3D 15
>
>
> [3.] Keywords (i.e., modules, networking, kernel):
> [4.] Kernel version (from /proc/version):
> Linux version 4.3.0-040300rc5-generic (kernel@tangerine) (gcc version=
 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #201510111530 SMP Sun Oct 11 19:=
31:35 UTC 2015
>
> [5.] Output of Oops.. message (if applicable) with symbolic informati=
on
> resolved (see Documentation/oops-tracing.txt)
> [6.] A small shell script or example program which triggers the
> problem (if possible)
> $ sudo s2ram
>
> [7.] Environment
> Description: Ubuntu 14.04.3 LTS
> Release: 14.04
>
> [7.1.] Software (add the output of the ver_linux script here)
> Linux biscuit 4.3.0-040300rc5-generic #201510111530 SMP Sun Oct 11 19=
:31:35 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>
> Gnu C 4.8
> Gnu make 3.81
> binutils 2.24
> util-linux 2.20.1
> mount support
> module-init-tools 15
> e2fsprogs 1.42.9
> pcmciautils 018
> PPP 2.4.5
> Linux C Library 2.19
> Dynamic linker (ldd) 2.19
> Procps 3.3.9
> Net-tools 1.60
> Kbd 1.15.5
> Sh-utils 8.21
> wireless-tools 30
> Modules Loaded drbg ansi_cprng ctr ccm pci_stub vboxpci vboxnetadp vb=
oxnetflt vboxdrv cmac rfcomm bnep binfmt_misc nls_iso8859_1 snd_hda_cod=
ec_hdmi asus_nb_wmi asus_wmi mxm_wmi sparse_keymap snd_hda_codec_realte=
k snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hw=
dep snd_pcm uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core =
intel_rapl v4l2_common x86_pkg_temp_thermal videodev intel_powerclamp m=
edia coretemp snd_seq_midi arc4 kvm_intel snd_seq_midi_event kvm i915 a=
th9k crct10dif_pclmul snd_rawmidi crc32_pclmul ath9k_common ghash_clmul=
ni_intel aesni_intel ath9k_hw ath3k aes_x86_64 lrw btusb btrtl gf128mul=
 btbcm glue_helper ath ablk_helper btintel mac80211 cryptd bluetooth dr=
m_kms_helper snd_seq joydev input_leds drm serio_raw snd_seq_device snd=
_timer i2c_algo_bit cfg80211 fb_sys_fops intel_pch_thermal syscopyarea =
sysfillrect sysimgblt mei_me lpc_ich snd mei processor_thermal_device i=
ntel_soc_dts_iosf soundcore shpchp iosf_mbi ak8975 inv_mpu6050 industri=
alio_triggered_buffer parport_pc kfifo_buf industrialio wmi ppdev i2c_m=
ux i2c_hid snd_soc_sst_acpi dw_dmac dw_dmac_core video i2c_designware_p=
latform spi_pxa2xx_platform 8250_dw i2c_designware_core int3402_thermal=
 int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad mac_hid=
 lp parport hid_generic usbhid hid psmouse ahci r8169 libahci mii sdhci=
_acpi sdhci fjes
>
> [7.2.] Processor information (from /proc/cpuinfo):
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model : 61
> model name : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
> stepping : 4
> microcode : 0x18
> cpu MHz : 2200.429
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cp=
l vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic m=
ovbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3d=
nowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd=
seed adx smap xsaveopt
> bugs :
> bogomips : 4389.75
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 1
> vendor_id : GenuineIntel
> cpu family : 6
> model : 61
> model name : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
> stepping : 4
> microcode : 0x18
> cpu MHz : 2155.054
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 2
> initial apicid : 2
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cp=
l vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic m=
ovbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3d=
nowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd=
seed adx smap xsaveopt
> bugs :
> bogomips : 4389.75
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 2
> vendor_id : GenuineIntel
> cpu family : 6
> model : 61
> model name : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
> stepping : 4
> microcode : 0x18
> cpu MHz : 1445.468
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 0
> cpu cores : 2
> apicid : 1
> initial apicid : 1
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cp=
l vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic m=
ovbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3d=
nowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd=
seed adx smap xsaveopt
> bugs :
> bogomips : 4389.75
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> processor : 3
> vendor_id : GenuineIntel
> cpu family : 6
> model : 61
> model name : Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
> stepping : 4
> microcode : 0x18
> cpu MHz : 1389.265
> cache size : 3072 KB
> physical id : 0
> siblings : 4
> core id : 1
> cpu cores : 2
> apicid : 3
> initial apicid : 3
> fpu : yes
> fpu_exception : yes
> cpuid level : 20
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cp=
l vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic m=
ovbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3d=
nowprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd=
seed adx smap xsaveopt
> bugs :
> bogomips : 4389.75
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
>
> [7.3.] Module information (from /proc/modules):
> drbg 28672 1 - Live 0x0000000000000000
> ansi_cprng 16384 0 - Live 0x0000000000000000
> ctr 16384 2 - Live 0x0000000000000000
> ccm 20480 2 - Live 0x0000000000000000
> pci_stub 16384 1 - Live 0x0000000000000000
> vboxpci 24576 0 - Live 0x0000000000000000 (OE)
> vboxnetadp 28672 0 - Live 0x0000000000000000 (OE)
> vboxnetflt 28672 0 - Live 0x0000000000000000 (OE)
> vboxdrv 442368 3 vboxpci,vboxnetadp,vboxnetflt, Live 0x00000000000000=
00 (OE)
> cmac 16384 2 - Live 0x0000000000000000
> rfcomm 69632 8 - Live 0x0000000000000000
> bnep 20480 2 - Live 0x0000000000000000
> binfmt_misc 20480 1 - Live 0x0000000000000000
> nls_iso8859_1 16384 1 - Live 0x0000000000000000
> snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
> asus_nb_wmi 24576 0 - Live 0x0000000000000000
> asus_wmi 28672 1 asus_nb_wmi, Live 0x0000000000000000
> mxm_wmi 16384 0 - Live 0x0000000000000000
> sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
> snd_hda_codec_realtek 81920 1 - Live 0x0000000000000000
> snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0x000000000=
0000000
> snd_hda_intel 36864 5 - Live 0x0000000000000000
> snd_hda_codec 135168 4 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_h=
da_codec_generic,snd_hda_intel, Live 0x0000000000000000
> snd_hda_core 65536 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda=
_codec_generic,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
> snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
> snd_pcm 102400 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_h=
da_core, Live 0x0000000000000000
> uvcvideo 90112 0 - Live 0x0000000000000000
> videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
> videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
> videobuf2_core 49152 1 uvcvideo, Live 0x0000000000000000
> intel_rapl 20480 0 - Live 0x0000000000000000
> v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
> x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
> videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000=
000000000
> intel_powerclamp 16384 0 - Live 0x0000000000000000
> media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
> coretemp 16384 0 - Live 0x0000000000000000
> snd_seq_midi 16384 0 - Live 0x0000000000000000
> arc4 16384 2 - Live 0x0000000000000000
> kvm_intel 163840 0 - Live 0x0000000000000000
> snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
> kvm 507904 1 kvm_intel, Live 0x0000000000000000
> i915 1138688 5 - Live 0x0000000000000000
> ath9k 143360 0 - Live 0x0000000000000000
> crct10dif_pclmul 16384 0 - Live 0x0000000000000000
> snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
> crc32_pclmul 16384 0 - Live 0x0000000000000000
> ath9k_common 36864 1 ath9k, Live 0x0000000000000000
> ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
> aesni_intel 167936 6 - Live 0x0000000000000000
> ath9k_hw 466944 2 ath9k,ath9k_common, Live 0x0000000000000000
> ath3k 20480 0 - Live 0x0000000000000000
> aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
> lrw 16384 1 aesni_intel, Live 0x0000000000000000
> btusb 45056 0 - Live 0x0000000000000000
> btrtl 16384 1 btusb, Live 0x0000000000000000
> gf128mul 16384 1 lrw, Live 0x0000000000000000
> btbcm 16384 1 btusb, Live 0x0000000000000000
> glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
> ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
> ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
> btintel 16384 1 btusb, Live 0x0000000000000000
> mac80211 724992 1 ath9k, Live 0x0000000000000000
> cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 0x00=
00000000000000
> bluetooth 516096 26 rfcomm,bnep,ath3k,btusb,btrtl,btbcm,btintel, Live=
 0x0000000000000000
> drm_kms_helper 131072 1 i915, Live 0x0000000000000000
> snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000=
000
> joydev 20480 0 - Live 0x0000000000000000
> input_leds 16384 0 - Live 0x0000000000000000
> drm 352256 6 i915,drm_kms_helper, Live 0x0000000000000000
> serio_raw 16384 0 - Live 0x0000000000000000
> snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000=
00000000000
> snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
> i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
> cfg80211 540672 4 ath9k,ath9k_common,ath,mac80211, Live 0x00000000000=
00000
> fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
> intel_pch_thermal 16384 0 - Live 0x0000000000000000
> syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
> sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
> sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
> mei_me 28672 0 - Live 0x0000000000000000
> lpc_ich 24576 0 - Live 0x0000000000000000
> snd 81920 21 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_g=
eneric,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_se=
q,snd_seq_device,snd_timer, Live 0x0000000000000000
> mei 98304 1 mei_me, Live 0x0000000000000000
> processor_thermal_device 16384 0 - Live 0x0000000000000000
> intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x000000000=
0000000
> soundcore 16384 1 snd, Live 0x0000000000000000
> shpchp 36864 0 - Live 0x0000000000000000
> iosf_mbi 16384 2 intel_rapl,intel_soc_dts_iosf, Live 0x00000000000000=
00
> ak8975 16384 0 - Live 0x0000000000000000
> inv_mpu6050 20480 0 - Live 0x0000000000000000
> industrialio_triggered_buffer 16384 1 inv_mpu6050, Live 0x00000000000=
00000
> parport_pc 36864 0 - Live 0x0000000000000000
> kfifo_buf 16384 1 industrialio_triggered_buffer, Live 0x0000000000000=
000
> industrialio 57344 4 ak8975,inv_mpu6050,industrialio_triggered_buffer=
,kfifo_buf, Live 0x0000000000000000
> wmi 20480 2 asus_wmi,mxm_wmi, Live 0x0000000000000000
> ppdev 20480 0 - Live 0x0000000000000000
> i2c_mux 16384 1 inv_mpu6050, Live 0x0000000000000000
> i2c_hid 20480 0 - Live 0x0000000000000000
> snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
> dw_dmac 16384 0 - Live 0x0000000000000000
> dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
> video 36864 2 asus_wmi,i915, Live 0x0000000000000000
> i2c_designware_platform 16384 0 - Live 0x0000000000000000
> spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
> 8250_dw 16384 0 - Live 0x0000000000000000
> i2c_designware_core 16384 1 i2c_designware_platform, Live 0x000000000=
0000000
> int3402_thermal 16384 0 - Live 0x0000000000000000
> int340x_thermal_zone 16384 2 processor_thermal_device,int3402_thermal=
, Live 0x0000000000000000
> int3400_thermal 16384 0 - Live 0x0000000000000000
> acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
> acpi_pad 20480 0 - Live 0x0000000000000000
> mac_hid 16384 0 - Live 0x0000000000000000
> lp 20480 0 - Live 0x0000000000000000
> parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
> hid_generic 16384 0 - Live 0x0000000000000000
> usbhid 49152 0 - Live 0x0000000000000000
> hid 118784 3 i2c_hid,hid_generic,usbhid, Live 0x0000000000000000
> psmouse 122880 0 - Live 0x0000000000000000
> ahci 36864 5 - Live 0x0000000000000000
> r8169 81920 0 - Live 0x0000000000000000
> libahci 32768 1 ahci, Live 0x0000000000000000
> mii 16384 1 r8169, Live 0x0000000000000000
> sdhci_acpi 16384 0 - Live 0x0000000000000000
> sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000
> fjes 28672 0 - Live 0x0000000000000000
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/i=
omem)
> /proc/ioports:
> 0000-0cf7 : PCI Bus 0000:00
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-0060 : keyboard
> 0062-0062 : PNP0C09:00
> 0062-0062 : EC data
> 0064-0064 : keyboard
> 0066-0066 : PNP0C09:00
> 0066-0066 : EC cmd
> 0070-0077 : rtc0
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0240-0259 : pnp 00:00
> 0380-038f : pnp 00:00
> 0680-069f : pnp 00:03
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
> 164e-164f : pnp 00:03
> 1800-1803 : ACPI PM1a_EVT_BLK
> 1804-1805 : ACPI PM1a_CNT_BLK
> 1808-180b : ACPI PM_TMR
> 1810-1815 : ACPI CPU throttle
> 1830-1833 : iTCO_wdt.0.auto
> 1850-1850 : ACPI PM2_CNT_BLK
> 1854-1857 : pnp 00:05
> 1860-187f : iTCO_wdt.0.auto
> 1880-189f : ACPI GPE0_BLK
> 3000-3fff : PCI Bus 0000:04
> 3000-307f : 0000:04:00.0
> 4000-4fff : PCI Bus 0000:02
> 4000-40ff : 0000:02:00.0
> 4000-40ff : r8169
> 5000-503f : 0000:00:02.0
> 5040-505f : 0000:00:1f.3
> 5060-507f : 0000:00:1f.2
> 5060-507f : ahci
> 5080-5083 : 0000:00:1f.2
> 5080-5083 : ahci
> 5090-5097 : 0000:00:1f.2
> 5090-5097 : ahci
> 50a0-50a3 : 0000:00:1f.2
> 50a0-50a3 : ahci
> 50b0-50b7 : 0000:00:1f.2
> 50b0-50b7 : ahci
> ffff-ffff : pnp 00:03
> ffff-ffff : pnp 00:03
> ffff-ffff : pnp 00:03
>
> /proc/iomem:
> 00000000-00000fff : reserved
> 00001000-00057fff : System RAM
> 00058000-00058fff : reserved
> 00059000-0009dfff : System RAM
> 0009e000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c3fff : PCI Bus 0000:00
> 000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000cbfff : PCI Bus 0000:00
> 000cc000-000cffff : PCI Bus 0000:00
> 000d0000-000d3fff : PCI Bus 0000:00
> 000d4000-000d7fff : PCI Bus 0000:00
> 000d8000-000dbfff : PCI Bus 0000:00
> 000dc000-000dffff : PCI Bus 0000:00
> 000e0000-000e3fff : PCI Bus 0000:00
> 000e4000-000e7fff : PCI Bus 0000:00
> 000e8000-000ebfff : PCI Bus 0000:00
> 000ec000-000effff : PCI Bus 0000:00
> 000f0000-000fffff : System ROM
> 00100000-974a8fff : System RAM
> 02000000-027b900b : Kernel code
> 027b900c-02d3c4ff : Kernel data
> 02eb3000-02ff7fff : Kernel bss
> 974a9000-9780afff : reserved
> 9780b000-9ade5fff : System RAM
> 9ade6000-9ae45fff : reserved
> 9ae46000-9b28bfff : System RAM
> 9b28c000-9c41efff : ACPI Non-volatile Storage
> 9c41f000-9cee8fff : reserved
> 9cee9000-9cffefff : reserved
> 9cfff000-9cffffff : System RAM
> 9d000000-9d7fffff : RAM buffer
> 9d800000-9fffffff : reserved
> 9e000000-9fffffff : Graphics Stolen Memory
> a0000000-feafffff : PCI Bus 0000:00
> a0000000-a000ffff : pnp 00:06
> a0010000-a001ffff : pnp 00:06
> a1000000-a1ffffff : 0000:00:02.0
> a2000000-a30fffff : PCI Bus 0000:04
> a2000000-a2ffffff : 0000:04:00.0
> a3000000-a307ffff : 0000:04:00.0
> a3100000-a31fffff : PCI Bus 0000:03
> a3100000-a317ffff : 0000:03:00.0
> a3100000-a317ffff : ath9k
> a3180000-a318ffff : 0000:03:00.0
> a3200000-a32fffff : PCI Bus 0000:02
> a3200000-a3203fff : 0000:02:00.0
> a3200000-a3203fff : r8169
> a3204000-a3204fff : 0000:02:00.0
> a3204000-a3204fff : r8169
> a3300000-a330ffff : 0000:00:14.0
> a3300000-a330ffff : xhci-hcd
> a3310000-a3317fff : 0000:00:04.0
> a3318000-a331bfff : 0000:00:1b.0
> a3318000-a331bfff : ICH HD audio
> a331c000-a331ffff : 0000:00:03.0
> a331c000-a331ffff : ICH HD audio
> a3320000-a3320fff : 0000:00:1f.6
> a3320000-a3320fff : Intel PCH thermal driver
> a3321000-a33210ff : 0000:00:1f.3
> a3322000-a33227ff : 0000:00:1f.2
> a3322000-a33227ff : ahci
> a3324000-a332401f : 0000:00:16.0
> a3324000-a332401f : mei_me
> b0000000-bfffffff : 0000:00:02.0
> c0000000-d1ffffff : PCI Bus 0000:04
> c0000000-cfffffff : 0000:04:00.0
> d0000000-d1ffffff : 0000:04:00.0
> f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
> f8000000-fbffffff : reserved
> f8000000-fbffffff : pnp 00:06
> fec00000-fec00fff : reserved
> fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : reserved
> fed00000-fed003ff : HPET 0
> fed00000-fed003ff : PNP0103:00
> fed10000-fed17fff : pnp 00:06
> fed18000-fed18fff : pnp 00:06
> fed19000-fed19fff : pnp 00:06
> fed1c000-fed1ffff : reserved
> fed1c000-fed1ffff : pnp 00:06
> fed1f410-fed1f414 : iTCO_wdt.0.auto
> fed20000-fed3ffff : pnp 00:06
> fed45000-fed8ffff : pnp 00:06
> fed90000-fed90fff : dmar0
> fed91000-fed91fff : dmar1
> fee00000-fee00fff : Local APIC
> fee00000-fee00fff : reserved
> ff000000-ffffffff : reserved
> ff000000-ffffffff : INT0800:00
> ff000000-ffffffff : pnp 00:06
> 100000000-35effffff : System RAM
> 35f000000-35fffffff : RAM buffer
>
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: Intel Corporation Broadwell-U Host Bridge -OPI (=
rev 09)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort+>SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> Kernel driver in use: bdw_uncore
>
> 00:02.0 VGA compatible controller: Intel Corporation Broadwell-U Inte=
grated Graphics (rev 09) (prog-if 00 [VGA controller])
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 50
> Region 0: Memory at a1000000 (64-bit, non-prefetchable) [size=3D16M]
> Region 2: Memory at b0000000 (64-bit, prefetchable) [size=3D256M]
> Region 4: I/O ports at 5000 [size=3D64]
> Expansion ROM at <unassigned> [disabled]
> Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00018 Data: 0000
> Capabilities: [d0] Power Management version 2
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [a4] PCI Advanced Features
> AFCap: TP+ FLR+
> AFCtrl: FLR-
> AFStatus: TP-
> Kernel driver in use: i915
>
> 00:03.0 Audio device: Intel Corporation Broadwell-U Audio Controller =
(rev 09)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 52
> Region 0: Memory at a331c000 (64-bit, non-prefetchable) [size=3D16K]
> Capabilities: [50] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00378 Data: 0000
> Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI=
 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> Kernel driver in use: snd_hda_intel
>
> 00:04.0 Signal processing controller: Intel Corporation Broadwell-U C=
amarillo Device (rev 09)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 16
> Region 0: Memory at a3310000 (64-bit, non-prefetchable) [size=3D32K]
> Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000 Data: 0000
> Capabilities: [d0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> Kernel driver in use: proc_thermal
>
> 00:14.0 USB controller: Intel Corporation Wildcat Point-LP USB xHCI C=
ontroller (rev 03) (prog-if 30 [XHCI])
> Subsystem: ASUSTeK Computer Inc. Device 201f
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort- <TA=
bort- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 46
> Region 0: Memory at a3300000 (64-bit, non-prefetchable) [size=3D64K]
> Capabilities: [70] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
> Address: 00000000fee00298 Data: 0000
> Kernel driver in use: xhci_hcd
>
> 00:16.0 Communication controller: Intel Corporation Wildcat Point-LP =
MEI Controller #1 (rev 03)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 49
> Region 0: Memory at a3324000 (64-bit, non-prefetchable) [size=3D32]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee00318 Data: 0000
> Kernel driver in use: mei_me
>
> 00:1b.0 Audio device: Intel Corporation Wildcat Point-LP High Definit=
ion Audio Controller (rev 03)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 32, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 51
> Region 0: Memory at a3318000 (64-bit, non-prefetchable) [size=3D16K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee00358 Data: 0000
> Kernel driver in use: snd_hda_intel
>
> 00:1c.0 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Ro=
ot Port #1 (rev e3) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot-), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s=
 <1us, L1 <4us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via W=
AKE# ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Eq=
ualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00218 Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Kernel driver in use: pcieport
>
> 00:1c.2 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Ro=
ot Port #3 (rev e3) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
> I/O behind bridge: 00004000-00004fff
> Memory behind bridge: a3200000-a32fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s=
 <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWM=
gmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not S=
upported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Eq=
ualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00238 Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [100 v0] #00
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
> PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
> Kernel driver in use: pcieport
>
> 00:1c.3 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Ro=
ot Port #4 (rev e3) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: a3100000-a31fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s=
 <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWM=
gmt+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not S=
upported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, Eq=
ualizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00258 Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [100 v0] #00
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
> PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
> Kernel driver in use: pcieport
>
> 00:1c.4 PCI bridge: Intel Corporation Wildcat Point-LP PCI Express Ro=
ot Port #5 (rev e3) (prog-if 00 [Normal decode])
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
> I/O behind bridge: 00003000-00003fff
> Memory behind bridge: a2000000-a30fffff
> Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
> Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> BridgeCtl: Parity- SERR- NoISA- VGA- MAbort->Reset- FastB2B-
> PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 128 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> LnkCap: Port #5, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s=
 <512ns, L1 <16us
> ClockPM- Surprise- LLActRep+ BwNot+
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgm=
t+ ABWMgmt-
> SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> Slot #4, PowerLimit 25.000W; Interlock- NoCompl+
> SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkCh=
g-
> Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> Changed: MRL- PresDet- LinkState+
> RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisibl=
e-
> RootCap: CRSVisible-
> RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not S=
upported ARIFwd-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled ARIFwd-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee00278 Data: 0000
> Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Capabilities: [a0] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [100 v0] #00
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
> PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
> Kernel driver in use: pcieport
>
> 00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller=
 (rev 03)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium>TAbort- <TA=
bort- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
> Kernel driver in use: lpc_ich
>
> 00:1f.2 SATA controller: Intel Corporation Wildcat Point-LP SATA Cont=
roller [AHCI Mode] (rev 03) (prog-if 01 [AHCI 1.0])
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort- <TA=
bort- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin B routed to IRQ 47
> Region 0: I/O ports at 50b0 [size=3D8]
> Region 1: I/O ports at 50a0 [size=3D4]
> Region 2: I/O ports at 5090 [size=3D8]
> Region 3: I/O ports at 5080 [size=3D4]
> Region 4: I/O ports at 5060 [size=3D32]
> Region 5: Memory at a3322000 (32-bit, non-prefetchable) [size=3D2K]
> Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> Address: fee002d8 Data: 0000
> Capabilities: [70] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
> Kernel driver in use: ahci
>
> 00:1f.3 SMBus: Intel Corporation Wildcat Point-LP SMBus Controller (r=
ev 03)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium>TAbort- <TA=
bort- <MAbort->SERR- <PERR- INTx-
> Interrupt: pin C routed to IRQ 255
> Region 0: Memory at a3321000 (64-bit, non-prefetchable) [size=3D256]
> Region 4: I/O ports at 5040 [size=3D32]
>
> 00:1f.6 Signal processing controller: Intel Corporation Wildcat Point=
-LP Thermal Management Controller (rev 03)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin C routed to IRQ 22
> Region 0: Memory at a3320000 (64-bit, non-prefetchable) [size=3D4K]
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
> Address: 00000000 Data: 0000
> Kernel driver in use: intel_pch_thermal
>
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/=
8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
> Subsystem: ASUSTeK Computer Inc. Device 200f
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 48
> Region 0: I/O ports at 4000 [size=3D256]
> Region 2: Memory at a3204000 (64-bit, non-prefetchable) [size=3D4K]
> Region 4: Memory at a3200000 (64-bit, non-prefetchable) [size=3D16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> Address: 00000000fee002b8 Data: 0000
> Capabilities: [70] Express (v2) Endpoint, MSI 01
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64=
us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via =
message/WAKE#
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
> Vector table: BAR=3D4 offset=3D00000000
> PBA: BAR=3D4 offset=3D00000800
> Capabilities: [d0] Vital Product Data
> Unknown small resource type 00, will not decode more.
> Capabilities: [100 v2] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ NonFatalErr+
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
> Capabilities: [160 v1] Device Serial Number 03-68-25-36-68-4c-e0-00
> Capabilities: [170 v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [178 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
> PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
> Kernel driver in use: r8169
>
> 03:00.0 Network controller: Qualcomm Atheros AR9462 Wireless Network =
Adapter (rev 01)
> Subsystem: AzureWave Device 2208
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 19
> Region 0: Memory at a3100000 (64-bit, non-prefetchable) [size=3D512K]
> Expansion ROM at a3180000 [disabled] [size=3D64K]
> Capabilities: [40] Power Management version 2
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
> Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable+ 64bit+
> Address: 0000000000000000 Data: 0000
> Masking: 00000000 Pending: 00000000
> Capabilities: [70] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
<64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L=
0s <4us, L1 <64us
> ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWM=
gmt- ABWMgmt-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF N=
ot Supported
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfT=
LP- ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ Malf=
TLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> Capabilities: [140 v1] Virtual Channel
> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=3DFixed
> Status: InProgress-
> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
> Kernel driver in use: ath9k
>
> 04:00.0 3D controller: NVIDIA Corporation Device 1347 (rev a2)
> Subsystem: ASUSTeK Computer Inc. Device 1a9d
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- S=
tepping- SERR- FastB2B- DisINTx-
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast>TAbort- <TAbo=
rt- <MAbort->SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 255
> Region 0: Memory at a2000000 (32-bit, non-prefetchable) [size=3D16M]
> Region 1: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
> Region 3: Memory at d0000000 (64-bit, prefetchable) [size=3D32M]
> Region 5: I/O ports at 3000 [size=3D128]
> Expansion ROM at a3000000 [disabled] [size=3D512K]
> Capabilities: [60] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> Address: 0000000000000000 Data: 0000
> Capabilities: [78] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 =
<64us
> ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> MaxPayload 128 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s=
 <512ns, L1 <4us
> ClockPM+ Surprise- LLActRep- BwNot-
> LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
> ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgm=
t- ABWMgmt-
> DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF Via me=
ssage
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Di=
sabled
> LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
> Compliance De-emphasis: -6dB
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equa=
lizationPhase1-
> EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> Capabilities: [100 v1] Virtual Channel
> Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> Arb: Fixed- WRR32- WRR64- WRR128-
> Ctrl: ArbSelect=3DFixed
> Status: InProgress-
> VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
> Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
> Status: NegoPending- InProgress-
> Capabilities: [250 v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [258 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subst=
ates+
> PortCommonModeRestoreTime=3D255us PortTPowerOnTime=3D10us
> Capabilities: [128 v1] Power Budgeting <?>
> Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 Rev=3D1=
 Len=3D024 <?>
> Capabilities: [900 v1] #19
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
> Vendor: ATA Model: ST500LT012-1DG14 Rev: SDM1
> Type: Direct-Access ANSI SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
> Vendor: ATA Model: ACJC2M128mSH Rev: 5.06
> Type: Direct-Access ANSI SCSI revision: 05
>
> [7.7.] Other information that might be relevant to the problem
> (please look in /proc and include all information that you
> think to be relevant):
> [X.] Other notes, patches, fixes, workarounds:
> My bug report on Launchpad with more info and some attachments:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1506363
>
> ------------------
> From Biscuit Wang with outlook.com
> Change your word, change your world.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
