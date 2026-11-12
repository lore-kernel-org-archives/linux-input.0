Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466249;
	b=yj1zVupwe05D5ugjHnfF+BZP4uaqd/Sc/TEEOe7fCdLUg9aDxjFxYFzAhuIMXmeXM9b1
	 MLKu6n/vpL5UeX1CdkIcSHM5+hSPYf8oWWuT4NI5Ly25+bMywvsXoJ4r63oWaRypiYAqb
	 5Zv7DNUDM9FevuQdMi93mL1j3WhCs3ETiyLGn68v9r6kbRf021S5UVbjK9xB+DukcwgUT
	 zE2rJzpC5ByMIiOUD74o/Ed8PtMpzc2QtDLU3Wd1/sG9VJAuISKqyV0m8gOhxGJLOwzYU
	 n5BqRwtrXnSSkLqQ4ia+zB18JFkvljxfsxIg1N+MUygLjcenGTNdBcFnEWzYl2UoY/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
	b=cDS6B1ZfE2XgLqwrCYv/N74hmSr00vAlVAaEmxQ01FLGNlHpcdycGISPcWchdi6IRq1L
	 e3qLpKoJLp6kkBjlmTDaf/1/YyMMEwHveP58/Go3kVyj+hYaG7x0c0cj5R5z92Gwc9qFc
	 NLfiGa44afcsEkIh/KhzdXjL002t4957meKLaK8/85rGekJiyGKN9bD0ZdOl8xEn0FfHp
	 TX4rWcxJKDhJetnVy438befgafT7iAdz48/OGbOftazBSTsW/HQkKmDDSjApGgcGtnEHr
	 EMbDvrYW+uLZn9QTqkBRa+WNIuMlcqSUHGxhko7kYsGNRB+67AD0TqUcviNyK7HO8cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zreSoGMN;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227C606DC94
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6227C606DC94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zreSoGMN
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so2284566a91.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466249; x=1795071049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
        b=zreSoGMNrTJC3Zn1q9S6QOkvTQMU1FITVvkgPEb6jkGbOa1grqbqUWdBG2XMuCtz3h
         YVIzsqYyUUKpHbbBTzHbP6yBp9TZkHN+/HQRzu5HxiVc2Cy1QTzDUYO8auFhX2U8q5xG
         nkg3sNTaKTJQ7yG/P7m7cHD8HtRnf8vd0FkfrHtRdTtMr59uBwKcfqPzVCf41yTePx0O
         rYS3N+L5z1v4ZKiGGCKoHodV6e7cmm/3IEaRJpbWJ1jbu/6Olz26iAFzbIX41B2vwN06
         Gjai4LecFguZbpE2WAqo6R+ro/Kz1pAbvLDNSJHD1B5PYOzrNNHhFc30rr0I99lpTR9c
         Waww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466249; x=1795071049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
        b=KX/k139y+Ykm7Dxzemjoo9nw8RuvWjVKn6T2hPiP7CVkKSu5zCZJvUlZlFFZ7ewY8n
         bNJNxNnGilGoGMttzyZb2aylXU7o5nLT5XTWih/5jJb9VUGflxrOFfo/TZv83dTGTIfI
         44mzPa4IUGjrPXuJiwmBP3UEWc+nXfe/zyXRjrBATkCi0c2kAyht9NaBdLPuaW+kqatE
         FMl26SFPWgb2o09ofXfbuhK2xoHeqBkfBZ5zQJOEk7n0QVhbkpRHwURxUILavHN9i9hx
         0Rd24U+TXJSc9Iqs9Cqc/JEMS2dMBJeiAVvhuCdnfVhW3zO3yVYaWXkWnYdpHpOWdQJI
         Yzjg==
X-Forwarded-Encrypted: i=1; AL+hErHSGZQDUN88qJstCHwvR5QtvioxFGSdazs9dbxQ36G/wWG7tI7AjtL+bkN2M7AUtZFEaqV3YBnAe48Z3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9M6Bg3zyqSRZJVFYUBwBllCIKaO0wzpuKeOwXPynh/Po3SwXsI
	6klwoOP6vkNgyHKEeApxnZUdCsCxQUV/W802dDYIL8JbTuOkQRXbr8JV
X-Gm-Gg: AYBFou2tDK4OKN0CRJL1UqNs8iS1fCYt8w6cQ4tBqOkTCTKzwvbr2WSagd17blUC3Z5
	ynNtMNL+7ZyPo+fvpDZrRH1j7WBmpxz5zrGxeSQpc1E7t8tCzP3zWP6i0yataP06Zji1m34md2E
	lC6v0f9tQuJC0KXw2aNheoPe6zFeSKq2raj8cWRxdOITOfDFNwiVqIAX8w+bA0axL174C02wWds
	JjQYgIt24+RyL5ygeNP0+DctpBWdy/1sVQDa+xQTkHFAc6473xlLyFscy9/X+vhF0Chpk+6rXx5
	dFaIFO1jXgGYy/mx6KM6uk4XnAZs+TjWc2sJaGkoei8u4oCykzz6INDmStk/cA4Biy30Wacrm4m
	gUFc3JCko9WkrAtIlNCTiB3MVhkpijP7eEyjtXQLwHIyNzTV4Ch2j1ZKYL8Xli6jHhwdi9L0EwP
	FPqd3dbbx5mcA8F06WIMmRFsVPx79DOTz50Bm6Stvbz26SArQJUph2w7rT5X96kwVQiLY6r21w4
	BqDA3HYtGMd68tKq7V2YFL9PcAVCRXFZ1pD8gGqC1UO2WIcPMJop4PNB/X1DDqE4pl0yiMAx7O+
	6WWU7LOIcFGVqD7P/TQrLcrksRm7AIbJjk7rSCBrGOwK4IX21UvCYOuXxAaFbIb3h5D5g5kScu5
	QUGJ7Z/teFrwxBcW6
X-Received: by 2002:a17:90b:3807:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b182fb6665mr4729745a91.54.1794466248801;
        Wed, 11 Nov 2026 22:50:48 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:48 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
Date: Wed, 11 Nov 2026 22:50:37 -0800
Message-ID: <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Request the threaded interrupt with IRQF_NO_AUTOEN so that the interrupt
line remains disabled after probe until the input device is opened by
user space. Explicitly initialize the stopped flag to true before
requesting the interrupt and drop the immediate tsc2007_stop() call.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 1fb2c26189ba..7660504f58ff 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -270,17 +270,17 @@ static int tsc2007_input_configure(struct tsc2007 *ts)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
 			     ts->fuzzz, 0);
 
+	ts->stopped = true;
+
 	err = devm_request_threaded_irq(dev, ts->irq,
 					NULL, tsc2007_soft_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev->driver->name, ts);
 	if (err) {
 		dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, err);
 		return err;
 	}
 
-	tsc2007_stop(ts);
-
 	err = input_register_device(input_dev);
 	if (err) {
 		dev_err(dev, "Failed to register input device: %d\n", err);
-- 
2.56.0.567.gdb80ae8cd5-goog

