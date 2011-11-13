From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 00/16] Wiimote: Extension and Debug Support
Date: Sun, 13 Nov 2011 14:27:03 +0100
Message-ID: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48117 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1KMN14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:27:56 -0500
Received: by bke11 with SMTP id 11so4910943bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:27:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Hi

This is the revised patchset for extension support. I didn't change much
compared to the previously sent patchset apart from some cleanups and
simplifications.

I added 4 more patches which add debugfs support. They should be trivial,
though.

The first three patches split the driver into multiple files and add simple
helper functions.

The following patches add the basic extension-support layout and add protocol
parsers. I'd appreciate any feedback on that.


Regards
David

David Herrmann (16):
  HID: wiimote: Rename driver to allow multiple source files
  HID: wiimote: Move common symbols into header
  HID: wiimote: Add read-mem helpers
  HID: wiimote: Add extension support stub
  HID: wiimote: Add extension initializer stubs
  HID: wiimote: Add extension initializers
  HID: wiimote: Add extension sysfs attribute
  HID: wiimote: Register input devices for extensions
  HID: wiimote: Add extension handler stubs
  HID: wiimote: Parse motion+ data
  HID: wiimote: Parse nunchuck data
  HID: wiimote: Parse classic controller data
  HID: wiimote: Add debugfs support stubs
  HID: wiimote: Allow direct eeprom access
  HID: wiimote: Allow direct DRM debug access
  HID: wiimote: Enable NO_INIT_REPORTS quirk

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   12 +
 drivers/hid/Kconfig                                |    9 +
 drivers/hid/Makefile                               |    8 +
 drivers/hid/{hid-wiimote.c => hid-wiimote-core.c}  |  245 +++----
 drivers/hid/hid-wiimote-debug.c                    |  227 ++++++
 drivers/hid/hid-wiimote-ext.c                      |  744 ++++++++++++++++++++
 drivers/hid/hid-wiimote.h                          |  208 ++++++
 7 files changed, 1317 insertions(+), 136 deletions(-)
 rename drivers/hid/{hid-wiimote.c => hid-wiimote-core.c} (90%)
 create mode 100644 drivers/hid/hid-wiimote-debug.c
 create mode 100644 drivers/hid/hid-wiimote-ext.c
 create mode 100644 drivers/hid/hid-wiimote.h

-- 
1.7.7.3

