Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C16364049
	for <linux-input@vger.kernel.org>; Fri, 27 Mar 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598042; cv=none; b=sk8/MCHE/8naGJfR0mFDbYMAtubc3fIdAKPEW70O/YOEDoKx11sgnAcdaKcEuCFn19ULDXruPbmf1qmvM2b0LJMPi5GITP92HCfBTlqEvDDlfCGLu9BaomVk1R26c/pFA8OQXh1v/lMAw7goqO5c/cKJfUEVodwRc17FiKQQncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598042; c=relaxed/simple;
	bh=yjlCY+TbbLFH769ylJi7fyTm/lP+2BWIBHinDDTU/6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/hQlA9KCxCJQPMWZLh6PFSCl+k9gdg/TRyuItItOgbdb3m7bRkeX7bAhU7jLpiyYRWBA0TzE+whMLylwd7I8OD3kVhc/bZgW8rJdx3EJQbhUwEFs4fdks2Nrfb44s/XGb+jki4QD53aepliaKkTzuBbxC4PM2vrbfqiW5Osvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg3uz9gu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg3uz9gu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b042533de1so10261215ad.0
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2026 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774598038; x=1775202838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCPnt3L5QA0Z6ghHOh/zUYqmlVGm7wGAqLeLSwOU5Js=;
        b=jg3uz9guZ5ixU+WfSy+PyXh2VX0d6s+0rpySnZvu7QBoEjgtoKWW5Q7MpKoVLcxCd6
         Cd613jJOjRL+2bxmEfUpvuj5DXy0tegXj+dCtWVHCL1l3H+SGFvhruWA33gTV1JfEhs5
         H6toLuMTogj46ow72GH6WyF8dyQztWJVGnX0rUo664CY6LQf7wJbZ7Ho6u8CoBABWyqs
         FgunL2azl3xZtmtX/Jw7mA/di3oNbmRSRPz6wE/pF2jYV2VI9Lruz61YXAy+OS/JPdXh
         UUf6Y2/Z2b68noVu8Rljk6HEKxVjpHKZEiVPRT95X23pTiW3cy2t5iuyBpI5e5Kk4E++
         E7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598038; x=1775202838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCPnt3L5QA0Z6ghHOh/zUYqmlVGm7wGAqLeLSwOU5Js=;
        b=IZoFpEfNRPIy1AnUyej+ZWCIpgCc4IM27h+7+KsjA376egN6d5xA6thg3kn3JnH5QB
         fJevQNCRcr36Lronq3S0MdcaxUvCohGDP65ec2frLztOraa3rBXb4o2rwdLalq1aB2+s
         cI4qLI3w/ZbQ/v/DRXZhqYJxRH1YfdJ1YDByQqGzNd3KtYtm/5jSszeWxbku2ik6l4X7
         umoCCLDL/bM3iSxMMX/94CElKS9l3XaZHquZGxJCo4OrU4jiI57sXZqpGmphfrpOF3HF
         TWgYS+fYP4hMFTu0UemYzzrA55gg2MV/uxo3zggts2xVJwCloLluPFavXGb1VX8xL13n
         CZog==
X-Gm-Message-State: AOJu0YycKN/0BR3MxUArgvFY+71Si592R8FHfk2iZj7r2xZNNaT9PPTV
	ZKNoF8wLPwOyOH+BNN+zbAjeyRLxFVU7O6vUfV2j7s7o19NPjAmqygbh
X-Gm-Gg: ATEYQzzmL8eVd+uzAC1UBSkwi+KArYFQkcAUpTJDix/syUk9KhR0D18QIDJAKc5gDbH
	OOkWQRUg3u/YH58w/4Reky0Ps7iNIXRVJ25tydf7YNuNCTsrA2Sic80jkn9etCMQMgOQK66rpAu
	QMpVXFQCisQaLps5KZT3mGSxnK4UjyxrnS7VqECD7MjGGqWPD0F1WvdEUZVzR+rpaEmRQ4vJ2VW
	rVN9te1JZJ9F142esz/9wUUmAV4ZpU0s8s19ia7xeqSzZBZPH3n+kPqUkyQlzgZ1XmBQuHrte8u
	4l9yhVyCKfc0dziOzIUaVYb7RsoId//kZAR8QMxoqtM9QS1FfufNDE5x9ELtjqqzhg0Lv65q/pj
	OUO+MStyO4j8LvBB/DFlkRCTFiYw29hHbxtEh0Ulxk7TwzOKuuY5HlXdQ4+jvTf3Us2dmzW6c/J
	7xkIsX04rh7gvh6NV2dP7f5u79nW2UuO9CNH2lUPFIEH0xJk8aejwnMg==
X-Received: by 2002:a17:902:d487:b0:2ae:6579:4795 with SMTP id d9443c01a7336-2b0cdc5f3ddmr17322505ad.21.1774598037664;
        Fri, 27 Mar 2026 00:53:57 -0700 (PDT)
Received: from ZC-202510311500 ([123.139.39.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc68914bsm55123345ad.0.2026.03.27.00.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 00:53:56 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"haoyu.lu" <hechushiguitu666@gmail.com>
Subject: [PATCH] input: fix missing newline in pr_err message
Date: Fri, 27 Mar 2026 15:53:14 +0800
Message-ID: <20260327075322.2391-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "haoyu.lu" <hechushiguitu666@gmail.com>

---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 7b7490a1fbc6..092c92380911 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2730,7 +2730,7 @@ static int __init input_init(void)
 	err = register_chrdev_region(MKDEV(INPUT_MAJOR, 0),
 				     INPUT_MAX_CHAR_DEVICES, "input");
 	if (err) {
-		pr_err("unable to register char major %d", INPUT_MAJOR);
+		pr_err("unable to register char major %d\n", INPUT_MAJOR);
 		goto fail2;
 	}
 
-- 
2.53.0.windows.1

