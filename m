From: Tejun Heo <tj@kernel.org>
Subject: [PATCH v2.6.36-rc7] input: cancel_delayed_work_sync() in hp680_ts_input
Date: Fri, 15 Oct 2010 14:16:09 +0200
Message-ID: <4CB84609.4080809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53672 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab0JOMQM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 08:16:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>, lkml <linux-kernel@vger.kernel.org>

Make hp680_ts_init/exit() call cancel_delayed_work_sync() instead of
calling cancel_delayed_work() followed by flush_scheduled_work().

This is to prepare for the deprecation and removal of
flush_scheduled_work().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/input/touchscreen/hp680_ts_input.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: work/drivers/input/touchscreen/hp680_ts_input.c
===================================================================
--- work.orig/drivers/input/touchscreen/hp680_ts_input.c
+++ work/drivers/input/touchscreen/hp680_ts_input.c
@@ -107,8 +107,7 @@ static int __init hp680_ts_init(void)
 	return 0;

  fail2:	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
+	cancel_delayed_work_sync(&work);
  fail1:	input_free_device(hp680_ts_dev);
 	return err;
 }
@@ -116,8 +115,7 @@ static int __init hp680_ts_init(void)
 static void __exit hp680_ts_exit(void)
 {
 	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
+	cancel_delayed_work_sync(&work);
 	input_unregister_device(hp680_ts_dev);
 }

