Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A04A2A49
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613048; cv=none; b=gTFU5VWedF99mBCH44SZDGZQXV6NtyfvVQtXcJaz7QL0T9BM2H+iPZrBpd1VDyNEuD9IYS7U7ISt8tdYlEWSrkuEmjTJHv1bV1eEb+gtAsZqj4euY7+Ph+igmGK7Dki4uPuy4or+eKTStti33IbHFbIiCOThf7nFJhHQxz2p3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613048; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jva2VwxtFTSxLJ/Hp5FnkJYbB+7cjhR2Kimo07qTypFJyJOzI+DpI7rLZXeeziApMKnCJ+9Kxb4R1M/VBGggNv60i6/hZ6MxEmcvuDIg255PZ/g4yIrW+gtlnAhdFZ2DgsWxbKun+TrqbqsmsX8T53BAVvF+7Xxb8zHLUC3me8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcZp2cWY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcZp2cWY"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso837214e0c.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613046; x=1789217846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=XcZp2cWY3IDTrWI6WiVnwaiVpJm/PcDwBmbcQMy03q2c6DM7uGqjl7YaVN6I3uS15W
         4H4x8seRnMrM6or3dMcNtKMsFhIIdawxQOl4BOJ7eMJWlZo+JvRyvb/NJT7e3gU+FiwQ
         /WEuDwPZJEwD18Ff4nUPJw6igC/XNIBImeN/PtS6+X9MR4kIzE313EjO2Zh41yyXmHpE
         d9WPa3XogeuNCaM+A+EG52/FISl9av4bCYI6zhz5XBhFPUR7oXF2YbGv0hmDfUmgtnpp
         mx+lUo7N4POwlPLrKQGIE0LvT0ZmTiCpgkPDfVJMDpSIBPgOK8xFjuECMn/UmTQZt+L1
         L4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613046; x=1789217846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=Cwt2NbHsmN3zyBImaFu7XUWMBdzDUPFau/+z6ShOyILlZjOjVbSinvDgX90FDcjV1S
         Sr9i3fwRAg0D/yhoXp/cTdRmQPwHgGLxhei7p2jVYAZk64FqdH0JLXW8V6h38QRXvfZN
         ptaJxudU2hbxLZ3sgy2SXov3FtdTc1fWhal+ydWO/f+x6ppuPJVizKN9YyUC4slile3Q
         MutOPa1Kksrrw3ka60CGEezcsleSP+VXxIvv+w0xF20/CIq6JP4SxUfInSyWbdthWb08
         EZ5dPvT5lVuDLSr4aUv5QpHkTJOJxitmEobHPkFNyODBeWIX7kFwDl1jLWs4fHyqXhvx
         rrgg==
X-Forwarded-Encrypted: i=1; AKwUvBz46drB1bmeG2vqFMhVX5XerQSlqugF4fpI7CF2DgKRZpeuYxYepjc/+/jwIThNIPGeJacvDRa3XoqzHQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lBhqXUDkD8GsSsOiv1sVjRSxIG/0r55SYKaoqNcGSD9qTn2wTv
	BgLTRPfD79dVAQg7h4GavRVZxCh5Iq4/HAZ6dhmkO9BqwRxsu74+wCGV
X-Gm-Gg: AYBFou0HBvZ9t2sCRb4GjKwYVPY93n+MeNkqNjJSplOEu1HO178yIlauSPLsfspFeX7
	iMs5oMNRSsHLGMqOBhpE6AhiNZyid1nxolGFFNo6FV/XgbSzq4RrvlnqWHAR62kKoUi3OvvrPZR
	E2mXD/tnHaz4cF0dMDFjqLPiIjuu+gy0iRtBeYnBreOkukiMmx99lLBkf0ONczAxvaKHd7U116e
	IjF78h1Pfu8n8KPy+nDbBKGj2jkPY6c6t1W22V3QC36ZnoGDYtDQre8a6xQZhQz3alrLi9jYI+k
	VJoGMAhWMnD5vMlzTPBDLeOsUbpGwRQ7t5VksuvL6PZUGPwe8HWDdoRACny4x7G7OKYdMEJD2bo
	y1EyAyAwvrIOROg7NyqreA9uVNMX1pIoO+qY6HwqbHn+cVl38J7Zl0DOYHiMa56otlNDpsW1EIK
	4k07UOv5ODE99UzzxV11eADCbPxFWpt97Rzj9vbZytSIGVJBKWykkh9Uqduv6MMXhl0zYr1J5fN
	3MBDRw2GFnWkgoX5WR9hbrCaMEa4QzvxNxmqt4l0Js=
X-Received: by 2002:a05:6122:4fa2:b0:5c7:c666:ec22 with SMTP id 71dfb90a1353d-5c7ed407509mr5471080e0c.6.1788613041673;
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1ef7a5sm4349416e0c.5.2026.09.05.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:57:21 -0700 (PDT)
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
Subject: [PATCH v8 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:57:05 -0300
Message-ID: <20260905125706.6550-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905125706.6550-1-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
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

