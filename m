Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFA3FB060
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533323; cv=none; b=KIqFnDgZRtWM9CHKayLiaC4BfVgSbuQaYIF8iL6UU4JEDQPZPRT9iaqaD7lrPEl5xWMbTU10d/JeJ7Xkp+OKhHQcTGPa0eJGqnth6SSmlfPzR3JvxFHUeW3G2rWig0BcVpgq1EfWb9HdruIcbmEses/RR+CtgFKm+Lfcf70Fnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533323; c=relaxed/simple;
	bh=TKWyalqVK8GLqXOJNE/S62cDUcMTVSr2CPvY1sjqxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyhU60lvUVF5O8cjed2V98v2PbROQxgtAT+1jCSe+KGALDCOB7hzPk/AGyiMDXiQFsnC4Vjy4iF+O+dFxhyiG4Y8GC9DfJw5qx1E1ZfMU4xndZdtfTTz/Ewj7Fixuv7Hj9fXJ4CUa/tuxmYGPJZxqnhAqgYsWBwXdq8xLZP7g9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEJDGcOh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEJDGcOh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso1814129a91.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533317; x=1782138117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owsFweYleMPe5NnGNcwnhZSDtHrTd9WEDx+h/fQkjWM=;
        b=TEJDGcOhrf55fwRuUOEzs/8S1cypHRJSqGov2gK75ZVp81GrohBfjPVYQ4z3vjy12b
         sgCAooR+pNpw3NhPNhin8Lx1MoDXECRxUDU+hlivroa5hKnwao8AJLFz92wNfjHfwtYi
         wV5rYgt2xZhHgiplb8XOsCxRQ7/WiZlkJtoZ1l3lrA/32hLN4rA8kapd9Rm8TFoqr1eo
         tHDDRY/W+WkPw+FFZHH9ErppC93ZOm+zzkyggv6FftDTk9mI1v8DceSQXkyEYvTX2tHa
         XrU/YRUXrc4l3r6KUg71xFIaJUFFsZMMMx2SCopJh46K4vqDqKn9Dl6/mhBXmoF5uY1X
         JiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533317; x=1782138117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owsFweYleMPe5NnGNcwnhZSDtHrTd9WEDx+h/fQkjWM=;
        b=jhgEopGMA+kcW09xtfnbCK+belJYh5jW3QpRuf1QmbVh/cTq7SmTSFn9bpzkrcgf5u
         wE+tFpmQldMERCBpmVyf/BC/L3N+RvcJkLN6tAJ1IDNXjbrFAcYD7xBe+nW282glBgyb
         qrZW42jaft2D3272PqxVvGZ0W5yhuMWKenrc2F0cAVxQw5/aT4zmj8IO5NVPxXltxDEW
         NOWUXwIR0mL/ImXXRui6MqC+/Rf36ky8repMFYd/2T8LrXGyyuJwiDFr32zVlMDgNvoY
         WpZiWyP3VzZoovftsnL5GPEQMrpWitKnng7T61j2B6M7B3ZKnnmmsjxyujrfiRWZCI7N
         gQdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ASvA5G7bpJkZqExudJYUyVS97SXTJiiXjQgNsLbnyT5HjglalROc2/mi4IQilsyd9JSTK269oXXpF5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yypgp0Qxa0HLGaCJkoW+Q4pk/f+j3mgktxltgqJQ610flh3t5fR
	9xJonDb3WmVloIpUJBBXVLVrFyDJVi8umYFhITId/Uk77NnuDiCHC3Lh
