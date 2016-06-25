From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 1/8] Input: synaptics-rmi4: Increment the refcount of the transport dev's of_node
Date: Fri, 24 Jun 2016 17:17:57 -0700
Message-ID: <1466813877-15737-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:31305 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbcFYASL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 20:18:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Increment the refcount for the transport device's of_node before calling
of_find_node_by_name(). Since of_find_node_by_name() assumes the refcount
was incremented by the caller and calls of_node_put() when it is done.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index b368b05..55b5336 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -157,11 +157,12 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
 static void rmi_function_of_probe(struct rmi_function *fn)
 {
 	char of_name[9];
+	struct device_node *node = fn->rmi_dev->xport->dev->of_node;
 
 	snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
 		fn->fd.function_number);
-	fn->dev.of_node = of_find_node_by_name(
-				fn->rmi_dev->xport->dev->of_node, of_name);
+	of_node_get(node);
+	fn->dev.of_node = of_find_node_by_name(node, of_name);
 }
 #else
 static inline void rmi_function_of_probe(struct rmi_function *fn)
-- 
2.5.0

