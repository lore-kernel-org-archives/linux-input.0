Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803135;
	b=ZdYlJZpGy8qAWW+1hjOkZNOviYYS5tbWr6J3Rki5NI7ZbRJiBJ3vDzMcb/zrt+77Z78P
	 wW+IdlUenIRnbaJR/oGau0Ch9ISkP57/zgmZw8bkKjEakbkXvlglqTYTK6clZ80NMEmDy
	 cScDf1lQqM6IltSv9CkjoOxZCgjQigbpFOUpkF/AEXUPC8PNnRTUevXU4wMKa4RXAM3S2
	 dPNRzaNnTc/TJ2+wFPh+u18T2WffCenIKHLf3PL4h1q4XbsnswvDh45v0pUNAXnon9pC5
	 QtNGwlvcGcx0NDoR9y0PCWuCRWbnvrAfrYYyrBZLLNS2RFote79cOLfOPPx/d1J1SkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/lReMIMdAhWyQP7nhfhWBKrd94woLfBPM63AuD2kZr0=;
	b=s7mXjF9gxS8dnFryyQEtbWKgI++a894axil/g51CXa10egau0+M3r9Xyq7SMdK3ejqFz
	 ZSs6F5NUBcqIHmts3rh8VrKjEVi0B1d/Z+xSbj7FP1i1SmyoVozC/VHSfxIIJhOkAe8W+
	 b2/3/Y0IjZMa5IfnCOUgF3rUqByAFGbJQ8XyPbBin1ugaI+kD2FDUOlSPBMl49N2Gip3g
	 j5EbuBwxB6/s2DszOBjZhljKsxOUupKsWumeHiy4Y7UEpaBG2ZxlbpmMl0wWqZnKyFT10
	 +IQHIJ3OXoR8y9E8CvmxesYUQM94ttTDUDBuRpS2PQk+3DdZ5vga4sd688RmuzzbgIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hJ3wXUy+;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3B60A381E
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F3B60A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hJ3wXUy+
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8246b13cbso11369535ad.2
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803120; x=1793407920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lReMIMdAhWyQP7nhfhWBKrd94woLfBPM63AuD2kZr0=;
        b=hJ3wXUy+eq9f29zOwqGhAIKV1kax0x51AXIcY2hASuDYtyiY7zs9gQ3UZIM1EAk0Ud
         2XHNonHHfi/E57Wt16CeMVbwe66/Ez50W4655a4TIA3BcURSeVmaq2Y4XSGFgs08P2Ag
         lgQdMviRCSBOAP56K+OVLts5pTt+UVKKaw1pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803120; x=1793407920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lReMIMdAhWyQP7nhfhWBKrd94woLfBPM63AuD2kZr0=;
        b=RJAL48Odguw1eofRIVRK4TAHHCKb6c4c4GERS08wMDbCMPkaa25qZ3slvihRTASYCn
         Fky1u45r4DQI10Saor564vHOrlD++Bbj2zDbFxES6cYmYlEV6ILYjJyXmgfruHODuEl3
         RxCAKHhpRd6hXhGFZRm58Dx738c/5wbTdb8P3P++NwzaT6Ub2CUrjgrtKhYM9auhp+sb
         UkkkjajcfSD711Uqj/s1g0Tx/6tu9sQE+3y90FRCmsKHRWyQ1dBVWwvi4F7yt64V89hu
         3TZXhlMGkpXkGEcRu+0nojQLJH/T4n0gtVvXIOAhbDsC7mAgisVkaZzNUWoI/W1ZXUVV
         VyiA==
X-Gm-Message-State: AFq9FYLkRYyuVxaDnM3fTmopcI+0sbu0WN0Zoy5amWyB6EPFNNkkmF93
	PXQmPmzMQ18CGtVfXy58Y7lTBbEp80vCzvNkU/CX5x+ALgrB+V0Txif7SikaBW5yel/u0mSLc8o
	fBGQ=
