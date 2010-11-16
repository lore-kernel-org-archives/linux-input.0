From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 2/5] qt602240_ts: move clearing of pending interrupt closer to
	request_threaded_irq
Date: Tue, 16 Nov 2010 12:41:55 -0800
Message-ID: <20101116204155.28796.6682.stgit@localhost6.localdomain6>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42155 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab0KPUl4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:41:56 -0500
In-Reply-To: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

I've seen interrupts asserted on the CHG pin between the call to make_highcgh()
during initialization and registering the interrupt handler, leaving CHG low
and no events get passed up.

This moves the clearing of pending messages to right before the call to
request_threaded_irq().  I still think there's a race here that could leave CHG
stuck low, but worry about clearing the message queue while the interrupt
handler is registered without some sort of additional locking.

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 0b92c9d..95496ec 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -991,10 +991,6 @@ static int qt602240_initialize(struct qt602240_data *data)
 	if (error)
 		return error;
 
-	error = qt602240_make_highchg(data);
-	if (error)
-		return error;
-
 	qt602240_handle_pdata(data);
 
 	/* Backup to memory */
@@ -1280,6 +1276,10 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 	if (error)
 		goto err_free_object;
 
+	error = qt602240_make_highchg(data);
+	if (error)
+		goto err_free_object;
+
 	error = request_threaded_irq(client->irq, NULL, qt602240_interrupt,
 			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
 	if (error) {

