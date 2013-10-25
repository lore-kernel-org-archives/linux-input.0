From: "Stephen Oberski" <sfo@cargocult.ca>
Subject: changes to ati_remote to support ATI Remote Wonder Plus RF Remote
     Control
Date: Fri, 25 Oct 2013 09:19:22 -0400 (EDT)
Message-ID: <34245.198.84.133.226.1382707162.squirrel@cargocult.ca>
Reply-To: sfo@cargocult.ca
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131025091922_99989"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.micro-line.net ([76.74.194.3]:43367 "EHLO
	smtp1.micro-line.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3JYNpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 09:45:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: sfo@cargocult.ca

------=_20131025091922_99989
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Attached is a text document describing proposed changes to the ati_remote kernel module to support
the ATI Remote Wonder Plus RF Remote Control.

I've forwarded these proposed changes to the listed authors of the module for review (Anssi
Hannula <anssi.hannula@XXX.YYY> and Torrey Hoffman <thoffman@XXX.YYY>) and have not heard back
from Anssi Hannul and I include Torrey Hoffman's response below.

Thanks,

-- 
Stephen Oberski sfo@cargocult.ca
289 430 5076
http://ca.linkedin.com/in/stephenoberski/


---------------------------------------- Original Message ----------------------------------------
Subject: Re: [Fwd: changes to ati_remote to support ATI Remote Wonder Plus RF Remote Control]
From:    "Torrey Hoffman" <thoffman@XXX.YYY>
Date:    Mon, October 21, 2013 12:21 pm
To:      sfo@cargocult.ca
--------------------------------------------------------------------------------------------------

Thanks for the heads up, and for working on this.

Unfortunately I no longer have any relevant hardware to test with.  If you
would like to be the official maintainer of this module, that would be
excellent.

Best wishes,

Torrey


On Mon, Oct 21, 2013 at 5:18 PM, Stephen Oberski <sfo@cargocult.ca> wrote:

> Hi Torrey,
>
> Attached is a text document describing proposed changes to the ati_remote
> kernel module to support
> the ATI Remote Wonder Plus RF Remote Control.
>
> I am sending this to you as the author of the module before posting to the
> linux-input mailing
> list and would appreciate any feedback.
>
> Thanks,
>
> --
> Stephen Oberski sfo@cargocult.ca
> 289 430 5076
> http://ca.linkedin.com/in/stephenoberski/
>
>
> ---------------------------------------- Original Message
> ----------------------------------------
> Subject: changes to ati_remote to support ATI Remote Wonder Plus RF Remote
>      Control
> From:    "Stephen Oberski" <sfo@cargocult.ca>
> Date:    Sat, October 12, 2013 9:53 pm
> To:      anssi.hannula@XXX.YYY
> Cc:      sfo@cargocult.ca
>
> --------------------------------------------------------------------------------------------------
>
> Hi Anssi,
>
> Attached is a text document describing proposed changes to the ati_remote
> kernel module to support
> the ATI Remote Wonder Plus RF Remote Control.
>
> I am sending this to you as the author of the module before posting to the
> linux-input mailing
> list and would appreciated any feedback.
>
> Thanks,
>
> --
> Stephen Oberski sfo@cargocult.ca
> 289 430 5076
>
------=_20131025091922_99989
Content-Type: text/plain; name="linux-input_ati_remote-problem.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="linux-input_ati_remote-problem.txt"

Proposed changes to the ati_remote kernel loadable module (drivers/media/rc/ati_remote.c) to support the ATI Remote Wonder Plus RF Remote Control
-------------------------------------------------------------------------------------------------------------------------------------------------

Date: Thu Oct 10 10:53:59 EDT 2013

By: Stephen Oberski (sfo@cargocult.ca)

Overview
========

The ati_remote.c USB ATI Remote support loadable kernel module (Version 2.2.0, Linux 3.8.0-31-generic) 
supports the SnapStream Media Firefly PC Remote Wireless Receiver Model R1000-1 receiver (FF receiver) with the Firefly RF Remote Control Model R1000 (FF remote).

It also supports the ATI USB RF Wireless Remote Receiver Part # 5000027000G receiver (ATI receiver) with the Firefly RF Remote Control Model R1000.

