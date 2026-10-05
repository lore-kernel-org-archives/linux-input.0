Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032782D0C94;
	Mon,  5 Oct 2026 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234783; cv=none; b=CfGwJCUVAMoEGPbFHjgNj6cisb0LGpHbZtxbDG7ItLHEveSQd8L3qX2bQWBLSSPpGo5utfAnKj3k8q3GtDqThFh//QKAdYXj952FsZJgAkiBwhJk4sOSfhJdYfOBLj3CeHB+FVqFvv+uaTTbmtamuz5pHWlD9RwdQjgozjOHmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234783; c=relaxed/simple;
	bh=tc0P6usWs64ZFy121MPOj/itqoKcNk2q0WgQi2zzOa4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jilRMpD/dD+gkJXII2ezIQauE/SH2MO7M7tWkLrj1lZalfEQO6JlnY3RR1RiECLHt0dOYe8wr3UJvr70m2hk9otsLjVU0zyUJWoW9NR7BqVdth1l56tYlPd+2DpG0y0XK7R9/5LRcMIWK46FLqW4Au8SHU3e3N0FoV3t02VME38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDpzX-000000005w3-0emE;
	Mon, 05 Oct 2026 21:12:59 +0000
Date: Mon, 5 Oct 2026 22:12:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] Input: hynitron-cst816x: set INPUT_PROP_DIRECT
Message-ID: <ff91fc6f203d4442d555597cdb455b476af9da50.1791233147.git.daniel@makrotopia.org>
References: <cover.1791233147.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791233147.git.daniel@makrotopia.org>

The sensor sits on the panel, so the coordinates it reports map
straight onto the display. Without either direct or pointer set,
event-codes.rst leaves userspace to deduce the device type from the
emitted event types, where ABS_X, ABS_Y and BTN_TOUCH read as a
touchpad and a touch becomes relative pointer motion.

Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/input/touchscreen/hynitron-cst816x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 7ef3e17a65f77..040ee3c2983ef 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -157,6 +157,7 @@ static int cst816x_register_input(struct cst816x_priv *priv)
 	input_set_abs_params(priv->input, ABS_X, 0, 240, 0, 0);
 	input_set_abs_params(priv->input, ABS_Y, 0, 240, 0, 0);
 	input_set_capability(priv->input, EV_KEY, BTN_TOUCH);
+	__set_bit(INPUT_PROP_DIRECT, priv->input->propbit);
 	touchscreen_parse_properties(priv->input, false, &priv->prop);
 
 	priv->input->keycode = priv->keycode;
-- 
2.56.0
