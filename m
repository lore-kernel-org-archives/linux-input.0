From: Daniele Forsi <dforsi@gmail.com>
Subject: [PATCH] Input: trivial: fix typo in Kconfig help
Date: Mon, 12 May 2014 18:24:02 +0200
Message-ID: <1399911842-28081-1-git-send-email-dforsi@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:45021 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbaELQYN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 12:24:13 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so4785088eek.31
        for <linux-input@vger.kernel.org>; Mon, 12 May 2014 09:24:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, Daniele Forsi <dforsi@gmail.com>

s/Logictech/Logitech/

CC: Jiri Kosina <trivial@kernel.org>
Signed-off-by: Daniele Forsi <dforsi@gmail.com>
---
 drivers/input/mouse/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index effa9c5..ff9b65d 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -53,7 +53,7 @@ config MOUSE_PS2_LOGIPS2PP
 	default y
 	depends on MOUSE_PS2
 	help
-	  Say Y here if you have a Logictech PS/2++ mouse connected to
+	  Say Y here if you have a Logitech PS/2++ mouse connected to
 	  your system.
 
 	  If unsure, say Y.
-- 
2.0.0.rc0

