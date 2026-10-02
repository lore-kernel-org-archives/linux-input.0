Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86B2DECD3;
	Fri,  2 Oct 2026 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945313; cv=none; b=qjSKOxW+2oEusBT78/aRZ2zHO6/6K+9F44hJe45D+FkMjPjHKzvuLHnn9FzsMicp4xBkZSlLvFrRDjTaAi1Ylx0NvgKwhgtZBGCmzDhqhPdEhxgAcMqWbCb9ypBhpSe16UW/9e2Izvc1KLbp+Ro4dRGPHWLUptJfr6h4C1qzFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945313; c=relaxed/simple;
	bh=FlkoV6/rrGNhPYyucI4iTOqdlBh6PDHzBJfz0WfjBCg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2BaHjEMq/CjIAzYOlgf2drk9/1Kw2qXur64WY09wTX7BEWsnPxAOwOI3rIEjo1ViYD1aYa3hVJmpeUe0hvFUFbuou+aZ95JZFOG3mniO7Qc+6u53w/sjEF/vTfUqybeOJ7oWrc9OoGx1WJF+Gsr+2lT9oGNOM4RT+waj/R3s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcge-000000003BD-0WeJ;
	Fri, 02 Oct 2026 12:48:28 +0000
Date: Fri, 2 Oct 2026 13:48:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hendrik Noack <hendrik-noack@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Input: hynitron-cst816x: power sequence with the panel
Message-ID: <67e9a67e17a977053eaacef203416473f4c63968.1790944534.git.daniel@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790944534.git.daniel@makrotopia.org>

Boards which mount the controller on the panel feed it from the
panel's rail, where a reset and the first interrupts are only
meaningful once the panel is powered. Register as a DRM panel follower
when the device tree points at a panel, so that the reset stays
asserted and the interrupt masked until the panel is prepared, and a
pressed key is released before the panel goes down again.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/input/touchscreen/Kconfig            |  2 +
 drivers/input/touchscreen/hynitron-cst816x.c | 60 ++++++++++++++++++--
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7fd..0beb499e24f20 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -478,6 +478,8 @@ config TOUCHSCREEN_HYNITRON_CSTXXX
 config TOUCHSCREEN_HYNITRON_CST816X
 	tristate "Hynitron CST816x touchscreen"
 	depends on I2C
+	# We call into panel code, so if DRM=m, this can't be 'y'
+	depends on DRM || !DRM
 	help
 	  Say Y here if you have a touchscreen using a Hynitron
 	  CST816x series touchscreen controller.
diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index f17c2b03396a1..2e786f617067f 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -18,6 +18,8 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 
+#include <drm/drm_panel.h>
+
 #define CST816X_RD_REG		0x01
 #define CST816X_NUM_KEYS	5
 #define CST816X_GEST_HOLD_MS	40
@@ -39,6 +41,7 @@ struct cst816x_priv {
 	/* lock keeps the timeout out of the middle of a report */
 	spinlock_t lock;
 	struct touchscreen_properties prop;
+	struct drm_panel_follower follower;
 };
 
 static int cst816x_parse_keycodes(struct device *dev, struct cst816x_priv *priv)
@@ -256,6 +259,44 @@ static void cst816x_timer_stop(void *data)
 	timer_delete_sync(&priv->release_timer);
 }
 
+static int cst816x_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct cst816x_priv *priv = container_of(follower, struct cst816x_priv,
+						 follower);
+
+	if (priv->reset)
+		cst816x_reset(priv);
+
+	enable_irq(priv->client->irq);
+
+	return 0;
+}
+
+static int cst816x_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct cst816x_priv *priv = container_of(follower, struct cst816x_priv,
+						 follower);
+	unsigned long flags;
+
+	disable_irq(priv->client->irq);
+	timer_delete_sync(&priv->release_timer);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	cst816x_release_keys(priv);
+	input_report_key(priv->input, BTN_TOUCH, 0);
+	input_sync(priv->input);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct drm_panel_follower_funcs cst816x_panel_follower_funcs = {
+	.panel_prepared = cst816x_panel_prepared,
+	.panel_unpreparing = cst816x_panel_unpreparing,
+};
+
 static int cst816x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -275,9 +316,6 @@ static int cst816x_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(priv->reset),
 				     "gpio reset request failed\n");
 
-	if (priv->reset)
-		cst816x_reset(priv);
-
 	error = cst816x_parse_keycodes(dev, priv);
 	if (error)
 		dev_warn(dev, "no gestures found in dt\n");
@@ -290,12 +328,24 @@ static int cst816x_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	error = devm_request_threaded_irq(dev, client->irq,
-					  NULL, cst816x_irq_cb, IRQF_ONESHOT,
+	error = devm_request_threaded_irq(dev, client->irq, NULL,
+					  cst816x_irq_cb,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					  dev_driver_string(dev), priv);
 	if (error)
 		return dev_err_probe(dev, error, "irq request failed\n");
 
+	if (drm_is_panel_follower(dev)) {
+		priv->follower.funcs = &cst816x_panel_follower_funcs;
+
+		return devm_drm_panel_add_follower(dev, &priv->follower);
+	}
+
+	if (priv->reset)
+		cst816x_reset(priv);
+
+	enable_irq(client->irq);
+
 	return 0;
 }
 
-- 
2.55.0
