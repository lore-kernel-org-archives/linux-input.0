Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723A288C81
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246123; cv=none; b=BSxXCNYL54l2F3XNftqNrJrjVXFRpk4HqKu5Vu9nK0KQQNNBXYelLow6/ppWh0UMze6l5AVSVKbwQmGZjs1bqI/d6zI6Cxhtj82fs8JfKB8XwHbDpr9qdLzlH3xlQcTbLrYBwhQRLaP+jMq9dD5dswlrb/n0giEJnOLvsmkFsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246123; c=relaxed/simple;
	bh=xVakQ8GmuEVC0dA3o7yZHmA2qBmEM7I9/PMTBkzfbJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2PRl9fU4oCQ75M42zGa6dGGrEg8gac55i4HtnN+T1WBnFqqb7rYmFzYlXDZB/L8AQ2uAqhGOM1Ucnsvdp87mkCwKFGGUb6/D1MfZC+QxLa0TmLq7ttoAxfP0mJTZAlCuX0PjNFMLOPH+CdKmiqfKRJlvo7rvRCNchS0Ypw59so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iURSgF0B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iURSgF0B"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso601738f8f.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792246118; x=1792850918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2REKTc3Loai45qA+UgRp6dZJ3Ic1DsiN3ndNN8daHjs=;
        b=iURSgF0BKVNRRWFZcJ3oQGCHlH4XRkkTCv9/1cLncq9YgyXjb+izB0HUslG+Ua0/eD
         m1OptwtLN7VLBYIJS1q++4JKQ+HKb4M6UC9MRbbd0lk13Fn4oHacMOzs1MAT4VuLuK7g
         jNAD7gvHZyjs4Sf20Um+XuZxuD1B6WTDTRjUxDCyA0+fhF+97NwJqTPX2IloPNfFbVUB
         rM6IveSTNvu20FlcD8u1MmmcvEULWz/ExIAO33nua3wLloyfC0rmB9mpkuPObmjGV2l/
         O2uu0nVm8gZfheqGilBMiAo3H5myUQbx67qqiw7iF8VNdRpWHEFOL/nKzq5MXk9iCH+0
         TCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246118; x=1792850918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2REKTc3Loai45qA+UgRp6dZJ3Ic1DsiN3ndNN8daHjs=;
        b=lXNEaf3VOoN3W/b+7KLXuKhuj5e8DKzyq4Kdxd6yBRDEXgNO8xv7teWO4GhY/OSuou
         CR/PKsQs42gzEl1zfA7wOsYVPFFoaHLTMlQ9y0UM7gptt/zeTlNDOnrZP1YnUYy6jbf+
         klXltGebTh1u2HliNT/sgi/2ysQyEoMYJQ0UKYfr2bjl3IOK/7qo4gLsDn1sZ3bTrqJY
         ItU+ulXaXgXxm6cWZYhB+5+7G2VmPEWhBjgnhAN9IMF+ImQO/wC4CLEKyCmZrUVuk4k0
         KjGgFUIsu+4LpxANMIiPaaWWMDjSL+n9iknw1KQo6pPozdPfEdX+oN1TU2q0O1peaVob
         kZvw==
X-Forwarded-Encrypted: i=1; AKwUvBzHmIDBb7chz5l1wR4ODNBZGQJ1pj8uff9Qr5rNcppwjU1nR8VUxYRXIj7957VuIJq3nObCV4/nEF/3xw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgstEvonkyJuaTR/qRvZzhd6ngNuLvq9ihGJvvrLcxm7O62rdY
	rKWXtXqC7JVhu5wGbSs7OtTiJUt8oqmUk0Bx8QdAbEKf0MWgMprc/lPz
