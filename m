Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795191;
	b=UbE90zXVj9jLQC3FUKQoh4uGgrygHXJmVhfQCgVzW9On2Alb0p4HFcE0860//Rd3eEVm
	 mRWatla/ZD7H/73vNJlSnk9Ygu32wU1IcCeYxYchZBPdTx76pMxORsh64y5A1qQPGYk5W
	 KYIw2oqsJMJcA6C2jGcJnfLh+jHYpW1Lo2ee8rI8SSJ0eRzmnBwMj0i1HiHJISpK6xHVe
	 7PW+FSKh+sJZ+wqFNsfrPChx0OcqQ9fMwuRDL9Bh4v3ec5cRIowRAY04VxzB6rk72ida8
	 UZuLnks7nrkW1Qeya9H/IMvD7MsaAQ5tNB8J/11lGXXHp8F2/C46f02oFPZPYVXTqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fr9foU8FPKiSJTPWfqOCEi6oYZhtYDC9y7CpAWUi2Xk=;
	b=Tbe3uiQm4mh70UPIELlP48PwqgjZtFPUU6kKvZFjDHarRU1207bXoOs4qQoejYLh3Z+B
	 iO7hHG7QkZHu1el3PdLTuSw/138Xwsf+pCqnulSxa90ThgWnhe6ie79CkofiHInA+AOtD
	 J95KIjOKJLo6vnR0lSjdHyhOQjHBaQ9OcdTpWHWcqwdS93uTHXwwPrR7e9Npi3xR6iCHP
	 mgUl4xVoskjOr+NYsm65a0DUoV4EGLzxunr/f/SZu0QRb8qHzOnmEI+UgVvO60SLK3XJ0
	 a8YVqrO3+egO6btve/76b6A/bx8/uNrFlMAs9yR0LWilMwzYqJUliwoWrdnAoRZ1NKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgynir3I;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA349606D825
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA349606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgynir3I
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so3758645e9.3
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795188; x=1794399988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fr9foU8FPKiSJTPWfqOCEi6oYZhtYDC9y7CpAWUi2Xk=;
        b=zgynir3IVXls8OaH4/Dm22KxpnCfI6ZL0B8bNAF8cxrcDSCtV1XVMonnFgU7bU6zor
         Rq8VwwjjJLLjwcgyEZm/XSFwEiHQ0Re9ZMgTD553WfMvWzdckelClaHIDBm8TnALwykk
         SmrJIh3ntbBCyo7b1e+lAZfEzdoKZEfjVEnJMJlTr03+pl+1YLSNLngAAMbhTVxsJYvM
         x541rFSWeecrPF/lB4u3ZE9fspYpw4X6UWaDS9fnMjAGvQ++vBfndlLCRWB/R0YN+SIW
         7zsE0a2jfEWOGPBc44sNvNWOdhJt7DOjOSEJE18RKEuRu+1F3adI3+mN7JaubeJgvMHX
         WwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795188; x=1794399988;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr9foU8FPKiSJTPWfqOCEi6oYZhtYDC9y7CpAWUi2Xk=;
        b=l9jgmjPShxlFtzxNF0yJHf7KwABY8RK2JBgfr+Gtb1v30/05e69NXPFVFr1R6Srt+t
         gdwrcv15xfCx5rbwLbq5lj60/eIWVaPBMnmIafp95P5EWbuZYi9yINlHIHIIa2vNTzws
         P6UKf8hgXJ2inQgRe7uwF7TpLfYb1RijLmUmf7YpoX8BnpFHMRYRpD/7+UtAibjscxsA
         hR6vsy6UTRq7NYpy3htFzeViKRVFDyyr/VQHUl3Qgm7sDNwbgY0uxWAVa53N547EPtGH
         f0r1JVocDYaqNARZz494SzNWolB0XSBShLX8wD9NT88pQJDCznVutyeNf1mST4Kz3dik
         Ftcw==
