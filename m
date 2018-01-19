From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: synaptics_rmi4 - do not delete interrupt memory too early
Date: Thu, 18 Jan 2018 16:49:53 -0800
Message-ID: <20180119004955.247190-2-dmitry.torokhov@gmail.com>
References: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36347 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeASAuA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 19:50:00 -0500
In-Reply-To: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org

We want to free memory reserved for interrupt mask handling only after we
free functions, as function drivers might want to mask interrupts. This is
needed for the followup patch to the F03 that would implement unmasking and
masking interrupts from the serio pass-through port open() and close()
methods.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 27791d6546c66..ce3ede289ed04 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -41,6 +41,13 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
 
+	/* Doing it in the reverse order so F01 will be removed last */
+	list_for_each_entry_safe_reverse(fn, tmp,
+					 &data->function_list, node) {
+		list_del(&fn->node);
+		rmi_unregister_function(fn);
+	}
+
 	devm_kfree(&rmi_dev->dev, data->irq_memory);
 	data->irq_memory = NULL;
 	data->irq_status = NULL;
@@ -50,13 +57,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 
 	data->f01_container = NULL;
 	data->f34_container = NULL;
-
-	/* Doing it in the reverse order so F01 will be removed last */
-	list_for_each_entry_safe_reverse(fn, tmp,
-					 &data->function_list, node) {
-		list_del(&fn->node);
-		rmi_unregister_function(fn);
-	}
 }
 
 static int reset_one_function(struct rmi_function *fn)
-- 
2.16.0.rc1.238.g530d649a79-goog

