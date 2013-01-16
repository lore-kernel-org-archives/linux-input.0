From: Florian Fuchs <fuchsfl@gmail.com>
Subject: Re: PROBLEM: SOLVEDModule hid_logitech_dj: None of the paired devices
 work, if one of them is not available on load
Date: Wed, 16 Jan 2013 22:51:24 +0100
Message-ID: <50F720DC.6000608@gmail.com>
References: <50F306CD.5020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:50509 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab3APVv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2013 16:51:27 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so989911bku.3
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2013 13:51:26 -0800 (PST)
In-Reply-To: <50F306CD.5020606@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: nlopezcasad@logitech.com

It seems, that it was an hardware failure.

I tracked the USB communication:
Here is the unsuccessful part - the mouse does not work after inserting 
the adapter:
[...]
< ffff8801b2ed6900 582503866 S Co:021:00 s 21 09 0220 0002 000f 15 = 
20ff8100 00000000 00000000 000000
< ffff8801b2ed6900 582503914 C Co:021:00 -32 0
< ffff8801b2ed6840 582503957 C Ii:021:03 -2 0

With a different unified USB adapter it just works like a charm, without 
problems, so no problem is there :-)

Regards,
Flo


Am 13.01.2013 20:11, schrieb Florian Fuchs:
> Hi there,
>
> I have an issue with the Logitech unified USB adapter, which is paired 
> with two devices - a wireless keyboard and mouse. The keyboard is not 
> always in use - so I turn this device off. In result the mouse is also 
> not working.
> It seems that, all paired devices have to be available, when the 
> module is initialised, in order to use one of them.
>
> Once the module is loaded, I can remove the adapter and plug it in 
> again, then the mouse works - so this is the workaround for me.
> If  both devices are turned on, on startup, everything works fine.
>
> Regards,
> Flo
>
> dmesg:
> [    1.659267] asus_wmi: SFUN value: 0x6a0877<6>[ 1.661154] usb 3-3: 
> New USB device found, idVendor=046d, idProduct=c52b
> [    1.661159] usb 3-3: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [    1.661162] usb 3-3: Product: USB Receiver
> [    1.661165] usb 3-3: Manufacturer: Logitech
> [    1.677071] usbcore: registered new interface driver usbhid
> [    1.677073] usbhid: USB HID core driver
> [    1.680449] logitech-djreceiver 0003:046D:C52B.0003: 
> hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on 
> usb-0000:00:14.0-3/input2
> [    1.680717] logitech-djreceiver 0003:046D:C52B.0003: 
> logi_dj_probe:logi_dj_recv_query_paired_devices error:-32
> [    1.680880] logitech-djreceiver: probe of 0003:046D:C52B.0003 
> failed with error -32
>
>
> Kernel version (from /proc/version):
> Linux version 3.7.2custom (root@flo-u) (gcc version 4.7.2 
> (Ubuntu/Linaro 4.7.2-2ubuntu1) ) #1 SMP Sat Jan 12 14:50:13 CET 2013
>
> Software:
> flo@flo-u:~$ perl linux-stable/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux flo-u 3.7.2custom #1 SMP Sat Jan 12 14:50:13 CET 2013 x86_64 
> x86_64 x86_64 GNU/Linux
>
> Gnu C                  4.7
> Gnu make               3.81
> binutils               2.22.90.20120924
> util-linux             2.20.1
> mount                  support
> module-init-tools      3.16
> e2fsprogs              1.42.5
> pcmciautils            018
> PPP                    2.4.5
> Linux C Library        2.15
> Dynamic linker (ldd)   2.15
> Procps                 3.3.3
> Net-tools              1.60
> Kbd                    1.15.3
> Sh-utils               8.13
> wireless-tools         30
> Modules Loaded         hid_logitech_dj bnep rfcomm binfmt_misc 
> nls_iso8859_1 snd_hda_codec_realtek joydev coretemp 
> ghash_clmulni_intel aesni_intel ablk_helper cryptd lrw aes_x86_64 xts 
> gf128mul asus_nb_wmi asus_wmi sparse_keymap snd_hda_intel 
> snd_hda_codec snd_hwdep snd_pcm microcode snd_seq_midi psmouse arc4 
> serio_raw snd_rawmidi snd_seq_midi_event i915 snd_seq snd_timer 
> snd_seq_device iwldvm btusb lpc_ich bluetooth mac80211 nouveau ttm snd 
> drm_kms_helper iwlwifi drm soundcore cfg80211 snd_page_alloc 
> i2c_algo_bit mei mxm_wmi video wmi usbhid hid
>

