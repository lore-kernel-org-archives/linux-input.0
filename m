From: Christian Engelmayer <christian.engelmayer@frequentis.com>
Subject: [RFC] usbtouchscreen: stuck BTN_TOUCH release events
Date: Fri, 11 Oct 2013 13:42:28 +0200
Message-ID: <20131011134228.1ec2567a@frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.frequentis.com ([195.20.158.50]:41666 "EHLO
	mail1.frequentis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab3JKLxB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Oct 2013 07:53:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, christian.engelmayer@frequentis.com

Hello,

We are using the usbtouchscreen driver for a 0eef:0001 eGalax based device and
have observed cases were BTN_TOUCH seems to be stuck as release events are not
reported promptly. In those situations the release event is reported after
arbitrary time when the next touch event is triggered.

An usbmon trace shows that the problem occurs reproducible when the final 5
byte report containing the liftoff event finishes at an 8 byte boundary:

   ceb81c80 1241543630 C Ii:1:002:1 0:4 16 = 81097c0a 5b81097c 0a5a8109 7b0a5a81
   ceb81c80 1241543964 S Ii:1:002:1 -115:4 16 <
   ceb81c80 1241555630 C Ii:1:002:1 0:4 16 = 097a0a5a 8109780a 59810975 0a578109
   ceb81c80 1241555988 S Ii:1:002:1 -115:4 16 <

   ---[abort - urb gets unlinked]---

   ceb81c80 1250629867 C Ii:1:002:1 -2:4 8 = 730a5380 09730a53

The usbtouchscreen driver is aware of both the report and diagnostic packets
supported by the controller. It enables multi frame support and defines the
report size for the eGalax to the 16 byte maximum diagnostic packet size
opposed to the 5 byte coordinate report.

In my opinion the situation described above is caused because the same size
definition is used for buffer allocation and interrupt endpoint requests to
the USB subsystem. The ehci-hcd will split the 16 byte request into up to 2
accesses according to the wMaxPacketSize of 8 byte for this endpoint. In case
the first transfer is answered by the eGalax with not less than the full 8 byte
requested, the host controller has got no way of knowing that the touch
controller will not have additional queued data until the next touch event.

As I am normally not involved into input drivers, please give me a hint to a
solution to this issue that would be acceptable for the maintainers and I can
prepare a tested patch accordingly.

Regards,
Christian

---

Bus 001 Device 002: ID 0eef:0001 D-WAV Scientific Co., Ltd eGalax TouchScreen
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0eef D-WAV Scientific Co., Ltd
  idProduct          0x0001 eGalax TouchScreen
  bcdDevice            1.00
  iManufacturer           1 eGalax Inc.
  iProduct                2 USB TouchController
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 USB TouchScreen
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               5
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            3.04
  iManufacturer           3 Linux 3.4.61-rel_4_4002_0-svn216359 ehci_hcd
  iProduct                2 Freescale On-Chip EHCI Host Controller
  iSerial                 1 fsl-ehci.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             1
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0303 lowspeed power enable connect
Device Status:     0x0001
  Self Powered
