Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA343D88F5;
	Wed,  8 Apr 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670640; cv=pass; b=YkvFfzsv7u4IeRoQ/Fho/DcgnhRDsnI5eZIawNnA/mlrSTqJ0PORpoa/BSGCsJggH/2/CsqHs1ZiQ9d5SyfYJGIS+r7ZxGeY9KhjFe/e7o0d1/qeJxvyTMH1foAIRuIf1sxhJvfq0M1nS/XmcVwk3aYWbkVFxbRP3NJLlTuBBhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670640; c=relaxed/simple;
	bh=r5udnECKsPpJoxQWnr5d1htCr/6wgjxSCKGHWijo7rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pK/w7aDd37JeyJ4Y2Hbo3qzYJRid3kmkVJtj2PXlKwfZ8HLlUxqiYFCLdVimQMdsEPmnrjCCclhNxm7r02hOeEhtklSjTXUDsNf5eWktmoOMNrURX4vx3R4V+tXNfu+pC+WuXqX8BDZGMnxNy3MPGwf+hQX5QRo7j5qoMhhCDgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=N4nEnWLM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="N4nEnWLM"
ARC-Seal: i=1; a=rsa-sha256; t=1775670616; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QUScs5mcJ8uy13JCHd8SMzLuRaH68GUmqUcqijRhMKJQUiwMMvuwKS7bk9N7/h3xclq0zMLEAc3wiRku0vRffYCBOXNKctTBFPxi/xv9T6QqVUC1AxYQqLeE7e5pL56S16h9l1v4AvZMu1ShIE9zRpLIVFinlURy1K0oSecue9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775670616; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aGdOZPDEQlZyEcepynzJddniCrCMmyXxDTt6mBa/WB0=; 
	b=coKOFAGutKI5LC0u5bwhvRDLLGK0BlPAhsoJyKuj2yu9MYXWrPJiQCJTJ1ExUGawn1eW9nM8p9jEP2vfXl4da6zOxnLWDpT6veilWNog4t667IqMcpiqbREX4gvSUiKobdNzM/qyHTIVxnm0aBW6P16K1Wcqv6FZQJEletnkf4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775670616;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=aGdOZPDEQlZyEcepynzJddniCrCMmyXxDTt6mBa/WB0=;
	b=N4nEnWLMzTCmJkE/R/EN7V/ihhXfmmeEyc6TUOI7prTIIS+XMpg63eNJ1Z6yaf+u
	EBrOSOWIQ269238tcsEZZMWuc4AeByNHh+rP+P3Hwzc33tf/g+wq+UBqlebySYjk9ir
	aLLrYgDVCFL9AmGFVWL8CbWVeeOS5tV3X+gcxepA=
Received: by mx.zohomail.com with SMTPS id 1775670614366927.2234922599506;
	Wed, 8 Apr 2026 10:50:14 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Apr 2026 19:49:41 +0200
Subject: [PATCH v3 3/4] Input: adc-keys - Use dev_err_probe in probe
 function
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rock4d-audio-v3-3-49e43c3c2a68@collabora.com>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
In-Reply-To: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.1

Rework the probe function, and functions called by the probe function,
to use dev_err_probe for error logging.

While at it, also do some minor style cleanups, like not error logging
on -ENOMEM and using ! instead of == 0.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/input/keyboard/adc-keys.c | 53 ++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index 62376f34f7d0..6f2ddcecea99 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -74,10 +74,8 @@ static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 	int i;
 
 	st->num_keys = device_get_child_node_count(dev);
-	if (st->num_keys == 0) {
-		dev_err(dev, "keymap is missing\n");
-		return -EINVAL;
-	}
+	if (!st->num_keys)
+		return dev_err_probe(dev, -EINVAL, "keymap is missing\n");
 
 	map = devm_kmalloc_array(dev, st->num_keys, sizeof(*map), GFP_KERNEL);
 	if (!map)
@@ -86,17 +84,16 @@ static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 	i = 0;
 	device_for_each_child_node_scoped(dev, child) {
 		if (fwnode_property_read_u32(child, "press-threshold-microvolt",
-					     &map[i].voltage)) {
-			dev_err(dev, "Key with invalid or missing voltage\n");
-			return -EINVAL;
-		}
+					     &map[i].voltage))
+			return dev_err_probe(dev, -EINVAL,
+					     "Key with invalid or missing voltage\n");
+
 		map[i].voltage /= 1000;
 
 		if (fwnode_property_read_u32(child, "linux,code",
-					     &map[i].code)) {
-			dev_err(dev, "Key with invalid or missing linux,code\n");
-			return -EINVAL;
-		}
+					     &map[i].code))
+			return dev_err_probe(dev, -EINVAL,
+					     "Key with invalid or missing linux,code\n");
 
 		if (fwnode_property_read_u32(child, "linux,input-type",
 					     &map[i].type))
@@ -129,7 +126,8 @@ static int adc_keys_probe(struct platform_device *pdev)
 
 	st->channel = devm_iio_channel_get(dev, "buttons");
 	if (IS_ERR(st->channel))
-		return PTR_ERR(st->channel);
+		return dev_err_probe(dev, PTR_ERR(st->channel),
+				     "Could not get iio channel\n");
 
 	if (!st->channel->indio_dev)
 		return -ENXIO;
@@ -138,16 +136,13 @@ static int adc_keys_probe(struct platform_device *pdev)
 	if (error < 0)
 		return error;
 
-	if (type != IIO_VOLTAGE) {
-		dev_err(dev, "Incompatible channel type %d\n", type);
-		return -EINVAL;
-	}
+	if (type != IIO_VOLTAGE)
+		return dev_err_probe(dev, -EINVAL, "Incompatible channel type %d\n", type);
 
 	if (device_property_read_u32(dev, "keyup-threshold-microvolt",
-				     &st->keyup_voltage)) {
-		dev_err(dev, "Invalid or missing keyup voltage\n");
-		return -EINVAL;
-	}
+				     &st->keyup_voltage))
+		return dev_err_probe(dev, -EINVAL, "Invalid or missing keyup voltage\n");
+
 	st->keyup_voltage /= 1000;
 
 	error = adc_keys_load_keymap(dev, st);
@@ -155,10 +150,8 @@ static int adc_keys_probe(struct platform_device *pdev)
 		return error;
 
 	input = devm_input_allocate_device(dev);
-	if (!input) {
-		dev_err(dev, "failed to allocate input device\n");
+	if (!input)
 		return -ENOMEM;
-	}
 
 	input_set_drvdata(input, st);
 
@@ -178,19 +171,15 @@ static int adc_keys_probe(struct platform_device *pdev)
 
 
 	error = input_setup_polling(input, adc_keys_poll);
-	if (error) {
-		dev_err(dev, "Unable to set up polling: %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(dev, error, "Unable to set up polling\n");
 
 	if (!device_property_read_u32(dev, "poll-interval", &value))
 		input_set_poll_interval(input, value);
 
 	error = input_register_device(input);
-	if (error) {
-		dev_err(dev, "Unable to register input device: %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(dev, error, "Unable to register input device\n");
 
 	return 0;
 }

-- 
2.53.0

