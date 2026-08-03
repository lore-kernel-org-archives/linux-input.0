Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD47435523
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784564; cv=none; b=GrvEI9UAiLrbYI1EQTW3olRQ3dxdkhJIagB627XCHte8m/zfEsPHN30oBVuLt0MrmZPOixXGs3rBfAdPXVezKY6EQPHzHtigCDXk6fz32eY1hSYaltEzjAehbO2krNpQMvH4YHE9Ba25Rs0boYsmHJ2u2rx4I//3S9muyokeXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784564; c=relaxed/simple;
	bh=7m2bmzqsMIVBLFuL/xrXIgkl9ruapdGRrZFiSZ6VQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiY9WYv68EBx8d38Ve/nV9ig8JiE4DhyQazk+KMGkEecHz1TP+Frv+hY0ltkh7fbTWhid1uOlWDzSky78VD6Yeg2mwZ9f4O4s/TNhow8AZ2T3hPkXJ6nMSigr6v/hS4dywWfhO+50jTkYUg5s4WTISv16IdecUTuRuvxpfWEa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0gy3bm3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0gy3bm3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5218927884fso32642891cf.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784560; x=1786389360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rjPj39P47xaMasHmkHYYs80LcqMLG66q4JfEodsvmM=;
        b=g0gy3bm3gMk2V7lodbrdRULtTf82+hvuMmG4QXjKTdHfKLsdlqv8VAHRmzCvWeocjY
         CvAmHyncSQ473tF4rv3dHN8RuBoJmUXQvNjqoxwstLMqn/iEPORAYxd9NG8Voa7daJg+
         mDZtV1vE/7LBS8dqOzrAuFzzSZDki7B8b6/OD11cJ/7iwAG2YUrakZBFedYNfiz4D2WA
         W4umC5NLPXwnl558UUU108njM+kfA5RPBYqJHcjgGGaM8fcKHPYfQ5aI4HCjHR+iWGTs
         xKSifQfAEWThnn8lHFi54uawmSZm7BJGXefg0W9SdbFHjipvp/dJE2oxUyEPsfIE0XSb
         wD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784560; x=1786389360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rjPj39P47xaMasHmkHYYs80LcqMLG66q4JfEodsvmM=;
        b=EmNh46O0nwIhSBz6bq2bVXfC/6ZpfGNCVnV3zRnsrl8q0rY/gkV0BdbCW6alD44OnT
         QIAyHjJfX9nL9TB+YKvZGX4t6ovmTFxooyYiqjVQKnGNfiW7t9/Z3C/PX2qyuMW3FYii
         JDfR8G4HQTtVfTXlaplNWVTTO3xidmcQxV2BGYuAWdWIPE+vS1RU9049zt41qoApFPfR
         zojlMniGJJIV6ptyCpsVv2Csl5LVQCF3tngmIJUF3iaxcekciJyh1w3ZJzzfxUi4PDAu
         7Hnyju4G/pqX8Zbb1k19R3nzkzk4Q6vLp2dLXfPptoadlPstrtjIon7l7qJRshAvOckE
         gqtA==
X-Gm-Message-State: AOJu0YynYSLQgP5hfM5ck1a7o+qFmjbHDMFJAmwXPy+WDQUynqH45qPZ
	g4XWroF83zPz6OvAYVlMtKrL5J941+nLdIcN/iIw7EICpOBH8Fr0f8qHcXyjAQ==
X-Gm-Gg: AR+sD11AcTO1SDOHjqnMGLtNXhWxpE6FOu4WJ8Z5MTTBrO6JCMHAQxIb7XFBw6CWXAr
	CLn4jwDkbTxB5WE6ovQKQK/w+JbYHVUWkEsAZpizmaeL7GZj4L758lAPXZbj31qDv7aquKgql0l
	UrNYbgJqb7zK8KxFY0pQehIQe9Ic798fPbpIUPdKsL6zzYvLgTFC4ddEz6WA3Zzo564yrYuRu2l
	vXfuqrctNtt0wFXv3ozUjfDSMcKr6iRW5co7erJeYamUIOWVFdUdNXrkCbRVLmOKin4Zd6KZBKf
	QZRKTHB6SBkj99H2+UOvZ6Y0W2ICVT00M/5j/wT7PCZzdm+yubLuZSrHPFWD+AGf3LZFbwSSO/Y
	61HG92w0BLcXF0D077PwPjTH+dJOdPyACrdpFLs8J3quvp9vIcxpXFtv6OrhtpbWPUfAsUgrUts
	CYGh3IFkC1WGHWr1iJcjAH+smHF5LiGnXWOL4qHavkwCwrUcLtjSfp4rQdfQJ6DyJY7VO+ASE3S
	Y2qO9jCjLcM/Hyix4bkOtIYpybUAQ==
X-Received: by 2002:ac8:574a:0:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52b5666d563mr221782141cf.3.1785784560318;
        Mon, 03 Aug 2026 12:16:00 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:15:59 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 5/8] HID: steelseries: Correct Arctis 9 battery calibration range
Date: Mon,  3 Aug 2026 15:15:50 -0400
Message-ID: <20260803191553.66368-6-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map the Arctis 9 raw battery value over 0x64 (empty) to 0x9a (full)
instead of 0x68 to 0x9d. These values match the HeadsetControl project
[1] and fit the calibration points from an independent reverse
engineering of the battery tray (about 25% at raw 112, 50% at raw 125)
[2].

I do not have this headset. The values come from those references and
were not measured directly.

[1] https://github.com/Sapd/HeadsetControl/blob/master/lib/devices/steelseries_arctis_9.hpp
[2] https://magnier.io/reverse-engineering-arctis-9-battery-tray/

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 7b8f5f2623b0..b54f20f081a2 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -141,7 +141,7 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	if (data[0] == 0xaa && data[1] == 0x01) {
 		sd->headset_connected = true;
 		sd->battery_charging = (data[4] == 0x01);
-		sd->battery_capacity = steelseries_map_capacity(data[3], 0x68, 0x9d);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9a);
 	} else {
 		/* Device off: 0x55 (no status) or 0x03 (stale status). */
 		sd->headset_connected = false;
-- 
2.55.0

