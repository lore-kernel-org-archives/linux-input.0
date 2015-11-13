From: "Simon Wood" <simon@mungewell.org>
Subject: Valve's "Steam Controller" behaves strangely
Date: Thu, 12 Nov 2015 18:36:39 -0700
Message-ID: <79797ec91738aa02460ded220f5059ad.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20151112183639_50437"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:38222 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbbKMBgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2015 20:36:38 -0500
Received: from [::1] (port=46802 helo=mungewell.org)
	by host18.canaca.com with esmtpa (Exim 4.86)
	(envelope-from <simon@mungewell.org>)
	id 1Zx3I7-0003TK-OM
	for linux-input@vger.kernel.org; Thu, 12 Nov 2015 20:36:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

------=_20151112183639_50437
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Just a heads up to anyone who wants to play with these on Linux. They do
NOT behave as a normal gamepad, they don't present a JS0 interface and the
events are a little wonky.

They do present the axis/buttons data in the 'hidraw' stream, so there is
some hope that we can support them. If anyone wants to collaborate, drop
me a note.
--
# hexdump -v -e '64/1 "%02x " "\n"' < /dev/hidraw1
01 00 01 3c 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
47 a7 c2 bc fa 9f 13 54 80 0a f6 df e5 3f
01 00 01 3c 23 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
47 a7 c2 bc fa 9f 13 54 80 0a f6 df e5 3f
--

Attached are some quick notes from 15mins playing with the device.
Cheers,
Simon.
------=_20151112183639_50437
Content-Type: text/plain; name="steam_controller_notes.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="steam_controller_notes.txt"


Wireless Dongle Insert
--
Nov 12 17:47:17 retrobox kernel: [ 2016.564082] usb 2-2: new full-speed USB device number 2 using uhci_hcd
Nov 12 17:47:17 retrobox kernel: [ 2016.733096] usb 2-2: New USB device found, idVendor=28de, idProduct=1142
Nov 12 17:47:17 retrobox kernel: [ 2016.733108] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 12 17:47:17 retrobox kernel: [ 2016.733114] usb 2-2: Product: Steam Controller
Nov 12 17:47:17 retrobox kernel: [ 2016.733121] usb 2-2: Manufacturer: Valve Software
Nov 12 17:47:18 retrobox mtp-probe: checking bus 2, device 2: "/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-2"
Nov 12 17:47:18 retrobox mtp-probe: bus: 2, device: 2 was not an MTP device
Nov 12 17:47:19 retrobox kernel: [ 2018.234725] hidraw: raw HID events driver (C) Jiri Kosina
Nov 12 17:47:19 retrobox kernel: [ 2018.374556] usbcore: registered new interface driver usbhid
Nov 12 17:47:19 retrobox kernel: [ 2018.374562] usbhid: USB HID core driver
Nov 12 17:47:19 retrobox kernel: [ 2018.499064] input: Valve Software Steam Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:28DE:1142.0001/input/input9
Nov 12 17:47:19 retrobox kernel: [ 2018.552665] hid-generic 0003:28DE:1142.0001: input,hidraw0: USB HID v1.11 Keyboard [Valve Software Steam Controller] on usb-0000:00:1d.0-2/input0
Nov 12 17:47:19 retrobox kernel: [ 2018.556660] hid-generic 0003:28DE:1142.0002: hiddev0,hidraw1: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:00:1d.0-2/input1
Nov 12 17:47:19 retrobox kernel: [ 2018.560451] hid-generic 0003:28DE:1142.0003: hiddev0,hidraw2: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:00:1d.0-2/input2
Nov 12 17:47:19 retrobox kernel: [ 2018.563159] hid-generic 0003:28DE:1142.0004: hiddev0,hidraw3: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:00:1d.0-2/input3
Nov 12 17:47:19 retrobox kernel: [ 2018.566189] hid-generic 0003:28DE:1142.0005: hiddev0,hidraw4: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:00:1d.0-2/input4
--

