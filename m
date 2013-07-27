From: oscherler@ithink.ch
Subject: [PATCH 0/1] hid: Add new driver for non-compliant Xin-Mo devices.
Date: Sat, 27 Jul 2013 19:20:01 +0200
Message-ID: <1374945602-11894-1-git-send-email-oscherler@ithink.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:61963 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3G0RUO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jul 2013 13:20:14 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so335904eek.32
        for <linux-input@vger.kernel.org>; Sat, 27 Jul 2013 10:20:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Olivier Scherler <oscherler@ithink.ch>

From: Olivier Scherler <oscherler@ithink.ch>

The Xin-Mo Dual Arcade Controller sends axis values that are out of
range with respect to the HID report descriptor. This patch adds a
driver to correct the input values so they are not thrown out by the
range check in hid-input.c.

The issue is discussed here: <https://bugs.launchpad.net/bugs/1077359>

checkpatch.pl gives warnings for two lines that are over 80 characters,
but I decided not to change them since similar lines in other HID
drivers. The third warning asks for a paragraph that describes the new
config symbol in Kconfig fully. I will gladly accept advice on how to
improve it.

This has been tested on Ubuntu Desktop 13.04 in a VMware VM and on a
Raspberry Pi running Raspbian.

Olivier Scherler (1):
  hid: Add new driver for non-compliant Xin-Mo devices.

 drivers/hid/Kconfig     |  8 ++++++
 drivers/hid/Makefile    |  1 +
 drivers/hid/hid-core.c  |  1 +
 drivers/hid/hid-ids.h   |  3 +++
 drivers/hid/hid-xinmo.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 drivers/hid/hid-xinmo.c

-- 
1.8.1.2

