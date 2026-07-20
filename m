Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B03D330C
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538552; cv=none; b=cISwBNqpz/fD27l12mu5TMGmoVZ4psGnRoEnYH//MaIDHLREqo2qrI6j9lIrcly4F2+p4rkaAunHofGwheL3KJZC4cXwzMglmy/6oK6rJK9pVOl6tTP81LfZNSmnGf+JFGHP+DLBCAk3+e7s0QYcecuYJ2+XtN7N3FvpcLSGO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538552; c=relaxed/simple;
	bh=cp5GMJl78VOV2ZnPubQ1XQux9HWWcxPb2jYopOuiM7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5SEjaYQROXWmGy9nDUySW9hExerAkypBEIFjZ9AQ7eXg+44yFDaX8ljlCY6aNnu3+FcKOataNhYiXlgjglgObp0ZoGzcurgib62LtEfR0wWEYP3g39UGDjnqvQDUCqcYgc/RyqVHcHcAJ2lUvGpfPiSxu/FEWDkrX3YhIw5FC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9nKtssY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9nKtssY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2dcede83so8880440b3a.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538550; x=1785143350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJj0iaMZG8c24+7ry3yV2ItcOfDprvTeycFTyhXXA3A=;
        b=o9nKtssYPLwmrpCQNlYpnU9ft7x6LltoJreEh3NijMyTPOK0Pl8xi7vYOWLp/Yfbpf
         ulTzjh3vrUpEj6AuaVFAZEXgp81f7iwLNXbB1jLLVeseG4JMKQlkbg3AEvCgpyxwkH7f
         SV1DxUZOfp2qWqH/gXOnFVo+FK/JSK4750NlDw8UTLU5+HJtc4M3YbK2zf9UeZBq7pVU
         /qwDFLbYn0m4eDPWV8Lg4Pug1frjcyPQc01Hxl1stOfdpJL7fdtvyxb4EfaWt0ZTAfTL
         vhk0gQXiKmlyrIeGoZPohJvv/JLp7eOnvEIcF4W7Kq/LwXi/F4pQO+IgA5N2BKM7y8p/
         KCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538550; x=1785143350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SJj0iaMZG8c24+7ry3yV2ItcOfDprvTeycFTyhXXA3A=;
        b=nxnxECzas0fhmRcc1W1bkLz2E/6NlWgS/nwZaTtoQsvpxPwt1Kka5KvMcrLBOe8RoS
         Ks6xxCLwBOaQpbzim8dO1TpO7DDcBG3GLwHN+IAjw2A8HoMfXYagzdlPrUD6qZ9zOmsw
         tAvxgieUzYaHXPZvaNJPNUG0B7xwXFPtWC1JhocCzQGfGqyQ7a818/5541vTDfZiUl7X
         aOwtAGtaWbdPDmAVsmBrAbMeyjBgWw9cjJRswB77co1N+0RmySp6YmYrj0yOU4fGfGY1
         Gh0zTvuyHeglqKlKD0f4Y482CpA73eedr4qWnLczG3a4/PFugs8Q47o3Y1dL4+eDnwSF
         7svg==
X-Gm-Message-State: AOJu0YwweaCTs7tuaApEBAp7130wu24ue5rFJYMeeiJj4cN9/HnV/KnK
	EF/60fIFR/XBGZsYrL6Mimq9Zyn3U5NvfJzBJuVVHu05dBdbMroc9EAE8lTROA==
X-Gm-Gg: AfdE7cl80ByfSnXA/JGHHJHiRa5HYO/OYJNxdTB8pHn0Cx+N5RyB3H4zGAr0XSrqLEq
	tHDrajIowArc6RaQrjb5rORraUGIqj3qgbbIvK3ClAjeQBsnhWb7VTaDk4NsVVXAi/6VLBuORWM
	SA8+AXxoAgbAwethDbN6lTD0R7Adax5uxwZ1YtpZ2tQImuhiPc1t0muoLJQcqQI0MNrL6h6kVLL
	TZf/lnsRCnNcYbGbbbBD8XHHjGgMQ8a7A77ip9GtPAxCBukBdlH3biQwKLiXqIj2VCRQNJ76qno
	4DcZq4wDvhavdfgwGHSq0Uk2HpV+vKLzGGsc/fQnuNsNr8w+qcqDgdOmQRNq+lEq9oBDXV82cih
	6LatB7P52JwoSIXBsTG2bAIwP8D77lHedy0tUjyM2nSghT1+OogCoKZ9ve6hZcOJw4GX8++PaA7
	qc9v1pDQ4ZXBtrGmM/Lp/qX1nWUzhLOfovnPLm
X-Received: by 2002:a05:6a00:3d0b:b0:847:8dec:141e with SMTP id d2e1a72fcca58-84c294fdeadmr13907957b3a.54.1784538550424;
        Mon, 20 Jul 2026 02:09:10 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2bf08b7dsm5374106b3a.10.2026.07.20.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:09:10 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Date: Mon, 20 Jul 2026 16:08:50 +0700
Message-ID: <20260720090851.230244-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720090851.230244-1-phucduc.bui@gmail.com>
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Use dev_err_probe() for devm_clk_get() so deferred probe errors are
handled correctly.
Drop the redundant error message after devm_request_irq(), since the
helper already reports request failures internally.
Return the original error from platform_get_irq() instead of replacing
it with -EINVAL.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2 : 
 -Return the original error from platform_get_irq() instead of replacing
  it with -EINVAL.

 drivers/input/keyboard/st-keyscan.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index e53ef4c670e4..8e9bac339dc4 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -173,10 +173,9 @@ static int keyscan_probe(struct platform_device *pdev)
 		return PTR_ERR(keypad_data->base);
 
 	keypad_data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(keypad_data->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
-		return PTR_ERR(keypad_data->clk);
-	}
+	if (IS_ERR(keypad_data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(keypad_data->clk),
+				     "cannot get clock\n");
 
 	error = clk_enable(keypad_data->clk);
 	if (error) {
@@ -188,14 +187,12 @@ static int keyscan_probe(struct platform_device *pdev)
 
 	keypad_data->irq = platform_get_irq(pdev, 0);
 	if (keypad_data->irq < 0)
-		return -EINVAL;
+		return keypad_data->irq;
 
 	error = devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
 				 pdev->name, keypad_data);
-	if (error) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+	if (error)
 		return error;
-	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-- 
2.43.0

