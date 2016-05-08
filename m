From: Jose Rodriguez <joerdz@gmail.com>
Subject: BUGZILLA[117791] Mayflash Wii Classic Controller Adapter For Pc -
 Nonuser initiated Input
Date: Sat, 7 May 2016 23:13:03 -0500
Message-ID: <CAMAnQ3bbhtLwOi_5S0cikmaMPO0oO7a0nND5YLuPSBWT0HtfeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34258 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcEHENY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2016 00:13:24 -0400
Received: by mail-ob0-f178.google.com with SMTP id dm5so69316212obc.1
        for <linux-input@vger.kernel.org>; Sat, 07 May 2016 21:13:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

             Bug ID: 117791
            Summary: Mayflash Wii Classic Controller Adapter For Pc - Non
                     user initiated Input
            Product: Drivers
            Version: 2.5
     Kernel Version: 4.5.0
https://bugzilla.kernel.org/show_bug.cgi?id=117791


I am using the following device:
http://www.amazon.com/Mayflash-Wii-Classic-Controller-Adapter/dp/B0089O4EB0/

It is a Mayflash Wii Classic Controller Adapter For PC. I am usually
Official PDP Fight Pads.

May  7 15:41:40 morpheous kernel: [ 7521.608869] input: SZMy-power LTD
CO.  Dual Box WII as
/devices/pci0000:00/0000:00:1a.1/usb2/2-1/2-1:1.1/0003:1D79:0301.000B/input/input18
May  7 15:41:40 morpheous kernel: [ 7521.610466] hid-generic
0003:1D79:0301.000B: input,hidraw1: USB HID v1.10 Joystick [SZMy-power
LTD CO.  Dual Box WII] on usb-0000:00:1a.1-1/input1
May  7 15:41:40 morpheous kernel: [ 7521.613308] input: SZMy-power LTD
CO.  Dual Box WII as
/devices/pci0000:00/0000:00:1a.1/usb2/2-1/2-1:1.0/0003:1D79:0301.000C/input/input19
May  7 15:41:40 morpheous kernel: [ 7521.613664] hid-generic
0003:1D79:0301.000C: input,hidraw2: USB HID v1.10 Joystick [SZMy-power
LTD CO.  Dual Box WII] on usb-0000:00:1a.1-1/input0
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II)
config/udev: Adding input device SZMy-power LTD CO.  Dual Box WII
(/dev/input/js0)
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) No
input driver specified, ignoring this device.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) This
device may have been added with another device file.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II)
config/udev: Adding input device SZMy-power LTD CO.  Dual Box WII
(/dev/input/js1)
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) No
input driver specified, ignoring this device.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) This
device may have been added with another device file.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II)
config/udev: Adding input device SZMy-power LTD CO.  Dual Box WII
(/dev/input/event2)
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) No
input driver specified, ignoring this device.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II) This
device may have been added with another device file.
May  7 15:41:40 morpheous /usr/lib/gdm3/gdm-x-session[1312]: (II)
config/udev: Adding input device Logitech USB-PS/2 Optical Mouse
(/dev/input/event1)

This is the output of evtest:

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x1d79 product 0x301 version 0x110
Input device name: "SZMy-power LTD CO.  Dual Box WII"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 288 (BTN_TRIGGER)
    Event code 289 (BTN_THUMB)
    Event code 290 (BTN_THUMB2)
    Event code 291 (BTN_TOP)
    Event code 292 (BTN_TOP2)
    Event code 293 (BTN_PINKIE)
    Event code 294 (BTN_BASE)
    Event code 295 (BTN_BASE2)
    Event code 296 (BTN_BASE3)
    Event code 297 (BTN_BASE4)
    Event code 298 (BTN_BASE5)
    Event code 299 (BTN_BASE6)
    Event code 300 (?)
    Event code 301 (?)
    Event code 302 (?)
    Event code 303 (BTN_DEAD)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value    122
      Min        0
      Max      255
      Flat      15
    Event code 1 (ABS_Y)
      Value    127
      Min        0
      Max      255
      Flat      15
    Event code 2 (ABS_Z)
      Value    128
      Min        0
      Max      255
      Flat      15
    Event code 5 (ABS_RZ)
      Value    127
      Min        0
      Max      255
      Flat      15
    Event code 16 (ABS_HAT0X)
      Value      0
      Min       -1
      Max        1
    Event code 17 (ABS_HAT0Y)
      Value      0
      Min       -1
      Max        1
    Event code 40 (ABS_MISC)
      Value      0
      Min        0
      Max      255
      Flat      15
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)

