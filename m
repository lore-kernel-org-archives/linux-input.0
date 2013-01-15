From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: DIALOGUE INC PenMount USB
Date: Tue, 15 Jan 2013 17:22:05 +0100
Message-ID: <CAH9NwWfoyWkF48VEtsQfCRTZvvZfiwnU_S3xgfui3zqbfepsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:58890 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3AOQW1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2013 11:22:27 -0500
Received: by mail-qa0-f44.google.com with SMTP id z4so2531936qan.10
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2013 08:22:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This device was working with 3.2.35 but fails with 3.6.11


Bus 002 Device 002: ID 14e1:6000 Dialogue Technology Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x14e1 Dialogue Technology Corp.
  idProduct          0x6000
  bcdDevice           a4.b4
  iManufacturer           1 DIALOGUE INC
  iProduct                2 PenMount USB
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 full speed
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              3 EndPoint1 Interrupt Pipe
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.01
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      76
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
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)


working:

[    1.833598] usbcore: registered new interface driver usbfs
[    1.833922] usbcore: registered new interface driver hub
[    1.858067] usbcore: registered new device driver usb
[    1.881379] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.881765] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[    1.884870] uhci_hcd: USB Universal Host Controller Interface driver
[    1.897422] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.897433] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.897740] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned
bus number 1
[    1.898188] ehci_hcd 0000:00:1d.7: debug port 1
[    1.912668] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.912721] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfea3bc00
[    1.926054] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.930387] hub 1-0:1.0: USB hub found
[    1.930621] hub 1-0:1.0: 8 ports detected
[    1.930994] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    1.931394] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.931402] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.931687] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 2
[    1.932143] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000d480
[    1.932755] hub 2-0:1.0: USB hub found
[    1.932981] hub 2-0:1.0: 2 ports detected
[    1.933317] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.933675] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.933682] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.933964] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
bus number 3
[    1.946535] uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000d080
[    1.950706] hub 3-0:1.0: USB hub found
[    1.950939] hub 3-0:1.0: 2 ports detected
[    1.951303] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 22 (level, low) -> IRQ 22
[    1.951665] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.951673] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.951956] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
bus number 4
[    1.966181] uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000c880
[    1.971477] hub 4-0:1.0: USB hub found
[    1.971712] hub 4-0:1.0: 2 ports detected
[    2.438169] usb 2-1: new full-speed USB device number 2 using uhci_hcd
[    2.606975] input: DIALOGUE INC PenMount USB as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/input/input0
[    2.607690] generic-usb 0003:14E1:6000.0001: input: USB HID v1.01
Mouse [DIALOGUE INC PenMount USB] on usb-0000:00:1d.0-1/input0
[    2.608693] usbcore: registered new interface driver usbhid
[    2.608988] usbhid: USB HID core driver

.config: http://dpaste.com/hold/877936/


not working:

[    1.738905] usbcore: registered new interface driver usbfs
[    1.738939] usbcore: registered new interface driver hub
[    1.762950] usbcore: registered new device driver usb
[    1.772483] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.772567] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.772576] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.772592] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned
bus number 1
[    1.801074] ehci_hcd 0000:00:1d.7: debug port 1
[    1.801094] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.801144] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfea3bc00
[    1.807973] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.808344] hub 1-0:1.0: USB hub found
[    1.808358] hub 1-0:1.0: 8 ports detected
[    1.820564] uhci_hcd: USB Universal Host Controller Interface driver
[    1.820638] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.820646] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.820665] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 2
[    1.820731] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000d480
[    1.829882] hub 2-0:1.0: USB hub found
[    1.829899] hub 2-0:1.0: 2 ports detected
[    1.833426] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.833438] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.833455] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
bus number 3
[    1.833617] uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000d080
[    1.837553] hub 3-0:1.0: USB hub found
[    1.837570] hub 3-0:1.0: 2 ports detected
[    1.840114] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.840125] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.840141] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
bus number 4
[    1.840205] uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000c880
[    1.846546] hub 4-0:1.0: USB hub found
[    1.846569] hub 4-0:1.0: 2 ports detected
[    2.291324] EXT3-fs (sda2): mounted filesystem with ordered data mode
[    2.291986] kjournald starting.  Commit interval 5 seconds
[    2.420068] usb 2-1: new full-speed USB device number 2 using uhci_hcd
[    2.557292] udev[1225]: starting version 164
[    2.608887] usbcore: registered new interface driver usbhid

.config: http://dpaste.com/hold/877937/


Does anybody have an hint for me?

thanks
--
Christian Gmeiner, MSc
