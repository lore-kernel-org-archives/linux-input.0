Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466267;
	b=mGW6Txx9TtvPueZxf+OckuSRk8YQVfESYmUFlAfw6GdOsocXPOcXwiFeoV0yI7p8V4ZC
	 TzPFuRu2egP3FKf9H1o9Gt6UKVFp+5tGLwkPpHQPVUyT3nfi+16IceW+bFLVO8KXqHYWh
	 fu611YvTCN0CGlhd+EfwtMSfItPrJq5m0d5/KPxWb+rwuna7FjxnOF2kEcxzAn88iDS7B
	 swRG3ZvAbmcUGYfJMvqyysXW3slfAXIn25hHiN4KJyy7bGTS6/olSzVh2rpYtg2SXuyKP
	 YyOCU2wEW4zr6UPQ6t+EjMRayre2sDrDWhdPdZClxZRXGQyEppWFaJmsBYvBgHf7ioA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kiOAjw508mciKfyacuxKAhkD/CSrvZAn08VTWyigGlM=;
	b=Jf+lV7O42u8CAJqMxg4G0zDWbn6eBe2QMOgUwvnDl9hs/tngiSoW1AFsJ1E3wOkN37pd
	 FhqDQtEn0xq+FudDMUVzwMgYM8isKEjL5EIRChjsYni1eqw/wg//WR8BE1iONdDyIkarw
	 tm9e4dlddfXm08FtLfSQp16Hb8XdaT0pNv5uMZ8jvcTaUXkqUaUk0nwdIJF74lQqiMV3p
	 Z4Ehmj+ZQHayFfao9QdC3vwx5ArmmrSQl26sKnJX8qvk+ShzFAMlnI1mUh2foaelAcpL/
	 MWZVgvYAtrNZfn4OntCy0xO/nh65hWL0anQ74FSAj9moIeG0IBfa2WW5gSxOzY9bKww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmRZwGuc;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29D606E92C
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E29D606E92C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmRZwGuc
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so7771950eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466265; x=1795071065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiOAjw508mciKfyacuxKAhkD/CSrvZAn08VTWyigGlM=;
        b=QmRZwGucrJ/Xqka2MHnrxgDhbtt47oO6SidE0J+2osYC4WrpJypN+cWdNA2ZfuLHMe
         GkGpM605TEs2AAxQIKXqc2dn8J4Dvkhi6HhXR9JVbqUxSdcgWsA5zcqnVxT9sLHmz5ye
         3kCelw+udGbw8xXj72vveKmtIOHGlFQTnHENilZnLwAyHwcQ91L17MPyCMdpP361ULra
         1Gx9pAEqz758BuP7s5vscXzsbjEZDpwO+hDDW+1Dge9Qud18zlBJoAfuxNMXn9jHGU4e
         NCRNguefBJ5/NijLX0BFL2yG1mE+fB5kzDzSbtkivVwAQhbiPes4N6VI97bikTeXfzH6
         sDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466265; x=1795071065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kiOAjw508mciKfyacuxKAhkD/CSrvZAn08VTWyigGlM=;
        b=gB47WF8tH0e+aAQ0XdqSgthxt5RRmebIJ63fhA7IUFZD4BRyL1J4o70+JNvAKjB/mI
         oC0kg1bRQdwCddm27355tQLda6afMUtkFP00BqijLIQBNQyPeYlFMX6BYAupYDpS7JMo
         42QnYQzHbY1gP9ttufIdQz9gjeucTzWRUC872SKvxU1xogmfTcyiRAImFBEkfdePN5Di
         Kpx01QwcQ2dUbysschKBP34+aT+D2kb63Bg6yT0m60HbZh3B2b1a4RQPp91QS52tCJa5
         PjuKZEGqg8iQyVj+Qw/2zrbi4IM8LpYUMRyVi7XNHmSJnXhRVqZV/FJhwz3Pv9sKp8Ph
         k2PA==
X-Forwarded-Encrypted: i=1; AL+hErGo/XCSdwdUqIgARJ/LdKuMxdpYKuE7rM0sYrHd/0m4jxuqoz0aceLd772qDbgMaWm5F8GxCqg/441Mjg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kcJtc3GkLQnGIC2RJzyJS5U2RIZtD3LMis4n0RVleUPbQBoGM
	BMKxNHHpjtHyy0UhUjUYzM7ELHzr6jw0mNl/wf99djZh26bMEgrrCtW7
