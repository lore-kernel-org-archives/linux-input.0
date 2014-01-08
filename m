From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input: synaptics-rmi4 - use snprintf instead of sprintf in rmi_i2c.c
Date: Wed, 8 Jan 2014 13:37:55 -0800
Message-ID: <1389217075-28551-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:30736 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757798AbaAHViA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 16:38:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This is a trivial change to use snprintf rather than sprintf while building
the diagnostic output buffer.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index b33074c..43b0e53 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -157,7 +157,7 @@ static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
 	temp = data->debug_buf;
 
 	for (i = 0; i < len; i++) {
-		n = sprintf(temp, " %02x", buf[i]);
+		n = snprintf(temp, 3, " %02x", buf[i]);
 		temp += n;
 	}
 
