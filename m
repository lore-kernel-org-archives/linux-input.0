Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1071377561
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144676; cv=none; b=SFut1fOaj5tp7+ogyPnoL2ZEs7Av+T0v+PLgakdUNV1hgc96ehBEDLj83pZmysChxx8PxBIQdZSTZvbL50mCECrsj8sHtaR9ToE6ZThQJW6G9DZO7obzp25Yo9Acc+jkVAnivUrhc32U41+C4Z6cX0Y6RScMAc1ClK7fqrngkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144676; c=relaxed/simple;
	bh=ei9zSkl0ZeKy9g5ir+Q5or3nGEpQ8+2PbCCg4B38miY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tx0gk8+jB7g1b+at2vXtGOGrslcmX71AtqDzJQ9gJ+q34yT33bJ/BQW2kykP4b1JE3xRlmpijN1Vam7hmL68ZLhSBIwJg1UE5qiicz0vyv/quOmsg6HqjIrbXIbbHbECk5jlK+ZJ4azVEa+PLkJVX5kbOHlb00gt7DBGWQTJK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5LT/7VD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5LT/7VD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so514995a91.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144671; x=1783749471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HP2OCLaMtFKD9zBA/qewPxKeAuiUz90Bk4XmeA+Nsw=;
        b=Q5LT/7VDmwrLkIyaTHkk2ioDY953tk/uMdH5VtmoHK22Rds5ijQhff3HgQKWRZL7gk
         4fxdNcDYSZyTpEuKvHegeLhcz9443jkfqupkINamVbUlCayw/ixgNtynqS42m7NIMwYi
         vmZgVk1R+oAkE5zAgX2RAaxBccvmCEvvKJXdsm4m0b74HyD2MAKXZLYAMnr3I7t+HNwj
         btnMRK+SFSD0/9YXFJ81V7ZFSIM3bOCPz6QdUemc9R9QDtOPmQtw3EZ8VQuCmfuNr0Au
         +QX2dx2RM3yATi13ntVDcgepmSCoTvfWUWEcG4HqAeu4NW6L/iq5Hi3TLYxW66J31etQ
         j96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144671; x=1783749471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HP2OCLaMtFKD9zBA/qewPxKeAuiUz90Bk4XmeA+Nsw=;
        b=Z1XIeH0ShnHGchgni0mt4HJpBZ1swOScxUYiIZpIBLYOPc0oHg0NfMtFWftXzBtMLP
         yA7kDkRd3Yr2aytUGdxO49dqfpBApH+cjv/3Fv4SlR7Zdi4lSrsP+4V6OugXRHys6tGw
         1WwkzIBElFdBSRP26kKL3kgF9g5fyAMD2v7hZQ/4HOsxWycpvGSvN5q2QDc5BRTPQ+DA
         ij6NrQSMSwOgG4TC0X1SCx50eK+QYbwVY2taKyDfW7UA33HbEJUi6EYiyXciMS79K1cM
         EcF0b/JL2Rm62xTfDY4Pry+Ujwf7X4gLHBGY3gdMjiefArdWvkxaw05OT6VSUHIUXNuu
         vu2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQ63tgAwG3WingrzzLe1lyI8xN0ese3vVCt/G5YgF5nYRoew/q8mZQQ97cZCQi1jc/4SbvaaJpGOcUzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOOQXbIsHWIl7NreqiNRmDzoR5yAMGHTxysUxEVZTCUf/elJK
	iQUK9gOAxdEGAhd60Eadv7lr48ZbkFfygGNfDfUXcoXcqa+GNRov6ed6
X-Gm-Gg: AfdE7cldNTNZGik/Dfw4xZXj/h/DlpcFPVUjeyuBDJ44rBZ6R8FO/rJ8G4Gr+1fL7Fd
	pM2WoyWscxnRr9P+MHjz3Vj92d+FPPPr0EJgWPEqIB2WktLnzW1YKA8GrrdpYqYWlFAoHuJeAuN
	a7zJLRheZVozq9lhkiMxycQvRUReEcN+TPex0bLuLJOCAybGySe1EQ6mARN0re4uwxnKeN9cWtW
	d6vNrtnq3FkTHYzMJYOHCjsxdgGjFaJHNQ9StPcfzXjr1dAwQOyPWgDYXiMe2aGB4IcBgoimUQ9
	2c/xMb7vQBUpEc5KR5WxVQgbG+1DRe3u0C5IwA957RO9xqbyPIFZichtpbMfr7iWa7AEe/WRDzm
	Gv1cfN7RDWQt3WI6cYQib4PzTEc/eSR/5d7cHIYTq2Uyj4OPGTk4grLd6SUOpy3mXIOJ6Eo95W9
	8GU6YMyXCwy18lIAYXOfzU93zuSGcoKRii52xurhTiDrIzsQYDdDZr+oOGZSXW08qxL3Bq397Ul
	BA=
X-Received: by 2002:a17:90b:2c85:b0:37f:9ce1:736a with SMTP id 98e67ed59e1d1-3829f9deb79mr2313752a91.32.1783144670906;
        Fri, 03 Jul 2026 22:57:50 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:50 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:34 -0700
Subject: [PATCH 11/26] Input: maplemouse - remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-11-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

The driver field in struct maple_device is no longer used since
commit 1795cf48b322 ("sh/maple: clean maple bus code") which removed
the reading of this field.

Remove the unused assignment to mdev->driver and the now unused
mdrv variable in probe_maple_mouse.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 37f60bbd0ba4..f67e3eb5841b 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -67,7 +67,6 @@ static void dc_mouse_close(struct input_dev *dev)
 static int probe_maple_mouse(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 	int error;
 	struct input_dev *input_dev;
 	struct dc_mouse *mse;
@@ -102,9 +101,6 @@ static int probe_maple_mouse(struct device *dev)
 	error =	input_register_device(input_dev);
 	if (error)
 		goto fail_register;
-
-	mdev->driver = mdrv;
-
 	return error;
 
 fail_register:

-- 
2.55.0.rc0.799.gd6f94ed593-goog

