Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9142B742
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605630; cv=none; b=cTg0J9yEsBqcx0WURbjMb6EX0QVgdsgQhaMHqNL5bxIa81H2SaznmCXIbp1nqAzzfP1M+veDNODg1wMFOFKg7sf0/iMnd7oPNGoItbwzIpG5YOCDMa1ukbOY4ub63M37EdmfNA974gw3Qlk/EImMaz2xA3bEUEQ3pCjFXFIO6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605630; c=relaxed/simple;
	bh=aW+PXsX+6KeImEBx+dybVaOovDoHX5ZdBphCv42nK9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxKstFpquLaxsS3Vaw30rMmn8qo5R6/DSVMKJiRT1zzG633vvDBsrmBOQSjuGdAiDEUT8lntDhWvnBwAo+1bO7kEsI1XYM/Lq3gAlOTKmMEX+KJiNp1+i9Zm+WUDuXKAB5GuuMTjo0QNTyTEoP0FPFj/qRzOU9yqhV7J6yl/p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRv5/lae; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRv5/lae"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2784436a91.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605628; x=1782210428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ihskKwTjoW0FSUSEV6CPpcECpjKDSFbZW8iDqF8sUE=;
        b=QRv5/lae8AfALIcQFzPOP4NoGGUcyyAuMNUJvC/Pb2CRsj9e0cd8b8oa3v4zKsFiS4
         T+zXMsZWgYlv6WkkGnI+sZULKhCJK0aWwKtl2OKYktysIgz1MWeXBLWITnPcFK/pfMns
         TdnU86B4vAEBEhfkeOwn2DP+YeeTzcCUHqY/aIO7B1Ih+G1X4zPSmoRp2+whNJGDitv7
         /qcFUAfSoaDIENAtegIFk9nfUwt6yF/TVS6AejQDIBid/nu56YTxmkTXevQVpmCqd+qC
         617etWI4Mju5/wz9AisBmZQmnRdhvyk+xWw52rrF1VPQcSJw7F+cbuP49iUAS4Vr8iC0
         bZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605628; x=1782210428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ihskKwTjoW0FSUSEV6CPpcECpjKDSFbZW8iDqF8sUE=;
        b=gWOkUB3/f2aaSziA0Iue5CBxfMW3FVmkitbClSb4ZMPBLxQTIsqJOYAv5BsaODnKYZ
         K1JGQxujOxckkRJsKr2xOKSTIKgvWnX4CZSztNLiwJuSim/rH/E1ueTinfCvHVhJNdJR
         2hL/73d3d2Pv0tVDP2a3ottu/A5hNifMTYHcW8dfzcj5aN4zWfVyg1S46CBF+I0dbQ3T
         UvpIPlnEhKJH70qY2tzM2OOQ8LvH6gf8Wp884UGjgAalWo44LoZFMwuUrnBE8hlPI+i4
         fkJQvyiAl2elXIYBU4OBTsvCnTTYxvfijE/NpOwyPv0dMCWV+1ovOT3m0M71QqVF8EI2
         +azg==
X-Forwarded-Encrypted: i=1; AFNElJ9KW1aUVB49nisAp8cYS53sX5COsDKUdp3C/6HbwdYlmf1iLlQ3tlvQKUXglifFo+NEwayVnYbjHfYH6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1g92ztod3DvmTFjf+uPoVuI4cqAsigKGLqO2ohxTeKK3Mny/Q
	0yAimD0Tm62EmOjiflIvIG31hgajbavUnD9TUMv1D7JLd+zobXOp0770
X-Gm-Gg: Acq92OE3aZdUG58fGsDD4ROqxy17r0BWR5a1flBRWAFXrWwvYpWNDcebiZyDGDsxPC7
	Nb4ZEsa9DZdQnKB2/F7cFYV2eaAT5WcKJm77MvbfKdALZQGXgmjtXz8SncSud0OJoVWxsUptCa/
	76wME0X1Zcp5RnrEt6UBkae/Borla8en+P1oH4/BrRaeL9eGsOD7Jw7XYM5xfWzqZGPWogxn9Ur
	kjDhlX5Fm50T+3G1SVO3MoTUEZHusf2Hhuwnm8fjReJIiK/u21pqKaiICk1aOn8cGVAI6kUjg6g
	6Yb3zNdwwGKKJ4DkicBmhg0sCZ5GopgLu9mXZ4D7bJZT7V2oaEgcm6/UJ+iaaDjiRPxFQ4MDlCc
	D0qkeNt4hzwgjMa6gbv22VH0/uBNoyQ/IbGXUDKn0cTIO1yAsqvOrBrErq+MkGj9CXa29x8hbQs
	mcqCuo5gPpzD4SMta7vteVK7lSYGHBf1LT2hAlw2qFSH+IAc+e
X-Received: by 2002:a17:90b:2d05:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-37c5293df35mr3124659a91.23.1781605628298;
        Tue, 16 Jun 2026 03:27:08 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:07 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:14 +0530
Subject: [PATCH 09/11] iio: hid-sensor-rotation: use ! instead of explicit
 NULL check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-9-0cd544286575@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 20563d8efaf6..fc925ec12d37 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -278,7 +278,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct dev_rot_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