However neither the SnapStream Media Firefly PC Remote Wireless Receiver Model R1000-1 receiver nor the ATI USB RF Wireless Remote Receiver Part # 5000027000G receiver
are supported with the ATI Remote Wonder Plus RF Remote Control Part # 5000026900G (ATI remote).

A simple change to the ati_remote.c module results in the support of all combinations of the FF and ATI RF receivers and remotes.

The RF receiver initialization sequence is modified and the processing of the 4 byte remote inputs by the driver is modified to support a leading byte value of 0x15 as well as the current 0x14.

These changes appear to be backward compatible and do no seem to impact the existing behaviour of the module when presented with data from currently supported RF receiver and remote combinations
while allowing currently unsupported combinations to be used.

Problem Scope
=============

It appears that data generated by the ATI remote is never being received by the ati_remote kernel module:

============================== CUT HERE ==============================
# terminal window 1
# modprobe usbmon
# cd /sys/kernel/debug/usb/usbmon
# lsusb
...
Bus 004 Device 008: ID 0bc7:0004 X10 Wireless Technology, Inc. X10 Receiver
...
# rmmod ati_remote
# modprobe ati_remote

# terminal window 2
# grep --line-buffered '4:008' 4u
ffff88018a00d3c0 1361036384 C Ii:4:008:1 -108:8 0
ffff88018a00d240 1385420709 S Io:4:008:2 -115:8 5 = 80010020 14
ffff88018a00d240 1385424393 C Io:4:008:2 0:8 5 >
ffff88018a00d240 1385424401 S Io:4:008:2 -115:8 8 = 80010020 14202020
ffff88018a00d240 1385432392 C Io:4:008:2 0:8 8 >
ffff88018a00da80 1385432519 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1385440394 C Ii:4:008:1 0:8 1 = ff
ffff88018a00da80 1385440399 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415136406 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415136432 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415176406 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415176413 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415216405 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415216411 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415256404 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415256410 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415296405 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415296412 S Ii:4:008:1 -115:8 8 <
ffff88018a00da80 1415336404 C Ii:4:008:1 0:8 4 = 14658010
ffff88018a00da80 1415336410 S Ii:4:008:1 -115:8 8 <
============================== CUT HERE ==============================

We log USB data for the RF receiver in window 2.

In window 1 we enable USB monitoring and unload and reload the ati_remote module.

We can see the 2 initialization strings being sent to the RF receiver via the interrupt out (Io) lines
and then when we press the Firefly key on the FF remote we see the repeated USB packets sent by the RF remote (14658010).

However when we press any keys on the ATI remote no data is logged by usbmon.

This indicates that the RF receiver is ignoring data sent by the ATI remote when initialized by the ati_remote modules.

However when we load the modified version of the ati_remote module we see:

============================== CUT HERE ==============================
# rmmod ati_remote
# insmod ./ati_remote_plus.ko
# grep --line-buffered '4:008' 4u
ffff88018a00da80 2183228699 C Ii:4:008:1 -108:8 0
ffff880181305a80 2197203596 S Io:4:008:2 -115:8 9 = 8080051b 15142024 15
ffff880181305a80 2197216703 C Io:4:008:2 0:8 9 >
ffff880181305a80 2197216761 S Io:4:008:2 -115:8 3 = 808303
ffff880181305a80 2197224702 C Io:4:008:2 0:8 3 >
ffff880181305a80 2197224714 S Io:4:008:2 -115:8 4 = 8084d720
ffff880181305a80 2197232701 C Io:4:008:2 0:8 4 >
ffff8801813050c0 2197232835 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2197240704 C Ii:4:008:1 0:8 1 = 00
ffff8801813050c0 2197240711 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2219904713 C Ii:4:008:1 0:8 4 = 14658010
ffff8801813050c0 2219904740 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2219944712 C Ii:4:008:1 0:8 4 = 14658010
ffff8801813050c0 2219944720 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2219984712 C Ii:4:008:1 0:8 4 = 14658010
ffff8801813050c0 2219984718 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2220024715 C Ii:4:008:1 0:8 4 = 14658010
ffff8801813050c0 2220024722 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2220064715 C Ii:4:008:1 0:8 4 = 14658010
ffff8801813050c0 2220064721 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2221952713 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2221952740 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2221992712 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2221992720 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2222032713 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2222032720 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2222072715 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2222072721 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2222120710 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2222120716 S Ii:4:008:1 -115:8 8 <
ffff8801813050c0 2222160714 C Ii:4:008:1 0:8 4 = 15222d20
ffff8801813050c0 2222160720 S Ii:4:008:1 -115:8 8 <
============================== CUT HERE ==============================

