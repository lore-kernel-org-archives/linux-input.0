From: Dawid S <dawid.public@gmail.com>
Subject: Input - wistron_btns bug? NX Security
Date: Wed, 19 Dec 2012 10:13:49 +0100
Message-ID: <CAEdOsPybcXtv_6jFqdriFubYust+Egs5ZosxTLZ52_-5Z7CSOA@mail.gmail.com>
References: <CAEdOsPxfvQ2xETsJia0WzXUS2JvrHRTig+L7JFaoBUuRVVfNSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:53262 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2LSJNu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Dec 2012 04:13:50 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so2367557iej.32
        for <linux-input@vger.kernel.org>; Wed, 19 Dec 2012 01:13:50 -0800 (PST)
In-Reply-To: <CAEdOsPxfvQ2xETsJia0WzXUS2JvrHRTig+L7JFaoBUuRVVfNSw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
i wanted to use the wistron_btns module in order to get the
wireless-power button to work on my Fujitsu Siemens Amilo Pro V3505.
Im using ubuntu 12.04.1 (3.2.0-34-generic-pae / 3.2.0-35-generic-pae /
3.6) and every time when i do "modprobe wistron_btns" i get black
screen...
I have compiled wistron_btns and i've added some printfs to trace it
down and it happends when platform_device_add(wistron_device) is
called..
Could you take a look there?
Thanks :-)

