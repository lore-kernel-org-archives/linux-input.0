From: Steffen Barszus <steffenbpunkt@googlemail.com>
Subject: gyration remote - europe/QWERTZ version (GYAR3101CKDE)
Date: Mon, 9 Aug 2010 08:39:12 +0200
Message-ID: <20100809083912.00910e94@grobi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36071 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0HIGj3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Aug 2010 02:39:29 -0400
Received: by wyb39 with SMTP id 39so9571763wyb.19
        for <linux-input@vger.kernel.org>; Sun, 08 Aug 2010 23:39:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi !

I have the european/german version of the gyration remote. The main
difference is that the keyboard is QWERTZ and the remote has a bit
different layout (4 Teletext color keys and a key to enable the
teletext, but no "My Media" Keys which i suppose are there on the US
version). 

The 5 Keys i could get working by adding them like that:

diff -Nru linux-2.6.32.y-d4e0f47/hid-gyration.c
linux-2.6.32.y-d4e0f47.new/hid-gyration.c ---
linux-2.6.32.y-d4e0f47/hid-gyration.c	2010-07-16
12:26:28.000000000 +0200 +++
linux-2.6.32.y-d4e0f47.new/hid-gyration.c	2010-07-16
12:39:24.154398189 +0200 @@ -43,6 +43,11 @@ case 0x048:
gy_map_key_clear(KEY_MEDIA);	break; case 0x049:
gy_map_key_clear(KEY_CAMERA);	break; case 0x04a:
gy_map_key_clear(KEY_VIDEO);	break;
+	case 0x05a: gy_map_key_clear(KEY_TEXT);		break;
+	case 0x05b: gy_map_key_clear(KEY_RED);		break;
+	case 0x05c: gy_map_key_clear(KEY_GREEN);	break;
+	case 0x05d: gy_map_key_clear(KEY_YELLOW);	break;
+	case 0x05e: gy_map_key_clear(KEY_BLUE);		break;
 
 	default:
 		return 0;


Please note, that i'm by no means a driver developer, and this is done
by copy&paste. Please let me know if i should verify something. Please
add the missing keys to the driver. 

lsusb -vv Output of the device:

Bus 003 Device 002: ID 0c16:0002 Gyration, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0c16 Gyration, Inc.
  idProduct          0x0002
  bcdDevice            2.20
  iManufacturer           1 Gyration
  iProduct                2 Gyration RF Technology Receiver
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 USB Receiver
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               98mA
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
          wDescriptorLength     149
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
          bcdHID               1.20
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     154
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
Device Status:     0x0000
  (Bus Powered)

