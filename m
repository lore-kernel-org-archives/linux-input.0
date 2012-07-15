From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/3] HID: Add HID_CLAIMED_OTHER device flag
Date: Sun, 15 Jul 2012 20:21:46 +0200
Message-ID: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37971 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2GOSWP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jul 2012 14:22:15 -0400
Received: by wgbdr13 with SMTP id dr13so309295wgb.1
        for <linux-input@vger.kernel.org>; Sun, 15 Jul 2012 11:22:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Hi

Drivers like picolcd and wiimote work without the generic hid drivers (hidinput,
hidraw, hiddev). Therefore, we need to make sure that the hid-core does not drop
the device when no driver claimed it.

This introduces the HID_CLAIMED_OTHER flag which can be set by said drivers to
tell hid-core to allow the device without a generic driver loaded.

Patch 2 and 3 convert picolcd and wiimote to use this new flag.

Regards
David

David Herrmann (3):
  HID: Add HID_CLAIMED_OTHER for non-generic drivers
  HID: picolcd: explicitly claim hid devices with HID_CLAIMED_OTHER
  HID: wiimote: explicitly claim hid devices with HID_CLAIMED_OTHER

 drivers/hid/hid-core.c         | 2 ++
 drivers/hid/hid-picolcd.c      | 7 +++----
 drivers/hid/hid-wiimote-core.c | 1 +
 include/linux/hid.h            | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.11.2

