Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B230C37E
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124769; cv=none; b=hP0W3x382Z2LnsUhWT959Az1OR57MXK7tOnouszO2Ok0Ehj5wgxYxemhmb9ROWmtr/8vV2uVHaJRemyuMn4WOk9USOTSTKIi4xsUpzfKXg5ZBteVNapLJGIMeT+tzwGlqIgmRvkPX8w4OfvnANccMaJddI9ot2yMrL6AzxQVI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124769; c=relaxed/simple;
	bh=geq5BT+A0hLULhKJpZ2RxBbwJytNC0jP0k9eCTgnWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqUCHxR4mO7DGcHKdr5O9xNHfjphqoTlR0laDgFCVwJxyUYii99P8VGrdi+3Z/Z9NcmfaOudwdVeY8kan8kXvLENNjckXSxzxdFie5v+XOnIjD373+185CQegwxuoK668Od+88yDWXLDg10+I5YwfFOMPh+f20zBcWm2yf8+f0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELT+9P4p; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELT+9P4p"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so362556241.3
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124767; x=1774729567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjPztHOYpRe/z66XBvAyt9iPj/WVCgBCacwWJUnDs4U=;
        b=ELT+9P4pOVpBHUJa0Y18waeuA5kCOdd/aD8RcWbHKD+qQdcj9QBykRoW+vYVMkJuSa
         3jdSOE+K+gu3fYZEkAneNnSp9DWlDBcFqQHRe2xNuPlVlBsvKqkutJsatJxEHv4Z9y0C
         Q43WwUmadrcf08QGz8/xXgeUD2f8EJn8AhtRp9C/jur8aWdMBvq6Xhw3opBk0TRzO4iY
         hVl9wMsUcZmgvtgxGNpcQJggzpGGCIil+bl4eLqEMr5J3oDvqvTH4Wl/JambSRmak93f
         cxAnhl3ux+5bT9VJGcKMD8s1zawyLWjISGWr4CsS6m3cMZ4Mq1/Kjsrg4nNtBjHPHU9F
         emaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124767; x=1774729567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjPztHOYpRe/z66XBvAyt9iPj/WVCgBCacwWJUnDs4U=;
        b=RF9kpV50oU7FrDRlwrpppruST1wJ9Wpcmwyb0qXdHm/bt1SO5M7A8SdueOv7Sr8QQ9
         4ETfw3QY/qzkBPEwVpeOB2tAfckwB9dgAthgFHdQlhXEWW61Po7VR+3yzTKGfCvSv+7B
         ozAARUQli89gynL7ZBkmkboFBxVLFws33MMLZ7RsEWaqomsxVRcIVR/ZcvkAhXx8g8x0
         cfFTsgGf+Od/FnSfCxS2bsq2nx7VUR9ReI+HKH2YF7+sWEr9x1n1mXag+/nucpC81/a6
         zZwvnEi2wZyGqU/UBnWu9G5p/0rkLKZRHSRrPY5whlwEPll49NsahOzMfRXLKC+o0hkP
         uFGg==
X-Forwarded-Encrypted: i=1; AJvYcCXeQGTLFoJdS2u0GCdOmTBPxI7iyiA12kP4jeivmpgryDG318u9j/axZcHc4OIUdABxAMQZCtOKOFFsSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0F98gG74dQt/dwDXVlAAN+/uQr4V/9cv+XE2w9Z3NH26GfrQ
	Madqb8bn/2D9QFk5JddV+ryn8YwJ/2rCCe886u3DiT2Eit403nXkT/G8
X-Gm-Gg: ATEYQzzDGFygV2rkS4u0JXXvwBW8YJUrY9yUlCVIBmNWB1AXOJCNtaudUprww9ycgI5
	3rOpBi04iEHytbqYvaxyiiLRIfUACv1mClgHMftjbnV026AjwSq/AN4bQj2UwMC8o9ZnBcLicuX
	HoVPtzVJZ3A5iRhLfQiVIxV/vPdeNH4RNuIizlG7FDzPXCiAaqZqI30mJSPPjkQ2qTldJzGwKTQ
	lw3Cxj8BVWHb97X5b5sp5RvXjGfWLx7eOuzqz2/gj2dGUm4HR8rpcXPwld4JDgzFxmSP0uzytme
	m4LX4r6LpaSJ2qD9SxILeAbZq8D9yyO8bIVg/H6o3Ma5PIZOxpSr16QR+69BVWwv1KyaXRyN8t0
	rzeBC40Lzr7oB21IjbDukcKxxQ4Avq2bzZNuyr/1bPuJpOdS0svR0TWpaUVlnod+oR/SvRhzRYq
	eIpWqUSQU8UljNG4HE9dGQug65FgEjiJYC9g==
X-Received: by 2002:a05:6102:8099:b0:602:8c16:b24c with SMTP id ada2fe7eead31-602aeca17e2mr3234341137.19.1774124767446;
        Sat, 21 Mar 2026 13:26:07 -0700 (PDT)
Received: from charlesdias.. ([191.22.16.211])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de53d9sm4144378241.8.2026.03.21.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:26:06 -0700 (PDT)
From: charles.embedded@gmail.com
To: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [PATCH 0/3] Input: adafruit-seesaw: use dev_err_probe and add IRQ support
Date: Sat, 21 Mar 2026 17:24:43 -0300
Message-ID: <20260321202446.724277-1-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Dias <charlesdias.cd@outlook.com>

This series improves the Adafruit seesaw gamepad driver in two steps.

The first patch switches to using dev_err_probe() in seesaw_probe()
to improve error handling.

The second patch adds optional interrupt support for button events when
an IRQ is described in DTS. Joystick axes remain polled because the
default Adafruit seesaw gamepad firmware exposes button interrupts
through the GPIO module, while the joystick positions are read from ADC
channels.

When no IRQ is described in DTS, the driver continues to operate in
pure polling mode.

This series was validated on a BeaglePlay board with the Adafruit
Seesaw Gamepad, both with the interrupt enabled in DTS and without it.

Charles Dias (3):
  Input: adafruit-seesaw - switch to using dev_err_probe()
  Input: adafruit-seesaw - add interrupt support
  dt-bindings: input: adafruit-seesaw-gamepad: fix interrupt polarity

 .../input/adafruit,seesaw-gamepad.yaml        |  12 +-
 drivers/input/joystick/adafruit-seesaw.c      | 160 ++++++++++++------
 2 files changed, 119 insertions(+), 53 deletions(-)

