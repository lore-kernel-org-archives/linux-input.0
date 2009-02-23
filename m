From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] psmouse: add newline to OLPC HGPK touchpad debugging
Date: Mon, 23 Feb 2009 18:16:43 +0000
Message-ID: <1235413003-5286-1-git-send-email-apw@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53609 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbZBWSQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2009 13:16:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Matt Zimmerman <mdz@canonical.com>, Andy Whitcroft <apw@canonical.com>

When probing for the OLPC HGPK touchpad the ID of the probed touchpad is
emitted, but the debug is missing the terminating newline.  This causes
later information to run into it, and for that to be categorised
incorrectly at KERN_DBG.  Fix this up.

Reported-by: Matt Zimmerman <mdz@canonical.com>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/input/mouse/hgpk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 81e6ebf..a14a6b0 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -472,7 +472,7 @@ static enum hgpk_model_t hgpk_get_model(struct psmouse *psmouse)
 		return -EIO;
 	}
 
-	hgpk_dbg(psmouse, "ID: %02x %02x %02x", param[0], param[1], param[2]);
+	hgpk_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], param[1], param[2]);
 
 	/* HGPK signature: 0x67, 0x00, 0x<model> */
 	if (param[0] != 0x67 || param[1] != 0x00)
-- 
1.6.1.2.419.g0d87e