X-Forwarded-Encrypted: i=1; AKwUvBwW3dGk6zdj1CPffx90VKVUmfOqqa7p0YB+zkhsrpDo7PJqhqgJOi82wwcMCxa3DF13ZyVL+1myEafyrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lZa+2yabI4y0LKLD63tNwHzaTCilX5pTrZM7uZADJwKVdCpHC
	hxQNbXeTDTvxLitlG/jI+avBa7eDfgnUI7EkoRj1NTwQtZ5AU+ZDjgHO
X-Gm-Gg: AYBFou2NoVS7GCutfphh1lIoOB6ILMeC7zUxp/mjw5U66y8OSRjJ0DKpTOyyKyWV3SH
	mONCDK1OZ03wSMF929lNPw4WL/nWG/MYi5RgRsP9xl3JfBvEPUl4p72d6f/t7sWb0UoTgzCoiZh
	Bw91DyYBzqur5ur7LU51Z/7I17LwJzdjeCTkndgQ7MtWj1oef7L9rxQceNa9uN+FDkMykorViL0
	CIHxwFPAjp4mvJAsI0lWYGaUThGU0w/5CQS2Zxxo32g9idzP8SqUg40ykRkFT7F7C2AzQJGpijr
	wF6INmbRrj381lpPmizzQnj/a5wInpt4fAGCc2qiYnntQzOS44JEh9ie6WfEKHZnc0Uy4pGwd/6
	CWmr0bGLVf2B2fiJq37htLBwZc9OBoNfqr9I9A3CRKUiY5HMdGowZ30YFW1WLr7yNVcDBbg8z2O
	Q6SElg0X422jcKQw9VfBPdKE98eCK/nHDVpxVojwWclptBe7v+1ixtK60hwuvqXVjqp3BkVRpZO
	P6AbytfRcjiFaji9CbL2oBm7iwGzaKS5mUALukEjS8vb9ekb+x5Ha2L7ASkR9tCD08At5x8c6++
	CCoXOhmsgVEPD4YnnnMUweNd7XASDkX+LfyRbqyJredyIBWKIw==
X-Received: by 2002:a05:600c:34cf:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4ac150b38ebmr369668425e9.1.1793795188364;
        Wed, 04 Nov 2026 04:26:28 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 2/7] mfd: Add driver for ASUS Transformer embedded controller
