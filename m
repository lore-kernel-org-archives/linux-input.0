From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 0/8] HID: wacom: Support second generation Intuos Pro
Date: Wed, 25 Jan 2017 12:08:34 -0800
Message-ID: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35135 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdAYUJR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so15004340pfa.2
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>

Patches 1-3 add Bluetooth support for the 2nd-gen Intuos Pro. Its
Bluetooth report lacks a proper report descriptor so we must add
explicit support for the device here.

Patches 4-8 add USB support for this device via the Wacom driver's
generic code path.

Best,
Aaron

Aaron Armstrong Skomra (5):
  HID: wacom: generic: remove input_event_flag
  HID: wacom: generic: add support for touchring
  HID: wacom: generic: add vendor defined touch
  HID: wacom: generic: support generic touch switch
  HID: wacom: generic: support LEDs

Jason Gerecke (3):
  HID: wacom: Enable HID_GENERIC codepath for Bluetooth devices
  HID: wacom: Move WAC_CMD_* into wacom_wac.h
  HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface

 drivers/hid/wacom.h     |   3 +
 drivers/hid/wacom_sys.c | 111 +++++++++++++++----
 drivers/hid/wacom_wac.c | 279 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/hid/wacom_wac.h |  37 ++++++-
 4 files changed, 389 insertions(+), 41 deletions(-)

-- 
2.7.4

