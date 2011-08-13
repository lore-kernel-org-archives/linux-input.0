From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/7] New wiimote interface
Date: Sat, 13 Aug 2011 15:29:08 +0200
Message-ID: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42152 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1HMN3c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Aug 2011 09:29:32 -0400
Received: by fxh19 with SMTP id 19so2801615fxh.19
        for <linux-input@vger.kernel.org>; Sat, 13 Aug 2011 06:29:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

Hi

As discussed on the ML, this adds a new interface for LED and rumble devices on
the wiimote. LED devices can now be controlled via led_classdev structure and
the rumble motor is controlled via force-feedback FF_RUMBLE event.

Based on the new semaphore-lock this also simplifies the locking to reduce
overhead and code complexity.

The last two patches correctly set DRM modes on new events. Currently, if an
extension is plugged into the wiimote, this driver stops working. Those two
patches make the driver reset the DRM so it still works with extensions plugged
in. Hence, it would be nice to see them in 3.1, too.

I have omitted the accelerometer/IR/extension etc. patches since they probably
don't go into 3.1 and I will resend them later after more testing.

Regards
David

David Herrmann (7):
  HID: wiimote: Simplify synchronization
  HID: wiimote: Correctly call HID open/close callbacks
  HID: wiimote: Register led class devices
  HID: wiimote: Support rumble device
  HID: wiimote: Add force-feedback support
  HID: wiimote: Add drm request
  HID: wiimote: Add status and return request handlers

 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |  345 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 276 insertions(+), 70 deletions(-)

-- 
1.7.6