Date: Wed,  4 Nov 2026 14:26:01 +0200
Message-ID: <20261104122606.215629-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
and TF600T, P1801-T and TF701T pad. This is a glue driver handling
detection and common operations for EC's functions.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Florian Krischer <florian.krischer@fkr.dev> # ASUS SL101
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/Kconfig                     |  16 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/asus-transformer-ec.c       | 551 ++++++++++++++++++++++++
 include/linux/mfd/asus-transformer-ec.h | 100 +++++
 4 files changed, 668 insertions(+)
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 87ed55c155f03..95e8f26bf993f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -137,6 +137,22 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ASUS_TRANSFORMER_EC
+	tristate "ASUS Transformer's embedded controller"
+	select MFD_CORE
+	depends on I2C && OF
+	help
+	  Select this to enable support for the Embedded Controller (EC)
+	  found in Tegra based ASUS Transformer series tablets and mobile
+	  docks.
+
+	  This driver handles the core I2C communication with the EC and
+	  provides support for its sub-devices, including battery management,
+	  charger detection, LEDs and keyboard dock functions support.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called asus-transformer-ec.
+
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f8101d2a9ce95..3765e6ebc7247 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
+obj-$(CONFIG_MFD_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transformer-ec.c
new file mode 100644
index 0000000000000..2f575ecb4f58b
--- /dev/null
+++ b/drivers/mfd/asus-transformer-ec.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define ASUSEC_ACCESS_TIMEOUT		300
+#define ASUSEC_DOCKRAM_OFFSET		2
+#define ASUSEC_ECREQ_DELAY		50
+#define ASUSEC_ECREQ_TIMEOUT		200
+#define ASUSEC_RESET			0
+#define ASUSEC_RETRY_MAX		3
+#define ASUSEC_RSP_BUFFER_SIZE		(ASUSEC_ENTRIES / ASUSEC_ENTRY_SIZE)
+#define ASUSEC_SL101_ENTRY_SIZE		8
+
+enum asusec_variant {
+	ASUSEC_SL101_DOCK = 1,
+	ASUSEC_TF101_DOCK,
+	ASUSEC_TF201_PAD,
+	ASUSEC_TF600T_PAD,
+	ASUSEC_MAX
+};
+
+enum asusec_mode {
+	ASUSEC_MODE_NONE,
+	ASUSEC_MODE_NORMAL,
+	ASUSEC_MODE_FACTORY,
+	ASUSEC_MODE_MAX
+};
+
+/**
+ * struct asus_ec_chip_info
+ *
+ * @name: prefix associated with the EC
+ * @variant: id of programming model of EC
+ * @fmode: state of Factory Mode bit in EC control register
+ * @read_size: size of block to read
+ * @keyboard_mask: mask of keyboard packets
+ */
+struct asus_ec_chip_info {
+	const char *name;
+	enum asusec_variant variant;
+	enum asusec_mode fmode;
+	u8 read_size;
+	u8 keyboard_mask;
+};
+
+/**
+ * struct asus_ec_data
+ *
+ * @ec: public part shared with all cells (must be first)
+ * @ecreq_lock: prevents simultaneous access to EC
+ * @ecreq_gpio: EC request GPIO
+ * @client: pointer to EC's i2c_client
+ * @info: pointer to EC's version description
+ * @ec_buf: buffer for EC read
+ */
+struct asus_ec_data {
+	struct asusec_core ec;
+	struct mutex ecreq_lock;
+	struct gpio_desc *ecreq_gpio;
+	struct i2c_client *client;
+	const struct asus_ec_chip_info *info;
+	u8 ec_buf[ASUSEC_ENTRY_BUFSIZE];
+};
+
+/**
+ * struct dockram_ec_data
+ *
+ * @ctl_lock: prevent simultaneous access to Dockram
+ * @ctl_buf: buffer for Dockram read
+ */
+struct dockram_ec_data {
+	struct mutex ctl_lock;
+	u8 ctl_buf[ASUSEC_ENTRY_BUFSIZE];
+};
+
+/**
+ * asus_dockram_access_ctl - Read from or write to the DockRAM control register.
+ * @client: Handle to the DockRAM device.
+ * @out: Pointer to a variable where the register value will be stored.
+ * @mask: Bitmask of bits to be cleared.
+ * @xor: Bitmask of bits to be set (via XOR).
+ *
+ * This performs a control register read if @out is provided and both @mask
+ * and @xor are zero. Otherwise, it performs a control register update if
+ * @mask and @xor are provided.
+ *
+ * Returns a negative errno code else zero on success.
+ */
+int asus_dockram_access_ctl(struct i2c_client *client, u64 *out, u64 mask, u64 xor)
+{
+	struct dockram_ec_data *ddata;
+	u8 *buf;
+	u64 val;
+	int ret = 0;
+
+	if (!client)
+		return -EINVAL;
+
+	ddata = i2c_get_clientdata(client);
+	if (!ddata)
+		return -ENODEV;
+
+	buf = ddata->ctl_buf;
+
+	guard(mutex)(&ddata->ctl_lock);
+
+	memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
+	ret = i2c_smbus_read_i2c_block_data(client, ASUSEC_DOCKRAM_CONTROL, ASUSEC_ENTRY_SIZE,
+					    buf);
+	if (ret < ASUSEC_ENTRY_SIZE) {
+		dev_err(&client->dev, "failed to access control buffer: %d\n", ret);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	if (buf[0] != ASUSEC_CTL_SIZE) {
+		dev_err(&client->dev, "buffer size exceeds %d: %d\n", ASUSEC_CTL_SIZE, buf[0]);
+		return -EPROTO;
+	}
+
+	val = get_unaligned_le64(buf + 1);
+
+	if (out)
+		*out = val;
+
+	if (mask || xor) {
+		put_unaligned_le64((val & ~mask) ^ xor, buf + 1);
+		ret = i2c_smbus_write_i2c_block_data(client, ASUSEC_DOCKRAM_CONTROL,
+						     ASUSEC_ENTRY_SIZE, buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asus_dockram_access_ctl);
+
+static int asus_ec_signal_request(struct asus_ec_data *ddata)
+{
+	guard(mutex)(&ddata->ecreq_lock);
+
+	gpiod_set_value_cansleep(ddata->ecreq_gpio, 1);
+	msleep(ASUSEC_ECREQ_DELAY);
+
+	gpiod_set_value_cansleep(ddata->ecreq_gpio, 0);
+	msleep(ASUSEC_ECREQ_TIMEOUT);
+
+	return 0;
+}
+
+static int asus_ec_log_info(struct asus_ec_data *ddata, unsigned int reg, const char *name)
+{
+	struct device *dev = &ddata->client->dev;
+	u8 buf[ASUSEC_ENTRY_BUFSIZE];
+	int ret;
+
+	memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
+	ret = i2c_smbus_read_i2c_block_data(ddata->ec.dockram, reg, ASUSEC_ENTRY_SIZE, buf);
+	if (ret < ASUSEC_ENTRY_SIZE)
+		return ret < 0 ? ret : -EIO;
+
+	if (buf[0] > ASUSEC_ENTRY_SIZE) {
+		dev_err(dev, "bad data len; buffer: %*ph; ret: %d\n", ASUSEC_ENTRY_BUFSIZE, buf,
+			ret);
+		return -EPROTO;
+	}
+
+	dev_info(dev, "%-14s: %.*s\n", name, buf[0], buf + 1);
+
+	if (!ddata->ec.model) {
+		ddata->ec.model = devm_kasprintf(dev, GFP_KERNEL, "%.*s", buf[0], buf + 1);
+		if (!ddata->ec.model)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int asus_ec_detect(struct asus_ec_data *ddata)
+{
+	int ret;
+
+	ret = asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_MODEL, "Model");
+	if (ret)
+		return ret;
+
+	ret = asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_FW, "FW version");
+	if (ret)
+		return ret;
+
+	ret = asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_CFGFMT, "Config format");
+	if (ret)
+		return ret;
+
+	ret = asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_HW, "HW version");
+	if (ret)
+		return ret;
+
+	ddata->ec.name = ddata->info->name;
+	ddata->ec.keyboard_mask = ddata->info->keyboard_mask;
+
+	return 0;
+}
+
+static int asus_ec_reset(struct asus_ec_data *ddata)
+{
+	int ret;
+
+	guard(mutex)(&ddata->ecreq_lock);
+
+	for (int retry = 0; retry < ASUSEC_RETRY_MAX; retry++) {
+		ret = i2c_smbus_write_word_data(ddata->client, ASUSEC_WRITE_BUF, ASUSEC_RESET);
+		if (!ret)
+			return 0;
+
+		msleep(ASUSEC_ACCESS_TIMEOUT);
+	}
+
+	return ret;
+}
+
+static void asus_ec_clear_buffer(struct asus_ec_data *ddata)
+{
+	int ret, retry = ASUSEC_RSP_BUFFER_SIZE;
+
+	/*
+	 * Read the buffer till we get valid data by checking ASUSEC_OBF_MASK
+	 * of the status byte or till we reach end of the 256 byte buffer.
+	 */
+	while (retry--) {
+		ret = i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
+						    ddata->info->read_size, ddata->ec_buf);
+		if (ret < ddata->info->read_size)
+			continue;
+
+		if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
+			continue;
+
+		break;
+	}
+}
+
+static int asus_ec_susb_on_status(struct asus_ec_data *ddata)
+{
+	u64 flag;
+	int ret;
+
+	ret = asus_dockram_access_ctl(ddata->ec.dockram, &flag, 0, 0);
+	if (ret)
+		return ret;
+
+	flag &= ASUSEC_CTL_SUSB_MODE;
+	dev_info(&ddata->client->dev, "EC FW behaviour: %s\n",
+		 flag ? "susb on when receive ec_req" : "susb on when system wakeup");
+
+	return 0;
+}
+
+static int asus_ec_set_factory_mode(struct asus_ec_data *ddata,
+				    enum asusec_mode fmode)
+{
+	dev_info(&ddata->client->dev, "Entering %s mode.\n",
+		 fmode == ASUSEC_MODE_FACTORY ? "factory" : "normal");
+
+	return asus_dockram_access_ctl(ddata->ec.dockram, NULL, ASUSEC_CTL_FACTORY_MODE,
+				       fmode == ASUSEC_MODE_FACTORY ? ASUSEC_CTL_FACTORY_MODE : 0);
+}
+
+static int asus_ec_init(struct asus_ec_data *ddata)
+{
+	int ret;
+
+	ret = asus_ec_reset(ddata);
+	if (ret)
+		goto err_exit;
+
+	asus_ec_clear_buffer(ddata);
+
+	/* Check and inform about EC firmware behavior */
+	ret = asus_ec_susb_on_status(ddata);
+	if (ret)
+		goto err_exit;
+
+	/* Some EC require factory mode to be set normal on each request */
+	if (ddata->info->fmode)
+		ret = asus_ec_set_factory_mode(ddata, ddata->info->fmode);
+
+err_exit:
+	if (ret)
+		dev_err(&ddata->client->dev, "failed to access EC: %d\n", ret);
+
+	return ret;
+}
+
+static void asus_ec_handle_smi(struct asus_ec_data *ddata, unsigned int code)
+{
+	switch (code) {
+	case ASUSEC_SMI_HANDSHAKE:
+	case ASUSEC_SMI_RESET:
+		asus_ec_init(ddata);
+		break;
+	}
+}
+
+static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
+{
+	struct asus_ec_data *ddata = dev_id;
+	unsigned long notify_action;
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
+					    ddata->info->read_size, ddata->ec_buf);
+	if (ret < ddata->info->read_size)
+		return IRQ_NONE;
+
+	/* Check status byte with ASUSEC_OBF_MASK if data is valid */
+	ret = ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK;
+	if (!ret)
+		return IRQ_NONE;
+
+	notify_action = ddata->ec_buf[ASUSEC_IRQ_STATUS];
+	if (notify_action & ASUSEC_SMI_MASK) {
+		unsigned int code = ddata->ec_buf[ASUSEC_SMI_CODE];
+
+		asus_ec_handle_smi(ddata, code);
+
+		notify_action |= code << 8;
+	}
+
+	blocking_notifier_call_chain(&ddata->ec.notify_list, notify_action, ddata->ec_buf);
+
+	return IRQ_HANDLED;
+}
+
+static void asus_ec_release_dockram_dev(void *client)
+{
+	i2c_unregister_device(client);
+}
+
+static struct i2c_client *devm_asus_dockram_get(struct device *dev)
+{
+	struct i2c_client *parent = to_i2c_client(dev);
+	struct i2c_client *dockram;
+	struct dockram_ec_data *ddata;
+	int ret;
+
+	dockram = i2c_new_ancillary_device(parent, "dockram",
+					   parent->addr + ASUSEC_DOCKRAM_OFFSET);
+	if (IS_ERR(dockram))
+		return dockram;
+
+	ret = devm_add_action_or_reset(dev, asus_ec_release_dockram_dev, dockram);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ddata = devm_kzalloc(&dockram->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return ERR_PTR(-ENOMEM);
+
+	i2c_set_clientdata(dockram, ddata);
+	mutex_init(&ddata->ctl_lock);
+
+	return dockram;
+}
+
+static const struct mfd_cell asus_ec_sl101_dock_mfd_devices[] = {
+	MFD_CELL_NAME("asus-transformer-ec-kbc"),
+};
+
+static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] = {
+	MFD_CELL_NAME("asus-transformer-ec-battery"),
+	MFD_CELL_NAME("asus-transformer-ec-charger"),
+	MFD_CELL_NAME("asus-transformer-ec-led"),
+	MFD_CELL_NAME("asus-transformer-ec-kbc"),
+	MFD_CELL_NAME("asus-transformer-ec-keys"),
+};
+
+static const struct mfd_cell asus_ec_tf201_pad_mfd_devices[] = {
+	MFD_CELL_NAME("asus-transformer-ec-battery"),
+	MFD_CELL_NAME("asus-transformer-ec-led"),
+};
+
+static const struct mfd_cell asus_ec_tf600t_pad_mfd_devices[] = {
+	MFD_CELL_NAME("asus-transformer-ec-battery"),
+	MFD_CELL_NAME("asus-transformer-ec-charger"),
+	MFD_CELL_NAME("asus-transformer-ec-led"),
+};
+
+static int asus_ec_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct asus_ec_data *ddata;
+	const struct mfd_cell *cells;
+	unsigned int num_cells;
+	unsigned long irqflags;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return dev_err_probe(dev, -ENXIO,
+			"I2C bus is missing required SMBus block mode support\n");
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->info = device_get_match_data(dev);
+	if (!ddata->info)
+		return -ENODEV;
+
+	switch (ddata->info->variant) {
+	case ASUSEC_SL101_DOCK:
+		cells = asus_ec_sl101_dock_mfd_devices;
+		num_cells = ARRAY_SIZE(asus_ec_sl101_dock_mfd_devices);
+		break;
+	case ASUSEC_TF101_DOCK:
+		cells = asus_ec_tf101_dock_mfd_devices;
+		num_cells = ARRAY_SIZE(asus_ec_tf101_dock_mfd_devices);
+		break;
+	case ASUSEC_TF201_PAD:
+		cells = asus_ec_tf201_pad_mfd_devices;
+		num_cells = ARRAY_SIZE(asus_ec_tf201_pad_mfd_devices);
+		break;
+	case ASUSEC_TF600T_PAD:
+		cells = asus_ec_tf600t_pad_mfd_devices;
+		num_cells = ARRAY_SIZE(asus_ec_tf600t_pad_mfd_devices);
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unknown device variant %d\n",
+				     ddata->info->variant);
+	}
+
+	i2c_set_clientdata(client, ddata);
+	ddata->client = client;
+
+	ddata->ec.dockram = devm_asus_dockram_get(dev);
+	if (IS_ERR(ddata->ec.dockram))
+		return dev_err_probe(dev, PTR_ERR(ddata->ec.dockram), "Failed to get DockRam\n");
+
+	ddata->ecreq_gpio = devm_gpiod_get(dev, "request", GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->ecreq_gpio))
+		return dev_err_probe(dev, PTR_ERR(ddata->ecreq_gpio),
+				     "Failed to get EC request GPIO\n");
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&ddata->ec.notify_list);
+	mutex_init(&ddata->ecreq_lock);
+
+	asus_ec_signal_request(ddata);
+
+	ret = asus_ec_detect(ddata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to detect EC version\n");
+
+	ret = asus_ec_init(ddata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init EC\n");
+
+	/*
+	 * Systems using device tree should set up interrupt via DTS,
+	 * the rest will use the default low interrupt.
+	 */
+	irqflags = dev->of_node ? 0 : IRQF_TRIGGER_LOW;
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, &asus_ec_interrupt,
+					IRQF_ONESHOT | irqflags, client->name, ddata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register IRQ\n");
+
+	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
+	client->dev.coherent_dma_mask = 0;
+	client->dev.dma_mask = &client->dev.coherent_dma_mask;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, num_cells, NULL, 0, NULL);
+}
+
+static const struct asus_ec_chip_info asus_ec_sl101_dock_data = {
+	.name = "dock",
+	.variant = ASUSEC_SL101_DOCK,
+	.fmode = ASUSEC_MODE_NONE,
+	.read_size = ASUSEC_SL101_ENTRY_SIZE,
+	.keyboard_mask = ASUSEC_OBF_MASK,
+};
+
+static const struct asus_ec_chip_info asus_ec_tf101_dock_data = {
+	.name = "dock",
+	.variant = ASUSEC_TF101_DOCK,
+	.fmode = ASUSEC_MODE_NONE,
+	.read_size = ASUSEC_ENTRY_SIZE,
+	.keyboard_mask = ASUSEC_KBC_MASK | ASUSEC_KEY_MASK,
+};
+
+static const struct asus_ec_chip_info asus_ec_tf201_pad_data = {
+	.name = "pad",
+	.variant = ASUSEC_TF201_PAD,
+	.fmode = ASUSEC_MODE_NORMAL,
+	.read_size = ASUSEC_ENTRY_SIZE,
+	.keyboard_mask = ASUSEC_KBC_MASK | ASUSEC_KEY_MASK,
+};
+
+static const struct asus_ec_chip_info asus_ec_tf600t_pad_data = {
+	.name = "pad",
+	.variant = ASUSEC_TF600T_PAD,
+	.fmode = ASUSEC_MODE_NORMAL,
+	.read_size = ASUSEC_ENTRY_SIZE,
+	.keyboard_mask = ASUSEC_KBC_MASK | ASUSEC_KEY_MASK,
+};
+
+static const struct of_device_id asus_ec_match[] = {
+	{
+		.compatible = "asus,sl101-ec-dock",
+		.data = &asus_ec_sl101_dock_data,
+	}, {
+		.compatible = "asus,tf101-ec-dock",
+		.data = &asus_ec_tf101_dock_data,
+	}, {
+		.compatible = "asus,tf201-ec-pad",
+		.data = &asus_ec_tf201_pad_data,
+	}, {
+		.compatible = "asus,tf600t-ec-pad",
+		.data = &asus_ec_tf600t_pad_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_match);
+
+static struct i2c_driver asus_ec_driver = {
+	.driver	= {
+		.name = "asus-transformer-ec",
+		.of_match_table = asus_ec_match,
+	},
+	.probe = asus_ec_probe,
+};
+module_i2c_driver(asus_ec_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's EC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/asus-transformer-ec.h
new file mode 100644
index 0000000000000..fda6fb08cc41a
--- /dev/null
+++ b/include/linux/mfd/asus-transformer-ec.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MFD_ASUS_TRANSFORMER_EC_H
+#define __MFD_ASUS_TRANSFORMER_EC_H
+
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+
+#define ASUSEC_ENTRIES			0x100
+#define ASUSEC_ENTRY_SIZE		32
+#define ASUSEC_ENTRY_BUFSIZE		(ASUSEC_ENTRY_SIZE + 1)
+
+struct i2c_client;
+
+/**
+ * struct asusec_core - public part shared with all cells
+ *
+ * @model: firmware version running on the EC
+ * @name: prefix associated with the EC
+ * @dockram: pointer to Dockram's i2c_client
+ * @notify_list: notify list used by cells
+ * @keyboard_mask: mask of keyboard packets
+ * @ext_keys_enabled: true if extension keys driver is active
+ * @right_alt_pressed: state of Right Alt (AltGr) key
+ * @special_combo_triggered: true if AltGr + extension key combo was triggered
+ */
+struct asusec_core {
+	const char *model;
+	const char *name;
+	struct i2c_client *dockram;
+	struct blocking_notifier_head notify_list;
+	u8 keyboard_mask;
+	bool ext_keys_enabled;
+	bool right_alt_pressed;
+	bool special_combo_triggered;
+};
+
+/* interrupt sources */
+#define ASUSEC_IRQ_STATUS		1
+#define ASUSEC_OBF_MASK			BIT(0)
+#define ASUSEC_KEY_MASK			BIT(2)
+#define ASUSEC_KBC_MASK			BIT(3)
+#define ASUSEC_AUX_MASK			BIT(5)
+#define ASUSEC_SCI_MASK			BIT(6)
+#define ASUSEC_SMI_MASK			BIT(7)
+
+/* SMI notification codes */
+#define ASUSEC_SMI_CODE			2
+#define ASUSEC_SMI_POWER_NOTIFY		0x31	/* USB cable plug event */
+#define ASUSEC_SMI_HANDSHAKE		0x50	/* response to ec_req edge */
+#define ASUSEC_SMI_WAKE			0x53
+#define ASUSEC_SMI_RESET		0x5f
+#define ASUSEC_SMI_ADAPTER_EVENT	0x60	/* charger to dock plug event */
+#define ASUSEC_SMI_BACKLIGHT_ON		0x63
+#define ASUSEC_SMI_AUDIO_DOCK_IN	0x70
+
+#define ASUSEC_SMI_ACTION(code)		(ASUSEC_SMI_MASK | ASUSEC_OBF_MASK | \
+					(ASUSEC_SMI_##code << 8))
+
+/* control register [0x0a] layout */
+#define ASUSEC_CTL_SIZE			8
+
+/*
+ * EC reports power from 40-pin connector in the LSB of the control
+ * register.  The following values have been observed (xor 0x02):
+ *
+ * PAD-ec no-plug  0x40 / PAD-ec DOCK     0x20 / DOCK-ec no-plug 0x40
+ * PAD-ec AC       0x25 / PAD-ec DOCK+AC  0x24 / DOCK-ec AC      0x25
+ * PAD-ec USB      0x45 / PAD-ec DOCK+USB 0x24 / DOCK-ec USB     0x41
+ */
+
+#define ASUSEC_CTL_DIRECT_POWER_SOURCE	BIT_ULL(0)
+#define ASUSEC_STAT_CHARGING		BIT_ULL(2)
+#define ASUSEC_CTL_FULL_POWER_SOURCE	BIT_ULL(5)
+#define ASUSEC_CTL_SUSB_MODE		BIT_ULL(9)
+#define ASUSEC_CMD_SUSPEND_S3		BIT_ULL(33)
+#define ASUSEC_CTL_TEST_DISCHARGE	BIT_ULL(35)
+#define ASUSEC_CMD_SUSPEND_INHIBIT	BIT_ULL(37)
+#define ASUSEC_CTL_FACTORY_MODE		BIT_ULL(38)
+#define ASUSEC_CTL_KEEP_AWAKE		BIT_ULL(39)
+#define ASUSEC_CTL_USB_CHARGE		BIT_ULL(40)
+#define ASUSEC_CTL_LED_BLINK		BIT_ULL(40)
+#define ASUSEC_CTL_LED_AMBER		BIT_ULL(41)
+#define ASUSEC_CTL_LED_GREEN		BIT_ULL(42)
+#define ASUSEC_CMD_SWITCH_HDMI		BIT_ULL(56)
+#define ASUSEC_CMD_WIN_SHUTDOWN		BIT_ULL(62)
+
+#define ASUSEC_DOCKRAM_INFO_MODEL	0x01
+#define ASUSEC_DOCKRAM_INFO_FW		0x02
+#define ASUSEC_DOCKRAM_INFO_CFGFMT	0x03
+#define ASUSEC_DOCKRAM_INFO_HW		0x04
+#define ASUSEC_DOCKRAM_CONTROL		0x0a
+#define ASUSEC_DOCKRAM_BATT_CTL		0x14
+
+#define ASUSEC_WRITE_BUF		0x64
+#define ASUSEC_READ_BUF			0x6a
+
+int asus_dockram_access_ctl(struct i2c_client *client,
+			    u64 *out, u64 mask, u64 xor);
+
+#endif /* __MFD_ASUS_TRANSFORMER_EC_H */
-- 
2.53.0

