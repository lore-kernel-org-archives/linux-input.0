From: "Zooko Wilcox-O'Hearn" <zookog@gmail.com>
Subject: Chromebook Pixel 1 atmel_mxt_ts doesn't work
Date: Tue, 13 Oct 2015 17:39:43 +0000
Message-ID: <CANdZDc4sHV5D6a8TsuSJ5hbecXP4SokmLp8E9KkD92pmMu7OTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37194 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbbJMRjo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 13:39:44 -0400
Received: by igcpe7 with SMTP id pe7so22155830igc.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 10:39:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

I'm running Linux 4.1.10 on a Chromebook Pixel 1 and my touchpad and
touchscreen don't work. Guided by Dmitry Torokhov on G+
(https://plus.google.com/u/0/+BensonLeung/posts/8zum4U7Aztg), I've
gotten as far as thinking that maybe these /var/log/syslog messages
are indicating the problem:

Oct 13 17:35:56 spark kernel: [ 2767.471569] atmel_mxt_ts 3-004a:
Direct firmware load for maxtouch.cfg failed with error -2
Oct 13 17:35:56 spark kernel: [ 2767.509568] input: Atmel maXTouch
Touchscreen as /devices/pci0000:00/0000:00:02.0/i2c-3/3-004a/input/inpu=
t14
Oct 13 17:35:56 spark kernel: [ 2767.510569] atmel_mxt_ts 2-004b:
Direct firmware load for maxtouch.cfg failed with error -2
Oct 13 17:35:56 spark kernel: [ 2767.513378] atmel_mxt_ts 3-004a:
=46amily: 162 Variant: 0 Firmware V1.1.AA Objects: 27
Oct 13 17:35:56 spark kernel: [ 2767.515044] input: Atmel maXTouch
Touchpad as /devices/pci0000:00/0000:00:02.0/i2c-2/2-004b/input/input15
Oct 13 17:35:56 spark kernel: [ 2767.515304] atmel_mxt_ts 2-004b:
=46amily: 130 Variant: 1 Firmware V1.0.AA Objects: 22

These get posted whenever I modprobe atmel_mxt_ts, although the module
is subsequently listed in lsmod.

Here are some of my kernel config options:

$ zgrep -i i2c /proc/config.gz  | grep -v ^#
CONFIG_REGMAP_I2C=3Dy
CONFIG_TCG_TIS_I2C_ATMEL=3Dm
CONFIG_I2C=3Dy
CONFIG_ACPI_I2C_OPREGION=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_MUX=3Dm
CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_I801=3Dy
CONFIG_I2C_ISCH=3Dm
CONFIG_I2C_SCMI=3Dy
CONFIG_I2C_CROS_EC_TUNNEL=3Dy
CONFIG_I2C_STUB=3Dm
CONFIG_MFD_CROS_EC_I2C=3Dy
CONFIG_SND_SOC_I2C_AND_SPI=3Dm

Here is the result of evtest:

zooko@spark~ $ sudo evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      Lid Switch
/dev/input/event1:      Power Button
/dev/input/event2:      Sleep Button
/dev/input/event3:      Sleep Button
/dev/input/event4:      Power Button
/dev/input/event5:      AT Translated Set 2 keyboard
/dev/input/event6:      Video Bus
/dev/input/event7:      Chromebook HD WebCam
/dev/input/event8:      Samsung S Action Mouse ET-MP900D
/dev/input/event9:      Jabra BIZ 2400 USB
/dev/input/event10:     Lite-On Technology Corp. Goldtouch USB Keyboard
/dev/input/event11:     Atmel maXTouch Touchpad
/dev/input/event12:     Atmel maXTouch Touchscreen
/dev/input/event13:     Lite-On Technology Corp. Goldtouch USB Keyboard
Select the device event number [0-13]: 11
Input driver version is 1.0.1
Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
Input device name: "Atmel maXTouch Touchpad"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 325 (BTN_TOOL_FINGER)
    Event code 328 (BTN_TOOL_QUINTTAP)
    Event code 330 (BTN_TOUCH)
    Event code 333 (BTN_TOOL_DOUBLETAP)
    Event code 334 (BTN_TOOL_TRIPLETAP)
    Event code 335 (BTN_TOOL_QUADTAP)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max     2039
      Resolution      20
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max     1359
      Resolution      20
    Event code 24 (ABS_PRESSURE)
      Value      0
      Min        0
      Max      255
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        9
    Event code 48 (ABS_MT_TOUCH_MAJOR)
      Value      0
      Min        0
      Max      255
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     2039
      Resolution      20
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     1359
      Resolution      20
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
    Event code 58 (ABS_MT_PRESSURE)
      Value      0
      Min        0
      Max      255
Properties:
  Property type 0 (INPUT_PROP_POINTER)
  Property type 2 (INPUT_PROP_BUTTONPAD)=EF=BB=BF

Thanks, folks!

--Zooko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
