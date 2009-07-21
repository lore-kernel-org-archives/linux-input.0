From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] trivial: fix typo s/ketymap/keymap/ in comment
Date: Tue, 21 Jul 2009 15:57:47 -0300
Message-ID: <1248202667-14107-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade.minaslivre.org ([72.232.18.203]:35252 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZGUS57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 14:57:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: trivial@kernel.org
Cc: giel@caffeinetrip.com, dtor@mail.ru, linux-input@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/input/keyboard/atkbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 809a7dd..8e8ddf7 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -227,7 +227,7 @@ struct atkbd {
 };
 
 /*
- * System-specific ketymap fixup routine
+ * System-specific keymap fixup routine
  */
 static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
 static void *atkbd_platform_fixup_data;
-- 
1.6.3.3