X-Gm-Gg: AYBFou2ccxzvGSQB+C/nnYNuA7eAN2sA+7nb3eRpZqwVx8GOYVNkSqDDMtRdpS5eMh7
	PrXTVPOGDb34JaiOUDQfBPUTcFUfePRDZufcW+bQXcGaiE86jHkcBl67GTDscrITCgqYIW1vlUE
	bHVS2QfpLXBGwlhaEm4Fk+vv4hNTD17OanpaZPOmhOSVNFp7lcNajnFsThImeB3d9FRgZdSF8id
	8uOwzj0RxIDxM0fFDWfNHb7q59upiFRMW4gUoU4QFuZjGs76UgJIrzBtyD53B8H4nvO+umTmDoj
	EOQnbL9dUMQpcHHbdJINRyU0JYQeFOz3U2+ffYRkdySrNZx2JOV52XC7EDRpDojIUNPxHrk2UZj
	RXoBTbf1SfbAaEkgLYBnkVBfwEnLJ+OIwtzXhqnIlx6g9icvVrfjmSvGZZjY7Qbl2P5LY66sjfX
	NuM5er+LNuoUsHpL+JI4SKZTEjQdzan7Vy6gPb6SY1whfdmzNG6ZFnnTQDBa/TOLsNxBL1o2Azx
	AdRWUkBcepL3G2X6CC0jvCSLM91qMWjuUvlW1qdFpCUMRcI1KP5Hc9om+/aXkyoIc7ZxehgRyg4
	mWrUBLYXgkpueqcU/Fp4HH8VGQ7FqtHJ4DGw+IZuT9U18lVP1rgl/iwhPLIeAXtMfX9nohEiGqu
	6UtouRWPcz2hu3+as
X-Received: by 2002:a05:7301:796:b0:36e:a321:5353 with SMTP id 5a478bee46e88-3768385f3ecmr4818851eec.2.1794466265270;
        Wed, 11 Nov 2026 22:51:05 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm20788624eec.9.2026.11.11.22.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:04 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kim Kyuwon <q1.kim@samsung.com>,
	Evgeniy Dushistov <dushistov@mail.ru>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: max7359_keypad - fix coding style issues
Date: Wed, 11 Nov 2026 22:50:58 -0800
Message-ID: <20261112065059.1802480-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
References: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <linux/bits.h> and switch the configuration register definitions
to use the BIT() macro. Also align the arguments with the open
parenthesis in max7359_initialize().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/max7359_keypad.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 686832fe2931..c6673bda67ba 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -10,13 +10,14 @@
  * Datasheet: http://www.maxim-ic.com/quick_view2.cfm/qv_pk/5456
  */
 
-#include <linux/module.h>
+#include <linux/bits.h>
 #include <linux/i2c.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pm.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
 
 #define MAX7359_MAX_KEY_ROWS	8
 #define MAX7359_MAX_KEY_COLS	8
@@ -37,11 +38,11 @@
 /*
  * Configuration register bits
  */
-#define MAX7359_CFG_SLEEP	(1 << 7)
-#define MAX7359_CFG_INTERRUPT	(1 << 5)
-#define MAX7359_CFG_KEY_RELEASE	(1 << 3)
-#define MAX7359_CFG_WAKEUP	(1 << 1)
-#define MAX7359_CFG_TIMEOUT	(1 << 0)
+#define MAX7359_CFG_SLEEP	BIT(7)
+#define MAX7359_CFG_INTERRUPT	BIT(5)
+#define MAX7359_CFG_KEY_RELEASE	BIT(3)
+#define MAX7359_CFG_WAKEUP	BIT(1)
+#define MAX7359_CFG_TIMEOUT	BIT(0)
 
 /*
  * Autosleep register values (ms)
@@ -143,8 +144,8 @@ static void max7359_close(struct input_dev *dev)
 static void max7359_initialize(struct i2c_client *client)
 {
 	max7359_write_reg(client, MAX7359_REG_CONFIG,
-		MAX7359_CFG_KEY_RELEASE | /* Key release enable */
-		MAX7359_CFG_WAKEUP); /* Key press wakeup enable */
+			  MAX7359_CFG_KEY_RELEASE | /* Key release enable */
+			  MAX7359_CFG_WAKEUP); /* Key press wakeup enable */
 
 	/* Full key-scan functionality */
 	max7359_write_reg(client, MAX7359_REG_DEBOUNCE, 0x1F);
-- 
2.56.0.567.gdb80ae8cd5-goog