X-Gm-Gg: AYBFou1K8L5N1O3269ZYJ02ie1DTxWqEFUQNEjGKNDpAkYWuAxzllgaecjz0ehCTazR
	63gwk1NBckx0t+bSYmM1d6+LTBGQGJT/sjyqv6Ysf3kWbtmVi/YQzaey9uG2b9ToX5HiPKTlD2Z
	eJlczZVqtS0DiZqnYo8jNOOtruwB+3ps6eCfT71RJchezIFqG5rRHd+9abf5rk8JZGUSeFhFtUK
	C3QrQaxLpKkQKKf6cuHtJ+IX+op9Y4oQ7Iuw53hzCYQT9PKP7f9t6qJOztLCR1vAXBMV4gaM4C5
	I5+qqwaiTkYnrHHEmaZ/wQUCHKG9bphCykVm48OxSBN0kG8WbkGdaqzDDLfjdR2iFoWErHMRGnb
	ofRCAetTM1G2j+MxRzz7S8ursmb7UuK0/Ham+CH7301csF5FSsZ5I4DeldOf0WApNjKzRzysCHX
	4o/n1GORtRN8J4a6OJlYFKp2gl1siLaDvS1Nlb9n62uu5ORjIiX28nYBQxmqOtlajTwcbYc6itF
	5ETpg1zAMhBHKvJ3NY/hsDkonml74OcOsxdWdJ12xXVE5lY/Skhcpk0HaNdIhruvRY6vMx1Duc8
	8HbEwy7PhApz
X-Received: by 2002:a05:600d:849a:10b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a1d75af354mr43144615e9.4.1792246117271;
        Sat, 17 Oct 2026 07:08:37 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:08:36 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 1/7] Input: edt-ft5x06 - split the bus independent core from the I2C driver
Date: Sat, 17 Oct 2026 16:07:49 +0200
Message-ID: <20261017140827.290666-2-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some FocalTech controllers handled by this driver, such as the FT8722
TDDI, are connected over SPI. Prepare for an SPI transport by moving
everything that depends on the i2c_client into a small I2C probe.

The only visible change for the I2C devices is that the interrupt is now
requested with the device name (e.g. "1-0038") instead of the I2C client
name, as the core no longer has access to the latter.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 276 +++++++++++++------------
 drivers/input/touchscreen/edt-ft5x06.h |  30 +++
 2 files changed, 179 insertions(+), 127 deletions(-)
 create mode 100644 drivers/input/touchscreen/edt-ft5x06.h

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e69d64c3db2d..543cc62088c7 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -34,6 +34,8 @@
 
 #include <linux/unaligned.h>
 
+#include "edt-ft5x06.h"
+
 #define WORK_REGISTER_THRESHOLD		0x00
 #define WORK_REGISTER_REPORT_RATE	0x08
 #define WORK_REGISTER_GAIN		0x30
