Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078532F741
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854354; cv=none; b=gN5rfuKCw/posKHJuHuaDZruR4ATUWi/hh8MVixdp5NPWYwA4V56w0De0kHORdzjg0IqH8HsrEI1QSeUBXtcQ00oJN7sct2EJxHg8k/rPOpIgMIQh+PeMLCouuqxgmTMnTPitSb0yv5k71WatOvfgtD/I6GatGCkQxzpytItv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854354; c=relaxed/simple;
	bh=FS6cD0vxLAwAM3mRmPraBnI/fwTXc7kLz9dq3OySe+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND0jzyjMTwLwKBmE4m/Co7SstajJ6QGytgeZA4yQrgXxSHbSElo9zf4kxqTXpOYP5sqkoRYWnZ0SlO8U1gdeCTAKmiF+Ljz5WrJ/8yudu3COwtqJNFF7luMgZDSS6FKtcULYgkzAUWF2/zRT5lG8GkF27kv/l/AZ1xTGG6bhG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va3Nv31h; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va3Nv31h"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8876d1a39bso832617666b.1
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854351; x=1771459151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk+U1XhvopRQh0tCKUkJe+M3cf4DnqtsFhbvW3ea8p0=;
        b=Va3Nv31hCIMGr7DyCLBu1/gg8IlkrGBCVeOSqmuIAUDY6SK+ZYbNJ63dxBrrqsqtF4
         xyteDiRwXTrmMrr+OmZWz53WsAJV6xHC3HziLMJ1Ov/uQSQPNJBMdr8Wx6VXrPrYMmuv
         yBVM1G+18khhoathrjxEQjOCd/oEFqKhkIGh6/XXbAHIz4hwHi2jWsLzZnnlXECvln8W
         9VakgKLGZqtd7KMyktxCpLmI72WuREjAW+lW2jCJ1xeIvmTTjJbETVfFPZ7e6RP5Se9e
         pgc5nkZrrxqfbEpNf01HXWN+IQcItOTi3u9bHO7aBaHvGHCO4jBsa7Sp3/2s5EIotJft
         nusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854351; x=1771459151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qk+U1XhvopRQh0tCKUkJe+M3cf4DnqtsFhbvW3ea8p0=;
        b=VQwtEZrhMTDsCtwMO5iUvIYE1/y7PZpfOgVTP65huNzYOOLLXj/URkyCDqy+HFkagw
         XKnEKmMdXdgargR33hI7KEjvqjttq04oismPJSsUIxlwcL0tWn6b0rqNiOwA0o+lCHdI
         htqBQ1I8BcQg2pdgVaeQmY4hscf0kFL68mLDuhXV35/4mubBKnVeNLUu1cQJ6ifC+PnY
         2eyjOvdim9RjbulttYRX+xHn8P3EZFhmu5bkezfJeDUU/8Rge5Lr3kI0MSWUTejF++Pe
         1f7265Is2JX0zdEOuSMBBdBa6f+7HaAeK0B31fVPvPh0m/vvg0QMjnRJiLDYu2AJJ/zb
         22Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXiH/MEy4vLJerH2Ge99EoDMR1GVIIPBXVVjHQUjXQAgM5ZdL2RIViZaCf7NmyyvY9epTLoB9cM3KW7bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+JWyl4+acccYHc50WuCraSeqloU9KMAmm6/baFEhw/6Q15Jj
	2Df/t+uqjBKcFbCpjs+osuHAuTlUZJ5WD/02mwJsrbP6QtNhsToYtKz9FyUXBg==
