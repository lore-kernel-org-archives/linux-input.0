Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA2329C57
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616333; cv=none; b=AhXpgKm0vyujewmHp6BegUBjvTelLaXBoG1kjk3uXixbGd3eV9vel0+uAoYJWGVJ3EXky1s0MLXLZxYox+2u6vQmVSBJxVDOPh6UerghpdgdlWt250DPPlVJbxF/2djMwUedy8TNr50jWmdrgtdkhEj344orZvhPKu3O/6Y7gBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616333; c=relaxed/simple;
	bh=/DhHLMxtax0q61L7+CS/qIAzA9d13fjEx2Ew5GW+K4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gx01FTXo6MidHkwsKGXjdR5nF/WAcnBsfjIleKddxqMPvv8nq8ZQEEWLgFPoA8GkoUlq28ZS9xammEaMjtwRiJxGv9r3etLujjbSBJuerVZGoSvTbpTrH+IkRiytPOBqDNUPxVU46UUlFSu3ujkGJYc5OhExvkgY7YIAaZE9pDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNqs00+n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNqs00+n"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84229481d44so2261589b3a.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616332; x=1782221132; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpRajPh6PjOiqYjGPArNVmTipWmAREJJTLFKHMT2x0g=;
        b=kNqs00+nXc7u4etMTuLiSu8UgmUz7klvaHAVEz9i54WViThAtAQnuCKWRDsK82fV1E
         uiGa8BNWKEDI8FlVnAl4FwNmrdJnkGHkhDKKnk14roo6niZ1esqhEdg1AdEliutOiGMI
         x6nNVdElgc1J19W5kKPCXrdlnw2/1ViTsu4ALv5ljIMbeEc6JvYC4+7dHw4kDRN5BroM
         yckvCUOL2F+0H5kTlvSmlMKiyqWPv4GZVUnsA11E6GBu6kUMviCax7MV7Qdj4V53t/W7
         VHlLyWIAppQOvxwSu/f273Qe5KG6Jvr0bVdllVbT64LcL/j/wYOKE0/IPSE1+BdYsWmV
         6dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616332; x=1782221132;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpRajPh6PjOiqYjGPArNVmTipWmAREJJTLFKHMT2x0g=;
        b=UHROt3X6rSqqO07f/mKIL2BA45Mq/9SIkQiTh4rdtrFHAmos4/daVszjqfxaQ975Ib
         gnaRk4+FECaw1yVr4JRIDEdLIpx/73g55fxNxJY+L2HkCJhzk8EHMA7YaTM3XlezXds+
         BCzLY7l0kUFfcS0VuXp+2kTPWNYIUDYcXXQ5+ZXA80YDXVDtMAgjxAjroUOpGTE1Rxun
         TusDBYIV07XTsX5B+IbxaG7vAcbRjRORda2cnk+77pcEsBxCw8Xxx4B5GefrTJ1Q0KXI
         1VvKjTgJ379XHpQj0ByMaHbAgusquP9BrMqV+pRRDoCQfkDf4zZPrlG0e5KZMf6+Nqtb
         YXpg==
X-Gm-Message-State: AOJu0YwjCby3XfON77OyFxVMl/rfTJcc0YpOdI0p46AjY6+mGtJyKofs
	MssGPQ6CJXvXEfK5kb9KsqfJq7CmFNOxXTWXaWmRTD6nDIdbU3YH3luY1T2naw==
X-Gm-Gg: Acq92OGEY9EC6MKG/SBIkEoxWwJncU1fH/jnhqGoLgWSgshX4XqLUkHlUSEVmqgUR9w
	0mC/CEfivZfcottJK103iF8rWrCkF2ucIuvChzfjuY1e75a6j3cPqa/SMCQjZunKmB2Jw5gyFNR
	9EFg2vH9nWTxiKfSDiftJvGpQMrulH/lVv0iJbHNsddIv2xd4am8C+N/M43YuyDTleqFdPPTrZR
	b3mcfg1abTl2bXmgVno0ZzYy3m9X5avMG0rS+9QSiBOQWpx/2SNWVtMvtA9Qh/nYG1C5x3Syzrk
	Q2E5vwbwTFM4E1VkB0xRVobR6fay4ICnfU0Y/Y+U0L2EQGOKNU1hZ49/I8rPXRXP8AO2y2JjN1i
	r3+UZdCe1nlkXRD8j1N7qM/n+REB/Vt8xFDXmVm2ZwALvTa1poeZXGDrrnCgb3EY9RfpMjUGCAD
	Dxhr3X5cSGbdVrE3MPJhWhLph4EOyR/MlzQTvajgbZgLJYz2Eh
X-Received: by 2002:a05:6a00:a903:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-844e1aa26d5mr17296039b3a.41.1781616331963;
        Tue, 16 Jun 2026 06:25:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:31 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 0/3] HID: iio: callback API signature match for usage_id
Date: Tue, 16 Jun 2026 18:55:19 +0530
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9OMWoC/yXMQQqDMBBG4avIrDuQREilVyldaBzr7yKGxIgi3
 r2pwtt8m3dQkghJ9KoOirIiYfYF+lGRG1v/FUZfTEYZq6y2XJqy5xE9AzPn2nAbwMsehHWjpBl
 UZ1z9pHIIUQZs1/39uZ1yN4lb/ks6zx8FkVEhfwAAAA==
X-Change-ID: 20260616-16-jun-hid-iio-u32-api-type-180e8f0b2c37
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

Most of HID IIO driver has correct 'u32' type of usage_id with
https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/
series which is applied on iio/testing branch.

On top of the same, this series updates remaining HID IIO drivers
to use 'u32' for the usage_id parameter.

Pending list of HID IIO drivers are extracted with command line:
find drivers/iio/ -type f -name "*hid*" | xargs grep -A 5 static | \
    grep -E -A 5 "_proc_event\(|_capture_sample\(|_parse_report\(" --color | \
    grep usage_id

This matches expected callback API type as HID usage IDs are
defined as 32-bit values.

No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Sanjay Chitroda (3):
      iio: hid-sensor-temperature: use u32 instead of unsigned int
      iio: hid-sensor-humidity: use u32 instead of unsigned int
      iio: hid-sensor-custom-intel-hinge: use u32 instead of unsigned int

 drivers/iio/humidity/hid-sensor-humidity.c           | 6 +++---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 6 +++---
 drivers/iio/temperature/hid-sensor-temperature.c     | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260616-16-jun-hid-iio-u32-api-type-180e8f0b2c37

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

