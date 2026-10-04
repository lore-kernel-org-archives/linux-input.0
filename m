Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86141A914;
	Sun,  4 Oct 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106531; cv=none; b=L+gm2GmqJJso3BcKkE2tvNas8KdI465A4HFRa2jOJS6MyXympZVD6ZBsPKVuu/LP/PEb4Mr+UwY9hKPwftHX1yeGUOXZP5ZkKPIcR2/4CPzCWJFerVTrRm0tOnZ7woIj0qVB6kEWRZKebrrLlSjG3sstcMXK4v7RSvvfRq3YcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106531; c=relaxed/simple;
	bh=PLpMpktIp4qHpfpFHqLw/hDjT+R8eyUI6m4rP4spPI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPXg999jN7NXUZsdFNePVGUO0WYaSNHBfBsse9cjWW7TQhTd0drIFXR1ENcB9tYPsAzjPG6/Q2epx0KzezWKuwIL+ktNBSlfdWkjcmWDJs9/uWxsP9sO0GWLeNP2m6YeuLnxLp6AmrkpKI02WcFRGOoi8ssPCVqlm02mowC2Hv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDIch-000000004pO-0Sur;
	Sun, 04 Oct 2026 09:35:11 +0000
Date: Sun, 4 Oct 2026 10:35:08 +0100
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
Subject: [PATCH v3 2/4] Input: hynitron-cst816x: respect touchscreen DT
 properties
Message-ID: <940c7d153e422548c3b83c0daa5d924ce322f56b.1791103511.git.daniel@makrotopia.org>
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
2.56.0
