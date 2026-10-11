Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D34448CF3;
	Sun, 11 Oct 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722883; cv=none; b=HjJSmDBEAU0JYMIHPuedRKqAf9RGGxxTQl4ciStJuseNLBch/6266xtg/aU83Zl39t3GFxFm/Alm0gU75NmPiLSWnnFI0pkFGiFPPAcm1uFqcO9D9hquANO0RiZcrWRcax4e0AEEQLWCuJO3m6LC0juWRWjDWfHzLfuyIeAIVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722883; c=relaxed/simple;
	bh=0cN/7/4QY1PETneovb2gHqozdM/dI7FmhiOpU6WBcD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4Afm0UKncu/YXoKjVMNbpUBHMMZz0d+cg2s8q9J9XPl959wxzdQczotXnVr80tD+AP+kdTk/Qujn3T1T0eEVat1MhW0UoABxRkIafN2kUMGDKccq3qIjogaCBQM65Vqp0fAtVzpFBp6nAKSzrPLtB7qYYlrH2xW4SnZlhcvvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=BPNkT52w; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="BPNkT52w"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j2gPB2jzZzKp6V;
	Sun, 11 Oct 2026 14:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFUETxEuaWKaun1+fDxvFjJ9XCDQJOC8LJkAhb6iig0=;
	b=BPNkT52wD5GCJTextCbwGrFv2vufu3hpKM18vtz/B6mtcrlVwiQNOdV7kod+mD6V09V1ZX
	fMWetZ7b/fnwv26LZ4v20jFuy4HKjqvI+/Pt+uDeLirFDd5holRVEebVL8Oo+ajID7QX9S
	WN6C9KNC+MwcwQwdMYE3/banzgzfE5hSHdicwkpfD97Vnm+8BE4e+c4THrwF9JkdWGufQt
	D8ecMnwW1kZS1OQSIvgZ1KwOxTa8sQp1rBuQXYUveOvJcBvJEFlDmkLvFFuM+btWYYFRkJ
	0cI5gwJ3ocT1IGWzowLFmUnDf/Iw0TeAAsU6E2UFvWjGXYCpuTvtdcvZzaYx9Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:44:58 +0200
Subject: [PATCH 3/7] Input: s6sy761 - add reset GPIO support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-3-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gPB2jzZzKp6V

Some boards wire up the controller's reset line. Hold the controller
in reset while its supplies come up and release it 10 ms later, as the
vendor driver does, and assert it again on power down. The GPIO is
optional, so boards without it are unaffected.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 drivers/input/touchscreen/s6sy761_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/s6sy761_core.c b/drivers/input/touchscreen/s6sy761_core.c
index 0e455060dbc0..8541cd9aa930 100644
--- a/drivers/input/touchscreen/s6sy761_core.c
+++ b/drivers/input/touchscreen/s6sy761_core.c
@@ -7,6 +7,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
@@ -100,6 +101,7 @@ struct s6sy761_data {
 	struct mutex xfer_lock;
 	int irq;
 	struct regulator_bulk_data regulators[2];
+	struct gpio_desc *reset_gpio;
 	struct input_dev *input;
 	struct touchscreen_properties prop;
 
@@ -297,6 +299,9 @@ static int s6sy761_power_on(struct s6sy761_data *sdata)
 	if (ret)
 		return ret;
 
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
+
 	msleep(140);
 
 	/* double check whether the touch is functional */
@@ -370,6 +375,7 @@ static void s6sy761_power_off(void *data)
 	struct s6sy761_data *sdata = data;
 
 	disable_irq(sdata->irq);
+	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
 						sdata->regulators);
 }
@@ -406,6 +412,12 @@ int s6sy761_probe(struct device *dev, const struct s6sy761_bus_ops *bus_ops, int
 	if (err)
 		return err;
 
+	sdata->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(sdata->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(sdata->reset_gpio),
+				     "failed to get reset GPIO\n");
+
 	err = devm_add_action_or_reset(dev, s6sy761_power_off, sdata);
 	if (err)
 		return err;

-- 
2.56.0

