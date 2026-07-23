Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF645D191
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820218; cv=none; b=WsaMDcbB2heqTMbcIiMukkeJib7FnpywoGhcuvVRmwJ9mbG3Nb1uwIvu3I53HI7/mPy/q9K7SSuXqc1+7ZLSR0BTGgb1+3p/FQ3pW7gf5hyyKDHSPowD37qMrGYyPoysiU0ZTLQdz/KQfRTmDLs8o6Mn9Ua9v+EpX0w6CnAipwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820218; c=relaxed/simple;
	bh=3+mLGmb+xo+Y7FWnjPd6Bk5tOhqzEHPjo9ocA5cAeR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMQyd/HylAnyQe6VihIqsvuH333LyU5VDS8mLc7LMDvK6bEWmw7b2A1FiiOE0fEHuxI+pTXhNATaoAZwhQiLSEr/xhxdet0tclUcv9Ol46Ekz9iu3cBStd6J4XCv2H1KqkK++bEkpHEZexUDPgv+qWuyhLPSJFG5rA6n3I4G7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=nWxR9koJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="nWxR9koJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so99102866b.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1784820210; x=1785425010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYlmrDRiIg93kPdC5KGJzikRrWWC1NJtz0hg41SezaM=;
        b=nWxR9koJQabmO9NIM5I45hzDIzoPU6L962Wo6OO7UVVqTNIesvjlJAwiGIyMTvhNr9
         lBUjDyrVZRerecOjeTDt413DTqsja3wjVHqHj1ngkR2rbmQXdAW6eyYB2EP9Gq/33g76
         C71o0gAw0soY6ssTOHMRHp6OlzmCSsCnRJsV6IJE7KF0s5zA0v9R9xURMNm7QNgaVDpC
         p32e6L11LLh6hKCHAxIaaNJ1h15STO69SgNI7J01R+RDRe4oDsSw6dZsRaA46cbXkMla
         x7YQMVH7VQ+AoziEDLQNYXNhpiI3KYVKzTIOJ5rZWS3+RGEUpHfjgq4ay2vCmWhEC574
         9HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820210; x=1785425010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYlmrDRiIg93kPdC5KGJzikRrWWC1NJtz0hg41SezaM=;
        b=EQ1qb4eWGoNf9ik1i//bRuba8wNq9H4SZH4xTB27+eKOqyf58Ib4OFxSHf24EQhR9V
         7THXDHp1vxmh06ADhcIRTbrMVg19+ydBc/7TCi5OSxeOVwJ5Zu4WywjA1AnZzdOlPHst
         QTuTOQ0C/EyWod/LsLE5GjdVoex180wmi0y/cx8h+vX47xLCZ+ZerC9UyDivOCMzGpiB
         eOzV3bc77Ali9wGW2B9PoiSVH5Q3UVj/hf/LMPl3Ut//Nx6TrlzRUPkEQGYTFNCRnFLt
         SmRzCxWvCfeRzIQMJCZYINMp04Cv3X1B7azUPtC25ul215y6NdJWTfHY0vEXwGOeyzGV
         mVaQ==
X-Gm-Message-State: AOJu0Yy/LRNh+D4EISwpsYJgeO6XrEWfHoQVXJq7HI7tNIsRBvLaqltF
	VUkLonM5Ug7sCgvJ8MY13BTjmBAMM1YZQKks2+fuNlcI0Ed7Bt+IlcGyk7UAnLSZvqJ9um6v4vC
	RbbhEKw==
X-Gm-Gg: AR+sD12y5Jun9yJswEa7s6QNTYCFoPOvic8q40QUDbTUOng/la4SKsY2VB+YUC/2s/0
	GPa7kpbvSLR20Z6noa89NH3+ycwujvBUUuqBpzBipYvnciKzPMhST/NWV3hP6qogq95Dq1BMbTF
	EOIS1/3EsmJXPrrbla8rFxm8+ILIOm3KqrJDj1bfhPIaTl5ORKxrJfVbPE/vW13XLqCu08TTs5h
	0UxEIsc56V66HhqzUcp1pzoU4+LcnFyehzy3Ezbg1HxP5TkWd454a1W1phGJGzKvwdlgnT/iUla
	PnV9dFcjHlpuHahgaEUr3+Q2t1kpvXJ3eU9a+/LgNFo6bpqlaX9QTT+BRkMPPHtbuZtTeMxwdlR
	MMevHKdSMCHP31VM/9PWehtcRP93Yg9D8Ik9+EiiSgrRPd+Ayd42RNilTwg+9URH2tGBCEq6Z6M
	4RGiHmCxSBlUn3bfXh6L4Y/eMlKO8KfUPdRczwSsGrR19b4Rrf7t4aXKFVJlGj+Ouz+KOdIYoBl
	5FK3WrFQ0FQ0za/CqsYGKEWrdmdEC3gixEH3OFu0g==
X-Received: by 2002:a17:907:3d46:b0:c15:b67b:523e with SMTP id a640c23a62f3a-c1c5092ecdfmr168445266b.19.1784820209846;
        Thu, 23 Jul 2026 08:23:29 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb385sm250749666b.52.2026.07.23.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:23:29 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v3 3/3] Input: ilitek_ts: ratelimit unexpected report logging
Date: Thu, 23 Jul 2026 17:22:44 +0200
Message-ID: <20260723152244.11252-4-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723152244.11252-1-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
 <20260723152244.11252-1-kristian@mide.dk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unexpected report IDs can repeat quickly when the controller
emits unknown packets.

Use dev_err_ratelimited() and include the first 16 bytes of the
raw packet to keep dmesg usable while preserving enough context
for debugging.

Return success after logging the unexpected report ID so the IRQ
handler does not emit a second unratelimited error for the same
condition.

Signed-off-by: Kristian Mide <kristian@mide.dk>
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index a184d024d..2f1741d77 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -238,8 +238,10 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		return ilitek_process_pen_report(ts, buf);
 
 	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
-		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
-		return -EINVAL;
+		dev_err_ratelimited(dev,
+				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=%*ph\n",
+				    buf[0], 16, buf);
+		return 0;
 	}
 
 	report_max_point = buf[REPORT_COUNT_ADDRESS];
-- 
2.54.0

