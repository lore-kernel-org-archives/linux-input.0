Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF932AAA3
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616338; cv=none; b=tlDW5yn8zLCzFEuRXAqWan1IeUQhYDBD63lXd66KoNDSdVNWmxlH/lZlXjX8pzUhqTBxgfc5VG9Z1hVept1Elo3a5Bg5GzRwd/34TbqmeZ4GTglxXs25bcoxG1SFAFrXtWMEtZik80rho70iVXflU2AFsGelMVyn8cLUYPiRdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616338; c=relaxed/simple;
	bh=ivbSDbPjMlcwVSaPpwbnzauJAgE6QePNzCiPCOIkAos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nEEoVPFRqETUDXSy7RV78JoO2M1AOHK1ToN2rueJsyfCo9Mj/VOWthJldGtH/7py+YSmXKKjgLzrNdptBfkfIrVQMF7UwSl15LNt5LNGGYevuh0HOpapoccLbxeXbFWKtI+2KHg6RlJ8jEVf2zoW1q1+XRN6TT4JyXAATJ+rSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/FqFtul; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/FqFtul"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422f148dfcso2647740b3a.3
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616336; x=1782221136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBh3T8DiAUTzySoFqHErLUnRhZqyPc5fESGPTvCXENU=;
        b=U/FqFtulpgqDzj+DMnXHncndgFaZFsID/BuFVPNaf5pgLhDMjukwN3bVt40sv7MwSQ
         +jIjEE7EJlg1Rhu5fuqiD2wxSkNJ2QCU+MBGmaoTYC5WgBOIVGP9eEHdwIdcJmf9iwCe
         j++h+OfxDYbQixBGbatbOeF/ql3nEJ0XxxzJm24eI+jK0GqQnxPcNrCVR2ctCv4TLjHN
         4Cta4l3SUfF1ECTLxYif5KCKSs4gnCpAcL18j6AEA2qFqowD1p9bJve0BFiEbdulz6WF
         V9qwyCLgbRLyMC315qnMKCY7oF0nVsyEK5xHbvhZo+L8ZDthSXoxkaAuYPs3c8JSiD5i
         rKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616336; x=1782221136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBh3T8DiAUTzySoFqHErLUnRhZqyPc5fESGPTvCXENU=;
        b=jHtgbw9bIsi6LorJSlL1qtlQkp4Q/uVh2AXt5E+YqLxXIvGEK1QZ2qh9bUkcH3se5o
         5jDf9JbHBsZypq5HzliUlldyvwWcSQbk3AzC2liQe3bNC7pzvgIxBtFD+jETeKYHqnF6
         UEAvgX6sxuvcNZk66FA5K/59iGSlJXnY8KIRMY6TsQ3YKbV72b1MTh72kTXZeHDU8cI0
         qxJ6ng+za9JjuSkjfFKlhbnRQZB4pPkCXOsNyxzMoPypxqRmhUQXAo39Dz+q7XJqXNDV
         4Xxyi37f08EtoWWUmORjMt5zFPtV9chI2C8V6TEfakjF0dLCUk9R3MX2NrKwLxNa9JtH
         9yvQ==
X-Gm-Message-State: AOJu0YyS1qYschSbKVhnM7iVzPIqSz5bnTqL85sNy88//21DbvP+FYZf
	1cUkxc4vyMl8xN0g2OfPeE21/M7Hca5+r/97HYxEzush9/yTD0AtQwNCpbf2vQ==
X-Gm-Gg: Acq92OHLW7HlX6nn10aSDyGfepG+5Q+QVdobW/hcQMorU3Y4ZlDdIRTw4kO4H4hlSrl
	qBliuvKAeXZIbGfldwmjmfMwtHlWhI8/5ahX/Bw0PU8Sr7wYasJUm9kynfK3Dmr1P5GBWhF7rnJ
	0XvqDfdIbIbHabe0vxVeRh/x/QaoM2A7v7ci7gCcILVLD5C7LM5ECYq0yWU/oBPObUXfyNIi5Xw
	GoYPIPYwBY2qLFyQe8SIKOi+fm3iuzJ53HcRrsEqmAyKWOTRa69y41qHPo46CtQbYUHWghHiwys
	RuZCrQQaYxXDAn7Zy3NF1/DPNHeqRzHQjE5FYRf3SfUZtldwS15aBj12V1oS/KtfU0FSAOsQ9sl
	6DiAWEHkyeH05itIl7QddO9rKr7P4GJuKVe3Nm3kw0IUFaDFrp99OhL453wyXUxu3NrdSKqzF+s
	qntFq+NEzOFuN3Pa3ZI3ng16gl3EDkbKgdQXn27TsR4DEB3RZR
X-Received: by 2002:a05:6a00:4fc8:b0:841:edb9:4ea2 with SMTP id d2e1a72fcca58-8451561d852mr3340064b3a.32.1781616335757;
        Tue, 16 Jun 2026 06:25:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 18:55:20 +0530
Subject: [PATCH 1/3] iio: hid-sensor-temperature: use u32 instead of
 unsigned int
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-1-952c74195f46@gmail.com>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of 'unsigned int' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..a8d3a15f9c53 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -125,7 +125,7 @@ static const struct iio_info temperature_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+				u32 usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
@@ -140,7 +140,7 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
+				u32 usage_id, size_t raw_len,
 				char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -159,7 +159,7 @@ static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int temperature_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned int usage_id,
+				u32 usage_id,
 				struct temperature_state *st)
 {
 	int ret;

-- 
2.34.1

