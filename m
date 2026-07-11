Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA13403EE
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783752886; cv=none; b=BAe9m+WB/dP7CEOlYi3lo90/5gMU8f945KIOWhjuczwMODTNn0UeTVJ4J6wL1tVc/nLXlGEa35uR4n6NKmhQ8GBwoYynruYeEzTveFSMK4vNMnRQE1kvbgZ41mBJ8QvCXOtRAa+bS2s9VtpKO46TqXYWuVOt26vOgqPM8uX/Bl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783752886; c=relaxed/simple;
	bh=hGG1QqmsXO8DZa/raxRUemdtxRcLvOuVWVFaisUeLkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/Rz4MYYxPjqdlzAJA6HIp4LKbq6lDFAw7N9FTtCuGW1gcYuTFqwy7AAtCBDivFIQ8dRx7Sk3o/bTkuyB95biQLCMddJEa/MiqDyey9MrQ5n6RHBO/zivtztY0du3yojaP1Z2bK8J2IeFmUlaF2CafqLtL7T0AiEVuVJr4SZDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so13865125ad.3
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 23:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783752884; x=1784357684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elcaEIBrAdy5k816lVEGPLULCsTSJKI/r6Pi3p4N1Is=;
        b=B6m7quHkn4GABwpkFTueu2xziG3VJKzcwJnyCOIsUYgnowwkrIfrKo65kfawdSgFJJ
         xBHlhX5mU3OYKWyN1D6X32uuS9DIXBz/V1yfzx7Ww0dQPj8tZ0eFG1XYMX6fV54980ih
         8mPVLlJOUyk6xwvu7fWJxBtUnib/L7MBxCqZ/ox3eDXGFgMWdEPe9xJebCCnoKwt9Fhx
         1R+v4WpdX+Dy6RvvMSR7qfhd6dSFLsiRQVPkIe3WjyuZ0I9a59+Fx+Ydee8mToe6ptMH
         GWrt9cJxiGXbZQ3jdErU2WsfOZ0AccHfWGFYGAbcSP1j6ebddeh6jdqos0bWPPO94BYb
         29RQ==
X-Gm-Message-State: AOJu0Yzq93AGYPHgN+UhFChtmVFeIjWSPUi8i1cvq1P64LjhGwJ6MQA4
	Nzhb5bHAYy/nBbj7u3aYIcisnvftvI0D848sgRh36AImY0py2OVaJtg=
X-Gm-Gg: AfdE7clrrLEwJ6BpvFM9BCvrJCjS5djNbAwuqRnJhePc3lj0OB7Dl1KjIpjaweo/gKO
	RLg4GIRD0w/wJZYBoQKogY0jBU/2oFYX2COQsHkqbDOEX+szxSRQYWk+oF65HHuyTGc/y9sd1Kl
	+Smc0axjIrOvO1nXidbRBMmXqZNcIMJFcyHJZZHSLyNS//QVf4Kl7AXPHBQkm8rCg+9kZE0fttS
	p+WjLLKoC4J5VlpCJa4Lc/3sTIRc+Yfwff8rKVarDprFLV9sofhazzfNHOE3a1Kg9UHLnRVqcPO
	0IqV6yfm0BXV82xO5bTVsqnWMnRHpPAiN8KfaltI2fqysF0hgN0q/SpsyhO/thIfk/V+di/qnUw
	fsy78q8fYDl8yuXtkzOaCmkpfFF0yyoeM6IgTCMtqy/+iCmRi7DacMOEMen51i4WfeNcv8IiPQn
	7NdhuOrdrsC29K3IQ9W/wY+a3lGBZY+r9wih8bNNm4VVIidSSMiF6n3vjymHzX39MHUMB7u57RQ
	2BT7fnx5yUIqfltIAVlne6U0JBMGI97WIDN
X-Received: by 2002:a17:902:ffcf:b0:2ca:d873:3b34 with SMTP id d9443c01a7336-2ce9f3b3933mr22477795ad.36.1783752884190;
        Fri, 10 Jul 2026 23:54:44 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce8f5183b9sm18272535ad.5.2026.07.10.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:54:43 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 2/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 14:54:14 +0800
Message-Id: <20260711065415.7396-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711065415.7396-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

This creates a use-after-free (UAF) vulnerability if a pending or
running worker thread attempts to access the private data after the
remove function returns.

Fix this by explicitly calling cancel_work_sync(&applespi->work) in
applespi_remove() before cleanups.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 07a910cb8459..b6b4d258d0dd 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1847,6 +1847,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	if (applespi->original_can_dma)
 		spi->controller->can_dma = applespi->original_can_dma;
 
-- 
2.39.5

