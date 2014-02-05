From: simon@mungewell.org
Subject: BUG: HID: hid-sony - LEDs on 3rd party controller
Date: Wed, 5 Feb 2014 13:10:32 -0500
Message-ID: <35071f8ed3fbe8f20d074f0a5018706c.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39581 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbaBESKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 13:10:34 -0500
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1WB6vg-0003sd-3T
	for linux-input@vger.kernel.org; Wed, 05 Feb 2014 13:10:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Tested 3.14rc1 on a collection of PS3/PS4 controllers, and noticed that
behaviour of the LEDs is 'odd' on a third party controller.

The controller shows 4 leds, which flash together when first plugged in.
Individual leds can be controlled via the '/sys/class/led/' interface,
however when all leds are set to off (0) the 'all flashing' restarts.

This is different to the official controllers (SixAxis and Dualshock4)
which will extingush all leds as expected.

The controller in question is made by Intec and identifies as
--
Nov 16 14:26:21 womble kernel: [   95.296039] usb 3-1: new full-speed USB
device
number 2 using uhci_hcd
Nov 16 14:26:22 womble kernel: [   95.463964] usb 3-1: New USB device found,
idVendor=054c, idProduct=0268
Nov 16 14:26:22 womble kernel: [   95.463973] usb 3-1: New USB device
strings:
Mfr=1, Product=2, SerialNumber=0
Nov 16 14:26:22 womble kernel: [   95.463978] usb 3-1: Product:
PLAYSTATION(R)3
Controller
Nov 16 14:26:22 womble kernel: [   95.463982] usb 3-1: Manufacturer: GASIA
CORP.
Nov 16 14:26:22 womble mtp-probe: checking bus 3, device 2:
"/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-1"
Nov 16 14:26:22 womble mtp-probe: bus: 3, device: 2 was not an MTP device
Nov 16 14:26:22 womble kernel: [   95.770400] usbcore: registered new
interface
driver usbhid
Nov 16 14:26:22 womble kernel: [   95.770408] usbhid: USB HID core driver
Nov 16 14:26:22 womble kernel: [   95.838174] sony 0003:054C:0268.0001:
Fixing up
Sony Sixaxis report descriptor
Nov 16 14:26:22 womble kernel: [   95.848763] input: GASIA CORP.
PLAYSTATION(R)3
Controller as /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input7
Nov 16 14:26:22 womble kernel: [   95.849784] sony 0003:054C:0268.0001:
input,hiddev0,hidraw0: USB HID v1.11 Joystick [GASIA CORP. PLAYSTATION(R)3
Controller] on usb-0000:00:1d.1-1/input0
--

I made some comments previously which may be of use in fixing this:
http://www.spinics.net/lists/linux-input/msg28271.html

Cheers,
Simon.

