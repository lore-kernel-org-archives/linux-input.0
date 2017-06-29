From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Genius "Wizard Stick" wireless joystick not working properly
Date: Thu, 29 Jun 2017 22:12:39 +0200
Message-ID: <20170629153538.1d2391a4@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751715AbdF2UMr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 16:12:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello,

I tried to connect a Genius "Wizard Stick" wireless joystick to my PC.

The device is identified as

Bus 003 Device 122: ID 0458:00d9 KYE Systems Corp. (Mouse Systems) 

/dev/input/event13:	KYE RF Game controller
/dev/input/event14:	KYE RF Game controller (no events on this)
evtest /dev/input/event14
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x458 product 0xd9 version 0x100
Input device name: "KYE RF Game controller"
Supported events:
  Event type 0 (EV_SYN)
Properties:

When the device is on these events are reported continuously by evtest:

Event: time 1498742449.233575, type 2 (EV_REL), code 2 (REL_Z), value 3
Event: time 1498742449.233575, type 2 (EV_REL), code 3 (REL_RX), value -14 
Event: time 1498742449.233575, type 2 (EV_REL), code 9 (REL_MISC), value 26

These are probably readings from the accelerometer which is advertised
as a feature of the device. Way more axis and buttons are reported than
actually exist. Also buttons are assigned from BTN_LEFT all the way
through joystick buttons by the hid driver. I tried reassigning the
buttons with a hwdb entry like:

# Genius Wizard Stick - this continuously reports events from accelerometer as RX, Z and MISC axis
evdev:name:*KYE RF Game controller*
# top big round A button
 KEYBOARD_KEY_90001=BTN_THUMB
# botton trigger (B)
 KEYBOARD_KEY_90002=BTN_TRIGGER
# dpad buttons
 KEYBOARD_KEY_90004=BTN_DPAD_LEFT
 KEYBOARD_KEY_90005=BTN_DPAD_RIGHT
 KEYBOARD_KEY_90006=BTN_DPAD_DOWN
 KEYBOARD_KEY_90007=BTN_DPAD_UP
# small round top s button
 KEYBOARD_KEY_9000a=BTN_START
# small round top menu button
 KEYBOARD_KEY_90003=BTN_SELECT
# colourful buttons
# blue square ^ 90009
 KEYBOARD_KEY_90009=BTN_Y
# orange triangle > 9000c
 KEYBOARD_KEY_9000c=BTN_B
# green circle  v 90008
 KEYBOARD_KEY_90008=BTN_A
# red X < 9000b
 KEYBOARD_KEY_9000b=BTN_X

the mappings are assigned:

udevadm info  /sys/class/input/event14
P: /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:0458:00D9.0045/input/input162/event13
N: input/event13
S: input/by-id/usb-KYE_RF_Game_controller-event-joystick
S: input/by-path/pci-0000:00:14.0-usb-0:1:1.0-event-joystick
E: DEVLINKS=/dev/input/by-id/usb-KYE_RF_Game_controller-event-joystick /dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.0-event-joystick
E: DEVNAME=/dev/input/event13 
E: DEVPATH=/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:0458:00D9.0045/input/input162/event13
E: ID_BUS=usb E: ID_FOR_SEAT=input-pci-0000_00_14_0-usb-0_1_1_0
E: ID_INPUT=1
E: ID_INPUT_JOYSTICK=1
E: ID_INPUT_MOUSE=1
E: ID_MODEL=RF_Game_controller
E: ID_MODEL_ENC=RF\x20Game\x20controller
E: ID_MODEL_ID=00d9
E: ID_PATH=pci-0000:00:14.0-usb-0:1:1.0
E: ID_PATH_TAG=pci-0000_00_14_0-usb-0_1_1_0
E: ID_REVISION=0203
E: ID_SERIAL=KYE_RF_Game_controller
E: ID_TYPE=hid
E: ID_USB_DRIVER=usbhid
E: ID_USB_INTERFACES=:030102:030000:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=KYE
E: ID_VENDOR_ENC=KYE
E: ID_VENDOR_ID=0458
E: KEYBOARD_KEY_90001=BTN_THUMB
E: KEYBOARD_KEY_90002=BTN_TRIGGER
E: KEYBOARD_KEY_90003=BTN_SELECT
E: KEYBOARD_KEY_90004=BTN_DPAD_LEFT
E: KEYBOARD_KEY_90005=BTN_DPAD_RIGHT
E: KEYBOARD_KEY_90006=BTN_DPAD_DOWN
E: KEYBOARD_KEY_90007=BTN_DPAD_UP
E: KEYBOARD_KEY_90008=BTN_A
E: KEYBOARD_KEY_90009=BTN_Y
E: KEYBOARD_KEY_9000a=BTN_START
E: KEYBOARD_KEY_9000b=BTN_X
E: KEYBOARD_KEY_9000c=BTN_B
E: LIBINPUT_DEVICE_GROUP=3/458/d9/110:usb-0000:00:14.0-1
E: MAJOR=13
E: MINOR=77
E: SUBSYSTEM=input
E: TAGS=:seat:uaccess:
E: USEC_INITIALIZED=3908136647901

but have no effect:

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x458 product 0xd9 version 0x110
Input device name: "KYE RF Game controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
    Event code 277 (BTN_FORWARD)
    Event code 278 (BTN_BACK)
    Event code 279 (BTN_TASK)
    Event code 280 (?)
    Event code 281 (?)
    Event code 282 (?)
    Event code 283 (?)
    Event code 284 (?)
    Event code 285 (?)
    Event code 286 (?)
    Event code 287 (?)
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
    Event code 304 (BTN_SOUTH)
    Event code 305 (BTN_EAST)
    Event code 306 (BTN_C)
    Event code 307 (BTN_NORTH)
    Event code 308 (BTN_WEST)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 4 (REL_RY)
    Event code 5 (REL_RZ)
    Event code 6 (REL_HWHEEL)
    Event code 8 (REL_WHEEL)
    Event code 10 (?)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 8 (LED_MISC) state 0
    Event code 9 (LED_MAIL) state 0
    Event code 10 (LED_CHARGING) state 0

Linux 4.11.0-2-default #1 SMP PREEMPT

Any idea what is going on?

Thanks

Michal
