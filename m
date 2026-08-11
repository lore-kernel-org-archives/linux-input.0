Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BB443ABB
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450844; cv=none; b=O8xU69F4bq17GQHuOepa7k6QooR4bqYAe2WmT+YctIcfP4YzOFW9jrlnFayjEffSuMz7488kth213nh8nvz46zcdL5t7rwUu8+OWwqu2fvyDnpEJcwd0B6RfPUykZ1odGqScR7lZKD1+L4kQ034ms55xEyJxOE+w/kLqH9MZ1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450844; c=relaxed/simple;
	bh=FmJ253mDx04B3QJ1bIl+tfh8HdALdb4bRYDxE/DUlnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEsTwcJnxLWMdKQgth1DDoDVpSPaBqq3Fbda94UrgpgcYwhvPmXA+VmX2HkCHShG6723jN2vE5iKOSE4kZVaWSYvt3j6JxyOUbtEljNWv/l6N0SDPgMAHKx3gM83NTawX21TthbGHaXeiiCQ8+VRemV27J9Z15e09gIjztVfLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Az5P1T6S; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Az5P1T6S"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3036754b3a.3
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450842; x=1787055642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7I9lwGzwg7czeq/kM88e0ae+cNOZS1aNNH4lK4EhTU=;
        b=Az5P1T6SPNsGLtkJZ4qiKSiRDN0IqSJ4Fr5WPSXhPTDbrZM+6P7BcyMJujMcLWt9bw
         8eZJDQepy4D8n3HN4E6X1z6Uk6HiPTkvbrNxIRjtB/DcMOuHcFufRUYi+G5U36EY/m2N
         VYoeHpTPPvwqpKm60d2GWfdJeUHq5hkVHoQ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450842; x=1787055642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L7I9lwGzwg7czeq/kM88e0ae+cNOZS1aNNH4lK4EhTU=;
        b=f2iQ3Wj75vFBAV1a+9uIjYh+AJBisznkDpMoM1OVRcZV6iSsSyohz9X9t+f5NHGCxK
         kq+ZqNzFDQDs5jQqGvioFoxPC3R+0eTxnYia16/Elk0lcQcKFD3rlfF8vfSwtP2J1gBD
         cQjfCTvV6uXq9so91GL04sZ6Nf4oCuOYVU757bRjDpQkdkFRtLEZbO4hvRv9Y6Nr+NHz
         lqjwRIotK5VwtPsZMi6bctfK2EbWstQOmXNhARc/c6BzCAX0r/0qLWgWTrqIYwZAqbEK
         fx5zJ2pV3W5/jiZ560X80wD20nn67Tk/ajuo7Lx+h9kZphImI359BJZh7hRw7/0GPBHC
         jTMg==
X-Forwarded-Encrypted: i=1; AHgh+RpK6e1W7iH0P4cHcyFs9N+V4uQt5blsv+Q6fq7Bw2+HccAP76fVgT/k4zGKy3f8OdgEqREWUxoR1OtdYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mBkwmsp+RCRQSevWfHmeu5lO0ic0s7HBDNUuzLwySOslTJ4/
	uq7z8qKvIzEYZOA8t7wIOoaU70MjwEOQNd6zsrUx5+RXX2HXrpf+4Ghm19vAFaxx6g==
X-Gm-Gg: AR+sD12l/9p9zB7EKfg5C0SFNKK9S4KppGHTeHwsM3nVt7e0Idsxno6UGpQ8RV3cYFk
	USQgHW0iTdjGfKQ2MJEXBm9DV1W8uG9hTXdY4QbqeMsx9kQmnqNSS+GzzTGkQBNKNLhtdc8lF0c
	X5VK4VLTxRCfBbyiMgSBXfX0/CiUz7pxG9s/V7+DSFc0/gvGaoaEs5/fYINx8rX93ujcH5lm+9L
	KNaXzSV/RYWT4cxA7zOxwgT/eJrrEWB5/eNHf3iq/kYOshtQHUg+C929IJLlUOJRIhT6VJ9kkrY
	3Vvctz/7EHxbm7q/kv0HL6CDSElNC/KN0kWbfxHOcLzKJUrvWFMR0MnDJx4ak2rKTt1+7fFY5O5
	1HXffi0Wirq8hkhYIN59WW/nzAPQlBpBf2FdtcF1RgGe1BjETCj1Rsb2cxBrfbPHp/T1nPop02j
	T+A7pA+UcoEwG3QSdCRr6/jqCqldUBAimK14ak15b1DvTWtpMddsjTBzmQPWWugvDn0VpMsUV3R
	FGdhU9/o8z11qEXWnNh1GlELD7EYY9kWTDyX0LM8EiYNg==
X-Received: by 2002:a05:6a00:23d2:b0:845:c906:5ff5 with SMTP id d2e1a72fcca58-84fa8842ea1mr2725202b3a.30.1786450842194;
        Tue, 11 Aug 2026 05:20:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/9] Input: elan_i2c - sort include statements
Date: Tue, 11 Aug 2026 20:20:02 +0800
Message-ID: <20260811122011.3539250-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include statements before adding new ones in the next change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.55.0.679.g6767b8d81c-goog

