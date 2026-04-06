Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAE38759C
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491701; cv=none; b=QGELiTDgeAUbpZo1XBdgz7+2T305w+FoFNQ95yrpscSbizM3JJA9xH/GrwCacMrTuMAWQXvX+dZe1UW886/yj68hec3C0tRmMp/HvYkDWEINNygI0CZFM8EkIs3UxN1lpLI9D3azsnARGByrGmmDtwcge8cHRb+HwRk3CFTZJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491701; c=relaxed/simple;
	bh=iWvCwSJMYymgZV6gOSS+VX8uxdvvq3QEoS4l42ivpDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRzC1WrKJ6YfHrqIWd1ernGE7B3lCJOPWwcb28EJwxm/lY1vkL7ec2ho4pdlSNAYCHDF/JObOXan78sPhQm/gAbhQvCWX6cpo/SpGXBcCuwU7pL7wJ2BdKcIGCvIqwLTKeC2XKQiZrgZf+590q9F8zBGi+bYNqg0XRWdzqE+X9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgY4mffj; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgY4mffj"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4337167eec.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775491698; x=1776096498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kV4jvdGIhOck112pxUmzJ/qnhiF45DasGsL0Uopy8yk=;
        b=AgY4mffjKB4D01PQAuTWU0uWWTzo2TzWtnxmV31jQBnFkufemiDo7fKdaFjFeaAZdo
         Vs18pg1mRCCMPssBKSovxEL+6YFjJ/1zFJAwyLdh7nyr01sUKMBP/JAGCl5H3Y+4Da47
         UCf7VhWf/XZMmQeYr/LAuV7PhlSZX24OWZWUCUB9wo2PxJ0UTuTghhQ29NjPkNnxeAvU
         nDa+LJGX7YPFzwDC9Mbe2KeYjZXjGGcMJnCtGk9RHR/f4kUqo/RVR1q830xPt+oD5iRL
         Y1xzFfvtm5/nN22wx1nJ37sbly/8YFxAVlUWDchIUZSVHcNdDxIQtsd1936Ek7Ls9mbe
         gEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491698; x=1776096498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV4jvdGIhOck112pxUmzJ/qnhiF45DasGsL0Uopy8yk=;
        b=ajY6N7zlVGwSHuS1dMOs90Upms7260sBWalTIRcuNl6n+NKXG9kd+RG6uoSq6m1EMO
         NDOJDZ04y9NJSm3pkebB1sE2dgX2uncSsEH+0bT1ku12b93jFSw1QcRgQe1/hEGBZZXb
         msg5bZAr4mHQ+HotarB4ltOgIhqt2E/saWZttXVnWBCxsGBtYcQVbz94hhFRAIIqY5fx
         F+6F96RE3duRAHri0oI6u2j6Z4uFcR0qey/KJHhb2G9kKhlh25tEqCYBZ7RyWYRSYjOL
         /QFhOJz0tF0DzVietW0NkGXPGatEKAwrgdCY9sc2jwsw7JQa6xDiF7Lt7P8wLR8lErmJ
         hIYA==
X-Gm-Message-State: AOJu0Yzsuowi/MDoY5cZ4IMNUD7A2jFFAWmMueKn4Ctscq0MEkhiCF7J
	SJtOYNvrfBFrk9jQprI8dVzpjYrPnM9yh0BhEqgs7puMszRP7gERh76U
X-Gm-Gg: AeBDiev9h+WcO+gBQWxsjJx60UrTnRZC2rj541fcCTAQCH16v85HiPlnCRBhnpHRUCf
	hdLbEjRaBhny19HNb1rm6pokYDSd5N5o2Mcwv1eYFISL7TdBQZspJJgQU0hBZM5qq7XKLEHOwqc
	Lb22TiRgakFCnlK88FTPfFT+hd2qN+OmYhWYS+4TmMawhkdfIEFZMrScH7wUaPzO/jh7gbN7pB+
	FAfBfYE6F3qtXZjPPI0+KMTqj+XWBbCKi+tww0klLhFZjVAd9EEZ7XSYOwiFcaXR4FV+vAPI0PQ
	nLFEYxFK2jJRGQoyINCwpXXiqTRTbK7XRcTP+p2lKkBnzGt4YRTaaNsEmSAUx+Ff6hX8Q9++U3q
	ae0bN6qFfz3b2EPgjZ4AX4roJpp1ZXgiHN5TB553g+BOLvCub53VFguBcPGLpi1Jj+PriL+zl00
	4e3l4XUufEXIlkIytrZWQVQK4NRg4zmzkwL4ak5xR5bM4HualgK8HzF8Irrtu24cewBGjOc+B2K
	ryGu1p/mWQp7T6r2TtBCA3FNvvBPdabMIzgBArcOfRaEySegnUyZdo=
