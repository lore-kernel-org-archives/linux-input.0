From: "Brian K. Turner" <turnerbk84@gmail.com>
Subject: [PATCH] Input: mouse: lifebook: Fixed tabbing issue.
Date: Thu, 19 Mar 2015 16:37:27 -1000
Message-ID: <1426819047-7518-1-git-send-email-turnerbk84@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36288 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbCTChg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 22:37:36 -0400
Received: by padcy3 with SMTP id cy3so93926162pad.3
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 19:37:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "Brian K. Turner" <turnerbk84@gmail.com>

Fixed a style issue where spaces where used instead of tabs.

Signed-off-by: Brian K. Turner <turnerbk84@gmail.com>
---
 drivers/input/mouse/lifebook.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 23222dd..e5ed216 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -256,8 +256,8 @@ static void lifebook_disconnect(struct psmouse *psmouse)
 
 int lifebook_detect(struct psmouse *psmouse, bool set_properties)
 {
-        if (!lifebook_present)
-                return -1;
+	if (!lifebook_present)
+		return -1;
 
 	if (desired_serio_phys &&
 	    strcmp(psmouse->ps2dev.serio->phys, desired_serio_phys))
@@ -268,7 +268,7 @@ int lifebook_detect(struct psmouse *psmouse, bool set_properties)
 		psmouse->name = "Lifebook TouchScreen";
 	}
 
-        return 0;
+	return 0;
 }
 
 static int lifebook_create_relative_device(struct psmouse *psmouse)
-- 
2.3.3

