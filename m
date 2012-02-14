From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 2/2] Input: synapticss - Set buttonpad property for all clickpads
Date: Mon, 13 Feb 2012 20:21:13 -0800
Message-ID: <1329193273-12486-2-git-send-email-chase.douglas@canonical.com>
References: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40906 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775Ab2BNEVT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 23:21:19 -0500
In-Reply-To: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/input/mouse/synaptics.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 06c9ee5..f63ab8c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1221,7 +1221,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
-	}
+	} else if (SYN_CAP_CLICKPAD2BTN(priv->ext_cap_0c) ||
+		   SYN_CAP_CLICKPAD2BTN2(priv->ext_cap_0c))
+		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 }
 
 static ssize_t synaptics_show_disable_gesture(struct psmouse *psmouse,
-- 
1.7.9

