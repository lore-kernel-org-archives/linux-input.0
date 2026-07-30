Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78F31985C;
	Thu, 30 Jul 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440953; cv=none; b=hiFqZYQQHqOz7W0R5+SzLiXsSauh7LRaqbX15U/eXVm+jXdWIQkMt11PMLpUz0vc/E/bL+JRRs0L7w+tDWkALOuCsb8ZlpbvqrNUk6ma1YIk7SaxEGOxM3neAId7n9pe1atOnUaRs6a+UtBKAXhopLRILfy8sD0Jxwy9oSbnRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440953; c=relaxed/simple;
	bh=5OosL7UAzAlw+AfOM4QcdD9qlKoevvkWJfZrS6zvBNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6+bdC2xU9wW4Vm3GIo7a4mivHP5H0/BPdZumX0SgXdIVO0JnAFuJclgv68E5nqGfG5AfZYDRa5/eI+t+LhgYGo2lm3+LnCKoUlVPR3dYWZ7SRQb7SsrHvAWNy9HM7I6fX8D9wdkSFsVE12EtdIkr6YFVDf0cYK2H12l2TBgLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RfPxy95n; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RfPxy95n"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2070D41C0A;
	Thu, 30 Jul 2026 21:48:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twh4_bGASbqc; Thu, 30 Jul 2026 21:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440938; bh=5OosL7UAzAlw+AfOM4QcdD9qlKoevvkWJfZrS6zvBNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RfPxy95nrBGr4RUcT6igf1c9IC/it5/M8WhA8SDcCraOn351JXMlcQNP8vagstq5f
	 pqi1RBiV/2aIqCRik7ikWAkL3kMqX6qgVctOmDAQBnTp1y/fQZeCCshKurk+yr7qHH
	 D7AhEy6wrYjD7oRHS7NnwQBpKlSDdmeoSAY4Esz5Ykjh0WM+oUjvA2O0hH/3xlKGAd
	 o5WsDsK17WoqAXDVuoEW6sBarOBWRys+dUeW1PSRLGptQbO04sA/T4amD9uPS2n5Ej
	 DJNZfWDnuqSginQZnxRTb4CQpiTP6HL2dNTXWM5mMzmBgxJIXHctdQHcYlXDFZnwo/
	 2bFVkwd1aTWTg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:18:22 +0530
Subject: [PATCH v2 2/5] Input: zinitix - do not ignore non-moving fingers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v2-2-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
In-Reply-To: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

With the ZT7548 touchscreen present in the Galaxy J6, multitouch does not
work reliably. This is due to the fact that the driver reports fingers
only when their state is changed, so it's either placed against the
screen, moved, or drawn away from the screen.

The function which is responsible for this is zinitix_report_finger().
This function is called from the IRQ handler, under the following
condition:

		if (p->sub_status & SUB_BIT_EXIST)
			zinitix_report_finger(bt541, i, p);

This implies and ensures that every valid finger must have the
SUB_BIT_EXIST flag.

However, at the beginning of the function, it refuses to recognize any
finger if it has none of SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE. This
excludes fingers in reports which do not move from the position since
the previous interrupt. Add SUB_BIT_EXIST to the list of valid bits.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/input/touchscreen/zinitix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 3421b8ffb19b..a0a89d25e25b 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -406,7 +406,7 @@ static void zinitix_report_finger(struct bt541_ts_data *bt541, int slot,
 	u16 x, y;
 
 	if (unlikely(!(p->sub_status &
-		       (SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
+		       (SUB_BIT_EXIST | SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
 		dev_dbg(&bt541->client->dev, "unknown finger event %#02x\n",
 			p->sub_status);
 		return;
@@ -473,7 +473,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 		const struct point_coord *p = &touch_event.point_coord[i];
 
 		/* Only process contacts that are actually reported */
-		if (p->sub_status & SUB_BIT_EXIST)
+		if (p->sub_status)
 			zinitix_report_finger(bt541, i, p);
 	}
 

-- 
2.54.0

