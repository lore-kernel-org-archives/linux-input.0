From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH V2] input synaptics-rmi4: Fix ms calculation in poll interval
Date: Thu, 5 Dec 2013 16:13:45 -0800
Message-ID: <1386288825-11837-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:32292 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab3LFANx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Dec 2013 19:13:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

[Previous patch re-used an old template for the subject line.  Sorry about that]

This patch implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patch is commit
8ca01dc61a42b6f7bcba052a8c084000f7057a34.

Fix computation of poll interval milliseconds.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joerie de Gram <j.de.gram@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 9af297e..dffbfa0 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -934,7 +934,7 @@ static int rmi_driver_probe(struct device *dev)
 	} else
 		data->poll_interval = ktime_set(0,
 			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
-			DEFAULT_POLL_INTERVAL_MS) * 1000);
+			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
 
 	if (data->f01_container->dev.driver) {
 		/* Driver already bound, so enable ATTN now. */
