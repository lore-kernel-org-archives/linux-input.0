Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CB4EBAED
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612807; cv=none; b=mGiYa9RZfUsOYXOn0jEwD+EReLsKn/CRhgNX3cNuL4NI7NyWidbXm57JycaKuCxGdiIcSwUR3CHRi50TUrax8Q5n+MNkDUtz4Nt+jmsTF2jgw7oisroHQP53ZDbXpAHfWsyC8yEQt9HDyWPGWCWSaGgjD4QkFP6sJ8PFzDcmZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612807; c=relaxed/simple;
	bh=A9JWXJhhYbjEw0Q/FmT2TC0JFq9NWAqh52pS9DhlAR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOJtCe6IGEPt+hWciebaRb73/gQMK9C8bfZbjWX7i9f6tSjuaFosiPNTTz1b6dYHZWWcgQZ+pPagbuUn0DVURW+R5j9bAN5JPfCskrevCRsBDJOtVg/g3sFHUsKtXslFuykcp07ESsXl2kF095bdW/r5IXvmHLlRuGjWR3Dk3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH0fldog; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH0fldog"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso4612093a12.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612804; x=1791217604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ciF559s1gnabWjBTiObZN3nBwqiMjrqb8Ji1Ou0L1qE=;
        b=TH0fldogRN5oibEj0bfbhKVI6R8puOEOaMRhE6kSVi2aKZzIyJZ6prBABkI0GS2i54
         Rqd3oHua+WoVPUsjg1ezyPQMAGNuTztNM0t/SwMJRpu4ZZo/5rFxtlh6gXRZEMW6y3FX
         dBThd5Z9yggoExThAVm6hOZ7TLOcS1l5zT/pll7nkXy98pT0yKf8MPn15IOmUxRh3iuv
         SzCo8ovjO9DxGunlv+JAp+2OEbwC/aYWVzQ7tAbsKUJHO4O3I2IfZeoemjONdS30eFBs
         4cAEiw27bncyCI1fgnnG1AENBiiGOYgOLzGTAdHE+RUT3CXFTJq0VUJ8EMUpoLR8zHjV
         OewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612804; x=1791217604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ciF559s1gnabWjBTiObZN3nBwqiMjrqb8Ji1Ou0L1qE=;
        b=O1T+n1Y7uTrxDj+NWg33OaeB3cteOWT6ZAV4o45Zdc39Wz+TIo/7/T264zusdxKEPj
         oUnGKEKdOwRYyM2Nz38ACHkqJ46BQxIeU0JazfEKesg5bc/iDKu9KEu9O7x4Cw48Zg24
         X+O0FkwG48xOsjYamfawughH5uZnEsNATpyOZji1Y7dQH/wxo1YjfqgEg8YquhKfNG2p
         ulaSkBI9NExdvnjAQ0mO5m+02ucu8Oo0oYILqRvpWWmnW9xSsHmabas71OvykEGgO34Z
         8FiAjsRq6ZOMsUaUbvE868OL32n1bWODheyfIGKuPJ5NVtFN6ITx94+aUeprcWUfHoZ5
         U8Pg==
X-Forwarded-Encrypted: i=1; AKwUvBw1rOXITAYUOWXjOLCPmGcZ5xUro7GIrTlV8XEHiCKCLCC7IJuSmDqaMDhSB/rRnY19ayhlwqoW34c+EA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLXL28Mll008Kh9bpOUXxMvunda0B/gRFMdW8UljI6DkAXpv2xw
	jvdCCUt+15jUtYQrt3jFwjrzS+7Azq32exi+DuvEy3QGcsAhRR2gN6M2
X-Gm-Gg: AYBFou2xEdRJzEYbEOlRo6EqiejmRg23pQ/Ye/byDfnHkUBlFb+Qb9F6Y8amJHCArHa
	/xRfSnkTXIDwoWO+oCNjO8DjFjU4aSFGdP4dPZIB2BLk/Rg64CGeCI5VQlOLh9OLN8IFErPBrDN
	D7XsjZGLXTtbW/tVUg9b+icrA5FioPIp2lPGyHVn5m60Z5Cl2D4Zn5hXMnNnm/PLXbqlxZxFrah
	dX2ReXUkgiFgjLNmEcJpBdd4c5J7LnSS2YvaQx/tN1HYcFBqi2fkM4IF0qbAFra3W7pGdkc/M0J
	MUFOsoJc3rTmOzwyThx2OVZHRHN2mGr94Y/6eBmazvqxRN2Xkv9mlwAmBabJCkvtO2yOJdWsJJR
	r4RRQ+r3BMWGEb7C3lfg7eyByWR5CksLK2IW5B3NYxcEALiYrv63XAdIcRwsUfOOBHDvFRhn4qM
	8rsVA1SCUnSOGT3SKApeMJAAI+yTTH+zGKvWCfNNGDinh7mlRVFGXg1jWV+HB3XccHhkGOWfiF0
	0jmg0Xcd1YSIG8TF/QIl9Y/VcADJkcZK/5E3+DCGuiDBKSUKyITCzA7Ba2CsNPXB9SrefURIOFw
	1W7Hv7UdCnQ=
X-Received: by 2002:a05:6402:23d2:b0:6aa:f187:26bc with SMTP id 4fb4d7f45d1cf-6aaf1873468mr5827998a12.39.1790612803776;
        Mon, 28 Sep 2026 09:26:43 -0700 (PDT)
Received: from localhost.localdomain (84-216-182-59.customers.ownit.se. [84.216.182.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5cb9a72sm4277474a12.7.2026.09.28.09.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:26:43 -0700 (PDT)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>,
	Rob Herring <robh@kernel.org>,
	Jeffrey Lin <jeffrey.lin@rad-ic.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Input: raydium_i2c_ts - defer report buffer allocation
Date: Mon, 28 Sep 2026 18:26:18 +0200
Message-ID: <ab1e1006a0ddebacc8b36023a062651fdbe57e97.1790612085.git.pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
References: <cover.1790612085.git.pooyan.azadparvar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices may probe in bootloader mode, where the main firmware packet size
is not available yet. Allocating the report buffer from probe in this state
requests zero bytes and leaves a ZERO_SIZE_PTR until firmware is updated.

Allocate the buffer from the main firmware information query instead. The
query runs before the IRQ is requested during normal probe and with the IRQ
disabled after a firmware update, so changing the allocation point does not
introduce a race with the IRQ handler.

Link: https://lore.kernel.org/r/20260927114425.442803-1-pooyan.azadparvar@gmail.com/
Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 00990c61010f..1d7f53d0b9fe 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -373,7 +373,7 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 		if (error)
 			continue;
 
-		if (ts->report_data && ts->pkg_size != data_info.pkg_size) {
+		if (!ts->report_data || ts->pkg_size != data_info.pkg_size) {
 			report_data = devm_krealloc(&client->dev, ts->report_data,
 						    data_info.pkg_size, GFP_KERNEL);
 			if (!report_data)
@@ -1135,11 +1135,6 @@ static int raydium_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	ts->report_data = devm_kmalloc(&client->dev,
-				       ts->pkg_size, GFP_KERNEL);
-	if (!ts->report_data)
-		return -ENOMEM;
-
 	ts->input = devm_input_allocate_device(&client->dev);
 	if (!ts->input) {
 		dev_err(&client->dev, "Failed to allocate input device\n");
-- 
2.43.0

