Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B33368BC
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095194; cv=none; b=VsfVAFZ1t/xX4G6Ph3vlMIVGfYBGSb0sqRCsLAD6ex7336qrO9QfU7gwIO6BkeDRD0GbdGUickxHgSV7m8YILCsuEcW1nJbNbpObkNB5EZ3DUqfeirLMoqrecMsb3GFZhfMcDKKGOAMLEioXdN3IIEaVLteNVnVu6wsejsMtd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095194; c=relaxed/simple;
	bh=IsaZ710oxuBN4PiA+69dKS/EYofhjm1DhhAZbjz2WWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/IT59M7giI/iPSJIhcXyZFm5CUCpjhC2GHF0WHuZ0u/6fT6uFwc74q9HiMHr/VeZBqo++oVSsqWz8ngBg10sFXUSMOB/365lXfAqilEHKayWFlmP6gCCsiYOe2vTdCqIXd6edoE6bJ1oZ+Dg31UkjnB9A055Wdkq/vA8iAeFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M+Y59rIf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M+Y59rIf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35c206f0481so293749a91.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095190; x=1775699990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eD7F1u44Jio2+2ZFUsBLXdqQbokoRei5mkxn2sOyNEM=;
        b=M+Y59rIfmowLxJXl3UOfLRPIBM3hrzyEK650qtn2g2croO3QMu4QbVL2hVuD5rFkDN
         mqAHLihFGFyR4GulofsALlJl485BRhnQevdY9NT3JmikPPn8LxlSAtKQDDTqEv8TzYCW
         1l+SVw57NOoI4PuRPha67Q+IhyRezvV0be71c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095190; x=1775699990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eD7F1u44Jio2+2ZFUsBLXdqQbokoRei5mkxn2sOyNEM=;
        b=cdB8Qk0k0fkGSSN93xOX6teS3Bt9J3jA5PPoI7xUBOOqr93aBiwvXJo18sX2Xv4kNl
         Ini3H1Y7vhMXXs3eDnx05LCEe4pIazGeH5pBh5GVmtr+C6qItIs1Y8+4vmUDJA5qKPdw
         1xVxKKkyzI+m3jLgbEw87OxltwcBrl/Xo4uVCrQbEsIJb72vni3ybQqctIQUYAkPcdB8
         ie2oc7LporX5pDbaRrk8BIduv1r31m8ieZ05PDUEGCGwQ/z04J+kMvejRzA5fTVZVSQz
         t+YJ+9TE0/UtXgQJ6MwEIwET91iJD/bQCli0h7gogAhUf8xd5MiqpRbENo+I2iiesqc4
         FJYg==
X-Gm-Message-State: AOJu0YxIQ1xGaFud4oiYrckT2XQ6weEgOFS4FWiTGGRhtsbu4F/QDIn0
	GgOnaxNWO4jLy+pUr1eSBm5+xbOzDzW4HAeHOPQ5lUvnsi5SougwVSR3LfSciMy1wVX4bIRSX4O
	VLbk=
X-Gm-Gg: ATEYQzwhAgKYtF2X2qwQEKQORRbJ2VxqDYiMt3khjTR4QGPbPyXI6n49OUiZUsBq0cO
	P/oub4ph2WlmbxGooMUjGNWYnAyNKDaIjzRyZ0cLHM/vntFomof4Kq1hBv36c0qjoGZ1PW49jnr
	NZ4ZwJV3x71Nt1GJmd6dQ4M5FvDXN4/m+HWMAzlLzmGqm2x1ZfgCng8kqZc924g7zJ4JPGMGYMn
	36eVdqYT1Hhujtq9IrPkL0yeJukugf89d28nXGA0oUVsRJf+RouR92GAYuywuDxMyQpRb0ztwg1
	c3NgTdDt3BsgTs3Q4YwTN7Yb37wTPWnQJ3RmQrPyrGeqYfcEqzEBZ3UH3BFcM4B1fadCGFZSH5T
	Obi6qbBFfAAbCk7BZKu+XM+tqxXpWJI5tGdzINp802ze0TZObQQqQmwuwlSeVQnt6RxRoBIQ/3G
	/UFVLfCG9pNWcy9WGCESgIrk+Idem/Vn3+jjs1fJMXdLfU6TWrlAFH9DEeMJ9K5EGpid+rAB/3t
	HiGRVPlhLi6SxZ8FHHsO3NYAQCtw9/rnQ==
X-Received: by 2002:a17:902:e54a:b0:2b0:cb96:9815 with SMTP id d9443c01a7336-2b275da7802mr13614315ad.43.1775095189867;
        Wed, 01 Apr 2026 18:59:49 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:49 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:47 +0000
Subject: [PATCH v3 10/11] HID: spi-hid: add power management implementation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-10-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=5452;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=IsaZ710oxuBN4PiA+69dKS/EYofhjm1DhhAZbjz2WWI=;
 b=sBQZ5/1CaFm4bih4+ceHjvhV3qaKwRPf7JlWoD907mU3+jK+oEsLVs4ps/CdORmGFzJTYd57q
 Za+4vFrNs19BHkaem3YK//a6rCIcoj3XRCtafJnCAeYZzipz0Z1T3uK
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
index d48175c764b9..5f7a5bb692d9 100644
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
@@ -244,6 +246,81 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
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
@@ -1200,6 +1277,13 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
@@ -1231,6 +1315,29 @@ void spi_hid_core_remove(struct spi_device *spi)
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
2.53.0.1185.g05d4b7b318-goog

