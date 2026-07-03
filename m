Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42F3CCFAC
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079777; cv=none; b=g2Y+yCaGs7q3VaqymvJchoVJxIhd962NfDGHRQgmIkLxyl0zV/tE/J6QmRTtBrUSBWwpgcdW5Ta9WjiWG87z4xnft9AYtPDlnPtMhI5YcYCxzFKt0uZFNXsfxj66Mo9dpjdE+LM6wn08SnOr4mmumrU7oyHczRZdt8rUoUAzWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079777; c=relaxed/simple;
	bh=/CzTqVrHPhxnQw7Hy1iaVnDjpPgGlbej4Ff3rf0qhOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRqanorsNvzj7G+bBumacJD7lAwxSFH64yWS2oALzfdTPXtLLfvozFIecb+aIIcP6M1Wt0SlbsKCwHAnBDjZsJ0vhHxK6IGDcDL7mdA5u8fHgRi/eUXLzcvl9qAjOIYVeRAstaIb5S62i5PreUR3pABJ0nlXiCEubIMOGgSvjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+p0SWk9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+p0SWk9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845ea8924fdso500456b3a.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079774; x=1783684574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJOQnYDmj56BFKnk3PptuIiEN5/cefcVZ6+liIWlLhk=;
        b=W+p0SWk9tyCegO7QtLB2ffoZjsSagYfx7OYaPgW2A19NlsvO76SVuVcXwSkQWC9KRu
         dgeezReLfqjhZ+lCFCYfFV6Vmuhs+rBPvr0Oocy14DwAB5CxfMlyj4pzQxp14io3Tt4g
         RGkSF4BZMDkzxFA3bVnORb0ZMQOc5piVT9nQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079774; x=1783684574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJOQnYDmj56BFKnk3PptuIiEN5/cefcVZ6+liIWlLhk=;
        b=o3r6FESB58zTkB56e9EzGyu+hOdLvZSplosob0/pQL08WLMVm+YtgzIxADeHynpULC
         wyBb5RB01+W66sCuWkAtbQuMdMV43Slo/pDQcYRJNtVMAjqVeAoyFdoiB2Usvb1NinjR
         6z9kZGiWn2VZySXZ3eBkGcu7x++aNxNg5kBvs2u4+ZUDPlJeNTXJHwIiK3iWP0vTv5Nj
         n2F/cTVfkwdGMPS6Kf5uRe3yvo9n2FQh6z8QyHLL35oH+CaqGiL7b1KGylQeHJ5xQlqV
         7uYTRhOMPtufcTz3HViORZDkFFH3xEDAfjTi0ybA3f6x1e8eEKu61K57t6LbDRm74BO1
         3IHA==
X-Forwarded-Encrypted: i=1; AFNElJ9B6wIV+IpzFk4O2Fg2L+bN++uvbESMIshRAqSVxVlP4hgXkCIIVBsX9v9wJo3WrH4aXoEH+KyPbLp/tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYl9ju1RqukScEZqptfXCzwuhNawn2Ed7dX4+nzKzP290sOCW
	HzSBkiA7RjY+vuO0ZN+VoxtTXS31kuL/56JxsSTL51WyCJTbKqKMAYwIhC7G6SLrlA==
X-Gm-Gg: AfdE7ckYwudJqR/usO+vG0BMr65rbvBF2+WPQ/42xCPwVzcZG73fjkdZPqfiuj2q6gC
	R1DGn2PiTB4T7VQ920649iv4BGK/k2t88jM/qparX03MdPa7W7XCXKcZsbDOyJbdLR3i5ITdzqD
	mJSKSTon3/gLFMhkFJ4Tqu8ZI0y0qAkISlNU3685ajHJlAlhpIR9AMaPCVd7sLyqcvXigutIP4z
	1CNN9jpH0VzKG34grHV+PgurXrx7oTKtWmqrpUI0qTwCVZaL90SozvyXoqUu5qzJtdt4tOPzlkV
	G/meJtczPJebOq99XSeurs2Wzb+DuozqASV9pOo0L1s5Ob+PnMwSE6++cCICN8u5I47sYN9ccsq
	JPRJuHQTr31o2BVYdZx6r8ZsZQHYU1zPArmSNl2E+N6XhPJOJODh7bBusuufmgT6NYQbnvhtunn
	x8+PgO68WMot9xERxZ+PI+ZunTm0AzUzGqmv/ZJpoOqNfk0tgIMWBk94Mxe0WtNwwPFN2S6g==
X-Received: by 2002:a05:6a00:cc9:b0:845:e23f:108 with SMTP id d2e1a72fcca58-847c088ec3fmr9998078b3a.42.1783079774322;
        Fri, 03 Jul 2026 04:56:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:14 -0700 (PDT)
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
Subject: [PATCH v2 1/7] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Fri,  3 Jul 2026 19:55:54 +0800
Message-ID: <20260703115601.1323491-2-wenst@chromium.org>
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

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Add proper delays after regulator_enable() calls. To avoid impacting
the boot time of existing devices that have the power rails always on,
skip the delay if the regulator supply was already enabled. In this
case the regulator is either always on, was on by default at power up,
or was left on by some other driver, such as the I2C OF component
prober. Either way the controller has had ample time to initialize.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f93dd545d66b..db48d7ef8357 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -47,6 +47,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY	110
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1219,6 +1221,7 @@ static int elan_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct elan_tp_data *data;
 	unsigned long irqflags;
+	bool supply_was_enabled;
 	int error;
 
 	if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
@@ -1250,6 +1253,8 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
+	supply_was_enabled = regulator_is_enabled(data->vcc);
+
 	error = regulator_enable(data->vcc);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
@@ -1263,6 +1268,9 @@ static int elan_probe(struct i2c_client *client)
 		return error;
 	}
 
+	if (!supply_was_enabled)
+		msleep(ETP_POWER_ON_DELAY);
+
 	/* Make sure there is something at this address */
 	error = i2c_smbus_read_byte(client);
 	if (error < 0) {
@@ -1406,11 +1414,16 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
+		bool supply_was_enabled = regulator_is_enabled(data->vcc);
+
 		error = regulator_enable(data->vcc);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
 		}
+
+		if (!supply_was_enabled)
+			msleep(ETP_POWER_ON_DELAY);
 	}
 
 	error = elan_set_power(data, true);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

