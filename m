Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2E34EEF7
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167466; cv=none; b=mUQEWuKGM74zsej6+p0pw60VDxTJdf6ccR76TZ/fqtOM1NBru+DXsOfZAScTOiDNGwUXtHRLZoxxlHSo8dqymz8IY1K6552gJicfu87CF4hygaTSMF+pd7x1SiqLhdjt3xWoQgHZa6BNs1/iu68lAPjhWsvA2WPZka4PRqzB9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167466; c=relaxed/simple;
	bh=nLqGp3I6iyqF8SyHzWbaClXTgEW5Obat6jczuJPhFRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdB6SpCnpd9gAVSNOrHzbeG+NXDHFvkZm7XJtLewSRw9LvtdKVZWJziByUzDEoqhb4B1TwpAEEwL1hqEC3xvClKsHXYUgwMGYIb/xH/hMgl0N/SszpuYOxpNYDYAzaW/wjZvwJcwUfitwiQ+csODBHnq+GXKwCJ+TyBqvjnxAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMCoaiEM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMCoaiEM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9a20f70263so900352a12.1
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783167464; x=1783772264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+8ZZFSRrlymucC2FxpZWiwNa+74f6yAjx0IzSc+u0=;
        b=qMCoaiEMjpEbwvph9Z5lCYepQNZndZpmpRJS/D8Ix7Wuwvt+evsdIpSKKVc2Zxxl/D
         lej2vpCWFDeOCCsWN9vfDIZ6SR8s9JNXLtLHjJRh0eQrMNKU8ZB9UFp9D7jYn8c0mGGz
         A/+243fvBeBqc0GjgdLlPAqkmV4bkS+9ntSUqyQQFs2Dvz1vFUmh8b26J1cPF/9pW3Oe
         1zv97BMaqxQ3Okulx+ICH7bTXLWZgATYEvl+/RQIUHzcFm9I5BFjkGLcOx9ulv5kjcxW
         L0qlylieOpFXoF0XofZmFr/6gh3G2jpTtBO9BbrmZorFCm99COpcWu95vkDURHZjrEjs
         Hdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783167464; x=1783772264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap+8ZZFSRrlymucC2FxpZWiwNa+74f6yAjx0IzSc+u0=;
        b=hpxVe/BOJ/T0NJ9Sba7uaitbiVeQ+hETM/CrR9Mp7zU0NGNL+JJgOcA3SrNLn5CXAd
         huP+jJbATzldpZJ6BQCjg4nKgioahSqRI4De0j/0odtrOqICvBt1fOxzdZwfbIMjFwfz
         I3f4OxIPoCIxNCYfiZOrPBVyrhWKKxZ5y+664mAdadizyJEb8ezSS9yqvFZfRlYC08hm
         bdpLtYMVQ+zxXvr4pdz7cpvQ9ec+Q5g/+zB8XX5AJ8oBnKaCv68mSJ0f0bAzgL6xVTEG
         feH9gZIGQuGgzJmeckTsbRj1v7/Z8ByAPPTKT0BTbTa+QLDbe5Y4cRqBuSdAF2//Hjpf
         pizw==
X-Gm-Message-State: AOJu0YwMy8lko7C8jj+O2N7WH/d9UvzT7kPzO7C/ISkKtIJwaB7WOC3w
	EsH9ur68TrJ2Hoqr6njQXfQo9Oaa49Ql0q13f1JMakOWJ+MNUvjNBBuZrNeuB3JW6X0=
X-Gm-Gg: AfdE7cmxdT1K7Ze7FKjoas7wTQY3FH8J3z/SccCgbgorCw5uEMo4Uky2LU5iktV5D7C
	zZiFLvpSC54Aj5szDRCAmJwvWLHxu112yih4cz7KyaUOIPhv1p22vbpbohbr6ATLIAKZIT53T11
	KPavb7ueOaDNUWYeZ2Q9Yj6A5JeRsoRXVhPe5UH8xa3cI35gNw4NYWEthsPvLHZB2zUwJOwLRf/
	Wo0JA9FeUSYOyjM35h9zZ5aE80luILlSUQQVJi8cKSHta3SMTqmrkheCrwlfcN3ZkZX3z+j/rCG
	/Ljw+Ml/dUsG/NwqLckEGqUO0qirGSkl504xRaqWqVhEkhWpNiIiba2DEvTHSIzCiJErg/rENrm
	k0pfJre6ibBAt05fMg6JPPmXG/bz1RnfLfZIIWx48Wlk7CJaEX4wUEyqZLXWA6OEHp7tMnJgSwR
	5GCPQELcN05Wb4WeYMdxFsSbFs1iPVPSMbjGnjzGgVFZaBePZVCYQgFgUW3YbalA==
X-Received: by 2002:a05:6a20:4324:b0:3b3:ccd0:cf62 with SMTP id adf61e73a8af0-3c01cbdc95amr7827862637.36.1783167463959;
        Sat, 04 Jul 2026 05:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:1a77:4d22:a645:ecb4:40eb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm49901144c88.9.2026.07.04.05.17.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jul 2026 05:17:43 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: elants_i2c - prevent divide-by-zero on invalid EKTH data
Date: Sat,  4 Jul 2026 18:02:38 +0545
Message-ID: <20260704121738.48071-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elants_i2c_query_ts_info_ekth() checks the reported row, column and
oversampling values before calculating the touchscreen resolution, but
does not check the physical dimensions. If either physical dimension
is zero, DIV_ROUND_CLOSEST() divides by zero during probe.

Treat zero physical dimensions as invalid data and skip the resolution
calculation, as is already done for the other invalid information.

Fixes: 66aee90088da ("Input: add support for Elan eKTH I2C touchscreens")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 17175ad..68c5ee3 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -566,10 +566,11 @@ static int elants_i2c_query_ts_info_ekth(struct elants_data *ts)
 
 	dev_dbg(&client->dev, "phy_x=%d, phy_y=%d\n", phy_x, phy_y);
 
-	if (rows == 0 || cols == 0 || osr == 0) {
+	if (rows == 0 || cols == 0 || osr == 0 ||
+	    phy_x == 0 || phy_y == 0) {
 		dev_warn(&client->dev,
-			 "invalid trace number data: %d, %d, %d\n",
-			 rows, cols, osr);
+			 "invalid data: rows=%u cols=%u osr=%u phy_x=%u phy_y=%u\n",
+			 rows, cols, osr, phy_x, phy_y);
 	} else {
 		/* translate trace number to TS resolution */
 		ts->x_max = ELAN_TS_RESOLUTION(rows, osr);
-- 
2.51.2