No events delivered, unless something is consuming hidraw (ie hexdump below).
--
root@retrobox:/home/simon# evtest  /dev/input/event8
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x28de product 0x1142 version 0x111
Input device name: "Valve Software Steam Controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
    Event code 15 (KEY_TAB)
    Event code 16 (KEY_Q)
    Event code 17 (KEY_W)
    Event code 18 (KEY_E)
    Event code 19 (KEY_R)
    Event code 20 (KEY_T)
    Event code 21 (KEY_Y)
    Event code 22 (KEY_U)
    Event code 23 (KEY_I)
    Event code 24 (KEY_O)
    Event code 25 (KEY_P)
    Event code 26 (KEY_LEFTBRACE)
    Event code 27 (KEY_RIGHTBRACE)
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    Event code 30 (KEY_A)
    Event code 31 (KEY_S)
    Event code 32 (KEY_D)
    Event code 33 (KEY_F)
    Event code 34 (KEY_G)
    Event code 35 (KEY_H)
    Event code 36 (KEY_J)
    Event code 37 (KEY_K)
    Event code 38 (KEY_L)
    Event code 39 (KEY_SEMICOLON)
    Event code 40 (KEY_APOSTROPHE)
    Event code 41 (KEY_GRAVE)
    Event code 42 (KEY_LEFTSHIFT)
    Event code 43 (KEY_BACKSLASH)
    Event code 44 (KEY_Z)
    Event code 45 (KEY_X)
    Event code 46 (KEY_C)
    Event code 47 (KEY_V)
    Event code 48 (KEY_B)
    Event code 49 (KEY_N)
    Event code 50 (KEY_M)
    Event code 51 (KEY_COMMA)
    Event code 52 (KEY_DOT)
    Event code 53 (KEY_SLASH)
    Event code 54 (KEY_RIGHTSHIFT)
    Event code 55 (KEY_KPASTERISK)
    Event code 56 (KEY_LEFTALT)
    Event code 57 (KEY_SPACE)
    Event code 58 (KEY_CAPSLOCK)
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 63 (KEY_F5)
    Event code 64 (KEY_F6)
    Event code 65 (KEY_F7)
    Event code 66 (KEY_F8)
    Event code 67 (KEY_F9)
    Event code 68 (KEY_F10)
    Event code 69 (KEY_NUMLOCK)
    Event code 70 (KEY_SCROLLLOCK)
    Event code 71 (KEY_KP7)
    Event code 72 (KEY_KP8)
    Event code 73 (KEY_KP9)
    Event code 74 (KEY_KPMINUS)
    Event code 75 (KEY_KP4)
    Event code 76 (KEY_KP5)
    Event code 77 (KEY_KP6)
    Event code 78 (KEY_KPPLUS)
    Event code 79 (KEY_KP1)
    Event code 80 (KEY_KP2)
    Event code 81 (KEY_KP3)
    Event code 82 (KEY_KP0)
    Event code 83 (KEY_KPDOT)
    Event code 86 (KEY_102ND)
    Event code 87 (KEY_F11)
    Event code 88 (KEY_F12)
    Event code 96 (KEY_KPENTER)
    Event code 97 (KEY_RIGHTCTRL)
    Event code 98 (KEY_KPSLASH)
    Event code 99 (KEY_SYSRQ)
    Event code 100 (KEY_RIGHTALT)
    Event code 102 (KEY_HOME)
    Event code 103 (KEY_UP)
    Event code 104 (KEY_PAGEUP)
    Event code 105 (KEY_LEFT)
    Event code 106 (KEY_RIGHT)
    Event code 107 (KEY_END)
    Event code 108 (KEY_DOWN)
    Event code 109 (KEY_PAGEDOWN)
    Event code 110 (KEY_INSERT)
    Event code 111 (KEY_DELETE)
    Event code 119 (KEY_PAUSE)
    Event code 125 (KEY_LEFTMETA)
    Event code 126 (KEY_RIGHTMETA)
    Event code 127 (KEY_COMPOSE)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 8 (REL_WHEEL)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML)
    Event code 1 (LED_CAPSL)
    Event code 2 (LED_SCROLLL)
    Event code 3 (LED_COMPOSE)
    Event code 4 (LED_KANA)
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
Properties:
Testing ... (interrupt to exit)
^C
--


