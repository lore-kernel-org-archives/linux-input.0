From: simon@mungewell.org
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Sat, 16 Nov 2013 17:30:25 -0500
Message-ID: <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131116173025_18109"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50519 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3KPWa2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 17:30:28 -0500
In-Reply-To: <1384021557-24106-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>, Sven Eckelmann <sven@narfation.org>

------=_20131116173025_18109
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> Sony Dualshock 3 controllers have two motors which can be used to provide
> simple force feedback rumble effects. The right motor is can be used to
> create
> a weak rumble effect but does not allow to set the force. The left motor
> is
> used to create a strong rumble effect with adjustable intensity.

Hi,
This patch appears to work OK with my DualShock/SixAxis controller (USB
connection), but causes a machine lockup when used with my Intec wired
controller.

The Intec controller works OK up to the point when I start rumble,
sometimes the motor runs some times it doesn't. I am using SDL2's
'testhaptic' application.

Syslog log attached detail controller.

If you have any specific tests to run, please advise,
Simon
------=_20131116173025_18109
Content-Type: text/plain; name="intec.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="intec.txt"

Nov 16 14:26:21 womble kernel: [   95.296039] usb 3-1: new full-speed USB device number 2 using uhci_hcd
Nov 16 14:26:22 womble kernel: [   95.463964] usb 3-1: New USB device found, idVendor=054c, idProduct=0268
Nov 16 14:26:22 womble kernel: [   95.463973] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 16 14:26:22 womble kernel: [   95.463978] usb 3-1: Product: PLAYSTATION(R)3 Controller
Nov 16 14:26:22 womble kernel: [   95.463982] usb 3-1: Manufacturer: GASIA CORP.
Nov 16 14:26:22 womble mtp-probe: checking bus 3, device 2: "/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-1"
Nov 16 14:26:22 womble mtp-probe: bus: 3, device: 2 was not an MTP device
Nov 16 14:26:22 womble kernel: [   95.770400] usbcore: registered new interface driver usbhid
Nov 16 14:26:22 womble kernel: [   95.770408] usbhid: USB HID core driver
Nov 16 14:26:22 womble kernel: [   95.838174] sony 0003:054C:0268.0001: Fixing up Sony Sixaxis report descriptor
Nov 16 14:26:22 womble kernel: [   95.848763] input: GASIA CORP. PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input7
Nov 16 14:26:22 womble kernel: [   95.849784] sony 0003:054C:0268.0001: input,hiddev0,hidraw0: USB HID v1.11 Joystick [GASIA CORP. PLAYSTATION(R)3 Controller] on usb-0000:00:1d.1-1/input0

------=_20131116173025_18109--