@@ -106,7 +108,9 @@ struct edt_reg_addr {
 };
 
 struct edt_ft5x06_ts_data {
-	struct i2c_client *client;
+	struct device *dev;
+	int irq;
+	struct dentry *debugfs;
 	struct input_dev *input;
 	struct touchscreen_properties prop;
 	u16 num_x;
@@ -148,15 +152,6 @@ struct edt_ft5x06_ts_data {
 	unsigned int header_errors;
 };
 
-struct edt_i2c_chip_data {
-	int  max_support_points;
-};
-
-static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
 				    u8 *buf, int buflen)
 {
@@ -168,7 +163,7 @@ static bool edt_ft5x06_ts_check_crc(struct edt_ft5x06_ts_data *tsdata,
 
 	if (crc != buf[buflen - 1]) {
 		tsdata->crc_errors++;
-		dev_err_ratelimited(&tsdata->client->dev,
+		dev_err_ratelimited(tsdata->dev,
 				    "crc error: 0x%02x expected, got 0x%02x\n",
 				    crc, buf[buflen - 1]);
 		return false;
@@ -182,7 +177,7 @@ static int edt_M06_i2c_read(void *context, const void *reg_buf, size_t reg_size,
 {
 	struct device *dev = context;
 	struct i2c_client *i2c = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(i2c);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	struct i2c_msg xfer[2];
 	bool reg_read = false;
 	u8 addr;
@@ -258,7 +253,7 @@ static int edt_M06_i2c_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
 	struct i2c_client *i2c = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(i2c);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	u8 addr, val;
 	u8 wbuf[4];
 	struct i2c_msg xfer;
@@ -298,7 +293,7 @@ static const struct regmap_config edt_M06_i2c_regmap_config = {
 static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 {
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
-	struct device *dev = &tsdata->client->dev;
+	struct device *dev = tsdata->dev;
 	u8 rdbuf[63];
 	int i, type, x, y, id;
 	int error;
@@ -376,8 +371,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 				       struct device_attribute *dattr,
 				       char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	struct edt_ft5x06_attribute *attr =
 			container_of(dattr, struct edt_ft5x06_attribute, dattr);
 	u8 *field = (u8 *)tsdata + attr->field_offset;
@@ -412,7 +406,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 	if (addr != NO_REGISTER) {
 		error = regmap_read(tsdata->regmap, addr, &val);
 		if (error) {
-			dev_err(&tsdata->client->dev,
+			dev_err(tsdata->dev,
 				"Failed to fetch attribute %s, error %d\n",
 				dattr->attr.name, error);
 			return error;
@@ -422,7 +416,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 	}
 
 	if (val != *field) {
-		dev_warn(&tsdata->client->dev,
+		dev_warn(tsdata->dev,
 			 "%s: read (%d) and stored value (%d) differ\n",
 			 dattr->attr.name, val, *field);
 		*field = val;
@@ -435,8 +429,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 					struct device_attribute *dattr,
 					const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	struct edt_ft5x06_attribute *attr =
 			container_of(dattr, struct edt_ft5x06_attribute, dattr);
 	u8 *field = (u8 *)tsdata + attr->field_offset;
@@ -478,7 +471,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 	if (addr != NO_REGISTER) {
 		error = regmap_write(tsdata->regmap, addr, val);
 		if (error) {
-			dev_err(&tsdata->client->dev,
+			dev_err(tsdata->dev,
 				"Failed to update attribute %s, error: %d\n",
 				dattr->attr.name, error);
 			return error;
@@ -511,8 +504,7 @@ static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
 static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%s\n", tsdata->name);
 }
@@ -522,8 +514,7 @@ static DEVICE_ATTR_RO(model);
 static ssize_t fw_version_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%s\n", tsdata->fw_version);
 }
@@ -534,8 +525,7 @@ static DEVICE_ATTR_RO(fw_version);
 static ssize_t header_errors_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%d\n", tsdata->header_errors);
 }
@@ -546,8 +536,7 @@ static DEVICE_ATTR_RO(header_errors);
 static ssize_t crc_errors_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%d\n", tsdata->crc_errors);
 }
@@ -567,7 +556,16 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&dev_attr_crc_errors.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(edt_ft5x06);
+
+static const struct attribute_group edt_ft5x06_group = {
+	.attrs = edt_ft5x06_attrs,
+};
+
+const struct attribute_group *edt_ft5x06_groups[] = {
+	&edt_ft5x06_group,
+	NULL
+};
+EXPORT_SYMBOL_NS_GPL(edt_ft5x06_groups, "EDT_FT5X06");
 
 static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
@@ -590,18 +588,17 @@ static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 #ifdef CONFIG_DEBUG_FS
 static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 {
-	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
 	unsigned int val;
 	int error;
 
 	if (tsdata->version != EDT_M06) {
-		dev_err(&client->dev,
+		dev_err(tsdata->dev,
 			"No factory mode support for non-M06 devices\n");
 		return -EINVAL;
 	}
 
-	disable_irq(client->irq);
+	disable_irq(tsdata->irq);
 
 	if (!tsdata->raw_buffer) {
 		tsdata->raw_bufsize = tsdata->num_x * tsdata->num_y *
@@ -616,7 +613,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	/* mode register is 0x3c when in the work mode */
 	error = regmap_write(tsdata->regmap, WORK_REGISTER_OPMODE, 0x03);
 	if (error) {
-		dev_err(&client->dev,
+		dev_err(tsdata->dev,
 			"failed to switch to factory mode, error %d\n", error);
 		goto err_out;
 	}
@@ -632,7 +629,7 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	} while (--retries > 0);
 
 	if (retries == 0) {
-		dev_err(&client->dev, "not in factory mode after %dms.\n",
+		dev_err(tsdata->dev, "not in factory mode after %dms.\n",
 			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
 		error = -EIO;
 		goto err_out;
@@ -644,14 +641,13 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts_data *tsdata)
 	kfree(tsdata->raw_buffer);
 	tsdata->raw_buffer = NULL;
 	tsdata->factory_mode = false;
-	enable_irq(client->irq);
+	enable_irq(tsdata->irq);
 
 	return error;
 }
 
 static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 {
-	struct i2c_client *client = tsdata->client;
 	int retries = EDT_SWITCH_MODE_RETRIES;
 	unsigned int val;
 	int error;
@@ -659,7 +655,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	/* mode register is 0x01 when in the factory mode */
 	error = regmap_write(tsdata->regmap, FACTORY_REGISTER_OPMODE, 0x1);
 	if (error) {
-		dev_err(&client->dev,
+		dev_err(tsdata->dev,
 			"failed to switch to work mode, error: %d\n", error);
 		return error;
 	}
@@ -675,7 +671,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	} while (--retries > 0);
 
 	if (retries == 0) {
-		dev_err(&client->dev, "not in work mode after %dms.\n",
+		dev_err(tsdata->dev, "not in work mode after %dms.\n",
 			EDT_SWITCH_MODE_RETRIES * EDT_SWITCH_MODE_DELAY);
 		tsdata->factory_mode = true;
 		return -EIO;
@@ -685,7 +681,7 @@ static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
 	tsdata->raw_buffer = NULL;
 
 	edt_ft5x06_restore_reg_parameters(tsdata);
-	enable_irq(client->irq);
+	enable_irq(tsdata->irq);
 
 	return 0;
 }
@@ -723,7 +719,6 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 						loff_t *off)
 {
 	struct edt_ft5x06_ts_data *tsdata = file->private_data;
-	struct i2c_client *client = tsdata->client;
 	int retries  = EDT_RAW_DATA_RETRIES;
 	unsigned int val;
 	int i, error;
@@ -741,7 +736,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 
 	error = regmap_write(tsdata->regmap, 0x08, 0x01);
 	if (error) {
-		dev_err(&client->dev,
+		dev_err(tsdata->dev,
 			"failed to write 0x08 register, error %d\n", error);
 		return error;
 	}
@@ -750,7 +745,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 		usleep_range(EDT_RAW_DATA_DELAY, EDT_RAW_DATA_DELAY + 100);
 		error = regmap_read(tsdata->regmap, 0x08, &val);
 		if (error) {
-			dev_err(&client->dev,
+			dev_err(tsdata->dev,
 				"failed to read 0x08 register, error %d\n",
 				error);
 			return error;
@@ -761,7 +756,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 	} while (--retries > 0);
 
 	if (retries == 0) {
-		dev_err(&client->dev,
+		dev_err(tsdata->dev,
 			"timed out waiting for register to settle\n");
 		return -ETIMEDOUT;
 	}
@@ -793,7 +788,10 @@ static const struct file_operations debugfs_raw_data_fops = {
 
 static void edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
-	struct dentry *debug_dir = tsdata->client->debugfs;
+	struct dentry *debug_dir = tsdata->debugfs;
+
+	if (!debug_dir)
+		return;
 
 	debugfs_create_u16("num_x", S_IRUSR, debug_dir, &tsdata->num_x);
 	debugfs_create_u16("num_y", S_IRUSR, debug_dir, &tsdata->num_y);
@@ -829,9 +827,9 @@ static void edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 
 #endif /* CONFIG_DEBUGFS */
 
-static int edt_ft5x06_ts_identify(struct i2c_client *client,
-				  struct edt_ft5x06_ts_data *tsdata)
+static int edt_ft5x06_ts_identify(struct edt_ft5x06_ts_data *tsdata)
 {
+	struct i2c_client *client;
 	u8 rdbuf[EDT_NAME_LEN];
 	char *p;
 	int error;
@@ -854,6 +852,11 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	if (!strncasecmp(rdbuf + 1, "EP0", 3)) {
 		tsdata->version = EDT_M06;
 
+		/* M06 uses its own register protocol, only over I2C */
+		client = i2c_verify_client(tsdata->dev);
+		if (!client)
+			return -ENODEV;
+
 		/* remove last '$' end marker */
 		rdbuf[EDT_NAME_LEN - 1] = '\0';
 		if (rdbuf[EDT_NAME_LEN - 2] == '$')
@@ -870,7 +873,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		tsdata->regmap = regmap_init_i2c(client,
 						 &edt_M06_i2c_regmap_config);
 		if (IS_ERR(tsdata->regmap)) {
-			dev_err(&client->dev, "regmap allocation failed\n");
+			dev_err(tsdata->dev, "regmap allocation failed\n");
 			return PTR_ERR(tsdata->regmap);
 		}
 	} else if (!strncasecmp(rdbuf, "EP0", 3)) {
@@ -1113,10 +1116,10 @@ static void edt_ft5x06_disable_regulators(void *arg)
 	regulator_disable(data->iovcc);
 }
 
-static int edt_ft5x06_ts_probe(struct i2c_client *client)
+int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
+		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
+		     struct dentry *debugfs)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	const struct edt_i2c_chip_data *chip_data;
 	struct edt_ft5x06_ts_data *tsdata;
 	unsigned int val;
 	struct input_dev *input;
@@ -1124,57 +1127,50 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	int error;
 	u32 report_rate;
 
-	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
-
-	tsdata = devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
+	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
 	if (!tsdata) {
-		dev_err(&client->dev, "failed to allocate driver data.\n");
+		regmap_exit(regmap);
 		return -ENOMEM;
 	}
 
-	tsdata->regmap = regmap_init_i2c(client, &edt_ft5x06_i2c_regmap_config);
-	if (IS_ERR(tsdata->regmap)) {
-		dev_err(&client->dev, "regmap allocation failed\n");
-		return PTR_ERR(tsdata->regmap);
-	}
+	tsdata->dev = dev;
+	tsdata->irq = irq;
+	tsdata->debugfs = debugfs;
+	tsdata->regmap = regmap;
 
 	/*
-	 * We are not using devm_regmap_init_i2c() and instead install a
-	 * custom action because we may replace regmap with M06-specific one
-	 * and we need to make sure that it will not be released too early.
+	 * The bus driver hands over a regmap that is not device managed
+	 * because we may replace it with the M06-specific one and we need to
+	 * make sure that it will not be released too early.
 	 */
-	error = devm_add_action_or_reset(&client->dev, edt_ft5x06_exit_regmap,
-					 tsdata);
+	error = devm_add_action_or_reset(dev, edt_ft5x06_exit_regmap, tsdata);
 	if (error)
 		return error;
 
-	chip_data = device_get_match_data(&client->dev);
-	if (!chip_data)
-		chip_data = (const struct edt_i2c_chip_data *)id->driver_data;
 	if (!chip_data || !chip_data->max_support_points) {
-		dev_err(&client->dev, "invalid or missing chip data\n");
+		dev_err(dev, "invalid or missing chip data\n");
 		return -EINVAL;
 	}
 
 	tsdata->max_support_points = chip_data->max_support_points;
 
-	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
+	tsdata->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(tsdata->vcc))
-		return dev_err_probe(&client->dev, PTR_ERR(tsdata->vcc),
+		return dev_err_probe(dev, PTR_ERR(tsdata->vcc),
 				     "failed to request regulator\n");
 
-	tsdata->iovcc = devm_regulator_get(&client->dev, "iovcc");
+	tsdata->iovcc = devm_regulator_get(dev, "iovcc");
 	if (IS_ERR(tsdata->iovcc)) {
 		error = PTR_ERR(tsdata->iovcc);
 		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
+			dev_err(dev,
 				"failed to request iovcc regulator: %d\n", error);
 		return error;
 	}
 
 	error = regulator_enable(tsdata->iovcc);
 	if (error < 0) {
-		dev_err(&client->dev, "failed to enable iovcc: %d\n", error);
+		dev_err(dev, "failed to enable iovcc: %d\n", error);
 		return error;
 	}
 
@@ -1183,32 +1179,30 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 
 	error = regulator_enable(tsdata->vcc);
 	if (error < 0) {
-		dev_err(&client->dev, "failed to enable vcc: %d\n", error);
+		dev_err(dev, "failed to enable vcc: %d\n", error);
 		regulator_disable(tsdata->iovcc);
 		return error;
 	}
 
-	error = devm_add_action_or_reset(&client->dev,
-					 edt_ft5x06_disable_regulators,
+	error = devm_add_action_or_reset(dev, edt_ft5x06_disable_regulators,
 					 tsdata);
 	if (error)
 		return error;
 
-	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
-						     "reset", GPIOD_OUT_HIGH);
+	tsdata->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(tsdata->reset_gpio)) {
 		error = PTR_ERR(tsdata->reset_gpio);
-		dev_err(&client->dev,
-			"Failed to request GPIO reset pin, error %d\n", error);
+		dev_err(dev, "Failed to request GPIO reset pin, error %d\n",
+			error);
 		return error;
 	}
 
-	tsdata->wake_gpio = devm_gpiod_get_optional(&client->dev,
-						    "wake", GPIOD_OUT_LOW);
+	tsdata->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_LOW);
 	if (IS_ERR(tsdata->wake_gpio)) {
 		error = PTR_ERR(tsdata->wake_gpio);
-		dev_err(&client->dev,
-			"Failed to request GPIO wake pin, error %d\n", error);
+		dev_err(dev, "Failed to request GPIO wake pin, error %d\n",
+			error);
 		return error;
 	}
 
@@ -1237,21 +1231,20 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		msleep(300);
 	}
 
-	input = devm_input_allocate_device(&client->dev);
+	input = devm_input_allocate_device(dev);
 	if (!input) {
-		dev_err(&client->dev, "failed to allocate input device.\n");
+		dev_err(dev, "failed to allocate input device.\n");
 		return -ENOMEM;
 	}
 
 	mutex_init(&tsdata->mutex);
-	tsdata->client = client;
 	tsdata->input = input;
 	tsdata->factory_mode = false;
-	i2c_set_clientdata(client, tsdata);
+	dev_set_drvdata(dev, tsdata);
 
-	error = edt_ft5x06_ts_identify(client, tsdata);
+	error = edt_ft5x06_ts_identify(tsdata);
 	if (error) {
-		dev_err(&client->dev, "touchscreen probe failed\n");
+		dev_err(dev, "touchscreen probe failed\n");
 		return error;
 	}
 
@@ -1263,19 +1256,18 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 
 	edt_ft5x06_ts_set_tdata_parameters(tsdata);
 	edt_ft5x06_ts_set_regs(tsdata);
-	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
+	edt_ft5x06_ts_get_defaults(dev, tsdata);
 	edt_ft5x06_ts_get_parameters(tsdata);
 
 	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
-	    !device_property_read_u32(&client->dev,
-				      "report-rate-hz", &report_rate)) {
+	    !device_property_read_u32(dev, "report-rate-hz", &report_rate)) {
 		if (tsdata->version == EDT_M06)
 			tsdata->report_rate = clamp_val(report_rate, 30, 140);
 		else
 			tsdata->report_rate = clamp_val(report_rate, 1, 255);
 
 		if (report_rate != tsdata->report_rate)
-			dev_warn(&client->dev,
+			dev_warn(dev,
 				 "report-rate %dHz is unsupported, use %dHz\n",
 				 report_rate, tsdata->report_rate);
 
@@ -1286,12 +1278,11 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 			     tsdata->report_rate);
 	}
 
-	dev_dbg(&client->dev,
-		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
+	dev_dbg(dev, "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
 		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
 
 	input->name = tsdata->name;
-	input->id.bustype = BUS_I2C;
+	input->id.bustype = bustype;
 
 	input_set_abs_params(input, ABS_MT_POSITION_X,
 			     0, tsdata->num_x * 64 - 1, 0, 0);
@@ -1303,20 +1294,19 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				    INPUT_MT_DIRECT);
 	if (error) {
-		dev_err(&client->dev, "Unable to init MT slots.\n");
+		dev_err(dev, "Unable to init MT slots.\n");
 		return error;
 	}
 
-	irq_flags = irq_get_trigger_type(client->irq);
+	irq_flags = irq_get_trigger_type(irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
 	irq_flags |= IRQF_ONESHOT;
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, edt_ft5x06_ts_isr, irq_flags,
-					  client->name, tsdata);
+	error = devm_request_threaded_irq(dev, irq, NULL, edt_ft5x06_ts_isr,
+					  irq_flags, dev_name(dev), tsdata);
 	if (error) {
-		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
+		dev_err(dev, "Unable to request touchscreen IRQ.\n");
 		return error;
 	}
 
@@ -1326,26 +1316,27 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 
 	edt_ft5x06_ts_prepare_debugfs(tsdata);
 
-	dev_dbg(&client->dev,
+	dev_dbg(dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
-		client->irq,
+		irq,
 		tsdata->wake_gpio ? desc_to_gpio(tsdata->wake_gpio) : -1,
 		tsdata->reset_gpio ? desc_to_gpio(tsdata->reset_gpio) : -1);
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(edt_ft5x06_probe, "EDT_FT5X06");
 
-static void edt_ft5x06_ts_remove(struct i2c_client *client)
+void edt_ft5x06_remove(struct device *dev)
 {
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 
 	edt_ft5x06_ts_teardown_debugfs(tsdata);
 }
+EXPORT_SYMBOL_NS_GPL(edt_ft5x06_remove, "EDT_FT5X06");
 
 static int edt_ft5x06_ts_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	struct gpio_desc *reset_gpio = tsdata->reset_gpio;
 	int ret;
 
@@ -1370,7 +1361,7 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 	 * settings. Disable the irq to avoid adjusting each host till the
 	 * device is back in a full functional state.
 	 */
-	disable_irq(tsdata->client->irq);
+	disable_irq(tsdata->irq);
 
 	gpiod_set_value_cansleep(reset_gpio, 1);
 	usleep_range(1000, 2000);
@@ -1387,8 +1378,7 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 
 static int edt_ft5x06_ts_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	struct edt_ft5x06_ts_data *tsdata = dev_get_drvdata(dev);
 	int ret = 0;
 
 	if (device_may_wakeup(dev))
@@ -1432,7 +1422,7 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 		msleep(300);
 
 		edt_ft5x06_restore_reg_parameters(tsdata);
-		enable_irq(tsdata->client->irq);
+		enable_irq(tsdata->irq);
 
 		if (tsdata->factory_mode)
 			ret = edt_ft5x06_factory_mode(tsdata);
@@ -1447,38 +1437,38 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 	return ret;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
-				edt_ft5x06_ts_suspend, edt_ft5x06_ts_resume);
+EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(edt_ft5x06_pm_ops, edt_ft5x06_ts_suspend,
+				edt_ft5x06_ts_resume, EDT_FT5X06);
 
-static const struct edt_i2c_chip_data edt_ft5x06_data = {
+static const struct edt_ft5x06_chip_data edt_ft5x06_data = {
 	.max_support_points = 5,
 };
 
-static const struct edt_i2c_chip_data edt_ft3518_data = {
+static const struct edt_ft5x06_chip_data edt_ft3518_data = {
 	.max_support_points = 10,
 };
 
-static const struct edt_i2c_chip_data edt_ft5452_data = {
+static const struct edt_ft5x06_chip_data edt_ft5452_data = {
 	.max_support_points = 5,
 };
 
-static const struct edt_i2c_chip_data edt_ft5506_data = {
+static const struct edt_ft5x06_chip_data edt_ft5506_data = {
 	.max_support_points = 10,
 };
 
-static const struct edt_i2c_chip_data edt_ft6236_data = {
+static const struct edt_ft5x06_chip_data edt_ft6236_data = {
 	.max_support_points = 2,
 };
 
-static const struct edt_i2c_chip_data edt_ft8201_data = {
+static const struct edt_ft5x06_chip_data edt_ft8201_data = {
 	.max_support_points = 10,
 };
 
-static const struct edt_i2c_chip_data edt_ft8716_data = {
+static const struct edt_ft5x06_chip_data edt_ft8716_data = {
 	.max_support_points = 10,
 };
 
-static const struct edt_i2c_chip_data edt_ft8719_data = {
+static const struct edt_ft5x06_chip_data edt_ft8719_data = {
 	.max_support_points = 10,
 };
 
@@ -1515,17 +1505,49 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, edt_ft5x06_of_match);
 
+static const struct regmap_config edt_ft5x06_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int edt_ft5x06_i2c_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct edt_ft5x06_chip_data *chip_data;
+	struct regmap *regmap;
+
+	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
+
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data && id)
+		chip_data = (const struct edt_ft5x06_chip_data *)id->driver_data;
+
+	regmap = regmap_init_i2c(client, &edt_ft5x06_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	return edt_ft5x06_probe(&client->dev, regmap, client->irq, chip_data,
+				BUS_I2C, client->debugfs);
+}
+
+static void edt_ft5x06_i2c_remove(struct i2c_client *client)
+{
+	edt_ft5x06_remove(&client->dev);
+}
+
 static struct i2c_driver edt_ft5x06_ts_driver = {
 	.driver = {
 		.name = "edt_ft5x06",
 		.dev_groups = edt_ft5x06_groups,
 		.of_match_table = edt_ft5x06_of_match,
-		.pm = pm_sleep_ptr(&edt_ft5x06_ts_pm_ops),
+		.pm = pm_sleep_ptr(&edt_ft5x06_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table = edt_ft5x06_ts_id,
-	.probe    = edt_ft5x06_ts_probe,
-	.remove   = edt_ft5x06_ts_remove,
+	.probe    = edt_ft5x06_i2c_probe,
+	.remove   = edt_ft5x06_i2c_remove,
 };
 
 module_i2c_driver(edt_ft5x06_ts_driver);
diff --git a/drivers/input/touchscreen/edt-ft5x06.h b/drivers/input/touchscreen/edt-ft5x06.h
new file mode 100644
index 000000000000..deadc756cd74
--- /dev/null
+++ b/drivers/input/touchscreen/edt-ft5x06.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Bus independent core of the EDT FT5x06 touchscreen driver
+ *
+ * Copyright (C) 2026 Luka Panio, <lukapanio@gmail.com>
+ */
+#ifndef _EDT_FT5X06_H
+#define _EDT_FT5X06_H
+
+#include <linux/types.h>
+
+struct attribute_group;
+struct dentry;
+struct dev_pm_ops;
+struct device;
+struct regmap;
+
+struct edt_ft5x06_chip_data {
+	int max_support_points;
+};
+
+int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
+		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
+		     struct dentry *debugfs);
+void edt_ft5x06_remove(struct device *dev);
+
+extern const struct dev_pm_ops edt_ft5x06_pm_ops;
+extern const struct attribute_group *edt_ft5x06_groups[];
+
+#endif
-- 
2.55.0

