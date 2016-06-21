From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/4] HID: merge support for ThingM blink(1) into hid-led
Date: Tue, 21 Jun 2016 19:53:55 +0200
Message-ID: <dc6bbc8a-4454-fb95-4a98-6266523f320b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36758 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcFUTvB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 15:51:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so6451189lfe.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 12:51:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

The hid-led driver just needs small extensions to support also devices with
multiple independent LED's. As a first device of this category support for
the ThingM blink(1) can be merged into the hid-led driver.

Heiner Kallweit (4):
  HID: hid-led: add support for devices with multiple independent LEDs
  HID: hid-led: add support for reading from LED devices
  HID: hid-led: add support for ThingM blink(1)
  HID: remove ThingM blink(1) driver

 drivers/hid/Kconfig      |  17 +---
 drivers/hid/Makefile     |   1 -
 drivers/hid/hid-led.c    | 180 ++++++++++++++++++++++++++------
 drivers/hid/hid-thingm.c | 259 -----------------------------------------------
 4 files changed, 154 insertions(+), 303 deletions(-)
 delete mode 100644 drivers/hid/hid-thingm.c

-- 
2.9.0

