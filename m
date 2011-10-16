From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray@wp.pl>
Subject: Genius Ergomedia 700 USB keyboard hangs up after GET_STATUS
Date: Sun, 16 Oct 2011 16:44:52 +0200
Message-ID: <20111016164452.51b21a31@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.7]:54226 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705Ab1JPOvf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Oct 2011 10:51:35 -0400
Received: from 89-69-158-229.dynamic.chello.pl (HELO north) (moorray@[89.69.158.229])
          (envelope-sender <moorray@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES128-SHA encrypted SMTP
          for <linux-input@vger.kernel.org>; 16 Oct 2011 16:44:52 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,
I've got Genius Ergomedia 700 keyboard which hangs up after waking up
from suspend or running `ls -v'. I seems that what makes the device
misbehave is GET_STATUS request. Issuing it with piece of libusb code
caused exactly the same type of hang up - device responds to all
control requests but interrupt requests return -EPIPE.

Is it even possible for device to have buggy implementation of such a
basic request? Truth be said I failed to force Windows to use it...

Can you suggest any procedure which may bring the device back to life?
Reloading usbhid does not help, reloading whole USB (*hci_hcd) does. I
tried setting configuration and playing with (boot) protocol but it
doesn't help either.

-Jakub



# lsusb -v -d"05d5:8001"

Bus 004 Device 005: ID 05d5:8001 Super Gate Technology Co., Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x05d5 Super Gate Technology Co., Ltd
  idProduct          0x8001 
  bcdDevice            1.00
  iManufacturer           1 KYE 4D device
  iProduct                2 Ergomedia
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          2 Ergomedia
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
          wDescriptorLength      65
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
        bInterval              10
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
          wDescriptorLength      50
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
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0xffff
  Self Powered
  Remote Wakeup Enabled
  Test Mode
  Debug Mode
