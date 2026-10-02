Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628333F329E;
	Fri,  2 Oct 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945274; cv=none; b=ZGXPj0D9KhBJMHw4jQiZiMHjaVlpfNXMQwVYQ1Kp6fQ8masmXryJBgP+NNoPioIdwb2lYq/EJxDY7ddQaoJdRG4Q8ouo3szt9KNxL/WI4qbB/cdsXlGPdYonY6x+QOqnjQVhAJW94cNndM2BrfP/gkZCaA1aOzpZrXA1NBzqhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945274; c=relaxed/simple;
	bh=7vymvtOUX7zPOeTNyf3FpSArn1nx5h04Q+pTytrTf6M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQQ8wE9uTjpQGDQRCGMxBfAfXv7WY0BZI71gP8n8LZeYwUHAKDruDRDSR3HrbEwspDusSdUktKSz1hC+kpF1ZXgJsY//0F4eLLaHOWihVWdTl/y7mFHxUy3s89OI3Nt88LpuII81IeFHRv5JUNtPCXbzns9cvgnvrz91936vqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcg1-000000003Ac-1rDO;
	Fri, 02 Oct 2026 12:47:49 +0000
Date: Fri, 2 Oct 2026 13:47:46 +0100
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
Subject: [PATCH v2 3/5] Input: hynitron-cst816x: release gesture keys
Message-ID: <7199967eb45b1c3adcb7efc859380f6f3dbf7bdd.1790944534.git.daniel@makrotopia.org>
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

The gesture key is reported with the value of the touch flag, so it
stays pressed once the controller stops reporting the gesture code
while the finger is still down. Report the press on its own and
release the keys the input core still holds down on the first report
that carries no gesture code. Keycodes above KEY_MAX are rejected,
as that release looks the key state up in the input core's key bitmap.

Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
- reject keycodes above KEY_MAX and publish keycodemax only once the
  whole array validates (Sashiko AI review)

 drivers/input/touchscreen/hynitron-cst816x.c | 67 ++++++++++++++------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 865c5a767ba01..725c8bd4c1d0e 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -39,28 +39,40 @@ static int cst816x_parse_keycodes(struct device *dev, struct cst816x_priv *priv)
 {
 	int count;
 	int error;
+	int i;
 
-	if (device_property_present(dev, "linux,keycodes")) {
-		count = device_property_count_u32(dev, "linux,keycodes");
-		if (count < 0) {
-			error = count;
-			dev_err(dev, "failed to count keys: %d\n", error);
-			return error;
-		} else if (count > ARRAY_SIZE(priv->keycode)) {
-			dev_err(dev, "too many keys defined: %d\n", count);
-			return -EINVAL;
-		}
-		priv->keycodemax = count;
-
-		error = device_property_read_u32_array(dev, "linux,keycodes",
-						       priv->keycode,
-						       priv->keycodemax);
-		if (error) {
-			dev_err(dev, "failed to read keycodes: %d\n", error);
-			return error;
-		}
+	if (!device_property_present(dev, "linux,keycodes"))
+		return 0;
+
+	count = device_property_count_u32(dev, "linux,keycodes");
+	if (count < 0) {
+		error = count;
+		dev_err(dev, "failed to count keys: %d\n", error);
+		return error;
+	}
+
+	if (count > ARRAY_SIZE(priv->keycode)) {
+		dev_err(dev, "too many keys defined: %d\n", count);
+		return -EINVAL;
+	}
+
+	error = device_property_read_u32_array(dev, "linux,keycodes",
+					       priv->keycode, count);
+	if (error) {
+		dev_err(dev, "failed to read keycodes: %d\n", error);
+		return error;
 	}
 
+	for (i = 0; i < count; i++) {
+		if (priv->keycode[i] <= KEY_MAX)
+			continue;
+
+		dev_err(dev, "keycode %u out of range\n", priv->keycode[i]);
+		return -EINVAL;
+	}
+
+	priv->keycodemax = count;
+
 	return 0;
 }
 
@@ -168,6 +180,18 @@ static void cst816x_reset(struct cst816x_priv *priv)
 	msleep(100);
 }
 
+static void cst816x_release_keys(struct cst816x_priv *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < priv->keycodemax; i++) {
+		if (!test_bit(priv->keycode[i], priv->input->key))
+			continue;
+
+		input_report_key(priv->input, priv->keycode[i], 0);
+	}
+}
+
 static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 {
 	struct cst816x_priv *priv = cookie;
@@ -181,8 +205,9 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 
 	if (tch.gest)
 		input_report_key(priv->input,
-				 priv->keycode[cst816x_gest_idx(tch.gest)],
-				 tch.active);
+				 priv->keycode[cst816x_gest_idx(tch.gest)], 1);
+	else
+		cst816x_release_keys(priv);
 
 	input_report_key(priv->input, BTN_TOUCH, tch.active);
 
-- 
2.55.0
