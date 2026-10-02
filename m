Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA231438490;
	Fri,  2 Oct 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945262; cv=none; b=pO6tFCSfkEF5w9y2PrV48yJYQjn4ktzgjzsXZ8YT7raoCibnl5q69mR1r9XRastDHNdsO0esE9h4lfT+4Ft+4/xX4RA6LdOKYAMx+kX7mjBNZfZ6/Adc3D7MPX6eSpT+AnywbT5WhsE1W71whlcfJTILxP9USaqf8IfmfBJiZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945262; c=relaxed/simple;
	bh=7DF6ApRlpbNsO0DfvNGA4JfaBqubcvCsOAWRq0BswdY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmzn8+CYD5ZR0zNZCgTUSobbrdqeOJXcRoYKvBWrr92geL93NG7Vn9UW98+bd8TMAaAqjN8Icdbz+P3O7EsaC+wZFozGimJiD0gykPlT1ei373qzoeKFRteYtV4ztBa6WMUSDLXHvf8dtgWwr+GcRxiBRs4xX/FB7q7V447c+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcfp-000000003AK-2RXs;
	Fri, 02 Oct 2026 12:47:37 +0000
Date: Fri, 2 Oct 2026 13:47:34 +0100
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
Subject: [PATCH v2 2/5] Input: hynitron-cst816x: respect touchscreen DT
 properties
Message-ID: <75b8436b900ecdce7f29513a7403b851986a3a1b.1790944534.git.daniel@makrotopia.org>
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

Parse common touchscreen properties and use touchscreen_report_pos()
instead of reporting raw absolute position.

This makes the driver respect the touchscreen-min-x/y,
touchscreen-size-x/y, touchscreen-fuzz-x/y, touchscreen-inverted-x/y
and touchscreen-swapped-x-y properties.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
- name all the properties the parser honours, no functional change

 drivers/input/touchscreen/hynitron-cst816x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 47d9cd7412d1b..865c5a767ba01 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/input/touchscreen.h>
 #include <linux/unaligned.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ struct cst816x_priv {
 	struct input_dev *input;
 	unsigned int keycode[CST816X_NUM_KEYS];
 	unsigned int keycodemax;
+	struct touchscreen_properties prop;
 };
 
 static int cst816x_parse_keycodes(struct device *dev, struct cst816x_priv *priv)
@@ -142,6 +144,7 @@ static int cst816x_register_input(struct cst816x_priv *priv)
 	input_set_abs_params(priv->input, ABS_X, 0, 240, 0, 0);
 	input_set_abs_params(priv->input, ABS_Y, 0, 240, 0, 0);
 	input_set_capability(priv->input, EV_KEY, BTN_TOUCH);
+	touchscreen_parse_properties(priv->input, false, &priv->prop);
 
 	priv->input->keycode = priv->keycode;
 	priv->input->keycodesize = sizeof(priv->keycode[0]);
@@ -173,8 +176,8 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 	if (!cst816x_process_touch(priv, &tch))
 		return IRQ_HANDLED;
 
-	input_report_abs(priv->input, ABS_X, tch.abs_x);
-	input_report_abs(priv->input, ABS_Y, tch.abs_y);
+	touchscreen_report_pos(priv->input, &priv->prop,
+			       tch.abs_x, tch.abs_y, false);
 
 	if (tch.gest)
 		input_report_key(priv->input,
-- 
2.55.0
