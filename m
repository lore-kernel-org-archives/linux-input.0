Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4833CEB9C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586569; cv=none; b=iS/QM6/L6JkQgIKnLYyVxSwLDSsY6IURYQCGsZtMUxbDLd6s6Kg6V7if4L2P0RW8I4fKriE6xNUwPw38za6euHQUdJg6ywAuvZkFE6qmUq9TQRpngL0fnV+FT5lG3s/RnWSMPGzb/lD5t5kSTcHkUxRoI5irJ1DlqNGHOoSMlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586569; c=relaxed/simple;
	bh=vKnaNMdhS8YtCnB88lrk3HZWNdfZpLbn4uC3MdzWMEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogIzrtGyHGe+vlCNJX9zS16fbY3TcBkRTGFYl7SfVRI2HcAMdxOY3FR+xgnBED4t99So78YcGnq6c3NU7z6Tdf5+UqlMTizP3UU4rzdXdyPimnQ3w0xTp1IWxsQ/YEZ5s0k34TGZ7oT9YJdhdpEEUj7n4bnI/64hHmVENhR+2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eou+wcBQ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eou+wcBQ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-307d0405e07so6255293eec.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586563; x=1782191363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tju79JaSAX+VOqY7AQfdPOSZXpM4x/1eAERC2kjOw2o=;
        b=Eou+wcBQlED+oVI7ekL0lsyxTIFwuzucnlcUwt5NVB32/eo8em+M2EVr8wlZrf4ruh
         hEBUCGQOHmbADGC2wqqIFRxQwnT69JO7RzXInQYToJ980WRDPzn7p2LlzeVnoi/iX5kt
         CjYlUDx1kEn4Iu+HNc6gei7z7jCXiGmPlj6xNkXRIfK9WxcOkQwh61TnT1XDAl3Joyhq
         nHAuDkr8Lp4eal4wfLE9mDG55JvS627scQiVYUiVOOqjLOQvq9p+eUZWZy+viG8HrCp1
         PM5Vqh+gZZlFdfGvF8zL5Pvlxh6KK/aIMH2gsC8tlZyf1nHDz1VgcI8iGd1gAYTJtX/0
         XUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586563; x=1782191363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tju79JaSAX+VOqY7AQfdPOSZXpM4x/1eAERC2kjOw2o=;
        b=pferc1nZrVgu5aW+wK+594D7M8KlgSwNzIZWfKK2xu9rJ80B37/ubqK++hZUhC6sog
         fnwt0zS+98XQTjhktR916BmVmYomkrdRK7BvLCaQs7O+HqnBGoN6Mm+wWaL4TOe3I79N
         CgIi5itvVi6PKMLf8AtEu8uT+JJycWgWeNIq4C/jPtdqX+U0c6IYnlhwdlX1gsuTsIep
         Z3gIQfGAcJayPfg13INUwSBQyq9iOXDUrpUl8t1aXdgqgMjciH9UmXstFuw05P0UKo23
         n+uKKVWn0xlNGlcbmLus1vIsyI8THTSf5agNfIYJ12wcNbKI2/UkXP6wL2gYRDgvlpr2
         tkQw==
X-Gm-Message-State: AOJu0YxF4/Ait127W1t3Y+q1q8V2fsQRGpYvFl73fUvOrvNCpLTQ72tX
	cnwBPye5a2YabbjhC1e5nuPrMT6+KXP2J6ahANe69v3m60uQUR+JWNVV6JHSkw==
X-Gm-Gg: Acq92OF0lUoiaDmPaXUjNwAQzWEyBmbkWQayrg+J6z/J+7oGJqKcZwlutZIVvKEo9Pr
	/G/IUYr3RYTyMxiDiHeW72RK5nE5dzw581D4aT2HQ9lz3MSxpdmBfqN2Rzoi1YKZ1e++1N54xje
	mYKIv4KzkNGJmRXaXpOLqmUREB+pX1gUXCKvqn+9VoLM7XM8okUoSwpYJo+lgp4tdwPqf9GriNX
	s+wUdVt+PoP2F+w9uf0jkhZZAWA0dFkdFPeevBRJQNrYtew1EAwaZpvQB6Ex7OTxbax9cL+pJLo
	4eWkxNjZXMtrVuudDLWeNoiJ4QTXIqnTsDYX0e5Brj8rWh22JI0BpzvZuqDVWyaxkx27DGwliln
	CohBgUe4P81+abkZxsrB1zvvh57fwaV8/8Y615yh1pkP47JaZYaSUavQW9z8PmEIFo/oVF2yORE
	kwLWdSuww1sLIgKChKEW2K+jLYGqATExRxn6jcq7Z4dyWY08y2gMWmeLBruBj35tUsayWQUDvc3
	QR9nQLla1636nI=
X-Received: by 2002:a05:7300:730c:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-30935239ec2mr7817919eec.3.1781586562639;
        Mon, 15 Jun 2026 22:09:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] Input: mms114 - refactor chip variant handling using descriptors
