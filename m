Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B83C10B8
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510204; cv=none; b=po5+oOfjzNNzVErHImU4MBOEwj0Xqn2B+T3ag9Sg7KFlV9jmZVIooM82qJ2be5+IS5qadhkLBqP1STV1q9YtpCBXU5IU9vsHILjXdp9sNXPgaicJYITCsJc+AtLmOHuDUZANVxjCZqpx2Vj7cKF1JiHhhzWKa9IrHwhcgBKDfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510204; c=relaxed/simple;
	bh=zWOQhEgXDSMZuNPR2XXmDUrg9p8HWA1NCXemKbEVnVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEUO/GCSe+PPA8QAQBdSSB2VFhPscTiaDbZQBGoY94nAUlR2hQbwTyGdH/kq0NO6iKGpkbAFCs+TrzG3fgQ92BPrETQWd0XvT4VGpyHNF3Ary6fSuKMfDFlrYOXb/z0mPGp3K6Is+0ZxTbFPBh1miMdyTQkxBX1XUhYrS9i5zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=AbaZG8HK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="AbaZG8HK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69532288224so3138218a12.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 14:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1782510202; x=1783115002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29CA9KnnHGCF5MZPePPPS8XZ1hqLV3Zp31LUg8QVI98=;
        b=AbaZG8HKcce/rrOHrBkGLWRrhTZiVMsgKOPXg5yBQGCdCtrWcJH2AaDGXd5FMtUSyU
         70oesF0at1pKsDabTSeGOr8aHuoIfXxWlsMHQGD1Hyrn8cBq6SOnsWMy0J7IvzENbSsF
         /7cDcwmI9YhS2TSra2CGLzQnXwpvp8ywdZ40cCnyyCuNYGwZaZ2Zbq1rE4QLFrB/p4Jq
         5+utucUT53Q5VwUCqwMUcZ+G6v2a8TYaXaAoxyAAb6oaAQhGk7A3cQvcGaei7FUG5iyi
         /loYU+6ozBrfthtG4+IlFo1V0wQJycUNbc4kS+LIdd7pVu+As3dILxFIOaF2XKAjTsS0
         0D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510202; x=1783115002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29CA9KnnHGCF5MZPePPPS8XZ1hqLV3Zp31LUg8QVI98=;
        b=YAtG93oqyku/oiXeX63s05zvB+tiL8XdYJxm6cvGeH1uCS/ySQ6VLAf6ibNBtw9uvv
         o/e/gD6BbF4GAhqpVMe7r6vQw2tXAs1PPvwIbDgEzlSYLXE3qHFBAHOtyn39LroFOQub
         N6IFF9Fkt3PdEiPSYCJdMIRDIr25+bZbLm8GPCS7ZxWYy7sEVEHVXqsh/1XbVeG0r9Qx
         coypTaPia28qhgQ6BQFi+Y2CI09YQWR0+BKKAlaS9LjCoz+Jm9QATqmL5DQ+ALuuoo+/
         sipcQY5kvMksrG/QAnBDFv5e5pno1lXhe5wlg39mxhpq8RSVXojqK/ZoN9cDusizFRt3
         SjgQ==
X-Gm-Message-State: AOJu0YyLjv465lQ2moh6XrISr1qAiSiPUAwp0KNifZ7wn16IA9Zgxspz
	leTJ6qlEPPZlO768TpPHeALbcSci3vaErlOIEzkbTqDpDXt1S2s0sbiBw7P4rTj3RQ==
X-Gm-Gg: AfdE7clgV3PxYR/HcSTVZ1CXOY8k4kfdnnaSu9uTcSXBMe6Ila5kjRBjkQUbOF0S3Xn
	2X37rFapItvLtBJLe7fRMogaD+AznfljtOZLd+T1SEXJwQBibFiQI3gDNOfTUZPMPxscrHR+hbO
	YrvRmjwa4xovv69kiqjgxyMKsNjv8k8pUu1gJFqw1Asih8NMhHYuccs7ROIjvNp5BBNZn1jXLBx
	rZl+CSLtoo/tFZQEFo75nhfXlIv2NL57ZeE1xZ7VdqIVPZBp0SZ+q2EmzOPBjChNGoCVect8mxW
	T1jP1KKgbKqkziWFL3Fts01Ub20M6U4tab4goZPZdBCdtYgLJq1vKGVBA+EaWpV9pR9mcww8eJA
	f5CxrNQFZXB4wlXjbtPI6X8uaCAEqsj4wqCX5L715p+YDr1lfgYSshFeKlXFNkLObeOqz9ggv7o
	019vqlvORT/lupf22kXM+1trFlbDLCivSbmP32UVKaLujAStb2dFfUnI9mbyWDqVLUwLtBpZEB/
	6rmshg+ZycE7mASTZlz9Xpf1w==
X-Received: by 2002:a05:6402:50cf:b0:697:ce9a:640e with SMTP id 4fb4d7f45d1cf-69810ae0428mr2780900a12.24.1782510201878;
        Fri, 26 Jun 2026 14:43:21 -0700 (PDT)
Received: from localhost.localdomain (78-31-252-186.static.kviknet.net. [78.31.252.186])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aece6dsm3385821a12.12.2026.06.26.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:43:19 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH 2/2] Input: ilitek_ts: ratelimit unexpected report logging
Date: Fri, 26 Jun 2026 23:42:48 +0200
Message-ID: <20260626214248.5563-3-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626214248.5563-1-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
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
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index f0721af02..8886bd39b 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -241,7 +241,9 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		return ilitek_process_pen_report(ts, buf);
 
 	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
-		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
+		dev_err_ratelimited(dev,
+				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=%*ph\n",
+				    buf[0], 16, buf);
 		return -EINVAL;
 	}
 
-- 
2.54.0

