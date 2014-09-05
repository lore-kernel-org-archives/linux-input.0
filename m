From: Laurent Debian <laurent.debian@gmail.com>
Subject: Bug ID: 83911  Summary: Thermaltake USB Gaming Mouse not working
Date: Fri, 05 Sep 2014 12:16:45 -0400
Message-ID: <5089335.19QK3Jph7p@laurent-debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart5796048.GCLVz76OrB"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:57890 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaIEQQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Sep 2014 12:16:53 -0400
Received: by mail-qa0-f52.google.com with SMTP id f12so11427936qad.11
        for <linux-input@vger.kernel.org>; Fri, 05 Sep 2014 09:16:52 -0700 (PDT)
Received: from laurent-debian.localnet (f237-pc1.mat.utfsm.cl. [200.1.16.57])
        by mx.google.com with ESMTPSA id 75sm1091139qgg.25.2014.09.05.09.16.51
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 09:16:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart5796048.GCLVz76OrB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all,
I was asked to send you a bug report I just submit so here we are :
the bug is there  https://bugzilla.kernel.org/show_bug.cgi?id=83911. 

I reproduce it here : 

I have a usb mouse model : TT esport Sapphira, from thermaltake.


When I plug it in I have this kernel messages

[ 1019.645758] usb 1-1.6.2: new full-speed USB device number 8 using ehci-pci
[ 1019.741008] usb 1-1.6.2: New USB device found, idVendor=04f2, 
idProduct=1106
[ 1019.741016] usb 1-1.6.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[ 1019.741020] usb 1-1.6.2: Product: USB Gaming Mouse
[ 1019.741024] usb 1-1.6.2: Manufacturer: Thermaltake
[ 1019.742903] input: Thermaltake USB Gaming Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.2/1-1.6.2:1.0/input/input23
[ 1019.743530] hid-generic 0003:04F2:1106.0006: input,hidraw1: USB HID v1.11 
Mouse [Thermaltake USB Gaming Mouse] on usb-0000:00:1a.0-1.6.2/input0
[ 1019.747180] input: Thermaltake USB Gaming Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6.2/1-1.6.2:1.1/input/input24
[ 1019.749302] hid-generic 0003:04F2:1106.0007: input,hiddev0,hidraw2: USB HID 
v1.11 Keyboard [Thermaltake USB Gaming Mouse] on usb-0000:00:1a.0-1.6.2/input1

So the usb mouse is properly identify but that's about it. Nothing more,the 
mouse is not powered (non of the led-light neither the laser produce light) 
and of course neither clicking or moving the mouse do anything.

To add to the confusion in rare occasions, ( +/- 3 times in one month of using 
the computer each day) it get powered and works correctly. One time it 
occurred  I checked the modules loaded and  messages from the kernel but I did 
not find anything relevant. 
I normally use occurs a kernel 3.13.0-24-generic of Linux mint package (aka 
Ubuntu kernel), but I tested as well with the last kernel from git which was 
at the time 3.17-rc3 and the problem was still there.

Attached a lsmod result.

Ps: I know I use nvidia binary  but this problem happened before, so please 
just ignore it.
--nextPart5796048.GCLVz76OrB
Content-Disposition: attachment; filename="lsmod.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="lsmod.txt"

Module                  Size  Used by
nls_utf8               12557  1 
udf                    89723  1 
nls_iso8859_1          12713  1 
crc_itu_t              12707  1 udf
pci_stub               12622  1 
vboxpci                23194  0 
vboxnetadp             25670  0 
vboxnetflt             27613  0 
vboxdrv               339502  3 vboxnetadp,vboxnetflt,vboxpci
rfcomm                 69160  0 
bnep                   19624  2 
bluetooth             395423  10 bnep,rfcomm
binfmt_misc            17468  1 
gpio_ich               13476  0 
dm_multipath           22873  0 
scsi_dh                14882  1 dm_multipath
joydev                 17381  0 
uvcvideo               80885  0 
videobuf2_vmalloc      13216  1 uvcvideo
videobuf2_memops       13362  1 videobuf2_vmalloc
videobuf2_core         40664  1 uvcvideo
videodev              134688  2 uvcvideo,videobuf2_core
snd_hda_codec_hdmi     46207  1 
intel_powerclamp       14705  0 
coretemp               13435  0 
kvm                   451511  0 
nvidia              10675249  39 
serio_raw              13462  0 
snd_hda_codec_realtek    61438  1 
snd_hda_intel          52355  0 
snd_hda_codec         192906  3 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
snd_hwdep              13602  1 snd_hda_codec
lpc_ich                21080  0 
snd_pcm               102099  3 snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
snd_page_alloc         18710  2 snd_pcm,snd_hda_intel
drm                   302817  2 nvidia
snd_seq_midi           13324  0 
snd_seq_midi_event     14899  1 snd_seq_midi
snd_rawmidi            30144  1 snd_seq_midi
wmi                    19177  0 
snd_seq                61560  2 snd_seq_midi_event,snd_seq_midi
snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
snd_timer              29482  2 snd_pcm,snd_seq
snd                    69238  11 snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_hda_codec,snd_hda_intel,snd_seq_device,snd_seq_midi
soundcore              12680  1 snd
mac_hid                13205  0 
mei_me                 18627  0 
mei                    82274  1 mei_me
parport_pc             32701  0 
ppdev                  17671  0 
lp                     17759  0 
parport                42348  3 lp,ppdev,parport_pc
dm_mirror              22135  0 
dm_region_hash         20862  1 dm_mirror
dm_log                 18411  2 dm_region_hash,dm_mirror
usb_storage            62209  1 
hid_generic            12548  0 
usbhid                 52616  0 
hid                   106148  2 hid_generic,usbhid
psmouse               102222  0 
r8169                  67581  0 
mii                    13934  1 r8169
ahci                   25819  3 
libahci                32168  1 ahci
--nextPart5796048.GCLVz76OrB--

