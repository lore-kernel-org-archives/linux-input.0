From: chris@cnpbagwell.com
Subject: [PATCH v4 0/4] Wacom Wireless Module Support
Date: Tue, 13 Mar 2012 19:51:58 -0500
Message-ID: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51988 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508Ab2CNAwK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 20:52:10 -0400
Received: by yenl12 with SMTP id l12so1239758yen.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 17:52:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, killertofu@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

The 3rd gen Bamboo Pen & Touch and Intuos5 tablets support an
optional wireless module.  This patch set adds support for it.

New in v4 -
 * Dropped patches related to 0xE5 support.  They will be sent
   on their own again.
 * Dropped a Kconfig patch that is already on for-linus branch.
 * Removed "Bamboo" references to wireless patch since
   wireless module works with at least 2 product families now.
 * Delayed enabling monitor interrupt to last possible moment in probe
   to fix crash reported by Jason Gerecke.

New in v3 - Changed a pointer reset from 0 to NULL.
Merged Ping's 0xE5 patches into this patch set to resolve
merge issues.

New in v2 - Updates only to 0xE5 patch set based on review comments.
No wireless patch changes.

Chris Bagwell (4):
  Input: wacom - isolate input registration
  Input: wacom - wireless monitor framework
  Input: wacom - create inputs when wireless connect
  Input: wacom - wireless battery status

 drivers/input/tablet/Kconfig     |    1 +
 drivers/input/tablet/wacom.h     |    9 ++
 drivers/input/tablet/wacom_sys.c |  230 ++++++++++++++++++++++++++++++++-----
 drivers/input/tablet/wacom_wac.c |   49 ++++++++-
 drivers/input/tablet/wacom_wac.h |    6 +
 5 files changed, 263 insertions(+), 32 deletions(-)

-- 
1.7.7.6

