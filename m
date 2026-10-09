Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E0509F17
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584815; cv=none; b=X0yAB70KfK5AEULgpHYM3BaPVCqwJgIZm6t/2ZZpl0iaGIizKQuh/YrdisZkmRznGt71f55e67xw4n8sIvBtbPH0hA0UaYH+lM3qnqURfiphvzhLBNGPzogO86h9ptROQaB7T7cQORRsdrOVBlGh5o+7rCkYP/tSIMCnGdogybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584815; c=relaxed/simple;
	bh=qE6cJD4P0KiNMIEIyVSFklglPlAzpZg71iGLy71/KPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcRLPk44vK90MNzRTfyKhTC2dg3tHjYRRUh9M9ObLQx1YNjgsZHmVm8ICGJNNZg/q8Ric1XIydJueUEHG4Nb37bCU9MVeeiUh/RaC2JvGFc/NnAIJI/TM54MKSLnNHTKsK1+aD5AklzmCHuf0NPeT3/nQY7Sfcz+MfQTcllaj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GZosuyqz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZosuyqz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e61f017091so1208445ad.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584806; x=1792189606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jU4MRympScJg6dbqwUcuL13gZ3w5UsJs8tfynwm+AWo=;
        b=GZosuyqzZ8ICANckkoHEwhJhE32WE5tthi1wMT5GfqAlDBu87icEbfuJ9Xg40RqIlj
         Hb8dltzQUYzxJpHhJCV+NzLB+U9uF6OuSl6nlVUE01R810XRF8EdUpIdxBMXt2ZphCUI
         1jdgdyJGcYRxADh3XMTyt2OYpFZtrKNeEykGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584806; x=1792189606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jU4MRympScJg6dbqwUcuL13gZ3w5UsJs8tfynwm+AWo=;
        b=CJZnqbPkyF2A8FNDQNhtJme5rEPAHiECI92txvJW2+ZBlo0rYyVugXnbUJ2cP5G+5Y
         k2B1hJpLeoNECpe2hmkeFhhb1O2sDAkc1h/0k9nYfQ4TY682P4flro8tcs+fXYg98rsF
         7LA2RP30myiPRaneWAFjSuVHc0nTGYL5rhvhuORAcvOwSywpfl4VIbKTeBsIUpQzW1FL
         Wo+4jEvWyL6DidAbLdOwQeeRqb2Qlidud417UDxAzcU1t2abUrJe2sPtOsfWRLDRycoQ
         jlycrbJx3WmBvOPziyD8maJLNEWTQBgc9vuMWapyAPXX4yC8xg1DNQoWwTMotQg3+yS7
         Smjg==
X-Gm-Message-State: AFq9FYJ8lK6vkENPJIbmlMZxBzvOSmh1ZD2ANYhXW1w7Fv1z5tScCF+U
	MrMOwpImKaHdi8FS7Llwe0eTxS2ktXu1rpx6IixJACW4sTbUtuWHL2vzea1HA4Pq30RNqDP2r6e
	eDn8X+w==
X-Gm-Gg: AYBFou3EulSuW6lMGYUn9pkOw1hF8+1bGwMwEWNP441nURYmNX4PzDlBtuPFm5Fdr23
	1Z5szq4N66jT2fwdBwalfOnF08x7GKQdHEl3ToK0U4r4iT9Ze8G3LAAPpVp2H6H98HzGqqRa6Y2
	quN3KKQmszWVP2bVBukcRR0DRpeBbrOwqx9tSj8wpVZRXig14ZFHr6LxmsHdAZmvp6uguFJrK/U
	j69QSwmP50h3rAyhTvH37A1uz31WAw9odaf1tMTd1Yg764/+/LZY6cB438kw1oUQWrSpEHHS79k
	nDQn10iiGzfsNtuchgrFZY+l3JUi5Fn3JLLqTYLg3ZKowP8WQWkO5O5hSBGxuxM5y8kUUhQ1WxF
	7IiJpJuznny/ObR3Vh8B4Y5ylWR44ifZsrJaeBh/ZH+iP2rdbD/8LBgSNU5WRK8LRSctRc1qeDU
	gYAgRKkyNs3x2PtjHlRYVk/V06Q/WnQ3KpxTwzCOesIVsUVETmuiNvEON+SKCaBsBK2634OGaEk
	Bles5D6/py4nHncOYjxsZAnBLaBltgkuDloGqj/4pwLHvprPzH34r2WBoS3imO/NsP13eMqZHd3
X-Received: by 2002:a17:903:b0d:b0:2dd:b6e7:ac1b with SMTP id d9443c01a7336-2e84280afafmr30388055ad.2.1791584805669;
        Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:35 +0000
