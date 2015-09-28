From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH] HID: hid-lg: Add USBID for Logitech G29 Wheel
Date: Mon, 28 Sep 2015 13:18:16 -0600
Message-ID: <fc8f57883eafaf01cd569dbe42e1a59f.squirrel@mungewell.org>
References: <1437700203-4546-1-git-send-email-simon@mungewell.org>
    <b2304f1d8d35f61bed3ae24ca68add18.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20150928131815_47821"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host8.canaca.com ([67.55.62.31]:58277 "EHLO host8.canaca.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbI1UDI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 16:03:08 -0400
In-Reply-To: <b2304f1d8d35f61bed3ae24ca68add18.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

------=_20150928131815_47821
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> I was able to get some more information, but as yet have not been able to
>  get time on the real hardware. Attached is a 2nd patch which should
> improve the support, I'll formally submit it next week.... But if anyone
> can test it first that would be great.

Obviously the 'submit next week' never happened... but I now have one of
these wheels to work on. The bad news is that the information we got does
not appear to be complete.

At present the wheel is mis-recognised as a G27 and forced into an
emulation state, it is somewhat usable in that mode.

If we send the 'G29 mode' command the wheel comes back with a device with
2x HID interfaces and that appears to screw up the probe (full log
attached).
--
Sep 28 12:30:33 retrobox kernel: [11079.944056] usb 2-1: new full-speed
USB device number 3 using uhci_hcd
Sep 28 12:30:33 retrobox kernel: [11080.113102] usb 2-1: New USB device
found, idVendor=046d, idProduct=c24f
Sep 28 12:30:33 retrobox kernel: [11080.113113] usb 2-1: New USB device
strings: Mfr=1, Product=2, SerialNumber=0
Sep 28 12:30:33 retrobox kernel: [11080.113120] usb 2-1: Product: G29
Driving Force Racing Wheel
Sep 28 12:30:33 retrobox kernel: [11080.113125] usb 2-1: Manufacturer:
Logitech
Sep 28 12:30:33 retrobox kernel: [11080.124431] input: Logitech G29
Driving Force Racing Wheel as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:046D:C24F.0002/input/input10
Sep 28 12:30:33 retrobox kernel: [11080.125134] logitech
0003:046D:C24F.0002: input,hidraw0: USB HID v1.11 Joystick [Logitech G29
Driving Force Racing Wheel] on usb-0000:00:1d.0-1/input0
Sep 28 12:30:33 retrobox kernel: [11080.126094] logitech
0003:046D:C24F.0002: Force feedback support for Logitech Gaming Wheels
Sep 28 12:30:33 retrobox kernel: [11080.134307] logitech
0003:046D:C24F.0003: hiddev0,hidraw1: USB HID v1.11 Device [Logitech G29
Driving Force Racing Wheel] on usb-0000:00:1d.0-1/input1
Sep 28 12:30:33 retrobox kernel: [11080.134319] logitech
0003:046D:C24F.0003: not enough values in HID_OUTPUT_REPORT 0 field 0
Sep 28 12:30:33 retrobox kernel: [11080.134339] logitech: probe of
0003:046D:C24F.0003 failed with error -1
--

Any suggestions as to how we can 'ignore' or unbind the 2nd interface in
order to only work with the 1st?
Simon
------=_20150928131815_47821
Content-Type: text/plain; name="g29_syslog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="g29_syslog.txt"


