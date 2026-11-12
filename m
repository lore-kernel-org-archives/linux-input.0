Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466205;
	b=4Qocw/9NkpLylmpUWLYq8m2zr69CHLq09qyBafIWkt2VbQkTsLjimULCPZe1Y4tPSy77
	 uazeQwLSVeu0Mg+8t4aqrXy1frlO+0iwdCX775U6FZBBOwaUCVB5zCzWLmt5W1hhAYj0i
	 y2a0oExFmKCau0WXHZ2sKxojdvPUtY1OmGTxGmK9AIlQktRdDQ0QaMF3maoG/OY9BFpvR
	 IrmhG7PPA8qb2KZBk8WTtQ2o7Tu7Y00WW7tESHdq92BcuJuIegITbsTT2Waa5wgZS3FNh
	 cH5GLMo6YRQdADlpQUK/qtCmzcXvATbT/qhTtuWrcVU1glbAOkGIr80wgzkK7Kq4E3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mOQDgVzOyktpz8+qz3IlalooRsKj4SHXFb4LM5pg8j4=;
	b=OhnHwqW2evChp3bErln/7u7Uif0bBLhZSzqqK4VZJasXrnN1GZ5MehO+pZzqDtkL46UN
	 Eqvl+Jhqjj13hAvT/yuqX6lnBuDRZCT93YlLAjJoIwwycZ9gKNI2O0nx7N00wlmxF68FZ
	 p2IxK6lzjOpnaNDmIOwtt9GEDKVPt2Bil9K2gFp59G/d0b0Iht7iD74nrtQiYVD5eashW
	 fScivJYbiwwthvjSNd0sUqm0BhcODZcN7LswqoSgY39IXZj/TnS7cw3twg5/9LK6OZjvC
	 c8rGJio39kgg6vsDnnlXsKgzoBfF0gqjdgztf09qG+UhcyrmIVDh+Gt8WH2dzn+1RVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyG+yWyJ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85B60A2636
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B85B60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyG+yWyJ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso5942994eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466204; x=1795071004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOQDgVzOyktpz8+qz3IlalooRsKj4SHXFb4LM5pg8j4=;
        b=DyG+yWyJp6unqrCxTWhL660epBUYvjEdhjvWkxvTNsvJsFTvFsOpOlYYS84Fdsm/NV
         hgf5g5DtJO2quifgZESmVxAqqKN10TDwlCRQZwM9S4ujQZV7rkP8cq45RMv4LHXWaebA
         jfa0bmBE8CdQlxBNs4tR+UmNUoCHA0Pg2NcyOCd4ghz0CLli6caA1G6DEZg/ysnSYHha
         O6cGoqxRcuaGIlYcctgCqRYbJ68MNjktzNpNIXp7U8uVp6P8vMuLMLurX04cGWgPu63x
         kZRNClnfnwqRNrsAJtKnqVR01WKcTzkM7wuLJNjP8JmS745MZa9XDIwiwRMb9fNF+qMK
         XT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466204; x=1795071004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOQDgVzOyktpz8+qz3IlalooRsKj4SHXFb4LM5pg8j4=;
        b=XxO8OXEyO09YRU2n+4hPY+2VPMJawYRLi8rSm0vg+aSrSe45+i5EpTYgb88sGI+bq2
         UIX62xZFqB7ugZZlyZkQRL+1Ztgux3wvX/dZ5X69BpgSy+qv9ybf2lEXyV6A9OzMid2+
         Aws3VKl6eZFDvV9XG/zRNkAaTK4L7taZyDShhhBYGL9YweiHV75/WfEjxB2vtxmccwZ6
         fFuov6ZIGTQZfJCHNvM1Rs2Up7cjdiTvMt85KfqZqUfkkYuPcJxzkP4MK1me4PLdIkg4
         oqz1VwtaCAkibkFwBiMyjWrnzaEU2rS/tL0emZQ4eGxAcqEmMV/OY+kjqI1s0jDwSPiv
         OV/Q==
X-Forwarded-Encrypted: i=1; AL+hErEAfE6c7ty9irhC8aOMBOAL4TFxFU9PIszdcsHYfa7tLIEHgVtkW21fHluSbrKCQcUU7Cs4xGiPD65l0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ImSHt6hBkZhEnCiNotN3s9g2qOVbyG+AlAQTWI+JNMAalbG+l
	pixt/ZMz9Mj6bkRbtikPfLpCktFPS4JnbQ3b4YJGHjelMxIAKp4ss7MV
