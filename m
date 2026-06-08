Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB42F617C
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894260; cv=none; b=j7HbAB2plwhWknxrqULWfXTuvwSIVAtZ46ty3DQiHz8Xi1sFslYCwJah56oVd8NkwxgIweMwysr3lojabKSQZEGoyAnbtyBlsWz5VHHawoj8tghfBmq+Lk1XsZ6h86gwvrWPhoo3RfMxPHWitIj7C6MbAYsy+DVyd3Kaoz+7LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894260; c=relaxed/simple;
	bh=BYn3xmXKI0v1FAOTSJzZlaAtSsf0ri/Iq6Rd104WwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Thl0THnW+FIC+A19CqZq10Vzi8nRWVnV5BTHeCW3baRzDm9aOznIsPJcb7LLgIdYKjvCiJdPJ8xg4tMu6ytiVxknz2ZJqMNFmitABtHfIwfschbvnhyPLu1rOD/xXSpVJSVCvGV0/sr1GbHpWnw+AFcTOGHYKREjquzOCxOl3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJL/SCQJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJL/SCQJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so2658785a91.3
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2026 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780894258; x=1781499058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LDW6Tf6NQZ53BoaFBWT0UGNP2FEUabDU/rw7/8e0ng=;
        b=NJL/SCQJ/I097ul+FGyygAm90Btp6yg/vDQ0fNCnDODwIYu8seQzPdgLLqJxJqxdr9
         wBmVm6BdXsfwvKYGyV7I0WqXSKWK1lJIp3O7X9WnYdNYuklV/D16N9nGwFp7pNYbkm9Z
         N9O4noID+io9cfgIArrPMuz6vtt1vTCwMYDcalLO7ECjncUQUsg/vRG71tpgoD/UeCek
         6FH/7lPIPt4OTyJDR+hMveV/Us+t1Q1rHFnmeLuikATawGGFMh69ZgL/YAo9EIWHbSpP
         RRECeYqPwzYONvuFELeFHtS/ayaXZx+G6+Q2uegMJMUTEN+5qMPnuZxJAxf4TqpgPUaG
         oPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780894258; x=1781499058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LDW6Tf6NQZ53BoaFBWT0UGNP2FEUabDU/rw7/8e0ng=;
        b=EI+5m2T6guxadakj6Vm6bR9VAN1hRdecDf9DaxcnU64Z0XnCxKxtLyC2tPrP1o1R4H
         ze0+/srqBW6SiJFf5KXtMwQnM2YfUEBfshaLI7vZhlHTO66RwFYV0/x/xW6oax7EfGkP
         JjrUiqi3a2lnCq2yzgnohGEKY/zf5m8i/Hphnb5ObRIqAPVx7PNJtnel6ZWSdZv4jrnx
         1RKvn18E/Bqgo1RyLphcYgnN2ExIiWyUYrsjPE5nFGwl/WhAjsEERIQh/U2Tr0mOzr3Q
         qtxSYDcYK7n0mkmiodUvrptYkFA8ITTDc8cC9+nfjOtGR6wf+QgKG6JCRTY0B1niV6tY
         GZ7A==
X-Gm-Message-State: AOJu0YzP+eKVppgzdl2ZWK8sOjzLKkcBDHS17DWh88VQzgeWgP5jGImz
	xDWkBkQRgLJjbx9KauiIlemWJJRstAbnrZY3NyGq8Y3FtBCTX7qSXNgVptJjbw==
X-Gm-Gg: Acq92OEkFH1u9NfDikxxC2Rlam7GSYkN4hiiFAo3t44ElMBoj7K7rJ9bn47NDz9SAu6
	Zd74TUFe8Z+cQirFRP30YPhBWi40qrlpno9qzvsULsArgQ8QSlxsKZD3kQXyNBslWr7hAV2biJi
	9nsVlhP1PCrTVPTxIe7KXd2tGceVqYplWUfpgSJk63HGJtSmlu4OYepT7lnEuAR6d57wPXlWec3
	EwSu0F22ZFdKi0Gf/0WVgQtoE3SvaooLwcbG3aSHK960VNlSSyZaPq7g+Zmn9X+YPPnuOozS/K6
	QL7ew1kW3F32APWNHYR2sDJ3qUgvrADqzPDi4BDH/YBg/VfJ2CktO6Xlk+KHKdlYpdNQanD1D2h
	KTZq8BMze+pHkH8+mZfBPtZUOr4DyXKy/vTLn/ylw48aJk3ZahLBmKi7WcYa5kZGOn4DmglMjtZ
	sDKOa6QYP0RGyTQ8seq+ES99LMIIW6ElR0sdcDqphBzn5ZfFQz7PFs025Tgu53hLcRnpVJDJPOq
	4nfijBRJBt9piOvv1xLY3ACtjtIfB4OrX36duaXgFBTgw==
X-Received: by 2002:a17:90b:2ec4:b0:36d:bc0d:f789 with SMTP id 98e67ed59e1d1-370f0a608a2mr14470035a91.22.1780894258396;
        Sun, 07 Jun 2026 21:50:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37134116c2esm6375698a91.1.2026.06.07.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 21:50:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] input: ipaq-micro-keys: simplify allocation
Date: Sun,  7 Jun 2026 21:50:41 -0700
Message-ID: <20260608045041.4664-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to have a single allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/ipaq-micro-keys.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index ca7ec054b1ce..0fc5b5dcdef5 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -23,7 +23,7 @@
 struct ipaq_micro_keys {
 	struct ipaq_micro *micro;
 	struct input_dev *input;
-	u16 *codes;
+	u16 codes[];
 };
 
 static const u16 micro_keycodes[] = {
@@ -90,10 +90,11 @@ static int micro_key_probe(struct platform_device *pdev)
 	int error;
 	int i;
 
-	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
+	keys = devm_kzalloc(&pdev->dev, struct_size(keys, codes, ARRAY_SIZE(micro_keycodes)), GFP_KERNEL);
 	if (!keys)
 		return -ENOMEM;
 
+	memcpy(keys->codes, micro_keycodes, ARRAY_SIZE(micro_keycodes) * sizeof(*keys->codes));
 	keys->micro = dev_get_drvdata(pdev->dev.parent);
 
 	keys->input = devm_input_allocate_device(&pdev->dev);
@@ -102,10 +103,6 @@ static int micro_key_probe(struct platform_device *pdev)
 
 	keys->input->keycodesize = sizeof(micro_keycodes[0]);
 	keys->input->keycodemax = ARRAY_SIZE(micro_keycodes);
-	keys->codes = devm_kmemdup_array(&pdev->dev, micro_keycodes, keys->input->keycodemax,
-					 keys->input->keycodesize, GFP_KERNEL);
-	if (!keys->codes)
-		return -ENOMEM;
 
 	keys->input->keycode = keys->codes;
 
-- 
2.54.0

