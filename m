From: Alan Ott <alan@signal11.us>
Subject: Re: PROBLEM: HIDRAW: /dev/hidraw* device does not get removed when    unplugged
Date: Wed, 11 Aug 2010 23:53:17 -0400
Message-ID: <4C63702D.4040905@signal11.us>
References: <4C62BE85.2040803@signal11.us> <alpine.LNX.2.00.1008111720300.2702@pobox.suse.cz> <4C62C1B1.8080903@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:43819 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758895Ab0HLDxT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Aug 2010 23:53:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 666691CCAA3C
	for <linux-input@vger.kernel.org>; Wed, 11 Aug 2010 23:53:18 -0400 (EDT)
In-Reply-To: <4C62C1B1.8080903@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>, Greg KH <greg@kroah.com>

On 08/11/2010 11:28 AM, Alan Ott wrote:
> On 08/11/2010 11:21 AM, Jiri Kosina wrote:
>> On Wed, 11 Aug 2010, Alan Ott wrote:
>>
>>> Hello,
>>>
>>> I'm having a bit of trouble with hidraw (with a USB device) and device
>>> removal. When I remove a device and re-attach it, the original 
>>> device does not
>>> get removed, and another node is added to /dev.
>>>
>>> At boot:
>>>      no /dev/hidraw devices exist
>>>
>>> attach a device:
>>>      /dev/hidraw0 exists
>>>
>>> detach the device:
>>>      /dev/hidraw0 remains
>>>
>>> re-attach the device:
>>>      /dev/hidraw0 exists (defunct)
>>>      /dev/hidraw1 exists
>>>
>>> This is with 2.6.35+ from git, revision 3d30701b58970425e1d, updated 
>>> about 30
>>> minutes ago.
>>>
>>> Aug 11 11:04:15 ato kernel: [  109.554287] ------------[ cut here
>>> ]------------
>>> Aug 11 11:04:15 ato kernel: [  109.554300] WARNING: at 
>>> lib/kobject.c:595
>>> kobject_put+0x50/0x60()
>>> Aug 11 11:04:15 ato kernel: [  109.554306] Hardware name: 
>>> GA-MA770T-UD3P
>>> Aug 11 11:04:15 ato kernel: [  109.554311] kobject: '(null)'
>>> (ffff880244a49898): is not initialized, yet kobject_put() is being 
>>> called.
>>> Aug 11 11:04:15 ato kernel: [  109.554317] Modules linked in: usbhid 
>>> hid
>>> binfmt_misc fbcon tileblit font bitblit softcursor snd_hda_codec_nvhdmi
>>> nouveau snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep
>>> snd_pcm_oss ttm drm_kms_helper snd_mixer_oss snd_pcm drm snd_seq_dummy
>>> snd_seq_oss snd_seq_midi snd_rawmidi ppdev parport_pc 
>>> snd_seq_midi_event
>>> snd_seq psmouse lp snd_timer parport i2c_algo_bit edac_core video 
>>> edac_mce_amd
>>> i2c_piix4 snd_seq_device serio_raw snd soundcore snd_page_alloc output
>>> ohci1394 floppy pata_atiixp ieee1394 ahci libahci r8169 mii
>>> Aug 11 11:04:15 ato kernel: [  109.554399] Pid: 29, comm: khubd Not 
>>> tainted
>>> 2.6.35+ #19
>>> Aug 11 11:04:15 ato kernel: [  109.554404] Call Trace:
>>> Aug 11 11:04:15 ato kernel: [  109.554416]  [<ffffffff8105de1f>]
>>> warn_slowpath_common+0x7f/0xc0
>>> Aug 11 11:04:15 ato kernel: [  109.554425]  [<ffffffff8105df16>]
>>> warn_slowpath_fmt+0x46/0x50
>>> Aug 11 11:04:15 ato kernel: [  109.554434]  [<ffffffff812a47c0>]
>>> kobject_put+0x50/0x60
>>> Aug 11 11:04:15 ato kernel: [  109.554442]  [<ffffffff8135c6b7>]
>>> put_device+0x17/0x20
>>> Aug 11 11:04:15 ato kernel: [  109.554455]  [<ffffffffa0238998>]
>>> hid_destroy_device+0x48/0x60 [hid]
>>> Aug 11 11:04:15 ato kernel: [  109.554466]  [<ffffffffa00f2aeb>]
>>> usbhid_disconnect+0x2b/0x50 [usbhid]
>>> Aug 11 11:04:15 ato kernel: [  109.554477]  [<ffffffff813d620a>]
>>> usb_unbind_interface+0x5a/0x1a0
>>> Aug 11 11:04:15 ato kernel: [  109.554487]  [<ffffffff81360645>]
>>> __device_release_driver+0x75/0xe0
>>> Aug 11 11:04:15 ato kernel: [  109.554495]  [<ffffffff813607ad>]
>>> device_release_driver+0x2d/0x40
>>> Aug 11 11:04:15 ato kernel: [  109.554503]  [<ffffffff8135f79e>]
>>> bus_remove_device+0xae/0xf0
>>> Aug 11 11:04:15 ato kernel: [  109.554510]  [<ffffffff8135d437>]
>>> device_del+0x127/0x1d0
>>> Aug 11 11:04:15 ato kernel: [  109.554519]  [<ffffffff813d2b88>]
>>> usb_disable_device+0xa8/0x130
>>> Aug 11 11:04:15 ato kernel: [  109.554527]  [<ffffffff813cbe65>]
>>> usb_disconnect+0x95/0x130
>>> Aug 11 11:04:15 ato kernel: [  109.554535]  [<ffffffff813cd51d>]
>>> hub_thread+0x48d/0x1210
>>> Aug 11 11:04:15 ato kernel: [  109.554544]  [<ffffffff8105771b>] ?
>>> dequeue_task_fair+0x8b/0x90
>>> Aug 11 11:04:15 ato kernel: [  109.554555]  [<ffffffff8107e490>] ?
>>> autoremove_wake_function+0x0/0x40
>>> Aug 11 11:04:15 ato kernel: [  109.554563]  [<ffffffff813cd090>] ?
>>> hub_thread+0x0/0x1210
>>> Aug 11 11:04:15 ato kernel: [  109.554571]  [<ffffffff8107df36>]
>>> kthread+0x96/0xa0
>>> Aug 11 11:04:15 ato kernel: [  109.554580]  [<ffffffff8100be64>]
>>> kernel_thread_helper+0x4/0x10
>>> Aug 11 11:04:15 ato kernel: [  109.554588]  [<ffffffff8107dea0>] ?
>>> kthread+0x0/0xa0
>>> Aug 11 11:04:15 ato kernel: [  109.554595]  [<ffffffff8100be60>] ?
>>> kernel_thread_helper+0x0/0x10
>>> Aug 11 11:04:15 ato kernel: [  109.554601] ---[ end trace 
>>> 212263bbb326ec69
>>> ]---
>>> Aug 11 11:04:21 ato kernel: [  116.450553] usb 1-5.4: new full speed 
>>> USB
>>> device using ehci_hcd and address 7
>>> Aug 11 11:04:22 ato kernel: [  116.576230] generic-usb 
>>> 0003:04D8:003F.0002:
>>> hiddev0,hidraw1: USB HID v1.11 Device [Microchip Technology Inc. 
>>> Simple HID
>>> Device Demo] on usb-0000:00:12.2-5.4/input0
>>> Aug 11 11:04:23 ato kernel: [  117.746427] usb 1-5.4: USB 
>>> disconnect, address
>>> 7
>>> Aug 11 11:04:23 ato kernel: [  117.746500] ------------[ cut here
>>> ]------------
>>>
>>>
>>> lan@ato:~/work/linux-2.6$ scripts/ver_linux
>>> If some fields are empty or look unusual you may have an old version.
>>> Compare to the current minimal requirements in Documentation/Changes.
>>>
>>> Linux ato 2.6.35+ #19 SMP Wed Aug 11 10:53:49 EDT 2010 x86_64 GNU/Linux
>>>
>>> Gnu C                  4.4.3
>>> Gnu make               3.81
>>> binutils               2.20.1
>>> util-linux             2.17.2
>>> mount                  support
>>> module-init-tools      3.11.1
>>> e2fsprogs              1.41.11
>>> pcmciautils            014
>>> Linux C Library        2.11.1
>>> Dynamic linker (ldd)   2.11.1
>>> Procps                 3.2.8
>>> Net-tools              1.60
>>> Kbd                    1.15
>>> Sh-utils               7.4
>>> wireless-tools         30
>>> Modules Loaded         usbhid hid binfmt_misc fbcon tileblit font 
>>> bitblit
>>> softcursor snd_hda_codec_nvhdmi nouveau snd_hda_codec_realtek 
>>> snd_hda_intel
>>> snd_hda_codec snd_hwdep snd_pcm_oss ttm drm_kms_helper snd_mixer_oss 
>>> snd_pcm
>>> drm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi ppdev parport_pc
>>> snd_seq_midi_event snd_seq psmouse lp snd_timer parport i2c_algo_bit 
>>> edac_core
>>> video edac_mce_amd i2c_piix4 snd_seq_device serio_raw snd soundcore
>>> snd_page_alloc output ohci1394 floppy pata_atiixp ieee1394 ahci 
>>> libahci r8169
>>> mii
>> This looks very similar to http://lkml.org/lkml/2010/8/10/373
>>
>> I have not yet root-caused this, but I am not aware of any recent 
>> changes
>> in usb-hid that might be causing that, so I suspect some change in USB
>> core. But will have to investigate.
>
> I just tried it with a Bluetooth HID keyboard and it works as 
> expected. I'd suspect it to not be a HID problem.

I think the warning and the non-removal of the /dev/hidraw* node are 
unrelated.

I spent some time looking into the non-removal of the /dev/hidraw* node. 
The hid_disconnect() function takes care of removing the node, and it's 
not getting called. hid_disconnect() is called by hid_hw_stop() (hid.h), 
which is called by hid_device_remove() (hid-core.c) which _should_ be 
getting called by the driver subsystem. It looks like this is not 
happening for whatever reason.

I wasn't able to get anything conclusive beyond this (yet).

Alan.


