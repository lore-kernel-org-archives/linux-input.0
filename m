Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DB4734E2
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452002; cv=none; b=lhFcoEjoW+nm0mkw4oxBoRYczXXUgU2yUjTNmbrPgYQvab/92BSMZhTrqzMVLpdfyao/Cllimdp9xC8xW9bA5xEItc7n2vDwjwnO80N/HDpOvJGy53IOww/k3NPlc1ltSthsWBo8/qALu0jsskPB1RbXVkLERydb+IqyYeiyzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452002; c=relaxed/simple;
	bh=N0V1DzKLR9gd036eXyTNdTYS26rNOng1qN4IAPCVCcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ci3B9d8OjiVTLQWgMQjCP/weotHJcXg81XfPtoWcEX0qimdBfBexkXGnNakjr2AM7hyIS4hmCeoEE0iX4GL2eQWdYAs8H21HaMUZu94ryoMdnse9QKNEU8bFiKoTVwCB/wzFzMNNS6i9ZDwGbBCrLs0aiHtDt7KYuYRWuqjZDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD+3etBo; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD+3etBo"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-16079d54c17so1964651c88.0
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791451998; x=1792056798; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBjkRKxxUcmxMrSLKdMDp6PTFbEMXcXN1ust/EC0L2I=;
        b=RD+3etBotcx4lle5Xm1ZfbM0BIreXRNQfZL2QqtfWx7FA33ejpPNR9ZoPsljDB8LNN
         LNTeYWL2E/SbZr0dvbHDOLmQAlUR2f9vjKk7B9MaxFUBkLakFcSPXXKjYpAO3nZaP9lr
         qLwYhreY9/K4mlVy//fUj/S6MYl8XIHfrxPFmdYKehCot0nAL/Gq2k+Lvjg4ZikDurNq
         ryBQ9oBRe/Sxw2veRXzIONfFtG6ZiKH8R5574Vgk2eGpWJWIZQoV1w2O11wnAeFT9psq
         BTJBpicYcwkz+NkKSOd2eBy/TSqy1qzK6ImwSxwn61b/xQWhqKJdQJPcrqph2/7xD9KU
         9PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791451998; x=1792056798;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBjkRKxxUcmxMrSLKdMDp6PTFbEMXcXN1ust/EC0L2I=;
        b=sPcdjTspWGVvPhZ5S1AXpjz4LdWG8c0nCAAPlAX7EfpCMMWzO6+Nzm2V2n0uxYO2z0
         OrMfTWtcKCiOT9hQTrDlnvBJ6dy4R4KoT61YrXUKqmt96mk/L6WKbLEyXygb7/YCi7Ts
         fdoND4F9WyR4yPJaIro6dn4BzmNnASTX62XuwUSkMXC1VFd97mxCFbBXHwn7Bl6W4wZz
         QSlFtS6WNiUSGKX2El+DFmaN2jlcUyNWkANwYUv0KfoaE9OcvGkhZajFI8raEXs5PQOO
         EoslRlmTiW5h8yA+lsl9cUoaGFZ1esbJCi8ts/xCaVtK/PiP2PZ2vdSqGG+BbQWK/HWk
         M11Q==
X-Gm-Message-State: AFuF++mN1xNpgEfLSDxjPRP8U3x2Wcb4B76z17nTwRRdHOHo41c+4dzM
	KojPFUXs9ygQQRFBlJ5mFl2DFbdDNzC1FPuclK0Q6sV+kBEihHfMV5TcQUhu0cBqpAKI0g==
X-Gm-Gg: AYBFou1x2rqNhGhzjn+3QFvvMTO1DiRnFmjEyqtu2nymsffsDbKflHOMI1qdSjvVBpu
	+4JPwTrUGXjIcjsiLcrCMF+FibNTt7tNss+zy9UtYMkjoWmpJWjHFTJL3c4eFNUnJsIuF0WA8gz
	k7dEjvMRohALKCP6PK4w5ddzyNlP9bCmb8lU/MdR/HxhxvHkeml6egn0FkPH4NDAtVAXGrmYT2W
	lqp2hvwmQsUUOkCMrcLmGpkgLb2qtwQjgPWlgDzuLkFY/0NRpB5XCQL/Rz7Zo3Ns9pXyjTfdNUj
	ywcysgf1MHkU4v43EZGpX8NtsrfGIvuc5JAP3qzSRa6D7eJcjKSdwbPbBGsBr6UZg+eEKj8uDOW
	5bGC2vMikM5oY7LJVqu6twyiTVobFrN5Pbo+pJJ6GTc/ODGvpbFX2ce3XBh8wZASUAxz1gibWqi
	DaNerCOmC/HN6wueoEGr5nn7avgFUPmhRnYO0logzC5vG0IjQ8zR4E+jeMseP82ofGbrmLGrS4e
	csv1n+Pi8egU0GmELujpnWxxZeF7eRNJKp8asLi
X-Received: by 2002:a05:7023:a4d:10b0:144:c12b:4e35 with SMTP id a92af1059eb24-16209c2807bmr5308207c88.42.1791451997826;
        Thu, 08 Oct 2026 02:33:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-162263643aasm16144763c88.17.2026.10.08.02.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:33:17 -0700 (PDT)
Date: Thu, 8 Oct 2026 02:33:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: s6sy761 - drop duplicate axis initialization in
 s6sy761_probe()
Message-ID: <asdjLHHNrrtjIKCb@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR are initialized twice with
identical parameters in s6sy761_probe(). Remove the duplicate calls.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/s6sy761.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index a770628d2b94..1afa38850f12 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -446,8 +446,6 @@ static int s6sy761_probe(struct i2c_client *client)
 	input_set_abs_params(sdata->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
 	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
-	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
-	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
 	input_set_abs_params(sdata->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
 
 	touchscreen_parse_properties(sdata->input, true, &sdata->prop);
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
