Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594443635E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620451; cv=none; b=D5NieTx7YtOGJ/KLXjfp7PVtcrdxufVRTBwlWtrLMPCBkhxKHKrwKEu6xT1Z7bsGjEW6RUPaGZ/J7D5rDaRotDrg0eNGT0SgbWl399x50vWu6sAfQFL4QXdziHAzmzmlmq8EmhSpDSe4aHn8bODMRPkgvXzAMuM1W4AJ5mr/M4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620451; c=relaxed/simple;
	bh=2aTFqtE74mVxCKzF4QnPnvxUaPaVEshhhNvwJjbpygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLRxa/jVwUjnisJr24+YCbhV2IWZucUscp6hN+4NI07SZLzBG1khdwiWrpkK9tfjOwb6wpo/J0/E/Jl5qSlJKt2H/YKXwP9ZepQ8pZSch9HlDgO51UxhLpGCM1P9ylgjhaRXfeBZC7wGRGyHOLnM1a6q2yhnanrS81dY7RCEhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QCREa322; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCREa322"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ced3386430so72811415ad.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620449; x=1785225249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGtEOhOpR/1OiCj9qufh1O1atPkJph2JTGUTc+kCL1E=;
        b=QCREa322kDGkOIcVNmQA7ZLYuVCx0ATnZ6BtEAahiV7+gMVUOGJbT0KgwZj8rUG4FV
         0PKCCg9P4rU2izCqIKLUjN2rfkjI45I0/QtUQvZlDxVwpF5OLDkPK9o/ictCmGddzeFL
         QUFL4Fi4tKNER+1+xEoRDWJfqVDytzdsoLeoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620449; x=1785225249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGtEOhOpR/1OiCj9qufh1O1atPkJph2JTGUTc+kCL1E=;
        b=JOdB2luWS1belIrQExMXh3zN8AbuFpjj/ahoZ0DJU+WWERL9WOZp01fTzHPSiPnKit
         xxh2a7uEJp5FWCyu0kTf/2qmFw5CcFK9AuZgbi4WSKhlpjLXGHSlbCWGj11LuI81o9IL
         CoCNTWU4MDetFpClYTbnQOSGweP1d/h3nXlLlxTZ6qWAmQNvQBTeJTrottecH7/cqvmr
         vOr71nfT90/d5bv9KbXsFWt1unGPHxFQ6nOO/W36fpqD1TKhL4kvblfA+ReJgNNPbP5V
         T88fD4dcFez+b8vjOAGLnMjxB0JcEg231EBHKIiTijRDdC/p/3BKC/uJkjsOQzcR5y3s
         xPGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQUUbSvrP4uvEl+BeybvqGN5qYiWIsChjrYsiOv8hvFm3EGDc4zFgonwWwChNO9taBvqbuoFDGV9g6Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGfHDCThe3PfAUxlXg8ApbOlIp8YgjLguBSS3sp4gOgmFEaAK
	jLgYUnz/7ky5ANqlJZFX5/No8FvE7VKQV0VZ79eyCQOx8QsC0qlTdJecWTftEHVotQ==
X-Gm-Gg: AR+sD11iV1uKaDKO5qTIl+7teLyyq+FgoTdp2S9pmFnulA+bdgxWPj9BTTPbo46HdkQ
	NU0V0LIekvNouf8k7TPzgBh66ZVsSgM6+tukkKmtNZOEjhXDufwZOpAIKQ8AcwtpurR9Hc2+Yh+
	xdtmvbLRFTobC7uffse3lAVEz89VupzeVkJVKyKBcAGsM8iqKO06qxyoP7uTr8TRyC73RCyb1y3
	VCWHslANIkPz/Xxp4fXBCsRW+q32Yu0tP72NQEX6Np8FKcRAmwJKdkur6le0JDLda9Prz1/iQw0
	nReIYkKSL9uHx+3WZtb4dclo7z9Ec2pZNf8AoYgf9CTPNjxmNUCjQQfAoysfs//uVHYY/cjzjE8
	9U5h6enbzhPMO8/N52n+I+qJ+g25O0EwnLE+Dw5vvazAhfHYgSvb2CWgLMb/9KpR0g3gWv1kLd3
	HQXO9yxj0lpdJ52UsdLLRl+Y+M6o072sf5t83oPF46SGyvplSaDKTzuQo8D0A=
X-Received: by 2002:a17:902:e748:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2cf3494aebdmr189718205ad.23.1784620449012;
        Tue, 21 Jul 2026 00:54:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] Input: elan_i2c - sort include statements
Date: Tue, 21 Jul 2026 15:52:16 +0800
Message-ID: <20260721075226.2347933-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075226.2347933-1-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include statements before adding new ones in the next change.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/input/mouse/elan_i2c_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f93dd545d66b..9f024a435dbf 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -16,27 +16,27 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string_choices.h>
-#include <linux/input.h>
-#include <linux/uaccess.h>
 #include <linux/jiffies.h>
-#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string_choices.h>
+#include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
 #include "elan_i2c.h"
-- 
2.55.0.229.g6434b31f56-goog

