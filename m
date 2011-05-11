From: Steven Liu <lingjiujianke@gmail.com>
Subject: [PATCH] touchscreen: check kzalloc memory for data first
Date: Wed, 11 May 2011 10:23:16 +0800
Message-ID: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59603 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab1EKCXS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 22:23:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jy0922.shim@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, liuqi@thunderst.com

Hi Joonyoung Shim ,

            Can this patch be fixed in?


if kzalloc memroy for data was faild, it will multi free data
memory space. so check the data memory first, is it kzalloc faild
for data, it should goto end and do nothing.

Signed-off-by: LiuQi <lingjiujianke@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
b/drivers/input/touchscreen/atmel_mxt_ts.c
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1039,8 +1039,15 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		return -EINVAL;

 	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
+
+	if(!data){
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		error = -ENOMEM;
+		goto err_alloc_data_mem_faild;
+	}
+
 	input_dev = input_allocate_device();
-	if (!data || !input_dev) {
+	if (!input_dev) {
 		dev_err(&client->dev, "Failed to allocate memory\n");
 		error = -ENOMEM;
 		goto err_free_mem;
@@ -1107,9 +1114,10 @@ err_free_irq:
 	free_irq(client->irq, data);
 err_free_object:
 	kfree(data->object_table);
-err_free_mem:
 	input_free_device(input_dev);
+err_free_mem:
 	kfree(data);
+err_alloc_data_mem_faild:
 	return error;
 }







Best Regards

Steven Liu
