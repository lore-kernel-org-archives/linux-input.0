Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769C15E5DC
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030474; cv=none; b=BTT3RAo0+EfIbi+e0qZll2oG4F57OuP3z0bG2ZobNuqXzokdiq4l/IVuLFzK2gyWiK/PjTB1nyHevnD48+n18i1VjJDmCb3SzFcgOe2u4SXL2L/pylr7sWy84xRACSAefcGFkqNLZx+02uI4fC/9a9tZhrlerB08fZeWYKW3PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030474; c=relaxed/simple;
	bh=tfzgwTa7BiktryzGWIkcyRE8N9h1/Jk912Ti1RcchOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHSTinfIqwZLksDNZNzAyPi1EKsxjt+Snm8IWVADMLT4dcpELJBTzo4tG7Juy0q0hqxuC2hacsZy94q0Qo2Qm1ZOmLibGNKadGgtM9QchgwwHuDVGAaJgrWPaYWZTmElfeG25uwPS3jFUNVPZO5ACw73ysYh4mz1XCJWjPZpJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knNTRTKK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knNTRTKK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceed7018c8so4346035ad.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030472; x=1784635272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=un1/HNmxd017xfWTCfNi2/7YdurFwymQXIdYAIjBxB8=;
        b=knNTRTKKBpS5xNKvJ1oeWh97QAwv7gEO9ddLKItmGWlNDus1Vtzrkpp+oG9LDyPybe
         WhVCTd6qdbBqnnXqbNtw71UVyZRMt28vCXbaCDUxjXut2lf1HX6QncpuU0/Z4Un3Oqms
         O30cechpnGV7XuXzvTSngQHxufesthpDJbToARb0lgVLx9tsOF5dqsam+SGWTHtM7jFl
         SpF/S5rIeBqGMw3EgmpcV/aF7zFICLwFOs7N7ichZudwnXRbg2ZOiAwxh+6Sz5DW5wHp
         06svUt2Ot5bCOv71wt5o4IYNL1nWyqrhl8N7xTsE8zvR54FNTI9oF95BxO9l9GBMm2ii
         kytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030472; x=1784635272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=un1/HNmxd017xfWTCfNi2/7YdurFwymQXIdYAIjBxB8=;
        b=tSfwZs2z3q43mLjwPSqQyNqjWER3kvDLUGimcdyw6shDR5L/rABmuHlGBU3BQQs8w2
         E0/TRJT0QVgbr2Twzr4N3pJ4qQbwvsqzGAlNpp6SC//twrdGk+zE5KoUBohurCCLALu2
         Cgiqy5/z4h91XP28mMNo+xhanP5juvejiEqfUKzkg0i063lN1RDLgWAG2Nu2ic+X5LmL
         YPEuD3Y4Qq3i2d/QoduZpKdHHqB1vSXiAnTVhjAvJgiMxWRFrg5qrQ/l7TR2vRlGSA3q
         wEu2ctTCLrPFNP70jFU5Uiz5A3pg+yIq0VM0wtu0KPIi7nIwtfVXhncgTzRlt+M6/X9T
         nJxA==
X-Gm-Message-State: AOJu0YzXwpZ/DfXDs/mPkD1JVxsuOvQ/6M+omEfGxBVne5S3tTDMvvbD
	iAsh/XTVbh6xWCZjCsoCMBC/b+JcrPWI332R/NfvGq5Zc+1xmhTCDP75
X-Gm-Gg: AfdE7cn0fNRv+iytn3ujS3aJ6/SblUX0V0WyVCvDtKq7oryc4AQi+J6R3i5oJ5o408j
	lXNjZYxPqSi7BQRp04oZiJKduXIizciJYVUKtUR2f6p5MZR91REkb2BzXUXSupzUqq+dRe1hhNs
	Ljq09oi8b0GMKqCTqnFIF+buEjE9EoZza2LrszSUUsuetzDHjlQMwgT6mWFtEbe0tJ54fzbQdm8
	OlLUGK4koi0woSvpHnK6jbFaF4134rzIzo7aEnhT2qnk8YR6LBrXvYQ4y/QZHpJunM2y9DHez/t
	esT4ZVlVON4kObY7hy9SA/AdudWgTrmoD/JHSrjdRIfLH6XMK0AaZZU8S4kGtBCrJ9uMitoO5+j
	XPv7OwRbWw/t4Km5oF7RmWMMv8ImbUXThA9gUE+fACd4K5P/9bd8yLnaEqtXXaGZ1bPKURSbSmz
	JIiH3DURF7Wx/a6sdm1eUnkvp7GO6i0etxKaTHag==
X-Received: by 2002:a17:902:e5c2:b0:2c9:97a7:f544 with SMTP id d9443c01a7336-2ce9f179c19mr123766045ad.42.1784030472044;
        Tue, 14 Jul 2026 05:01:12 -0700 (PDT)
Received: from DESKTOP-EQETL3O.localdomain ([182.225.143.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm118605335ad.12.2026.07.14.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:11 -0700 (PDT)
From: Hyeonsu Choi <chlgustn3171@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyeonsu Choi <chlgustn3171@gmail.com>,
	syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
Subject: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid device devres
Date: Tue, 14 Jul 2026 21:00:52 +0900
Message-ID: <20260714120052.255085-1-chlgustn3171@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

input_dev->name, phys, and uniq are directly assigned from hid_device.
It causes a slab-use-after-free bug if the input device outlives the parent HID device during teardown.
Fix this by using devm_kstrdup() tied to &hid->dev for name, phys, and uniq strings.
The string lifetime is tied to the parent HID device, preventing a potential slab-use-after-free bug.
Also add OOM error handling for these allocations.

Reported-by: syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
Signed-off-by: Hyeonsu Choi <chlgustn3171@gmail.com>
---
 drivers/hid/hid-input.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..da6b338f18ba 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -2125,10 +2125,21 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	input_dev->close = hidinput_close;
 	input_dev->setkeycode = hidinput_setkeycode;
 	input_dev->getkeycode = hidinput_getkeycode;
+        
+	const char *name = hidinput->name ? hidinput->name : hid->name;
+
+	input_dev->name = devm_kstrdup(&hid->dev, name, GFP_KERNEL);
+	if (!input_dev->name)
+		goto fail;
+
+	input_dev->phys = devm_kstrdup(&hid->dev, hid->phys, GFP_KERNEL);
+	if (!input_dev->phys)
+		goto fail;
+
+	input_dev->uniq = devm_kstrdup(&hid->dev, hid->uniq, GFP_KERNEL);
+	if (!input_dev->uniq)
+		goto fail;
 
-	input_dev->name = hidinput->name ? hidinput->name : hid->name;
-	input_dev->phys = hid->phys;
-	input_dev->uniq = hid->uniq;
 	input_dev->id.bustype = hid->bus;
 	input_dev->id.vendor  = hid->vendor;
 	input_dev->id.product = hid->product;
@@ -2144,6 +2155,8 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	return hidinput;
 
 fail:
+	if (hidinput)
+                kfree(hidinput->name);
 	kfree(hidinput);
 	input_free_device(input_dev);
 	hid_err(hid, "Out of memory during hid input probe\n");
-- 
2.53.0

