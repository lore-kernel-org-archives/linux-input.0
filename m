Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B35444706
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450853; cv=none; b=YmHChqD1MqdEdSh5lM783vmuYWGiZJdQ4dkkfZZt1mv8uqtTzgiJ2xfUmDKi8YYYf7P17kr2UG0TsP+1aE02QlCdCKMax7UuC0dLAmW1IJ5n6xXya6q2ec6ROQr6r2IRwGu/Sm0PGXQr4eynDFfD3ItK5BY2dbyq6QBgxLdXg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450853; c=relaxed/simple;
	bh=uirJlTrzUDnDWGluHgHaYZhmNeiDmkFi3DnjsuZpHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+VSHiP10so9W6JxqjjK09iyJ/BncKnPiCUWvkAf+YxwpgtkFI2SjD4fVdCpGs+febYX2kQHIYrjkpJVHfE9hKu3xug50OiDWj7A3DbOhrUD5Hr07+e13FalnGGrty+TTv0pTQuJiuOGGqqOeIY6Fx1uZBdw8Dvni9QH0VDcQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AHysLrxK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHysLrxK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so750783b3a.2
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450851; x=1787055651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsFbGvUc+lL3nEmcNAop98oZPFXcbP5zb4ZbtxDxx0U=;
        b=AHysLrxKBQRBWDPQAOCDHjM1n5xvZQ2q4T4wopMN1EbGiPvP79efhy6Y3H7y6zDD72
         lyfi2zZZ8MGtj8/g5V/hUMa8gIMA8lo5N2dUIF8D11cVzr9S9opuhIFIzZiQirmuKigP
         xwvegTrWzYjUhwxR0dEjzjN0A14QdcOpuXZTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450851; x=1787055651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsFbGvUc+lL3nEmcNAop98oZPFXcbP5zb4ZbtxDxx0U=;
        b=peW1ZN69qaiGqdo7nOtBqe0RoNsdUARekv4YybCKAOrgDOETz9Ch9mWtmZkymwPmuG
         3cCFzGRcszFzp/a+w0r7svw7oNFvTUDbYMEFgNMPAWhn63iTfwDtRSdYdfGvF5SzEE/+
         6+ZPmCVr+ULtLP8fmP3a2CwejIIYWg2KwSV1kesrQlohMHL3O7hQ0TbQxdG0x1KuAepM
         Zcec1HrLU82awO73Sz1orGkV1sOZY3emTfmiW7Kh/eugsQt1Es9LMBVNWqb3L1FjgVY1
         FVPAtqclEErJB1/Wvgdgo7MfqG1SZBzyBF0SrPGXCc6h/ordRFQJf1+6/wziACYOM7Bz
         d4Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpLayE+SaqHYxZea1G+1DSNE3aIc0xwbdmqINpXBxA1NK4cZSDO4FR3ecxSM3OhHfM8VWAtpBtSk1bEBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbp5VnqtpJjk8kAudVgYk+iJMk+ID0EDKTmQfpY4fTmbpB+9bc
	amAal4wBEsBC3RuxZrtBLuILTSdIkaqgCN+musSfQFObH0G7zmdXFgHlFi3DJVBfUw==
X-Gm-Gg: AR+sD12H2mphgzV9Ciprx9a2l80G+bb2ZA5CVP+eQLbEas9lsrXTg3R431C9Q9ms6rr
	JSfT32GJI5EBDycMBH9j1jXxWSm77GzNEfb/zQAVfiZ+TKkUiQ+BE3ZKbxYL6oAbm9PiYDdgCJp
	lfFx/bEBF0yLWDcYuhwDhJbHnIQTPVC7T/askh5Y7pSxb0MHE5dgZYcc2DAiwbfUB9od1Dduu45
	BWizxo6kwovPtS+LqzcWEyXDiuNKywTdUwpV0WFwSG6PkCENK2GiDk+O1o3PygbL0HM7oWVtcgO
	2BdzSFs6YlBYKAz7oPL8LuTjr9mr39DHqiXgyyoLqsjL/Myuk9kHxVIq1FPWOqdCTm3L0eJtcvI
	R3yJj6l4huyChxvhfvR7UKyNl1uY07f3H9XaL7IHFeUbp9v11mIOJHl26xUFJfMd2aWlaaSzM1c
	BBn/PqmsgSltlblS5qejZo2cPu2Y94O5SQ+2gxA8s3881/7Xe6tmh2eu8CQ6zOigJm7VcbDQ7N5
	SFHJHMTmocA9b5F2r7ldJJI61ty9V3udQ6nePTttPeRPg==
X-Received: by 2002:a05:6a00:8d1:b0:846:22ea:e171 with SMTP id d2e1a72fcca58-84fa872c289mr2761703b3a.3.1786450851388;
        Tue, 11 Aug 2026 05:20:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:50 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue, 11 Aug 2026 20:20:04 +0800
Message-ID: <20260811122011.3539250-5-wenst@chromium.org>
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

On some devices the HID device is powered from an always-on power rail,
or the power rail has been left on by either POR defaults or the
bootloader. By the time the driver probes, the device most certainly
has finished initializing. There is no need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree. This is undesired, as the device tree is not fully describing
the hardware.

Switch to the new regulator_bulk_enable_and_wait() function that makes
sure a certain amount of time has passed since the regulator supplies
were actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_bulk_enable_and_wait() API
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..fdaad451e710 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 
 #include "i2c-hid.h"
 
@@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 	struct device *dev = &ihid_of->client->dev;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
-				    ihid_of->supplies);
+	ret = regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
+					     ihid_of->supplies,
+					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
 	if (ret) {
 		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
-		msleep(ihid_of->post_power_delay_ms);
-
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
 	if (ihid_of->post_reset_delay_ms)
 		msleep(ihid_of->post_reset_delay_ms);
-- 
2.55.0.679.g6767b8d81c-goog

