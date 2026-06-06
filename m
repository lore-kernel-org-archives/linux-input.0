Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EE370ADE
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748277; cv=none; b=SldKasVGywTvrZxdJLtmLbGkD4Xcrgw4Puj1XIenAT0/XNB4WpFz59tQS8PJX1B8uV/Ji9cC3TISQqbz7Ova9dQl6CrNdEYrdWPrc67P4s4gIuce0PdH8GOzEifGY1df1o0vFIhjoJnYxrjhJQecqCCCuK36NCKym+ztxBJ492g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748277; c=relaxed/simple;
	bh=4Mb2sE0t5VHj8KrN5qm/La79m5mR/fH48E1nduC3sqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uVAIUBERedX4m7kQ0uqWXsBQVu4ultiEW1mKg7HgE5qrUZqlDaULRXXfW/CCOtgaDNJS8Rm4Qv++OaTW7jFw6NRDn9GW4Wzz0AGbUtAcuicpoxdmLYQYR+251c6OEofLrUBjIc7W0cP0fWkHgvtrblR2tnlG/seu4t6JyBQHNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvXscF4c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvXscF4c"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8422f395a4aso1736948b3a.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748275; x=1781353075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciD6JDfZME6lggXRo7tdfg+t9RkhDLMdFtncMXFS9nI=;
        b=qvXscF4c5k58FWYTC9F/6uyszlJhRI3Ar/wJ7diMJxipgsgGfiGsWumsPltmax4UHk
         14tGAUZSOyuxerYows+S8X5zFjlRrkcx7jq71n084QEYEiAbt07Iip/k1a90hB+Vq0Rq
         VQe6F9zzVxuAn52LaidRus0+egs8KtSL2FyG3lHUzEZcuqk52OXEgS+ts0+9Cfxggmqd
         tM6xLoDXTmffEpW+HzoqbmoeJeuqpNuTJA9MHguljsw3JLoscycONvwN4Pm8h4qCnrBt
         oa7P5ecMOzFoOVFP3dH6kZtw396w0c/Qq9xeIakZ43PAHx3x8JhjVXkycXhB8CUiXl8r
         6njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748275; x=1781353075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciD6JDfZME6lggXRo7tdfg+t9RkhDLMdFtncMXFS9nI=;
        b=rFDmT/CV3cxjagQV+7J0CgdOK8OQZDL0j8RyGZY1rZfi5oYusJMV2qPlXE0ITk/zQ7
         d8xVG8KHMR0uUTg1KVMKAoRLTqOLGLvJpkVspIIpeUbop4DJ5XBgySw3uBN8hkzQ6yx7
         hhRL++BRa9ei6/9UbcWWE0qZJkMzt2CMLrFraxp2x87HuSBZkLog51r5bIIj9BE43xLO
         liAuQl6gZmUBiDCHClmF07VyrKeJ+OhUebq0fVL/W2v7aYxxoAHcQ8dKfY4zuadOknpt
         iK24oV0Ipc1D4qnfODpifeFDCOHN/yNWiANv4Zo7a9UnjByR/RamvBhvpezp4fBrwNsx
         L0Bw==
X-Gm-Message-State: AOJu0YyH0H2atG6BIEn2VQRkOA+QFeJ8gTGYlYqbKuoDx6VVSXJ7KL78
	1H+cl3lIFenymn83+mcA+1TPom9B0Q49UkXjSkt2SXHnHPpZJsrN+LJ0
X-Gm-Gg: Acq92OHETgLw80uSphl1oAWsfizH0FjXmXC7B3r+D1AfaYxEdkGgRSF8sgMTCj8N4RJ
	l7l9YtB0EK4blqxer/oI6qitZANNfJa7X0+uCKG/CocJQxMZgAZESawp4jBSHdgmPqZhwoPa8s6
	0vMpHdZgkzoQNmOn/jRlqwyVlpw7xTPBaA3tPhJsaX/+a1csims4J0jZPy4VE8WRxV+uBipmfs2
	MNI4MZBCAAnZ0IdyLo8rG6kN0GjwItsAtDnQbFXiFAjksnN7/f1g8QgyK7yRYLBAsjwlgXevsIC
	hQ+uwzDfRGdv1v05E9FzLeo6/5LN0DTBs8tDmbXo4eJhwo/EMaH+xWm9eMb0fpIvb+RdA8BTnQ8
	PbnuGiJiveuAJWjymocmSl3/QNIfL9ElG2zoJgtOfmQEbBFql8qglbtFZHADTSDg0B7rBPMjhwk
	Tsvd+rUqBBLs0BcHMyJVZ/9Ad7SM/RcPNBztlakjr/T5EhrMiNbyf9an4TJG8=
X-Received: by 2002:a05:6a00:4c1b:b0:834:e24c:3f9c with SMTP id d2e1a72fcca58-842b67657a4mr5631697b3a.22.1780748275139;
        Sat, 06 Jun 2026 05:17:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:17:54 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 0/7] HID: iio: basic clean up for usage_id
Date: Sat, 06 Jun 2026 17:47:41 +0530
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUPJGoC/yWNwQqDQAxEf0VybmBdqKK/UnpwY6rxsFuSbimI/
 97UMqcHM292MFZhg7HZQfktJiU7tJcGaJ3ywiizM8QQu+DBDreaGVeZUaQgFVWmF1abzi5ee+I
 hUmpDTOCWp/JDPufD7f5nq2nzzU8Lx/EF4Yi0wIMAAAA=
X-Change-ID: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

This series updates all HID IIO drivers to use 'u32' instead of
bare 'unsigned' for the usage_id parameter.

This improves type clarity and ensures consistency with kernel
coding style, as HID usage IDs are defined as 32-bit values.

No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

---
Sanjay Chitroda (7):
      iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
      iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
      iio: light: hid-sensor-als: use u32 instead of unsigned
      iio: light: hid-sensor-prox: use u32 instead of unsigned
      iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
      iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
      iio: pressure: hid-sensor-press: use u32 instead of unsigned

 drivers/iio/accel/hid-sensor-accel-3d.c       | 6 +++---
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 6 +++---
 drivers/iio/light/hid-sensor-als.c            | 6 +++---
 drivers/iio/light/hid-sensor-prox.c           | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 6 +++---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 drivers/iio/pressure/hid-sensor-press.c       | 6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20260606-6-june-hid-iio-correct-usage-id-57ce92cb102b

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

