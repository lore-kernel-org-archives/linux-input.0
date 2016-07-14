From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v3 1/8] Input: synaptics-rmi4: Use of_get_child_by_name() instead of of_find_node_by_name()
Date: Wed, 13 Jul 2016 23:08:08 -0700
Message-ID: <1468476488-7935-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:43987 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcGNGIS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 02:08:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>

Calling of_find_node_by_name() assumes that the caller has incremented
the refcount of the of_node being passed in. Currently, the caller is
not incrementing the refcount of the of_node which results in the node
being prematurely freed when of_find_node_by_name() calls of_node_put()
on it. Instead use of_get_child_by_name() which does not call put on the
of_node.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index b368b05..253df96 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -157,11 +157,11 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
 static void rmi_function_of_probe(struct rmi_function *fn)
 {
 	char of_name[9];
+	struct device_node *node = fn->rmi_dev->xport->dev->of_node;
 
 	snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
 		fn->fd.function_number);
-	fn->dev.of_node = of_find_node_by_name(
-				fn->rmi_dev->xport->dev->of_node, of_name);
+	fn->dev.of_node = of_get_child_by_name(node, of_name);
 }
 #else
 static inline void rmi_function_of_probe(struct rmi_function *fn)
-- 
2.5.0

