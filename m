Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7525356772
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632421; cv=none; b=bLxHcC1p9Qw7iIW0ms/cjjuqNqHdZ6W8YjjXzhPMY7l1HIFTynx6pBn2wVcFL1qBXjzlnTnMtVVV+eplF+8FG8btrVis9yelihBtJFzYYL7uZDcHRoBu7eU1ql7mo9nuBcCO+c7xOsxoqBTPOnuiWv8F3/gqLgI+nKRBQvmtVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632421; c=relaxed/simple;
	bh=cRuzIp0YKHNVkHOrNUk+CYNCeyPuFKnnKm3lwy7T2Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+zYj/eRpBeqsc1uY7EW2U9updzCidfKjesBCdYWdgqxqPB1r7VjArY0izPWIVVCs7ciUZH13fTqxnWfqcgMzvfUaiedm8ttTFJ4prvww8dzpEdGzxYMTwdHpeR+pbJo9pfhi5R1zjh++9lA3Xik6gB8/NoEVKjjTNoX2RCVkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a5mAseLU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a5mAseLU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ced3386430so43721125ad.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632418; x=1788237218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3x3zvQVHa95aIkNqH4RuqCyE87uGo0+4gPg8D8l4X4=;
        b=a5mAseLUz17+WwOGp1O1stqEVmt+F4+9JwoBJr2emmTS3J89/GxvL8TEJdgOOql0AB
         e/KDsQkkdntGrN5ellJGF7oHU2woSgCJmbEfcPqUyo/XCFo3RmNCbdh0cT6gh7GibZ2E
         Em6y/Y5YR+h1wx2CrkYGpcoXNq2ksDmOftYhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632418; x=1788237218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3x3zvQVHa95aIkNqH4RuqCyE87uGo0+4gPg8D8l4X4=;
        b=lmIH6Y4upvgLpC0YXNlLR3VmZExnNrSy26MaxYQGjxmTbVjYlkvYzTY7sZhICEQCXe
         wTf5r8pg4tmlC+EKSwS1QUOOVV9JDRidw9IMIbS3YYuIq1IihAROp2qJxGAvbxOFWRlC
         uo+iPXvFfde5J8QQUqCcZn7LfxLE803puuQ4Usbfb+lUbZlVYP4iu5XmBRYk8P+/9wSH
         jn+RvJRqDm+0TyNpvH/L3CeTIT2KlERezxz62NZv3tGKrht/0VGY6IavPy3uNPEsDDdN
         GLYWXwUu+0kKDL6WD2gzFD6gcfvZj1NPFYt7p5w7m3ub3Z1z0WCORdTsqIl6feXdjSNQ
         gyYA==
X-Forwarded-Encrypted: i=1; AHgh+Rqbnv6Es3oq5/gp9aRYyXQ08f6lcGAHQogDDS7ZqEdeHF8Vx8uQ0RCdTvbWZby5AbqGVUHPpql2QOYiSA==@vger.kernel.org
X-Gm-Message-State: AFuF++kII3k1Xwmc3wQ/rvGI6jF6Ta7ZHZcsBIKiehnlwUTihhzhJoDO
	nROTxu4k8/TG5xtpeXRqkeEeWZNU6DtTnL1rL5eGjg7/TlYLHuHa3rgKWUZdQ94tMg==
X-Gm-Gg: AR+sD12lZ2r+M9pKYJMQgbiaHerWIopLXFJlVcRmI3W6hpHuCjRBAWMnz+YeDXzNVfG
	AJYAMvfoqiuLJ5n5+F1uqVImS9qJnlNUM5c7i1o1PRgU5FrGzOUpCZrTSYdSqEQC3ABRXhUcmgw
	0VGkqkYKZSGtlHtwbATOIvrUDim+w/XPaJpopR41/GfxJ/W0e8aGQwqCUSb6ce6enlDowInrzne
	A3QyE1w0FXx0lixpdxUh3hlun1hqaPu6cE/KY5WRsSMMzNR1HDKatZBdZutWu7tio0s50vxJlsZ
	1Rd7iOLvcvkoSPlkjYXk2GsI802VG+L2x2nGB2SS6WKv8+1woo2sX3gLaJxLvGATrhvW4/SryWJ
	GZw17T9N1qn0yTXXpzjlUqZ5qG/T+z/GV4pzzS9LHoIVAurqY4TCb9lJGTICo7XHlnebrD0BfNi
	5MHO/6xw9PqgHwQ+NWDk0OapPJi0d6POSqOamQm7VUiyFcfFY4GcQnQGVdrrUVFq02GDeOxkH4z
	sWhdIu3/4rVODuD9+FNL9B3+d9R+BN7t7XcrLkFuqsla+M=
X-Received: by 2002:a17:90b:574f:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-396463f1346mr8081145a91.8.1787632418173;
        Mon, 24 Aug 2026 21:33:38 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:37 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue, 25 Aug 2026 12:16:20 +0800
Message-ID: <20260825041628.988369-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
In-Reply-To: <20260825041628.988369-1-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Link: https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5e505edbc33..4bbc6cef8be6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1260,7 +1263,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1416,7 +1419,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.55.0.860.g4b6b3295ed-goog