X-Gm-Gg: AYBFou0Ajho+KCWTDf1WYq2KDFlYdbycnce2ruS7QuotlY6LyUuoc0B+QJHiif55rVE
	Im3gp63dQDPpxDK36zq5TUxEPajjmEulL8S6XxdI8C55itUnDGnbcqv6VYNeG+V51AWDe52hbEn
	PsZvVjO48eFQvg1DJHYmzz1UZgU/HGPFZ/JlmjyuGGr1yDo+zYfQhh+E/3d7GWb10sdgLcUvStV
	ly8Cwm6MMRqB2FvW262avEmsJGOqeWcu3kx0ZIHoRwyTBMNYINk+4lE/kANlZ4sFdFydGmk2gdf
	4B/FUj68r1oi1Xp05By7H7+WaWeAlvljmyDz12hqWMO+DPCdyG9LZAhc/YEBIeRWk1ZucoA6wwc
	rc6FyjhE+cJD47zmCzQsfEpmETQMPWwajKf0bXHj3DhSc0EhmkSnCAbgLb9CP5jPY9QtlFNey15
	//CpwPHJciu/Val1NlfY5uO7flKIKDzxl3S7xmgDasYuoUC/+FX3o0t/xJ1CqzZ8x/4xHitt8oe
	DBDSCz+2MnEmjKwJgNO2+3X8E3Goje8Xf23iPl363ou/3K4fiLvP+TwIHKwB8dVXCuv4L0CBCgQ
	2C63i6g9I3R/Ddt/WmJYIBaC2gBwSdbmA96crh92tanfifnq3cGMMDHlZqsyMDiOPnMQRSF/2xa
	itFeamUtO+0P/pi21PMqhkWA+xYtsqGJm+R8ODA==
X-Received: by 2002:a05:7301:3f19:b0:36a:532e:4abe with SMTP id 5a478bee46e88-3768701e279mr6579211eec.35.1794466204006;
        Wed, 11 Nov 2026 22:50:04 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:03 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: ads7846 - drop platform data support
Date: Wed, 11 Nov 2026 22:49:53 -0800
Message-ID: <20261112064957.1796975-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all in-tree board files (including board-nokia770, spitz, and
db1000) have been converted to Device Tree or software nodes, legacy
platform data support is no longer needed.

