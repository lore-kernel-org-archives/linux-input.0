Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C34387346;
	Fri,  2 Oct 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945289; cv=none; b=RwuhlrdIr5hF2Wblmax8e9EX2YNxO/CT88eC4w5TLyCxIEHrms1/FIIY2mz5sJhYs/6QPXMVcuAe9EEtFmQyGBnyeKvT5AqEDaH0fXVP4+uAzVcpnaLgpa9jq19Lc0SIGUlyTw1yBkUuS99m5IbOqCHRBB0wC9k4aMOKA2/MU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945289; c=relaxed/simple;
	bh=lEuF/01KJuM0ldrGLJCw65FcpdK9M35ZfAMCGQ/2zRo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTP39XFFvp7Tp2A5SITEErDFDaAqIYchuf+666OBt3vYo+t7Gls8pLEEli3wjCnEgbDCp9byb1dfbXf5SqqTbUctpS999VIK9Ygbe4R1XJJFwKNd7gbjOOerznhYC21ivBcP834Psx/JQBeq5EmTlFgqO8uMzllhOb25Q8aYpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcgF-000000003Au-0yzX;
	Fri, 02 Oct 2026 12:48:03 +0000
Date: Fri, 2 Oct 2026 13:48:00 +0100
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
Subject: [PATCH v2 4/5] Input: hynitron-cst816x: time out gesture key release
Message-ID: <909d4a3a2182ede94e76f60954279774d5f91b15.1790944534.git.daniel@makrotopia.org>
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

The controller reports a gesture code once and can then stay quiet
until the next touch, which leaves the gesture key pressed for as long
as the panel is left alone. Release the gesture keys 40 ms after the
last report that carried a gesture code, so that the release comes
from whichever happens first, the timeout or a report without a
gesture code. The 40 ms matches TSC200X_PENUP_TIME_MS, chosen there
for the same want of a lift event from the controller, and has to stay
above the interval between consecutive reports of a held gesture.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
- skip the release when the interrupt handler re-armed the timer while
  the timer callback waited for the lock (Sashiko AI review)

 drivers/input/touchscreen/hynitron-cst816x.c | 52 ++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 725c8bd4c1d0e..f17c2b03396a1 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -15,9 +15,12 @@
 #include <linux/unaligned.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
 
 #define CST816X_RD_REG		0x01
 #define CST816X_NUM_KEYS	5
+#define CST816X_GEST_HOLD_MS	40
 
 struct cst816x_touch {
 	u8 gest;
@@ -32,6 +35,9 @@ struct cst816x_priv {
 	struct input_dev *input;
 	unsigned int keycode[CST816X_NUM_KEYS];
 	unsigned int keycodemax;
+	struct timer_list release_timer;
+	/* lock keeps the timeout out of the middle of a report */
+	spinlock_t lock;
 	struct touchscreen_properties prop;
 };
 
@@ -180,8 +186,9 @@ static void cst816x_reset(struct cst816x_priv *priv)
 	msleep(100);
 }
 
-static void cst816x_release_keys(struct cst816x_priv *priv)
+static bool cst816x_release_keys(struct cst816x_priv *priv)
 {
+	bool released = false;
 	unsigned int i;
 
 	for (i = 0; i < priv->keycodemax; i++) {
@@ -189,33 +196,66 @@ static void cst816x_release_keys(struct cst816x_priv *priv)
 			continue;
 
 		input_report_key(priv->input, priv->keycode[i], 0);
+		released = true;
 	}
+
+	return released;
+}
+
+static void cst816x_release_timeout(struct timer_list *t)
+{
+	struct cst816x_priv *priv = timer_container_of(priv, t, release_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* a re-arm while this waited for the lock supersedes the timeout */
+	if (!timer_pending(&priv->release_timer) && cst816x_release_keys(priv))
+		input_sync(priv->input);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 {
 	struct cst816x_priv *priv = cookie;
 	struct cst816x_touch tch;
+	unsigned long flags;
 
 	if (!cst816x_process_touch(priv, &tch))
 		return IRQ_HANDLED;
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	touchscreen_report_pos(priv->input, &priv->prop,
 			       tch.abs_x, tch.abs_y, false);
 
-	if (tch.gest)
+	if (tch.gest) {
 		input_report_key(priv->input,
 				 priv->keycode[cst816x_gest_idx(tch.gest)], 1);
-	else
+		mod_timer(&priv->release_timer,
+			  jiffies + msecs_to_jiffies(CST816X_GEST_HOLD_MS));
+	} else {
+		timer_delete(&priv->release_timer);
 		cst816x_release_keys(priv);
+	}
 
 	input_report_key(priv->input, BTN_TOUCH, tch.active);
 
 	input_sync(priv->input);
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
+static void cst816x_timer_stop(void *data)
+{
+	struct cst816x_priv *priv = data;
+
+	timer_delete_sync(&priv->release_timer);
+}
+
 static int cst816x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -227,6 +267,8 @@ static int cst816x_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	priv->client = client;
+	spin_lock_init(&priv->lock);
+	timer_setup(&priv->release_timer, cst816x_release_timeout, 0);
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset))
@@ -244,6 +286,10 @@ static int cst816x_probe(struct i2c_client *client)
 	if (error)
 		return dev_err_probe(dev, error, "input register failed\n");
 
+	error = devm_add_action_or_reset(dev, cst816x_timer_stop, priv);
+	if (error)
+		return error;
+
 	error = devm_request_threaded_irq(dev, client->irq,
 					  NULL, cst816x_irq_cb, IRQF_ONESHOT,
 					  dev_driver_string(dev), priv);
-- 
2.55.0
