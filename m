Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0F25B663
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025943; cv=none; b=JIY8OfTm6alH8Sm/CfF3l3NHz+JKlZJl6qhkDEKBGOCVP6QGB6KdoodjfTo/+KJAEroXPg8VkDfJSSVS0uAf+1/SwKDMmBnOYJG25f/mzf/s9EUE8i/9+vR2b92PpjvbAOSQiqIGvHGbBYwko8wutB3CQB8V29exBEbeRryM0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025943; c=relaxed/simple;
	bh=yvRThhtFRzgNLNcZCuDT8RcuBgO7/FLtuzpeOVLUW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDfnqv2ZlBi8TvaVp/7ixWd0mj4JsuFZQ0whn5zYsWv46x+cetrXmxzC0+b4KFpvXtZ3I8Dh5q1XDr9HN5BCNh6RfGxktx9S0zldmTAfDgEQcY8DWJ0Bh5+6Gs64xAZII9JfNpN/P3mlAQlGH+5aNnO8qa3CnHLBHWl/06T+U9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhiAP5RV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhiAP5RV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2baca4df358so6989615ad.2
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025941; x=1779630741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t7vRy14fAIhG2Wr4kGou1JDcvmH5z+z8GUCNDyefuA=;
        b=BhiAP5RVnssOdyMMW3sT74bM4e4o+oiqPzeOm6hNPJMKOjVaQ4Fxj3J4dbg0qZNr7Z
         XM3cr5Rd37AO7AB70CkJUXU9Qa0UP4aWPc5TOIla705YFg0e54dknqTAV/ojSz0hEWG+
         j69n7ezzw56OaZLwflSliHCsqaQUyijnNvdc6I2FHeursV2P6qCMYMjWUGpeUb8rQE10
         dBEd+NFPDd6Uxmho0c+hDCTkFXaDO+cYQYOi8lNLWKs7A/bJhbtW0pReIC0BUA7b4QFc
         dJgwFK7faDWBtejq2360C2PGL74DlEVyYHvbzo0aFBGRqA362KrMRBB/ozVT/PzZdZl3
         oaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025941; x=1779630741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t7vRy14fAIhG2Wr4kGou1JDcvmH5z+z8GUCNDyefuA=;
        b=BAkShcBK6XO6qrZq7dJkMmV1d1Ovu24QHFjXNQbpjDqu+bBBbIBK9WZeg1JKFcRPeS
         saH6RAmmMLXZiTyKDsjkq12yMjv8tStMI70FKTxbtzNsc9D8/Eih7YI/7tl8lGAGFPhE
         S3RPHFGbiwBDAARpbKDr4CWfxj99Wd1zPHAvwYN7plbYDwwvZm7lIG1eo+NM+jhrdzO1
         vsHwtetaB6atb91HByJLwpHUbOy9bL2RHabpev87sV201qRJeioKNlndg+NOdraWWHjY
         2DhNlaJ7DspCtNU6n+EzgwS9EuLLVf4Jq0rUlVm9k6cqwa47P+2BhmLzW861b0sES9jd
         CD1Q==
X-Gm-Message-State: AOJu0YxSl/vkDkivJ8yRFFYjSsnL6Ghe2ZPtvjDa09qSA2P4aZ+s3lKY
	pLYYhzMG1lUrQJrolrdEEYvTv7MpVYs7URwK3MGKLZOhLMvRaRjheNZLVdGRfkvY7r8G7Q==
X-Gm-Gg: Acq92OG1CPFnDI3BrK+bE5qbqPwqim9mPvJsbxWPTBMnXB9IE5Z1CApxzEhVk3EQdUk
	hZpIauYy3HnrVQ81UgYa07DNxC+mLY1DSRF7qtQGuOLtaRDcsFgx7I645xLiBzAKNhjPrZk2loX
	q5d+vO9LgYvNz/gfo7IjRcDSJTvDpkdYF7a+q3lw5FN8AVTkFObidoX3LVxmo9SCR8igESXvOWR
	BmJHzY9KMOzqj4XqvJCUcYcdzH6gqJRAIWNrBvHfhB5Utig/nlPspE2wmLHq/AhMElXlNXOLr35
	d8flUWntF5RYzTfeRc5SNnrhEK/gTmK6JXpIXdLqZnCY/+/aC1RUr2QHD3gSQBHwYNZQ15Mv8f2
	WXmmf+/vyK473PgFDLDayAp7z3Yr94m+Kz/2O9odxTNWReDVXBA6DUgv/wfxEJFzmhvAED4lpeB
	Fbp/CUBESKTjw/s3cv3AM5C5JI7tTVC59w5Q0y5R1fdMcUWTkL
X-Received: by 2002:a17:902:b60a:b0:2bc:b366:4731 with SMTP id d9443c01a7336-2bd7e9b8086mr84503465ad.31.1779025941162;
        Sun, 17 May 2026 06:52:21 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:20 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 1/4] HID: wacom: validate report length for PL and PTU handlers
Date: Sun, 17 May 2026 22:52:12 +0900
Message-ID: <20260517135215.2220117-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_pl_irq() and wacom_ptu_irq() access fixed offsets up to data[7]
in the raw HID report buffer without validating the buffer length.
These sub-functions are called from wacom_wac_irq() which receives the
length parameter but does not pass it to the handlers.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add minimum length checks in wacom_wac_irq() before dispatching to
wacom_pl_irq() and wacom_ptu_irq().

Fixes: 4104d13fe019 ("Input: move USB tablets under drivers/input/tablet")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..6d06842b6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3453,6 +3453,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case PL:
+		if (len < 8)
+			return;
 		sync = wacom_pl_irq(wacom_wac);
 		break;
 
@@ -3464,6 +3466,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case PTU:
+		if (len < 8)
+			return;
 		sync = wacom_ptu_irq(wacom_wac);
 		break;
 
-- 
2.53.0