Date: Mon, 15 Jun 2026 22:09:11 -0700
Message-ID: <20260616050912.1531241-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using an enum and conditional switch/if statements throughout
the driver to handle differences between chip variants (MMS114, MMS134S,
MMS136, MMS152, MMS345L), introduce a variant-specific descriptor
structure that encapsulates variant-specific properties (name, event
size, presence of configuration registers) and callbacks (such as
get_version). Define descriptors for each supported chip and associate
them with the matching entries in the OF and I2C device ID tables.

This eliminates the need for variant checks in the driver logic, making
it easier to support new chip variants in the future.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 204 ++++++++++++++++-------------
 1 file changed, 112 insertions(+), 92 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index bf01eee0560a..006dded17eb8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -52,21 +52,13 @@
 #define MMS114_TYPE_TOUCHSCREEN		1
 #define MMS114_TYPE_TOUCHKEY		2
 
-enum mms_type {
-	TYPE_MMS114	= 114,
-	TYPE_MMS134S	= 134,
-	TYPE_MMS136	= 136,
-	TYPE_MMS152	= 152,
-	TYPE_MMS345L	= 345,
-};
-
 struct mms114_data {
+	const struct mms_chip	*chip;
 	struct i2c_client	*client;
 	struct input_dev	*input_dev;
 	struct regulator	*core_reg;
 	struct regulator	*io_reg;
 	struct touchscreen_properties props;
-	enum mms_type		type;
 	unsigned int		contact_threshold;
 	unsigned int		moving_threshold;
 
@@ -77,6 +69,13 @@ struct mms114_data {
 	u8			cache_mode_control;
 };
 
+struct mms_chip {
+	const char *name;
+	int event_size;
+	bool has_config_regs;
+	int (*get_version)(struct mms114_data *data);
+};
+
 struct mms114_touch {
 	u8 id:4, reserved_bit4:1, type:2, pressed:1;
 	u8 x_hi:4, y_hi:4;
@@ -156,6 +155,91 @@ static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
 	return 0;
 }
 
+static int mms114_get_version(struct mms114_data *data)
+{
+	struct device *dev = &data->client->dev;
+	u8 buf[6];
+	int error;
+
+	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
+	if (error)
+		return error;
+
+	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
+		 buf[0], buf[1], buf[3]);
+	return 0;
+}
+
+static int mms152_get_version(struct mms114_data *data)
+{
+	struct device *dev = &data->client->dev;
+	u8 buf[3];
+	int group;
+	int error;
+
+	error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+	if (error)
+		return error;
+
+	group = i2c_smbus_read_byte_data(data->client, MMS152_COMPAT_GROUP);
+	if (group < 0)
+		return group;
+
+	dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
+		 buf[0], buf[1], buf[2], group);
+	return 0;
+}
+
+static int mms345l_get_version(struct mms114_data *data)
+{
+	struct device *dev = &data->client->dev;
+	u8 buf[3];
+	int error;
+
+	error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+	if (error)
+		return error;
+
+	dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x\n",
+		 buf[0], buf[1], buf[2]);
+	return 0;
+}
+
+static const struct mms_chip mms114_descriptor = {
+	.name = "MMS114",
+	.event_size = MMS114_EVENT_SIZE,
+	.has_config_regs = true,
+	.get_version = mms114_get_version,
+};
+
+static const struct mms_chip mms134s_descriptor = {
+	.name = "MMS134S",
+	.event_size = MMS136_EVENT_SIZE,
+	.has_config_regs = true,
+	.get_version = mms114_get_version,
+};
+
+static const struct mms_chip mms136_descriptor = {
+	.name = "MMS136",
+	.event_size = MMS136_EVENT_SIZE,
+	.has_config_regs = true,
+	.get_version = mms114_get_version,
+};
+
+static const struct mms_chip mms152_descriptor = {
+	.name = "MMS152",
+	.event_size = MMS114_EVENT_SIZE,
+	.has_config_regs = false,
+	.get_version = mms152_get_version,
+};
+
+static const struct mms_chip mms345l_descriptor = {
+	.name = "MMS345L",
+	.event_size = MMS114_EVENT_SIZE,
+	.has_config_regs = false,
+	.get_version = mms345l_get_version,
+};
+
 static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
 {
 	struct i2c_client *client = data->client;
@@ -217,8 +301,8 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct i2c_client *client = data->client;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
 	struct mms114_touch *t;
+	int event_size = data->chip->event_size;
 	int packet_size;
-	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -233,12 +317,6 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	/* MMS136 has slightly different event size */
-	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		event_size = MMS136_EVENT_SIZE;
-	else
-		event_size = MMS114_EVENT_SIZE;
-
 	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size, touch);
@@ -288,64 +366,17 @@ static int mms114_set_active(struct mms114_data *data, bool active)
 	return mms114_write_reg(data, MMS114_MODE_CONTROL, val);
 }
 