Multiple HID raw devices are created with dongle, controller appears on first with 64byte frames
--
root@retrobox:/home/simon# hexdump -v -e '64/1 "%02x " "\n"' < /dev/hidraw1
01 00 01 3c cc 0c 00 00 00 00 00 00 00 00 00 00 9b f3 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 00 01 3c cd 0c 00 00 00 00 00 00 00 00 00 00 9b f3 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 00 01 3c ce 0c 00 00 00 00 00 00 00 00 00 00 9b f3 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 00 01 3c cf 0c 00 00 00 00 00 00 00 00 00 00 9b f3 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
--

Report Descriptor
--
root@retrobox:/sys/bus/hid/devices/0003:28DE:1142.0001# hexdump -C report_descriptor 
00000000  05 01 09 06 95 01 a1 01  85 01 05 07 19 e0 29 e7  |..............).|
00000010  15 00 25 01 75 01 95 08  81 02 95 01 75 08 81 01  |..%.u.......u...|
00000020  95 05 75 01 05 08 19 01  29 05 91 02 95 01 75 03  |..u.....).....u.|
00000030  91 01 95 06 75 08 15 00  25 65 05 07 19 00 29 65  |....u...%e....)e|
00000040  81 00 c0 05 01 09 02 a1  01 85 02 09 01 a1 00 05  |................|
00000050  09 19 01 29 05 15 00 25  01 95 05 75 01 81 02 95  |...)...%...u....|
00000060  01 75 03 81 01 05 01 09  30 09 31 09 38 15 81 25  |.u......0.1.8..%|
00000070  7f 75 08 95 03 81 06 c0  c0                       |.u.......|
00000079
--
root@retrobox:/sys/bus/hid/devices/0003:28DE:1142.0001# hidrd-convert -o code report_descriptor 
0x05, 0x01, /*  Usage Page (Desktop),               */
0x09, 0x06, /*  Usage (Keyboard),                   */
0x95, 0x01, /*  Report Count (1),                   */
0xA1, 0x01, /*  Collection (Application),           */
0x85, 0x01, /*      Report ID (1),                  */
0x05, 0x07, /*      Usage Page (Keyboard),          */
0x19, 0xE0, /*      Usage Minimum (KB Leftcontrol), */
0x29, 0xE7, /*      Usage Maximum (KB Right GUI),   */
0x15, 0x00, /*      Logical Minimum (0),            */
0x25, 0x01, /*      Logical Maximum (1),            */
0x75, 0x01, /*      Report Size (1),                */
0x95, 0x08, /*      Report Count (8),               */
0x81, 0x02, /*      Input (Variable),               */
0x95, 0x01, /*      Report Count (1),               */
0x75, 0x08, /*      Report Size (8),                */
0x81, 0x01, /*      Input (Constant),               */
0x95, 0x05, /*      Report Count (5),               */
0x75, 0x01, /*      Report Size (1),                */
0x05, 0x08, /*      Usage Page (LED),               */
0x19, 0x01, /*      Usage Minimum (01h),            */
0x29, 0x05, /*      Usage Maximum (05h),            */
0x91, 0x02, /*      Output (Variable),              */
0x95, 0x01, /*      Report Count (1),               */
0x75, 0x03, /*      Report Size (3),                */
0x91, 0x01, /*      Output (Constant),              */
0x95, 0x06, /*      Report Count (6),               */
0x75, 0x08, /*      Report Size (8),                */
0x15, 0x00, /*      Logical Minimum (0),            */
0x25, 0x65, /*      Logical Maximum (101),          */
0x05, 0x07, /*      Usage Page (Keyboard),          */
0x19, 0x00, /*      Usage Minimum (None),           */
0x29, 0x65, /*      Usage Maximum (KB Application), */
0x81, 0x00, /*      Input,                          */
0xC0,       /*  End Collection,                     */
0x05, 0x01, /*  Usage Page (Desktop),               */
0x09, 0x02, /*  Usage (Mouse),                      */
0xA1, 0x01, /*  Collection (Application),           */
0x85, 0x02, /*      Report ID (2),                  */
0x09, 0x01, /*      Usage (Pointer),                */
0xA1, 0x00, /*      Collection (Physical),          */
0x05, 0x09, /*          Usage Page (Button),        */
0x19, 0x01, /*          Usage Minimum (01h),        */
0x29, 0x05, /*          Usage Maximum (05h),        */
0x15, 0x00, /*          Logical Minimum (0),        */
0x25, 0x01, /*          Logical Maximum (1),        */
0x95, 0x05, /*          Report Count (5),           */
0x75, 0x01, /*          Report Size (1),            */
0x81, 0x02, /*          Input (Variable),           */
0x95, 0x01, /*          Report Count (1),           */
0x75, 0x03, /*          Report Size (3),            */
0x81, 0x01, /*          Input (Constant),           */
0x05, 0x01, /*          Usage Page (Desktop),       */
0x09, 0x30, /*          Usage (X),                  */
0x09, 0x31, /*          Usage (Y),                  */
0x09, 0x38, /*          Usage (Wheel),              */
0x15, 0x81, /*          Logical Minimum (-127),     */
0x25, 0x7F, /*          Logical Maximum (127),      */
0x75, 0x08, /*          Report Size (8),            */
0x95, 0x03, /*          Report Count (3),           */
0x81, 0x06, /*          Input (Variable, Relative), */
0xC0,       /*      End Collection,                 */
0xC0        /*  End Collection                      */
--