X-Received: by 2002:a05:7300:a14b:b0:2c1:6676:5ed6 with SMTP id 5a478bee46e88-2cbfbf7a279mr5723302eec.25.1775491697583;
        Mon, 06 Apr 2026 09:08:17 -0700 (PDT)
Received: from uf0ccb33743a85f.ant.amazon.com ([2601:642:4e01:ba30:bfe6:a9ff:a137:33b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df5ec7sm12912679eec.3.2026.04.06.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:08:17 -0700 (PDT)
From: Armando De Leon <auribe84@gmail.com>
X-Google-Original-From: Armando De Leon <learmand@amazon.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Armando De Leon <learmand@amazon.com>
Subject: [PATCH] Input: gpio-keys - add hibernation support
Date: Mon,  6 Apr 2026 09:04:37 -0700
Message-ID: <20260406160437.3084755-1-learmand@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio-keys driver uses DEFINE_SIMPLE_DEV_PM_OPS which maps .freeze
and .restore to the same callbacks as .suspend and .resume. This is
insufficient for hibernation (suspend-to-disk) because the SoC is fully
powered off, unlike suspend-to-RAM where hardware state is preserved.

After hibernation resume, GPIO keys fail to function correctly because
the interrupt controller (e.g. GIC) is fully re-initialized during
restore, resetting all IRQ trigger type configurations to defaults.
GPIO keys require IRQ_TYPE_EDGE_BOTH for proper press/release detection,
but after the interrupt controller re-initialization only a single edge
remains active. This causes buttons to report only release events but
not press events, or vice versa.

The existing gpio_keys_button_disable_wakeup() does restore
IRQ_TYPE_EDGE_BOTH, but only when wakeup_trigger_type is non-zero.
When the device tree does not specify wakeup-event-action (the common
case), wakeup_trigger_type defaults to zero and the IRQ type
restoration is skipped entirely.

Fix this by implementing dedicated .freeze and .restore callbacks:

- gpio_keys_freeze(): Marks all buttons as suspended before the
  hibernate image is created. Unlike .suspend, it does not configure
  wakeup IRQs since the SoC will be powered off.

- gpio_keys_restore(): Re-applies the pinctrl default state to restore
  GPIO pin configuration, explicitly reconfigures IRQ trigger type to
  IRQ_TYPE_EDGE_BOTH for all GPIO-backed buttons, clears the suspended
  flag, and re-syncs current GPIO state with the input subsystem.

The .thaw callback reuses gpio_keys_resume() since the SoC remains
powered when hibernation is aborted and hardware state is intact.

Signed-off-by: Armando De Leon <learmand@amazon.com>
---
 drivers/input/keyboard/gpio_keys.c | 60 +++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e19617485..9fb77c9aa 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -27,6 +27,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/input/gpio-keys.h>
 
@@ -1088,7 +1089,64 @@ static int gpio_keys_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(gpio_keys_pm_ops, gpio_keys_suspend, gpio_keys_resume);
+static int gpio_keys_freeze(struct device *dev)
+{
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
+	struct gpio_button_data *bdata;
+	int i;
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		bdata = &ddata->data[i];
+		bdata->suspended = true;
+	}
+
+	return 0;
+}
+
+static int gpio_keys_restore(struct device *dev)
+{
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
+	struct gpio_button_data *bdata;
+	int error;
+	int i;
+
+	error = pinctrl_pm_select_default_state(dev);
+	if (error)
+		dev_warn(dev, "failed to restore pinctrl default state: %d\n",
+			 error);
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		bdata = &ddata->data[i];
+		bdata->suspended = false;
+
+		/*
+		 * After hibernation the interrupt controller is
+		 * re-initialized and loses its configuration.
+		 * Restore dual-edge triggering for GPIO-backed
+		 * buttons so both press and release are detected.
+		 */
+		if (bdata->gpiod) {
+			error = irq_set_irq_type(bdata->irq,
+						 IRQ_TYPE_EDGE_BOTH);
+			if (error)
+				dev_warn(dev,
+					 "failed to restore IRQ %d trigger: %d\n",
+					 bdata->irq, error);
+		}
+	}
+
+	gpio_keys_report_state(ddata);
+	return 0;
+}
+
+static const struct dev_pm_ops gpio_keys_pm_ops = {
+	.suspend	= gpio_keys_suspend,
+	.resume		= gpio_keys_resume,
+	.freeze		= gpio_keys_freeze,
+	.restore	= gpio_keys_restore,
+	.thaw		= gpio_keys_resume,
+	.poweroff	= gpio_keys_suspend,
+};
 
 static void gpio_keys_shutdown(struct platform_device *pdev)
 {
-- 
2.43.0

