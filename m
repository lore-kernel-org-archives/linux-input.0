From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 00/21] Nintendo Wii Remote Extension Hotplugging
Date: Sat, 13 Apr 2013 12:47:41 +0200
Message-ID: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:47343 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3DMKsZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:25 -0400
Received: by mail-ea0-f176.google.com with SMTP id h10so1526461eaj.7
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Hi

Last two month I sat down and started reverse-engineering the wiimote protocol
again. My goal was to finally get reliable extension hotplugging. What I then
ended up with was a huge Bluetooth-HID rewrite, a major hid-wiimote
modularization and finally working extension hotplug support.

The patches in Detail:
 - #1 to #6 are small fixes and initial device-detection logic. They are fairly
   simple and fix small issues I encountered.
 - #7 to #12 move all the sub-device drivers into modules. This allows us to
   extend device detection and load only the sub-devices that are actually
   present. For instance, the Balance Board does only provide one LED so we
   should not register led #2-#4. Note that the balance board still emulates the
   other LEDs in the protocol so we wouldn't notice that they are not present if
   we didn't know.
 - #13 to #17 implement extension hotplugging. Patch #13 extends the core to
   handle hotplugging and #14 to #17 implement the protocol parsers as modules
   so we can dynamically load different modules.
 - #18 to #21 add sysfs attributes and contain small fixes

I know that the driver became pretty huge, but it currently contains an
IR-camera driver, 4 accelerometer/gyro drivers, force-feedback driver, LED
driver, weight-sensor driver and like 5 different button/joystick drivers. So
considering that I think it's actually pretty small.

Another point is that I tried to be as conservative as possible. I tested this
code with several 3rd-party devices and all of them ended up breaking at some
point because they expect the exact Wii-Console behavior. I fixed everything I
found but I need more input from users here. At least I don't break any devices
that worked with the driver so far (as far as I know).

Also please don't merge it, yet. I still have to remove hid-wiimote-ext.c as it
is no longer needed, but I haven't tested how this affects
backwards-compatibility. I did my best to not break existing user-space, but I
want to do some more tests. So if there are no comments on this series, I will
resend in about 1 week with a ready-to-merge series. But I wanted to see whether
anyone has issues with the patches, first.


Some sidenotes:
 - Marcel already ACK'ed my Bluetooth HIDP rewrite which finally gives us
   working Bluetooth HID without any kernel oops. Gustavo is currently applying
   the patches. This series doesn't exactly depend on it, but you cannot test
   Bluetooth device hotplugging without it, because the kernel just breaks.
 - I currently work on the "Wii U Pro Controller". It's similar to the Classic
   Controller and I hope I can include patches for it in the next revision.
 - I also work on reverse-engineering the Wii U GamePad. It uses 5Ghz 802.11n
   instead of Bluetooth, but the Miracast (Wifi Display) protocol allows a
   separate HID stream side-by-side with the MPEG-4 video stream. So there might
   be a new hid_ll_driver in the future. However, I guess UHID will serve well
   for the beginning.

Last but not least I noticed that we duplicate the HID Boot Protocol in usbhid
and Bluetooth HID. The Wifi-Display HID also provides some similar protocol. So
I currently look into creating a hid-boot.c so we have a central place that
implements it.


Cheers
David

David Herrmann (21):
  HID: wiimote: extend driver description
  HID: wiimote: move queue handling into separate struct
  HID: wiimote: keep HID device open
  HID: wiimote: add device detection
  HID: wiimote: use cached battery values on I/O failure
  HID: wiimote: wake up if output queue failed
  HID: wiimote: add sub-device module infrastructure
  HID: wiimote: convert KEYS and RUMBLE to modules
  HID: wiimote: convert BATTERY to module
  HID: wiimote: convert LEDS to modules
  HID: wiimote: convert ACCEL to module
  HID: wiimote: convert IR to module
  HID: wiimote: add extension hotplug support
  HID: wiimote: add Balance Board support
  HID: wiimote: add Nunchuk support
  HID: wiimote: add Classic Controller extension
  HID: wiimote: add Motion Plus extension module
  HID: wiimote: fix ctx pointer in debugfs DRM-write
  HID: wiimote: lock DRM mode during debugfs overwrite
  HID: wiimote: add sysfs extension/device-type attrs
  HID: wiimote: add "bboard_calib" attribute

 drivers/hid/Kconfig               |   20 +-
 drivers/hid/Makefile              |    2 +-
 drivers/hid/hid-wiimote-core.c    | 1571 +++++++++++++++++++++------------
 drivers/hid/hid-wiimote-debug.c   |   10 +-
 drivers/hid/hid-wiimote-ext.c     |   16 +-
 drivers/hid/hid-wiimote-modules.c | 1717 +++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |  168 +++-
 7 files changed, 2925 insertions(+), 579 deletions(-)
 create mode 100644 drivers/hid/hid-wiimote-modules.c

-- 
1.8.2.1

