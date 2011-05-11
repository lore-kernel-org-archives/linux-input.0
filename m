From: Steven Liu <lingjiujianke@gmail.com>
Subject: Re: [PATCH] touchscreen: check kzalloc memory for data first
Date: Wed, 11 May 2011 10:45:46 +0800
Message-ID: <BANLkTi=qDL8sQf0OkUZ1zAAUCYrgpmwD9g@mail.gmail.com>
References: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58240 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1EKCps (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 22:45:48 -0400
In-Reply-To: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jy0922.shim@samsung.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, liuqi@thunderst.com

fixed the code style


new patch is



if kzalloc memroy for data was faild, it will multi free data
memory space. so check the data memory first, is it kzalloc faild
for data, it should goto end and do nothing.

Signed-off-by: LiuQi <liuqi@thunderst.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
b/drivers/input/touchscreen/atmel_mxt_ts.c
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1039,8 +1039,14 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		return -EINVAL;

 	data = kzalloc(sizeof(struct mxt_data), GFP_KERNEL);
+	if (!data) {
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
@@ -1107,9 +1113,10 @@ err_free_irq:
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

--
