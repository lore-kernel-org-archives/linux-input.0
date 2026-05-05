Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B33CCFA8
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957217; cv=none; b=t5MKDISYZey2fG5uP7zjgmgr8NaOxBNN4EviORnDDlE5GnLQOmsuLHSzDaB+KVZotjqdMMBzai1sdjWvpTW6K2wPHJgffQjjuHs5DzDR1KSqXnV4+J+Yefj+8sVh+UYlLE5KzOxBvVXABvC2nwI96uPA5eFP1FDE3MU10mxZcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957217; c=relaxed/simple;
	bh=sX7LI9cJsDgaVno54OstmKI9vx15QEujZXCD0CAXJ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpvlD9yajt9TBkZyhoqHIrkgHLHY0GGL4z8it0y14yRTb9EOsco8YfGriWoMCM3O+m7afdlc2cBkL9BaWKHRJwGmmLwwAM5AYajtzB8DBoqC3RfzZIGpbOfpnga7nY2zxmqCtQPDvjaeR5J6PhCAo+jJwVUhEOPKg3XAaP/xkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1ySq1T7; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1ySq1T7"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1309f4ee97fso1291444c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957214; x=1778562014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kKhA5i6t85r7bsw25QU/4JDOTnDB8uAmTRJmc8QB64=;
        b=p1ySq1T7MgyGxh/o+gGUD7DhWvo8hnDNtq3jUJ1I5NQwz3ojmuK7LNkEF3DhxVUxn9
         nIuEVA8/3TtBapO6RGDXbQ2r+3Aw5RgwxW61NRwriTaC4UAOYkJ1xyCAk6kVgqlvc2d8
         AWumjBBtbsDLl86j50u0m+8Uclfe5c6dien16nR7t8bJ/1GZ6tUvIbAMa1eQCIu5FaK2
         gkPmzFkLh2G5XJdIl1yblnYKvPYVpj4hvweiReKuZqfxuatPfe9Nn7Sxz1VmHVccsiFW
         75qm/xYuFZMA8FiD5Gf4T4D3F0VOaeBUeCw5Ls78ajTUZzigIlROcLDVAbc+BQ8nr8G9
         zJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957214; x=1778562014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kKhA5i6t85r7bsw25QU/4JDOTnDB8uAmTRJmc8QB64=;
        b=WGgyrPIhYe04CQFaixq/NsxNDfdJl9TUpZi9aDaodeP07TV32H+JuvdrcyPFHVAGCi
         9YCIRNuz40r4WdkJkOU+ApRfVhmODmxp07pSgQUQlIQxJ8+BtjYyJ2Mf9towTy+CB2f3
         l1O2t7UYxEZyQLmtPVj7VOIOJotl3h6C9p/rvZOCVYxn3wvvQO1E5qTIGsbwDK83YKDo
         G+XhqdVtkpGU95WNM0j7izUJvTOc1q02R2aN3M/Gv/W6jJ8gAXJh+kcWjJ03sXM9NV03
         ZXT5FbuzhCcO5oUO9bDzlOB3nVK7PiUlz7UHcEq555UDb/fMqFS2YV+BfiLtCMbAF0H1
         X+pg==
X-Gm-Message-State: AOJu0YxYdQGB+/zjgPiXUvvNv4y11yb5ctDvUX8RKeosRizG4tlLQ18T
	LDSQkOOpnbOFPmIkzN9jNj84i+SmkF8M5dz7bth6XWJ26UaeYyRIEzODXqjbkg==
X-Gm-Gg: AeBDiesPE3HOfDy48Z1nwtc01iwmrrxxNMVuhuRhcAyycycGQfnQGpDFJSQq7w3CWvo
	GCVnOw5D3avSPhCE6YTlg1OjCb99JCSH/TyxHoqy4nhPLMYSE/232QpftqXvyyEiC6P8szbsyoE
	V0c9ViyBzJ+d3Q05frIzrln3gaCYxIAn002/CLPu6ypl2pafFePY8wZOGjhvuqmc5Ut90K5tAPo
	x3g6DeDKmkBF6xZ0L6p1TaSMyoFv7dDJHKYDQp6s8wXjYJ6fSUOYhb/jGP7Dqcn/DxeoLkaOnyW
	bXKaQjsJQ3pHhvANI0TckRbRgA0G/7vJMvV+0+LHaWcXwMaMbWi+EohpQqu7ISlkAmpJe1Ub4/H
	5bwxMiGZfFn/DwzM5Y+b5EwRCjCz7vJ8atjMy2HMI2Bj8RNuRp3ijMD+LhKFKj0c8uTJLx5uCGG
	m+dw+l4niBTKp3wkm/XuhxDva8DwTyK1k8mJxRe0lm/nxHhcmWbU655lI/JFCaIOThkbZnU1BVx
	7vkRrReoToxKI3PEccM7H0uPw==
