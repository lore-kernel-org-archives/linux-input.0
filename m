Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5F45C713
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345010; cv=none; b=jUWXbQbVr81o1d7dYBKpG8rdql1KlnSUjBGctgscndDAlnOUYIIb5QCaYhhj+7rzSulDCmMMssDgtoJ9BOTGYK/4THN5HPrTbtr/iw1Yw8BjcRnUfd8urmyoPRVcGNOBiRun8F8ICGH2yh9KRpSrraHDwRMUmsyl7U5HxB06LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345010; c=relaxed/simple;
	bh=hozdLyqkwUyv7nQGeKMb9Yul7dJcbrG59xMfsmKI734=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETy8Z836c2G2csu3jQrF/+l1RWXWoutfmHty8cKmXWYFqpzNMNzJ6yvRXYpgpYcPeozkEXbPzsyVcgaxGOu73xfZEoH1wvAOYHXhvpQ9mLEhMmOTdD3tFVrJELOAf65L/N110eNqoIPII3yNZ6mm6+teZjF0KCRQ4UMtBDDdl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/vliqsd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/vliqsd"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1092331b3a.3
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345008; x=1785949808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ep93HPjH5mmfbaJOhBXSdXp3nxY941Jgshzn8ZjPsSw=;
        b=F/vliqsdRzUs6x4m569+gWW9LXTjPHZs0AlBqg+/qTrvhwiYgpP2q5gzamkDwsAxdl
         AHmv3iaVYyGRBviw7HnjdCCdZjz7TeP+kiOnYF0bcw4/BeVdoFdLkntYNxfLgbw3y9oS
         OSu7Vby6N9degefnfnpuWKA9qDw+y86w9n8/CjugCJ6lsBQrd8U9+j+XH8hn+qJPFBvn
         Rwivr/FRIKP2bk6j4KI31AvCiC9VcrCoDSNk/cOwIeYdohWZnfwAUT4FFd7wqCwCoorw
         FHA9UaX28fxDUPRB++Vv3BHO4J72mvBDB5Q7Q8iWH2mCgW+EGCmLAQSiy1L03ID1t3I7
         WT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345008; x=1785949808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ep93HPjH5mmfbaJOhBXSdXp3nxY941Jgshzn8ZjPsSw=;
        b=lxwkkeFYJsvndFLYgKHvXxq6gGgHXoAjijUwhIWkXk5w04hqEd4ddFH2FFqMH1BBn6
         BqI9kfMAPnfxRE7NSI3fRL5NZXx2LlGYSgsTjsCl1qkiHPRUyvelCK0wPGA4Fx5k4MKj
         /d/4MJhuAGS75mz+kXM2yOMOdAUWFLwQHjgd05yBk9gKdYfu0ZQstKfolYG3dEB+eXRX
         qN4/VfpLP1rdKSgBdXN4+rgTuT4HIt9DuSxUoRsEfX7EhR0vCf8ONNhAi8Dp8iWrjAFO
         IcuSqy0qeEw1Vt5tQDVRusWsq17qyfKAsRly82b8B724ZfcD8BFPtU//CWOGJE+Mi0mP
         WYew==
X-Gm-Message-State: AOJu0Ywimh5NbWY18jKCtRZJ/p/qc6QlunPjU8nM/1FI+t4sG6P/0CHa
	mvHx9tKze4Gg2z+AfOIGxrD5/tfjKZmtrUZHwKtj+hRf2BM3Pe7t6UQL1Mo86kVp
X-Gm-Gg: AR+sD10WHFSX9nIPUS4aPHA2YOBn9nJfMWhDFRpAm1rqhm1aWszjZHxK90sZUoNnsOg
	6e86qskSMRLum2jpbyzyI2ax03StOkCw2TtT0hH4rj6QafOi9O3CVxRY14U0xZNRpusqnqVQR0r
	0VWX9sjQa1sxxVN5ml9NxOVOqsIOof7SwA/cW2mLlD0bsiDxi5NZUmpQQQQRUzQDLiUKtx42JDW
	e9/BGiUHhZ3CzLiEn2Nyo3fydVAF3nCS/ve8UnSqEDag2gnQD7xFBijNVzmfmLXs0YOFR4hW50A
	lsa9esFSs2GoqXNLnRCVkyeUrXkPWCJbCBQqCR6YzzSnaqqsOa/PyWvVOBr4qtHuW9oQ9IINNfv
	uooUTKfj9G0fAckhM6YtK42McnV3z7w/c++a5hHHZXS3X8OJPn7eIltD061NBDBirbI8Rv9301D
	YCo1EalDlncpgrd/eRMI69rLiDfmCu8qzFRsa4WRwCbf9mHrfSb3A1UY0=
X-Received: by 2002:a05:6a00:10c3:b0:845:d274:c024 with SMTP id d2e1a72fcca58-84e932c7a28mr7886101b3a.61.1785345007996;
        Wed, 29 Jul 2026 10:10:07 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm1694231b3a.22.2026.07.29.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:07 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Input: pmic8xxx-keypad - remove conditional return with no effect
Date: Thu, 30 Jul 2026 02:09:33 +0900
Message-ID: <20260729171001.260698-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729171001.260698-1-ekffu200098@gmail.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has no
effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 35d1aa2a22a5..c916e80e2f58 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -462,15 +462,9 @@ static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
 
 static int pmic8xxx_kp_disable(struct pmic8xxx_kp *kp)
 {
-	int rc;
-
 	kp->ctrl_reg &= ~KEYP_CTRL_KEYP_EN;
 
-	rc = regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
-	if (rc < 0)
-		return rc;
-
-	return rc;
+	return regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
 }
 
 static int pmic8xxx_kp_open(struct input_dev *dev)
-- 
2.43.0

