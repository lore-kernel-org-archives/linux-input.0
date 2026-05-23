Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A232B119
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512819; cv=none; b=eMIYxiEmHDR/xrwcfxj6HxFfCu9TtnrIvhcm8wVCLitGCGAHPv7B62h/BYRaGoAOMuO382bpukf1GdrR+CJ1mY0fPeTnoVgCpI4C/HEKk4TkzI3yGgkJ9w4MWZYiP0PYHbiQlm6q0UiBbUaYzVM0Mw3bZDUFiaQpWNMHJlPORFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512819; c=relaxed/simple;
	bh=MlNPLgO0GOSz+HJrY3JUc5wo/gOXs2kCDyQ3NbipUxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S19U1CWVvtNznsg6m97RouHyAkWDiiUbiqMLcA+t4WUUtLwRv5PzHMx7zyzsHLxgzYdwqUq9G1DyQkcF/cj4fB3sSEPpt8MawZiJuCQY4TVJs6H+mqjo1/Cx7xY8n2cVQVVhCt3Vl1zWZ+r9r8tcBSL2Vm1Y3M18gfFVJXawXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLGuMEpt; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLGuMEpt"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304545e6c7fso1388772eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512814; x=1780117614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbUNHVP+Sayv9nlw80jQ85O8z9BYRMlkqYBRJNlEspo=;
        b=mLGuMEptwCpq9Ti2JdnzJEOgRGLlZNVqo0BdxRtqdZafkX0Esx9HCcoBy2dQsiYSRa
         kvFs8Xq+DnJbUKjtxrpAzK2qFLI6cfSJN7xhieWqDHDac46Lvrf+iZQLEYBiS4M3SsEN
         wbNS48OsPQddRTpHz8A+iKawZy4/+44cGmgcgdaQH4QQe8pSfGnVkxtVsxZyL2sStg5a
         ms7VNlSrOLbzUIJkGYYNCTDgMFzKwfw3NBoe02bY1a1kQgMf4PcFIS13/OeqA+xc6JcH
         jDQkySZ4m90brEEd4NAXjbebCsk98t4DlvQuUN4+ftQj0FRmt1YmSqPescN+rfuZ2nvl
         vaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512814; x=1780117614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WbUNHVP+Sayv9nlw80jQ85O8z9BYRMlkqYBRJNlEspo=;
        b=Hwb8O/ll2QWNp4mig+jx+mC8BEOfeX/j8YSIWjlpZSiADKcuRmZq+yFyTfYImaijfF
         1EV9XTZYA/VBERurpwQdLD5SMS2eZTc5QslYh6bO5xOsEpTior2tI4haILeS3soTjuwj
         EARkrWCOzAHr/sE3OdH/et1z7lyxxmab9bnhtSDnfpaUWbjnidXNrfBGuQQHICLOOms4
         QFgDxbHdHCQHvqjJPdrYawYoijSSLK39XlvylQipZC8JSHExLOGD/QBSNP37MCRHMfeH
         v4QgMvzL2Upo1cAQYjponyLKEP6v7Fr039jCnt71UV8ymlGereIkCcbKHpDjX3kMeQiQ
         oS4Q==
X-Gm-Message-State: AOJu0YxekgNLyURU78e+MK1bxJcfy6zN28T3nzmeBAKFg6PQvplnntam
	czaibJxrynKi8eN5bD8bu4TfvKV8+fwbIvr0+yKPayxjTfw5TPHd0bDJN113zA==
X-Gm-Gg: Acq92OEvQy795bog6Zn9Sz070lJNIyVYDZyZNhmQwYcLIf5USiphu3bfzz96rwbiECd
	Ryb7a4hobUonrGK7nOxsa3+FrcjD+bXzJYbiHq/WIQzOUXV5GlFcHxvT0JYRu0c87TdD4Vm16WG
	ZqTVKliw89+baaKH+zw4miWPjJ5Nq041Xj+TCVnPHdPFDsvpRGMR/uyUJxHPHuAmkbUU7CW3iwy
	5jy0roPFijFBexfa7vlphbi0a3/uiW0AcLq+ayxtXaaoIVi74haP1xvRpp8TxP/MKjmpHz2FdQG
	j3+k7Dka9e6UeC+4VqyMGwqCf/ZqvNtlnUedguBG7p1fzH35ihW//D0N4HrWoM3ApLYs8SlMp4g
	LxDMAHTyo3YVriT/VtmdCOdSPGTnjUOQ8V39CDMI+NMk41eHRE52ryeyOsBAwBoj+MmW7fbgiS3
	MBdrAnpBRQ9H9b6Fy+udtIsY0jK2oOpy7tmv/dj3sEygSV5+QguvMiQgCXLDZs8wIWYdFVX732f
	k1N+qNjUreBUg==
X-Received: by 2002:a05:7300:6da7:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-30449054359mr3500635eec.17.1779512813893;
        Fri, 22 May 2026 22:06:53 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 08/11] Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
Date: Fri, 22 May 2026 22:06:26 -0700
Message-ID: <20260523050634.501509-8-dmitry.torokhov@gmail.com>
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

The debug logging in ims_pcu_irq() unconditionally prints data from
pcu->urb_in_buf. However, if the interrupt fired for pcu->urb_ctrl, the
actual data resides in pcu->urb_ctrl_buf. If urb->actual_length for the
control URB exceeds pcu->max_in_size, this leads to an out-of-bounds
read.

Fix this by printing from the correct buffer associated with the URB.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index cdb46b2297a2..23e576500890 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1529,7 +1529,7 @@ static void ims_pcu_irq(struct urb *urb)
 	}
 
 	dev_dbg(pcu->dev, "%s: received %d: %*ph\n", __func__,
-		urb->actual_length, urb->actual_length, pcu->urb_in_buf);
+		urb->actual_length, urb->actual_length, urb->transfer_buffer);
 
 	if (urb == pcu->urb_in)
 		ims_pcu_process_data(pcu, urb);
-- 
2.54.0.746.g67dd491aae-goog

