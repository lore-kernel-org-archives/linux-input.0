Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974B2931C9
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179324; cv=none; b=kMgtSPQ2HsijNbcYi/5T5eibtWZsrJCKaDTn8dygjB2X4/2j7iVJlImpb8rRgYpxH8/qt1xSeyvGgdfzKhU6n6f3F5lipHazJQBS2r/ou8pJhHYTQRh9NQibHrPxEYRJBcuzv7ONK1qh43kz4K14Le9ar+L9adVhQ9MXIy/21Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179324; c=relaxed/simple;
	bh=H2k/AAjpWs+yQB0dnrC+IkFEgdC3qO0Kxanddzie1iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wd3Q5pz3ewdwcs4390IcKD7W7ijV9GwjEfIXcXJ2YcIotivZb46X7FQWGOwccPD1MuzmJ1H5rXq0iY4ssFov3QmuobsBB9iwf5mFXuarcRuEMeJ/+35dtr+H0DGnY0UjebTrBFjO1vW/BWOaVhTv+umpYOR3ARM3cb96jgOAU+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBPZURAs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBPZURAs"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e85499ffbso226762585a.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784179321; x=1784784121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAxassaZbi0foqUKMXHqAeI8487T3Ro1Dytg2tkc3xg=;
        b=LBPZURAsUGO1sNXXXw/4P/kyggZpYEv4ivYbsJnaQ25C0J8VUL3Is+KkpAbeSrlMI7
         N84v1jZULv77zqdFwKM02csaOaRQVBjkQsvWcxFFimV3vKOvl9sjmxPDaYo0hIt6lw6C
         O8R2b2ChNFCE+nhIRz+dkMRTiu+juQuuaqhSt3QpcsoR+En5cx4dPtW3I8/JIMafJHge
         f6ga4z5j7jZo7E8hXLs4UQuHdUFB/sgpYqISrUed4VnpJ/+ZAUrNaR+cvXlGtFuhSPHk
         DC3BwiTa/f1zM2WHzH7Bt8TakWmOaSowB0rkkovJ/zUwS3il6AvzQplRQsYD/GC+3kyG
         dqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179321; x=1784784121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EAxassaZbi0foqUKMXHqAeI8487T3Ro1Dytg2tkc3xg=;
        b=el0cgStJsQ2HPwzLCBkTAM66IL32e2Ic8P4OvS3CNmgB1UtLk57KuMeTK+pZhbTODd
         ZTte/DSnPPMLzfgBrWy91ooR7dKpPqdzeciU8BUqtd+Z95y02z/gX71oQqBfuEzLLBeA
         g5TD69PBck3+ogodT5b+sRtslZuN1a+2Yq9dNL76lIdzMWUtUT/ZxnvRLqA4UieDCCb3
         DWkHZYg/sgeLPTWa5waHGi1iOHbOHvz2QNqxZzYWFn+Q+3Lk3LxAct+I2cYL0WRGs0/F
         0q4hmgzJ3DY09VEKp6awAnmfI/3DgXdeN5EFWnFwtVe1aVsV7x9YYbBQsSuXlE109lsA
         f2OA==
X-Gm-Message-State: AOJu0Yx2xhNM8M4JykZrsScCj3vOQYs7ZK9nqViMczLi46EzKePhM/pY
	VmyXQf7+TThknWeN73U7z+RmCYcPq+OOh5hvdqDXAMYyZ6fSyT6mY34=
X-Gm-Gg: AfdE7clgcG7N3bUuLtJCUdWHGX1sJvAXukAm8JND3Xb+cVQYkG08pW75f3m9rSlSIGX
	qakTAfctabix7k6NHxRgp+GtQ0kOOeunhTckXPRQ8tevn/Aj+YRTMGiu5UeQ3FPngNVy+yi366v
	7FHObzVryfYbUsvYmAzSaM/OkV8GDujjC2YqG5jQwYB279z36+g0QiQbcTEmIXAguwi3hRe/mI+
	u2hxJ5PiaftCvVfsTwz4/rHR47YxSsZZS5LfPSN2VtNsD4YrwRhk2HepO00ij2PWzgyxSjjHNro
	++5sKxj4d4Mw76iR1PaTzG3MRmD3R5fBa2tyEww2LHqiEBn07sMeMIUh1Qkkf+73IJ1SoXq6TZW
	XJxw6RU5scqg6u/ua180jp3Q1V7LmTCcKIz6GJ51HvZHWJ0Al3yVj09CjulGLCSzmDVHDe0v3cc
	R/aMSVcrb4IKSE
X-Received: by 2002:a05:620a:460c:b0:92e:e2a4:ae86 with SMTP id af79cd13be357-92ef2c6b27amr2156087185a.80.1784179321076;
        Wed, 15 Jul 2026 22:22:01 -0700 (PDT)
Received: from kombuis ([2606:a300:900b:eec7:948c:da6:4bb5:416f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0a6sm1920541185a.8.2026.07.15.22.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:22:00 -0700 (PDT)
From: Owen Giles <owen.a.giles@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Owen Giles <owen.a.giles@gmail.com>
Subject: [PATCH RESEND] HID: corsair: fix typos in comment
Date: Thu, 16 Jul 2026 00:19:44 -0500
Message-ID: <20260716051944.29482-1-owen.a.giles@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260118185815.14237-1-owen.a.giles@gmail.com>
References: <20260118185815.14237-1-owen.a.giles@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in report descriptor comment: "obviousy" -> "obviously",
"Magimum" -> "Maximum", "poper" -> "proper", "due Logical" -> "due to
Logical".

Signed-off-by: Owen Giles <owen.a.giles@gmail.com>
---
 drivers/hid/hid-corsair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 21cd8b12a..82bccaf1d 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -681,8 +681,8 @@ static int corsair_input_mapping(struct hid_device *dev,
  * The report descriptor of some of the Corsair gaming mice is
  * non parseable as they define two consecutive Logical Minimum for
  * the Usage Page (Consumer) in rdescs bytes 75 and 77 being 77 0x16
- * that should be obviousy 0x26 for Logical Magimum of 16 bits. This
- * prevents poper parsing of the report descriptor due Logical
+ * that should be obviously 0x26 for Logical Maximum of 16 bits. This
+ * prevents proper parsing of the report descriptor due to Logical
  * Minimum being larger than Logical Maximum.
  *
  * This driver fixes the report descriptor for:
-- 
2.55.0