G29 connected, appears as DFEX then we send command to get it to reconnect
--
Sep 28 12:30:32 retrobox kernel: [11078.904047] usb 2-1: new full-speed USB device number 2 using uhci_hcd
Sep 28 12:30:32 retrobox kernel: [11079.077104] usb 2-1: New USB device found, idVendor=046d, idProduct=c294
Sep 28 12:30:32 retrobox kernel: [11079.077115] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Sep 28 12:30:32 retrobox kernel: [11079.077122] usb 2-1: Product: G29 Driving Force Racing Wheel
Sep 28 12:30:32 retrobox kernel: [11079.077128] usb 2-1: Manufacturer: Logitech
Sep 28 12:30:32 retrobox mtp-probe: checking bus 2, device 2: "/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1"
Sep 28 12:30:32 retrobox mtp-probe: bus: 2, device: 2 was not an MTP device
Sep 28 12:30:32 retrobox kernel: [11079.266693] input: Logitech G29 Driving Force Racing Wheel as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:046D:C294.0001/input/input9
Sep 28 12:30:32 retrobox kernel: [11079.267441] logitech 0003:046D:C294.0001: input,hidraw0: USB HID v1.00 Joystick [Logitech G29 Driving Force Racing Wheel] on usb-0000:00:1d.0-1/input0
Sep 28 12:30:32 retrobox kernel: [11079.276117] usbcore: registered new interface driver usbhid
Sep 28 12:30:32 retrobox kernel: [11079.276127] usbhid: USB HID core driver
Sep 28 12:30:32 retrobox kernel: [11079.320193] usb 2-1: USB disconnect, device number 2
Sep 28 12:30:32 retrobox systemd-udevd[243]: error opening USB device 'descriptors' file
Sep 28 12:30:33 retrobox kernel: [11079.944056] usb 2-1: new full-speed USB device number 3 using uhci_hcd
Sep 28 12:30:33 retrobox kernel: [11080.113102] usb 2-1: New USB device found, idVendor=046d, idProduct=c24f
Sep 28 12:30:33 retrobox kernel: [11080.113113] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Sep 28 12:30:33 retrobox kernel: [11080.113120] usb 2-1: Product: G29 Driving Force Racing Wheel
Sep 28 12:30:33 retrobox kernel: [11080.113125] usb 2-1: Manufacturer: Logitech
Sep 28 12:30:33 retrobox kernel: [11080.124431] input: Logitech G29 Driving Force Racing Wheel as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:046D:C24F.0002/input/input10
Sep 28 12:30:33 retrobox kernel: [11080.125134] logitech 0003:046D:C24F.0002: input,hidraw0: USB HID v1.11 Joystick [Logitech G29 Driving Force Racing Wheel] on usb-0000:00:1d.0-1/input0
Sep 28 12:30:33 retrobox kernel: [11080.126094] logitech 0003:046D:C24F.0002: Force feedback support for Logitech Gaming Wheels
Sep 28 12:30:33 retrobox kernel: [11080.134307] logitech 0003:046D:C24F.0003: hiddev0,hidraw1: USB HID v1.11 Device [Logitech G29 Driving Force Racing Wheel] on usb-0000:00:1d.0-1/input1
Sep 28 12:30:33 retrobox kernel: [11080.134319] logitech 0003:046D:C24F.0003: not enough values in HID_OUTPUT_REPORT 0 field 0
Sep 28 12:30:33 retrobox kernel: [11080.134339] logitech: probe of 0003:046D:C24F.0003 failed with error -1
Sep 28 12:30:33 retrobox mtp-probe: checking bus 2, device 3: "/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1"
Sep 28 12:30:33 retrobox mtp-probe: bus: 2, device: 3 was not an MTP device
--

New device has 2 interfaces, the second one is not liked at all... as noted above the probe fails. Also note that there is no report descripter presented in the 2nd interface's '/sys/bus/hid/devices/...' directory


$ lsusb --vv
--
Bus 002 Device 003: ID 046d:c24f Logitech, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc24f 
  bcdDevice           89.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           66
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              200mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     125
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
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               2
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               2
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      54
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
        wMaxPacketSize     0x0014  1x 20 bytes
        bInterval               2
--


$ ls -la /sys/bus/hid/devices/0003\:046D\:C24F.0002/
--
total 0
drwxr-xr-x 6 root root    0 Sep 28 12:37 .
drwxr-xr-x 6 root root    0 Sep 28 12:37 ..
-rw-rw-r-- 1 root root 4096 Sep 28 12:37 alternate_modes
-r--r--r-- 1 root root 4096 Sep 28 12:37 country
lrwxrwxrwx 1 root root    0 Sep 28 12:37 driver -> ../../../../../../../bus/hid/drivers/logitech
drwxr-xr-x 3 root root    0 Sep 28 12:37 hidraw
drwxr-xr-x 3 root root    0 Sep 28 12:37 input
drwxr-xr-x 7 root root    0 Sep 28 12:37 leds
-r--r--r-- 1 root root 4096 Sep 28 12:37 modalias
drwxr-xr-x 2 root root    0 Sep 28 12:37 power
-rw-rw-r-- 1 root root 4096 Sep 28 12:37 range
-r--r--r-- 1 root root 4096 Sep 28 12:37 real_id
-r--r--r-- 1 root root 4096 Sep 28 12:37 report_descriptor
lrwxrwxrwx 1 root root    0 Sep 28 12:37 subsystem -> ../../../../../../../bus/hid
-rw-r--r-- 1 root root 4096 Sep 28 12:37 uevent
--

$ ls -la /sys/bus/hid/devices/0003\:046D\:C24F.0003/
--
total 0
drwxr-xr-x 4 root root    0 Sep 28 12:35 .
drwxr-xr-x 6 root root    0 Sep 28 12:35 ..
-r--r--r-- 1 root root 4096 Sep 28 12:35 country
drwxr-xr-x 3 root root    0 Sep 28 12:35 hidraw
-r--r--r-- 1 root root 4096 Sep 28 12:35 modalias
drwxr-xr-x 2 root root    0 Sep 28 12:35 power
-r--r--r-- 1 root root 4096 Sep 28 12:35 report_descriptor
lrwxrwxrwx 1 root root    0 Sep 28 12:35 subsystem -> ../../../../../../../bus/hid
-rw-r--r-- 1 root root 4096 Sep 28 12:35 uevent
--
------=_20150928131815_47821--