lsusb -vv
--
Bus 002 Device 002: ID 28de:1142  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x28de 
  idProduct          0x1142 
  bcdDevice            0.01
  iManufacturer           1 Valve Software
  iProduct                2 Steam Controller
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          134
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0 
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
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     121
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
        wMaxPacketSize     0x0009  1x 9 bytes
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
          wDescriptorLength      33
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
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
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
          wDescriptorLength      33
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
          wDescriptorLength      33
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
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
          wDescriptorLength      33
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
Device Status:     0x0000
  (Bus Powered)
--


USB connected.
--
Nov 12 18:05:17 retrobox kernel: [ 3096.556082] usb 2-1: new full-speed USB device number 3 using uhci_hcd
Nov 12 18:05:17 retrobox kernel: [ 3096.722122] usb 2-1: New USB device found, idVendor=28de, idProduct=1102
Nov 12 18:05:17 retrobox kernel: [ 3096.722134] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 12 18:05:17 retrobox kernel: [ 3096.722140] usb 2-1: Product: Wired Controller
Nov 12 18:05:17 retrobox kernel: [ 3096.722147] usb 2-1: Manufacturer: Valve Software
Nov 12 18:05:17 retrobox kernel: [ 3096.732326] input: Valve Software Wired Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:28DE:1102.0006/input/input10
Nov 12 18:05:17 retrobox kernel: [ 3096.788470] hid-generic 0003:28DE:1102.0006: input,hidraw0: USB HID v1.11 Keyboard [Valve Software Wired Controller] on usb-0000:00:1d.0-1/input0
Nov 12 18:05:17 retrobox kernel: [ 3096.797309] input: Valve Software Wired Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.1/0003:28DE:1102.0007/input/input11
Nov 12 18:05:17 retrobox kernel: [ 3096.797854] hid-generic 0003:28DE:1102.0007: input,hidraw1: USB HID v1.11 Mouse [Valve Software Wired Controller] on usb-0000:00:1d.0-1/input1
Nov 12 18:05:17 retrobox kernel: [ 3096.807547] hid-generic 0003:28DE:1102.0008: hiddev0,hidraw2: USB HID v1.11 Device [Valve Software Wired Controller] on usb-0000:00:1d.0-1/input2
Nov 12 18:05:17 retrobox mtp-probe: checking bus 2, device 3: "/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1"
Nov 12 18:05:17 retrobox mtp-probe: bus: 2, device: 3 was not an MTP device
--

