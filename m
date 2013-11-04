From: Sohin Vyacheslaw <in.soho@yandex.ua>
Subject: incorrect determination of the USB-sound card
Date: Mon, 04 Nov 2013 10:26:40 +0200
Message-ID: <52775A40.9050209@yandex.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward3h.mail.yandex.net ([84.201.187.148]:58455 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3KDI0o (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Nov 2013 03:26:44 -0500
Received: from smtp4h.mail.yandex.net (smtp4h.mail.yandex.net [84.201.186.21])
	by forward3h.mail.yandex.net (Yandex) with ESMTP id 6CB8C13621BD
	for <linux-input@vger.kernel.org>; Mon,  4 Nov 2013 12:26:42 +0400 (MSK)
Received: from smtp4h.mail.yandex.net (localhost [127.0.0.1])
	by smtp4h.mail.yandex.net (Yandex) with ESMTP id 374312C1EC9
	for <linux-input@vger.kernel.org>; Mon,  4 Nov 2013 12:26:42 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,


when an external USB sound card inserted in the logfile the following 
messages:
Oct 28 13:01:34 sldas kernel: [ 3036.571158] usb 2-1.2.1: new full-speed 
USB device number 9 using ehci-pci
Oct 28 13:01:35 sldas kernel: [ 3036.663870] usb 2-1.2.1: New USB device 
found, idVendor=0d8c, idProduct=000e
Oct 28 13:01:35 sldas kernel: [ 3036.663881] usb 2-1.2.1: New USB device 
strings: Mfr=0, Product=1, SerialNumber=0
Oct 28 13:01:35 sldas kernel: [ 3036.663888] usb 2-1.2.1: Product: 
Generic USB Audio Device
Oct 28 13:01:35 sldas kernel: [ 3036.682211] input: CM109 USB driver as 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.1/2-1.2.1:1.3/input/input16
Oct 28 13:01:35 sldas mtp-probe: checking bus 2, device 9: 
"/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.1"
Oct 28 13:01:35 sldas mtp-probe: bus: 2, device: 9 was not an MTP device

  idVendor and idProduct -> correct: C-Media
but CM109 USB driver is for voip phones:

$  modinfo cm109
filename: 
/lib/modules/3.2.0-4-686-pae/kernel/drivers/input/misc/cm109.ko
license:        GPL
description:    CM109 phone driver
author:         Alfred E. Heggestad
alias:          usb:v0D8Cp000Ed*dc*dsc*dp*ic03isc00ip00*
depends:        usbcore
intree:         Y
vermagic:       3.2.0-4-686-pae SMP mod_unload modversions 686
parm:           phone:Phone name {kip1000, gtalk, usbph01, atcom} (charp)

I've tried to use each parameter (kip1000, gtalk, usbph01, atcom) and 
try on a different linux distros with different kernels (also compiled 
kernel) - the result is the same card plays audio, but some functions 
don't work properly: increase, decrease volume...

In Windows 7 operating system all functions of this sound card correct...

what's the right driver can be used for this card in Linux?


p.s.  after enabling CONFIG_USB_DEBUG and rebuild the kernel in logfile 
when connecting card:


Oct 30 21:06:35 sky-19 kernel: [  232.453931] usb 2-1.2: new full-speed 
USB device number 7 using ehci-pci
Oct 30 21:06:35 sky-19 kernel: [  232.546522] usb 2-1.2: skipped 10 
descriptors after interface
Oct 30 21:06:35 sky-19 kernel: [  232.546534] usb 2-1.2: skipped 2 
descriptors after interface
Oct 30 21:06:35 sky-19 kernel: [  232.546541] usb 2-1.2: skipped 1 
descriptor after endpoint
Oct 30 21:06:35 sky-19 kernel: [  232.546547] usb 2-1.2: skipped 2 
descriptors after interface
Oct 30 21:06:35 sky-19 kernel: [  232.546552] usb 2-1.2: skipped 1 
descriptor after endpoint
Oct 30 21:06:35 sky-19 kernel: [  232.546558] usb 2-1.2: skipped 1 
descriptor after interface
Oct 30 21:06:35 sky-19 kernel: [  232.546766] usb 2-1.2: default 
language 0x0409
Oct 30 21:06:35 sky-19 kernel: [  232.547012] usb 2-1.2: udev 7, busnum 
2, minor = 134
Oct 30 21:06:35 sky-19 kernel: [  232.547021] usb 2-1.2: New USB device 
found, idVendor=0d8c, idProduct=000e
Oct 30 21:06:35 sky-19 kernel: [  232.547028] usb 2-1.2: New USB device 
strings: Mfr=0, Product=1, SerialNumber=0
Oct 30 21:06:35 sky-19 kernel: [  232.547034] usb 2-1.2: Product: 
Generic USB Audio Device
Oct 30 21:06:35 sky-19 kernel: [  232.547263] usb 2-1.2: usb_probe_device
Oct 30 21:06:35 sky-19 kernel: [  232.547271] usb 2-1.2: configuration 
#1 chosen from 1 choice
Oct 30 21:06:35 sky-19 kernel: [  232.547397] usb 2-1.2: adding 
2-1.2:1.0 (config #1, interface 0)
Oct 30 21:06:35 sky-19 kernel: [  232.547477] snd-usb-audio 2-1.2:1.0: 
usb_probe_interface
Oct 30 21:06:35 sky-19 kernel: [  232.547489] snd-usb-audio 2-1.2:1.0: 
usb_probe_interface - got id
Oct 30 21:06:35 sky-19 kernel: [  232.566883] usb 2-1.2: adding 
2-1.2:1.1 (config #1, interface 1)
Oct 30 21:06:35 sky-19 kernel: [  232.566950] usb 2-1.2: adding 
2-1.2:1.2 (config #1, interface 2)
Oct 30 21:06:35 sky-19 kernel: [  232.567009] usb 2-1.2: adding 
2-1.2:1.3 (config #1, interface 3)
Oct 30 21:06:35 sky-19 kernel: [  232.567062] usbhid 2-1.2:1.3: 
usb_probe_interface
Oct 30 21:06:35 sky-19 kernel: [  232.567069] usbhid 2-1.2:1.3: 
usb_probe_interface - got id
Oct 30 21:06:35 sky-19 kernel: [  232.567186] hub 2-1:1.0: state 7 ports 
6 chg 0000 evt 0004
Oct 30 21:06:35 sky-19 mtp-probe: checking bus 2, device 7: 
"/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2"
Oct 30 21:06:35 sky-19 mtp-probe: bus: 2, device: 7 was not an MTP device
Oct 30 21:06:35 sky-19 kernel: [  232.606164] cm109: Keymap for 
Komunikate KIP1000 phone loaded
Oct 30 21:06:35 sky-19 kernel: [  232.606189] cm109 2-1.2:1.3: 
usb_probe_interface
Oct 30 21:06:35 sky-19 kernel: [  232.606193] cm109 2-1.2:1.3: 
usb_probe_interface - got id
Oct 30 21:06:35 sky-19 kernel: [  232.606279] input: CM109 USB driver as 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.3/input/input15
Oct 30 21:06:35 sky-19 kernel: [  232.606474] usb 2-1.2: link 
qh32-0e01/ee754bc0 start 5 [1/2 us]
Oct 30 21:06:35 sky-19 kernel: [  232.607234] usbcore: registered new 
interface driver cm109
Oct 30 21:06:35 sky-19 kernel: [  232.607238] cm109: CM109 phone driver: 
20080805 (C) Alfred E. Heggestad
Oct 30 21:06:35 sky-19 kernel: [  232.611347] usb 2-1.2: unlink 
qh32-0e01/ee754bc0 start 5 [1/2 us]
Oct 30 21:06:35 sky-19 kernel: [  232.613491] ehci-pci 0000:00:1d.0: 
reused qh ee754bc0 schedule
Oct 30 21:06:35 sky-19 kernel: [  232.613498] usb 2-1.2: link 
qh32-0e01/ee754bc0 start 5 [1/2 us]



--
Best wishes,
Sohin Vyacheslav