If only one one controller is read with evtest, there are no issues;
however, if both event devices are opened at the same time, the
following events are registered every 119 seconds. Events may vary
slightly but it is always the same keys/axis and usually in the same
order:

First device (/dev/input/by-id/usb-SZMy-power_LTD_CO._Dual_Box_WII-event-joystick)
vent: time 1462659514.036389, type 3 (EV_ABS), code 2 (ABS_Z), value 140
Event: time 1462659514.036389, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659514.036389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.036389, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659514.036389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.036389, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659514.036389, -------------- SYN_REPORT ------------
Event: time 1462659514.044387, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659514.044387, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659514.044387, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659514.044387, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.044387, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659514.044387, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.044387, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659514.044387, -------------- SYN_REPORT ------------
Event: time 1462659514.052390, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659514.052390, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659514.052390, -------------- SYN_REPORT ------------
Event: time 1462659514.060388, type 3 (EV_ABS), code 2 (ABS_Z), value 140
Event: time 1462659514.060388, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659514.060388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.060388, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659514.060388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.060388, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659514.060388, -------------- SYN_REPORT ------------
Event: time 1462659514.068389, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659514.068389, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659514.068389, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659514.068389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.068389, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659514.068389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.068389, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659514.068389, -------------- SYN_REPORT ------------
Event: time 1462659514.076396, type 3 (EV_ABS), code 2 (ABS_Z), value 140
Event: time 1462659514.076396, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659514.076396, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659514.076396, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.076396, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659514.076396, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.076396, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659514.076396, -------------- SYN_REPORT ------------
Event: time 1462659514.084389, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659514.084389, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659514.084389, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659514.084389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.084389, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659514.084389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.084389, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659514.084389, -------------- SYN_REPORT ------------
Event: time 1462659514.092389, type 3 (EV_ABS), code 2 (ABS_Z), value 140
Event: time 1462659514.092389, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659514.092389, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659514.092389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.092389, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659514.092389, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.092389, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659514.092389, -------------- SYN_REPORT ------------
Event: time 1462659514.100390, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659514.100390, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659514.100390, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659514.100390, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.100390, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659514.100390, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.100390, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659514.100390, -------------- SYN_REPORT ------------
Event: time 1462659514.108388, type 3 (EV_ABS), code 2 (ABS_Z), value 140
Event: time 1462659514.108388, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659514.108388, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659514.108388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.108388, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659514.108388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.108388, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659514.108388, -------------- SYN_REPORT ------------
Event: time 1462659514.116388, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659514.116388, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659514.116388, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659514.116388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659514.116388, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659514.116388, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659514.116388, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659514.116388, -------------- SYN_REPORT ------------
Event: time 1462659514.124387, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659514.124387, type 3
(EV_/dev/input/by-id/usb-SZMy-power_LTD_CO._Dual_Box_WII-event-joystickABS),
code 0 (ABS_X), value 122
Event: time 1462659514.124387, -------------- SYN_REPORT ------------
Event: time 1462659515.100395, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.100395, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659515.100395, -------------- SYN_REPORT ------------
Event: time 1462659515.108395, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659515.108395, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659515.108395, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.108395, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659515.108395, -------------- SYN_REPORT ------------
Event: time 1462659515.116394, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659515.116394, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659515.116394, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.116394, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659515.116394, -------------- SYN_REPORT ------------
Event: time 1462659515.124394, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659515.124394, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659515.124394, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.124394, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659515.124394, -------------- SYN_REPORT ------------
Event: time 1462659515.132394, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659515.132394, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659515.132394, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.132394, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659515.132394, -------------- SYN_REPORT ------------
Event: time 1462659515.140393, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659515.140393, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659515.140393, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659515.140393, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659515.140393, -------------- SYN_REPORT ------------
Event: time 1462659515.148393, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659515.148393, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659515.148393, -------------- SYN_REPORT ------------
Event: time 1462659516.092410, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659516.092410, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659516.092410, -------------- SYN_REPORT ------------
Event: time 1462659516.100406, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659516.100406, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659516.100406, -------------- SYN_REPORT ------------
Event: time 1462659516.116401, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659516.116401, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659516.116401, -------------- SYN_REPORT ------------
Event: time 1462659516.124414, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659516.124414, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659516.124414, -------------- SYN_REPORT ------------
Event: time 1462659516.132398, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659516.132398, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659516.132398, -------------- SYN_REPORT ------------
Event: time 1462659516.140417, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659516.140417, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659516.140417, -------------- SYN_REPORT ------------
Event: time 1462659517.116404, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659517.116404, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659517.116404, -------------- SYN_REPORT ------------
Event: time 1462659517.124403, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659517.124403, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659517.124403, -------------- SYN_REPORT ------------
Event: time 1462659517.132405, type 3 (EV_ABS), code 2 (ABS_Z), value 116
Event: time 1462659517.132405, type 3 (EV_ABS), code 0 (ABS_X), value 128
Event: time 1462659517.132405, -------------- SYN_REPORT ------------
Event: time 1462659517.140406, type 3 (EV_ABS), code 2 (ABS_Z), value 128
Event: time 1462659517.140406, type 3 (EV_ABS), code 0 (ABS_X), value 122
Event: time 1462659517.140406, -------------- SYN_REPORT ------------


