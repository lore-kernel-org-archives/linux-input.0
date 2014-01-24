From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 03/15] Input: synaptics-rmi4 - don't free devices directly
Date: Thu, 23 Jan 2014 16:00:11 -0800
Message-ID: <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19745 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbaAWX7Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 18:59:24 -0500
In-Reply-To: <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Devices use a kobject to manage references, do not delete the memory
while still referenced.  Instead, call put_device() to release the
reference.

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_bus.c    | 8 +++++---
 drivers/input/rmi4/rmi_driver.c | 6 +-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 8a939f3..cd7bfbd 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -94,8 +94,7 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 		return -EINVAL;
 	}
 
-	rmi_dev = devm_kzalloc(xport->dev,
-				sizeof(struct rmi_device), GFP_KERNEL);
+	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
 	if (!rmi_dev)
 		return -ENOMEM;
 
@@ -112,8 +111,10 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 	rmi_physical_setup_debugfs(rmi_dev);
 
 	error = device_register(&rmi_dev->dev);
-	if (error)
+	if (error) {
+		put_device(&rmi_dev->dev);
 		return error;
+	}
 
 	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
 		pdata->sensor_name, dev_name(&rmi_dev->dev));
@@ -240,6 +241,7 @@ int rmi_register_function(struct rmi_function *fn)
 		dev_err(&rmi_dev->dev,
 			"Failed device_register function device %s\n",
 			dev_name(&fn->dev));
+		put_device(&fn->dev);
 		goto error_exit;
 	}
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5c6379c..4965589 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -557,15 +557,11 @@ static int create_function(struct rmi_device *rmi_dev,
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_free_mem;
+		return error;
 
 	list_add_tail(&fn->node, &data->function_list);
 
 	return 0;
-
-err_free_mem:
-	kfree(fn);
-	return error;
 }
 
 /*
-- 
1.8.1.5

