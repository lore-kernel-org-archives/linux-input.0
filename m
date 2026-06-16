Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9E2D8391
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616342; cv=none; b=uCSqnFlO+Bz8PRcDXWbsAwshni0RfeBk0QdavESmN0JkCssys5zgdlXk6Ruz1lyA8LJ6k6OviTm9RIA//bnm4yijjKj4d5QqEcq7I6o1HOH1gGH0ACtP/d8rLVAiS7iVNtt3knY5NZH07KgNoixyZiwDt52+U9JCf4sefLk+wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616342; c=relaxed/simple;
	bh=Sxd/SrcujUUhRfwBaDCPn5GXXbvSiDKztzm3UU5gxPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onv2XrO34wJ+sDkYe7dyR+GAxn7Mu3d8Sl+zOFA7V4jj+SEmVauE4k9Go4Zq5rSZ8ED3ouj0K5P36Vrf7z0OLQyCp5fM+LdC2C5nApk0JDwR7lwLBguYedeTJJsPJq54JICTP6OwOphZbVjyizRffNXKroypp254xjlxiSiHIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5Z2njBz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5Z2njBz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c88831f28f4so500364a12.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616339; x=1782221139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkocZihbZzYSbPpNk3n5PGGeczdx5v/JvKMwmEHQUjM=;
        b=p5Z2njBzNUmXB4BZ2UHNTGohs4RgnaAlXUw8dleX9wEvcwfnpPI2GuMArepwgKWS7i
         3vr55CYblzMxhHWODxANIkMkZ3heGnHbYjRw3qUG4x9nbfsMLtIUKEO5iheGj7Jw4hK4
         AO5VUYlAIu3knIPQI3qW6mfHnBYoX+s365qnrJ9l+1eMBD/CnBAf6UWtNCHGveRwr8Bl
         UHqOVBBZ7PKb1TtAnRPJWptf4EM+W36G0XSh2FpIqxTqpkkNJSMboNvt8W9Nao4OblB/
         7QZmAyr0bsvIAfEpnBNSahdhFU0pYxVx4eQvvmlMUuiPorE5LUS02YSyFco0tThCO2gf
         IF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616339; x=1782221139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NkocZihbZzYSbPpNk3n5PGGeczdx5v/JvKMwmEHQUjM=;
        b=qIXSCA11xoxibG0Ts6/Ophr742uiFUaD390lux02c63gzG4CybvH6kOxebiL6kt7RQ
         3Aaz+etpmVC5CbYylz6oIXDvJEnMy+WTyW/ZfoIteLBDpsVm/qPThEDZtCic0ydjQlaO
         FSvNYbusTuYKz7Y/fOprRrOAkJU2W2f/4frWbVUaIjvbHQUb/TFb2n+DMmyUm3x1Q6yD
         Zu5LRjEegcaWggZhacmHBi3v8OEDmA/7UnC7sNWy1CX0a+oQ93o6rLv6vIGB44mzPb66
         vbNV/1Gaw29ztrTb0jyuDm81S36VvBZ+Me2XqvYDwrHqVRP8B8i+5eT73n3XM+J4Hnk5
         Dbog==
X-Gm-Message-State: AOJu0YyBGNgj9MVKaMidG5YrcwDawcDGSYtvkP0PFMPsp0Q3oreLa925
	COE06bYvJoKmG4PWvEz0qPeuPgJO+30cz9qHhNK8Nl+uJrV6YbYjMRAQEEd6Lw==
X-Gm-Gg: Acq92OFFGXicdLti4sgV0mLF6+JMP2aiGbyMWdHPqIkhaaMRo2Kdwdduo8QJ2BD82rl
	j+Xw5W1Tp1RLxPQsQdoe4ANU8nj7lCEbxDtHp7ODmKDfpvyBmYnpIeMPaUuNkW6i6JxMfH7JuXq
	ureCYBvwmTLxCoUWbDc0v5WnMth8JQ2qCN2qG7pF+56ThgJt+D6zVj6xPHLF1M0ke4fjn4h8h6e
	pkpdhy9p+dBr5qQZINi6p0qWdaCp7D8/sIDzS1u9ZSKtzin11r0G9l33LBJxgvRh1frTBdP23CI
	W4lpMbLR7kw+L+HkpfBEuQk3aZ3P9vNntdENE+Xz6vqlSkh16X0wzmXJhlH2kkVidO/r8JY11mh
	lacz48yaaElyNJMSGu2jKv8MfMrUgYWsP9UfqlYLxBxilvJvk2xO540tb1BK+FjP3ZcPM1dKo6I
	lxVcq6kYJYSJdkE6UIaSv86Fp/ZnLJT+lRWaCHkbR0QTH+2eQ+
X-Received: by 2002:a05:6a00:4c08:b0:842:2efa:5fac with SMTP id d2e1a72fcca58-845151a1030mr3580208b3a.0.1781616339501;
        Tue, 16 Jun 2026 06:25:39 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:39 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 18:55:21 +0530
Subject: [PATCH 2/3] iio: hid-sensor-humidity: use u32 instead of unsigned
 int
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-2-952c74195f46@gmail.com>
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
 drivers/iio/humidity/hid-sensor-humidity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..c376a247b137 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -127,7 +127,7 @@ static const struct iio_info humidity_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+				u32 usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -141,7 +141,7 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
+				u32 usage_id, size_t raw_len,
 				char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -161,7 +161,7 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int humidity_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned int usage_id,
+				u32 usage_id,
 				struct hid_humidity_state *st)
 {
 	int ret;

-- 
2.34.1

