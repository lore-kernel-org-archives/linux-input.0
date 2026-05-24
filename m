Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1D30C172
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650473; cv=none; b=EAsqAVb/FnYfBwvmq1MV6yDw5E5COAx1N0wp1etK0HEsbIngRyZV/yTYHiC6vXBisgEybHbfNgLe4OsUb+Rjkd9uRo9EhK5gNtKoxwGaanq4ssZfztl5OGMSeTokHV1Pz21gTBlIaece2G0H4KMa9Xpl+Z3g4JVTuHPhdaqeDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650473; c=relaxed/simple;
	bh=MynwvAXISlN6FBbplJ3MtRw713eym2MlQlYrB5xEx14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QamCLuq1+roe2yQc+jGopswjjA1dBwgwAGe62b7LuW7vFPY0kJfDOyL6sBn7bHWCckcPLexBbzUUHeSUEEKrN9mDi9dL4KlXzDT8K8VhVeunKPp5r+xOP+vYqVrSq1wUrKdSxhZhwZxFFaIqbKLHyXgQ2KuYE+rW+EfT3SPwtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUZVe9FI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUZVe9FI"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so2913798b3a.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650472; x=1780255272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4fJxXzGfStgadHssCMhfgcT9RTwK+beGIJZOOpamdI=;
        b=HUZVe9FIVmiLXmVA3QmHAMvAWv3FJ6UYgtDkuiclwjeukUiE4EYtAHr+B+QyMZv0jw
         mIE1FDtJoVPvG/0W5kbB6ySbPr9TK4YWNL6XLIUPsrQQGZoIj77qmYAUrfeQtGpDeJte
         bImUMAnxE26mZiuQTfDi840zw7/eHT3AkU75tUGkO7nEBtOf12gms4WCJmiCMlq2FXSy
         QG/U+SWWZCsbAmL8gwLxvCejmfQczeuZH9s3KUgr23OHRrHsy3Qaf+4i+FQwckc/NJuJ
         9i4v2kHqJwUlJe9nAPugccpVdNv7KAb7RNPrNPVcOop7q5VBmPALzQ1hgneVpi3vcCEX
         wePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650472; x=1780255272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4fJxXzGfStgadHssCMhfgcT9RTwK+beGIJZOOpamdI=;
        b=jcO5JfjoYbyS/f6SvlTgzUf48aVp+5qlipkIx9iAbI2c8EJ6I+HpbSN8aNDxB/1iUX
         Saqpgk9RCM3q3D6U12P8m8D2LK8YpSohXFCg2VjWiVTmIql+ULvGnaUejghRVsevDvls
         zGFKcL2oimu8sP7z6K8MBwWWcsxUQjOu4vvVxjTyCmJBAge9Su5N64MtrCF+YcvFNnpX
         FAy+pW5PS6/C6ZsYHdA8sszazknkTTAdCrL2dbplnaBmF6mERoif/rj+EtdG5fuiX0Kz
         pONOKMv6td3IovVxthuzKQMqC94jMzDMBinitAYJmD4mUPjoinStlC3jQRHkm93PLwiQ
         wWPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PMZq5rhVkIOlq8P7+x45Unspr7W2m2UrsZ3xhGIhrHeP5LeSUGtVOJk0yyYVwv9nQz6fiVx+nmwXzqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gvLQefzBrwMdTKEK3Loe9BOKbbZa/RLa0f26EQUKnWOCyzmG
	4ytrt4ayrw602D5Vtw6T7b/GW62iy/yrkLD+Bxrw7aLH3I2LWE/ouJqY
X-Gm-Gg: Acq92OEm+VqSmFsgDmlyjoamC+d3AenBtQ9+CfveBSuoSU0WAXJb2HTFc+aDsUu6TaE
	ef2rXYSwqB++e+HxR0W21yM4PDTbnfQ7M0MP+ErvlWzpG3Fd73+ZIy9k0/9NjtefdFYHtwR/X8N
	erHxlVXrcX/oCc5K9SL39YN7q+Fgs67zfTwpXdwzWpzWTldi+EQ1SAPhO+qQ+DTE+JRT3RRPtbo
	f3e/T0m7h2ygCn78IhrpTfpJoYZFL923rbSahfGLNj+iYgam01dRXOr3gjNQCYdOhK4CenwNZYU
	Ouu1M/+A8jm5+SrWVi+aVsh7/uMAM7IcbdFw6FGqu6eDEi+1fW5m7K3r+Y9z/PHiqAHcgnLM4su
	FhyDdbXvPWbrbMEfndE7rStzo0l575SNm6nB4WTKml2QC+vZ2lDSk86XgRmQWlcCy4pHEEDOur1
	/VO9m828fB7sX+9jXzzw6v5+h9nvsYMF3I5X4ZmWV54EY3Nl+NAemU+73rEw8=
X-Received: by 2002:a05:6a00:8885:20b0:841:89a4:5f86 with SMTP id d2e1a72fcca58-84189a4702dmr2748311b3a.21.1779650471941;
        Sun, 24 May 2026 12:21:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:11 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/36] iio: hid-sensors: add missing blank line after declarations
Date: Mon, 25 May 2026 00:50:24 +0530
Message-Id: <20260524192059.1193716-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Add a blank line after variable declarations to improve
readability and align with kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v4:
- Rectify commit message with input from David
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..c8ccf96f3d03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 
-- 
2.34.1

