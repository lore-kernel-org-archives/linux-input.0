Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C77379EDA;
	Thu,  1 Oct 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851987; cv=none; b=cfPp1Ujd4BbUQimOoBeXISBt8G6ygImAiGL60Cf8kaBS9kVwXwVC4BabEtjjsOTV1NBFnmvIrkXeHLXzFqpDGFgKnU4lvpfdBn8tlLG2EgGKzSV7iv37NCLIZ8DUnDvy8XWW4nKUpJaaILUgmkxBe3IQIQESYmvDhrnLzYLJAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851987; c=relaxed/simple;
	bh=YmiizVIOYHKqWOpOBSck0M51lxKIh+PACKiIebMZDiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObnBIHcx1R/MU6KHjPzot1Bl47D47sQhyht17KVLlqgQXWaugAvkllXXHRFQeS3Apt043qp0nwLmOdzPAR1Sc67ZROJbjr7eCQWnIeE7QGR8oze0oPTBdHcT/J87wkO8lGtfaOgrgB3eUZ/NA0JX5AZSeJWjLAy9Efg5z+x/ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCEPP-000000003gd-0lUk;
	Thu, 01 Oct 2026 10:53:03 +0000
Date: Thu, 1 Oct 2026 11:53:00 +0100
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
Subject: [PATCH 3/4] Input: hynitron-cst816x: release gesture keys
Message-ID: <6f87a6c44555a0abb5d7f677250c28aacb230fbc.1790851590.git.daniel@makrotopia.org>
References: <cover.1790851590.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790851590.git.daniel@makrotopia.org>

The gesture key is reported with the value of the touch flag, so it
stays pressed once the controller stops reporting the gesture code
while the finger is still down. Report the press on its own and
release the keys the input core still holds down on the first report
that carries no gesture code.

Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/input/touchscreen/hynitron-cst816x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input/touchscreen/hynitron-cst816x.c
index 865c5a767ba01..e2093518e8af1 100644
--- a/drivers/input/touchscreen/hynitron-cst816x.c
+++ b/drivers/input/touchscreen/hynitron-cst816x.c
@@ -168,6 +168,18 @@ static void cst816x_reset(struct cst816x_priv *priv)
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
@@ -181,8 +193,9 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
 
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
