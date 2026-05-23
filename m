Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584833065D
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512809; cv=none; b=Q26CjNT6Zu8QeVENCEgPlymSeRqKcqxfk/RXZ7E52Al4GeujIgx2gsMGwYll4tFbfintgZEJryyRtYA1dpIbH1e23DQbKE0i6ut88/V4CoJih+W8xEdIEEKjj/mSS7NfSklxyVY1SMEWrmZ1BGvg+gudxFFaEMu2wX11NPZrOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512809; c=relaxed/simple;
	bh=D49s69jzBXejZo67zjSIej+Rl6VSAaM7KMlYezj0434=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJTdhkyVIg7KRZnDUI2wp599nKvw0GDES1sX1xyZ6rRZk68c+J/T/L/maXm2bW3Od2aBZN9TyuxceJyqQQqYVcywVZVOj836qDxrriB0pLyX3H0a23wbq2pt1Z95n4QjmGOYxAQQ14wveaWTleTMZEE/5uO3UaJ21u8wy3QUaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4zBCE35; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zBCE35"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f68f3b075fso2130013eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512805; x=1780117605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYWslJK6SpSjatzdYnqvuc5HM66+pB8AlGJT3pjZSU0=;
        b=Z4zBCE35xakkjGzhJNH9lSmDKEush9ifnr+m0A6lvQnRWKmTEpORwT59wEDW5afg+/
         20NVOfFjWuaG/a08zJWPTtM90IeFYsgtHqsoRhMrVCpPoPTA1gpxUN+UzJ7j7Oq113vU
         yWuaED4CmFOImIb1tiBtQ0e5yQc5huB84sfxwKdIx88YTZi6qycMZcZf1Njc9liP4W1b
         F2uATUT9yh5Am4MHmkHUWQqsrbsyAz3FTkeitESOCGw0TyRZQl0aDdpY8Ub5D3/VaDzC
         l4iCuR/CVGK4cFypT93CR5wZTTh+CCn3E6ZWBicEHc+qfYfGmgEjAePKo32Ufxm6cYj/
         IwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512805; x=1780117605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYWslJK6SpSjatzdYnqvuc5HM66+pB8AlGJT3pjZSU0=;
        b=Bt+r87LEZLCmIWDQNG2M/HHBfF5JLFFa18t5qqImj/OEzuH9CeF61TsbT4zfZW7byB
         VbjzYKtlBS2h5lBBHEzZuT6F8oB8eCL72ok7sUz3XtACpDldt6rEUfh8APoJ+FfhG0DP
         nMAomelUzVdHs8rL6KMPK/ZoQoLTJvcSSPv6cxdNCOISq4GLgaZPPhdrX6H2n4IUikft
         hwADY0EGp/HqP+PDsUsLll2cXAKKGIS0whrrcDqOS1eJeA5aB5+NuBteTDcbMxqcVfa5
         QlUpA6K1SK/ixw60GLWPixAhXK8LviGKAZl3FMkM4jw/pJW2nnr8X+LHi2S1qW1aXUSz
         HvYQ==
X-Gm-Message-State: AOJu0Yz7e3VEK2Ktlc8xHV7M2OKMn5kz9t21E0rHF5BaskZgzZDTPL/6
	XfTkssOR8Is5lK2aNlire5HlfYjUbYW6NaG+QcDS8WlDX9ycyS2sx0Z+TH0zTg==
X-Gm-Gg: Acq92OHMyjgQaYVCQCQH3X91OUz1M6KiaC7Tp2d9pKiW+JpW1kdkn58ZCc+6PI3DSBg
	yJTpvBQPsf5AUlUCGP4Dfr2DvBprq1UUnMr6mVgGUXkGbNkmbOvzv5OtDpGv9hQRoeAvWYDdu1V
	mKwhsOh6Si+g5xMIwH1U+jmkwR8Qv6l0mT0BWvRMb4EEwR+4ypHe7QBkonk1F81V6jeTYnWleD8
	mJMcYMH9Wor5PeY4goA7DuT4B0DSYsiumLHif3SoC01j6e92MiXpCwwBpuMr/RFsQ7XqjNo3pah
	KOcg8W2xv9E+xiO4h+RQVTyl1+ZlapuVTLwl0FK+qXxLY5C0N/PlkOkS6ahC7CQd6mhHaE6kRy+
	675koHrXdcehzui9agyNqLvHJr5fUpocg8TZDrIe6/SjmOxYPCDmMNe+wjv/tUg8xbC7WSoYEWr
	vW8YbS3CuZxZTI4L4oNVhwy4wB/YiAhHXCkUzkhNr8JQd2DKNovnYLIe/pujuI239MQbr9xs0uP
	a1uDN8j1NUhLQ==
X-Received: by 2002:a05:7300:cd8f:b0:2f5:3641:f10f with SMTP id 5a478bee46e88-304491ebec3mr3466361eec.31.1779512805103;
        Fri, 22 May 2026 22:06:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:42 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 04/11] Input: ims-pcu - fix firmware leak in async update
Date: Fri, 22 May 2026 22:06:22 -0700
Message-ID: <20260523050634.501509-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware object was not being released if validation failed.
Use __free(firmware) to ensure the firmware is always released.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index a134483e543b..f86f9a5a7564 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -934,9 +934,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -956,8 +957,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	scoped_guard(mutex, &pcu->cmd_mutex)
 		ims_pcu_handle_firmware_update(pcu, fw);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
-- 
2.54.0.746.g67dd491aae-goog