Second Device (dev/input/by-id/usb-SZMy-power_LTD_CO._Dual_Box_WIIf01-event-joystick)
Event: time 1462659768.845655, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659768.845655, type 3 (EV_ABS), code 1 (ABS_Y), value 0
Event: time 1462659768.845655, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.845655, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659768.845655, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.845655, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659768.845655, -------------- SYN_REPORT ------------
Event: time 1462659768.861659, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659768.861659, type 3 (EV_ABS), code 1 (ABS_Y), value 127
Event: time 1462659768.861659, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.861659, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659768.861659, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.861659, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659768.861659, -------------- SYN_REPORT ------------
Event: time 1462659768.869667, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659768.869667, type 3 (EV_ABS), code 1 (ABS_Y), value 0
Event: time 1462659768.869667, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.869667, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659768.869667, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.869667, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659768.869667, -------------- SYN_REPORT ------------
Event: time 1462659768.885663, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659768.885663, type 3 (EV_ABS), code 1 (ABS_Y), value 127
Event: time 1462659768.885663, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.885663, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659768.885663, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.885663, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659768.885663, -------------- SYN_REPORT ------------
Event: time 1462659768.893656, type 3 (EV_ABS), code 5 (ABS_RZ), value 0
Event: time 1462659768.893656, type 3 (EV_ABS), code 1 (ABS_Y), value 0
Event: time 1462659768.893656, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.893656, type 1 (EV_KEY), code 294 (BTN_BASE), value 1
Event: time 1462659768.893656, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.893656, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659768.893656, -------------- SYN_REPORT ------------
Event: time 1462659768.909661, type 3 (EV_ABS), code 5 (ABS_RZ), value 127
Event: time 1462659768.909661, type 3 (EV_ABS), code 1 (ABS_Y), value 127
Event: time 1462659768.909661, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90007
Event: time 1462659768.909661, type 1 (EV_KEY), code 294 (BTN_BASE), value 0
Event: time 1462659768.909661, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659768.909661, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659768.909661, -------------- SYN_REPORT ------------
Event: time 1462659770.821657, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.821657, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659770.821657, -------------- SYN_REPORT ------------
Event: time 1462659770.837663, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.837663, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659770.837663, -------------- SYN_REPORT ------------
Event: time 1462659770.845657, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.845657, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659770.845657, -------------- SYN_REPORT ------------
Event: time 1462659770.861666, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.861666, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659770.861666, -------------- SYN_REPORT ------------
Event: time 1462659770.869664, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.869664, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659770.869664, -------------- SYN_REPORT ------------
Event: time 1462659770.885663, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.885663, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659770.885663, -------------- SYN_REPORT ------------
Event: time 1462659770.893659, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.893659, type 1 (EV_KEY), code 295 (BTN_BASE2), value 1
Event: time 1462659770.893659, -------------- SYN_REPORT ------------
Event: time 1462659770.909670, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90008
Event: time 1462659770.909670, type 1 (EV_KEY), code 295 (BTN_BASE2), value 0
Event: time 1462659770.909670, -------------- SYN_REPORT ------------



Additionally, the second port disconnects frequently.
