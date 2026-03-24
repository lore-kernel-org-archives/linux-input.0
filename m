Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279CC3C5DBB
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334424; cv=none; b=XKmehl4H1jyP0MkkA8TNasxUAqqOG86sABwnbpFFIpttHF3QBlPtlAj0xHufFKslqYhHTfBNA4nCAcQ4R4VB/Q2dFTf/slPpQ1plb8Ce2lgIppLzhhRY9cNa+F1ybv6RzzBq6a7JwkgFaWVT+FHqP8nMoBt7iwzmoTBhL+0lk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334424; c=relaxed/simple;
	bh=0ShLgUfw8xYUqYg8g1hkipQJ7Pim/IpYSDnBkx4kC3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFXge9OlPnfGm5j/l9StOd6nDLKD4nVX+Wci7INdji5MzYFkIzXwkmhZlZS8a5Rg9CKGenaFNobntMXFAL46fXbi//OrCMrtElGdFNRzlkadrI2vKT46s4dJGt3A/yeAG3bmcKxSPc51uOjsFV2Ag9hHKnFmDwzlGTaYaqSupAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d1juY+0o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1juY+0o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aecefc7503so37344045ad.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334412; x=1774939212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fOl7nSumxiQQ22tuWWzFLmSP0tNH8zNV33iVHAJAWQ=;
        b=d1juY+0o8+OUEQVSCm9VK4dW8vZJZPLvBj11NQI+TotHtpnMCtB+1PTNW+0dRaGkP0
         38yGy/QsDXGHvdkYD6AkpIuXrwpaQSy03ljNxXCKWrmUut8H8GPmPpsFpRPCAPBj3FSz
         /XNCrXrjXHZ6qHqO0ilqownO71qtYrIDBxvZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334412; x=1774939212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5fOl7nSumxiQQ22tuWWzFLmSP0tNH8zNV33iVHAJAWQ=;
        b=WpzdnnYIhoEY8V2mPalHU8BYxmXI2bmBQIO6o7KdReFKIfnwRjcx7OWqfqAI44bIiO
         FWCIP8RdtITrBj2GPjPmDsAhXCseGY9NJX7E94dIv29UIrLsjrwiuXAC3bH3vcFkbso0
         0JKqOCRN9x0KzWZKC+a6sLkBRFWWEhBfqB1Wfb6Z1QIO7y8futkCzu4u+q3wrCpf2fWF
         gnke4zGKKyUt5eGWXEZdMdbQolbmZ8eKF60o9jI4qx/hoLuBBYVZuPq4G+tU62Fm3xwi
         1RcOEfguzRRxRya2SvAh8IsObOs3BlNygqWey759dRZvTP/XAp8bxDfd71JXu931XSO3
         R8ow==
X-Gm-Message-State: AOJu0Yy3PY7hFCtcxazjuI3Is+xAU/qErEZ34Yd/NdrDXTOaeSYi6HeP
	5wUyNj5z80dIgaZQWQdmaK6MygXG1w205SSdvX/UJXDYdOtJYuov1W5Pvk6raOhe9Q==
X-Gm-Gg: ATEYQzzfcDfXW0IQ9i/16bXcAhOyAUn/E/fPQvBDcHwx2YQ0ffJgsFrF0mDxac0LKSX
	w5Eu8Itd2PY8/aX1/Ni1oCA7gdUzMciWmIZvQk6jnnTj5T3Wvs8gTBREMTLFp0PofIqp4VTIjPn
	kqLIz8BeeU6P6UOELgp7/x4K9UGlCusffOqFLmN7i8BQv0+eyk1fRXGfuIwNb4w7QV0hgLbnART
	CMRieuFT2JyyPERJgIVrICz/ghQsr0r/phnWhy/QZuErK5E26HcIQeXNrsNhtDM+CbY68Gxs/R1
	zYy5rcpWnjq/OZPv8txgUEAE+E2aaGKSCEtrp3LlkddwL0FBfn35Ix9s0cB3jSvZFUKMPKmPi40
	R0HeNJ3bla3rNNAQub48h7bk0o4MNPEx1qBGn2fHZdmsIM0bFS1Xxeqhxr9Cd3d/t67zNJDRhdy
	IatZaO/FxFokb+zTRg/aH4FPdPRSTy9BlxPUCuWp1rFuSh4ZkNM391kcTeg7H/kYi7StpkmzKzC
	gkNBXn4MxU5tMDh7eNNRR/SL3SeXwPn5Q==
