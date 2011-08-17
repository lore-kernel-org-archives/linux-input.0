From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH V2 0/5] Wiimote fixes for 3.1
Date: Wed, 17 Aug 2011 11:43:19 +0200
Message-ID: <1313574204-12664-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1HQJny (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:43:54 -0400
Received: by fxh19 with SMTP id 19so525058fxh.19
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 02:43:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: oliver@neukum.org, jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

This contains few fixes for the current wiimote driver. Since HID core uses a
semaphore lock now, we can simplify the wiimote synchronization. This also adds
open/close callbacks, although bthid doesn't need that, but it makes the code
more consistent with other drivers.
As discussed on the mailinglist, this also removes the four LED sysfs attributes
in favor of four new led_classdev devices. I hope it is ok to remove an API as
long as 3.1 isn't released, yet.
The last two patches fix a bug that the driver didn't work when an extension was
plugged/unplugged. They simply reset the current DRM so the extension port is
ignored.

I've kept these fixes for 3.1 small. I will resend the other patches for 3.2
as RFC soon.

Cheers
David

David Herrmann (5):
  HID: wiimote: Simplify synchronization
  HID: wiimote: Correctly call HID open/close callbacks
  HID: wiimote: Register led class devices
  HID: wiimote: Add drm request
  HID: wiimote: Add status and return request handlers

 drivers/hid/Kconfig       |    1 +
 drivers/hid/hid-wiimote.c |  277 ++++++++++++++++++++++++++++++---------------
 2 files changed, 184 insertions(+), 94 deletions(-)

-- 
1.7.6

