From: Pilot6 <hanipouspilot@gmail.com>
Subject: ASUS X200MA Touchpad scrolling not working
Date: Fri, 31 Oct 2014 20:52:32 +0300
Message-ID: <5453CC60.1040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52370 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaJaRwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 13:52:37 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so6545189lbi.3
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 10:52:35 -0700 (PDT)
Received: from [192.168.1.112] (93-80-53-100.broadband.corbina.ru. [93.80.53.100])
        by mx.google.com with ESMTPSA id lt8sm4122974lac.35.2014.10.31.10.52.34
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Oct 2014 10:52:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

[1.] [ASUS X200MA] Touchpad scrolling not working

[2.] Touchpad is detected as a mouse. It works, but no multitouch, no=20
scrolling.

pilot6@X200MA:~$ xinput --list
=E2=8E=A1 Virtual core pointer id=3D2 [master pointer (3)]
=E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4 [slave pointer (2=
)]
=E2=8E=9C =E2=86=B3 PS/2 Logitech Wheel Mouse id=3D13 [slave pointer (2=
)]

This bug exists on all kernels up to 3.18-rc2

[3.]

[4.] Linux version 3.18.0-031800rc2-generic (apw@gomeisa) (gcc version=20
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201410281737 SMP Tue Oct 28=20
21:38:57 UTC 2014

[5.] n/a

[6.] n/a

[7.] Description:    Ubuntu 14.04.1 LTS
Release:    14.04

pilot6@X200MA:~$ cat /proc/version
Linux version 3.18.0-031800rc2-generic (apw@gomeisa) (gcc version 4.6.3=
=20
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201410281737 SMP Tue Oct 28 21:38:57=20
UTC 2014
pilot6@X200MA:~$ ^C
pilot6@X200MA:~$ lsb_release -rd
Description:    Ubuntu 14.04.1 LTS
Release:    14.04

pilot6@X200MA:~$ sudo cat /proc/modules
snd_hda_codec_hdmi 52670 1 - Live 0xffffffffc0adb000
snd_hda_codec_realtek 76099 1 - Live 0xffffffffc0abf000
snd_hda_codec_generic 69995 1 snd_hda_codec_realtek, Live 0xffffffffc0a=
ac000
ctr 13193 2 - Live 0xffffffffc0779000
ccm 17856 2 - Live 0xffffffffc06d5000
rfcomm 75066 0 - Live 0xffffffffc0a98000
bnep 23980 2 - Live 0xffffffffc0a91000
uvcvideo 86723 0 - Live 0xffffffffc0a7a000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffc0616000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffc06b2000
videobuf2_core 51547 1 uvcvideo, Live 0xffffffffc0a6c000
v4l2_common 15715 1 videobuf2_core, Live 0xffffffffc055d000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live=20
0xffffffffc0a43000
media 22008 2 uvcvideo,videodev, Live 0xffffffffc0a3c000
arc4 12573 2 - Live 0xffffffffc0553000
ath9k 162133 0 - Live 0xffffffffc0a07000
snd_hda_intel 30783 3 - Live 0xffffffffc09f7000
intel_rapl 19196 0 - Live 0xffffffffc06db000
snd_hda_controller 32234 1 snd_hda_intel, Live 0xffffffffc06cc000
ath9k_common 25638 1 ath9k, Live 0xffffffffc06c4000
i915 1031913 4 - Live 0xffffffffc08c8000
snd_hda_codec 144641 5=20
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_controller,=20
Live 0xffffffffc08a3000
ath9k_hw 460416 2 ath9k,ath9k_common, Live 0xffffffffc0707000
intel_powerclamp 19099 0 - Live 0xffffffffc06be000
asus_nb_wmi 21128 0 - Live 0xffffffffc06b7000
asus_wmi 24697 1 asus_nb_wmi, Live 0xffffffffc0629000
sparse_keymap 13890 1 asus_wmi, Live 0xffffffffc061b000
coretemp 13638 0 - Live 0xffffffffc0558000
ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0xffffffffc0620000
btusb 32691 0 - Live 0xffffffffc060d000
snd_hwdep 17709 1 snd_hda_codec, Live 0xffffffffc054d000
mac80211 697143 1 ath9k, Live 0xffffffffc07f7000
bluetooth 486890 11 rfcomm,bnep,btusb, Live 0xffffffffc077f000
kvm_intel 149984 0 - Live 0xffffffffc06e1000
cfg80211 520257 4 ath9k,ath9k_common,ath,mac80211, Live 0xffffffffc0631=
000
kvm 475233 1 kvm_intel, Live 0xffffffffc0597000
snd_pcm 106273 4=20
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live=
=20
0xffffffffc057c000
snd_seq_midi 13564 0 - Live 0xffffffffc04d0000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffc04eb000
snd_rawmidi 31197 1 snd_seq_midi, Live 0xffffffffc0544000
drm_kms_helper 99802 1 i915, Live 0xffffffffc0562000
drm 323675 6 i915,drm_kms_helper, Live 0xffffffffc04f3000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc04da00=
0
crct10dif_pclmul 14268 0 - Live 0xffffffffc04d5000
crc32_pclmul 13180 0 - Live 0xffffffffc0493000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live=20
0xffffffffc04cb000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0xffffffffc04c2000
ghash_clmulni_intel 13230 0 - Live 0xffffffffc0477000
mei_txe 19808 0 - Live 0xffffffffc04b1000
cryptd 20531 1 ghash_clmulni_intel, Live 0xffffffffc04bb000
snd 84025 17=20
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_=
intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_devic=
e,snd_timer,=20
Live 0xffffffffc049b000
mei 88473 1 mei_txe, Live 0xffffffffc047c000
serio_raw 13483 0 - Live 0xffffffffc0472000
rtsx_pci_ms 18337 0 - Live 0xffffffffc0468000
iosf_mbi 13865 0 - Live 0xffffffffc0463000
memstick 16968 1 rtsx_pci_ms, Live 0xffffffffc0459000
wmi 19379 1 asus_wmi, Live 0xffffffffc0448000
i2c_algo_bit 13564 1 i915, Live 0xffffffffc0450000
lpc_ich 21176 0 - Live 0xffffffffc043a000
snd_soc_sst_acpi 13007 0 - Live 0xffffffffc0443000
8250_fintek 12925 0 - Live 0xffffffffc0435000
soundcore 15091 2 snd_hda_codec,snd, Live 0xffffffffc0427000
video 20649 2 i915,asus_wmi, Live 0xffffffffc042e000
nls_iso8859_1 12713 1 - Live 0xffffffffc0422000
mac_hid 13275 0 - Live 0xffffffffc0411000
parport_pc 32909 0 - Live 0xffffffffc0418000
ppdev 17711 0 - Live 0xffffffffc03a7000
lp 17799 0 - Live 0xffffffffc03e0000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffc0405000
rtsx_pci_sdmmc 23718 0 - Live 0xffffffffc03c2000
psmouse 118197 0 - Live 0xffffffffc03e7000
r8169 86907 0 - Live 0xffffffffc03c9000
rtsx_pci 51162 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0xffffffffc03b4000
mii 13981 1 r8169, Live 0xffffffffc03ad000
ahci 34220 3 - Live 0xffffffffc039d000
libahci 32446 1 ahci, Live 0xffffffffc0394000

Launchpad bug report

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1388160


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