Remove struct ads7846_platform_data and associated callbacks, parse
device properties directly without allocating a temporary structure,
and delete the unused header file.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c           |   1 -
 drivers/input/touchscreen/ads7846.c | 230 ++++++++++------------------
 include/linux/spi/ads7846.h         |  45 ------
 3 files changed, 84 insertions(+), 192 deletions(-)
 delete mode 100644 include/linux/spi/ads7846.h

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 5eaf38243b9e..191292d10eb8 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -21,7 +21,6 @@
 #include <linux/platform_data/pca953x.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/mtd/physmap.h>
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 40652c0cfd22..9bcb2ef129cd 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -27,7 +27,6 @@
 #include <linux/property.h>
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
@@ -104,8 +103,9 @@ struct ads7846 {
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 	u16			pressure_max;
+	u16			settle_delay_usecs;
 
-	bool			swap_xy;
+	bool			keep_vref_on;
 	bool			use_internal;
 
 	struct ads7846_packet	*packet;
@@ -134,16 +134,11 @@ struct ads7846 {
 	bool			disabled;	/* P: lock */
 	bool			suspended;	/* P: lock */
 
-	int			(*setup_spi_msg)(struct ads7846 *ts,
-					const struct ads7846_platform_data *pdata);
 	void			(*read_state)(struct ads7846 *ts);
 	int			(*filter)(void *data, int data_idx, int *val);
 	void			*filter_data;
-	int			(*get_pendown_state)(void);
 	struct gpio_desc	*gpio_pendown;
 	struct gpio_desc	*gpio_hsync;
-
-	void			(*wait_for_sync)(void);
 };
 
 enum ads7846_filter {
@@ -221,9 +216,6 @@ enum ads7846_cmds {
 
 static int get_pendown_state(struct ads7846 *ts)
 {
-	if (ts->get_pendown_state)
-		return ts->get_pendown_state();
-
 	return gpiod_get_value(ts->gpio_pendown);
 }
 
@@ -811,11 +803,6 @@ static int ads7846_filter(struct ads7846 *ts)
 
 static void ads7846_wait_for_hsync(struct ads7846 *ts)
 {
-	if (ts->wait_for_sync) {
-		ts->wait_for_sync();
-		return;
-	}
-
 	if (!ts->gpio_hsync)
 		return;
 
@@ -1055,29 +1042,26 @@ static int ads7846_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
-static int ads7846_setup_pendown(struct spi_device *spi,
-				 struct ads7846 *ts,
-				 const struct ads7846_platform_data *pdata)
+static int ads7846_setup_pendown(struct ads7846 *ts)
 {
+	struct device *dev = &ts->spi->dev;
+	u32 debounce;
+
 	/*
 	 * REVISIT when the irq can be triggered active-low, or if for some
 	 * reason the touchscreen isn't hooked up, we don't need to access
 	 * the pendown state.
 	 */
-
-	if (pdata->get_pendown_state) {
-		ts->get_pendown_state = pdata->get_pendown_state;
-	} else {
-		ts->gpio_pendown = devm_gpiod_get(&spi->dev, "pendown", GPIOD_IN);
-		if (IS_ERR(ts->gpio_pendown)) {
-			dev_err(&spi->dev, "failed to request pendown GPIO\n");
-			return PTR_ERR(ts->gpio_pendown);
-		}
-		if (pdata->gpio_pendown_debounce)
-			gpiod_set_debounce(ts->gpio_pendown,
-					   pdata->gpio_pendown_debounce);
+	ts->gpio_pendown = devm_gpiod_get(dev, "pendown", GPIOD_IN);
+	if (IS_ERR(ts->gpio_pendown)) {
+		dev_err(dev, "failed to request pendown GPIO\n");
+		return PTR_ERR(ts->gpio_pendown);
 	}
 
+	if (!device_property_read_u32(dev, "ti,pendown-gpio-debounce",
+				      &debounce))
+		gpiod_set_debounce(ts->gpio_pendown, debounce);
+
 	return 0;
 }
 
@@ -1085,18 +1069,17 @@ static int ads7846_setup_pendown(struct spi_device *spi,
  * Set up the transfers to read touchscreen state; this assumes we
  * use formula #2 for pressure, not #3.
  */
-static int ads7846_halfd_spi_msg(struct ads7846 *ts,
-				 const struct ads7846_platform_data *pdata)
+static int ads7846_halfd_spi_msg(struct ads7846 *ts)
 {
 	struct spi_message *m = ts->msg;
 	struct spi_transfer *x = ts->xfer;
 	struct ads7846_packet *packet = ts->packet;
-	int vref = pdata->keep_vref_on;
+	int vref = ts->keep_vref_on;
 	unsigned int offset = 0;
 	unsigned int cmd_idx, b;
 	size_t size = 0;
 
-	if (pdata->settle_delay_usecs)
+	if (ts->settle_delay_usecs)
 		packet->count = 2;
 	else
 		packet->count = 1;
@@ -1166,7 +1149,7 @@ static int ads7846_halfd_spi_msg(struct ads7846 *ts,
 			x->rx_buf = &packet->rx[l->offset + b].data;
 			x->len = 2;
 			if (b < l->count - 1 && l->count > 1) {
-				x->delay.value = pdata->settle_delay_usecs;
+				x->delay.value = ts->settle_delay_usecs;
 				x->delay.unit = SPI_DELAY_UNIT_USECS;
 			}
 			spi_message_add_tail(x, m);
@@ -1181,13 +1164,12 @@ static int ads7846_halfd_spi_msg(struct ads7846 *ts,
  * Set up the transfers to read touchscreen state; this assumes we
  * use formula #2 for pressure, not #3.
  */
-static int ads7846_setup_spi_msg(struct ads7846 *ts,
-				  const struct ads7846_platform_data *pdata)
+static int ads7846_setup_spi_msg(struct ads7846 *ts)
 {
 	struct spi_message *m = &ts->msg[0];
 	struct spi_transfer *x = ts->xfer;
 	struct ads7846_packet *packet = ts->packet;
-	int vref = pdata->keep_vref_on;
+	int vref = ts->keep_vref_on;
 	unsigned int count, offset = 0;
 	unsigned int cmd_idx, b;
 	unsigned long time;
@@ -1196,7 +1178,7 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 	/* time per bit */
 	time = NSEC_PER_SEC / ts->spi->max_speed_hz;
 
-	count = pdata->settle_delay_usecs * NSEC_PER_USEC / time;
+	count = ts->settle_delay_usecs * NSEC_PER_USEC / time;
 	packet->count_skip = DIV_ROUND_UP(count, 24);
 
 	if (ts->debounce_max && ts->debounce_rep)
@@ -1293,61 +1275,6 @@ static const struct spi_device_id ads7846_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, ads7846_spi_ids);
 
-static const struct ads7846_platform_data *ads7846_get_props(struct device *dev)
-{
-	struct ads7846_platform_data *pdata;
-	u32 value;
-
-	pdata = devm_kzalloc_obj(dev, *pdata);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdata->model = (uintptr_t)device_get_match_data(dev);
-
-	device_property_read_u16(dev, "ti,vref-delay-usecs",
-				 &pdata->vref_delay_usecs);
-	device_property_read_u16(dev, "ti,vref-mv", &pdata->vref_mv);
-	pdata->keep_vref_on = device_property_read_bool(dev, "ti,keep-vref-on");
-
-	pdata->swap_xy = device_property_read_bool(dev, "ti,swap-xy");
-
-	device_property_read_u16(dev, "ti,settle-delay-usec",
-				 &pdata->settle_delay_usecs);
-	device_property_read_u16(dev, "ti,penirq-recheck-delay-usecs",
-				 &pdata->penirq_recheck_delay_usecs);
-
-	device_property_read_u16(dev, "ti,x-plate-ohms", &pdata->x_plate_ohms);
-	device_property_read_u16(dev, "ti,y-plate-ohms", &pdata->y_plate_ohms);
-
-	device_property_read_u16(dev, "ti,x-min", &pdata->x_min);
-	device_property_read_u16(dev, "ti,y-min", &pdata->y_min);
-	device_property_read_u16(dev, "ti,x-max", &pdata->x_max);
-	device_property_read_u16(dev, "ti,y-max", &pdata->y_max);
-
-	/*
-	 * touchscreen-max-pressure gets parsed during
-	 * touchscreen_parse_properties()
-	 */
-	device_property_read_u16(dev, "ti,pressure-min", &pdata->pressure_min);
-	if (!device_property_read_u32(dev, "touchscreen-min-pressure", &value))
-		pdata->pressure_min = (u16) value;
-	device_property_read_u16(dev, "ti,pressure-max", &pdata->pressure_max);
-
-	device_property_read_u16(dev, "ti,debounce-max", &pdata->debounce_max);
-	if (!device_property_read_u32(dev, "touchscreen-average-samples", &value))
-		pdata->debounce_max = (u16) value;
-	device_property_read_u16(dev, "ti,debounce-tol", &pdata->debounce_tol);
-	device_property_read_u16(dev, "ti,debounce-rep", &pdata->debounce_rep);
-
-	device_property_read_u32(dev, "ti,pendown-gpio-debounce",
-			     &pdata->gpio_pendown_debounce);
-
-	pdata->wakeup = device_property_read_bool(dev, "wakeup-source") ||
-			device_property_read_bool(dev, "linux,wakeup");
-
-	return pdata;
-}
-
 static void ads7846_regulator_disable(void *regulator)
 {
 	regulator_disable(regulator);
@@ -1355,12 +1282,15 @@ static void ads7846_regulator_disable(void *regulator)
 
 static int ads7846_probe(struct spi_device *spi)
 {
-	const struct ads7846_platform_data *pdata;
 	struct ads7846 *ts;
 	struct device *dev = &spi->dev;
 	struct ads7846_packet *packet;
 	struct input_dev *input_dev;
 	unsigned long irq_flags;
+	bool swap_xy;
+	u16 x_min = 0, y_min = 0, x_max = 0, y_max = 0;
+	u16 pressure_min = 0, pressure_max = 0;
+	u32 val32;
 	int err;
 
 	if (!spi->irq) {
@@ -1391,14 +1321,6 @@ static int ads7846_probe(struct spi_device *spi)
 	if (!ts)
 		return -ENOMEM;
 
-	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
-		ts->setup_spi_msg = ads7846_halfd_spi_msg;
-		ts->read_state    = ads7846_halfd_read_state;
-	} else {
-		ts->setup_spi_msg = ads7846_setup_spi_msg;
-		ts->read_state    = ads7846_read_state;
-	}
-
 	packet = devm_kzalloc_obj(dev, struct ads7846_packet);
 	if (!packet)
 		return -ENOMEM;
@@ -1416,40 +1338,48 @@ static int ads7846_probe(struct spi_device *spi)
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		pdata = ads7846_get_props(dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	}
+	ts->model = (uintptr_t)device_get_match_data(dev);
+	if (!ts->model)
+		ts->model = 7846;
+
+	device_property_read_u16(dev, "ti,vref-delay-usecs",
+				 &ts->vref_delay_usecs);
+	if (!ts->vref_delay_usecs)
+		ts->vref_delay_usecs = 100;
+
+	device_property_read_u16(dev, "ti,vref-mv", &ts->vref_mv);
+	ts->keep_vref_on = device_property_read_bool(dev, "ti,keep-vref-on");
+
+	swap_xy = device_property_read_bool(dev, "ti,swap-xy");
+
+	device_property_read_u16(dev, "ti,settle-delay-usec",
+				 &ts->settle_delay_usecs);
+	device_property_read_u16(dev, "ti,penirq-recheck-delay-usecs",
+				 &ts->penirq_recheck_delay_usecs);
+
+	device_property_read_u16(dev, "ti,x-plate-ohms", &ts->x_plate_ohms);
+	if (!ts->x_plate_ohms)
+		ts->x_plate_ohms = 400;
 
-	ts->model = pdata->model ? : 7846;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->vref_mv = pdata->vref_mv;
+	device_property_read_u16(dev, "ti,debounce-max", &ts->debounce_max);
+	if (!device_property_read_u32(dev, "touchscreen-average-samples", &val32))
+		ts->debounce_max = (u16)val32;
+	device_property_read_u16(dev, "ti,debounce-tol", &ts->debounce_tol);
+	device_property_read_u16(dev, "ti,debounce-rep", &ts->debounce_rep);
 
-	if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
+	if (ts->debounce_max) {
 		if (ts->debounce_max < 2)
 			ts->debounce_max = 2;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
 		ts->filter = ads7846_debounce_filter;
 		ts->filter_data = ts;
 	} else {
 		ts->filter = ads7846_no_filter;
 	}
 
-	err = ads7846_setup_pendown(spi, ts, pdata);
+	err = ads7846_setup_pendown(ts);
 	if (err)
 		return err;
 
-	if (pdata->penirq_recheck_delay_usecs)
-		ts->penirq_recheck_delay_usecs =
-				pdata->penirq_recheck_delay_usecs;
-
-	ts->wait_for_sync = pdata->wait_for_sync;
-
 	ts->gpio_hsync = devm_gpiod_get_optional(dev, "ti,hsync", GPIOD_IN);
 	if (IS_ERR(ts->gpio_hsync))
 		return PTR_ERR(ts->gpio_hsync);
@@ -1461,20 +1391,28 @@ static int ads7846_probe(struct spi_device *spi)
 	input_dev->phys = ts->phys;
 
 	input_dev->id.bustype = BUS_SPI;
-	input_dev->id.product = pdata->model;
+	input_dev->id.product = ts->model;
+
+	device_property_read_u16(dev, "ti,x-min", &x_min);
+	device_property_read_u16(dev, "ti,y-min", &y_min);
+	device_property_read_u16(dev, "ti,x-max", &x_max);
+	device_property_read_u16(dev, "ti,y-max", &y_max);
 
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
-			0, 0);
+			     x_min, x_max ? : MAX_12BIT, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
-			0, 0);
-	if (ts->model != 7845)
+			     y_min, y_max ? : MAX_12BIT, 0, 0);
+
+	if (ts->model != 7845) {
+		device_property_read_u16(dev, "ti,pressure-min", &pressure_min);
+		if (!device_property_read_u32(dev, "touchscreen-min-pressure", &val32))
+			pressure_min = (u16)val32;
+		device_property_read_u16(dev, "ti,pressure-max", &pressure_max);
+
 		input_set_abs_params(input_dev, ABS_PRESSURE,
-				pdata->pressure_min, pdata->pressure_max, 0, 0);
+				     pressure_min, pressure_max, 0, 0);
+	}
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
@@ -1488,12 +1426,18 @@ static int ads7846_probe(struct spi_device *spi)
 	 * Check if legacy ti,swap-xy binding is used instead of
 	 * touchscreen-swapped-x-y
 	 */
-	if (!ts->core_prop.swap_x_y && pdata->swap_xy) {
+	if (!ts->core_prop.swap_x_y && swap_xy) {
 		swap(input_dev->absinfo[ABS_X], input_dev->absinfo[ABS_Y]);
 		ts->core_prop.swap_x_y = true;
 	}
 
-	err = ts->setup_spi_msg(ts, pdata);
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		ts->read_state = ads7846_halfd_read_state;
+		err = ads7846_halfd_spi_msg(ts);
+	} else {
+		ts->read_state = ads7846_read_state;
+		err = ads7846_setup_spi_msg(ts);
+	}
 	if (err)
 		return err;
 
@@ -1514,13 +1458,12 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
-	irq_flags |= IRQF_ONESHOT;
+	irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 
 	err = devm_request_threaded_irq(dev, spi->irq,
 					ads7846_hard_irq, ads7846_irq,
 					irq_flags, dev->driver->name, ts);
-	if (err && err != -EPROBE_DEFER && !pdata->irq_flags) {
+	if (err && err != -EPROBE_DEFER) {
 		dev_info(dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
 		irq_flags |= IRQF_TRIGGER_RISING;
@@ -1554,14 +1497,9 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	device_init_wakeup(dev, pdata->wakeup);
-
-	/*
-	 * If device does not carry platform data we must have allocated it
-	 * when parsing DT data.
-	 */
-	if (!dev_get_platdata(dev))
-		devm_kfree(dev, (void *)pdata);
+	device_init_wakeup(dev,
+			   device_property_read_bool(dev, "wakeup-source") ||
+			   device_property_read_bool(dev, "linux,wakeup"));
 
 	return 0;
 }
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
deleted file mode 100644
index a04c1c34c344..000000000000
--- a/include/linux/spi/ads7846.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* linux/spi/ads7846.h */
-
-struct ads7846_platform_data {
-	u16	model;			/* 7843, 7845, 7846, 7873. */
-	u16	vref_delay_usecs;	/* 0 for external vref; etc */
-	u16	vref_mv;		/* external vref value, milliVolts
-					 * ads7846: if 0, use internal vref */
-	bool	keep_vref_on;		/* set to keep vref on for differential
-					 * measurements as well */
-	bool	swap_xy;		/* swap x and y axes */
-
-	/* Settling time of the analog signals; a function of Vcc and the
-	 * capacitance on the X/Y drivers.  If set to non-zero, two samples
-	 * are taken with settle_delay us apart, and the second one is used.
-	 * ~150 uSec with 0.01uF caps.
-	 */
-	u16	settle_delay_usecs;
-
-	/* If set to non-zero, after samples are taken this delay is applied
-	 * and penirq is rechecked, to help avoid false events.  This value
-	 * is affected by the material used to build the touch layer.
-	 */
-	u16	penirq_recheck_delay_usecs;
-
-	u16	x_plate_ohms;
-	u16	y_plate_ohms;
-
-	u16	x_min, x_max;
-	u16	y_min, y_max;
-	u16	pressure_min, pressure_max;
-
-	u16	debounce_max;		/* max number of additional readings
-					 * per sample */
-	u16	debounce_tol;		/* tolerance used for filtering */
-	u16	debounce_rep;		/* additional consecutive good readings
-					 * required after the first two */
-	int	gpio_pendown_debounce;	/* platform specific debounce time for
-					 * the gpio_pendown */
-	int	(*get_pendown_state)(void);
-	void	(*wait_for_sync)(void);
-	bool	wakeup;
-	unsigned long irq_flags;
-};
-
-- 
2.56.0.567.gdb80ae8cd5-goog

