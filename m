Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A073E1CE9
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244812; cv=none; b=L7vEgP/WgXzUAQ02A3Q87djL8TfD22UqAsJn/G1w31UCj7zzgoAg4JigO1mwPnXDBths7bYJ5mdnk+NT0Cl18vq73md4BvLy0cAGRHuoiUmAaYQeeb3N7w3G3NAHESMEMrGPUmSp6PPi8ge2nkHcidtxDoHJ7IeeCyJk9hDBz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244812; c=relaxed/simple;
	bh=5gO6npexgo7th4yWru6p4t8YuaeWr0gCCknKoQ5U+NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgOSQTPpeDP96zkrV7P4PNUI+uabPit+TWw8vGqdcA16Np2v3hFaKi/4TchTNziKhsHUNFGuIxos7DnyHzBcL4wkDV33uAu7udvGzxl5fKIz6aUumwORw5ApjSinrJOqILGbEAiS/pSQ7tTjqI3YiHLD5k2lpyTcxohmUNZYOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=GCp7h3xs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="GCp7h3xs"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba545100a13so340998166b.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1778244809; x=1778849609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w0ldg67Kx7W7htSiAB7dV1/ur2vkooDzTmdvNdijms=;
        b=GCp7h3xs3Abp3GlPrVOtpMD9a6ZmkRrHogQ9oLrE/VZy2wL4lA0Ypv4GiMTSBoeJ2O
         3VoMuvytHN3cRNxdeG5tMkD/EJwq4oWRgGlSF4+2avVCZAFTqCZ2IFi/HYBsCVUxhJiS
         /Y55EE9pnmQ0JkdyGa9Yrso/ea5heWMwLpSNyNr4nZWJUb8WNXpaSqhBRojmmpFCGOTl
         Vq6QbyfP6sJM1oL/p/jSgXpZ3RkcXz9aq1phwPc2Bo4HfibkjVgeG4EhnrNIvVwNQTlx
         u7irn7bhGTDh9C6V6rQdLwZevqjDZca7qiYz2+CisRo42T8I3hr+uOK1bWd8ACLdVwWp
         eTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244809; x=1778849609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2w0ldg67Kx7W7htSiAB7dV1/ur2vkooDzTmdvNdijms=;
        b=iHxdRQmWZ0cjIwZbUj9C+tJZu8sxKlSn6ZtCKLAmrxq51i9Rt4xAPb1MWu2knvpVFA
         KC9Xule+sY+NSJMVu3NkiKB+/XveDrgxG7G3U7tn4uHggpEjiU9GHfxOJr2uGcMpRaJr
         /ZylrNl4xhKh94iiNq8XfXblaWqo/hF1p0ASDue9FGzO5wCXRf+cbFaq6nrYsCrR8UQB
         20gyv3MOwpfhz8pTZPTbd1gQcb8xFO+wceq1UdLd9s3izlxdnqkQMcWuibspWbKYfi+i
         GK8vDLffznq0mbBAbteLeq99KM+wyIkNeyiGsAc9QOlRqgAQL5rXY2Y/RsE4yJqVJ92z
         UDvw==
X-Gm-Message-State: AOJu0YziqMoQm9GS5XeRtbVBCiUryb6w9fhNPSFsW1tBWAoOBdbmG2fH
	YfDf2RwCXYyv+0ZiFuj00jx1aoRnwBJLTz99Y9dCo9qqgCOhKZ/AP0HuIQZ8nPBy6xk=
X-Gm-Gg: AeBDietNh4Pt4AfIt+hr69SHCAEoxTcqa0TS9nmM6s9bXoYKRjpq4QqPdrtFNyGeyGW
	upcb7Q1lc3py/Le8huRG2nM1XoliK9QjJ/NUlZqPpzcB56ZRXHuIqTHsq4oHPXiS2evdjjadMoL
	jkfhNO66SVBl+r1snPQLLp4FdIr7AzXcgHq6eNY2prnu1b36MzA8BVrt1MVRX2FhtUqy6ZA8IQF
	qyRdsuTFTDBgfMnKb3WiRwkwZ7Qwosvr7gmBv/2NZLyQ0yClOXcPnkAyDh55EMKepk+bJFkNaFA
	Fif5Aa0IK3sesROJdsE0qPg7X8gUTRwmi9H/D3U5Ndp72QvCLLlKC1p6Z3TWRBFw6xb8b71wyUo
	mpw8OtpyzGpfW/UQL5/JaqcbajxlDLr7C5TPBeBQc/4KZHQ13cTslwKzhMJmsLXtE/db4PVBMfa
	zoCMi9CHXnRvpCoKj71Gnw2NwOnzvy+wl95LzNlj3FVK4Af/yg8Zk47uG4wmGDEFRFRUfoF15VH
	i/4x0XjvPUMtKiKVjcP
