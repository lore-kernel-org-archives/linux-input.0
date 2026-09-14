Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB77410D06
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426393; cv=none; b=IOgL5xmObUZl8swJrpfFMVWfkNVjlJSYYRpq9sIXV5/N+IJg2tNWNXYlfbN2ycVVypfB4e4jswaoQswRlYfCJPIYHUGPIl2j87zLGXYXEliuxqOr3iuUsaguTg7S0BmNE1FJHb/QqyRgN2SYNZ32EKMaOgc3Aq/qrihTEcSPFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426393; c=relaxed/simple;
	bh=ZuOq9RLAaVoK2JQN1iRsIvHe30yGLSunUDOxw5csnQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBfYo0dOQw0ydHepsAeUTtTs/qTRNBoiUcP4oqTDkSc6mSdDCT3UJ/PA/ylgifhPPZ3yoEJMu0yD37GkYYWP1FFMK7NhEqZrWeS0CLbW9HpJlIod0AdxWsHzgw1S/L6uFe7BIS3mqsvWAVVDnwN7fR6jUiAaqhSAeJZqIr2M4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOdYmtPr; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOdYmtPr"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so22206545ad.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426391; x=1790031191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXpVCxEknnDOBO2wgTMiDMSPtQ3J/1cRefmdmIu8XSU=;
        b=KOdYmtPrPd0p5M2Ao1rK3dJUTCUCQv7Ie+HD3s8ML2u9XtrWwSp4kU2LFz2Xd2M86K
         bnVaW4/8K5J1kLWOT6KFZn8z9FhIfIqHVCWQPDISifiFOxA0A1KRhUv5KJPtUtPcd3dA
         xRo6zMiVLhKIg8+LrCWhtXVjYHWS8lprCT65JtSq+BrMn1XdWLES1BkoQOh8Znyq11BD
         eQnnCRpYn+cd64S/ohSj147bWxgNx1J8XydzzHz1Qd4ZxbG1XmQSUIx0fkhJCkimv9UF
         7Y0ZLPFfIxSf24DK3xAXqoBPAyV74euO1t239CLMvkAPSwsnU5t75lGZ3fYe1SFmx5Yf
         qsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426391; x=1790031191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXpVCxEknnDOBO2wgTMiDMSPtQ3J/1cRefmdmIu8XSU=;
        b=LIPDx1kN2dMDWB3M6zzja8NTk0jBaCb2RWBt15dR4Kh2Fbtx0anEZQv6dARxRX4mHb
         76kxOeHmQG763BV6pITkTYuMMo7iMlLoXhnd4OcAKojmrjyN7cUDjZ8/XelzlWBwXtUT
         5MEHy5Qho6Juu2m8XBVG8d5WFw9/dPS43obeVtA8NCHtAmloYsPO+RI0IZhclvDa6zuC
         BIn9BvUyX3QxFehG7h1Cta2Ez3oz5IHQRYHxqbx0YmUk8AcfRlVe+fPSrKEQ6aXSM8FS
         5Bk3frFian+P5t0KmplGq/1NQA4d0YxS9rvpwfTm23lCJBitwr7hsKSImwg1NM7WvQ44
         an7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwER8mozS1XXqJCUqkTFaydfjzYb80arVJdY7dcjLAEowbAXAooRBHhqH55/1VtYUWAffJpe5Y1SOuFMA==@vger.kernel.org
X-Gm-Message-State: AFuF++mronKBT5L1HnuGWfM+nI7fAMZSjA/oVUG1IEWQ2IS+CP9Vh7fe
	jZLniVBJ8hin9mPvCc+EOPsiQV+PMQbCSNAsHsdZxx0hIyJr1PQ+Pe3I
X-Gm-Gg: AYBFou2wsimni76wAhyD+5B2h2rx6GvHl6v5GY4jxpH53UFXnta9pvOue3duF7d9vlY
	JW0WhTPi99C31nMgw1pVfKiUf1i+ZUqhZxPg37jEh1w4sjTNma21tHde8I8wyM4ddEtdHTVX0kP
	Gmc3E+dxu6Uwg5zxMio7VMnryVDYEd3mwV4DmQGEOCvtPkSHioQrJf9RMO1zk/4+lkW8vN4C+Ng
	WPAWGC0eYQbw3ouuLR7fgrsXOnIQ/EGp7FORxgqBotWviklrKQp8suGAzhSCas3O4s61uvL6bCv
	ucv8kj94mSWaSA2QN+dD3fNEzKlje4XfdH+6UmxwXFkhjz/prLWeHIP9/EK5NTYy8g8zsFX4PJb
	z4YJ+cvFSf0lCy/fhBYVYt41nPV0HzxfkMPWVi6mZTOSNvfnfuXlgUknC9nebrZB9W1OJm2HHX3
	KdVjJ0TrmTLvEC1H0aNt8dYd/hqDxKE7yZpF768fQPDy9Iq4//gKgQdhK6Vq3y7ksg1FngT+QkE
	gzWGXSfZBFyzNu0qhqMmNUGDqFdI5VbeIKtdRR0FP0z5nSCLr+vJKYwLMi4pdU=
X-Received: by 2002:a17:902:d485:b0:2dd:78d1:65c9 with SMTP id d9443c01a7336-2dd78d16661mr9457075ad.19.1789426391520;
        Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 03/10] HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup
Date: Mon, 14 Sep 2026 15:52:56 -0700
Message-ID: <20260914225303.868569-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_gos_cfg_remove() calls a mutex before canceling delayed work. That
delayed work function calls mcu_property_out(), which holds the same mutex.
Prevent deadlock my removing the mutex prior to stopping the work.
Additionally, since cancel_delayed_work has the potential to re-arm,
switch to disable_delayed_work.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 36505d8402ff..8b16fc7d151e 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1442,8 +1442,7 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
-	guard(mutex)(&drvdata.cfg_mutex);
-	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-- 
2.55.0