I have contacted also the author of wistron_btns and he sayd:
The above quoted parts suggests that wistron_btns is unable to work
when the NX (no execute) security feature is enabled.  As a possible
workaround, you might want to try building a non-PAE kernel in order
to disable the NX feature (from a very cursory look it seems that
there isn't a separate CONFIG_* variable that would control only NX).
Please also report this to the higher-level input maintainer so that
they are aware of this problem.



syslog:
Dec 16 21:08:05 V3505 kernel: [ 4791.380768] wistron_btns: BIOS
signature found at c00f5b10, entry point 000FDD20
Dec 16 21:08:05 V3505 kernel: [ 4791.380881] kernel tried to execute
NX-protected page - exploit attempt? (uid: 0)
Dec 16 21:08:05 V3505 kernel: [ 4791.380967] BUG: unable to handle
kernel paging request at c00fdd20
Dec 16 21:08:05 V3505 kernel: [ 4791.381032] IP: [<c00fdd20>] 0xc00fdd1f
Dec 16 21:08:05 V3505 kernel: [ 4791.381077] *pdpt = 0000000001939001
*pde = 0000000001a12067 *pte = 80000000000fd163
Dec 16 21:08:05 V3505 kernel: [ 4791.381161] Oops: 0011 [#1] SMP
Dec 16 21:08:05 V3505 kernel: [ 4791.381204] Modules linked in:
wistron_btns(+) sparse_keymap input_polldev rfcomm bnep bluetooth
parport_pc ppdev joydev snd_hda_codec_si3054 snd_hda_codec_realtek
pcmcia snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi
snd_rawmidi arc4 snd_seq_midi_event iwl3945 iwl_legacy mac80211
yenta_socket pcmcia_rsrc pcmcia_core psmouse snd_seq snd_timer
snd_seq_device cfg80211 serio_raw snd i915 drm_kms_helper soundcore
drm snd_page_alloc i2c_algo_bit video mac_hid lp parport sdhci_pci
sdhci sky2
Dec 16 21:08:05 V3505 kernel: [ 4791.381821]
Dec 16 21:08:05 V3505 kernel: [ 4791.381841] Pid: 2713, comm: modprobe
Not tainted 3.2.0-34-generic-pae #53-Ubuntu FUJITSU SIEMENS AMILO Pro
Edition V3505        /AMILO Pro Edition V3505
Dec 16 21:08:05 V3505 kernel: [ 4791.381982] EIP: 0060:[<c00fdd20>]
EFLAGS: 00010086 CPU: 0
Dec 16 21:08:05 V3505 kernel: [ 4791.382038] EIP is at 0xc00fdd20
Dec 16 21:08:05 V3505 kernel: [ 4791.382072] EAX: 00009610 EBX:
0000012e ECX: 00000000 EDX: f25f5e3c
Dec 16 21:08:05 V3505 kernel: [ 4791.382130] ESI: 00000000 EDI:
f25f5e3c EBP: f844e400 ESP: f25f5e10
Dec 16 21:08:05 V3505 kernel: [ 4791.382188]  DS: 007b ES: 007b FS:
00d8 GS: 00e0 SS: 0068
Dec 16 21:08:05 V3505 kernel: [ 4791.382240] Process modprobe (pid:
2713, ti=f25f4000 task=f1ad32c0 task.ti=f25f4000)
Dec 16 21:08:05 V3505 kernel: [ 4791.382317] Stack:
Dec 16 21:08:05 V3505 kernel: [ 4791.382340]  f85fa03e f25f5e2c
00000286 f25f5e3c f25f5e3c 00000000 f25f5e3c f25f5e54
Dec 16 21:08:05 V3505 kernel: [ 4791.382450]  f85fa576 00000000
f3f24a00 00009610 0000012e 00000000 f3f24a08 f85fc014
Dec 16 21:08:05 V3505 kernel: [ 4791.382559]  f85fc014 f25f5e5c
c1386ca1 f25f5e80 c138580d f3f24a62 00000000 f25f5e80
Dec 16 21:08:05 V3505 kernel: [ 4791.382664] Call Trace:
Dec 16 21:08:05 V3505 kernel: [ 4791.382694]  [<f85fa03e>] ?
call_bios+0x3e/0x60 [wistron_btns]
Dec 16 21:08:05 V3505 kernel: [ 4791.382754]  [<f85fa576>] ?
wistron_probe+0x33/0x10c [wistron_btns]
Dec 16 21:08:05 V3505 kernel: [ 4791.382817]  [<c1386ca1>] ?
platform_drv_probe+0x11/0x20
Dec 16 21:08:05 V3505 kernel: [ 4791.382873]  [<c138580d>] ?
really_probe+0x4d/0x150
Dec 16 21:08:05 V3505 kernel: [ 4791.382921]  [<c138ee79>] ?
pm_runtime_barrier+0x49/0xb0
Dec 16 21:08:05 V3505 kernel: [ 4791.382976]  [<c1385a4a>] ?
driver_probe_device+0x3a/0x60
Dec 16 21:08:05 V3505 kernel: [ 4791.383028]  [<c1385b51>] ?
__device_attach+0x41/0x50
Dec 16 21:08:05 V3505 kernel: [ 4791.383077]  [<c1385b10>] ?
__driver_attach+0xa0/0xa0
Dec 16 21:08:05 V3505 kernel: [ 4791.383127]  [<c13848d9>] ?
bus_for_each_drv+0x49/0x70
Dec 16 21:08:05 V3505 kernel: [ 4791.383179]  [<c13859da>] ?
device_attach+0x8a/0xa0
Dec 16 21:08:05 V3505 kernel: [ 4791.383227]  [<c1385b10>] ?
__driver_attach+0xa0/0xa0
Dec 16 21:08:05 V3505 kernel: [ 4791.383276]  [<c1385105>] ?
bus_probe_device+0x25/0x40
Dec 16 21:08:05 V3505 kernel: [ 4791.383329]  [<c138371c>] ?
device_add+0x28c/0x380
Dec 16 21:08:05 V3505 kernel: [ 4791.383379]  [<c12b9ea3>] ?
kvasprintf+0x43/0x60
Dec 16 21:08:05 V3505 kernel: [ 4791.383429]  [<c12ae63a>] ?
kobject_set_name_vargs+0x4a/0x60
Dec 16 21:08:05 V3505 kernel: [ 4791.383486]  [<c12ae63a>] ?
kobject_set_name_vargs+0x4a/0x60
Dec 16 21:08:05 V3505 kernel: [ 4791.383544]  [<c138742f>] ?
platform_device_add+0xdf/0x1b0
Dec 16 21:08:05 V3505 kernel: [ 4791.383599]  [<c1387787>] ?
platform_device_alloc+0x67/0x80
Dec 16 21:08:05 V3505 kernel: [ 4791.383654]  [<f87fc2cb>] ?
wb_module_init+0x45/0xd7a [wistron_btns]
Dec 16 21:08:05 V3505 kernel: [ 4791.383718]  [<c1003035>] ?
do_one_initcall+0x35/0x170
Dec 16 21:08:05 V3505 kernel: [ 4791.383774]  [<f87fc286>] ?
map_bios+0x123/0x123 [wistron_btns]
Dec 16 21:08:05 V3505 kernel: [ 4791.383832]  [<c1095f1d>] ?
sys_init_module+0xad/0x210
Dec 16 21:08:05 V3505 kernel: [ 4791.383887]  [<c15aec9f>] ?
sysenter_do_call+0x12/0x28
Dec 16 21:08:05 V3505 kernel: [ 4791.383937] Code: 00 e8 9a fe ff ff
86 c4 66 5b 66 5a 5e c3 00 00 00 00 00 00 00 00 00 00 00 00 00 c3 c3
00 00 00 00 00 00 00 00 00 00 00 00 00 00 <57> 50 c1 e0 10 66 8b c3 8b
f8 58 e8 ef 00 00 00 73 11 e8 e8 00
Dec 16 21:08:05 V3505 kernel: [ 4791.384327] EIP: [<c00fdd20>]
0xc00fdd20 SS:ESP 0068:f25f5e10
Dec 16 21:08:05 V3505 kernel: [ 4791.384327] CR2: 00000000c00fdd20
Dec 16 21:08:05 V3505 kernel: [ 4791.454873] ---[ end trace
094fb6404aadddf7 ]---
