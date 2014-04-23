From: simon@mungewell.org
Subject: Re: Bug: HID-Sony: DS4 touch-pad corrupts Axis0
Date: Tue, 22 Apr 2014 23:21:29 -0400
Message-ID: <4af72268126ca3c2c9468b4064ce9491.squirrel@mungewell.org>
References: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
    <535555C6.5050407@gmail.com> <53557CB5.1010100@gmail.com>
    <35342da9a382362bc86ab7abfa7ee07a.squirrel@mungewell.org>
    <5356A774.5050505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140422232129_53336"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:44933 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbaDWDVd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 23:21:33 -0400
In-Reply-To: <5356A774.5050505@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

------=_20140422232129_53336
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> It might be a matter of the joydev module not being loaded into memory
> the first time thus allowing the probe function to complete and set the
> proper axis bits before the js* device is created.  On subsequent
> connects the module would already be loaded so the js* device would be
> created before the extra axis bits are set, assuming that my earlier
> hypothesis is correct and the joystick device is being created before
> the probe function returns.

You are correct... I did some quick testing and it appears that 'joydev'
and 'hid-sony' are remaining loaded after the controller is unplugged.

In this state when the DS4 is reconnected (2nd time) jstest shows 14 axes.
--
Driver version is 2.1.0.
Joystick (Sony Computer Entertainment Wireless Controller) has 14 axes (X,
Y, Z, Rx, Ry, Rz, Hat0X, Hat0Y, (null), (null), (null), (null), (null),
(null))
and 14 buttons (BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect,
BtnStart, BtnMode, BtnThumbL, BtnThumbR, ?, ?).
Testing ... (interrupt to exit)
--

If I 'sudo rmmod joydev' after removing the DS4 and then plug it back in
(3rd time), we get 18 axis (as we should)
--
Driver version is 2.1.0.
Joystick (Sony Computer Entertainment Wireless Controller) has 18 axes (X,
Y, Z, Rx, Ry, Rz, Hat0X, Hat0Y, (null), (null), (null), (null), (null),
(null), (null), (null), (null), (null))
and 14 buttons (BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect,
BtnStart, BtnMode, BtnThumbL, BtnThumbR, ?, ?).
Testing ... (interrupt to exit)
--

Also when in the 'faulty/14 axis' state, I can 'sudo rmmod joydev' and
'sudo modprobe joydev' to return it to the 'correct/18 axes' state without
unplugging the DS4.

The HID report descriptors (from /sys/bus/hid/...) are identical on all
plug in cycles, as is the 'syslog' text.

If I blacklist hid-sony I do not get a 'js0' to check and no report
descriptor is present.


Anything else I can test for you guys?
Simon
------=_20140422232129_53336
Content-Type: text/plain; name="syslog_2nd.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="syslog_2nd.txt"

Apr 22 20:48:07 bigbox kernel: [ 2529.236727] usb 5-2: USB disconnect, device number 3
Apr 22 20:49:10 bigbox kernel: [ 2592.524323] usb 5-2: new full-speed USB device number 4 using uhci_hcd
Apr 22 20:49:11 bigbox kernel: [ 2592.900863] usb 5-2: New USB device found, idVendor=054c, idProduct=05c4
Apr 22 20:49:11 bigbox kernel: [ 2592.900870] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Apr 22 20:49:11 bigbox kernel: [ 2592.900873] usb 5-2: Product: Wireless Controller
Apr 22 20:49:11 bigbox kernel: [ 2592.900875] usb 5-2: Manufacturer: Sony Computer Entertainment
Apr 22 20:49:11 bigbox kernel: [ 2592.907030] sony 0003:054C:05C4.0003: Using modified Dualshock 4 report descriptor with gyroscope axes
Apr 22 20:49:11 bigbox kernel: [ 2592.952084] input: Sony Computer Entertainment Wireless Controller as /devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/0003:054C:05C4.0003/input/input6
Apr 22 20:49:11 bigbox kernel: [ 2592.952404] sony 0003:054C:05C4.0003: input,hidraw1: USB HID v1.11 Gamepad [Sony Computer Entertainment Wireless Controller] on usb-0000:00:1d.3-2/input0
Apr 22 20:49:11 bigbox mtp-probe: checking bus 5, device 4: "/sys/devices/pci0000:00/0000:00:1d.3/usb5/5-2"
Apr 22 20:49:11 bigbox mtp-probe: bus: 5, device: 4 was not an MTP device
------=_20140422232129_53336
Content-Type: text/plain; name="syslog_3rd.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="syslog_3rd.txt"

Apr 22 20:50:40 bigbox kernel: [ 2682.258150] usb 5-2: USB disconnect, device number 4
Apr 22 20:51:45 bigbox kernel: [ 2747.112424] usb 5-2: new full-speed USB device number 5 using uhci_hcd
Apr 22 20:51:45 bigbox kernel: [ 2747.284439] usb 5-2: New USB device found, idVendor=054c, idProduct=05c4
Apr 22 20:51:45 bigbox kernel: [ 2747.284446] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Apr 22 20:51:45 bigbox kernel: [ 2747.284450] usb 5-2: Product: Wireless Controller
Apr 22 20:51:45 bigbox kernel: [ 2747.284452] usb 5-2: Manufacturer: Sony Computer Entertainment
Apr 22 20:51:45 bigbox kernel: [ 2747.290508] sony 0003:054C:05C4.0004: Using modified Dualshock 4 report descriptor with gyroscope axes
Apr 22 20:51:45 bigbox kernel: [ 2747.335577] input: Sony Computer Entertainment Wireless Controller as /devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/0003:054C:05C4.0004/input/input7
Apr 22 20:51:45 bigbox kernel: [ 2747.335881] sony 0003:054C:05C4.0004: input,hidraw1: USB HID v1.11 Gamepad [Sony Computer Entertainment Wireless Controller] on usb-0000:00:1d.3-2/input0
Apr 22 20:51:45 bigbox mtp-probe: checking bus 5, device 5: "/sys/devices/pci0000:00/0000:00:1d.3/usb5/5-2"
Apr 22 20:51:45 bigbox mtp-probe: bus: 5, device: 5 was not an MTP device
------=_20140422232129_53336--


