Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682754A0157
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612286; cv=none; b=ZZZ76F8B1RvhxZNhdNoS8Ena5gCFZabHyLzjMtylNDLhJ347QMKQLyYRwm/SQpCIVD9w2MqS2Qf1UUFiyzNaEWxgBj65d2YRNIBhv/hxcsIZY1HTysCXqMU+hJqrwMJox04Qr7e2ipdMR0LfqkHIh5v82wSunWDU9GQQnoLwvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612286; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYzSmqw7H6ClE/ejV0jCFs6gLUMRUNaMCQm7NfUkeIfN53gexoDtwKKtSgjgbW7u8y1HmmGszMQZWiH4oDv2hzC+uiLX/kRjAr3wmD0l1u6bAosmFcthDu9hD9tjEdAYJnNNuree3MHgeU7CgseH4QIYvyPSSBClDrd52QKQ5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxA+t2+o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxA+t2+o"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86309e1a213so115811b3a.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612284; x=1789217084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=kxA+t2+oXL2x7EMXQO7yKd8Q2TsrzpN5J8KcJOxJtzo8UCq3Pq/eQ6OvRiTbgGBKxU
         FG+jB4lrUw+ogJbMGc97bJp0QdX+qQ3BK2GPWguDm7swABoeHQMsqmGcQmA97C9Fwg87
         4yx1Ama1LFuuEwDwqpCNuCA44gll0EabgP7oCJwFKGpQ5NOlDYja3XbJ0+PkaGDAt5RZ
         +xf/jqCwbhA94ngMM55TRADZAAVSgHx55/KmIatYzZFnJbkstYvE7oH1T76VfioL9+T8
         Fv2sShwtLS4PLZy6xiVs5TQmfgI+fDgrCi1pWTrl0JpdRy1g+SFUxkjJy4RjNKv418nJ
         7V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612284; x=1789217084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=gDtmzshNR3HTUz9DdPjBNOBz15Pbdnhm5qWH2CfwBwi+4ewpRV37kCMpzCEssevZyC
         F4NMhA9zrZOf0EQVG5w9W+/Avmrk+OcxCninWwhMxX+9R8Y3JcQL6nCfSHF4+W111Mtt
         C+U9BWUKlTePoSLYvy/gjIqflH75oCGhlY4Ax/5x+SwIRLMztFnIfIU2yaG82WZKqXE9
         p3Wfi+OKXhmrefMOJYPp+luSm2RrfkY7x3I6vEZAu0k+NKsBDeWAjMJkVGjN/YBIY4FW
         5LGM2zNTyP3lPE3gC3SoPWW5ZF4z+kqxZ37BTRv4MrHQRzrTtZUlknE3Kmp+vrFJ+MeZ
         nxqw==
X-Forwarded-Encrypted: i=1; AKwUvBzAXesA7XhOCYy6ptagQOZSxPdYcitsZCUfrnT7YiyReH1KNvXonf83m5GpmoiT4+BWr+ICXUDncpXZhg==@vger.kernel.org
X-Gm-Message-State: AFuF++mmMq/BVKoK+2orZJAub8C5dHYRFryaFR0fN6eOy4SPiL6UR9or
	K36+mJORHKD8dYKBDgHSJj27JVAoB9dF1zfv1AYR0nZZI3luqGzAmQMK
X-Gm-Gg: AYBFou1MbiKQTlvyWPQ7AIiHnXfaGxCRaoi/KFjA7HZY9+JUUDQP7hHcXiaxM129kZh
	0OvCqIXAjdhbkFq3J+FDNuZFI1qSG/yDnJk1NkFP1wOyF+rTIxiz8l8n+iVCA6N12n8tRRmWZ+0
	0zbEOYHbYCCd46ytY2QwhjXuT6UGW/aXGPj/buWcohKywm8MU6HwtithtBjm2J+oMu5ZjXl7I86
	0XcAFIMI2CYOmASEBgbWnktv2/bUdy7urpCcduvovsXr4VX/5t1uKacY6oM8E/9XU0HlXH7nMlB
	5/TGJFDIPCeLpyOOLGDQcCMAm41eMQN94iGEY9tkjsceKcvK+VJQx1ckfX7GL8Dm5/SN7XlStsh
	+ZPD+nDQ+9ZoMa8ZqPTo8GWvUBan3kuKn1uBRtmKTuw9NauKAdZlEPLaKgrEraPZ24RXoyjXET4
	6BRi2nraft2Ms/deqNckXxajrCdJGp1CQ+hohpoUShpgvjsVj9vUhfFYPDPWXWgAvJlD1//B4n4
	MCbDz2kKAqCTSOO+FML1w9s7TXCWg4x+IsiXSkQlGAE
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3da3a0cc429mr18182599637.23.1788612283674;
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm11740417eec.3.2026.09.05.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
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
Subject: [PATCH v7 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:44:33 -0300
Message-ID: <20260905124434.6163-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905124434.6163-1-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