-static int mms114_get_version(struct mms114_data *data)
-{
-	struct device *dev = &data->client->dev;
-	u8 buf[6];
-	int group;
-	int error;
-
-	switch (data->type) {
-	case TYPE_MMS345L:
-		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
-		if (error)
-			return error;
-
-		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x\n",
-			 buf[0], buf[1], buf[2]);
-		break;
-
-	case TYPE_MMS152:
-		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
-		if (error)
-			return error;
-
-		group = i2c_smbus_read_byte_data(data->client, MMS152_COMPAT_GROUP);
-		if (group < 0)
-			return group;
-
-		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
-			 buf[0], buf[1], buf[2], group);
-		break;
-
-	case TYPE_MMS114:
-	case TYPE_MMS134S:
-	case TYPE_MMS136:
-		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
-		if (error)
-			return error;
-
-		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
-			 buf[0], buf[1], buf[3]);
-		break;
-	}
-
-	return 0;
-}
-
 static int mms114_setup_regs(struct mms114_data *data)
 {
 	const struct touchscreen_properties *props = &data->props;
 	int val;
 	int error;
 
-	error = mms114_get_version(data);
-	if (error < 0)
+	error = data->chip->get_version(data);
+	if (error)
 		return error;
 
-	/* MMS114, MMS134S and MMS136 have configuration and power on registers */
-	if (data->type != TYPE_MMS114 && data->type != TYPE_MMS134S &&
-	    data->type != TYPE_MMS136)
+	if (!data->chip->has_config_regs)
 		return 0;
 
 	error = mms114_set_active(data, true);
@@ -481,7 +512,6 @@ static int mms114_probe(struct i2c_client *client)
 {
 	struct mms114_data *data;
 	struct input_dev *input_dev;
-	const void *match_data;
 	int error;
 	int i;
 
@@ -501,12 +531,10 @@ static int mms114_probe(struct i2c_client *client)
 	data->client = client;
 	data->input_dev = input_dev;
 
-	match_data = device_get_match_data(&client->dev);
-	if (!match_data)
+	data->chip = i2c_get_match_data(client);
+	if (!data->chip)
 		return -EINVAL;
 
-	data->type = (enum mms_type)match_data;
-
 	data->num_keycodes = device_property_count_u32(&client->dev,
 						       "linux,keycodes");
 	if (data->num_keycodes == -EINVAL) {
@@ -563,8 +591,7 @@ static int mms114_probe(struct i2c_client *client)
 				     0, data->props.max_y, 0, 0);
 	}
 
-	if (data->type == TYPE_MMS114 || data->type == TYPE_MMS134S ||
-	    data->type == TYPE_MMS136) {
+	if (data->chip->has_config_regs) {
 		/*
 		 * The firmware handles movement and pressure fuzz, so
 		 * don't duplicate that in software.
@@ -579,8 +606,8 @@ static int mms114_probe(struct i2c_client *client)
 	}
 
 	input_dev->name = devm_kasprintf(&client->dev, GFP_KERNEL,
-					 "MELFAS MMS%d Touchscreen",
-					 data->type);
+					 "MELFAS %s Touchscreen",
+					 data->chip->name);
 	if (!input_dev->name)
 		return -ENOMEM;
 
@@ -676,29 +703,22 @@ static int mms114_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mms114_pm_ops, mms114_suspend, mms114_resume);
 
 static const struct i2c_device_id mms114_id[] = {
-	{ .name = "mms114" },
+	{ .name = "mms114", .driver_data = (kernel_ulong_t)&mms114_descriptor },
+	{ .name = "mms134s", .driver_data = (kernel_ulong_t)&mms134s_descriptor },
+	{ .name = "mms136", .driver_data = (kernel_ulong_t)&mms136_descriptor },
+	{ .name = "mms152", .driver_data = (kernel_ulong_t)&mms152_descriptor },
+	{ .name = "mms345l", .driver_data = (kernel_ulong_t)&mms345l_descriptor },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mms114_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id mms114_dt_match[] = {
-	{
-		.compatible = "melfas,mms114",
-		.data = (void *)TYPE_MMS114,
-	}, {
-		.compatible = "melfas,mms134s",
-		.data = (void *)TYPE_MMS134S,
-	}, {
-		.compatible = "melfas,mms136",
-		.data = (void *)TYPE_MMS136,
-	}, {
-		.compatible = "melfas,mms152",
-		.data = (void *)TYPE_MMS152,
-	}, {
-		.compatible = "melfas,mms345l",
-		.data = (void *)TYPE_MMS345L,
-	},
+	{ .compatible = "melfas,mms114", .data = &mms114_descriptor },
+	{ .compatible = "melfas,mms134s", .data = &mms134s_descriptor },
+	{ .compatible = "melfas,mms136", .data = &mms136_descriptor },
+	{ .compatible = "melfas,mms152", .data = &mms152_descriptor },
+	{ .compatible = "melfas,mms345l", .data = &mms345l_descriptor },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mms114_dt_match);
-- 
2.54.0.1136.gdb2ca164c4-goog

