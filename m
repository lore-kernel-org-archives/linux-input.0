From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 00/14] Extended Wiimote Support
Date: Mon, 29 Aug 2011 15:37:57 +0200
Message-ID: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab1H2Nia (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 09:38:30 -0400
Received: by fxh19 with SMTP id 19so4422164fxh.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 06:38:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

Hi

This adds support for accelerometer, IR-cam, force-feedback and battery-requests
of the wiimote.
Input support is split into 3 devices to allow huge power-savings on the
wiimote. As extension support must add at least 2 new input devices since the
ABS_XY ids are needed, I thought adding 2 more for accelerometer and IR doesn't
bother that much, but helps saving lots of power of the wiimote.

This patchset basically just extends the current driver with trivial DRM-modes
and further input reports. The only new _more complex_ feature is probably the
stream-locking/unlocking for synchronous requests.

For userspace tools, see (as always): http://github.com/dvdhrm/xwiimote

Thanks for reviewing,
David

David Herrmann (14):
  HID: wiimote: Support rumble device
  HID: wiimote: Add force-feedback support
  HID: wiimote: Add accelerometer input device
  HID: wiimote: Parse accelerometer data
  HID: wiimote: Add IR input device
  HID: wiimote: Parse IR data
  HID: wiimote: Add missing extension DRM handlers
  HID: wiimote: Add register/eeprom memory support
  HID: wiimote: Helper functions for synchronous requests
  HID: wiimote: Add write-register helpers
  HID: wiimote: Add IR initializer
  HID: wiimote: Initialize IR cam on request
  HID: wiimote: Add status request
  HID: wiimote: Read wiimote battery charge level

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |    8 +
 drivers/hid/hid-wiimote.c                          |  776 +++++++++++++++++++-
 2 files changed, 768 insertions(+), 16 deletions(-)

-- 
1.7.6.1

