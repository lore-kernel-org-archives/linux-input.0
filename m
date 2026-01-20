Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49743426D18
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937784; cv=none; b=AwoI78nNIdCqxp+09V6atGcjcPX5OrYAeXtFbITWPWz2awBYLmjvxnCphqldZzbH3nb/eU3daPwU6ozIZ/y+wKB20Fz6W4HGa7R1FHO3wdVsQd0jNIPbhANnWYFXMp2PFIXwWuEQXKdwaRwlNAs6okLj+6lzpLr9MSC6I8zfU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937784; c=relaxed/simple;
	bh=XkNMP7cd+gchNvP7abMlUd/wTlgiF/59hJAv+vC/3gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv9bT3RUFYZauGjXpyTeGTdRgFvu8Uuqt+ZyAfxbvgvmK55qrF1uK6/PspuSGZjTU6veVG4s2gLgmEZQUTnrSLKLYubdTyYr4uSUodcQL2qTnKivBjqCjEslUS4ddnhkFbd4hNVAzlsP+ggYBSE9FffNWFFAHuK7ak+a/sXfwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXibl3sp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXibl3sp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so52985015e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768937780; x=1769542580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWDjFAm1WaiS9fdrpJtyst/PgjIOQ0mI0xi2wXullFg=;
        b=XXibl3spTwDxac9NvBsJqRX5D08/7EtKigVuEaGUU91kTlC+L0l7dDOdGX/eY7xwmk
         HOsxPxEttFy/KXOezPbPBcwbxUWFlnuA5LE8+tnl3P0d8SRk3KiPZxnQw2YByPApuwLE
         Ns1cLGfTG4B7ReuSa30hNZaj+f71Zr7d6mIFhBcVRfo+Nuan3QwHrEQIeSiWK+POrKLO
         C3f04b806Hp24BleS0SPEyeVt0M00/5BWHHWb1APfcXEs+JUrWzuyEN5sahgcsD5SDXv
         VcsIp0y6zioQTG8H3mQvzqWP0C31poylhhgYo74TgvopTFN5FHSSpRilc9h32XRVSabI
         F5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937780; x=1769542580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWDjFAm1WaiS9fdrpJtyst/PgjIOQ0mI0xi2wXullFg=;
        b=EQ8GvNcuHDpK5Z5EUX/SNcEg2CUm3OPqhwAHvU6bCxUBiZmSn2J1Qsn7bksyLsX/1J
         toGkdb7rfq2X6tYXsUj+IRDcv9v7mJLJ6vaxUDKLf9m7wiuDsMFT1Zikd08rs5pPqT4Y
         hXyfXBX+0GG4T5HoALAHV8URnMAUtjGYmW+vMAuG9zndtdq7tgflvjksnZ+7+UTblm+M
         kgtLcip5+WaRw676dtnnjtJN4gAbTL6gkLgU9KXKYBdPWN0UvDgaS5lQEwFUKjcRmn/1
         iyefWZ8l5yOeHXkUzQ4s8rxEBejgUt2WAc5IT6Sdunt3o9dqENlc2e4Crswf9ah9soOI
         zSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmacxOVjRda7V6FksG7TNTQWL4tkieYBbYblCsQF+PQNpzJ6zMhKGGPrBcjVm4FtmlsgXgpBUew/GSZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7UJGLy2eWSZdnk1ibuuw+ppwDLSVswO25n7lmKc2jeVIU4kg
	9ZVXL8eoTkOzO7XnT3ONZxEDnoMBDTkmsMuB1lLNRmT82ICYzq2/oMXgqascaiUF
X-Gm-Gg: AY/fxX7PPLOB2ps+lwVethaRQYJp/wNe1xgkqhNvsmJ5CKEWjZdbwH+RKcFhztX+z7o
	dJ3tWc4VoYi3ov+kJdy4mylgQ2Xz8sEZdjSGS+8lkZ0o7h9gZ4v0T9kkH4U9IVSHDM8/F+lMUtw
	U9Ga3IjFF9FmqGgO5/Y3gC5S8IKstVhrrQTO42TtmA7WU6t7IPlGhoHamb+6yt79d39hNIkF/d6
	wXfW/sClJIA8QBZzYjE/VeNsrRBiuKTfgqdKvD+A4bqxHJRzZw31Ce6JwHaKAVDdGZMsgFB+Fqj
	4KU+tltAsFYJ5hyfpUoGpWqkr1JrZ/Kr1hTuaDnim6J2UYN0G6I9JdtDHgO+ZYGdvuReFtuui4c
	8Z30MVhgg2eTrJt0hxK3vO35iaUAQTQnwRY7ObxXN3B+iKLOFcUQiMakluh4wxbJjP95m3lSKSP
	tdPhvf6MzkZn3TSluitmZg
X-Received: by 2002:a05:600c:3555:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4801e2fe352mr218429725e9.12.1768937779906;
        Tue, 20 Jan 2026 11:36:19 -0800 (PST)
Received: from unknown.zextras.com ([78.208.157.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4801e8795f1sm265081185e9.6.2026.01.20.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:36:19 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: hansg@kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 2/2] input: touchscreen: novatek-nvt-ts: Add support for NT36672A e7t variant
Date: Tue, 20 Jan 2026 20:36:00 +0100
Message-ID: <20260120193600.1089458-2-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120193600.1089458-1-morf3089@gmail.com>
References: <20260120193600.1089458-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Novatek NT36672A touchscreen variant found on the
Xiaomi Redmi Note 6 Pro (tulip) which uses a different wake_type value
(0x02 instead of 0x01).

The touchscreen was failing to initialize with error -5 due to the
wake_type parameter mismatch during probe. This adds a new chip data
structure for the e7t variant with the correct wake_type value.

Closes: https://github.com/sdm660-mainline/linux/issues/155
Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/input/touchscreen/novatek-nvt-ts.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
index 44b58e0dc1ad..b1c379d87de0 100644
--- a/drivers/input/touchscreen/novatek-nvt-ts.c
+++ b/drivers/input/touchscreen/novatek-nvt-ts.c
@@ -323,9 +323,15 @@ static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
 	.chip_id = 0x08,
 };
 
+static const struct nvt_ts_i2c_chip_data nvt_nt36672a_e7t_ts_data = {
+	.wake_type = 0x02,
+	.chip_id = 0x08,
+};
+
 static const struct of_device_id nvt_ts_of_match[] = {
 	{ .compatible = "novatek,nt11205-ts", .data = &nvt_nt11205_ts_data },
 	{ .compatible = "novatek,nt36672a-ts", .data = &nvt_nt36672a_ts_data },
+	{ .compatible = "novatek,nt36672a-e7t-ts", .data = &nvt_nt36672a_e7t_ts_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
@@ -333,6 +339,7 @@ MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
 static const struct i2c_device_id nvt_ts_i2c_id[] = {
 	{ "nt11205-ts", (unsigned long) &nvt_nt11205_ts_data },
 	{ "nt36672a-ts", (unsigned long) &nvt_nt36672a_ts_data },
+	{ "nt36672a-e7t-ts", (unsigned long) &nvt_nt36672a_e7t_ts_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);
-- 
2.52.0

