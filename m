From: chris@cnpbagwell.com
Subject: [PATCH v3 0/7] Wireless Bamboo and 0xE5 device support
Date: Sat, 11 Feb 2012 15:55:27 -0600
Message-ID: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61504 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab2BKVzj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Feb 2012 16:55:39 -0500
Received: by obcva7 with SMTP id va7so5156955obc.19
        for <linux-input@vger.kernel.org>; Sat, 11 Feb 2012 13:55:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

The 3rd gen Bamboo Pen & Touch tablets support an optional
wireless module.  This patch set adds support for it.

New in v3 - Changed a pointer reset from 0 to NULL and merged
Ping's 2 outstanding patches into this set to resolve merge
conflicts and dependency issues.

New in v2 - I never released a v2 for Bamboo but skipped to avoid confusion
with there being a v2 of Ping's 2 patches released seperately.
Changes I made to Ping's 2 patches in v2:

Move init of touch_max to features table based on review comment.
Fixed memory leak in wacom_retrieve_report_data() by moving value
to stack.

Chris Bagwell (5):
  Input: wacom - isolate input registration
  Input: wacom - Bamboo wireless monitor framework
  Input: wacom - create inputs when wireless connect
  Input: wacom - wireless Bamboo battery status
  Input: wacom : Add missing LEDS_CLASS to Kconfig

Ping Cheng (2):
  input : wacom - retrieve maximum number of touch points
  input: wacom - add 0xE5 (MT device) support

 drivers/input/tablet/Kconfig     |    2 +
 drivers/input/tablet/wacom.h     |    9 +
 drivers/input/tablet/wacom_sys.c |  305 ++++++++++++++++++++++++++++++--------
 drivers/input/tablet/wacom_wac.c |  191 +++++++++++++++++++++---
 drivers/input/tablet/wacom_wac.h |   15 ++
 5 files changed, 439 insertions(+), 83 deletions(-)

-- 
1.7.7.6

