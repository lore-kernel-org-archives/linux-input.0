Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680673;
	b=OVQHvD4lcb2P5hMwGEwJRui92jmfhkhwNQwqJ4TggFLbgQlwGMF9ElqCnOgzV69D/fPQ
	 VBtKLeIlOvt36It66jJ9IF10ybe1VOuS416MSOH0Uvhf9M03RZ4GDfKbkMueOlT/kyz8q
	 9zQvZlRqVvnxqWRZdtPX2nf0s22Gfi3uBLw7tCpnIkF4nNdXSjqSsub7rFwRoCGHCOl37
	 Ody3sm2P/g+t+Hcx9xuvglnpjl1pAV4DiP2VNEPjpcmP4WU3TLxofYKeio+BgkTwDfXN1
	 o/CgYmG6d19enJVRZx6q5fZMlqcVk+KKXARXjXZK72+tiTicgHS0/nwb/QG4x8y6e4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
	b=AAq/Lt3jnXT2qJNAXKZafGzE4QwgFvqWr6JQFTSx1ceWf3NRIvPz8l6cMEwP3meamWqK
	 63lWsAfIdmABUICIKwDsJaOWHNNirTrVxPcIgmL4NfsmQrPeB77tsQIVxJDuFXZZ8ciLm
	 xz6heD6KYmBHAWPQuyN0AYWxkqyo9qvXrISzE3EyL1J/fOKNH9nC3xGUP9pPPIfApPiPq
	 qGFZMsa7aBvRVfoEWFalgQNygXLO2kTGKUXTRr6IV60kJ1JBLAi342jd8qS3NgtPkmd1o
	 PUVK5cnzN6mX6ksIDGJT5eWtzIaDxLg90/82ndZizrxfrE9ijpitsIWlDgFEacRzuCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PdJvRmCB;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08021606A32D
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08021606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PdJvRmCB
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1611479a12.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680672; x=1794285472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
        b=PdJvRmCBW1wQ6OU3g6wpWwu1J+p3JTzSxLtDdRYLIr9+zCvOFml0datlWZ9ZCXiSL5
         jp0vGuECBDFT6Qk+GR4a7krValxFzz4CC2Yy4WM6IlDhVb1rY1oHPLq63weM1s8yeQlx
         ODTMOxlqBLRuml0PHSxQngt/9AX7NwITY+2VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680672; x=1794285472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ggqaj3bggsrUOqnPqyXrXYqxV+UfImDX5TnRZxULpTQ=;
        b=r+ZMBq0Ryi9WqlxtUJ7y3lHaxxobTbTAMG3AgTx0sqD/XGtNmYeOjYRGVr9PIyN6vv
         JBWMTeHvFY4V0Gh94RFyHkTbSqBa+zzL7xyBrEmucGqdM6dTzmkIX6r997ZCpD59UiHB
         a2HlJmnkv9C1Zlqo8zopWZ5GF7hPa3f4Z9Qk7b3R8k2qVlHdjVC4tlVlvL3h2tythifA
         JjyqLrKWRXSUw8baJpsGZfq5GApEr4sDW+wW8ZftZik3/Wbqef+qviZjDjG+2D7QlDRz
         DkLLnpPA2GgSspbvMrw+tyWmr59jvPOOQtxBUmOEkYsHD9Mf1JoNrNuOjZOqEGz0rsJk
         OwKg==
X-Forwarded-Encrypted: i=1; AKwUvBwsdTo2EUhUbjuAHpqGfukI/vfXoUH1ZTvKftIwe4GAlGQXWhovJ62ogW4SGFksKuLfO1Md+wYo5v/Tmw==@vger.kernel.org
X-Gm-Message-State: APuU4Z82DniIJ40d6uY+JIVqvS9RAlja/D5R5MsNZhpW6hHeV3J5tPuK
	cSLawhDckOF51XBzSCLTFj6ylq8CDbIgc5XMYoFfo3WK14CHkeL0ZXm6SEnSpWQScg==
X-Gm-Gg: AYBFou22gr25eiD1+rAQ86SeXRmsjnZbSPwOPF5I4ov8/Keo5hUcjjARTiLS9IwU3qb
	0QV5DtImCTlvq1qXqJQTAdIz8StcIHdhzHlaOws0oVSMfYutpP2jXEiljK2F5ZSwLwOfUXLe28s
	0Q/RTJrYMZShy9LzEV3XRxPoS3Lsuopx45nrwS7Hvu7wWtu0XtRl71lkghASF0JELLz4H1i2MIu
	4tLZigFK/2eYMeO/sPROVhDde9fngrHHOiPpyDW9qP46xMYcjAa+vdVTOHZ92fYHHFTCJ746T21
	wXuYpbfKJFvnw+X73bZ2g2lRkyg2BzAYs0SmfmJe/PGJ8dzgaD7IWkN24dPnF6wTAH0DDdt6M+S
	JmoCu8odJDrxAhUa9EC2J/z3OiPJNjXtBz7XFZObPyonqLgt2fRgx2VaMh+iX+SvY9JUdY5zP/O
	e/8o/4HQsxP3UT9UrLDz0DtShI7waLxgZzLfti8ADRJYdGcwBSWaNEXRkMrhxnCQGCJoru9HoJo
	VhHmgt/yye4O8pzRaiyow29YlqaojOrR7LzdQg3nzwIUPjbeCo+WY6kUkkn548nTLPrH7wm6nt6
	Tn1tvifYbxUcWD5CjdaaRg0bu197Hm5lHw7dQ5L1m+R5ZyMj7wCBCgYmss1mQjOBJR5keg/dsAO
	WIqRuK9CSUXfj
X-Received: by 2002:a17:90b:562d:b0:3ac:8527:3fcd with SMTP id 98e67ed59e1d1-3ae898385a1mr9902090a91.39.1793680672423;
        Mon, 02 Nov 2026 20:37:52 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:37:51 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v7 2/8] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue,  3 Nov 2026 12:37:26 +0800
Message-ID: <20261103043734.2179858-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Cc: <stable+noautosel@kernel.org> # needs new regulator API
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added noautosel tag

Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5e505edbc33..4bbc6cef8be6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1260,7 +1263,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1416,7 +1419,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.56.0.385.gac671c819a-goog