X-Received: by 2002:a17:907:7205:b0:ba8:e7b5:1106 with SMTP id a640c23a62f3a-bc56e01b348mr733763566b.43.1778244808667;
        Fri, 08 May 2026 05:53:28 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb94415c94sm800266b.53.2026.05.08.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:53:28 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Fri, 08 May 2026 14:53:15 +0200
Subject: [PATCH RFC 3/4] Input: gpio-keys - add regulator to gpio_keys
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-gpiokeys-vdd-supply-v1-3-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778244804; l=3314;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=5gO6npexgo7th4yWru6p4t8YuaeWr0gCCknKoQ5U+NA=;
 b=4QSIAQbxI0W8K8el+9bhadM8rW5gb7l5/joZ0qCZtpqAOcIRMsdoI8SFaBNyEdgGwaME96pOn
 YqdAA1xDYrlDhX6GdCPyTLXG+iSpUO9IMK6q4SMf9HIrColb7icPAwN
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Allow gpio-keys to have vdd power suppy through regulators.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/keyboard/gpio_keys.c | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/gpio_keys.h          |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e196174856796b391f14c31da9b2fee5ff742172..2199ce7455cfc763569e173d4d18da92507f38d3 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
+#include <linux/regulator/consumer.h>
 #include <dt-bindings/input/gpio-keys.h>
 
 struct gpio_button_data {
@@ -729,6 +730,7 @@ static int gpio_keys_open(struct input_dev *input)
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
 	const struct gpio_keys_platform_data *pdata = ddata->pdata;
 	int error;
+	int i;
 
 	if (pdata->enable) {
 		error = pdata->enable(input->dev.parent);
@@ -736,19 +738,48 @@ static int gpio_keys_open(struct input_dev *input)
 			return error;
 	}
 
+	for (i = 0; i < pdata->nbuttons; i++) {
+		const struct gpio_keys_button *button = &pdata->buttons[i];
+
+		if (!button->regulator)
+			continue;
+		error = regulator_enable(button->regulator);
+		if (error)
+			goto reg_err;
+	}
+
 	/* Report current state of buttons that are connected to GPIOs */
 	gpio_keys_report_state(ddata);
 
 	return 0;
+
+reg_err:
+	for (--i; i >= 0; i--) {
+		const struct gpio_keys_button *button = &pdata->buttons[i];
+
+		if (!button->regulator)
+			continue;
+		regulator_disable(button->regulator);
+	}
+	return error;
 }
 
 static void gpio_keys_close(struct input_dev *input)
 {
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
 	const struct gpio_keys_platform_data *pdata = ddata->pdata;
+	int i;
 
 	if (pdata->disable)
 		pdata->disable(input->dev.parent);
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		const struct gpio_keys_button *button = &pdata->buttons[i];
+
+		if (!button->regulator)
+			continue;
+		regulator_disable(button->regulator);
+	}
 }
 
 /*
@@ -829,6 +860,16 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
 
+		if (fwnode_property_present(child, "vdd-supply")) {
+			button->regulator = devm_fwnode_regulator_get_optional(dev, child, "vdd");
+			if (IS_ERR(button->regulator)) {
+				if (PTR_ERR(button->regulator) != -ENODEV)
+					return dev_err_ptr_probe(dev, PTR_ERR(button->regulator),
+								 "Failed to get regulator\n");
+				button->regulator = NULL;
+			}
+		}
+
 		button++;
 	}
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c6795eb7c6143a79655a6f918446eb..66e786ad7eba407dbea2545941f5b6e464a4f61c 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -3,6 +3,7 @@
 #define _GPIO_KEYS_H
 
 #include <linux/types.h>
+#include <linux/regulator/consumer.h>
 
 struct device;
 
@@ -36,6 +37,7 @@ struct gpio_keys_button {
 	int value;
 	unsigned int irq;
 	unsigned int wakeirq;
+	struct regulator *regulator;
 };
 
 /**

-- 
2.43.0

