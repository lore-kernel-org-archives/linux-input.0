From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 00/26] Wii Remote Extension Hotplugging Support
Date: Sun,  5 May 2013 23:12:44 +0200
Message-ID: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:33355 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3EEVNn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:43 -0400
Received: by mail-bk0-f52.google.com with SMTP id q16so1329600bkw.11
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Hi

This is my second revision of the hid-wiimote rework. It features:
  - Full extension hotplugging support: We can now initialize extensions during
    runtime and no longer require them to be plugged during connection setup.
  - Sub-device modularization: Nintendo produced many different devices which
    are based on the Wii-Remote protocol. However, they often emulate the core
    protocol but don't feature the hardware. The modularization allows us to
    disable hardware that isn't present and instead provide a consistent API
    to user-space.
    For instance, patch 24/26 adds "Wii U Pro Controller" support and avoids
    all the standard wii-remote input devices (rumble, IR, accelerometer,
    extensions, ...) and instead provides a single interface for the
    Pro-Controller features. That makes working with the device from user-space
    a lot easier.
  - Speaker support: Patch 26/26 adds an alsa sound driver and allows user-space
    to use the built-in speaker like any standard sound card.
  - Fixes: Several small fixes are included. They are very hard to backport so I
    didn't CC stable@vger. However, none of the fixes are crucial so I think we
    can ignore the stable kernels here. They fix things like reducing timeouts
    and debugfs bugs.

The Bluetooth HIDP rework is now upstream and already in David Miller's queue.
It will be part of linux-3.10 so if someone wants to test this, I recommend
using linux-next. However, this series doesn't depend on it. But if you want to
avoid Bluetooth l2cap oopses during hotplugging, you should use linux-next..

I did several code review-rounds myself and tested this with 4 different Wii
Remote revisions simultaneously. I didn't get any kernel oops, panic or deadlock
and it works very well. I also tested different extension devices, 3rd party
devices (including balance-board and Pro-Controller) and emulated devices. It
also works with Wii-U devices.
I did some backwards-compatibility checks. Obviously, old user-space won't
notice hot-plugged devices, but other than that the patches should be 100%
backwards-compatible.

Note that the driver doesn't support extension devices between patch 13 and 16.
But extension support is reworked heavily, so there is no reason to do a bisect
on wiimote extensions, anyway. Other than that the series should be bisectable.


Patch 24/26 is marked as RFC because it adds Wii-U-Pro-Controller mappings. If
someone could review them, I would be very glad. Because I want to avoid
introducing horrible mappings as I did with the main Wii-Remote buttons..

Patch 26/26 is marked as RFC as it adds an Alsa driver which I'd like to get
reviewed by ALSA developers. It works for me (and heavily tested), but it's my
first alsa driver, so I am not entirely sure. (alsa-devel is CC'ed for this
patch).


ABI changes are tagged as 3.11 so no need to push this into 3.10.
Sorry for the 3 weeks delay, but I thought I'd do some more review myself before
resending it.


Cheers
David

David Herrmann (26):
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
  HID: wiimote: remove old static extension support
  HID: wiimote: add MP quirks
  HID: wiimote: support Nintendo Wii U Pro Controller
  HID: wiimote: fix DRM debug-attr to correctly parse input
  HID/ALSA: wiimote: add speaker support

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   39 +-
 drivers/hid/Kconfig                                |   31 +-
 drivers/hid/Makefile                               |    8 +-
 drivers/hid/hid-wiimote-core.c                     | 1714 ++++++++++------
 drivers/hid/hid-wiimote-debug.c                    |   14 +-
 drivers/hid/hid-wiimote-ext.c                      |  849 --------
 drivers/hid/hid-wiimote-modules.c                  | 2091 ++++++++++++++++++++
 drivers/hid/hid-wiimote-speaker.c                  |  662 +++++++
 drivers/hid/hid-wiimote.h                          |  234 ++-
 9 files changed, 4188 insertions(+), 1454 deletions(-)
 delete mode 100644 drivers/hid/hid-wiimote-ext.c
 create mode 100644 drivers/hid/hid-wiimote-modules.c
 create mode 100644 drivers/hid/hid-wiimote-speaker.c

-- 
1.8.2.2

