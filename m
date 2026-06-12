Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CEB3B0AF5
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296056; cv=none; b=g82tsadSY8xYQs1SRng8/RjRPTK+AHZVSbCHAG91YtkKYe8h+9MravengyNPGMQLjQZK7ZwNiTY1gyQi7Wu0hO3BD+jgA+v1AdosYidQI/4Zd/VVEAye2fvo3w+c/HEDqy8cXiAZIQDgh1aX/+jH3/a7X3XbJJkHmERKJQe/4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296056; c=relaxed/simple;
	bh=CR0Lbo3n/3oeNiXmZXBO+NYu4WLlnQ0plwOZWYPDaYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxcaE78JQ2bHl/VnxC3vy9EPPFJDJSk+Y/miI8FYibAplVyqprcvBvyOanzmPGn7ZDL+WDyJkc13pWeIFmJaZJ4JM7qt7jSA8RznIsEFeChJvmBHWUtutlBihBu7Svbj2jZiiX/3cQLOHDpQRRAP6aIL1gYXuuIUdRWuAzL8iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX3X4XwD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3X4XwD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so14376715e9.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296053; x=1781900853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uiu84fLHByfY8NkkF/LaIKJoh0XbICVZ1vVfqMiiSs=;
        b=FX3X4XwDidk+/aBHU4zOsuu8EexfnnSbElbBLzbr5DlEHYw8iAEGatYAm1PK+VQov2
         GET0WP1+3RjZN2XqIWln8ct0z1Bh+1oiXP7isYi7mB7+YrNR/D7Z0fk2JJrZf6S6hdj1
         N29LOQmumTxN07mnPsukXeTdFt5XAZ5uUVM4MYWlx3Mh9jHhxvbyRMLURbjcrhhJrxf6
         mfuU4VQL1RA1rr+y7FhOzn/6bg7yMWnacPLhDS3+Yhj+IITX60JG/oXRykNbQ8bkp8FX
         vLFepW0ZrjEx6o/zMWcz0VGyTM7LD8Pg81Hi8Enbnf/majjfw18Yt7z+wlEdlnGoU1qD
         6eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296053; x=1781900853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uiu84fLHByfY8NkkF/LaIKJoh0XbICVZ1vVfqMiiSs=;
        b=gojhVLW6bzYksRU6gKHwK6pMU3kgCTHKcgoEP/LjZ375Rm6aaU4QpdPz0e3fgmYx1r
         7NFuFP9XOMb6P+8D/J9wwCDKFcFU6O+YGXWg7pCROtRDzsbaYid8TA0l5eq37rLz5/UK
         9cKwtnObuMCwk8L5xO+xKHrAT26I5jI4+jTFbZw237awB6SsGhYvASw6GdhTwZJn+LAq
         leoBKN76lo3CVyW1v+AFqO9oKGGHiP6Q2WMjgKcaAo+oD5ej4aL6i+HMbDPtkIKfLA/C
         U6ZLgv5gO+3We8RqJaXVBHmbHPoktqPqygu8yMQxe032haTAS+NwzYHEKE7Yh61eZizE
         rEIg==
X-Forwarded-Encrypted: i=1; AFNElJ8O4+isthzy4FEMPvl4q3lzvedNCYvOr9LExjcGJ0i8aKnCn/FcaXhonXanUpVWSeB8MWtt02OHLIKw5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBJWJybDX6P6Z/HEzc29gsy6ln8GFoKCcBXIOT5v2MlH+Vt4+
	6v6cIOuGUf5QIQKyV+5Hjb1zl4M126bRmDC3qd2nSOqsshVK31OL04Y6bC04PbEr
X-Gm-Gg: Acq92OHXqoPSromdKfiWOzxplBb3LbOjb2veAziyEEJ7WQeaK4AUh0p5zz5cSDeeSnF
	AoHz08yLcUNFfb3qK1wYudpiQkNwOMs+CmJFPjWAq02+yfL4qFOsbocoxHP4D+GtW5151+AYIxx
	DMOqahc5UC3OiUuLX1Yp3aiIIDNyoKY/T+9P+THp4H2o8jCk7eCCWfv0yLGYntWdLgRMsF+4uiL
	CyzV/WVyttw2DpiimDydTmARyG/JlAMz3vPlHm67lEQJCIa9+3aQqoQZXc+hGQNlXnvAdUkjcou
	1F7uFcvfJcAKFb27d+Ecu0uGBp3YzB8axGf9ag2ELQ9JZxngG7Sjq+JARkQkzmX5Y1nnhLY+MrZ
	J2+dH3IoVjS7NuOGJaMia+ajnkdR6OAq1iWgWc3UPBBEa6SwQHtZbLQhMkqRxOk6PmO82GuC3EZ
	f9Jv5LZiPxQOdQwPx9
X-Received: by 2002:a05:6000:428a:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-4606db9667amr6456265f8f.6.1781296052923;
        Fri, 12 Jun 2026 13:27:32 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:27:32 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 7/7] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Fri, 12 Jun 2026 22:04:12 +0200
Message-ID: <20260612200717.361018-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dts to be included by all boards using the MT6392 PMIC,
providing support for keys, pinctrl and RTC.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..b8d943e47816
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mt6392keys: keys {
+			compatible = "mediatek,mt6392-keys";
+
+			key-power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes = <KEY_HOME>;
+				wakeup-source;
+			};
+		};
+
+		mt6392pio: pinctrl {
+			compatible = "mediatek,mt6392-pinctrl";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		mt6392rtc: rtc {
+			compatible = "mediatek,mt6392-rtc",
+				"mediatek,mt6323-rtc";
+		};
+	};
+};
-- 
2.43.0

