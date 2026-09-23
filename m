Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2348A8A7
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161091; cv=none; b=vC+wSuv2ba6Pm/p/l4pocZPB5iW6ww+VXp8/MHhXD9nMCgEO/vYBROuZVBnBoVbAlsfW07IDZYO16NJRBH0tZdFbXYAfUye/9lI08/2KWUrVyZ41/GBNwmjNlqk7op/ufgsB9fEUbTfdEpMkOh5+p3Wqc57hP9fm7b1Hnd0vT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161091; c=relaxed/simple;
	bh=rS2E/4MHN8oX+wH7iWFSabQRKWvtT5oxQlLidA08taQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrWVfPhIkxlssq5OSUUVXoqqsTU0G8Q+Za9FIxaqkIvnd0k3kXg0LEqAFyzmBi1ujJ0GbyGZR6rmhUERbK1S5iduVz6QSsMYDpC/aAKCsXkJEJGS0ttqoBOuTf7Q9xVK3fY8RQTVeNIGV1xMbCyy+22DXnrTEL2smMfdtrvSIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssgQtPLz; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssgQtPLz"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so618444e87.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161081; x=1790765881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/cw8tLIDAcANE0rBxwCaZOdt393QPndtVfDmqg3iEZo=;
        b=ssgQtPLzYCY8PksrmwNmXbGmNuXCa88jO26ZO5G1rBrRORFKZWW65AFYfgLycwr+FB
         wDbgGtp8pLMY0PHgE1w2jKmHiKBRlHKqiQW30WmiEYBqyjvm5EpycqGb/uPb4T1cde8A
         nDcq+F9eGU7TSevPaHlL7SweCrbmv0QFEg556w4vsRjvU2ASjFAzY6aFXYzA0/8UdaNr
         FD+oQ1iroFfAnaaewl5Elwon7EsN3QKkLh+cLEKDJTmUYOujSrIE79RKu9CwZRhRrZFo
         3tFvqP3ocvlavpdw5Pbf+2VUnHxX7FRzloiN4othSFttepsiPmuJOkm8fU+j6cvS0HQs
         M0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161081; x=1790765881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cw8tLIDAcANE0rBxwCaZOdt393QPndtVfDmqg3iEZo=;
        b=C6sofwExwyjhBDfqm+dEZCUM8hb6u4x0nVtIP9wT8I9dCyEWcymKKcIZE5FpBqaDLo
         xvSdO0GQM2Tr7rIKEZPwGhlsLCzKtw/e2qIfWnNnYU4NDabGVQFfqF6g2lcqQD0hVL2F
         pOQl1YrMjY4mnBHUu3eNOZZGuSRlzVN1pJjlpeHZT967Hmd+GF8gd+2yLZCjk4H3fXNk
         wCLf/x0+WqiQ3bgg8NwaLbjLdA555w3anmpUfmk72N1DBeLZL/OnOM4BXIvZ+gAWXGCf
         1vlwFN2ZWoe43U8wuarpF9g5mN/NEOF1JljbCkuNwaF+OtcT6N+dw0uK35O955eODDzr
         cq3w==
X-Gm-Message-State: AFuF++kxuwD0g/OHaY2A+oRuMTw+MZfUOCWFmhGKF+RJ/ei7jn7MUpRa
	0ArMAOafA9SGBDfarrg/aXmN+jTNk6DF2Xjc+N4CcWcY6CI8LZIxFrMv
X-Gm-Gg: AYBFou0hRX3exkmrwcGihzjdLFDPa225gzl3nuaCMuERBwZOodnvN0szyUCAElLmHVG
	5NMgD2D+Ge3Tmjl+M3y869E/reRxkRDu5kjg4/MBII4GxkvcpxEcbBe/olfcZF32C9Nysi4jVUR
	LZ1BcoYUjkx8t3w/fPy/tbCUikr5X4+n4AEt6HQruJq1GFbYklNSywXHB0/LsYBnoZjb32uJ0eX
	C9bAfyPyydHWdet2DZ6uu7QUnt6AQqyw7jbZ+3EH4auw9KX1QXPrYZZAqfJKk6WzpwL/0uKLukq
	ZP7LWUBjLL2KjwXFl0FGEbojY55D/2w9/2boJEyh/UznjQsX+x2C56M4TJg4Nl3oI9JKim745rc
	+xtQ9lmVbOwcbVxPNL0aI8LOzYFv7yDd7daozjLGokgTHpibB5ISWirMrDssG8N6UdibB7hIl1+
	SoH+Ly2qAWJqw68Iy08+vdC6yavoHbPYsn0xyaOJjGPogNwWQS55VEKYkn7sbCgOR3JCT1VH8KA
	Z5Kym1DghPDoljoUYg=
X-Received: by 2002:a05:6512:318d:b0:5b8:bc5e:b580 with SMTP id 2adb3069b0e04-5b8d89c111dmr839870e87.56.1790161080622;
        Wed, 23 Sep 2026 03:58:00 -0700 (PDT)
Received: from DESKTOP-7GRJKK0 ([188.226.104.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d858ef85sm499606e87.62.2026.09.23.03.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:58:00 -0700 (PDT)
From: Vladimir <anykey196@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-input@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Vladimir <anykey196@gmail.com>
Subject: [PATCH] Input: axp20x-pek - add AXP313a support
Date: Wed, 23 Sep 2026 15:57:57 +0500
Message-ID: <20260923105757.260-1-anykey196@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP313a MFD driver registers its power button cell as "axp313a-pek",
but the axp20x-pek platform id table only matches "axp20x-pek" and
"axp221-pek". The power button therefore never probes on boards using the
AXP313a PMIC (e.g. the OrangePi Zero 2W).

Add the missing id table entry. The register layout used by the driver
matches the AXP313a, so the generic axp20x_info is reused.

Tested on: OrangePi Zero 2W (Allwinner H618 + AXP313a), kernel 7.1.13.

Signed-off-by: Vladimir <anykey196@gmail.com>
---
 drivers/input/misc/axp20x-pek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d89..d4e2fc9a9 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp20x_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.53.0