--
root@retrobox:~# evtest /dev/input/event8
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x28de product 0x1102 version 0x111
Input device name: "Valve Software Wired Controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
    Event code 15 (KEY_TAB)
    Event code 16 (KEY_Q)
    Event code 17 (KEY_W)
    Event code 18 (KEY_E)
    Event code 19 (KEY_R)
    Event code 20 (KEY_T)
    Event code 21 (KEY_Y)
    Event code 22 (KEY_U)
    Event code 23 (KEY_I)
    Event code 24 (KEY_O)
    Event code 25 (KEY_P)
    Event code 26 (KEY_LEFTBRACE)
    Event code 27 (KEY_RIGHTBRACE)
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    Event code 30 (KEY_A)
    Event code 31 (KEY_S)
    Event code 32 (KEY_D)
    Event code 33 (KEY_F)
    Event code 34 (KEY_G)
    Event code 35 (KEY_H)
    Event code 36 (KEY_J)
    Event code 37 (KEY_K)
    Event code 38 (KEY_L)
    Event code 39 (KEY_SEMICOLON)
    Event code 40 (KEY_APOSTROPHE)
    Event code 41 (KEY_GRAVE)
    Event code 42 (KEY_LEFTSHIFT)
    Event code 43 (KEY_BACKSLASH)
    Event code 44 (KEY_Z)
    Event code 45 (KEY_X)
    Event code 46 (KEY_C)
    Event code 47 (KEY_V)
    Event code 48 (KEY_B)
    Event code 49 (KEY_N)
    Event code 50 (KEY_M)
    Event code 51 (KEY_COMMA)
    Event code 52 (KEY_DOT)
    Event code 53 (KEY_SLASH)
    Event code 54 (KEY_RIGHTSHIFT)
    Event code 55 (KEY_KPASTERISK)
    Event code 56 (KEY_LEFTALT)
    Event code 57 (KEY_SPACE)
    Event code 58 (KEY_CAPSLOCK)
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 63 (KEY_F5)
    Event code 64 (KEY_F6)
    Event code 65 (KEY_F7)
    Event code 66 (KEY_F8)
    Event code 67 (KEY_F9)
    Event code 68 (KEY_F10)
    Event code 69 (KEY_NUMLOCK)
    Event code 70 (KEY_SCROLLLOCK)
    Event code 71 (KEY_KP7)
    Event code 72 (KEY_KP8)
    Event code 73 (KEY_KP9)
    Event code 74 (KEY_KPMINUS)
    Event code 75 (KEY_KP4)
    Event code 76 (KEY_KP5)
    Event code 77 (KEY_KP6)
    Event code 78 (KEY_KPPLUS)
    Event code 79 (KEY_KP1)
    Event code 80 (KEY_KP2)
    Event code 81 (KEY_KP3)
    Event code 82 (KEY_KP0)
    Event code 83 (KEY_KPDOT)
    Event code 86 (KEY_102ND)
    Event code 87 (KEY_F11)
    Event code 88 (KEY_F12)
    Event code 96 (KEY_KPENTER)
    Event code 97 (KEY_RIGHTCTRL)
    Event code 98 (KEY_KPSLASH)
    Event code 99 (KEY_SYSRQ)
    Event code 100 (KEY_RIGHTALT)
    Event code 102 (KEY_HOME)
    Event code 103 (KEY_UP)
    Event code 104 (KEY_PAGEUP)
    Event code 105 (KEY_LEFT)
    Event code 106 (KEY_RIGHT)
    Event code 107 (KEY_END)
    Event code 108 (KEY_DOWN)
    Event code 109 (KEY_PAGEDOWN)
    Event code 110 (KEY_INSERT)
    Event code 111 (KEY_DELETE)
    Event code 119 (KEY_PAUSE)
    Event code 125 (KEY_LEFTMETA)
    Event code 126 (KEY_RIGHTMETA)
    Event code 127 (KEY_COMPOSE)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML)
    Event code 1 (LED_CAPSL)
    Event code 2 (LED_SCROLLL)
    Event code 3 (LED_COMPOSE)
    Event code 4 (LED_KANA)
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
Properties:
--
root@retrobox:~# jstest /dev/input/
by-id/   event0   event2   event4   event6   event8   mice     mouse1   
by-path/ event1   event3   event5   event7   event9   mouse0   mouse2   
root@retrobox:~# evtest /dev/input/event9
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x28de product 0x1102 version 0x111
Input device name: "Valve Software Wired Controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 8 (REL_WHEEL)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
Properties:
Testing ... (interrupt to exit)
^[Event: time 1447376851.445046, type 2 (EV_REL), code 1 (REL_Y), value -1
Event: time 1447376851.445046, -------------- EV_SYN ------------
Event: time 1447376851.453048, type 2 (EV_REL), code 1 (REL_Y), value -2
--

Different frame size on USB connection
--
# hexdump -v -e '4/1 "%02x " "\n"' < /dev/hidraw1
# hexdump -v -e '64/1 "%02x " "\n"' < /dev/hidraw2
--

root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0006# hexdump -C report_descriptor 
00000000  05 01 09 06 95 01 a1 01  05 07 19 e0 29 e7 15 00  |............)...|
00000010  25 01 75 01 95 08 81 02  95 01 75 08 81 01 95 05  |%.u.......u.....|
00000020  75 01 05 08 19 01 29 05  91 02 95 01 75 03 91 01  |u.....).....u...|
00000030  95 06 75 08 15 00 25 65  05 07 19 00 29 65 81 00  |..u...%e....)e..|
00000040  c0                                                |.|
00000041
--
root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0006# hidrd-convert -o code report_descriptor 
0x05, 0x01, /*  Usage Page (Desktop),               */
0x09, 0x06, /*  Usage (Keyboard),                   */
0x95, 0x01, /*  Report Count (1),                   */
0xA1, 0x01, /*  Collection (Application),           */
0x05, 0x07, /*      Usage Page (Keyboard),          */
0x19, 0xE0, /*      Usage Minimum (KB Leftcontrol), */
0x29, 0xE7, /*      Usage Maximum (KB Right GUI),   */
0x15, 0x00, /*      Logical Minimum (0),            */
0x25, 0x01, /*      Logical Maximum (1),            */
0x75, 0x01, /*      Report Size (1),                */
0x95, 0x08, /*      Report Count (8),               */
0x81, 0x02, /*      Input (Variable),               */
0x95, 0x01, /*      Report Count (1),               */
0x75, 0x08, /*      Report Size (8),                */
0x81, 0x01, /*      Input (Constant),               */
0x95, 0x05, /*      Report Count (5),               */
0x75, 0x01, /*      Report Size (1),                */
0x05, 0x08, /*      Usage Page (LED),               */
0x19, 0x01, /*      Usage Minimum (01h),            */
0x29, 0x05, /*      Usage Maximum (05h),            */
0x91, 0x02, /*      Output (Variable),              */
0x95, 0x01, /*      Report Count (1),               */
0x75, 0x03, /*      Report Size (3),                */
0x91, 0x01, /*      Output (Constant),              */
0x95, 0x06, /*      Report Count (6),               */
0x75, 0x08, /*      Report Size (8),                */
0x15, 0x00, /*      Logical Minimum (0),            */
0x25, 0x65, /*      Logical Maximum (101),          */
0x05, 0x07, /*      Usage Page (Keyboard),          */
0x19, 0x00, /*      Usage Minimum (None),           */
0x29, 0x65, /*      Usage Maximum (KB Application), */
0x81, 0x00, /*      Input,                          */
0xC0        /*  End Collection                      */
--

