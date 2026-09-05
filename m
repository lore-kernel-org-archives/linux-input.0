Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1C4A0155
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612282; cv=none; b=tv9z3DBstBIn5eo2x43daUxsekyUHRWaGvR9hvm0iEa/W7RTNVyAJL3ktXAUjoZRyihyK9l3h80Hv/rdYnUBQwmJzGkrWMGqTJx9jffhFEOLOrAMhNPunTiIUCr4iDm+yHuJFzGQjyMxoeWXyei07zzZAlWgaf+SClvbhbBBTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612282; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fExON892vxJ5loJyXYp8HFI5g5htpjjJ5KCbPrY2JpDWQCJoAQLWoHbJXC1ncxJik3ID7GXLl4olmKNRtsHajl2BTwVMLInW4UXmR1/pVgBMUu9V0PBOpGipr6dvP21yMJtrbXngMLzs8MjWdYCesBPGhgk+VdZ4FrUjPdJzs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzBSFuhs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzBSFuhs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so16487685ad.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612280; x=1789217080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=jzBSFuhsbkrPCo505JQz3G+xdlugkLc+IBPvSy0XsIfFSJd/c8mRnEylKYpvF/ZV+K
         iQUQvk2s2tPlR5qay3SW81SyUF3LUWrPBD3BL+8kQzuMGyi+PCzUPb2ziwy44odAhWxJ
         KTAOHC2ufuge6vYiRCOS/R/oyBcXjCrVSqvelyemGLd9ZIkupmKYvwNzB5GYnZNZPujQ
         Hjn7VrXRaVdL0DKmXwRFpiet0mtZDoEHvKcaCOFkF1M4dpc5T65ijaEJtaFuAXazWNgX
         EnDpoQPToYSNlZENI5dBX7MQGfVkGX5FExIrLz0LfI9EpCnPlAHcMuO4m31CgfjJ6jSx
         hELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612280; x=1789217080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=qTynliWdYak+dmRJ4MyOd5qfrIsDd1T6UnliU5WIoGfZKHaGJA5w/xx/3GLOUp4HGX
         RaLwkyae9mGQjPoT0cXGKvK+HTYg5yjOCiYc1qjbShJl4raeD/e3ds6pGKTP1bLG8LT1
         vovOq73QoJZyusapNtRtmX2wJVICBs2Ja6Gx/DceV4zfLGCR0uSlN+IkwyG+8OggLv//
         UFaKXrXqcdlm7vziQ9KncmV/+RAnaG2a2csOdZHGkbAsEmw6pAdPBLl51piFvXOk+k1c
         XZOu25wZjY3ezfWuuF4jwvirsXBQnaZBsWuaHCXugMMnHIZUiMYL25ssDqhfxn/jeZI5
         xlWA==
X-Forwarded-Encrypted: i=1; AKwUvBxv3iDemL+LcNVj+a4bWD8//8wJ+5C7fT80gcx2GWO69V2V7l1O9tI18cQZ6JplSaiw8lhvAPlsFRo/Bw==@vger.kernel.org
X-Gm-Message-State: AFuF++lKg8pAxognzcZ4+YmoGz37+fqQpBFPvEmJGoyypvEB+z353Hb7
	YZ5C04ZBKEU8Ip7B99NfTTY9a4YwW8OgMK8B6tkMUQ/Fc2gnVGoZxA6K
X-Gm-Gg: AYBFou0bqxj5p9cQI63B938XtpsSbVlirAEEYMoXfjgMrbSZBJWdOJKUtOd+fQog8r7
	B37mLBeIRIzQtmhTWHDjZ76mE5KOfC8eDmjXkDlO8qD9MIa9Aix6plrPsfxpChXzZjU1ZxMOb3N
	iIPiE/Ci6bJP1G5UlHPWhn+jvru1fxs1yzUAQJi493g+/800mzNvk8M/0r4nLN+h1igh8KMarlz
	pWzNZwrht83G+liRUMz5h1ERrw5d95Lbc4elFqsG2I2YsIeKh02aLCKqr1Xt2SSjoP7u/GO2h3k
	bkWYyMkah2ROLG0hei3e6SBQtIzw2veazSpSxAL9BNQebmGONl7EXWzwHFV6IVaRqKH9Pv72YGe
	QGZn0lDCCwY9AqH6kAjkqVRbDuIYHSWfvQlY+rkZuJfJ8y6AW+Bzu4zdsiI9bmMO6svAmE+smQ/
	9qqxWdMo5O13IE8sbwcfagA+JkCOwMfIcX/54wyl2rq2839b7YD4RqXL53au3zdaURrHuB1F8Yh
	PxD5EyLHVm+pRpA9pWE8o00sx38zEbp
X-Received: by 2002:a17:902:e805:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2db3b351c2emr5928535ad.5.1788612279984;
        Sat, 05 Sep 2026 05:44:39 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm11740417eec.3.2026.09.05.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:44:39 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v7 1/3] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:44:32 -0300
Message-ID: <20260905124434.6163-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