X-Gm-Gg: AZuq6aKmHeyAiidmlchTISZleBweXGT35eN2rO9xZzqP3FzXHoA6329zogyii5MBhKw
	fYc4fwzSsUbqBcHWdsm7yC9IIeV33DJ03BHfw2CMhP8SF1B9JERui2nEAUW7bfPZjl1U7nsjmvW
	/HxtrWqT7nTCCjr8d5KzTl3v9tNq2oFJyXWDGaiS1TXtAKphG3MWL7JYvvH6UAMxDCO2HNnF6K/
	/kSr0jRyDyE6wjmh2BAQxq67Z0n58vlwFC0UgWDvgrG+TurFfuw9BBTxmylW9VpMlPCtcGrw8JS
	b2sff1lH7g4ywQ+bFroiB/7JldfYo014H/Ad7IsWRpEvWtZ+akj3msKS71A6W8p3+mqHlb2fV32
	fyZP1pzEt/3dJUEZfzQhuBqe/7aViJFwJrgzRZbP3miOnyQSD89JFvEjKdYNxxblAUOubqlywBS
	kqkjQTdDp1aLtKfA==
X-Received: by 2002:a17:907:3cd2:b0:b87:1edc:5a27 with SMTP id a640c23a62f3a-b8f8f5f5c41mr37134766b.1.1770854350781;
        Wed, 11 Feb 2026 15:59:10 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:10 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 5/5] input: drv260x: Don't try to disable dummy regulator
Date: Thu, 12 Feb 2026 01:46:55 +0200
Message-ID: <20260211235902.4156624-6-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211235902.4156624-1-jekhor@gmail.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use a dummy regulator for 'vbat' because it cannot be disabled
during suspending.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 44 +++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index f7bfac6d3973..e82ede54c6f6 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -548,11 +548,17 @@ static int drv260x_probe(struct i2c_client *client)
 	haptics->overdrive_voltage = error ? DRV260X_DEF_OD_CLAMP_VOLT :
 					     drv260x_calculate_voltage(voltage);
 
-	haptics->regulator = devm_regulator_get(dev, "vbat");
+	haptics->regulator = devm_regulator_get_optional(dev, "vbat");
 	if (IS_ERR(haptics->regulator)) {
-		error = PTR_ERR(haptics->regulator);
-		dev_err(dev, "unable to get regulator, error: %d\n", error);
-		return error;
+		if (PTR_ERR(haptics->regulator) == -ENODEV) {
+			haptics->regulator = NULL;
+			dev_dbg(dev, "No vbat regulator found\n");
+		} else {
+			error = PTR_ERR(haptics->regulator);
+			dev_err(dev, "unable to get regulator, error: %d\n",
+				error);
+			return error;
+		}
 	}
 
 	haptics->enable_gpio = devm_gpiod_get_optional(dev,
@@ -626,13 +632,15 @@ static int drv260x_suspend(struct device *dev)
 
 		gpiod_set_value(haptics->enable_gpio, 0);
 
-		error = regulator_disable(haptics->regulator);
-		if (error) {
-			dev_err(dev, "Failed to disable regulator\n");
-			regmap_update_bits(haptics->regmap,
-					   DRV260X_MODE,
-					   DRV260X_STANDBY_MASK, 0);
-			return error;
+		if (haptics->regulator) {
+			error = regulator_disable(haptics->regulator);
+			if (error) {
+				dev_err(dev, "Failed to disable regulator\n");
+				regmap_update_bits(haptics->regmap,
+						   DRV260X_MODE,
+						   DRV260X_STANDBY_MASK, 0);
+				return error;
+			}
 		}
 	}
 
@@ -647,10 +655,12 @@ static int drv260x_resume(struct device *dev)
 	guard(mutex)(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
-		error = regulator_enable(haptics->regulator);
-		if (error) {
-			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+		if (haptics->regulator) {
+			error = regulator_enable(haptics->regulator);
+			if (error) {
+				dev_err(dev, "Failed to enable regulator\n");
+				return error;
+			}
 		}
 
 		error = regmap_update_bits(haptics->regmap,
@@ -658,7 +668,9 @@ static int drv260x_resume(struct device *dev)
 					   DRV260X_STANDBY_MASK, 0);
 		if (error) {
 			dev_err(dev, "Failed to unset standby mode\n");
-			regulator_disable(haptics->regulator);
+			if (haptics->regulator)
+				regulator_disable(haptics->regulator);
+
 			return error;
 		}
 
-- 
2.51.0

