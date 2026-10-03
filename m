Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FC330659;
	Sat,  3 Oct 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038119; cv=none; b=ObZVvgKOJ/8KbHymaqKDPFl4Co887TJTtvIgQ2WVInKtzFT4IyREzeR0KhKi4MT+DDkSSsL7CAhFQKjKlaaddttuqxT23JpL5LPXzTy8GAoKAxCWMAgM88NuW+BYNVz2P8FKMQGp2oqU8Kor1u7KTr2F21pSoLmffjS+tM812LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038119; c=relaxed/simple;
	bh=4Aanp2WwjbJa5F/BZ9djoclmyC01Z1H/dD54Nn37gFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNdpFmOqu4v2IScIjN55Jbo/tdNT4tZGo224rg+urHRcRDPzgJA3TEPbcHbv72sa8vFO2fSZ0BcvpewMg01JtAOSh2tVaihq2ksOU2nsqStCqy58x+5Dj1Xr9aXNaNt/uPSNj2qprBLCLbH+DJXNmdj2jO5WKuP/1z9Lm6vvntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=CJ80KUgt; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="CJ80KUgt"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791037671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBNWHT4zmYLHY4YuP3DZLBFkghTYi5YIb06vr+tOSbs=;
	b=CJ80KUgtCYXRZtHqLASY7bcpkjb7VIz2W7FOjKjOQ7dhCqXBePr8JoB6hpZAr4MblVuECe
	sMY6tI3xK2Vhex+qCTaOCbKoJwDp+KDKYUwAP1Z++8cmzD6SVp89TqwPn0Z0/IhWnrwq8U
	TaLh8sLQQUJZmqZEV9XL4K82dfsaqVp0YWU7Z+T3kdxWPc3+sSWdto2cEX2FzgZEl/dQqr
	R1kXa0bNjLtv1VclIpbhGZdN/D4Tr+HKUXvF1oY5/OIuKRmu2v8s7+RdjzgX+Puaf48nj5
	9+fX2nbBo8BwdSLHmJuOp5sdLAhUu7P5qBytJI2S+LMav+D+MHiRWnjIha0xeQ==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen Lin <allencl_lin@hotmail.com>,
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
	Felix Kaechele <felix@kaechele.ca>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v5 3/6] HID: himax: Add DRM panel follower support
Date: Sat,  3 Oct 2026 16:27:38 +0200
Message-ID: <20261003142741.48634-4-michal@nozomi.space>
In-Reply-To: <20261003142741.48634-1-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Allen_Lin <allencl_lin@hotmail.com>

The touch function of the HX83102J is part of a TDDI controller and has
to follow the power sequence of the panel. Register as a DRM panel
follower, and suspend and resume the touch function when the panel is
unprepared and prepared.

Link: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org
Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
[michal@nozomi.space: unregister the panel follower on remove]
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/hid/hid-himax.c | 295 +++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-himax.h |  10 ++
 2 files changed, 289 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
index 1cdb310dec642..653c92829ec7f 100644
--- a/drivers/hid/hid-himax.c
+++ b/drivers/hid/hid-himax.c
@@ -8,6 +8,7 @@
 #include "hid-himax.h"
 
 static int himax_chip_init(struct himax_ts_data *ts);
