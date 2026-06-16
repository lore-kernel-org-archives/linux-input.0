Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E4428852
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605595; cv=none; b=IrlyjwQ348ssLKWLumoDgM5WwantcgW3Yzx2rOckjVIAdsBE5hShsCgURZXHAOfUj7brYgmz1xDVA/7yauBXEZIzmlYvQ7X3bd2o16hGSCRyFzTWBWSr3bY4/r6x0C+Iep9qNw3dnvXDuGLwuFrsTtdly6kx3PHIuErD5/glT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605595; c=relaxed/simple;
	bh=Qfz8+6Uu78GANnk+XXmC1yVoBt4uyAv8DDRBtb1jN/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qSVbJrkzrYx4PEh0hexU5SC91hbQle2Y7IxJBLnK+iHrbOXNTgxmbvBUHiV2cmF+cy0bpZwRMUkppShHDczhAxnDG3AvEc6CWIofkaFG/oFOSfbGzABFmRjaT2hanA9Nbvb1J6t26I7qd8rxd3pcjApRl3jyKCunoF+JbJEbYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZHuY4+G; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZHuY4+G"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b900f350fso3970445a91.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605593; x=1782210393; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjOTgU/R9Q6waNYMRI2IpAW/+oeT0LDKFANpc77mFxQ=;
        b=hZHuY4+GXN+UYsCTkFA03mj4t8870XlAgniD8zGl3tH0B1zBcf1zSq/T7QXxZFrqax
         YX5dKyvpe5p8mOLXda6HkBI0AkR1dEubcsm/6BQEBgIpES6kQzU+nAhlhCNJDdkr8VLg
         pPxWHzdo/EJdxALI9sWcARSH8/Qed8NTCFdmbQu9sLj+aVWgVuJEtg/hy8ySieJFK+0Z
         aLs6msHydhbcEEbcgi3DS4CP255x7SvIJJe9eexFSr9UAOTDv0eqcNTbSrm/TUjTsrbX
         KfF46Yc4fFdiDsY3/I3rO5Eh5eQORU+xe47FgSkePpSa1Uil0km/qXjQEVoSVwOgRBT4
         6ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605593; x=1782210393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjOTgU/R9Q6waNYMRI2IpAW/+oeT0LDKFANpc77mFxQ=;
        b=lHg1x8n4hGVZiEcQ1OioWAmiRqRPouK51nNVnZoVoF1P2dtl/TuARCbHHO/iJ6WJhQ
         xiwgaXN6u0QYnnwFj+Bizm0E5hPSo8+h1IEJ6w5ykr6ZdOn2oCM3W3nNPjVwYRwZTUns
         CyCtZtffnsJ4YaGuQO3ByjqZiO2Ce5CLTlKIgvvq9xshcCMJX1CMZYhALl+R9AQpbqRb
         brhQQnVLRkQEG5F7UgZKp4B/nVOnwpfuBNKCZn9++dw3S3yWpd3BbrcIg2MTfKGclf+f
         dNSoAnXjfn46EjPsNhMVtT5gE1Qo7RrdN3VG2k2+pRR5xNjnSNFRWAb3uaF7aGJsRfYu
         CGXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KfCSv/dpHUuHj4uJPEuv7f1vb6zHCJRdxhaDgePkjBhNS36vM7u4XMHJbBvxiMcile9aQ2nuM+Jw4pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDONJlTemV50iqBiyIPQgdlWsnIrXp1CHfhhCxXKj917pi6FA
	UgeGLC9limf18Jm3kHsIrOqJtahEcfhyDNb4LiF447Am7rJIk9BnVuMK
X-Gm-Gg: Acq92OHm2Jw3ZP/tPCzEBy685MgtxPHJikB/2ZzXspb/jnD4WaXOS/Ung5jtOPRLzHJ
	IRaFqgQpL0n4Ddma5LGx0whoKgPU2Z3YDHmktMaspCIEVSJTefkMtLP5wKkHY8wnp1G/zjNIkWC
	Fi1jqCB34Y3wC8Rxd9TiSfIUTTljRoFeDMnBfecqVVq7IBdnqO+SLbn+hnRKDQ3JkNaQtO7zRZg
	v2e0OtRHtODfBJck8UgqkGBY7ysZbmoxLUKRPmfXUEwFaQaMAmov3vrOOKBcKA13zvGLFvzqHa9
	Q1LxvejjgkQJ5hS/oPjsSDv0OlunCArfBRoJqekGhqoYvJoevFq+39an9XrmUActeaW864v7qjt
	J235SnktTLNVEZQrXdJhBW4FcGUgHprZr0ySXEwpRVbz+JomtrmDyfIIHi3/tgPxdFMJgc358DE
	+mgLJylrnNdl+BA3a726qCh2cuexh4QKfM09bqbXWYoNZ2HiOB
X-Received: by 2002:a17:90b:53cc:b0:36b:7f69:c152 with SMTP id 98e67ed59e1d1-37c2bd494e7mr15411320a91.18.1781605592598;
        Tue, 16 Jun 2026 03:26:32 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:32 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 00/11] HID: iio: warning clean up and prefer kernel coding
 style
Date: Tue, 16 Jun 2026 15:56:05 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0kMWoC/yXMwQqDMBCE4VeRPXdBUxuxr1J6SHTVEbuWREtBf
 HfTCnP5DvNvFCVAIt2zjYJ8EDFrQnHJqBmc9sJok8nkxua2uHHauCoPaBmY2U3o9SW6cGm9d5W
 pai9XSvd3kA7ff/rxPB1XP0qz/Hq07wcdM36RfAAAAA==
X-Change-ID: 20260615-15-jun-hid-iio-alignment-46bba7279be3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2

Hi all,

This series updates HID IIO drivers to resolve checkpatch and
kernel coding style issue.

This improves readability and follow standard kernel coding style
No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

---
Sanjay Chitroda (11):
      iio: hid-sensors: add missing blank line after declarations
      iio: humidity: hid-sensor-humidity: align parenthesis for readability
      iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
      iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readability
      iio: humidity: hid-sensor-humidity: use common device for devres
      iio: position: hid-sensor-custom-intel-hinge: use common device for devres
      iio: temperature: hid-sensor-temperature: use common device for devres
      iio: hid-sensor-magn-3d: use ! instead of explicit NULL check
      iio: hid-sensor-rotation: use ! instead of explicit NULL check
      iio: hid-sensor-incl-3d: use ! instead of explicit NULL check
      iio: hid-sensor-accel-3d: use ! instead of explicit NULL check

 drivers/iio/accel/hid-sensor-accel-3d.c            |  2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  3 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 58 ++++++++--------
 drivers/iio/humidity/hid-sensor-humidity.c         | 48 ++++++-------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 80 +++++++++++-----------
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  2 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |  2 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |  4 +-
 9 files changed, 102 insertions(+), 99 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260615-15-jun-hid-iio-alignment-46bba7279be3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