Subject: [PATCH v5 10/11] HID: spi-hid: add power management implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-10-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=10211;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=qE6cJD4P0KiNMIEIyVSFklglPlAzpZg71iGLy71/KPY=;
 b=iE15o4t4sbspF7KZNYCnQr60i/NY3GW77oJ77nfcgEjEaZo74FQs9uQZBCY62fNjS8uWbKY74
 G5C+Wc4UI8dBAbPU981hCMsoqBrwWtkAgMj8AuHOathluZn34wjfpp2
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Implement HID over SPI driver power management callbacks.

Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-acpi.c |   1 +
 drivers/hid/spi-hid/spi-hid-core.c | 185 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h |   2 +
 drivers/hid/spi-hid/spi-hid-of.c   |   1 +
 drivers/hid/spi-hid/spi-hid.h      |   1 +
 5 files changed, 190 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
index 31ca3fa336cd..a52cafe86c05 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.c
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -246,6 +246,7 @@ static struct spi_driver spi_hid_acpi_driver = {
 	.driver = {
 		.name	= "spi_hid_acpi",
 		.owner	= THIS_MODULE,
+		.pm	= &spi_hid_core_pm,
 		.acpi_match_table = spi_hid_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.dev_groups = spi_hid_groups,
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index f4e9b4e1294e..66bfc251bd91 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -36,6 +36,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
@@ -60,6 +62,7 @@
 
 #define SPI_HID_MAX_RESET_ATTEMPTS	3
 #define SPI_HID_RESP_TIMEOUT		1000
+#define SPI_HID_RESET_TIMEOUT		1000
 
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
@@ -91,6 +94,11 @@
  * ll_close. Input reports are only forwarded while this flag is set.
  */
 #define SPI_HID_STARTED	6
+/*
+ * dead indicates that the device was powered off after too many failed
+ * resets. It stays off until the driver is rebound, even across resume.
+ */
+#define SPI_HID_DEAD	7
 
 /* Processed data from input report header */
 struct spi_hid_input_header {
@@ -242,6 +250,148 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+/*
+ * Wait for the device descriptor response after reset; the device then takes
+ * requests. Set READY here: the report descriptor check that normally sets it
+ * needs power_lock, which callers hold.
+ */
+static void spi_hid_wait_for_reset(struct spi_hid *shid)
+{
+	unsigned long timeout = msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
+						 SPI_HID_RESP_TIMEOUT);
+
+	if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
+		dev_warn(&shid->spi->dev,
+			 "Device descriptor not received after reset\n");
+		return;
+	}
+
+	set_bit(SPI_HID_READY, &shid->flags);
+}
+
+static int spi_hid_suspend(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+
+	/* HID driver suspend may talk to the device; responses need the IRQ. */
+	scoped_guard(mutex, &shid->power_lock) {
+		if (shid->power_state != HIDSPI_OFF && shid->hid) {
+			error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
+			if (error) {
+				dev_err(dev, "%s failed to suspend hid driver: %d\n",
+					__func__, error);
+				return error;
+			}
+		}
+	}
+
+	/*
+	 * disable_irq() waits for a running IRQ thread, so no new reset_work
+	 * can be queued after it returns. Then wait for any queued or running
+	 * instance. Must not hold power_lock here: reset_work takes it.
+	 */
+	disable_irq(shid->spi->irq);
+	cancel_work_sync(&shid->reset_work);
+
+	guard(mutex)(&shid->power_lock);
+	if (!device_may_wakeup(dev)) {
+		if (shid->power_state != HIDSPI_OFF) {
+			/* Device is fully reset on resume; drop stale state. */
+			clear_bit(SPI_HID_READY, &shid->flags);
+			clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
+			clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
+			clear_bit(SPI_HID_ERROR, &shid->flags);
+			set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+
+			shid->ops->assert_reset(shid->ops);
+
+			error = shid->ops->power_down(shid->ops);
+			if (error) {
+				dev_err(dev, "%s: could not power down\n", __func__);
+				shid->regulator_error_count++;
+				shid->regulator_last_error = error;
+				/*
+				 * Undo partial suspend before returning error.
+				 * Complete the reset; RESET_PENDING stays set
+				 * until the device sends its reset response.
+				 */
+				shid->ops->sleep_minimal_reset_delay(shid->ops);
+				reinit_completion(&shid->reset_done);
+				shid->ops->deassert_reset(shid->ops);
+				enable_irq(shid->spi->irq);
+				if (shid->hid) {
+					spi_hid_wait_for_reset(shid);
+					hid_driver_reset_resume(shid->hid);
+				}
+				return error;
+			}
+
+			shid->power_state = HIDSPI_OFF;
+		}
+	}
+	return 0;
+}
+
+static int spi_hid_resume(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+	bool was_reset = false;
+
+	guard(mutex)(&shid->power_lock);
+	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
+		/* Stay off; only balance disable_irq() in suspend. */
+		enable_irq(shid->spi->irq);
+		return 0;
+	}
+
+	if (!device_may_wakeup(dev)) {
+		if (shid->power_state == HIDSPI_OFF) {
+			shid->ops->assert_reset(shid->ops);
+
+			shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+			error = shid->ops->power_up(shid->ops);
+			if (error) {
+				dev_err(dev, "%s: could not power up\n", __func__);
+				shid->regulator_error_count++;
+				shid->regulator_last_error = error;
+				/* Suspend runs next even if resume fails. */
+				enable_irq(shid->spi->irq);
+				return error;
+			}
+			shid->power_state = HIDSPI_ON;
+			reinit_completion(&shid->reset_done);
+			shid->ops->deassert_reset(shid->ops);
+			was_reset = true;
+		}
+	}
+
+	enable_irq(shid->spi->irq);
+
+	/*
+	 * For devices that may wake up, process work that was pending when
+	 * suspend cancelled reset_work. Otherwise suspend already dropped it.
+	 */
+	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
+	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
+	    test_bit(SPI_HID_ERROR, &shid->flags))
+		schedule_work(&shid->reset_work);
+
+	if (shid->hid) {
+		if (was_reset)
+			spi_hid_wait_for_reset(shid);
+		error = hid_driver_reset_resume(shid->hid);
+		if (error) {
+			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
+				__func__, error);
+			return error;
+		}
+	}
+	return 0;
+}
+
 static void spi_hid_stop_hid(struct spi_hid *shid)
 {
 	struct hid_device *hid;
@@ -280,6 +430,7 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 			shid->regulator_last_error = error;
 		}
 		shid->power_state = HIDSPI_OFF;
