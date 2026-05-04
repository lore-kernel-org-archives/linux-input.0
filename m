Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD93A5E97
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892108; cv=none; b=arM8DMqRSs95lE9Deo6QApMPg4cewPGFldJp8oBUFiOlZWlA+nwIseYuVntBzpLl7BxSnGQcnMYgmUNEeh7f87lLVo2sQZXenZHwipA5agZFJfnuggE1xyUygjBgRzOgpptBjmjJ1DIbzuongr+RGHPW/2Oj/Sv3LWnmKlUKfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892108; c=relaxed/simple;
	bh=+dgffLgBiEP6ZBRGedun1KaOTrk/q8XcHD/7lgiAyQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cP1PNHlj2DhTrRTX2Otmx9w/2iBPb9VLr5R01BVFKRX4jGpxm0WS4/TKkYYoUZ8PAGYx1blwqlvgXO2JTtgGgqq2BJ++8c365sPpl6n1BaSKvlqo+HzQNPrx82WaevWV8uXbq/1JjRzrAMxBwGnIaUIkT0cBdr7TGm1wd4i8Deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aHCG4sEt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aHCG4sEt"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7d983f91so41601781fa.2
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777892105; x=1778496905; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcDLjx4hLgTrt8Ve4u4lIZsmkmGxyF9I6wHEUsyYi7c=;
        b=aHCG4sEtExwCG0zgv0l48pTohS4tt2KR1AyCDBSxrEuVHN68AnRzO9OYWsotnCZ6fY
         7jIQDGyHAMcp3bzt5j125jPvikl0GmkCLEaCw5NquWK7xAnE/UYrU8PDTCZB0V6hlEES
         DHGi1HB6dvI960WOJKTOQIqRliCMeoKMx5elk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892105; x=1778496905;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcDLjx4hLgTrt8Ve4u4lIZsmkmGxyF9I6wHEUsyYi7c=;
        b=JdLn4kBv/7rlba7h+2c8s0704/fPmH3YbA7eagXteZ6/Y+98JVog46fNVVVRwIsuKm
         1SG+NqZCEQXa3m8JR++LhVmF0OIx/vcyVoXpAU9ySxieYUTKTaHObeWbnCXcYoTO9b+z
         o+B1wnfwjIEunfuUSVlVkYaVdupXMQ8iyhjVoXcj4/CDmYRrsJeukbw5Y9H74u+pMObg
         ruNiMP4FtMhGAbKY6lPP7L3XhnYytIb5lwZWecK6QcH5eKA3Lmi044tzSK5H/+ngT0Sk
         D+sbfGRihMoVRhjNc2t2k/AM8TMia7rGSUtUc+FgTkX1UXX4YimTDPAXUSdVUoLKLGcN
         yCQw==
X-Gm-Message-State: AOJu0YxFKVcfJvI2cz1UvPYka7B234gZ0N14OrlVlBvjYR2U8lHzZNZH
	mlg2e4q07UPQrOfMtroKLX1h22kxEiKgW/m0fkVtUIzxYvG8XqZ7pMlLFtoXMZRIMdfrJXRJRg2
	ppbxuVRVU
X-Gm-Gg: AeBDieuW8mErglT5Ob2RxYiBWNVIGueQIMoiShCEvIoixYCfS0yLrg9yZeJHB/Gm9ie
	+eJMaCujHvBidxwbRxdUrTJmZhe6JudhAGzmeUOuZLjMfV+gVh5FJw7H2XLI5Os/A3b+NeBQcJX
	0wKRhzd0jqbEk8I6fagnhq3lquCXARVkFtepadGvUvon4zEmZAqZd7IruPQWB+ceGvh823bB+5r
	B4a5pYP7cdccFZnKy1mkheoL4vzu3+GoeInXLgQyDQex0Zv7mM02Xk/Zh5/G8tDWxaUASCk+oXf
	WziPM03LMUEzOXVxpKw9SkG6bB6xo99u2nZ97sMgoI07F/R8mWpPW6mHThNJirF/JneIng/ZHMP
	lp3vquH8E0PsAqnmdc2fRSI4hqdLYooXKHFJVWyPM07l+1aoHonjsnSrW2LKQMMN7U3N2feOc6c
	cmvzsJcykCYnBzVFCUC3UEraKywRCozpxU+g1untguXwfHAA5o1dqMPylsbxsP5AMYSxYoVOfq3
	zHtsgVO6jDCIyd67g==
X-Received: by 2002:a05:651c:2116:b0:38a:45d6:c246 with SMTP id 38308e7fff4ca-393783ef512mr33168221fa.8.1777892105339;
        Mon, 04 May 2026 03:55:05 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361323c56sm28904411fa.29.2026.05.04.03.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:55:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 04 May 2026 10:55:03 +0000
Subject: [PATCH] Input: atmel_mxt_ts - Set byte_offset as signed
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-fix-sparse-v1-1-1071137cd280@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAZ7+GkC/x2MQQqAIBAAvyJ7TjBLD30lOqy11l5MXIhA/HvSc
 RhmKggVJoFFVSj0sPCdOoyDgv3CdJLmozNYY71xZtaRXy0Zi5CeQkQf0FtyAXqQC3X7z9attQ9
 RBWiQXAAAAA==
X-Change-ID: 20260504-fix-sparse-3bfa6ba62e5b
To: Nick Dyer <nick@shmanahar.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

The calculations done to obtain byte_offset can result into a negative
number, fix its type.

This patch fixes the following sparse error:

drivers/input/touchscreen/atmel_mxt_ts.c:1481:44: warning: unsigned value that used to be signed checked against zero?
drivers/input/touchscreen/atmel_mxt_ts.c:1479:49: signed value source

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 87c6a10381f2..26ba82fb60b6 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1397,7 +1397,8 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 {
 	struct device *dev = &data->client->dev;
 	struct mxt_object *object;
-	unsigned int type, instance, size, byte_offset;
+	unsigned int type, instance, size;
+	int byte_offset;
 	int offset;
 	int ret;
 	int i;

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260504-fix-sparse-3bfa6ba62e5b

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

