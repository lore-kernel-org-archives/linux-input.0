Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18F427A0A
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105852; cv=none; b=T6RUtp02Mxx0Ajfph64vpXldo1bfawyNEnVrPQo893tWyXMsSzSo+4Xp+0xx5Z4duRUyNdGHb4jW5Rhk7DvmyOQGzKNdhO5lvag5/LM9noSRVZML06O6UQ8SUzcI7zlJ+SxwhuOEt0EpXHfHrHXsbtxxanEHnlRh9dHtF3OQ4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105852; c=relaxed/simple;
	bh=2aqPuaQcktVNpiy3IjCIIGpbqwcR7J6YOFv4WcRn2yI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwP2rMdf/8F5QWYMukPPUYPzYmLnjwm7et0hVLwuVUTRMQNYk6RJpi9mcXCfGFQ7I7e/NzlFhLUc87WFE/5+bEamqJh4s5tV6nkSHXwAppXIEE9OYEc3WCIZvCdA/oolRaYTWQyx9+ElRaUnGBQQC5G6eZUKNi2Y/orM25BKVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmZtepuO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmZtepuO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso4436864a91.2
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105850; x=1781710650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3DYTRaj5o9JX7HjN2WJvEbzJSwnxUVlbxBFf+VFy4A=;
        b=FmZtepuOswrQk37r+sDyaxsMzgCfm3MBK3/LL+G+cEHpKov988MRqs6hEKMyvFt0TD
         0/oI0n3n43+DiJcKTj0cQ/tTNJ3Jh2KmpcOzrOQbJeoVPf2fdr+kBUbL/oN+B1RjvlRS
         bBo/xBnw0CnQNFHjTc/nha0ipCvp1zn50e3kEJxb/B+YqkVBCmQCk9EdDyAxOCN4ZEvF
         xxjAYKbGolVL+8cofTefZfQAClXHHULO0i+GDdMsrHzHiJf9Vq+U16PBePEw1wKHltLv
         5grcpurW+t3SNNaEvOq4i8EIHAwPeWclYmmJ0a6xN2hGXfHZ5UpPt1wIen2A9TK53BQB
         lOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105850; x=1781710650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3DYTRaj5o9JX7HjN2WJvEbzJSwnxUVlbxBFf+VFy4A=;
        b=k7UuXRBBKEPvz10Gl/JBPm8nQpJCsx0KPAqZe4ULJ6JXl1bjs5+luCsoQFOau8T5fI
         hwokB/N6zCtCqZsjfkPe9QLfQY4sWwg+/C2VNlq1Obsi74nnm2oDmTbxXy3N064np41W
         iQcS3A80K9NN+i2cfuRdKn+Lic0a5taUHV3EZDtksJ3wTlixAnQqpy407zBWZE3xCD4B
         0Ymf+sQa4EJxvLtT9NjogVHt/FrwSq4Aq5reCWc7nvZcTVTNeGp2eUPxNYmtpI0TB35J
         mxEXWFklBcSiKEWs8MFLlnCsrR6oNuydtYAHFU7EgDtO1tH4WC0JDNI7A28C0P87/MmO
         b+cQ==
X-Gm-Message-State: AOJu0Yxi+WeiDdt+141hFqrrIlPW58CNOvJDglZgD7On3vXb5i5macqp
	KGkVH2ZesAfWo/gzui/XRqdDzErYTdG0c/MhCp2m6y+jwpW4wDWhoH92
X-Gm-Gg: Acq92OHadUCZ/KVYE1LJ7dvrHfUFPKiqYK8fCjOcjotJJbG1p8vXhZL7ro0iWmvQMk4
	uLGh0d7NkfbMZ9SOxc1XQzAgLJU5SlpHRsDlBlPWoPe+xXia+iL3UfIxJOsS0w0btZ+LM2Ch1C0
	3kkRVRE9hiNinpfUUiIjvblX5oAEkn8iAIYYH/a5SjcCNJrl3CQiYNnSESE/L54N8pb2ext5eKz
	2+Bg72ocHGrWUZu807nH+QwpBPo/v5puIUgo82GAAVKDunHcAqkVh4aoKI880rRpbRZVt1igVtg
	3DfqMzTjlldg6o0VvxMOky0G2acZQCx7I9jCKYF/Dq1bqOfIS4MrRol/lWZ28Ci/7EYXHfvlLrv
	p1oK02TxFieTLQeeN0L2ZmL4eSrMdgeHvyYTMvtePmlscz8pL+aagknCiDTjRD4W/aT3r8sImKv
	UXIExl66bWmjSP4+nzOon+kQ5Z8NxCgAS09MTLLVxF2okswxCTUPau4AjuJ1c=
X-Received: by 2002:a17:90b:3a46:b0:36d:7a76:827b with SMTP id 98e67ed59e1d1-370f0095b48mr28959386a91.14.1781105849749;
        Wed, 10 Jun 2026 08:37:29 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:29 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:05 +0530
Subject: [PATCH v2 4/7] iio: light: hid-sensor-prox: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-4-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index edc9274a2c07..9059f00f0ced 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -166,7 +166,7 @@ static const struct iio_info prox_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -183,7 +183,7 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {

-- 
2.34.1

