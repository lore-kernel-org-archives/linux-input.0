From: Valdis.Kletnieks@vt.edu
Subject: Wonkiness with keyboard adapter - not sure if it's in USB or input systems
Date: Tue, 26 Apr 2011 11:47:00 -0400
Message-ID: <11501.1303832820@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1303832820_5095P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:50142 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab1DZPrG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Apr 2011 11:47:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

--==_Exmh_1303832820_5095P
Content-Type: text/plain; charset=us-ascii

Running 2.6.39-rc1-mmotm at the moment on a Dell Latitude E6500, that wants an
external USB keyboard/mouse and monitor when it's in its docking station in the
office. I have an old Microsoft Natural keyboard that has a PS/2 connector, but
I like the tactile feel so I didn't want to get rid of it.  So we recently got
some PS2->USB adapters, which appear in lsusb as follows:

Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter

Now, when I first power up the laptop in the docking station, it *does* see the
keyboard just fine, and Grub is able to talk to it, and everything works (this
particular boot, I was able to hit the space bar to get to the Grub menu, use
arrow up/down to move between entries, all looked good).  So it isn't like the
device needs any initialization above and beyond what the BIOS is doing at
initial power-on.

However, when the Linux kernel starts up, it sees the adapter, but doesn't
recognize key presses until I disconnect and then reconnect the keyboard:

[    5.733323] usb 1-4.2: new low speed USB device number 6 using ehci_hcd
[    5.827679] usb 1-4.2: New USB device found, idVendor=0e8f, idProduct=0020
[    5.827692] usb 1-4.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.827701] usb 1-4.2: Product: PS2toUSB Adapter
[    5.827708] usb 1-4.2: Manufacturer: GASIA
[    5.846069] input: GASIA PS2toUSB Adapter as /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.2/1-4.2:1.0/input/input12
[    5.847894] generic-usb 0003:0E8F:0020.0002: input,hidraw1: USB HID v1.10 Keyboard [GASIA PS2toUSB Adapter] on usb-0000:00:1a.7-4.2/input0
[    5.855346] input: GASIA PS2toUSB Adapter as /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.2/1-4.2:1.1/input/input13
[    5.857351] generic-usb 0003:0E8F:0020.0003: input,hidraw2: USB HID v1.10 Mouse [GASIA PS2toUSB Adapter] on usb-0000:00:1a.7-4.2/input1
[  134.879149] dracut: Scanning devices dm-0  for LVM volume groups

root VG is LUKS-encrypted, so the initrd waits till the passphrase is entered.
That didn't work at 6-8 seconds in when I got the prompt - type keys, no
response from dracut.  I gave it some time, then about 2 mins after boot I
disconnected and reconnected the keyboard's PS2 connector from the adapter, and
then it worked fine, and I was able to enter the passphrase and dracut was
happy.

Not sure what to make of the fact that it registers the input devices right
off, but I see nothing in the dmesg output that the keyboard was unplugged/
replugged.

I have zero evidence that this device ever worked, as I only got it a few days
ago and haven't had a chance to try anything older than 39-rc.

Any idea/suggestions?

Oh, and the output of 'lsusb -v', here for tl;dr reasons:

Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0e8f GreenAsia Inc.
  idProduct          0x0020 USB to PS/2 Adapter
  bcdDevice            2.80
  iManufacturer           1 GASIA
  iProduct                2 PS2toUSB Adapter
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      62
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               8
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse

      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     130
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               8
Device Status:     0x0000
  (Bus Powered)


--==_Exmh_1303832820_5095P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNtuj0cC3lWbTT17ARAiwDAKCcPGOPAuYeTkP0mBE/r7T1EWlhEQCg4O4n
oaYgk9Zwhj20V3ebW9V6t68=
=z1fs
-----END PGP SIGNATURE-----

--==_Exmh_1303832820_5095P--

