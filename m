From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 00/15] Extended Wiimote Support
Date: Tue,  6 Sep 2011 13:50:25 +0200
Message-ID: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44212 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab1IFLvK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:10 -0400
Received: by fxh19 with SMTP id 19so4508571fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Hi

This is v2 of the extended wiimote support. It adds support for Accelerometer,
IR-Cam, battery and force-feedback.

v2 replaces the sysfs-battery attribute with a power_supply device.

Regards
David

David Herrmann (15):
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
  HID: wiimote: Add MAINTAINERS entry

 MAINTAINERS               |    6 +
 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |  800 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 791 insertions(+), 16 deletions(-)

-- 
1.7.6.1

