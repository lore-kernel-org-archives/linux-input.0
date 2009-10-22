From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Chesen ps/2 usb adapter: fourth mouse button not working
Date: Thu, 22 Oct 2009 07:00:15 +0200
Message-ID: <4ADFE6DF.9080108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout01.t-online.de ([194.25.134.80]:37846 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZJVFAP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 01:00:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks,

I've got a Logitech Trackman FX connected to my PC via a
Chesen ps/2 usb adapter for mouse and keyboard. Problem: The
fourth mouse button doesn't trigger any events. This means
that I cannot enable scroll wheel emulation in the X mouse
driver, for example. It is a severe restriction.

I had opened a bug report for the Xorg mouse driver, but a low
level test program running outside of X showed that this
seems to be a problem in the kernel.

Kernel is 2.6.31.4. The same Trackman FX works fine connected
to a PC with a "real" ps/2 port (using the same kernel, of
course).


It would be very nice if this could be fixed. Of course I would
be glad to help.


Many thanx

Harri
=====================================================================
% cat /proc/bus/input/devices
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input0
U: Uniq=
H: Handlers=kbd event0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=0a81 Product=0205 Version=0110
N: Name="CHESEN PS2 to USB Converter"
P: Phys=usb-0000:00:1a.2-2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/input/input1
U: Uniq=
H: Handlers=kbd event1
B: EV=120013
B: KEY=1000000000007 ff980000000007ff febeffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=0a81 Product=0205 Version=0110
N: Name="CHESEN PS2 to USB Converter"
P: Phys=usb-0000:00:1a.2-2/input1
S: Sysfs=/devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.1/input/input2
U: Uniq=
H: Handlers=kbd mouse0 event2
B: EV=17
B: KEY=1f001f 2020000 3878d801d001 1e000000000000 0
B: REL=103
B: MSC=10

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
U: Uniq=
H: Handlers=kbd event3
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input4
U: Uniq=
H: Handlers=kbd event4
B: EV=3
B: KEY=10000000000000 0

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
S: Sysfs=/devices/platform/pcspkr/input/input5
U: Uniq=
H: Handlers=kbd event5
B: EV=40001
B: SND=6
