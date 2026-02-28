Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B58430B90
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309043; cv=none; b=BT9VO+2zWcrfMzJh7s1qZNIYlW4gcx2fxTaG9ki6o6jipeWPOiO4Vuk4Ye/k6Vn2AdPdlMyv405sudUXYL6QYT4TbjOaP+TaUuCEyl8qKD86FcThV7dJIRh+5TfeW+gv2GQpRKnzDwh6Fj0Z8s6vmsZHbTaWmgJrgG5RCEWyr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309043; c=relaxed/simple;
	bh=Tml8NSuUzi1rxzSKD4vwjG6v9vlm4oP2bm1Xe5cL5IA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dCoWjP7tlRjgxAuUiVc2ePIZWTW9t78mpcZyx6+1pAGGux7Sg4paaASvOdKI175g4zzP9YVZOj+NfEGzKRbCJSnfpy6VM/CTKmpWl6dD+o3nt0YQ16KKGTl0oflhoiCFCdpPgvxsELYt4a1P55RGxG0jCFHYQy8/T7v7sgBATMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gwHIghQV; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gwHIghQV"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-464ba2bb3aeso2262522b6e.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772309041; x=1772913841; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/zft2uTLV6nJnLwPmbv0LSJma9hhFD05ECXQxkCKDw=;
        b=gwHIghQVws6mRYZyVw4VWdrX4D4jr0dKTFXDfOVA53X/p45U1nNEBCVgNS29W5wej7
         HVPrAPR9PQsnc9oymHubkB+5mnV+3HAd7m771Dg/ljpyJ726UCA4LS+hfMH8yVqnmBtB
         R1awszPuW2qkXDL/DDnu9wnY+u+ZG4MwPdZ9vRBtPfjjKPprdlM53meA4QFOCAytSpMY
         IBlJcwcY5CCxgySKvr3TW5H8utNEe/MouVlCcoGdNs00MFeF3LcWDwUuwiz+11kmlVOn
         l7Gp0C1s1klO/2H/eArbc1laTAn1ybhJXntw6O6MqdLWKerz1P/6bISTclmHWZSrwmPE
         tMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309041; x=1772913841;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/zft2uTLV6nJnLwPmbv0LSJma9hhFD05ECXQxkCKDw=;
        b=Fu9jgWC9n7FewmQ9bs6XHL3fPFl/JvLpgLrSBQwrx9T5bcSiPZjem3r8rUHIa2eDlc
         s+41YlHZB0H2bfk+ec8Jzq6r1TE6pEEuaMWbOnJWnxy+scHsEhgOexrbcNN7VpV4N67Y
         AcdetbH6pzIN7JaAHC1lyvVqRnLKcb9dwtuI1a+JznFpAuzSFCvLvSdTu21dVnXzmnDx
         GPhH5YJ5eQblUEFFabIt+KaEas229YTo0zCDl1GG2oaoUwEzyD4wPxE02ZBOxEUKDmgf
         ROFIwNjzVwSNYcsum/bZnW8PhrjozC+7OTBjxoBS6G6cph6qk0YrX6Faj9/U9gmi0+K2
         rIjw==
X-Forwarded-Encrypted: i=1; AJvYcCXUuC57IfjUqXtXSCiNand7+KewVZAoYEdpLyX52q2NdndGJNeAB6Qvj+ATqUdwSydCcu7eG6d4UVIKdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeF56hGCr4VgFZ5h6y7YyFCaaspHlk0vD3IvgejVAQXKh4mKt
	q/sj8Qp/OYS20jDhl3gwYguB8yhfRV5RLzqoQHBT0yF8dRQpVzDTFodMpofNWN7tbHmWE2p2L8o
	8dxVa