Here we can see the modified initialization sequence being sent to the RF remote and when we press the Firefly key on the FF remote we see the repeated USB packets sent by the FF remote (14658010)
and when we press the ATI key on the ATI remote we see the repeated USB packets sent by the ATI remote (15222d20).

The conclusion is that the RF receiver initialization must be changed in the ati_remote module in order to support the ATI remote.

History
=======

The changes made to the ati_remote.c module are based on changes made to the LIRC lirc_atiusb.c code [1] 
by Cymen Vig in Feb 2006, who used a USB packet snooping program on Windows, these changes now seems to have disappeared from the current version of LIRC (0.9.0)
and a patch made to the drivers/media/rc/ati_remote.c file for the 2.6.31 kernel [2] which was never committed into the Linux source tree.

Hardware
========

- ATI USB RF Wireless Remote Receiver Part # 5000027000G:

Oct 10 16:07:08 acer-Veriton-N282G kernel: [695612.752080] usb 2-2: new low-speed USB device number 4 using uhci_hcd
Oct 10 16:07:08 acer-Veriton-N282G kernel: [695612.929218] usb 2-2: New USB device found, idVendor=0bc7, idProduct=0004
Oct 10 16:07:08 acer-Veriton-N282G kernel: [695612.929227] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Oct 10 16:07:08 acer-Veriton-N282G kernel: [695612.929233] usb 2-2: Product: USB Receiver
Oct 10 16:07:08 acer-Veriton-N282G kernel: [695612.929239] usb 2-2: Manufacturer: X10 Wireless Technology Inc
Oct 10 16:07:08 acer-Veriton-N282G kernel: [695613.044063] Registered IR keymap rc-ati-x10

- SnapStream Media Firefly PC Remote Wireless Receiver Model R1000-1:

Oct 10 19:14:59 OptiPlex-755 kernel: [534490.804065] usb 4-1: new low-speed USB device number 6 using uhci_hcd
Oct 10 19:14:59 OptiPlex-755 kernel: [534490.974451] usb 4-1: New USB device found, idVendor=0bc7, idProduct=0008
Oct 10 19:14:59 OptiPlex-755 kernel: [534490.974455] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Oct 10 19:14:59 OptiPlex-755 kernel: [534490.974458] usb 4-1: Product: USB Receiver
Oct 10 19:14:59 OptiPlex-755 kernel: [534490.974461] usb 4-1: Manufacturer: X10 Wireless Technology Inc
Oct 10 19:15:00 OptiPlex-755 kernel: [534491.032019] Registered IR keymap rc-snapstream-firefly

- Firefly RF Remote Control Model R1000

- ATI Remote Wonder Plus RF Remote Control Part # 5000026900G

Product ID Test Coverage
========================

+--------------------------+------+-----+------+-----------------------+---------------------+
|Product Name              +ID    +FF RC+ATI RC+3.8.0-31-generic/x86_64+3.8.0-31-generic/i686|
+--------------------------+------+-----+------+-----------------------+---------------------+
|LOLA_REMOTE_PRODUCT_ID    |0x0002|No   |No    |No                     |No                   |
|LOLA2_REMOTE_PRODUCT_ID   |0x0003|No   |No    |No                     |No                   |
|ATI_REMOTE_PRODUCT_ID     |0x0004|Yes  |Yes   |Yes                    |Yes                  |
|NVIDIA_REMOTE_PRODUCT_ID  |0x0005|No   |No    |No                     |No                   |
|MEDION_REMOTE_PRODUCT_ID  |0x0006|No   |No    |No                     |No                   |
|FIREFLY_REMOTE_PRODUCT_ID |0x0008|Yes  |Yes   |Yes                    |Yes                  |
+--------------------------+------+-----+------+-----------------------+---------------------+