+		set_bit(SPI_HID_DEAD, &shid->flags);
 		/* Dead device: leave the IRQ permanently disabled. */
 		return;
 	}
@@ -561,6 +712,8 @@ static int spi_hid_dev_desc_response(struct spi_hid *shid,
 	shid->reset_attempts = 0;
 	set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
 	schedule_work(&shid->reset_work);
+	/* The device can take requests now; see spi_hid_wait_for_reset(). */
+	complete(&shid->reset_done);
 
 	return 0;
 }
@@ -1378,6 +1531,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	mutex_init(&shid->power_lock);
 	mutex_init(&shid->io_lock);
 	init_completion(&shid->output_done);
+	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
 
@@ -1411,6 +1565,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return error;
 	}
 
+	/*
+	 * Use device_can_wakeup(), not device_may_wakeup(): power/wakeup can
+	 * change after probe, and the PM core checks it at suspend time.
+	 */
+	if (device_can_wakeup(dev)) {
+		error = devm_pm_set_wake_irq(dev, spi->irq);
+		if (error) {
+			dev_err(dev, "%s: failed to set wake IRQ\n", __func__);
+			return error;
+		}
+	}
+
 	error = shid->ops->power_up(shid->ops);
 	if (error) {
 		dev_err(dev, "%s: could not power up\n", __func__);
@@ -1451,6 +1617,25 @@ void spi_hid_core_remove(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
+static int spi_hid_core_pm_suspend(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return spi_hid_suspend(shid);
+}
+
+static int spi_hid_core_pm_resume(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return spi_hid_resume(shid);
+}
+
+const struct dev_pm_ops spi_hid_core_pm = {
+	SYSTEM_SLEEP_PM_OPS(spi_hid_core_pm_suspend, spi_hid_core_pm_resume)
+};
+EXPORT_SYMBOL_GPL(spi_hid_core_pm);
+
 MODULE_DESCRIPTION("HID over SPI transport driver");
 MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 1d8356f787f3..0b3248aedfce 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -92,6 +92,8 @@ struct spi_hid {
 	struct mutex io_lock;
 
 	struct completion output_done;
+	/* Completed once the device descriptor is received after a reset. */
+	struct completion reset_done;
 
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
index 78d0530d2473..605edecc4f7e 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -226,6 +226,7 @@ static struct spi_driver spi_hid_of_driver = {
 	.driver = {
 		.name	= "spi_hid_of",
 		.owner	= THIS_MODULE,
+		.pm	= &spi_hid_core_pm,
 		.of_match_table = spi_hid_of_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.dev_groups = spi_hid_groups,
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index f5a5f4d54beb..17b2fdf192ed 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -41,5 +41,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 void spi_hid_core_remove(struct spi_device *spi);
 
 extern const struct attribute_group *spi_hid_groups[];
+extern const struct dev_pm_ops spi_hid_core_pm;
 
 #endif /* SPI_HID_H */

-- 
2.56.0.385.gd3acb90ef8-goog