root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0007# hexdump -C report_descriptor 
00000000  05 01 09 02 a1 01 09 01  a1 00 05 09 19 01 29 05  |..............).|
00000010  15 00 25 01 95 05 75 01  81 02 95 01 75 03 81 01  |..%...u.....u...|
00000020  05 01 09 30 09 31 09 38  15 81 25 7f 75 08 95 03  |...0.1.8..%.u...|
00000030  81 06 c0 c0                                       |....|
00000034
--
root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0007# hidrd-convert -o code report_descriptor 
0x05, 0x01, /*  Usage Page (Desktop),               */
0x09, 0x02, /*  Usage (Mouse),                      */
0xA1, 0x01, /*  Collection (Application),           */
0x09, 0x01, /*      Usage (Pointer),                */
0xA1, 0x00, /*      Collection (Physical),          */
0x05, 0x09, /*          Usage Page (Button),        */
0x19, 0x01, /*          Usage Minimum (01h),        */
0x29, 0x05, /*          Usage Maximum (05h),        */
0x15, 0x00, /*          Logical Minimum (0),        */
0x25, 0x01, /*          Logical Maximum (1),        */
0x95, 0x05, /*          Report Count (5),           */
0x75, 0x01, /*          Report Size (1),            */
0x81, 0x02, /*          Input (Variable),           */
0x95, 0x01, /*          Report Count (1),           */
0x75, 0x03, /*          Report Size (3),            */
0x81, 0x01, /*          Input (Constant),           */
0x05, 0x01, /*          Usage Page (Desktop),       */
0x09, 0x30, /*          Usage (X),                  */
0x09, 0x31, /*          Usage (Y),                  */
0x09, 0x38, /*          Usage (Wheel),              */
0x15, 0x81, /*          Logical Minimum (-127),     */
0x25, 0x7F, /*          Logical Maximum (127),      */
0x75, 0x08, /*          Report Size (8),            */
0x95, 0x03, /*          Report Count (3),           */
0x81, 0x06, /*          Input (Variable, Relative), */
0xC0,       /*      End Collection,                 */
0xC0        /*  End Collection                      */
--

