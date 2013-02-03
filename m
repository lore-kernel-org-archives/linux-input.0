From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 09/14] Input: ALPS - Fix command mode check
Date: Sun,  3 Feb 2013 15:56:49 -0800
Message-ID: <1359935815-13507-10-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40396 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3BCX5e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:34 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so155649pab.1
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:33 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Pinnacle class devices should return "88 07 xx" or "88 08 xx" when
entering command mode.  If either the first byte or the second byte is
invalid, return an error.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index de82339..bea4a37 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -983,7 +983,7 @@ static int alps_enter_command_mode(struct psmouse *psmouse,
 		return -1;
 	}
 
-	if (param[0] != 0x88 && param[1] != 0x07) {
+	if (param[0] != 0x88 || (param[1] != 0x07 && param[1] != 0x08)) {
 		psmouse_dbg(psmouse,
 			    "unknown response while entering command mode\n");
 		return -1;
-- 
1.7.10.4