X-Gm-Gg: AYBFou31uGcx84PY5ENBI3YEaKt1kNRn9fdCz/alZpeCVeH31Lkm5NF1m9IbvL8fv6J
	zYzNBacPcbZoskVFfdQnI91ch0EDGBpkxBtJtxno+OuR2Z1YnLnsxzKdbaQ54Dw2Kv9wbPDo+rd
	asdeBmIqAxYMQstEd7Zg0icMuDczPCkJyIJ633J15uX7ORhPqYswaqggzKT+poCsnrJtK+lnmPw
	qs6lM8qzFLv9cmNuwi1DmFGyzMZ27PIQnZWZk9v3lSNEQPtqjR5n+TQA8vcgvnx8oXMeuUMDzUE
	k3KhOZd05OFoq3jQeEdV/J8h2l2HC2hItA+gcEh5Uj7s4W629DMHowHIiE2S7+pqBH7mWOAF5SE
	elkSubLEgVF/U9w+YbbKFlvhRHV95C6RFO7/2wS5mH+QzvELYxQf7tFamJJj7T1H8wVkqrB82N/
	As0RihoNXhDEknYTf53/lA3NKkrkQnthUQWjvrxcO2Xz2aOsU5LovwJ1I0MjE2Uzfj0MO88Ok04
	Pv7wgesUmf49J6y+ZX9zdEHsAZVpqBDg1bOnWByqQmMxcLGSgrEz1Uamn7UCiXMrGckZrvDVpO6
	4liCBxRUP4thHCo9zNmQCp8YPOdBsj3gk2amHuuINBha6wAS4EviLGlePxwqT1Q=
X-Received: by 2002:a17:90a:d406:b0:3ac:adce:60af with SMTP id 98e67ed59e1d1-3adead51544mr715207a91.16.1792803119698;
        Fri, 23 Oct 2026 17:51:59 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:59 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:44 +0000
Subject: [PATCH v7 10/11] HID: spi-hid: add power management implementation
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-send-upstream-v7-10-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=10501;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=EAsAf+Dd1ixu/za227J38fBv91SHTsDXj6O1MD8yXIE=;
 b=Tkjy0D0Xc+9oO1oVNb/t0Qf4MGZ9HMcDF8kNj4syh6YXDoJMmAoMIqs3MDT3gbEsNzqcNxoJb
 3UpNWrJ603iDml4EO9f0OSor+CNU9rpiUc3j2OQylL/pAS/iLs5z1WM
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Implement HID over SPI driver power management callbacks.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-acpi.c |   1 +
 drivers/hid/spi-hid/spi-hid-core.c | 188 ++++++++++++++++++++++++++++++++++++-
 drivers/hid/spi-hid/spi-hid-core.h |   2 +
 drivers/hid/spi-hid/spi-hid-of.c   |   1 +
 drivers/hid/spi-hid/spi-hid.h      |   2 +
 5 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
