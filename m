Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523F38D688
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144678; cv=none; b=IkE4CGXNqnhwwmvkx1i5+5aHfYk8f/83T+GAkrlfFb5kzz7R6mUG5v9k6Z4CJ59H91R9lTsEHJRnQl6t/RikWwVqHwBn1wpLGVpaPq3ySpaDMDxYM39icEGCFshGKLw5aBrvN2ixmYbCLriJ5BX0u2nLXzttKBATCcHiUiBjOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144678; c=relaxed/simple;
	bh=kDux37zexnLOGh8VdMuPwY8vE7k5m7s2gavlNWMAuFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDRbpC5Fc3SpLHvMCpyMpc2BV2rHsj5CZ7qVU+5RSPQAlWMl1GSalWhYL5QVTDmpH1wYguV7YpOYbJX6ePYKVWDsveO4u5PUrWm1Fk32HFWeJx3aDZqzlrl1D1os33yVVhNCR+cmoKqjH/NcqTJwGarvR5QB98MK+cU1dIyZOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGJ27AUc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGJ27AUc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso852947a12.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144676; x=1783749476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdTmxlQdCLPDy6vLV7fvg2daIcNL2JqaHKiT0xd47mo=;
        b=gGJ27AUcClJjXmBNFie4KJbIH/7C4jITwBf7yZ2PH8yEi7Dgyyx2zh8tTdFH2y7sJl
         BDHjsQ/mUo59plB0NsS2xNcEvVy0k6G0bX+g92h+nJzSDzfm81mTTMy1Eg9I/jgsN88C
         6s6W50ZQkqcReNXW7VXEAuwBnDXo3QEJG2HSTzcCx82PfuxPJ1Fll2faf9wvKm+NrkGB
         um94fhpDNj9kut9zyGcoCSA7fNZMVIhr4rwMA2G2DudkUMtKYoya59NeDNhIYqxIuVcG
         Hnl5E0tFHsxZldmF9O3YndjYa5OWpmmq5q5ZMUhiDvfLr8uRQxMZ8NUVqGp+FvooieOv
         W5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144676; x=1783749476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdTmxlQdCLPDy6vLV7fvg2daIcNL2JqaHKiT0xd47mo=;
        b=R0imHpqT9W8GtJuml9A9hdEznMpFyCDRsyafSOoDh/O9txoN++S9q7x/2EGv4Anggc
         i2juC1OAMi8/Wh4De78+xAscmj/DD8Wy7rOI+FITeXd0XuyUmns5oJT9bbfhB2RccIJj
         Rk6Naphpr9qwbgHOH20EZX/4jfUz9iRvCAHaeTTf4rQ3hb9qZDGdMq9YPLGh6Ji1e1MX
         WCEU/EsR30VFn/ESWhnxDF6YHRVP8/wOzJl29XHRL4AqbpGqETbG5+yKO0nLo+EB7XKo
         Xa+o1qxV1iWObVWeW6yq+9HndQhRoQWYuj+I7pZyTSJvpuPR+Z1p3xiIAbxk6H1ydw5c
         AB+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9KRnYUTVQwdgpCT73cS8Q8g9MzBuhcFdSAeEIB+RL4TNnEb/rRLgkYTJbdnu3+Z2dqS+dsyiDpzGCOSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjofnWWfWQ9OXa20vHXsarqM6EFRpn828YrRHHksIQigL9lVO
	cZIEzp+jqwtbRs8A7DwOsUpZFcS73+AxjM3PSTzzRgQW0RNt93wfJQKv
X-Gm-Gg: AfdE7ckzJpWoD7MxHl6+QmWxBSCa4BmfMLO/UrhpfFBULI9oTOOCAPueVJJnJ/Vrx12
	e6s5nbiTN1PITcg27PLc1p0q4NQ7lPDcEVQuBNOJKDBgOoVuBW3f5tBN42QKHtLHazdrElL9LnV
	m3/HGx7H+x/hTUxUlvRJLljQ9TB2BLw1po5E5Ws0T/yDn/4Vb4IgFSILUpppElYBr2J0UOQjw5p
	qSqWleVHVmm8d4fAk+6ux32dVcy4X6kadA1J0vrvh99lswjr6zzhP1CK8ZpH7hmOLzIWx2NKLsz
	Nw9mRTzMS6VxCdhLn00WaRciCKnEH8QJnlRCXbJH52AMFt18jHtPA+jsGU/Jovrp4eEwl4wpxoO
	E8S9wJhxP2Fcoong4EZQ4CmmJjS+MD2yFf2fsPbCH0DaZFS95za8iNelCiJ+yOBOHF6Kala32WS
	mJ5iwK7grUlaRjk7pwzpsjgGGtJech/iCb1rBmqQEIeGZeqGN/hwj4ucteaALySXB1jMCp83JWR
	mY=
X-Received: by 2002:a05:6a21:1bc3:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c03e21c2e6mr2608163637.14.1783144676040;
        Fri, 03 Jul 2026 22:57:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:37 -0700
Subject: [PATCH 14/26] mtd: maps: vmu-flash: remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-14-41e424964da5@gmail.com>
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
mdrv variable in probe_maple_vmu.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mtd/maps/vmu-flash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 10244e6731d0..8f7028ac1b56 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -772,11 +772,9 @@ static void vmu_file_error(struct maple_device *mdev, void *recvbuf)
 static int probe_maple_vmu(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 
 	mdev->can_unload = vmu_can_unload;
 	mdev->fileerr_handler = vmu_file_error;
-	mdev->driver = mdrv;
 
 	return vmu_connect(mdev);
 }

-- 
2.55.0.rc0.799.gd6f94ed593-goog

