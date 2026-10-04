Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A25419FBE;
	Sun,  4 Oct 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106574; cv=none; b=sLV9KekwZf8RnWsmpkk+5aIJw+ba7mn8f7PlZ4DxsKB1QPC6MzdmZMEgK+7HKfmT+ETU+E5DVz97wpMH/oTgrpPDlGA0He1IvnaJnhXddTWleKmpGjmdFAJV3DxFMOJgmU1gzyehZwOoOo8mlTvWGdO30FtZ0T1iROihtbc0ULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106574; c=relaxed/simple;
	bh=nIcJx8qsm5FL3zmEH8c3D1BaXvlRSRHFnAG7dkwvFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFhef5BiSGLLzalqKN1sOBZCPxYYet9DLEaKjsFM2coAPy0nDvE7HMhSfWMwCQVkDt3lFy9xx2VW27KR0rboFE9vH/OpKOo0/2RXjdM1Hbl5UT4kCuX8cvU5A8b+6pBarBUHfVqiuN7jWXpGP84Nt5HYAPBE5jQp43FqmRHzMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDIdR-000000004r0-3s9k;
	Sun, 04 Oct 2026 09:35:58 +0000
Date: Sun, 4 Oct 2026 10:35:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v3 4/4] Input: hynitron-cst816x: time out gesture key release
Message-ID: <2e6d0ad1cba3ffce87a31002418d5b11f27810bb.1791103511.git.daniel@makrotopia.org>
References: <cover.1791103511.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791103511.git.daniel@makrotopia.org>

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
v3: use timer_shutdown_sync() in the devres teardown action
    (Sashiko AI review)
v2: skip the release when the interrupt handler re-armed the timer
    while the timer callback waited for the lock (Sashiko AI review)

 drivers/input/touchscreen/hynitron-cst816x.c | 52 ++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 725c8bd4c1d0e..bd84581cf2b6d 100644
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
+	timer_shutdown_sync(&priv->release_timer);
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
2.56.0
