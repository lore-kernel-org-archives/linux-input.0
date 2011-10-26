From: Sean Young <sean@mess.org>
Subject: BUG: hid-multitouch causes 10 second delay and error
Date: Wed, 26 Oct 2011 22:37:05 +0100
Message-ID: <20111026213705.GA32664@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pequod.mess.org ([188.220.58.213]:44692 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab1JZVgs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Oct 2011 17:36:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Since this commit:

	commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205

	HID: multitouch: decide if hid-multitouch needs to handle mt devices
    
I get the following when I insert a smartjoy device (hid-sjoy driver):

[ 3727.405037] usb 7-1: new low speed USB device number 2 using uhci_hcd
[ 3727.709082] usb 7-1: New USB device found, idVendor=6666, idProduct=8802
[ 3727.709087] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 3727.709092] usb 7-1: Product: TigerGame PS/PS2 Game Controller Adapter
[ 3727.709095] usb 7-1: Manufacturer: WiseGroup.,Ltd
[ 3738.002095] hid-multitouch 0003:6666:8802.0005: timeout initializing reports
[ 3738.007861] input: WiseGroup.,Ltd TigerGame PS/PS2 Game Controller Adapter as /devices/pci0000:00/0000:00:1d.1/usb7/7-1/7-1:1.0/input/input17
[ 3738.008137] smartjoyplus 0003:6666:8802.0005: input,hidraw4: USB HID v1.00 Joystick [WiseGroup.,Ltd TigerGame PS/PS2 Game Controller Adapter] on usb-0000:00:1d.1-1/input0
[ 3738.008163] smartjoyplus 0003:6666:8802.0005: Force feedback for SmartJoy PLUS PS2/USB adapter

Note the 10 second delay caused by the hid-multitouch error.

If I understand it correctly, the problem is that hid-multitouch now has 
a catch-all usb-id field, and does a usbhid_init_reports() on the device 
without the quirk HID_QUIRK_NOGET. 

The HID_QUIRK_NOGET for this device is listed in the hid-sjoy.c driver itself 
rather than in hid-quirks.c; presumably the latter is handled correctly.

Is there a different way of handling this rather than hid-multitouch 
messing with every usb device which identifies itself as hid? Alternatively,
should all quirks for all devices be specified in hid-quirks.c and not in
individual drivers?


Sean
