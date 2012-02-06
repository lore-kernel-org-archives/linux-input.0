From: chris@cnpbagwell.com
Subject: [PATCH 0/5] Wacom Bamboo Wireless Support
Date: Sun,  5 Feb 2012 20:46:11 -0600
Message-ID: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46352 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751851Ab2BFCqY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Feb 2012 21:46:24 -0500
Received: by obcva7 with SMTP id va7so6249563obc.19
        for <linux-input@vger.kernel.org>; Sun, 05 Feb 2012 18:46:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

The 3rd gen Bamboo Pen & Touch tabletse support an optional
wireless module.  This patch set adds support for it.

The only feature missing; compared to Windows driver; is
a sysfs interface to allow setting time period before tablet
goes to sleep.  This may come in a future patch.

Chris Bagwell (5):
  Input: wacom - isolate input registration
  Input: wacom - Bamboo wireless monitor framework
  Input: wacom - create inputs when wireless connect
  Input: wacom - wireless Bamboo battery status
  Input: wacom : Add missing LEDS_CLASS to Kconfig

 drivers/input/tablet/Kconfig     |    2 +
 drivers/input/tablet/wacom.h     |    9 ++
 drivers/input/tablet/wacom_sys.c |  228 ++++++++++++++++++++++++++++++++-----
 drivers/input/tablet/wacom_wac.c |   49 ++++++++-
 drivers/input/tablet/wacom_wac.h |    6 +
 5 files changed, 262 insertions(+), 32 deletions(-)

-- 
1.7.7.6

