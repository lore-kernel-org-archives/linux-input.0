Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113320;
	b=0GBLg9MwiiHAeM3NjjESiPllmC2u3XLkyC4oJdv/qVAwJiYnqp3QvPY1JtaXG9ECyyhM
	 vpPHTVTHW6TU11Pu5DrQ3xzNXBFdtga9FQEVYpAw/ia4oaaIvX2k03CYw7wrXst1OnzCS
	 prP9iNhfXf47gRzub4xptVp523Q64Z7nHk46uF2XmmCIOr/ACB8BImqwtqZOKqbD2lkf3
	 sfPWxU7/TwsCg4RXhU72+OCFf1pxBQmMJt8dQREFA7bbQ4uNd9Sx/+dWdoO0UuM23v9Fj
	 SUQE97QEyOOsaYEgl/v8ex5WOs+fmAkOgAE5qW1nLKsfizaClDsck5FEUqhIw9q/D2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113320;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5rr4KVYUwS00eV6h4Ur0WZubiToiZFWmqJNWDXUyNEk=;
	b=n1vVPttANLYfQGy4p/F0/2rd4u5jCp0+JGV41ZAsUeX2C/1x0TkXo09pISPWnQ0c8Nvz
	 TABY8KgGa/WeQMMqTjmRECC+5XJNyfIAD02WQSLpwkmdkyeYYWbU8HiqitbtrUmaA3J3Y
	 nR4KoBo30xE+9oLeo91w0wDnppzpAEYeUFTPONPXIsxlQVbB1JLptDcHeBPwnXSzKMX26
	 QrwI3FFlbhWCJGKcO/RoDACcoOycxD1o+/ZsBHkC6nPp+QStBauQOq7DBxFPgc7lNhqh8
	 PcFDwI4Bwffe5Bn+wZe7Z4sNUUQcKKV9FCWEjfBmzRpJbCa4YIwhMdzul4mBvrAQhmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=BlX8HBSb;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F4606A324;
	Thu, 19 Nov 2026 18:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 702F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=BlX8HBSb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5rr4KVYUwS00eV6h4Ur0WZubiToiZFWmqJNWDXUyNEk=; t=1795113320; x=1796322920; 
	b=BlX8HBSbR6gsXS4oLnAjmeCAI+gOkeoOm2KSehdDHw1FO7szzSYP1Vaq50sndFNGnrb5dEnfSxl
	3dqi4immXaiyF0+q+ZVfQ9fvK54v3p5Ti46JTq4lTFW2RxA2d7VycTKkTR0cIkfmHGa1WEVQLNNCt
	XfAr72vaICTNfnHM/L5+I7t6PdJbZAxNJGI4Amoga2CDydqBSDEJBczf2Vuxhn50Gik36HGWCGukj
	rf+JaPOBTGQvNF7V/fC+EZGBEtXwLAmRESqX7hlva8QHLN17hs0MbiSe1XM9YVXMli+Kq39CbffCB
	JvMCrdsLroXmOFTl6fMuw97wMUhO03e3l4ZQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 19 Nov 2026 19:34:56 +0100
Subject: [PATCH] Input: cyttsp5 - Use dev_err_probe() to hide EPROBE_DEFER
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
Message-Id: <20261119-cyt-errporbe-v1-1-7faa44e821b4@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAE9B/2oC/yXMTQ5AMBBA4avIrDXRSurnKmJhajAWyBQh4u6K5
 bd47wJPwuShjC4Q2tnzPAXoOAI3NFNPittgMImxWutCuXNVJLLMgqQsWpPlTVJgihCSRajj49t
 V9W+/4UhufR9w3w+i46FFcAAAAA==
X-Change-ID: 20261119-cyt-errporbe-6b6278a09b3b
To: Linus Walleij <linusw@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=ePghd3pJr/R938Z3aAj3mvyY+bWToG6Do4p3q8V8Vfk=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq/0FSDuqs0ZTdqGplBHDE099T6NXoP5SnWpxcH
 24RHwT1tkyJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCav9BUgAKCRCEYUX6QCjc
 8QyGD/9GHCxcymO471y4NIzueJe0NhsFv0Ae3ZQgGvrhh72Jnr9uBFUeSwNKgyKQsYlrh3FnOMV
 rK9peo+XGsDDdpbFzyOlMSQlKIgMt1EdV6c//gumPzHBMVr+N3ooAACFF1wmLiDx+tVTIJ1ooGf
 DfYAG+yonSQ9BAceJFf2Oe4Xk3OBySVvjcTtiFx8/2ejTgiCTgEH3CXvVAtjjLCgeLS0SzknWsI
 fOQ22sxUco5VkVElC8cwcpNNDqEGjhvFMfvUbVKlykeEInJdLJ14jAmo94sF3/KijnCIHk79Y3h
 J8X42ZkXzlP6ytUBTEe0NDf9YU4P4QvWs+4BzgHL7cGHk2iVVEGQxD8l5tPbKQ7hpBl9JKJzu82
 x/8bIiI9/favE+eJm2ZqRvY5vDFuD1RlcTmXNhhZW+SrwDnnLGA1hcSz22aQz2iqscFs9pVt2e7
 35YylnBoiU4zefiTqIABfRWLhqdlgt8TPoCOMO3AS+yfrUQTQiW9WZ7HsEoVSw2XdYyMuvyg3S5
 p6RLyTFYCLRLIJo8ER6mJc7tgsv27o35LfDeptZ40Q75rYjA5HruuYFqulyEOcuSl1bj9e1PY+c
 LP7F6MJuh7djhA0KSqG7a1p0rPNzdkesp8VJ973YSS5KVZn+MnkJyg+jyMhYqExnxy7wpAYyzWK
 znl6hU6kWSS6hpQ==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Use dev_error_probe() to avoid unnecessary noise if prerequisites
are not ready like the regulators.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/touchscreen/cyttsp5.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index d4a78facfa815..82209bfdf828d 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -844,20 +844,16 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	ts->supplies[1].supply = "vddio";
 	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
 					ts->supplies);
-	if (error) {
-		dev_err(ts->dev, "Failed to get regulators, error %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(ts->dev, error, "Failed to get regulators\n");
 
 	error = devm_add_action_or_reset(dev, cyttsp5_cleanup, ts);
 	if (error)
 		return error;
 
 	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
-	if (error) {
-		dev_err(ts->dev, "Failed to enable regulators, error %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(ts->dev, error, "Failed to enable regulators\n");
 
 	ts->input = devm_input_allocate_device(dev);
 	if (!ts->input) {
@@ -874,8 +870,7 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
-		dev_err(dev, "Failed to request reset gpio, error %d\n", error);
-		return error;
+		return dev_err_probe(dev, error, "Failed to request reset gpio\n");
 	}
 
 	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
@@ -887,22 +882,16 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	error = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
 					  IRQF_ONESHOT, name, ts);
-	if (error) {
-		dev_err(dev, "unable to request IRQ\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(dev, error, "unable to request IRQ\n");
 
 	error = cyttsp5_startup(ts);
-	if (error) {
-		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(ts->dev, error, "Fail initial startup\n");
 
 	error = cyttsp5_parse_dt_key_code(dev);
-	if (error < 0) {
-		dev_err(ts->dev, "Error while parsing dts %d\n", error);
-		return error;
-	}
+	if (error < 0)
+		return dev_err_probe(ts->dev, error, "Error while parsing dts\n");
 
 	touchscreen_parse_properties(ts->input, true, &ts->prop);
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261119-cyt-errporbe-6b6278a09b3b

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

