From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Correctly configure RMI4 functions during initialization
Date: Tue, 18 Mar 2014 17:21:09 -0700
Message-ID: <1395188469-2257-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:33088 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaCSAVn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 20:21:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Courtney Cavin <courtney.cavin@sonymobile.com>

Fix a bug where an RMI4 function handler's config() routine
was not be called during rmi_function_probe().

Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>

---

 drivers/input/rmi4/rmi_bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 6e0454a..2ed0d32 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -212,7 +212,14 @@ static int rmi_function_probe(struct device *dev)
 
 	if (handler->probe) {
 		error = handler->probe(fn);
-		return error;
+		if (error)
+			return error;
+	}
+	if (handler->config) {
+		error = handler->config(fn);
+		if (error)
+			dev_warn(dev, "WARNING: Config for F%02x failed with code %d.\n",
+				 handler->func, error);
 	}
 
 	return 0;
