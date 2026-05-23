Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A359313535
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512804; cv=none; b=R4TvhOS/BoCNirJML5b9s2MXPypEmNFhr10x+knZRawuSFSBPhYMB4S1Fj1shKZphzo23akdj9Lv+9MsMJnJ4mfJLSvCG41ARzQScugHFgbPMTZ6W6onn1XavOz8YXqUL3JF1tgx+/z69YkL2Cu6MRIxaM7j4nMa64aUm7yp52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512804; c=relaxed/simple;
	bh=Shgi5jElQdfBIcR6Rb8wt7MvaQ1F9hHKWfstV1Edmk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjCeaUm4KFke0i6UUBaCIcZziKmKDVraoZmib7cixftvIGJuYyORaUMfelpRR4g0nv6kCx0ZDg/Hthx5l4qaw9ywDcHrDHzQZh7fX4L/wE2Y9lcsVfHaD7VNOlL2/ERSVOvCN9LWmN1U7F8lvK1tu8QRcZUFSzOsCIl4gFY6crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUDmJlwP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUDmJlwP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3042dffd80bso4232739eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512802; x=1780117602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJRSgIm5PQp/1IbzKWdJwM1Izu6wojlwAOub5x9zwME=;
        b=KUDmJlwPsq8EcNVP9lNzpO7gjE6BbG2YOQn2Ctf6GZaQJnjlg02LkcHRufCcj1cF5I
         +wJHX3rOyppG/DRStVmP4R5xAhC6fjdq9FXZlMrN7qRb09lf5UYKIYhe5XMrKSOY9H2S
         qaemq+L+pEqfjlFzjI11gbtw52aOPCVWlL9o8xctuC179B67Li6s4Au3tfEQDxQUlaMk
         96VrcZ+CG0zfkiPFGE6tokzXu8IpCa8t3g6pC2+T3+YVwpw59GL/SF44kqa2LyE6H7Bn
         gpIId+FebuwU6O09LK1I92NvoaG4hc72YJVPNpfvykR5fU7C8CpNl3NdPX1TIcpasT2I
         u9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512802; x=1780117602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJRSgIm5PQp/1IbzKWdJwM1Izu6wojlwAOub5x9zwME=;
        b=UhWRXylJg63hIBXKmhVz8jQH2e2SZ5CrPP2LoagyJ5Z0YFq0/itxxmnzLl+7sIwg9Y
         j2f9LquZpbX2AMayQFzyQbv/hZLr1MJVzA5NLc/lHi2nQd/94XPkSA4mmyMWAxPuLtfc
         Rp/9BZYnsliW31sQhWjD2DvI4+2kHiFNHsDaOY8JVQjtpfj4lGVZdrwv1sWp13NUiPkD
         +0JzUIRy7GxNMwGA1ZnBOUkhievzYC+h6oiDg+tOJ98q9NQXkVs0MRsFnhZWO8Dm1aXE
         0dUhAmdNh6Mzf/ygUjboFWHWff+NyeSf66Y+Zpr4lGj3APznD616eJG5lGHmqGJWV9pY
         GUaA==
X-Gm-Message-State: AOJu0YxbGA3IiwhoVSctvtvaQ2RSssvwK61L1bazeIbuGU1/KEOvdOXt
	Fo454ZQw/EJR2xj4ldoEJuyUt8+CDmCjidbHb1Tn2VNyGugGHULK9C/YXsS+3w==
X-Gm-Gg: Acq92OGIr/LX61WAZggh+86qZ1sdQMQZrPlLTIZETOupJUvcKxebntXZxejGpr3tBOQ
	ZDuzjR1UgPKN6S/gbICjn3dPVHOA1bHbHiu7EsY2VtxyEd5sXxeQXI25izj8OyDhB64oKMG7efn
	fkhSPUqnQk7KiPd7godu1XewbkA3zqLYcrXxMURtHGlFsvKxHuEbzdb0bUj8UXoGf/tNggmOCOh
	OWLl/3J1QhGEUK0AtuD5g9LFvYKgxgfttTvShDVV2fBkpHWUFC1eggKoVnIJIPhMcJZVxObqB5I
	W5pJIElA8AovFs6W1iB3Y8LhJO+THCSU9bMpykRbAoV+LreHS6yoPHoQbeGR0eVjm4ZZhWdRN3p
	UFxoLKCaWwKMOlW/hDXmtENX+/ModFMhvWbuQSnmlOoOh7wFxLjZY6RvDs3omfiqU0GzxvlZVzB
	OsIWoa7tj8TIbzdMkU14/ETska6f+ShnPBeAFS0XuulumaRAKtvLgtuBfsZfbeuoXYQAk3zbfv7
	KSvPRfyKXyfhGCVznWvYpaQ
X-Received: by 2002:a05:7301:6704:b0:2e2:d94d:6188 with SMTP id 5a478bee46e88-3044904e1e6mr3083881eec.7.1779512802332;
        Fri, 22 May 2026 22:06:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:41 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 03/11] Input: ims-pcu - fix type confusion in CDC union descriptor parsing
Date: Fri, 22 May 2026 22:06:21 -0700
Message-ID: <20260523050634.501509-3-dmitry.torokhov@gmail.com>
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

The driver currently trusts the bMasterInterface0 from the CDC union
descriptor without verifying that it matches the interface being
probed. This could lead to the driver overwriting the private data of
another interface.

Validate that the control interface found in the descriptor is indeed
the one we are probing.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index d0934d577b5e..a134483e543b 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1693,7 +1693,7 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 
 	pcu->ctrl_intf = usb_ifnum_to_if(pcu->udev,
 					 union_desc->bMasterInterface0);
-	if (!pcu->ctrl_intf)
+	if (pcu->ctrl_intf != intf)
 		return -EINVAL;
 
 	alt = pcu->ctrl_intf->cur_altsetting;
-- 
2.54.0.746.g67dd491aae-goog

