Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA292DB7A9
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164881; cv=none; b=Bat0P/7NYg0Uf0s+sM3rTvgqB+WhNwuzELxH4rEX/3GaFcGvpLkv2kqNQvO05cJskzbTDB4VGpM1D2nQmc1NDbAY6Du96gXFUO2bMOWR7+hoXjRzWh51sk7ojAWgQ4vEz7Lj+wrfW7do5w8X+QCnoq/iItXLVrLdh+i1zUT5rAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164881; c=relaxed/simple;
	bh=6Mn8R6SRKRgG0ByJxNxVjB3oNt3WphVQtDNMtYHQF0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH5cXEGsyb7hP2ENeWEDXqSO7D3iSk+sslG97w73SVLZqrLwQft44F/aH1EQ7fXBjqpI2Tu4daT7ep1oAa2HlQovvC9TUNkXlbLz/sDcJf6MfhEJ48S82Lfd8oxCQjT2lLC2Vf6j+ajZU8gJuRk/+6FxNk9GH89Kxdzl1fhtMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkeuzaA5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkeuzaA5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so121152a12.3
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164879; x=1771769679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIGfWmCiwzhVm2oaMsxxKLqRBfz7odPdW5C10ge7suM=;
        b=RkeuzaA5Y6pY/LKZNRfY76nFvwIvJRCbS1p4vi9TEMnaMFhxXmEiKVPcWzNJ+b477R
         HsV4ZjlCorLFcXNoROmZxnHUSyrn8RYBJ6v2NnvBqnMzrc3UyqMwkD6pb/fdaygHf7sB
         cji3D6kE6aM+lulhC0RaNziOSJkv1bSP2Uyrct+2YZpwI4aAKmRalNfkDFTqlS5+nXfc
         cHBblqG+WI2Vr/htNq+UqWRejUgO2tf39mkNh9Y59MPDMk1WmmsId21Hd2TJOYU3+YXm
         A1D6/67ZCmpRX4s+NZssud3Kuvhy8vok8b2tZXEmpiREwozF4oNIMe4/vutZZ1qt/2VC
         b4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164879; x=1771769679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIGfWmCiwzhVm2oaMsxxKLqRBfz7odPdW5C10ge7suM=;
        b=bQdVauuQ1zOfY34BoZf0ij2lRKHWJ7GF6T7csTrRw5G26IKvWQyjl4ZI9erLgq3Bu2
         W2mVDxmB9EmPWqHCxTU8qhd3yzan1PrrlfQ4VR/QgSeqicUF+WEEjhY0YMS8FGe1N0J0
         VJGlBH/jUO9LV0E1DxNhH9XutPiI8JS2oF0AgAyElbEQNUZEv4GZZoimuA68d3tqYL4T
         LV+u/kQQnoJw140U/YKobqlThVCiWDS0jtWjdHb8hvSquW6vQ5pbLRcNN4yv6fDL89l6
         vWi0usK1jpNDOaCtXPMxMCLrvHSG0K1nxOgWaSJPDivKDBPI96rdg3edyON38JvE/h7r
         n5jA==
X-Forwarded-Encrypted: i=1; AJvYcCXbJWDirhNbmzqsL+wUGDELUHRqLBMXqKJ+hS14fR36kamAJkHVphM7m5oSFdwdVFJp1F3noJktjeX7xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2k4+AyKKtfgbHZm3BOeMy8MW+ai7TqIoW0/Nh6TXm4NVxCHaz
	WJ4cgGhf3tE1S5jrQi9BP8H2xpDHwJaGbv/kjsThIJJWz9fWXq2C//bO
X-Gm-Gg: AZuq6aJ9oSNzMNr+ayyrdG0+MBpWlBkW9WQOqQ1YZRWcflBdwn08QgC9AIKUpT5LM5x
	Obq8W3V10R2TRObqf4+Kw+NPM2Y8ErTp61QuoefudEkAlaytqBwEI/wJk/BjH0Np5KNg+GHMw60
	nkYITVJn7ISCOKa4FQaT3wg44s2C2ZIj70ZNAKbatXITnQrwGfBlckpvZ+eTz7N1zWFfGf9ARW1
	Tw+mo66uPzv72FlZhao9iGPNuhe4CPROpVZ29Leoei4evLNMlnb7e9klAxTdWy8RJLjYg7IhNxg
	O5lIlmi/Uf0LAV5f9Xo9mnks8zOA0rAYOn6IPuKEF/hVgMIRlOiOEOKcGSXI0p/pgGti+BfGcfh
	R7HUVBHy6nPtk5fJ/jCC/PsZV4jJgyR1RTrkCV9CqHJkytns+UiNBKlf7+ccJPvp3XhRD++EYXs
	8RaBBsK1ASJp4UaMSQK/M0jtMe
X-Received: by 2002:a05:6402:4499:b0:65b:f08e:d4 with SMTP id 4fb4d7f45d1cf-65bf08e0148mr756952a12.25.1771164878846;
        Sun, 15 Feb 2026 06:14:38 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:38 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 2/5] input: drv260x: Sort all #include alphabetically
Date: Sun, 15 Feb 2026 16:14:32 +0200
Message-ID: <20260215141435.727872-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215141435.727872-1-jekhor@gmail.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort all #include directives alphabetically before adding new entries.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 18360bdfe877..c352ff2859e2 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -7,14 +7,14 @@
  * Copyright:   (C) 2014 Texas Instruments, Inc.
  */
 
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/input/ti-drv260x.h>
 
-- 
2.51.0