X-Gm-Gg: ATEYQzzMvGT5msdQvcJ/lRaBoV8cVhPiQ+IUA+PCa0UswiizZyeH468qciM64faLA6S
	8ohURnr+Lsylty2xzsGmgkkD+kBcaRO0n4FUzApOPXDThyx9NrPvygjpJQLbAEjQswV+fnzQmgw
	aCfFBX3ryEeU7efE/gYlxAebQL++8x0L6smZH9Jg1reRot0mhb9TvWflyGeBe1UBdLDxuTfZQt/
	dgvFXibn2+lupflCiX7mD9GR9BgeYQ/uRNNYjvx34rCqFdEsum8sHobZvf68rkSIWtcmRYdRmXH
	kzUgzx8KiDuir5m+RD1+rLPlhm3wKfqOW5O8VLwoaeL/curUiObzVdKkOT8DN/11Z075KS6tIZL
	KxNwO15sTIGQxFTkXPPRYC/nMKoNiXK7ZMi8B2zWw1GnYuaZIhciY/mvtPX1bIWXfGX4orGIG8i
	pfrOGCEbpsZeNzdz+EGMBv9l4fBaP+
X-Received: by 2002:a05:6808:170f:b0:45c:7aef:621d with SMTP id 5614622812f47-464a5eab3demr5376938b6e.23.1772309040821;
        Sat, 28 Feb 2026 12:04:00 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm7579785fac.20.2026.02.28.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:04:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Date: Sat, 28 Feb 2026 14:02:21 -0600
Message-Id: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZhpBUFW3sOwKHWASaAlLSESw
 t2tnMDl+/n//R0iB+EIdbZD4FWieJdAXzKwg3E9o7wTgyZ9J61yFPHYyQcDz2wWNKP0bmK3YFE
 WrbZED9YFpPkcOPVO9atJPEhcfNjOp1X90j+kq0LCvOxI6aqyFd2erdlGaQNfrZ+gOY7jCwlc7
 XTDAAAA
X-Change-ID: 20260214-iio-fix-repeat-alignment-575b2c009e25
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Tml8NSuUzi1rxzSKD4vwjG6v9vlm4oP2bm1Xe5cL5IA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpo0oaPCYrXh9Je6cQGJH9OHltDO9OjDkom0XVf
 qEw9jbcb2WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaNKGgAKCRDCzCAB/wGP
 wGkJB/41MEvdIRHOjO68oSGJZOLI8NLvmV63HIzlXl/dZqK2JefZ25odqLJHxctd2GyYBFwRFjS
 YfGZgcyFBOScz2ErEv5YZ+EgR6sBUhj36a1bepS5bH8nrolvEsEkfnXc8wJaexMeDLEYLRnZmk+
 7IJ685jfHLhsqn7OtJM6NgmQ2g0caAwRJOYCjW62x610G9ub0lIcokbkcpAeeEzwzd1AJTp3b2A
 Ahgsd5t9p4iK3303V5xh9TmbnlxA6RjtehEpWEPMuyDIKWOBpyuEBTWTIpc2u52y9yVh83oukon
 brLUWeWg92I0aYxNlEIzcTIn4CFzeH8POZ5xIyNlqQ7yGi8L
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main point of this series is to fix a regression reported in
hid-sensor-rotation where the alignment of the quaternion field in the
data was inadvertently changed from 16 bytes to 8 bytes. This is an
unusually case (one of only 2 in the kernel) where the .repeat field of
struct iio_scan_type is used and we have such a requirement. (The other
case uses u16 instead of u32, so it wasn't affected.)

To make the reason for the alignment more explicit to future readers,
we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
array with proper alignment. This is meant to follow the pattern of
the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Rename IIO_DECLARE_REPEATED_ELEMENT() to IIO_DECLARE_QUATERNION().
- Link to v1: https://lore.kernel.org/r/20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com

---
David Lechner (2):
      iio: add IIO_DECLARE_QUATERNION() macro
      iio: orientation: hid-sensor-rotation: fix quaternion alignment

 drivers/iio/orientation/hid-sensor-rotation.c |  2 +-
 include/linux/iio/iio.h                       | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

