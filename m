From: "F. Heitkamp" <heitkamp@ameritech.net>
Subject: keyboards and evdev printing multiple keys
Date: Mon, 22 Dec 2008 15:09:46 -0500
Message-ID: <494FF40A.7000806@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from flpi102.sbcis.sbc.com ([207.115.20.71]:45421 "EHLO
	flpi102.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbYLVURR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2008 15:17:17 -0500
Received: from [192.168.0.2] (adsl-70-227-57-68.dsl.dytnoh.ameritech.net [70.227.57.68])
	(authenticated bits=0)
	by flpi102.prodigy.net (8.13.8 smtpauth/dk/map_regex/8.13.8) with ESMTP id mBMK9kPJ023975
	for <linux-input@vger.kernel.org>; Mon, 22 Dec 2008 12:09:56 -0800
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I am not sure this is a bug.
I have a Apple keyboard connected to a IOGear USB KVM.
I have installed evdev and the Xorg 1.5.3 server.
When I use any X apps the keyboard repeats three for one in.  i.e. 
typing one 'L' puts three of them in the input.
I noticed when looking at /proc/bus/input/devices there are three 
instanced of the keyboard.

Thanks for your help.

Fred

Here is some additional info.

bash-3.2$ more /proc/bus/input/devices
I: Bus=0019 Vendor=0000 Product=0002 Version=0000
N: Name="Power Button (FF)"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/class/input/input0
U: Uniq=
H: Handlers=kbd event0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button (CM)"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/class/input/input1
U: Uniq=
H: Handlers=kbd event1
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0003 Vendor=05ac Product=020b Version=0110
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:1d.2-1.1/input0
S: Sysfs=/class/input/input2
U: Uniq=
H: Handlers=kbd event2
B: EV=120013
B: KEY=10000 7 ff9f207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=1f

I: Bus=0003 Vendor=05ac Product=020b Version=0110
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:1d.2-1.1/input1
S: Sysfs=/class/input/input3
U: Uniq=
H: Handlers=kbd event3
B: EV=13
B: KEY=2 c000 e0000 0 0 0
B: MSC=10

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/class/input/input6
U: Uniq=
H: Handlers=kbd event5
B: EV=120013
B: KEY=4 2000000 3803078 f800d001 feffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=046d Product=c404 Version=0110
N: Name="Logitech Trackball"
P: Phys=usb-0000:00:1d.2-1.4/input0
S: Sysfs=/class/input/input10
U: Uniq=
H: Handlers=mouse0 event4
B: EV=17
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103
bash-3.2$ more /proc/bus/input/devices
I: Bus=0019 Vendor=0000 Product=0002 Version=0000
N: Name="Power Button (FF)"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/class/input/input0
U: Uniq=
H: Handlers=kbd event0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button (CM)"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/class/input/input1
U: Uniq=
H: Handlers=kbd event1
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0003 Vendor=05ac Product=020b Version=0110
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:1d.2-1.1/input0
S: Sysfs=/class/input/input2
U: Uniq=
H: Handlers=kbd event2
B: EV=120013
B: KEY=10000 7 ff9f207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=1f

I: Bus=0003 Vendor=05ac Product=020b Version=0110
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:1d.2-1.1/input1
S: Sysfs=/class/input/input3
U: Uniq=
H: Handlers=kbd event3
B: EV=13
B: KEY=2 c000 e0000 0 0 0
B: MSC=10

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/class/input/input6
U: Uniq=
H: Handlers=kbd event5
B: EV=120013
B: KEY=4 2000000 3803078 f800d001 feffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=046d Product=c404 Version=0110
N: Name="Logitech Trackball"
P: Phys=usb-0000:00:1d.2-1.4/input0
S: Sysfs=/class/input/input10
U: Uniq=
H: Handlers=mouse0 event4
B: EV=17
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

bash-3.2$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pc1lin 2.6.27.10 #55 SMP PREEMPT Sat Dec 20 17:18:12 EST 2008 i686 
GNU/Linux

Gnu C                  4.3.3
Gnu make               3.81
binutils               2.19.50.20081101
util-linux             2.13-rc3
mount                  support
module-init-tools      3.2.2
e2fsprogs              1.40.10
jfsutils               1.1.13
reiserfsprogs          3.6.19
xfsprogs               2.10.2
pcmcia-cs              3.2.0
PPP                    2.4.0
Linux C Library        2.9
Dynamic linker (ldd)   2.9
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               6.10
wireless-tools         28
Modules Loaded         nvidia coretemp lm85 hwmon_vid autofs4 nfsd lockd 
nfs_acl auth_rpcgss sunrpc exportfs ipv6 ctr twofish twofish_common 
camellia serpent blowfish aes_i586 aes_generic xcbc sha256_generic 
crypto_null ide_pci_generic firewire_ohci firewire_core usbhid e1000e 
crc_itu_t snd_echo3g snd_rawmidi snd_seq_device snd_pcm snd_timer snd 
soundcore parport_pc parport snd_page_alloc i2c_i801 shpchp ide_cd_mod 
i3000_edac thermal container piix uhci_hcd evdev ehci_hcd rng_core 
pci_hotplug processor edac_core button sr_mod cdrom st sg jfs
bash-3.2$ bash-3.2$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.




