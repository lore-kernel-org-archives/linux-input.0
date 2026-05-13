Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB047DD7E
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689978; cv=none; b=VMTygzQGQ+CrGNAlGa9TaUcXa5CrZrDmV007/Jf21H1xsYXM05vM18bA4xZdPMa8Xv+lDR+xLQ46BSUrYsJIw2OwAy8rk3UIfbMAcI/gZRRWBFdbkYuo1dMUL6h5YSznWbNs7vWNfUsDpBezqo0Chm1rXAqMGkNvq8d6Gy7xgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689978; c=relaxed/simple;
	bh=JfKFS0K9nP36IEkfYAv7a3/MHMkRmXjmrQjYbR6VFJk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njkQn0VnC6uOT4V6yr1/YMSWoZ/Vk9X8DmFPLyyFVGchiSl8mINRvX/3vDU5Zv5SxZRorwOPh4W6t2NFtSjbef80wp+3yn+x187ojKH4XysS9U9q/3Xy3srDXcjs2QOE+U6G1qHhSAF0IstDLoGrz4Ox+R6UMDd6qcNeX3KJUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3MhWZe8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3MhWZe8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so57908405e9.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689975; x=1779294775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxebvTn4pavgI/TQ478/jxnqJNji+G9FasNQPUvkkc0=;
        b=a3MhWZe8wpDvTh+J+upkBP/W/zSs823xoJ6fEJ7o+EgmGqsmjW2qaZtVzT8HlGfKKo
         9cyzzv5svSoyiIXRAaV6FqptpYsb3Oj1gAankzWigy9MMmk6buop5yCKxvwOze4AG2xf
         k3YL7kPV8KLbPedEaGui0wUwgfBS6mWVjuk4TiblgLui9AhtBFH2eD4Ttb3TrlTC9tRD
         7pm95O4ve8UN+xFhyQgKKMcZx09WpvEpqFLQnUh3RSOL7nqOBJbSLZXfHFaj5W4lo8us
         zD+jV8HmQNxXHXhdKxnRT7y9YeI9fZAGDzlfNDR6QffJ0UFZ7X1BUCgMasakb+7Fb1Fb
         aKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689975; x=1779294775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xxebvTn4pavgI/TQ478/jxnqJNji+G9FasNQPUvkkc0=;
        b=EFoeFdqRsM5ljbbMgzM1Xo2i1ZCxPtQLdLhnKEIPS2iIqe2K6THO1prT5IXTyI1Rtz
         m4P63cIDwp6WPIX1Wue8lcZ+evx6X1A7kSOs90aLvpSwYGHxJkfjEGsOqPwmiaqSOYE2
         G3TYITsYkKCCEPI6aPw33rBWvDuoP5G9VNWEytZV7JFJncBJQ1g3Gx/NrFpHaVSQRoqv
         8wzJQjwqx7E2sVwFdHg8uycDR4F7Fnb9Ca9PGN5RbdAYDHoyqMUw0IcgMCBIvrgr4iMg
         La3nbvJqP1/Y7WaCQ+QztrTtobRee3Fp8Luv2r3Q7ETT+IJQ01dAMemJfoUg9N3BS/6C
         H0kg==
X-Forwarded-Encrypted: i=1; AFNElJ93rDYEYCTbWxOiISiliZBrNoG3i/K5HUgtrYGUHEPZsWHe5zU+0oHriAlXGF+gRlDLG2HgENB68lSx8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuL9xJGxF4EhLdOqSX9ajrpXs0OR5uYCJWl8sSyy7AHhgSAPiI
	54RCWKsS2rwSqVnkQKHfsRCzWEnHekax5ZvgVyd5QPVcJkakRNmpDNsB
X-Gm-Gg: Acq92OEem81wbJslyTJvb1xZRsTVp/QXDWCTxfLjo+AJtpVFxrvnVFOpCe/Q9j4zBYY
	F8Xvee7UK0zmXgR16bP3MiUA0FqDgl/yIZAHZxURJtjfKO9gxHRtKrcXaLoqgaKKu4up4tL7Agp
	doIUBU/sR0eJhVphUvYmH0METbRAZyZUJduCR4QSEKjnc9L5k8Yaqjto7G3uGg/ukOri3acPtQj
	QL9Tu/PooR7/rxiMe5iqommtBeGzecQAweOq4Q/qamWcaPKTdxcDe6KSET2dCQjpay2QCYj83ht
	2KgvN3PSTh/8yLPVCVR0cCYbxZrpyMnpxWcDqUpRMlcJKnVdCcF7DPVXAKL9HcRf193YLKZ+3/+
	oP2C1Flbjaa5C4PvTqB7RDOTncd/dDuQlJC+AB1tKm/YtaFB2cR4kfSomorqor91h2JawwhqeY+
	XPFylxJHvYUAaEG1V9XAtvQ+swy+J6stSHOgfK5wVRSIMP9BcLONqvR5E8Ipg+bcWiGBpjH46DH
	fcCU7Y=
X-Received: by 2002:a05:600c:468e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fc9a3d8c5mr56740785e9.20.1778689975018;
        Wed, 13 May 2026 09:32:55 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd648a7e5sm2258745e9.3.2026.05.13.09.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:54 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 4/7] hid-asus: Remove more bogus zero bytes from some report descriptors
Date: Wed, 13 May 2026 18:32:45 +0200
Message-ID: <20260513163248.16483-5-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2a88ce695489d..cf9184ed2d3ec 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1422,14 +1422,19 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		/*
 		 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
 		 * (FFh) and clear the flags in the Input() byte.
-		 * Note the descriptor has a bogus 0 byte at the end so we
-		 * only need 1 extra byte.
 		 */
 		if (*rsize == rsize_orig &&
 			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
 			__u8 *new_rdesc;
+            unsigned int new_rsize = rsize_orig;
 
-			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
+			/* Clear bogus trailing zero bytes. */
+			while (rdesc[new_rsize + 1] == 0)
+				--new_rsize;
+            /* Make room for the added bytes. */
+			new_rsize += 2;
+
+            new_rdesc = devm_kzalloc(&hdev->dev, new_rsize,
 						 GFP_KERNEL);
 			if (!new_rdesc)
 				return rdesc;
@@ -1439,8 +1444,8 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				"T100CHI" : drvdata->quirks & QUIRK_T90CHI ?
 				"T90CHI" : "ZENBOOK DUO");
 
-			memcpy(new_rdesc, rdesc, rsize_orig);
-			*rsize = rsize_orig + 1;
+			memcpy(new_rdesc, rdesc, new_rsize);
+			*rsize = new_rsize;
 			rdesc = new_rdesc;
 
 			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
-- 
2.53.0

