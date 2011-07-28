From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 00/16] Extended wiimote support
Date: Thu, 28 Jul 2011 18:08:20 +0200
Message-ID: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab1G1QJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:03 -0400
Received: by fxh19 with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Hi

This patch series adds support for extended wiimote features:
 - force-feedback / rumble
 - accelerometer
 - IR cam input for up to 4 trackable items
 - battery charge level
 - raw eeprom access

Most of the patches just extend the current driver with trivial features. The
only new interface is the "synchronous requests" API which allows to lock the
stream for a series of requests.

For userspace tools see:
  http://github.com/dvdhrm/xwiimote
tools/xwiishow.c visualizes all wiimote input and is great to test the driver.

The only missing feature is extension support which I am currently working on
and which is available in my xwiimote_kernel repository. So after this series I
will submit one last series of patches for extension support.

It would be great to get some review and feedback. The current bluez repo also
has a wiimote plugin so pairing should be as simple as with other devices now.
The next bluez release will bring it to the distros, eventually.

I've set the KernelRelease of the sysfs docs to 3.2 so there is no time pressure
for 3.1.

Regards
David

David Herrmann (16):
  HID: wiimote: Support rumble device
  HID: wiimote: Add sysfs rumble attribute
  HID: wiimote: Add drm request
  HID: wiimote: Add status and return request handlers
  HID: wiimote: Reduce input syncs
  HID: wiimote: Enable accelerometer on request
  HID: wiimote: Parse accelerometer data
  HID: wiimote: Parse IR input and report to userspace
  HID: wiimote: Add missing extension DRM handlers
  HID: wiimote: Add register/eeprom memory support
  HID: wiimote: Helper functions for synchronous requests
  HID: wiimote: Add write-register helpers
  HID: wiimote: Add IR initializer
  HID: wiimote: Allow userspace to control IR cam
  HID: wiimote: Read wiimote battery charge level
  HID: wiimote: Allow EEPROM debugfs access

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   34 +
 drivers/hid/hid-wiimote.c                          |  965 +++++++++++++++++++-
 2 files changed, 993 insertions(+), 6 deletions(-)

-- 
1.7.6

