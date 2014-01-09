From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf in rmi_i2c.c
Date: Wed, 8 Jan 2014 17:18:39 -0800
Message-ID: <1389230319-4737-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:21073 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAIBSs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 20:18:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This is a trivial change to replace the sprintf loop with snprintf using
up-to-date format capability.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_i2c.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index d94114b..8a93dad 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -138,9 +138,6 @@ static int rmi_set_page(struct rmi_transport_dev *xport, u8 page)
 
 static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
 			     const u8 *buf, const int len) {
-	int i;
-	int n = 0;
-	char *temp;
 	int dbg_size = 3 * len + 1;
 
 	if (!data->debug_buf || data->debug_buf_size < dbg_size) {
@@ -154,12 +151,8 @@ static int copy_to_debug_buf(struct device *dev, struct rmi_i2c_data *data,
 			return -ENOMEM;
 		}
 	}
-	temp = data->debug_buf;
 
-	for (i = 0; i < len; i++) {
-		n = sprintf(temp, " %02x", buf[i]);
-		temp += n;
-	}
+	snprintf(data->debug_buf, data->debug_buf_size, "%*ph", len, buf);
 
 	return 0;
 }
