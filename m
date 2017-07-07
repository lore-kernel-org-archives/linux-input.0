From: Tobias Predel <tobias.predel@gmail.com>
Subject: ELAN Touchpad not responding after wakeup
Date: Fri, 7 Jul 2017 21:58:50 +0200
Message-ID: <20170707195850.GA11318@laptop.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33297 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbdGGT6t (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Jul 2017 15:58:49 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so60926135wrb.0
        for <linux-input@vger.kernel.org>; Fri, 07 Jul 2017 12:58:49 -0700 (PDT)
Received: from laptop.fritz.box (HSI-KBW-085-216-067-125.hsi.kabelbw.de. [85.216.67.125])
        by smtp.gmail.com with ESMTPSA id r187sm392406wmg.15.2017.07.07.12.58.47
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 12:58:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm using Linux 4.11.9.1 (Arch Linux) and after the wakeup from
suspension the touchpad doesn't respond anymore. Instead, the kernel ring buffer is
flooded with

 irq 227, desc: ffff880078128c00, depth: 1, count: 0, unhandled: 0
 ->handle_irq():  ffffffff810e5fe0,
 handle_bad_irq+0x0/0x230
 ->irq_data.chip(): ffffffff81a9f680,
 0xffffffff81a9f680
 ->action():           (null)
    IRQ_NOPROBE set
 unexpected IRQ trap at vector e3

right after resume.
This message block is repeated indefinitely. My laptop is 
ASUSTeK COMPUTER INC. E205SA/E205SA, BIOS E205SA.206 09/04/2015
according to DMI. xinput prints

⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ Elan Touchpad                             id=11   [slave  pointer  (2)]
⎜   ↳ SIS0457:00 0457:1136                      id=12   [slave  pointer  (2)]
⎜   ↳ Logitech USB Receiver                     id=15   [slave  pointer  (2)]
⎜   ↳ Logitech USB Receiver                     id=17   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=6    [slave  keyboard (3)]
    ↳ Asus Wireless Radio Control               id=7    [slave  keyboard (3)]
    ↳ Video Bus                                 id=8    [slave  keyboard (3)]
    ↳ Sleep Button                              id=9    [slave  keyboard (3)]
    ↳ USB2.0 VGA UVC WebCam                     id=10   [slave  keyboard (3)]
    ↳ Asus WMI hotkeys                          id=13   [slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard              id=14   [slave  keyboard (3)]
    ↳ Logitech USB Receiver                     id=16   [slave  keyboard (3)]

lsmod says

Module                  Size  Used by
tun                    28672  1
sd_mod                 45056  2
uas                    24576  0
usb_storage            65536  2 uas
scsi_mod              155648  3 sd_mod,usb_storage,uas
hid_generic            16384  0
usbhid                 45056  0
fuse                   98304  5
rfcomm                 69632  14
ctr                    16384  2
ccm                    20480  3
snd_hda_codec_hdmi     49152  1
arc4                   16384  2
bnep                   20480  2
snd_hda_codec_realtek    73728  1
snd_hda_codec_generic    69632  1 snd_hda_codec_realtek
intel_rapl             20480  0
intel_powerclamp       16384  0
hid_multitouch         20480  0
coretemp               16384  0
nls_iso8859_1          16384  1
kvm_intel             192512  0
joydev                 20480  0
nls_cp437              20480  1
mousedev               20480  0
kvm                   528384  1 kvm_intel
btusb                  40960  0
asus_nb_wmi            24576  0
btrtl                  16384  1 btusb
vfat                   20480  1
btbcm                  16384  1 btusb
fat                    65536  1 vfat
irqbypass              16384  1 kvm
iTCO_wdt               16384  0
btintel                16384  1 btusb
crct10dif_pclmul       16384  0
asus_wmi               24576  1 asus_nb_wmi
iTCO_vendor_support    16384  1 iTCO_wdt
crc32_pclmul           16384  0
sparse_keymap          16384  1 asus_wmi
bluetooth             487424  41 btrtl,btintel,bnep,btbcm,rfcomm,btusb
crc32c_intel           24576  0
uvcvideo               86016  0
videobuf2_vmalloc      16384  1 uvcvideo
ghash_clmulni_intel    16384  0
videobuf2_memops       16384  1 videobuf2_vmalloc
ath10k_pci             45056  0
ath10k_core           294912  1 ath10k_pci
pcbc                   16384  0
videobuf2_v4l2         20480  1 uvcvideo
videobuf2_core         36864  2 uvcvideo,videobuf2_v4l2
ath                    28672  1 ath10k_core
videodev              151552  3 uvcvideo,videobuf2_core,videobuf2_v4l2
media                  32768  2 uvcvideo,videodev
mac80211              696320  1 ath10k_core
i915                 1429504  33
aesni_intel           163840  2
aes_x86_64             20480  1 aesni_intel
crypto_simd            16384  1 aesni_intel
glue_helper            16384  1 aesni_intel
cryptd                 20480  3 crypto_simd,ghash_clmulni_intel,aesni_intel
snd_intel_sst_acpi     16384  0
snd_intel_sst_core     69632  1 snd_intel_sst_acpi
intel_cstate           16384  0
evdev                  24576  18
snd_hda_intel          36864  3
drm_kms_helper        126976  1 i915
snd_soc_sst_atom_hifi2_platform    86016  1 snd_intel_sst_core
input_leds             16384  0
mac_hid                16384  0
cfg80211              520192  3 mac80211,ath,ath10k_core
pcspkr                 16384  0
snd_hda_codec         106496  4 snd_hda_intel,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_codec_realtek
snd_soc_sst_match      16384  1 snd_intel_sst_acpi
drm                   299008  11 i915,drm_kms_helper
snd_soc_core          192512  1 snd_soc_sst_atom_hifi2_platform
rfkill                 20480  10 asus_wmi,bluetooth,cfg80211
i2c_hid                20480  0
intel_gtt              20480  1 i915
syscopyarea            16384  1 drm_kms_helper
hid                   110592  5 i2c_hid,hid_generic,usbhid,hid_multitouch
sysfillrect            16384  1 drm_kms_helper
sysimgblt              16384  1 drm_kms_helper
fb_sys_fops            16384  1 drm_kms_helper
elan_i2c               32768  0
mei_txe                20480  0
lpc_ich                24576  0
i2c_algo_bit           16384  1 i915
snd_hda_core           65536  5 snd_hda_intel,snd_hda_codec,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_codec_realtek
i2c_i801               24576  0
mei                    86016  1 mei_txe
snd_hwdep              16384  1 snd_hda_codec
processor_thermal_device    16384  0
snd_compress           20480  1 snd_soc_core
shpchp                 32768  0
intel_soc_dts_iosf     16384  1 processor_thermal_device
snd_pcm_dmaengine      16384  1 snd_soc_core
snd_pcm                90112  7 snd_hda_intel,snd_hda_codec,snd_pcm_dmaengine,snd_hda_core,snd_soc_sst_atom_hifi2_platform,snd_hda_codec_hdmi,snd_soc_core
wmi                    20480  1 asus_wmi
thermal                20480  0
snd_timer              28672  1 snd_pcm
snd                    65536  17 snd_compress,snd_hda_intel,snd_hwdep,snd_hda_codec,snd_timer,snd_soc_sst_atom_hifi2_platform,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_codec_realtek,snd_soc_core,snd_pcm
soundcore              16384  1 snd
ac97_bus               16384  1 snd_soc_core
battery                20480  0
i2c_designware_platform    16384  0
i2c_designware_core    20480  1 i2c_designware_platform
ac                     16384  0
spi_pxa2xx_platform    24576  0
tpm_crb                16384  0
tpm_tis                16384  0
int3400_thermal        16384  0
tpm_tis_core           20480  1 tpm_tis
acpi_thermal_rel       16384  1 int3400_thermal
int3406_thermal        16384  0
int3403_thermal        16384  0
fan                    16384  0
int340x_thermal_zone    16384  2 int3403_thermal,processor_thermal_device
video                  36864  3 asus_wmi,int3406_thermal,i915
asus_wireless          16384  0
tpm                    40960  3 tpm_tis,tpm_crb,tpm_tis_core
button                 16384  1 i915
sch_fq_codel           20480  6
ip_tables              24576  0
x_tables               28672  1 ip_tables
ext4                  528384  1
crc16                  16384  2 bluetooth,ext4
jbd2                   90112  1 ext4
fscrypto               24576  1 ext4
mbcache                16384  1 ext4
mmc_block              36864  4
serio_raw              16384  0
atkbd                  24576  0
libps2                 16384  1 atkbd
xhci_pci               16384  0
xhci_hcd              184320  1 xhci_pci
usbcore               208896  7 uvcvideo,usbhid,usb_storage,xhci_pci,btusb,uas,xhci_hcd
usb_common             16384  1 usbcore
i8042                  24576  1 asus_nb_wmi
serio                  20480  4 serio_raw,atkbd,i8042
sdhci_acpi             16384  0
sdhci                  40960  1 sdhci_acpi
led_class              16384  4 asus_wmi,sdhci,input_leds,asus_wireless
mmc_core              122880  3 sdhci,mmc_block,sdhci_acpi

I would be very glad if someone may look into this case.

Kind regards,

Tobias