X-Received: by 2002:a17:902:cece:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b0827a71b9mr150520295ad.41.1774334411667;
        Mon, 23 Mar 2026 23:40:11 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:10 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:43 +0000
Subject: [PATCH v2 10/11] HID: spi-hid: add power management implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-10-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=5451;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=0ShLgUfw8xYUqYg8g1hkipQJ7Pim/IpYSDnBkx4kC3k=;
 b=MVoQai+OxPMiMzvQ10d7yPTDsI9Ruok69BFUlI95JNH3FHzmcW4FRyfC9Jd938bfaOIx0p1W2
 5d2Kpd5KP5SCCJOM2s19xquT4clf+fe5Nf18semlX1hsL+80Lob20vV
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Implement HID over SPI driver power management callbacks.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-acpi.c |   1 +
 drivers/hid/spi-hid/spi-hid-core.c | 107 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-of.c   |   1 +
 drivers/hid/spi-hid/spi-hid.h      |   1 +
 4 files changed, 110 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
index 298e3ba44d8a..15cfc4e6cc2f 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.c
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -238,6 +238,7 @@ static struct spi_driver spi_hid_acpi_driver = {
 	.driver = {
 		.name	= "spi_hid_acpi",
 		.owner	= THIS_MODULE,
+		.pm	= &spi_hid_core_pm,
 		.acpi_match_table = spi_hid_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.dev_groups = spi_hid_groups,
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 5411425710e2..ac46e2c7c8aa 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -35,6 +35,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
@@ -236,6 +238,81 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+static void spi_hid_suspend(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+
+	guard(mutex)(&shid->power_lock);
+	if (shid->power_state == HIDSPI_OFF)
+		return;
+
+	if (shid->hid) {
+		error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
+		if (error) {
+			dev_err(dev, "%s failed to suspend hid driver: %d",
+				__func__, error);
+			return;
+		}
+	}
+
+	disable_irq(shid->spi->irq);
+
+	clear_bit(SPI_HID_READY, &shid->flags);
+
+	if (!device_may_wakeup(dev)) {
+		set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+
+		shid->ops->assert_reset(shid->ops);
+
+		error = shid->ops->power_down(shid->ops);
+		if (error) {
+			dev_err(dev, "%s: could not power down.", __func__);
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+			return;
+		}
+
+		shid->power_state = HIDSPI_OFF;
+	}
+}
+
+static void spi_hid_resume(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+
+	guard(mutex)(&shid->power_lock);
+	if (shid->power_state == HIDSPI_ON)
+		return;
+
+	enable_irq(shid->spi->irq);
+
+	if (!device_may_wakeup(dev)) {
+		shid->ops->assert_reset(shid->ops);
+
+		shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+		error = shid->ops->power_up(shid->ops);
+		if (error) {
+			dev_err(dev, "%s: could not power up.", __func__);
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+			return;
+		}
+		shid->power_state = HIDSPI_ON;
+
+		shid->ops->deassert_reset(shid->ops);
+	}
+
+	if (shid->hid) {
+		error = hid_driver_reset_resume(shid->hid);
+		if (error)
+			dev_err(dev, "%s: failed to reset resume hid driver: %d.",
+				__func__, error);
+	}
+}
+
 static void spi_hid_stop_hid(struct spi_hid *shid)
 {
 	struct hid_device *hid = shid->hid;
@@ -1161,6 +1238,13 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		dev_err(dev, "%s: unable to request threaded IRQ.", __func__);
 		return error;
 	}
+	if (device_may_wakeup(dev)) {
+		error = dev_pm_set_wake_irq(dev, spi->irq);
+		if (error) {
+			dev_err(dev, "%s: failed to set wake IRQ.", __func__);
+			return error;
+		}
+	}
 
 	error = shid->ops->power_up(shid->ops);
 	if (error) {
@@ -1192,6 +1276,29 @@ void spi_hid_core_remove(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
+static int spi_hid_core_pm_suspend(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	spi_hid_suspend(shid);
+
+	return 0;
+}
+
+static int spi_hid_core_pm_resume(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	spi_hid_resume(shid);
+
+	return 0;
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
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
index 651456b6906d..80c481b77149 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -227,6 +227,7 @@ static struct spi_driver spi_hid_of_driver = {
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
2.53.0.983.g0bb29b3bc5-goog

