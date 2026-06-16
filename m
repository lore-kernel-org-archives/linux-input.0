Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73B3624B3
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607711; cv=none; b=L6oSTwI3utQHWpDgG82LwNWnLK/7465UlbEkEqo21Zs1WWXL7UNxUGVACNOmVvDDVoUMMxIBwwb4MWKFFX2mJPP8bVACJzvNIPJraoSJdl/33rvdmC5uq47p/H9VmcKeLJ5nt7+YkANdB1PmJZ9IzI20bndHcF1bSWRocfQ0bvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607711; c=relaxed/simple;
	bh=WGX0XQW1Y1v+z1IdcNozewhJkNcGnleipMvP0AiYsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNBWv4wZQoHVXTmO/0i7uVjhOdETAByP/EHpbNfKRCis18TrMJdLA519kE1t1ctr7SckzY6AEaglPrEUJURhaK9cWeJpIj7fIWsUA/Zg3u188ibC/OodhwfYbIkQpI5iG103wionKvqMzqRyxHl0AzQaY7sv98cKt6XlmIuen0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOsJxB/I; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOsJxB/I"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so1486207a12.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607710; x=1782212510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=WOsJxB/IjN1PhGnvqLkxXFqOSFfPRG0c4NvYpUQv5gkpkdmYklQ8dYmtw4ZSHgzK/6
         G78C9NhTzadikgymUbcYEKjNxFJQwXQ1hHTGHqC0gv0AFoe7Tt+daRs2Zjmbep4Tt1ei
         tM4AhhYVwUATe/rmCBNUuAQDiF2iJJ8eUp7qRI/meFBWaK7SXtYEgsbZGkqR6i2aRxmH
         6ks+pwfy+3Z7z7dH14BlhQ8SP+W37I++KEe1PtpDdrMNuOad49PbDmMJYHbwOVE1NPP4
         PtN1LlY7esgzl71djvr3vygLUdfuyts3NCwXbTA4OwPOebbvahiZMTs0KE200z2ZQQbL
         Nm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607710; x=1782212510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=aZSwq8Oyzz9KvZAiqWCH4H5qVdhCeMpRGM6OXuzM+P8ke5Sf/EL5P//OKxtJy9LESM
         IsDEuiXTJpT2rHpU8K+mQbxbkM/X5tnOmMJ7ERuRhuKKb+G00gu1t6qkeZesFKFSQRe2
         cYsX55ygCfwMgJQkdxSL3IXlkK5xrX2USj3VLFam55bfVr9HZWeqFJkrtXpbFxMd5Yuv
         bJYTmZ9pxnmZsyqOTRb9na0tMkI1+6TRcE84v8PPNZVcjz80pUZ4zovLuLu7PbJztlG/
         k3KlgjwaEfnjtXdqdXPhdbnzv8shwLIucxh/R8Ac2ThmX4I80sSHUIWDCn+WcOPZ2x5B
         8qYA==
X-Gm-Message-State: AOJu0Ywf/xhPduGal6yQgX5k6Wd+y/Bl4FbQ/lRsj7f+tgqMa5EGzZtN
	AtG6x0TgLzGLIgYgv7e4LFE6icQw08iwiqikSOa0lkjV729vkxUWCSak
X-Gm-Gg: Acq92OGgDlwlUIO59JosZ2uaEN33MmT42twhOZvG1kz4um8tQzZBJOZc8cbe80sn+XT
	buWsBakbmYvLYcuSdYWGDNBusdt8dQVMfRkj338wTeKtW59PT5M3NhaR1vboQT8rOPymAfrP2EL
	j3YNMJC2/AoHB+wLP3z9hVwN6bBHueS99tlsOMSyVRwdXylp0Juz/Ptbb6Ii/dmdXBGqMcZtwnw
	BUVbtsFj7IN+MY+Px3wV927EsnUjL8wFoiMwPtXRgCNIqlVBBWs9Gc5PfUjz4KwY8dIh+INSLCs
	Jmk5TvWrZLASLld7wYCnbiuIX78REFuaJyer2sRzbepvi5rV7jMudicn4SyGyOwIU8APFNKFUc3
	QUB8MM/6/PKOAS4WiRmOXSATWI5PbIYsZXdIMATxY+Qu7CS1h1XJ1e2TNrp/o7Cn7/s6uCtYf5g
	oyPqtFRCadug0q0Y/yetkbYBQE3NtNhobsefQLRlxpTPljZF/F
X-Received: by 2002:a17:90b:4ac7:b0:36d:a510:f908 with SMTP id 98e67ed59e1d1-37c522f3b17mr3344504a91.5.1781607709910;
        Tue, 16 Jun 2026 04:01:49 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb67sm2668045a91.9.2026.06.16.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:01:48 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
Date: Tue, 16 Jun 2026 16:31:42 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-11-950d25a05d9a@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-950d25a05d9a@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-950d25a05d9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..0999f7dbf434 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -329,7 +329,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

