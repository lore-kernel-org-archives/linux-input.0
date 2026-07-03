Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020F3CC7FF
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079779; cv=none; b=lIhMQZG6xQ8HVZg7cfzLUBtItOnayP8Si2jNtT9mLrkncHGD8L1AzuQu45iWdR6XScVFQvLVQhSK68LMHfDO0dwyB39HyJh1oDgDgAH6oQdd2govVtlQLvEChxw6Muk88qFKYUdItj7kkL/sBYlSfEqpf1ZkbaJE7m0Y6zfqhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079779; c=relaxed/simple;
	bh=V7cOkFeI+SMCrClZ1qRg1vjKvkY61qr7W7O4sv97AZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NouYrAwSHcCkwTNjh0xeI6Tgwa2/NehMUqFtH6lEUVW963ZfJuKRJHzwpIUQmV2CnN6ieOhgXe+ZNRZV9Zf70prhJgh6ZJ98CmwTmTR1Llu4M3zqNLX8EHJ94q2AiYaP5h/IoU2bVje3O0Al2sETYZMmTDYigglRx1TYZ1yNgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9/h8NgY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9/h8NgY"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842358aaf36so248233b3a.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079777; x=1783684577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1Qi7K0Q2jUkzExsWzvH+ABdRL+B0DFQxVv+X4n7A58=;
        b=M9/h8NgYWoQ7o2l8ye0lo66sKTlRzgH7BvW2v7lUuHWBX20CMZr/LB5rY3rdXehhd8
         q7h1f+k0/5tlEcjjyIMf1CtTkmA4Bq9IMyyx+YxMrfojokT9fVgHJRpKl8WsCsB5alx2
         Md/u5FHWHKQt2BCTfI5PswF8ifDsLEBK4/q8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079777; x=1783684577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1Qi7K0Q2jUkzExsWzvH+ABdRL+B0DFQxVv+X4n7A58=;
        b=ABN77rPIYX1JYEJnfDlZo15jrB8eTImqvVpRQ2faUDbkEAFiU5wwKpyBN3mSAbYd7E
         pQ2t+b3r2T4toKrakfz3Hzrr5w/q9HwQ7gfGisLS0FOEBhbi0Hivq0pdVABqK2C6BWh7
         l2qXR95OAKlzJaF9D8sU61tgveGVbNe0XC/Zhr4pwRvmPSkmUPytm0mESJ6sr4dXIn9e
         CxwXs/t0a8oOyjkUzwlOQh93w1Zir/XWCu2L47eo8bkOiaBeTxIwQdGD1oDtGpAFHqAZ
         iA/nf2kWbiH/8jmgGS+r60PORwfQR9mCbxjlJa+bAi6Gzq4y+MKEEieKUxBAAEfu09nh
         iPIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9W+pZW/oOnR6yw0fczzhIBTdG2wcdz65w5XSfuuKU27RhNryW6/k9FS8eiO3FCPhqS3ufMqbwTUfM7jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTka6rmCeijqMCU/d/34p8yq0a/Z3i3FtoE/WREK6YkE/72HK
	4nciPEIwqbvwtNBRICa4aTL1JL53pOxGDY+yRZ9pJC3oc/WV0qHbTab0IcBiz+9VkpN0bYR3nRQ
	V/Fs=
X-Gm-Gg: AfdE7clbbmJcJzzaW+gNiOgI8IAyWP8s6wrxyu43F2OXWZkl2QHflUNTr30tuTxxbNL
	BosjHRGsVagQU+fd/9eU2ct8a49gsrpms0gzHn6s9Ixs9BykOHUVlvV3IQiaf+JmUnxfIur4TLM
	INxaXpRxMQD25iOCn5N+JYTd4HoSf/ryDZoZgR6NBqnZ+rrqZQ85CHQ4eUdgc8xCbrNg+f+Md73
	zNHutwpgsQ7Aplr/54ExSvy+I5V+adP4JpfZzle4j3jZ9x/7ug0oXaEMIl2zCzFNJzYgfzVb5zZ
	7XzCKKUwrO1I2Q5DdosH+RjbNVl0K+eJW0xYwTXzd7UB7R1fSsE+5TDokGlMkcRPjYHcU1uno/7
	rFiZFclEFnJjuz1p3e548oRiO0zJKH+WEdwatBjpaAXnROuWK6W7O+0WlrdEQGwkw/YRcdoaexU
	JvsrzbYs0aD1B6OWONua11WGLq6uQ1Gm50pGI741prT7cKx12K9HmGHHGJDiAqG5BJ/brNk6iOj
	rg2IVbg
X-Received: by 2002:a05:6a00:6ca7:b0:845:388b:56f with SMTP id d2e1a72fcca58-847c08956ebmr10321332b3a.40.1783079777502;
        Fri, 03 Jul 2026 04:56:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:17 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v2 2/7] HID: i2c-hid-of: skip post-power-on delay if already powered on
Date: Fri,  3 Jul 2026 19:55:55 +0800
Message-ID: <20260703115601.1323491-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
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

Instead, check if the regulator supplies are all enabled, and skip
the post-power-on delay if that is the case.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..70afdfb207ac 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/string_choices.h>
 
 #include "i2c-hid.h"
 
@@ -46,8 +47,12 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 {
 	struct i2c_hid_of *ihid_of = container_of(ops, struct i2c_hid_of, ops);
 	struct device *dev = &ihid_of->client->dev;
+	bool supply_was_enabled = true;
 	int ret;
 
+	for (unsigned int i = 0; i < ARRAY_SIZE(ihid_of->supplies); i++)
+		supply_was_enabled &= regulator_is_enabled(ihid_of->supplies[i].consumer);
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
 				    ihid_of->supplies);
 	if (ret) {
@@ -55,7 +60,8 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
+	dev_dbg(dev, "supply was %s.\n", str_on_off(supply_was_enabled));
+	if (!supply_was_enabled && ihid_of->post_power_delay_ms)
 		msleep(ihid_of->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

