From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: rmi_f01.c storage fix
Date: Tue, 11 Feb 2014 15:13:00 -0800
Message-ID: <1392160380-8221-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16052 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaBKXNF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 18:13:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Correctly free driver related data when initialization fails.

Trivial: Clarify a diagnostic message.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_f01.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 381ad60..e4a6df9 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -149,7 +149,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
 
 	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
 	if (!f01) {
-		dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
+		dev_err(&fn->dev, "Failed to allocate f01_data.\n");
 		return -ENOMEM;
 	}
 
@@ -158,6 +158,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
 			GFP_KERNEL);
 	if (!f01->device_control.interrupt_enable) {
 		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
+		devm_kfree(&fn->dev, f01);
 		return -ENOMEM;
 	}
 	fn->data = f01;
@@ -381,7 +382,8 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	return 0;
 
  error_exit:
-	kfree(data);
+	devm_kfree(&fn->dev, data->device_control.interrupt_enable);
+	devm_kfree(&fn->dev, data);
 	return error;
 }
 
