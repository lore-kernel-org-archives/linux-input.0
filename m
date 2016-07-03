From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] HID: hid-led: add support for Delcom Visual Signal
 Indicator G2
Date: Sun, 3 Jul 2016 17:40:32 +0200
Message-ID: <e804a266-95b3-5e1e-b3e8-930f27fe88d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33742 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbcGCPtA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2016 11:49:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id r201so16340675wme.0
        for <linux-input@vger.kernel.org>; Sun, 03 Jul 2016 08:49:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

I got hold of a Delcom Visual Signal Indicator G2 device.
Unlike generation 1 devices generation 2 is fully HID-compliant
what makes it easy to support them in the hid-led driver.

Just a small change to the framework is needed because Delcom doesn't
use a fixed report id. Instead the report id is used to submit
command information.

Heiner Kallweit (2):
  HID: hid-led: remove report id from struct hidled_config
  HID: hid-led: add support for Delcom Visual Signal Indicator G2

 drivers/hid/hid-core.c |   1 +
 drivers/hid/hid-ids.h  |   3 ++
 drivers/hid/hid-led.c  | 104 +++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 97 insertions(+), 11 deletions(-)

-- 
2.9.0

