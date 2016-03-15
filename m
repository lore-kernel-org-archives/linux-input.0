From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] Input: synaptics-rmi4: Remove check of Non-NULL array
Date: Mon, 14 Mar 2016 17:35:01 -0700
Message-ID: <1458002101-4681-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:3793 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932254AbcCOAfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 20:35:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>

Originally the irq_mask member of rmi_function was a pointer. Then it was
switched to being a zero length array. However, the checks for a NULL
pointer where not removed.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index da38f0a..faa295e 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -126,7 +126,7 @@ static void process_one_interrupt(struct rmi_driver_data *data,
 		return;
 
 	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fn->irq_mask && fh->attention) {
+	if (fh->attention) {
 		bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
 				data->irq_count);
 		if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
@@ -172,8 +172,7 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	 * use irq_chip.
 	 */
 	list_for_each_entry(entry, &data->function_list, node)
-		if (entry->irq_mask)
-			process_one_interrupt(data, entry);
+		process_one_interrupt(data, entry);
 
 	if (data->input)
 		input_sync(data->input);
-- 
2.5.0

