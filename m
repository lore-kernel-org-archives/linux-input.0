From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 14/15] Input: synaptics-rmi4 - ensure we have IRQs before reading status
Date: Thu, 23 Jan 2014 16:00:22 -0800
Message-ID: <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19874 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755578AbaAXAAH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 19:00:07 -0500
In-Reply-To: <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_f01.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 22b57f2..06fc5bc 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -318,13 +318,15 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	ctrl_base_addr += sizeof(u8);
 
 	data->interrupt_enable_addr = ctrl_base_addr;
-	error = rmi_read_block(rmi_dev, ctrl_base_addr,
-				data->device_control.interrupt_enable,
-				sizeof(u8) * (data->num_of_irq_regs));
-	if (error < 0) {
-		dev_err(&fn->dev,
-			"Failed to read F01 control interrupt enable register.\n");
-		goto error_exit;
+	if (data->num_of_irq_regs > 0) {
+		error = rmi_read_block(rmi_dev, ctrl_base_addr,
+					data->device_control.interrupt_enable,
+					sizeof(u8) * (data->num_of_irq_regs));
+		if (error < 0) {
+			dev_err(&fn->dev,
+				"Failed to read F01 control interrupt enable register.\n");
+			goto error_exit;
+		}
 	}
 
 	ctrl_base_addr += data->num_of_irq_regs;
-- 
1.8.1.5

