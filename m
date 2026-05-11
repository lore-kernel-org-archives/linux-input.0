Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822C318EDC
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778478050; cv=none; b=Wx9FLgEt9IssLnF7OQRMlxyGfEOpbbHs7jBmU/2EXdTJ+I5epny2ifGcMyGle++yqpTYSIAglI4Ghf4gtqbDzch9TY2gUk4d4MMTYp62uCRMQdiiSyzJ5ZOhQpXewDsFtVpLwRtiOkITryeeGLb+EHDNoIGkHQHCtkipJcAeY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778478050; c=relaxed/simple;
	bh=zx04FKYj2eO0IdnDMSTWzwGM+GIhYvkHy1gr8MVSzzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIGTCCokCRkGPFV0I2ETsWtQoTuoYSlYX5uG1S5vqe4eelY0rWbrU8ATIqDe0G8I6KU22opbNpeh7su60bsif/G86CK7GLLU5WXHygutwvi5I/w0gjOZqy9djnGIBRmVc0XggFbuZBJSpdEmYQq1xx3DwNQFZSnwKRNJL+3hXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAH0uxw+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAH0uxw+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-838d0b7c950so2647875b3a.3
        for <linux-input@vger.kernel.org>; Sun, 10 May 2026 22:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778478048; x=1779082848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRo/zL8lcbk775YFV/kXBbQEwWE9HD7jqnCbZs9KJSM=;
        b=EAH0uxw+PEuGHq0fVq69nke+wF8WQIHY3vOSe0DqK6VktixVytHF9NA1QLwz+AFOtZ
         Y93kMZqJCcLIouvMGLQxs4XRqZec9CSwRRRgXGuRhL6LQVhc52H2VuG1ucMwBRAVopAx
         bCcolMo5nzf8Av58ROr7QlKF01nQX96tnl2oMeFkZyunaVnCkPGxvZhV+Bse7GIxIl1B
         ffWTpi2Y+3r2PLU0gCvbJxqLUkjiiBSi96QCzPBZJ/qiSbYT2HlZLQzipKCrojBNZWBy
         MQp6sUYSmlbO/AXxbqfiQaaLg00DAeatQ1BU/GcxTN8vY88D/4yp1s1QuLl8DkSEx1Yy
         kZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778478048; x=1779082848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRo/zL8lcbk775YFV/kXBbQEwWE9HD7jqnCbZs9KJSM=;
        b=hadfHtKBYbr+dWtUX5BYsPwFTPGMf8dRcu5lWtRTVjSyF0l8GNIHRlHjYPyLm4LWHN
         Pf6oir+JCYs1g0wALdHbEE933n6i1JzmnJog5hcd3Y30AXYwI8iHcfFcGVkzdn2dfWwP
         TwNrf7j7GOaegi6TGjeZRED6iX/qWP4ifYm9/3z4vcVqIfe5qcLuA/rY70O3CuKBixaF
         oWGhHuJpjvHpIm5qBhJQYeEbpVb3BWdsZ3oro3JuHVby7WLFO/j0pFNU+4Vkn4yBJFZE
         TkudTSrCRLia2F/+DEJDrtMQNf8qBdH7jSZdcIhmwtrB0HYWqqi788hWgtYuyE1dzmyG
         mxnw==
X-Forwarded-Encrypted: i=1; AFNElJ+bvDQv+eqGnaaXYq/PKLaSOLjwhQiWPBzxBWjbtN3kJZZ8rC3ePlrHhhaUy8OaHyl4hFqWwqmJbL9h/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHMZ1epGREmAiDMidTEeNgHd9Q/z0x5g/SAhvdq5C9IAn5+Hh
	rx+Fm2slmauXtaURlpbwNq3VhllWiKDgo2pRrtgG5okvFbBZegbxwbKh
X-Gm-Gg: Acq92OHjczwQLyLJoKPgc4ILNTYWwLWP+c7wi8OY03QMuc8ZDOdWrwEbMCNd4LHtW/x
	avbGXWB7Z8+FMF+OFdl6DzYVg+3nxgGI7ndul7P00lcB2pHcvGthh2WJElvNIs+5FUjBU3yEKb2
	IDhH23YPdFENjGlN3kxN1IHKLcVTXs9gjaOuVUpyeEPrZgmciDhosLco9raEVRIK4G5x1MOqBF7
	0S7rTHuWyzt97FDRJsMuSXpxcgHZ5yKLCUjgnrpH3B/IJZSIV7VJp9B/JmVd2duKyUwVeA5v+I3
	q4RudUmx3vD53VENOdQfezyJLrwbBsDnjE5KxHcHW878s0PkYs8imdfFMmhUqfbrOkshR27smo+
	SvytKaW8Faqeax4ME1dXjyt8ZnyCDBVufipReufhE+eLthIfF8HJTsa/pg8e+AF/BSxTN1TYmRR
	0A2KkJVWk8EC4wcQPLrkaOBB1sd0/MP4PhNr5r80/UORnjvYhMa4XlFRsngqK3I1pbRmQcTyWRR
	HH5FQ==
X-Received: by 2002:a05:6a00:f04:b0:83e:c8f8:cec7 with SMTP id d2e1a72fcca58-83ec8f8d219mr2280567b3a.35.1778478045878;
        Sun, 10 May 2026 22:40:45 -0700 (PDT)
Received: from isd22-5290.dc-ishida.ishida.co.jp ([60.36.185.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm23180139b3a.31.2026.05.10.22.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 22:40:45 -0700 (PDT)
From: Yuki Horii <yuuki198708@gmail.com>
X-Google-Original-From: Yuki Horii <horiiyuk@ishida.co.jp>
To: dmitry.torokhov@gmail.com
Cc: andreas@kemnade.info,
	clamor95@gmail.com,
	linux-input@vger.kernel.org,
	yuuki198708@gmail.com,
	Yuki Horii <horiiyuk@ishida.co.jp>
Subject: [PATCH] Input: tsc2007 - fix resistance calculation when A/D value is saturated
Date: Mon, 11 May 2026 14:40:03 +0900
Message-ID: <20260511054003.1205-1-horiiyuk@ishida.co.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A/D conversion sequence starts with reading the Y position
immediately after the A/D converter is powered on. This makes
the Y position measurement more susceptible to instability due
to noise and mechanical bounce compared to the X position, and
may result in a saturated value (MAX_12BIT = 0xFFF).

While the Y position is not used in equation #1 of the datasheet
for touch resistance calculation, it is required for equation #2.
A saturated Y A/D value, like a saturated X A/D value, indicates
that the touch resistance calculation is invalid.

Only the saturation of the X A/D value was checked, while the
saturation of the Y A/D value was not. Additionally, modifying
tc->x directly had an unintended side effect of corrupting the
caller's data.

The function now returns 0 when either X or Y A/D value is
saturated to indicate that the touch resistance calculation
is invalid.

Signed-off-by: Yuki Horii <horiiyuk@ishida.co.jp>
---
 drivers/input/touchscreen/tsc2007_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 524f14eb3da2..ce82163da4ff 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -71,9 +71,9 @@ u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
 {
 	u64 rt = 0;
 
-	/* range filtering */
-	if (tc->x == MAX_12BIT)
-		tc->x = 0;
+	/* invalidate touch resistance if X or Y coordinate is saturated */
+	if (tc->x == MAX_12BIT || tc->y == MAX_12BIT)
+		return 0;
 
 	if (likely(tc->x && tc->z1)) {
 		/* compute touch resistance using equation #1 */
-- 
2.51.0

