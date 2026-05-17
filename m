Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A626B973
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025950; cv=none; b=pntNqJN1FvKp5/wGMKr4gkgUCahDqMhLChKuNgFrZJ+yHHk4n4nYVJBMdT27PeIXQV3PcIMJCFNt/SwHGY3f8FTueBo6RclzgMfCO57fhjCWNOPeBEO7s7XjEPikGFJtSJHOvULJQoLzekQEX9jB7upwMQIRkIAyZkv1h5V2d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025950; c=relaxed/simple;
	bh=7RVrmuiuxF/rWreRjusc9N9OoV45FUmambe+/N5PACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNTs/bNZVC8IKlDXkGEdzLaPFQOY4asvRZUP1Id1Gg97TQqBcqW4Dl/xgDyLpBOatBZqyUjKQE04dyIeIaqE+MYtiT56f1nkCYE922B1RcTTkAkSjOqE2c/WlhCkItusfH8YBpF3+7pIvu1RvHRJdSLaKqre+1EkxxbYtSc04MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVxsAaNX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVxsAaNX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b9ea536877so6582895ad.1
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025946; x=1779630746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO75HleHGDZqT7J517EBpplpM7jMyRvzAuKel4/gPzs=;
        b=KVxsAaNXKVd8NIY5+lfvKHLi7uvQYiPmIE3KUaqiWZ21yIgRKIf7lAigo+j030sQDJ
         ufFWkoEYvHiCKan7aRCxV2xm66wrYvrdLtSAQQp8z9C1rjYg4PkTrr6S8/8gZt65/E4A
         56v0hZ143Qsh8gGbrXz0qHiB68MKbBVHKCuvtk/zO/VazOe5rRfG8hIyehvaE/0noFGB
         4w6Rz4HskipOY4q+N/VzKBJ0n31yIWQtS+hohmRCe0F182Vn+ey4AQfpYxeUnB5d9bww
         m49X1LHP0mprsPSLDRLmGwZyl4ReINQVVNRdEOkk5qndzzZ/q1WjchUTQxWQddG4Daoa
         Fu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025946; x=1779630746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QO75HleHGDZqT7J517EBpplpM7jMyRvzAuKel4/gPzs=;
        b=MC/9+G1n14UuTLl0FqHLE3rKVbMeC9ce4cxT+z3eSnsLChY4yyvd/M3IpntMFGNsg+
         allrxLHXZbg7HYO5Z70jEVeFMx0mdE3Iufj1ytxZX+KOeeblwfSrhELb3ozflsxop3xn
         UYo4UW2fjV0zBU9iyAaoglfi1pbIw+2XOL6sG6BNB4RG8vEQ2sFDQfITukhMuLnwXIE5
         EmedGibynC0sw1GCCn7jbS7/ahfJqPExqnHPnxCb7U78D6puUNwcG56EZUFQQ5fUydgI
         /wdJDI+RfJqdJ64oqHGpF62M86MgLL0bK6rLL0RZvOfgcUfVyi3NoM8a2xDareBXOGRa
         +YWg==
X-Gm-Message-State: AOJu0YzMgmRBNb9+skL48F1YrjVK8OISS9VKcQWURMyDwsuIgj7Nuf6h
	Y4wG9YxTXEe/6bkH4WBCkThoYWxvRuNvLM9dLRhJffh0ySNGHiqxLWZDPpfRKpRSzATFzw==
X-Gm-Gg: Acq92OF6diqiXZnL3znyXqMBH9Kr4KSjaYaWxeVyTaIf4hdpgRjXzXBr9OEikYSwCE8
	uTweBX5cY8RwtkIydYTlbRcch0s0ZtTZxmXSEDOM0lzovoET5ceD/h58PJD7ACaS8vbXX4ztXmw
	x1VttTIv1+5wK/WfPxuxv/ym6MEgOACeKwmmu4Z/2DgaTrwq6Gxj7n0D4N2LUMe8OlRFFnU3BMa
	+d5pyqbE3hqabQ7RwuXo8IPBYd0qi9UOI6aROk1JKNvebWncBIS73zqZ6plPi0cHvkCHwF4BJnf
	L/lu/vSuTT5dc5R9iNWSQLE2o7bz0eAj/fC+TrYFZd85eTPLZCyUNBoHhINXSzQ2A4ZDdww6HqB
	JlKCqaq2yzG8awqeLqisU5mjDDnIAqSQreIK2/WSMvOEFkIa4qQUvAMNaY9N9PzagXQhFzvelO6
	ldSX12JJ6L7EqN2K17wbPqX6g/NOLSgihajYh/nSZCBjaWWN2c
X-Received: by 2002:a17:903:1210:b0:2bd:c60d:2968 with SMTP id d9443c01a7336-2bdc60d2bdcmr28937195ad.12.1779025946291;
        Sun, 17 May 2026 06:52:26 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:26 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 4/4] HID: wacom: validate report length for 24HDT and 27QHDT handlers
Date: Sun, 17 May 2026 22:52:15 +0900
Message-ID: <20260517135215.2220117-5-jinmo44.yang@gmail.com>
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

wacom_24hdt_irq() accesses data[61] for WACOM_24HDT and data[63] for
WACOM_27QHDT in the raw HID report buffer without validating the buffer
length. This sub-function is called from wacom_wac_irq() which receives
the length parameter but does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add minimum length checks in wacom_wac_irq() before dispatching to
wacom_24hdt_irq() for both device types.

Fixes: b1e4279e4ef5 ("Input: wacom - add touch sensor support for Cintiq 24HD touch")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 269e8318f..2fd1c4e80 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3509,7 +3509,14 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case WACOM_24HDT:
+		if (len < 62)
+			return;
+		sync = wacom_24hdt_irq(wacom_wac);
+		break;
+
 	case WACOM_27QHDT:
+		if (len < 64)
+			return;
 		sync = wacom_24hdt_irq(wacom_wac);
 		break;
 
-- 
2.53.0

