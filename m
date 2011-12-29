From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH] Input: sentelic: Fixing wrong register offset
Date: Thu, 29 Dec 2011 21:00:05 +0800
Message-ID: <1325163605-30670-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:10906 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab1L2NC1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 08:02:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tai-hwa Liang <avatar@sentelic.com>

Fixing wrong register offset which is used to retrieve the number of buttons
attached to the hardware.

Signed-off-by: Tai-hwa Liang <avatar@sentelic.com>
---
 drivers/input/mouse/sentelic.c |    4 ++--
 drivers/input/mouse/sentelic.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 5babc47..c8a73b9 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -2,7 +2,7 @@
  * Finger Sensing Pad PS/2 mouse driver.
  *
  * Copyright (C) 2005-2007 Asia Vital Components Co., Ltd.
- * Copyright (C) 2005-2010 Tai-hwa Liang, Sentelic Corporation.
+ * Copyright (C) 2005-2011 Tai-hwa Liang, Sentelic Corporation.
  *
  *   This program is free software; you can redistribute it and/or
  *   modify it under the terms of the GNU General Public License
@@ -309,7 +309,7 @@ static int fsp_get_buttons(struct psmouse *psmouse, int *btn)
 	};
 	int val;
 
-	if (fsp_reg_read(psmouse, FSP_REG_TMOD_STATUS1, &val) == -1)
+	if (fsp_reg_read(psmouse, FSP_REG_TMOD_STATUS, &val) == -1)
 		return -EIO;
 
 	*btn = buttons[(val & 0x30) >> 4];
diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index ed1395a..2e4af24 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -2,7 +2,7 @@
  * Finger Sensing Pad PS/2 mouse driver.
  *
  * Copyright (C) 2005-2007 Asia Vital Components Co., Ltd.
- * Copyright (C) 2005-2009 Tai-hwa Liang, Sentelic Corporation.
+ * Copyright (C) 2005-2011 Tai-hwa Liang, Sentelic Corporation.
  *
  *   This program is free software; you can redistribute it and/or
  *   modify it under the terms of the GNU General Public License
@@ -33,6 +33,7 @@
 /* Finger-sensing Pad control registers */
 #define	FSP_REG_SYSCTL1		0x10
 #define	FSP_BIT_EN_REG_CLK	BIT(5)
+#define	FSP_REG_TMOD_STATUS	0x20
 #define	FSP_REG_OPC_QDOWN	0x31
 #define	FSP_BIT_EN_OPC_TAG	BIT(7)
 #define	FSP_REG_OPTZ_XLO	0x34
-- 
1.7.7.3

