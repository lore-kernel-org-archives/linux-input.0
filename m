Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218127;
	b=wf6tGuSIhamb7bE16KR+b36Vdqrxu3RApfzxAPBjgzoWvcXL5wCCmDP0qJJaYi6aM9nf
	 7VT16O8u+8uMyzhm/y1xzTlnqKjxZ9NQZfsYE4NJHSaeFAkXVtDOSaKvzzsoAWYKaJiu2
	 oObCGnC/Bb0PLD/tkuCTf04ifNFMpNdxdiBh2lbmkgTGiW4TSGq6eqeP2wBFkfEYtB1/X
	 SNPhhNAJF3QwzLuTgkXnBtzmMmbzk35mq21jO4IjOtffFpnaYoAaEBJXTlTdh+hPZHpSe
	 /1F6WdZ79NJzWtygtsPd4dL3XfyG1hSaNMU24Fb9psm6qt+ldVMTZQOj+0/9HWwUhSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=whgz2xp+Qof9xdVTPW28769GBAl4IHLoKq0HlwY7cKs=;
	b=wYY48vqOhhDKHM81vZYcnTaW/p8JTGkPMmmez2FW5k3JTaQEhBYHpD6V8/8P5IFnlPrR
	 MUMDa2iJF/vF+O0kriiGt5F4jOnejJ+5h61fpnU9L4hh8Ak8JPQymsPWtAAB7+gagcAuN
	 RD8OTIb2TFeueR8/TJ498SxEdUzbtnxYwBa6JDYH1khxBrnQYRYQZDT7DyzhKjVfux0sc
	 Bapbm1PtOMvDbVJ3dYRrzDS0ER9P+G50uAvDqAusWg6MxI1iAmgiGCZ9ZJUwxOqYW4sbM
	 jspvsjjPqXBQugTjHDuEINCqaigdCfAWiT34dnd+5dwWsNJCerui3Px6HdVOER8r84w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xORv2qdf;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F4606A333
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 20:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320F4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xORv2qdf
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so12914605e9.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218126; x=1793822926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whgz2xp+Qof9xdVTPW28769GBAl4IHLoKq0HlwY7cKs=;
        b=xORv2qdff9ONSS3gk/vFQEAVExQiBOVC34Yt8gjGgWCu782oFeqi2xESe2mXz2ixYl
         h1VYq4254ut/hY36SsW721Dd5O5a2VFmKJzL4XNhwIuHfcXpiosIJd2Y0MNway87Yh5P
         xfVY4HPd0MAradlpYlGfj9szHpR4i9NnegHXTSpqWGPjyZdkQVXuQ0wrH7pdwDhL0r5e
         m2XDQ0j55FjNuo/9CM6Ku4m2/Oezs25Bx84Y4lrigvnCoMn4nygoY2P70YEdJpYrrl46
         1BmXvXKd2fVoDML3FkM11jrHKYbb3Uu++cq1WoGrcA+bs+ngNSvAD72pbARjQ9b244YE
         ey0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218126; x=1793822926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=whgz2xp+Qof9xdVTPW28769GBAl4IHLoKq0HlwY7cKs=;
        b=DSnDkJEq3emQHBlPODqDjTzXBHUPxEU8KPEuW/pmQOp84ATHDuAiok8MnmQopd3KUF
         4q6rCbpQQKS3g2NMs6n75OwysTPqTHoM7PXTXwpA66GzGve4O4BYkgrdsMkA9Xb6tQSj
         IBGYGlzdI44Avm3M+DNtFtDmK7JDASq9FJzBtg2CUHFCufG2P7qQKUCkV/kO4Qe4amtA
         Llj6EyoejPKCh1ucUpNgIQnkt137HgUuPXxIpGr5KPZBFKIXg41XZEcuzTs42PVw+P9Z
         7iHA8Jp59kY//Bg5WFH0h4iL82U9B0i/Lu1by+DpfA0o1n1eE+cvrHWIfSkbDjLj40BJ
         uMEw==
X-Forwarded-Encrypted: i=1; AKwUvByFsMayoD4zj2thdF4cxrvjaHL0hxjlDaRuaDlglteZ4tmL0Ujt8K6TJqhb6462t4uYQo4JTzUIBj/E1w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIpV4c8aePdznW8tcrLpiog5fv0HbNI5xdErNJh6CLbEAvpQj8S
	bQLU7GdID1OyEV6SlZpZYSb9sp2nUrzksNpA/qK7GS/ZtAMDa/TFbn+aJuCCSA==
X-Gm-Gg: AYBFou1zlFICyMgBfAFPiWrARK6fZQnlD+9uz04l5k6zLxFAh4leUDUZHSF11ySZiJ/
	DvE8757lAVcl6PnKnu5yzm8kGRSHiUoEpSIafX8SaOce80ZvIP97+mo4gyZPQTgnycyH89H+fuj
	71FUojz4Wb0vQRJvko8UBXd5ABCrO5j3sY95+0LhVZ9nQePHIRiAHSxnOTg4MmjIWlKA57NZ6XE
	KfgVMLOOlFwBrxFm9UKJKkOfW921cmWWjJ8rInBo9vmrjJhxZXxrqBBj3f7oa4RUvtAhehsbJA0
	s7txtvWXBkGGsCY4HZb3Uh6AGVPmDez5CtB+tw8wNGViN+8Ms2R+ZiJS0JYSuLmeoFCTQZq4J+s
	CIZh2p4MrrvsOLml+BuGwvrsfu5p4Z0DbmlXGbIZFBfvZIsO8VJYpenYQYVy5yd36BTABa4H2Ye
	UyMM/ADAAnte9NefxDMAnYSCi9fKhS4j8mfnkRIJNJ7hHfDPhPVsMVUgJIjnRUHLiiknbjJ6Py7
	9czRa/a/gQnOMdEZdAS5950XPAZU5xr/OqK2LVr3CHk1mRxVDNwFuDTYs8RdXrG5+66p5EiV/hR
	0A0nFOWoCHcL1aQKyA==
X-Received: by 2002:a05:600c:810c:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4a967e8d6e2mr76409945e9.28.1793218125585;
        Wed, 28 Oct 2026 13:08:45 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm30134320f8f.4.2026.10.28.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:08:45 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH v2 2/3] HID: elo: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 22:08:38 +0200
Message-ID: <20261028200839.202670-3-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028200839.202670-1-mail@taterr.org>
References: <20261028200839.202670-1-mail@taterr.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the elousb workqueue.

Use flags=0 as this workqueue only transmits outgoing output reports

and is not depended upon during memory reclaim. Using WQ_MEM_RECLAIM

would unnecessarily spawn a rescuer thread and trigger

check_flush_dependency() warnings.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-elo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 86e8729e1975..8a96c0f7d5b0 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -296,7 +296,7 @@ static int __init elo_driver_init(void)
 {
 	int ret;
 
-	wq = create_singlethread_workqueue("elousb");
+	wq = alloc_ordered_workqueue("elousb", 0);
 	if (!wq)
 		return -ENOMEM;
 
-- 
2.56.0