index df459c71e209..ea291ca269d4 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.c
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -246,6 +246,7 @@ static struct spi_driver spi_hid_acpi_driver = {
 	.driver = {
 		.name	= "spi_hid_acpi",
 		.owner	= THIS_MODULE,
+		.pm	= &spi_hid_core_pm,
 		.acpi_match_table = spi_hid_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 4ff93d22715c..3b8874ca0e1c 100644
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
@@ -231,6 +239,147 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+/*
+ * Wait for the device descriptor response after reset; the device then takes
+ * requests. Set READY here: the report descriptor check that normally sets it
+ * needs power_lock, which callers hold.
+ */
+static int spi_hid_wait_for_reset(struct spi_hid *shid)
+{
+	unsigned long timeout = msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
+						 SPI_HID_RESP_TIMEOUT);
+
+	if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
+		dev_warn(&shid->spi->dev,
+			 "Device descriptor not received after reset\n");
+		return -ETIMEDOUT;
+	}
+
+	set_bit(SPI_HID_READY, &shid->flags);
+	return 0;
+}
+
+static int spi_hid_suspend(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+
+	/*
+	 * Stop reset_work until resume; pending steps keep their flags. The
+	 * IRQ stays on so a request in flight gets its response.
+	 */
+	disable_work_sync(&shid->reset_work);
+
+	/* HID driver suspend may talk to the device; responses need the IRQ. */
+	scoped_guard(mutex, &shid->power_lock) {
+		if (shid->power_state != HIDSPI_OFF && shid->hid) {
+			error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
+			if (error) {
+				dev_err(dev, "%s failed to suspend hid driver: %d\n",
+					__func__, error);
+				enable_work(&shid->reset_work);
+				/* Redo a schedule_work() dropped while disabled. */
+				schedule_work(&shid->reset_work);
+				return error;
+			}
+		}
+	}
+
+	/* disable_irq() waits for a running IRQ thread. */
+	disable_irq(shid->spi->irq);
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
+			if (error)
+				dev_err(dev, "%s: could not power down: %d\n", __func__, error);
+
+			/* Held in reset either way; resume resets it. */
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
+	enable_work(&shid->reset_work);
+	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
+		/* Stay off; only balance disable_*() in suspend. */
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
+				dev_err(dev, "%s: could not power up: %d\n", __func__, error);
+				/* Suspend runs next even if resume fails. */
+				enable_irq(shid->spi->irq);
+				return error;
+			}
+			shid->power_state = HIDSPI_ON;
+			reinit_completion(&shid->reset_done);
+			error = shid->ops->deassert_reset(shid->ops);
+			if (error)
+				dev_err(dev, "%s: failed to deassert reset: %d\n",
+					__func__, error);
+			else
+				was_reset = true;
+		}
+	}
+
+	enable_irq(shid->spi->irq);
+
+	/*
+	 * For devices that may wake up, process work that was pending while
+	 * suspend had reset_work disabled. Otherwise suspend already dropped it.
+	 */
+	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
+	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
+	    test_bit(SPI_HID_ERROR, &shid->flags))
+		schedule_work(&shid->reset_work);
+
+	if (shid->hid) {
+		if (was_reset && spi_hid_wait_for_reset(shid)) {
+			/* No reset response: let recovery retry. */
+			set_bit(SPI_HID_ERROR, &shid->flags);
+			schedule_work(&shid->reset_work);
+			return -ETIMEDOUT;
+		}
+		/* HID requests would fail while the device is not ready. */
+		if (!test_bit(SPI_HID_READY, &shid->flags))
+			return 0;
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
@@ -266,6 +415,7 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 		if (error)
 			dev_err(dev, "failed to disable regulator: %d\n", error);
 		shid->power_state = HIDSPI_OFF;
+		set_bit(SPI_HID_DEAD, &shid->flags);
 		/* Dead device: leave the IRQ permanently disabled. */
 		return;
 	}
@@ -454,8 +604,8 @@ static void spi_hid_reset_response(struct spi_hid *shid)
 
 	error = spi_hid_sync_request(shid, &report);
 	if (error) {
-		dev_WARN_ONCE(dev, true,
-			      "Failed to send device descriptor request: %d\n", error);
+		dev_err(dev, "Failed to send device descriptor request: %d\n",
+			error);
 		set_bit(SPI_HID_ERROR, &shid->flags);
 		schedule_work(&shid->reset_work);
 	}
@@ -546,6 +696,8 @@ static int spi_hid_dev_desc_response(struct spi_hid *shid,
 
 	set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
 	schedule_work(&shid->reset_work);
+	/* The device can take requests now; see spi_hid_wait_for_reset(). */
+	complete(&shid->reset_done);
 
 	return 0;
 }
@@ -1325,6 +1477,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	mutex_init(&shid->power_lock);
 	mutex_init(&shid->io_lock);
 	init_completion(&shid->output_done);
+	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
 
@@ -1358,6 +1511,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
 		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
@@ -1398,6 +1563,25 @@ void spi_hid_core_remove(struct spi_device *spi)
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
index e66594b7a8cb..060272353216 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -92,6 +92,8 @@ struct spi_hid {
 	struct mutex io_lock;
 
 	struct completion output_done;
+	/* Completed once the device descriptor is received after a reset. */
+	struct completion reset_done;
 
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
index d1bbdc17102e..6de9affbebe9 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -195,6 +195,7 @@ static struct spi_driver spi_hid_of_driver = {
 	.driver = {
 		.name = "spi_hid_of",
 		.owner = THIS_MODULE,
+		.pm = &spi_hid_core_pm,
 		.of_match_table = spi_hid_of_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index a31956ef24ef..95acb2845246 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -40,4 +40,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 void spi_hid_core_remove(struct spi_device *spi);
 
+extern const struct dev_pm_ops spi_hid_core_pm;
+
 #endif /* SPI_HID_H */

-- 
2.56.0.257.gf7497c7d27-goog

