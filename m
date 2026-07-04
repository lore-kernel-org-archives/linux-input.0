Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED438D018
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144677; cv=none; b=laAR/8MU7KmmrBe81GeyW60lr5QQe51X7F+DiAWybdFKdusSKhvq9RBUDXqqMsOZDQbGCHY4M/uwWC6FRH7mbXbybM+T+oM+67EEpy5oVC33HZWG6jGFI95QZn9ZAtxfheyXlmMgPn6oWo3fipTSKCeGSVPdqGmEEi90snoJbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144677; c=relaxed/simple;
	bh=31waFKIZGxX4PPWcLhnRAtyChlu/qYXY5U953fMygGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUqZQl8E6vtiJgnehnaDMCMbb/H7kjPTfDf5GI7a38t0nSp33AQHmvHuHIEylrc4W5jb+qzNLjFPawaiwJmhznXHXSaotGEQvQ6I4sKcQaWf4J633KV3fSBSO5xdt9OOtvHoDjVCrPPcTXFnvLYYziFAPC2FnX6QfNvBkhYNppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQFr9Axo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQFr9Axo"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9d265355so910529a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144674; x=1783749474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5F7LxDsRkHtfo4eJ/PQP5nz/gnv4TgKb2uK7bw1iEA=;
        b=qQFr9AxoVmEiGkxE2WROc/81Q5EdMxszk3VyBmmDcOt6KFjwLYGq90+jLwP4rnwElw
         ID7ci1SWEGBjq0Q2hNR4geUbc/r0qrWhPXiwqIJ9DNnZe/ImkKCiXOpCvcoPuJlIeoTk
         pkA++jh7+STlFO79bF5cMBhzfTPZuL9NBtLFc1Mcl/LFDiPhRfJN9tVy5uK10ZQRoOOC
         G5O5+C31gOCVta6twwe2upyL4rFpr2paT72aQeQJdwhNuQRfWo0SxYz3OvJQilVDGMAk
         DsxyNNOk3HRRbkmuqaXCivyWnRp7oRvAlpYZwWTTHhIr971YX7a8Er3GAN//uhnYkMJY
         9BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144674; x=1783749474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5F7LxDsRkHtfo4eJ/PQP5nz/gnv4TgKb2uK7bw1iEA=;
        b=PlV9zRItiE157Yt3paI2NdIB+MDsEiR1mynxP+GsIZZZvKtp26tvxRJ+khm03BM55L
         XJH1DoCGuSjqi47yPuc4hbY+Ck/AcHhmU+hd5wmkpAE+CZ+yQ4i09oXFvDTIBytGHPxA
         6/Yhb1bJsT0EGwLsebUUXSiKlSqCv1tNj/QH267bdK6CZ0P41KBx2h3MJYaiIYeNP6bT
         P7sdL+qllcddsF9hJHWcm3vyNLIpG7i7P3hG+X+rYbf5C9kH6J5Nz2adwS9sWVN8GPnG
         1UKrNx5MbuhSxMBkJotxPhfvQOYWiSTpJ5iPhD3sBfIHCQqX759BRGSEBcb0f0Q+WWXq
         XlGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNcjQPg8E/mtbUgNSylYiRCRzaJ6p3yppEbDZzbxyC7uKnjXtyQ/2df3EZtz7bivfsfwIXNc/oxpzLrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhJ5TDKAx2WnVEfpje/rHmEYNc+ClgKZhRdD2VepEwYsAMidg
	ceR3YaAk40iUx1go5zD9MDioJZAUhxpNarz7JDEbPVBze81+fzJ0VHi9
X-Gm-Gg: AfdE7ckghj5PdMdPSbHKNbUHkzEII4R3MQxLEtgrGrX0rScmaOEgbXQCv1HY6u8isSt
	xAu8ySAAff64iM50fR5DTGBVHjZ5VaMu9Qn326e4m/+hmDzFC6MFU4Ldu0pkMKPp2Qm8nkidCPm
	HtpJMwBDWp8uf1ydmHjAUfFYEYiAzYmZSChUhHJOsqLnIinbSHXczP6tA9i0CduNUMyQmZirSmt
	016wUoOWIxE0q2ceJtLqZcAbGxrXWb7zYxALbNzwJznomgNTKQdYPuF/TmDSs5iifdAnagWgbMT
	3Uxsq+0f8ko9sAxciuRy1ipWPeV99Xz9jKjE+60llp5y6owocK5zmfvMxKX0nkaCWxKBNV3RR14
	lvIKQwuR2n8ISy83mWiF4tB42iIy+O38XQfU9AjBLhYA2D99P5aP1j1v2MYhrkvUPKdqQXTJvxW
	7MgpAVQ3MPLjtDs0OwryMoEQ4c6pzUabex6eEnXViMDUtOPeuGlp0htMqNQfzKoVnz76UWRDn8U
	6Q=
X-Received: by 2002:a17:90b:1850:b0:37f:9ce1:735c with SMTP id 98e67ed59e1d1-3829f5ea616mr2372239a91.29.1783144674303;
        Fri, 03 Jul 2026 22:57:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:36 -0700
Subject: [PATCH 13/26] Input: maple_keyb - remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-13-41e424964da5@gmail.com>
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
mdrv variable in probe_maple_kbd.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index 0c92138bcc77..e277b929a375 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -161,13 +161,11 @@ static void dc_kbd_close(struct input_dev *dev)
 static int probe_maple_kbd(struct device *dev)
 {
 	struct maple_device *mdev;
-	struct maple_driver *mdrv;
 	int i, error;
 	struct dc_kbd *kbd;
 	struct input_dev *idev;
 
 	mdev = to_maple_dev(dev);
-	mdrv = to_maple_driver(dev->driver);
 
 	kbd = kzalloc_obj(*kbd);
 	if (!kbd) {
@@ -206,9 +204,6 @@ static int probe_maple_kbd(struct device *dev)
 	error = input_register_device(idev);
 	if (error)
 		goto fail_register;
-
-	mdev->driver = mdrv;
-
 	return error;
 
 fail_register:

-- 
2.55.0.rc0.799.gd6f94ed593-goog

