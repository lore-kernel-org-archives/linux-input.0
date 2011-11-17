From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 00/17] HID: Wiimote Extension Support v2
Date: Thu, 17 Nov 2011 14:11:57 +0100
Message-ID: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44293 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNMv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:12:51 -0500
Received: by eye27 with SMTP id 27so1873323eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:12:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

Hi

Version 2 of the wiimote extension support removes the module-versioning and
adds a comment to the deinitialization function.

Regards
David

David Herrmann (17):
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
  HID: wiimote: Remove module version number
  HID: wiimote: Enable NO_INIT_REPORTS quirk

 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   12 +
 drivers/hid/Kconfig                                |    9 +
 drivers/hid/Makefile                               |    8 +
 drivers/hid/{hid-wiimote.c => hid-wiimote-core.c}  |  246 +++----
 drivers/hid/hid-wiimote-debug.c                    |  227 ++++++
 drivers/hid/hid-wiimote-ext.c                      |  752 ++++++++++++++++++++
 drivers/hid/hid-wiimote.h                          |  208 ++++++
 7 files changed, 1324 insertions(+), 138 deletions(-)
 rename drivers/hid/{hid-wiimote.c => hid-wiimote-core.c} (89%)
 create mode 100644 drivers/hid/hid-wiimote-debug.c
 create mode 100644 drivers/hid/hid-wiimote-ext.c
 create mode 100644 drivers/hid/hid-wiimote.h

-- 
1.7.7.3