root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0008# hexdump -C report_descriptor 
00000000  06 00 ff 09 01 a1 01 15  00 26 ff 00 75 08 95 40  |.........&..u..@|
00000010  09 01 81 02 95 40 09 01  91 02 95 40 09 01 b1 02  |.....@.....@....|
00000020  c0                                                |.|
00000021
root@retrobox:/sys/bus/hid/devices/0003:28DE:1102.0008# hidrd-convert -o code report_descriptor 
0x06, 0x00, 0xFF,   /*  Usage Page (FF00h),         */
0x09, 0x01,         /*  Usage (01h),                */
0xA1, 0x01,         /*  Collection (Application),   */
0x15, 0x00,         /*      Logical Minimum (0),    */
0x26, 0xFF, 0x00,   /*      Logical Maximum (255),  */
0x75, 0x08,         /*      Report Size (8),        */
0x95, 0x40,         /*      Report Count (64),      */
0x09, 0x01,         /*      Usage (01h),            */
0x81, 0x02,         /*      Input (Variable),       */
0x95, 0x40,         /*      Report Count (64),      */
0x09, 0x01,         /*      Usage (01h),            */
0x91, 0x02,         /*      Output (Variable),      */
0x95, 0x40,         /*      Report Count (64),      */
0x09, 0x01,         /*      Usage (01h),            */
0xB1, 0x02,         /*      Feature (Variable),     */
0xC0                /*  End Collection              */

lsusb -vv
--
Bus 002 Device 003: ID 28de:1102  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x28de 
  idProduct          0x1102 
  bcdDevice            1.00
  iManufacturer           1 Valve Software
  iProduct                2 Wired Controller
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           84
    bNumInterfaces          3
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
      iInterface              3 Keyboard
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
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
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              4 Mouse
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      52
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
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               6
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              5 Valve
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      33
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               6
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled
--
------=_20151112183639_50437--


