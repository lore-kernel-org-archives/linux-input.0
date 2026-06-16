Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6C3B813A
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605634; cv=none; b=BHAElK6o3IUtA6Mz0Hy0Q4ne3FkXYS5EDeYdRyHZBSaIzOUfm14h83URUTV+GY55II+bRmWSj9JcVfIBzW+ABjVvNdGTtUgvWI2NlqZLFoE8/ez+HWsHQCgSJfontmtz73ipac+NsItuHfe6suOFaMvttxYq05JeXF3FMxp3JS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605634; c=relaxed/simple;
	bh=nchTERKMiySHyAcZgin+UDOqk+gFtUFbtrkMUhOWUzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNvpIPiOhswAG78TuYBK2dibphAI2TfOHPrLyWFvPWqAipcqRgmH84QVkx4YvYNY/QtKikkeQ3235ZGBLB8aQvA/NIp5X+AhqYNAVQVAN4n6q7WpwA/Ac4kDe+Rka7ARdFdmPwnUJ65xPxl/2X0tyowk4yjTUQI4Y/wZkruVYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ro0+YWKu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro0+YWKu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9d265355so2135897a91.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605632; x=1782210432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW00z0Rs/ytIerSqqtTuZoAD4LbTMtwdm5yjmtjWEIY=;
        b=ro0+YWKuaJMgOVg6+o9rsVQuz1R7JuZiFZWQbFnPwsfo6O8NefCQJSJ18MyJUlZVdI
         K38Dfkn2qIodLBEwmTWHbAi69p6JltGNUMWRkWPfyM9Mr86D4DTLKD6ihRKykcZS5tTM
         tmwP7aIHmsSg2gY44MaJvf1J2Fcn2GW8e9w5FJNQ1nSWEW39eaFWmVjc/BYwitmLbyp6
         L6RyApTA/zO/LX7TXYXL+hMJlHnE01Fn/DX8X1tIlP3WesRfz4hGR3MrAUBslX7lwhbG
         3GjI8DD2MMZS4lXFeylZiFxnyewbKui0oNnWpmwCOKyWUs7icq/DDzD9W9gedYBtzgWB
         g3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605632; x=1782210432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dW00z0Rs/ytIerSqqtTuZoAD4LbTMtwdm5yjmtjWEIY=;
        b=bDz31egbr0EESWVTrDWXAmsQxwrBRPuaVEhWCIVr4kI1r5uS7M+/cV63IrqhqLxJBH
         KgzpdVJ+TTmya1YLdtA7jjygbAvSXgqz22ECs/Hg5pBoWeQ2r457T26ZvMnvDPkmuhTQ
         w/vf7TVcaiNwBhkkgsO4y2Lty4Eit9LJnL76+Vzl7vyVPI4m6t36XJvOxcUuXBhTtQ/n
         00k3HvRPc9YNUftVLdi4uv5dMk2Gl9mwAWpyuJWOaY5dXzYSRn0uI09vNMxpAgMRFSPB
         uqykkVkErUzyWO+PCcgASWbshCVz7Amhs2Q/crLWaeMFSWd6Wd+KfrZ1op50KLNlqiMV
         ZpqA==
X-Forwarded-Encrypted: i=1; AFNElJ9CCYXNUL+5+/L2R11JJD5FRAZEAgzlM1BAFnGCyC2DVpC3Zy/S8/ZDFTV6nfUnIyHf58k/IBPk0HNZZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwqqvAfT5aVhQZhIWytRxUr6RTdbTSSGU3F0ysMO+H1lJLUqD
	u7fOnIF+k1lvx0yf/I3jgz4xw9AM1FXC4gmhqf4Z3W3Zd2yoDm9pvoCm
X-Gm-Gg: Acq92OGI7KgvAxE0Fjh3AKOjjd1KreIyPTkDhxfiRSRdV6vX4RiKqDKZUgho9ADVKQN
	t7BJ/EEo3gLYW8ZgCHlKDCDoTwkpBKsQaNmKvLZXJORSMSdm9VeZKKNE26LFe81C93sVcyOKPiN
	wpkoLo7QgQULTBJKg4mNBU4d+GG7Zr7q4nfcy6wJccHsM9qW879xFBgoSkQl7pVT4Egy0p7UBpS
	HR7gJPPcI9AKU0d107LuBNVvy/VUIyJNhn+LISXoE2eRPuFb7Dz+u6S06FRgCKb9Y7Ut14muclK
	h48H1Ly2ojMm2B2giqIvPWVLwGSx4p0ThcUjk6w8KHVJNLtriro283T0LhtALoJpYY7rgL+CA89
	/uNwXxj7kcO/vue310017A+tsbGuep+M/Wbi6pbOTdhTQx3SKkq5t4SIJb/fosejB/duYHEgfOt
	kxXcTUavqyCYUrHMjBWwtpx2pvpBZmXdvV6qR+2XVGjr5jze5O
X-Received: by 2002:a17:90b:5625:b0:369:971:4888 with SMTP id 98e67ed59e1d1-37c528e104emr3379915a91.15.1781605632620;
        Tue, 16 Jun 2026 03:27:12 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:11 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:15 +0530
Subject: [PATCH 10/11] iio: hid-sensor-incl-3d: use ! instead of explicit
 NULL check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-10-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index c7fbff498be7..4c4b0ef2e01c 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -307,7 +307,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct incl_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