FF RC: Firefly Remote Control
ATI RC: ATI Remote Control
3.8.0-31-generic/x86_64: 64 bit kernel
3.8.0-31-generic/i686: 32 bit kernel
Yes: Successful test
No: Not tested

Userspace Test
==============

A userspace test program [3] was developed to test the Remote receiver and remote control combinations.
It locates the X10 receiver by searching the USB devices for a Vendor ID of 0xbc7, any Product ID is allowed.
It then initializes the X10 receiver via interrupt writes using the new initialization strings discovered by Cymen Vig [1]:

static char init1[] = { 0x80, 0x05, 0x1b, 0x15, 0x14, 0x20, 0x24, 0x15 };
static char init2[] = { 0x83, 0x03 };
static char init3[] = { 0x84, 0xd7, 0x020 };

It then enters a loop and displays all packets received via interrupt reads, along with the computed checksum.

It is assumed that the libusb-dev: "userspace USB programming library development files" package is installed.

Compile and link as follows:

$ gcc -c testlibusb1.c
$ gcc testlibusb1.o -o testlibusb1 -lusb

Unload the "ati_remote" module if loaded:

$ sudo rmmod ati_remote

Run the test program:

$ sudo ./testlibusb1
...
found X10 0xbc7:0x8
found 1 interfaces
found 2 endpoints
endpoint 0 direction IN 0x81
endpoint 1 direction OUT 0x2
X10 open() OK
X10 set configuration OK
X10 claim interface 0 OK
X10 write 8 bytes to endpoint 0x2 OK with 8 bytes written
X10 write 2 bytes to endpoint 0x2 OK with 2 bytes written
X10 write 3 bytes to endpoint 0x2 OK with 3 bytes written
X10 read from endpoint 0x1 returned 4
 0:14  1:e5  2:00  3:10 checksum e5 
X10 read from endpoint 0x1 returned 4
 0:14  1:e5  2:00  3:10 checksum e5 
X10 read from endpoint 0x1 returned 4
 0:14  1:e5  2:00  3:10 checksum e5 
X10 read from endpoint 0x1 returned 4
X10 read from endpoint 0x1 returned 4
 0:15  1:a2  2:ad  3:20 checksum a2 
X10 read from endpoint 0x1 returned 4
 0:15  1:a2  2:ad  3:20 checksum a2 
X10 read from endpoint 0x1 returned 4
 0:15  1:a2  2:ad  3:20 checksum a2 
X10 read from endpoint 0x1 returned 4
 0:15  1:a2  2:ad  3:20 checksum a2
...
^C

In the sample output above the SnapStream Media Firefly PC Remote Wireless Receiver Model R1000-1 was connected as can be seen by the Vendor ID value of 0x8.
Each remote key press generates 4 usb packets, each USB packet is always 4 bytes in length.

The first 4 packets were from the Firefly button on the Firefly RF Remote Control Model R1000, byte 0 is always 0x14 for this remote.

The second 4 packets were from the ATI button on the ATI Remote Wonder Plus RF Remote Control Part # 5000026900G, byte 0 is always 0x15 for this remote.

Other than the value of byte 0 the format of the the USB packets generated by the Firefly and ATI remotes are identical, including the channel mask (byte 3) and checksum calculation.

Exactly the same results are obtained when the ATI USB RF Wireless Remote Receiver Part # 5000027000G is used.

Conclusions
===========

The modified version of the ati_remote driver [4] and the corresponding patch file [5] are provided.

The untested Product ID and remote control combinations need to be tested.
I have no access to the untested RF receivers corresponding to the Product IDs so perhaps users on the linux-input and linux-media 
could test this patch using other RF receiver and remote combinations.

References
==========

[1] http://www.mythtv.org/pipermail/mythtv-users/2006-February/121861.html
[2] http://www.mythtv.org/wiki/ATI_Remote_Wonder_Plus
[3] http://cargocult.ca/testlibusb1.c
[4] http://cargocult.ca/ati_remote_plus.c
[5] http://cargocult.ca/ati_remote.patch
------=_20131025091922_99989--