X-Received: by 2002:a05:7022:e994:b0:122:3a5:fc42 with SMTP id a92af1059eb24-12dfd81a4b8mr6180171c88.20.1777957214280;
        Mon, 04 May 2026 22:00:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/20] Input: rmi4 - refactor function allocation and registration
Date: Mon,  4 May 2026 21:59:40 -0700
Message-ID: <20260505045952.1570713-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rmi_create_function() allocates memory for the rmi_function
structure, but rmi_register_function() initializes the device via
device_initialize(). This split of ownership makes error handling in
rmi_create_function() confusing because the caller must be aware that
if rmi_register_function() fails, it has already called put_device() to
clean up the memory.

To make the memory lifecycle explicit and fix potential leaks cleanly
introduce rmi_alloc_function() to handle memory allocation and device
initialization, and make the caller of rmi_register_function()
responsible for cleanup.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_bus.c    | 32 +++++++++++++++++++++-----------
 drivers/input/rmi4/rmi_bus.h    |  1 +
 drivers/input/rmi4/rmi_driver.c | 10 ++++------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 687cb987bc13..71a25df73984 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -237,36 +237,46 @@ static int rmi_function_remove(struct device *dev)
 	return 0;
 }
 
-int rmi_register_function(struct rmi_function *fn)
+struct rmi_function *rmi_alloc_function(struct rmi_device *rmi_dev, u8 id)
 {
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	int error;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_function *fn;
+
+	fn = kzalloc(sizeof(*fn) +
+			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
+		     GFP_KERNEL);
+	if (!fn)
+		return NULL;
 
 	device_initialize(&fn->dev);
 
-	dev_set_name(&fn->dev, "%s.fn%02x",
-		     dev_name(&rmi_dev->dev), fn->fd.function_number);
+	dev_set_name(&fn->dev, "%s.fn%02x", dev_name(&rmi_dev->dev), id);
 
 	fn->dev.parent = &rmi_dev->dev;
 	fn->dev.type = &rmi_function_type;
 	fn->dev.bus = &rmi_bus_type;
+	fn->rmi_dev = rmi_dev;
+
+	return fn;
+}
+
+int rmi_register_function(struct rmi_function *fn)
+{
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	int error;
 
 	error = device_add(&fn->dev);
 	if (error) {
 		dev_err(&rmi_dev->dev,
-			"Failed device_register function device %s\n",
+			"Failed to register function device %s\n",
 			dev_name(&fn->dev));
-		goto err_put_device;
+		return error;
 	}
 
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Registered F%02X.\n",
 			fn->fd.function_number);
 
 	return 0;
-
-err_put_device:
-	put_device(&fn->dev);
-	return error;
 }
 
 void rmi_unregister_function(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index d4d0d82c69aa..90122df21f74 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -49,6 +49,7 @@ struct rmi_function {
 
 bool rmi_is_function_device(struct device *dev);
 
+struct rmi_function *rmi_alloc_function(struct rmi_device *rmi_dev, u8 id);
 int __must_check rmi_register_function(struct rmi_function *);
 void rmi_unregister_function(struct rmi_function *);
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 6755dd66d62f..aae4a9bb76fb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -872,9 +872,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	rmi_dbg(RMI_DEBUG_CORE, dev, "Initializing F%02X.\n",
 			pdt->function_number);
 
-	fn = kzalloc(sizeof(struct rmi_function) +
-			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
-		     GFP_KERNEL);
+	fn = rmi_alloc_function(rmi_dev, pdt->function_number);
 	if (!fn) {
 		dev_err(dev, "Failed to allocate memory for F%02X\n",
 			pdt->function_number);
@@ -884,8 +882,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	INIT_LIST_HEAD(&fn->node);
 	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
 
-	fn->rmi_dev = rmi_dev;
-
 	fn->num_of_irqs = pdt->interrupt_source_count;
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
@@ -894,8 +890,10 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
 	error = rmi_register_function(fn);
-	if (error)
+	if (error) {
+		put_device(&fn->dev);
 		return error;
+	}
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
-- 
2.54.0.545.g6539524ca2-goog

