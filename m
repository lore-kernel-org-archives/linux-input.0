Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F038F645
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425304; cv=none; b=ob2p5KTsIkR8OBTGQSXLXaaTS7YOexLSWCb2EBbjka40eTMi9HI3eetxTsfpbfXLOoSuilqW6MMNeTILiBGPzEypRqeSfL4FVaBZpbPQDlpvuGcG/KuBqjV+NjyjSvELpWdh0ApORqbkATfb1X3X/Dp6x0iKa4NH/ljD5s+b69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425304; c=relaxed/simple;
	bh=36W6yJDWLIth+tUseXKkzXolAUxka7O34Ksz1lKW9Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLwXpn6tOnp9dpPQrr04xnde6rNpaL00BQivUgK6sqtqZML+MCxTZr7xIVvbqaEQPwdXJhOU/qMRmqxdJ+W2BeqGtgM3JIN9lB012Q63IRjE1/CLsbu5dn8xRSo8uugxCgUr992atLRCwkGNmtHiunjc0WfCEJv8/YJArkSC6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3Z/s0zV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Z/s0zV"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b941762394aso84252066b.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776425301; x=1777030101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uNWB3DvmF873bNYVv5qFQjmGY5lb9eWysb+QqY8hMw=;
        b=M3Z/s0zVWMzdG6KqkMUcPyCdvyRrb71PHImf1UhkUFko5x+8xDQHmham/k0d16vpD1
         WxH5bHgZ2N1CBAUQmdhXy4F0UemUx7fwnXWDVEf5gk4Ev50um9gLjPzW7r+SIcahM5hS
         K5ce3l83VPGTZyIuWEUGyv+biEDV9SX26+t0D5Goj4vOZ1CpzZ3UkIkdwxjQxloFoMeO
         UW74LSscwkX/wqkoMkpF4moJDIfLK+qvFf8Ak9HY+pCrzAxy/9cAEGOkDFAI26PrgVyp
         Nmv4HPnxcr6tq+CjLiggWxUAGquKX/eYkk7+zAfOB9iUoyys/1mq1m/Wo8ITz79GUL/p
         bIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425301; x=1777030101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uNWB3DvmF873bNYVv5qFQjmGY5lb9eWysb+QqY8hMw=;
        b=c7EeT9/7C5lM+TXkd19WhV8su655wkQ+k6M0REQrLc4i0JLf2cfsBmtW4dzzzSZdD0
         GhPtlr4IjNY2fxWxIfFIW6uN/aqI/+9fyhGMA/JJJ68yMXTsWigogfIHEqvfvNnxZlys
         /q6FXdem5glK6lKwObpdNT+78E7kIEW56hFFlAWYCMYSDVhTeqh4vSDSbZq6Ganr/PDT
         M4NizsmizqOaBoES/RdnLLRKvib9k7riNBsguWeVIa4Qx5FKaEdtYRvQaTA1VUcDNYLA
         eDNlAFleCKP1mB1ds4nDgG3ydBP0vl9ixaTu7tsNwvzue05i+HcL+MPnKCQdD8KT0j+p
         Pxpw==
X-Forwarded-Encrypted: i=1; AFNElJ9lvcyosZk1e+vHRE+oineucHlbuft6XbTVeTcNADe9pO9dGTlrAJLYPS/t9sFWyNIPFWVG1sV7g32BCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqo5N2lzY2MevmjaLx1gWfpjgfEXf4ov/EcaoCwk3+AcnHq0v
	s7YnYnXXZ1rE6LAB1wrAVfxE/ZGVHl71WT45AL33ArjeclnX4k+XXcBX
X-Gm-Gg: AeBDievlNPW76GySFKymYojRD4uV2HRBcXidBLAipGfS1Bw5DLZmM5ZTsorY3mOn3tM
	iZGzyOCClqTELi0G8KmPSTHQcdbq8ll8BRjAyyoxaCFrZEXyWPptsvbh/pSnnUm7UMzGhoUYESP
	GwZmH/H3VgVHD34D5DX73KJ1//UUj6uTMrhjcYjcP2bDl6mnk50t9DK1ttnxuIlL0Ie++cljld7
	R5/Q5px01hbAV601Sa2fan2sPdvaTS3D4ZNBOfPOdxEUL5Rc0wXmKCj0w9AhvSLdG2Kmr51/nvj
	/l6+dD1VPtqloaXx2kmNGVfWgDV3nzXAIiltzgqjnWlUyUWMJ5whvp3oX7BAifzTjM1Kj0U730u
	gLBnowid7ZGU5TrTHoGAlOSAjAUSByH/0HCqHfpx2oAHt5eoXXf6aSTFVhjJVrfRN9hW8UAmaza
	uvti4hDkXr45prTl46Zklj4dsTkHB2ROAGCDP/kHPXRylKeIbZK4cFiLUvwsMmaMLDmvf28J6Oj
	y/FS1lp9x0DsTuGDr+zn+tPTxdOmde5Ioa5My93y1FZ8N7Q9e09zfXcSsWhWeVJzwSLR8ztb1tn
	GiETOlWDeQN9m0+oOBS5LqEGHaH8UaXvbnMNHHKK7anrqxgLZgE8I19H1fUnXRr0iuqhZtQKpt1
	a04GWI22yfwyvf3KuovGgqKauzVDQArg/oJXk0ZEN7xozzUUPcqI8LAqkcYw7GqH/U8AkgcSxVu
	0ug92NfBASqYCH
X-Received: by 2002:a17:907:e989:b0:b9c:b808:4617 with SMTP id a640c23a62f3a-ba4188822acmr136165766b.7.1776425300954;
        Fri, 17 Apr 2026 04:28:20 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (100.61.7.34.bc.googleusercontent.com. [34.7.61.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455046429sm45363466b.50.2026.04.17.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:28:20 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
Date: Fri, 17 Apr 2026 11:28:08 +0000
Message-ID: <20260417112808.1280-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'unsigned int' instead of bare 'unsigned' to resolve checkpatch.pl
warnings and adhere to kernel coding style.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e..67550f16a9 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				unsigned int usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.47.3