+static int himax_platform_init(struct himax_ts_data *ts);
 static void himax_ts_work(struct himax_ts_data *ts);
 
 /**
@@ -1145,7 +1146,6 @@ static int himax_hid_probe(struct himax_ts_data *ts)
 
 	hid = ts->hid;
 	if (hid) {
-		dev_warn(ts->dev, "%s: hid device already exist!\n", __func__);
 		hid_destroy_device(hid);
 		hid = NULL;
 	}
@@ -1501,6 +1501,154 @@ static int himax_load_config(struct himax_ts_data *ts)
 	return -EINVAL;
 }
 
+/**
+ * himax_ap_notify_fw_suspend() - Notify the FW of AP suspend status
+ * @ts: Himax touch screen data
+ * @suspend: Suspend status, true for suspend, false for resume
+ *
+ * This function is used to notify the FW of AP suspend status. It will write
+ * the suspend status to the DSRAM and read the status back to check if the
+ * status is written successfully. If IC is powered off when suspend, this
+ * function will only be used when resume.
+ *
+ * Return: None
+ */
+static void himax_ap_notify_fw_suspend(struct himax_ts_data *ts, bool suspend)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 retry_limit = 10;
+	union himax_dword_data rdata, data;
+
+	if (suspend)
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND);
+	else
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME);
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					       data.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: write suspend status failed!\n", __func__);
+			return;
+		}
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					      rdata.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: read suspend status failed!\n", __func__);
+			return;
+		}
+
+		if (rdata.dword == data.dword)
+			break;
+	}
+}
+
+/**
+ * himax_resume_proc() - Chip resume procedure of touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will call the
+ * himax_ap_notify_fw_suspend() to notify the FW of AP resume status.
+ *
+ * Return: None
+ */
+static void himax_resume_proc(struct himax_ts_data *ts)
+{
+	himax_ap_notify_fw_suspend(ts, false);
+}
+
+/**
+ * himax_chip_suspend() - Suspend the touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to suspend the touch screen. It will disable the
+ * interrupt and set the reset pin to activate state. Remove the HID at
+ * the end, to prevent stuck finger when resume.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	himax_int_enable(ts, false);
+	gpiod_set_value(ts->pdata.gpiod_rst, 1);
+	himax_power_set(ts, false);
+	himax_hid_remove(ts);
+
+	return 0;
+}
+
+/**
+ * himax_chip_resume() - Setup flags, I/O and resume
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will set the resume
+ * success flag to false, and disable reset pin. Then call the himax_resume_proc()
+ * to process detailed resume procedure.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_resume(struct himax_ts_data *ts)
+{
+	if (himax_power_set(ts, true))
+		return -EIO;
+	gpiod_set_value(ts->pdata.gpiod_rst, 0);
+	himax_resume_proc(ts);
+	himax_hid_probe(ts);
+	himax_int_enable(ts, true);
+
+	return 0;
+}
+
+/**
+ * himax_suspend() - Suspend the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_suspend() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		dev_err(ts->dev, "%s: init not ready, skip!\n", __func__);
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+
+	return 0;
+}
+
+/**
+ * himax_resume() - Resume the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_resume() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_resume(struct device *dev)
+{
+	int ret;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		if (himax_chip_init(ts))
+			return -ECANCELED;
+	}
+
+	ret = himax_chip_resume(ts);
+	if (ret < 0)
+		dev_err(ts->dev, "%s: resume failed!\n", __func__);
+
+	return ret;
+}
+
 /**
  * himax_chip_init() - Initialize the Himax touch screen
  * @ts: Himax touch screen data
@@ -1531,6 +1679,130 @@ static int himax_chip_init(struct himax_ts_data *ts)
 	return 0;
 }
 
+/**
+ * __himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to perform the initial power up sequence of the Himax
+ * touch screen for DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __himax_initial_power_up(struct himax_ts_data *ts)
+{
+	int ret;
+
+	ret = himax_platform_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: platform init failed\n", __func__);
+		return ret;
+	}
+
+	ret = himax_chip_detect(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
+		return ret;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: chip init failed\n", __func__);
+		return ret;
+	}
+	ts->probe_finish = true;
+
+	return 0;
+}
+
+/**
+ * himax_panel_prepared() - Panel prepared callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is prepared. It will call the
+ * __himax_initial_power_up() when the probe is not finished which means
+ * the first time driver start. Otherwise, it will call the himax_resume()
+ * to performed resume process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	if (!ts->probe_finish)
+		return __himax_initial_power_up(ts);
+	else
+		return himax_resume(ts->dev);
+}
+
+/**
+ * himax_panel_unpreparing() - Panel unpreparing callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is unpreparing. It will call the
+ * himax_suspend() to perform the suspend process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	return himax_suspend(ts->dev);
+}
+
+/* Panel follower function table */
+static const struct drm_panel_follower_funcs himax_panel_follower_funcs = {
+	.panel_prepared = himax_panel_prepared,
+	.panel_unpreparing = himax_panel_unpreparing,
+};
+
+/**
+ * himax_register_panel_follower() - Register the panel follower
+ * @ts: Himax touch screen data
+ *
+ * This function is used to register the panel follower. It will set the
+ * pdata.is_panel_follower to true and register the panel follower.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_register_panel_follower(struct himax_ts_data *ts)
+{
+	struct device *dev = ts->dev;
+
+	ts->pdata.is_panel_follower = true;
+	ts->pdata.panel_follower.funcs = &himax_panel_follower_funcs;
+
+	if (device_can_wakeup(dev)) {
+		dev_warn(ts->dev, "Can't wakeup if following panel");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &ts->pdata.panel_follower);
+}
+
+/**
+ * himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function checks if the device is a panel follower and calls
+ * himax_register_panel_follower() if it is. Otherwise, it calls
+ * __himax_initial_power_up().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_initial_power_up(struct himax_ts_data *ts)
+{
+	if (drm_is_panel_follower(ts->dev))
+		return himax_register_panel_follower(ts);
+	else
+		return __himax_initial_power_up(ts);
+}
+
 /**
  * himax_platform_deinit() - Deinitialize the platform related settings
  * @ts: Pointer to the himax_ts_data structure
@@ -1660,25 +1932,13 @@ static int himax_spi_drv_probe(struct spi_device *spi)
 	ts->initialized = false;
 	ts->ic_boot_done = false;
 
-	ret = himax_platform_init(ts);
-	if (ret) {
-		dev_err(ts->dev, "%s: platform init failed\n", __func__);
-		return ret;
-	}
-
-	ret = himax_chip_detect(ts);
+	ret = himax_initial_power_up(ts);
 	if (ret) {
-		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
-		return ret;
+		dev_err(ts->dev, "%s: initial power up failed\n", __func__);
+		return -ENODEV;
 	}
 
-	ret = himax_chip_init(ts);
-	if (ret < 0)
-		return ret;
-	ts->probe_finish = true;
-
 	return ret;
-	himax_platform_deinit(ts);
 }
 
 /**
@@ -1693,6 +1953,9 @@ static void himax_spi_drv_remove(struct spi_device *spi)
 {
 	struct himax_ts_data *ts = spi_get_drvdata(spi);
 
+	if (ts->pdata.is_panel_follower)
+		drm_panel_remove_follower(&ts->pdata.panel_follower);
+
 	if (ts->probe_finish) {
 		if (ts->ic_boot_done) {
 			himax_int_enable(ts, false);
diff --git a/drivers/hid/hid-himax.h b/drivers/hid/hid-himax.h
index 1818474552a92..0ec43fc00a469 100644
--- a/drivers/hid/hid-himax.h
+++ b/drivers/hid/hid-himax.h
@@ -8,6 +8,7 @@
 #ifndef __HID_HIMAX_83102J_H__
 #define __HID_HIMAX_83102J_H__
 
+#include <drm/drm_panel.h>
 #include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,11 @@
 #define HIMAX_AHB_CMD_INCR4				0x10
 #define HIMAX_AHB_CMD_INCR4_ADD_4_BYTE			0x01
 #define HIMAX_AHB_CMD_LEAVE_SAFE_MODE			0x0000
+/* DSRAM flag addresses */
+#define HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND		0x10007fd0
+/* dsram flag data */
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND		0xa55aa55a
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME		0x00000000
 /* hx83102j-specific register/dsram flags/data */
 #define HIMAX_HX83102J_REG_ADDR_TCON_RST		0x80020004
 /* hardware register addresses */
@@ -219,13 +225,17 @@ struct himax_hid_desc {
 
 /**
  * struct himax_platform_data - Platform data holder
+ * @is_panel_follower: Is panel follower enabled
  * @vccd_supply: VCCD supply
+ * @panel_follower: DRM panel follower
  * @gpiod_rst: GPIO reset
  *
  * This structure is used to hold the platform related data.
  */
 struct himax_platform_data {
+	bool is_panel_follower;
 	struct regulator *vccd_supply;
+	struct drm_panel_follower panel_follower;
 	struct gpio_desc *gpiod_rst;
 };
 
-- 
2.55.0

