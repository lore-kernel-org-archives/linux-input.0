Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BF3AEB49
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440218; cv=none; b=fi9WQ0qyHdPcxpAhiFi/jW2/zwayHpg5XtDDBFpL59O7vOJnHj6SVMBxi5564j/wfKRrhii9+TuruAup4axz1ONzRT34DiA4W2hWmCCkDx4Fj0Gdp62IX9NXeiIQyjrUrjDVrEtB67xmdCwPTSF1+DS1PjMUA/Jk8u4EPVLZHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440218; c=relaxed/simple;
	bh=gOmun+zN7RztrvQYSyqFVJChn6F0LABtiPDXJNCLz18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O70VHUphUgVaq72yWBJA8HT9VDE9O2vU7PlXUG7XRuAUOmD3Uanb9weUqIdURAJaXptoReO+M9uVIKC/wLHViShMTrlQdGppl9zW72tnrG/Xm6zA8x4pdXLrXhNByoMCGaM0n2tz0ImPq0Gd0CQKjWVccXN0FtegX2omK8+ef8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad//hpu+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad//hpu+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48e69e60063so6290195e9.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440213; x=1780045013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIcMGzBSx7pwGWEOrLxy1VclzIMHdDoOsNUMGRX9Xl8=;
        b=Ad//hpu+vnPvZgHRwr9Slih+w99gk16GDDLD6eG88h9cWfwt9VizzZzUHWv4Qc3uIB
         OWYjDzhfd/7pXferr0yJHGPDZrZfnA+0hDj2hTDYE2SEu7nXQ8m0aG7EGgKvfq92vuAl
         Jah6vAkGc5b5UQTmkGEWy+XzNKPk8u/urmPId4uQ648wAh6TvNX8AxQh3ZtLCPnbEh72
         KUUqgQ/fYydq6DXKHVBZSUUy86zautqL+xnTr5ccW0trbpsQftLHcCOTnem7NMj0ll5R
         8JogpP+D+6DF3jSmjuwmVtJT207aIEaXlZmUh4Xl5aVbpeZ+QI0PMdRG+leAV6zzDHIB
         XkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440213; x=1780045013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIcMGzBSx7pwGWEOrLxy1VclzIMHdDoOsNUMGRX9Xl8=;
        b=sd9lUtTLOdXvPCc+IYOmJ0bHK8N93i7/Rm4+0kDgr1BkWj+EicKIQHx6zy2z7wxXij
         qLhlAKbbNVIvxAjEtyB8IyCCPisgqU+djCoftw4QfI2cAbas2+e7GK4Wu4dzO8DQFP1m
         IE1m6Xn7OqJwe7kSNkiGfY5+9NOoYdcm7Vr/LKvGua2V/tiYl3D3vOcXzYobfm9NwYxQ
         eLf5Bz2PQcqUTC85uJRFc9p2GUlngUdtRsqVTnofI7qY1dlFL7NlLBYpvvr1K2N2+HM6
         6MoKHXvQh93GgCvBxIDG3+BPYUZPjN5e2T8PtCrh/BwBRv3+mgVRJWiqRyqyKoAmikVh
         h4vg==
X-Forwarded-Encrypted: i=1; AFNElJ971dLdPrqUom37gXcy+cFf7jnzEn9nKg1Z6+69Xv+8oczfaXFajJ7nDYrF1k6Oy5Us9GzgL8HnOjz26w==@vger.kernel.org
X-Gm-Message-State: AOJu0YztwpqsQgmD737DI82lqlqEuN/4DiWUiNA1Q2d/qvL671s/Sq8v
	EqPj2L/QcH7mz73SnOaaPuysZqhqljUM074ZRnPD3PMQO/FmuL6c7az2L4gzhssS
X-Gm-Gg: Acq92OHWxHa9xc7BZ2EzhAt10SJo02Gt+uNqOGZn92SrvZONX1B8hEJPb7OWqaAFNVF
	vuT8/oTaVaipi4/IkT5Kt8Rp0XvHPtQgWGv6zzNK3orDjWmgZAG95AmypWzcBlzXBW3XgRUn5e3
	rFIFWO5Dfztl8nbFvV1vz1y0SIpvVS3pEH6XBsOPs6kz0wArlgwyUniEoEwoq7v8X2VZiMYSJNB
	KhhWj7Oa/WxzZ3491p/Q5jWWxgq8ykUUZO7zWmnJvLTtdyRRSaoOhWqP6OnRFyJsJdIS5SVKYJj
	MUrqN+e4Rr5KVl+AaKkmGWNEaoOZx2KB9MCST8jW6Vba+Fry6fVp9I2mDDEMYeQ9BnYVl1Aj8qv
	ZHi607IpDU1Vv/zsPE4iOLEucYdw+MgT2HZV4lB4KjAv9eoorUtJsFh8DOxuSF1jol7VR0jhXRX
	KJE5QuFW/GXFUqO7ZqwPR9Wzk4MsK8yiyCv3shK75ntT6Z17RYSiHBzw1o9hk8N2nFWXkr31Xd2
	w==
X-Received: by 2002:a05:600c:8b77:b0:48f:c8d4:487a with SMTP id 5b1f17b1804b1-49042adef79mr16696695e9.8.1779440213032;
        Fri, 22 May 2026 01:56:53 -0700 (PDT)
Received: from thomas-precision3591.wifi.univ-lorraine.fr ([2001:660:4503:4242:16c2:6758:c5ad:949e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4904174a145sm18607125e9.0.2026.05.22.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:56:52 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	Sanghoon Choi <csh0052@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_alloc()
Date: Fri, 22 May 2026 10:54:04 +0200
Message-ID: <20260522085412.45430-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input buffer size is pcu->max_in_size, but pcu->max_out_size is
passed to usb_free_coherent().

Change size to match the allocation size.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4c022a36dbe8..7a1cb9333f53 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1624,7 +1624,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
 	usb_kill_urb(pcu->urb_in);
 	usb_free_urb(pcu->urb_in);
 
-	usb_free_coherent(pcu->udev, pcu->max_out_size,
+	usb_free_coherent(pcu->udev, pcu->max_in_size,
 			  pcu->urb_in_buf, pcu->read_dma);
 
 	kfree(pcu->urb_out_buf);
-- 
2.43.0

