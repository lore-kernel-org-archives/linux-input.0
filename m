From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH 0/4] HID: (thingm) introduces blink(1) mk2
Date: Mon, 14 Apr 2014 16:50:16 -0400
Message-ID: <1397508620-15244-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:54559 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaDNVCE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 17:02:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jkosina@suse.cz>, linux-leds@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

This patchset introduces the support of the blink(1) mk2 device, after a
refactoring of the thingm driver. It removes non-standard sysfs attributes and
uses work queues to fix the usage of triggers with this device.

Vivien Didelot (4):
  HID: (thingm) remove the "play" sysfs attribute
  HID: (thingm) remove the "fade" sysfs attribute
  HID: (thingm) refactor blink(1) support
  HID: (thingm) add support for blink(1) mk2

 Documentation/ABI/testing/sysfs-driver-hid-thingm |  23 --
 drivers/hid/hid-thingm.c                          | 361 ++++++++++++----------
 drivers/leds/Kconfig                              |   2 +
 3 files changed, 203 insertions(+), 183 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-driver-hid-thingm

-- 
1.9.1