X-Gm-Gg: Acq92OHsyGjXF2pk4KQ51zvvoV88y7iiHy1o9xKgKYh4qCzZGfgH8g5+Xvu4W3Pp4t/
	+D9hEjRYeCfEscUubrTMo0tddi3M8gIHe519Q82mXy5AD3KqlqqkPirYTMWgXZU2Ah8icCpdD8Q
	35Gza4txya5nuPmo3Fmuyf5M577+lPsjFmPkN8I7doLoYFEab/L/k2Q86DhaVXn7lqsQiJju106
	4RShBkXNvtivg/Ze91W5eFnJGWeYw36gcuB/rlGGR0ThngcxFzZCRNHplbr+vtPapH/eQP+n7WP
	ahMjrNH8yM3YwLTVCTTttpYgw0KcXPTHjyl4WmXnfvS8qixAR89prvV/NE4wQ8H+r8tgaM9JQEL
	9OVDz6GOKXmURPZbs5F5QVYKvOWdY0OQu9KI1o2EmbUyg7fW52n/d6acvq0pm5me4V+cAw/7cEB
	m4L/L7V5AHuIlxIqFSDtSx
X-Received: by 2002:a17:90b:380e:b0:36d:79c6:1563 with SMTP id 98e67ed59e1d1-37a035f00e6mr15785637a91.17.1781533317379;
        Mon, 15 Jun 2026 07:21:57 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:57 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] Input: cap11xx - guard unsupported DT properties before parsing
Date: Mon, 15 Jun 2026 22:20:34 +0800
Message-ID: <20260615142103.352163-9-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142103.352163-1-jerrysteve1101@gmail.com>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check of_property_present() before parsing microchip,calib-sensitivity
and microchip,signal-guard, so that models which do not support these
properties (e.g. CAP1114) skip the parsing entirely.

This prevents a potential buffer overflow in calib_sensitivities[8] and
signal_guard_inputs_mask when a model with more than 8 channels
(CAP1114 has 14) would otherwise call of_property_read_u32_array()
with num_channels as the element count.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 52 +++++++++++++++++---------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 2e9382a721e9..c48ee8520a27 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -224,10 +224,13 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 		}
 	}
 
-	if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
-					priv->calib_sensitivities,
-					priv->model->num_channels)) {
-		if (priv->model->has_sensitivity_control) {
+	if (of_property_present(node, "microchip,calib-sensitivity")) {
+		if (!priv->model->has_sensitivity_control) {
+			dev_warn(dev,
+				 "This model doesn't support 'calib-sensitivity'\n");
+		} else if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
+						       priv->calib_sensitivities,
+						       priv->model->num_channels)) {
 			for (i = 0; i < priv->model->num_channels; i++) {
 				if (!is_power_of_2(priv->calib_sensitivities[i]) ||
 				    priv->calib_sensitivities[i] > 4) {
@@ -247,32 +250,31 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 				if (error)
 					return error;
 			}
-		} else {
-			dev_warn(dev,
-				 "This model doesn't support 'calib-sensitivity'\n");
 		}
 	}
 
-	for (i = 0; i < priv->model->num_channels; i++) {
-		if (!of_property_read_u32_index(node, "microchip,signal-guard",
-						i, &u32_val)) {
-			if (u32_val > 1)
-				return -EINVAL;
-			if (u32_val)
-				priv->signal_guard_inputs_mask |= 0x01 << i;
-		}
-	}
-
-	if (priv->signal_guard_inputs_mask) {
-		if (priv->model->has_signal_guard) {
-			error = regmap_write(priv->regmap,
-					     CAP11XX_REG_SIGNAL_GUARD_ENABLE,
-					     priv->signal_guard_inputs_mask);
-			if (error)
-				return error;
-		} else {
+	if (of_property_present(node, "microchip,signal-guard")) {
+		if (!priv->model->has_signal_guard) {
 			dev_warn(dev,
 				 "This model doesn't support 'signal-guard'\n");
+		} else {
+			for (i = 0; i < priv->model->num_channels; i++) {
+				if (!of_property_read_u32_index(node, "microchip,signal-guard",
+								i, &u32_val)) {
+					if (u32_val > 1)
+						return -EINVAL;
+					if (u32_val)
+						priv->signal_guard_inputs_mask |= 0x01 << i;
+				}
+			}
+
+			if (priv->signal_guard_inputs_mask) {
+				error = regmap_write(priv->regmap,
+						     CAP11XX_REG_SIGNAL_GUARD_ENABLE,
+						     priv->signal_guard_inputs_mask);
+				if (error)
+					return error;
+			}
 		}
 	}
 
-- 
2.54.0

