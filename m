Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672C388E53;
	Thu, 23 Jul 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834680; cv=none; b=Mycan9dVdMx4kVIR/W4SCcd9a0I0kJwxvQ2uvCvIpFvSNw4TMLuGnGlA7tfthmdqbXcmcLoB8E7mg0AIlql7Ms/M5mzgyxMTYBNlEzBKpwGNFx/R1Wbs6RA8jf4Hp5SUvRan86DjSGx1cowaax0bxhtV5NUriqkXiwNfOOVbraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834680; c=relaxed/simple;
	bh=J3J022ZGj9ZwKPT7jAjojwthMO7BRByaqpFAI8V+BqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZiXYkvmqGssiFxyMaMyFeeDo7LL4DWgaHry/8sc31jr3sXhBJ49/YKqyYnjT5TJpGugQbEwVKGGfg2YhHWB6SxzHLr5ieiAp42svNoXdxp+xGW1gDX9/DaPopz7u5x4xZiq/JfqtUyVSuCbYJoQTafzR9KO2nzFb2pmHOUcs2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FzMWymWb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FzMWymWb"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DD2B79D778;
	Thu, 23 Jul 2026 21:24:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sm6cQttzSK1e; Thu, 23 Jul 2026 21:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834676; bh=J3J022ZGj9ZwKPT7jAjojwthMO7BRByaqpFAI8V+BqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FzMWymWb3aucVymjRY+8heXQP/xL6u/90f0d0wa9YrMhAjvcyWfjgrw2X/R35dq9j
	 Py3o0a2hMV2rGnQqgtJ623XpzGVTbxve3Y6TS2rUqQCe+4yLSom6MzDunY3crok5C6
	 s3ym6ZVQOJf/ezHYDDg5IqDHQO784+tknzMng3+stXb6RuSmmV6PJB1qDBrNxPzwyb
	 a85dyiObGZqqVbwR5OmJbZabqwQSASX+oNkZ4h3CrXHZnxflWEIonyXc9vCO2vHdDf
	 2g1mj/suyQWKV/r1UUUO34OsCaA5GymUNKFGNf+fe0I76dalUoWwFSfOQmQiF4XW2e
	 lvnhpJNfwffow==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Jul 2026 00:54:04 +0530
Subject: [PATCH 2/5] Input: zinitix - do not ignore non-moving fingers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-zinitix-modes-v1-2-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
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
scren, moved, or drawn away from the screen.

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
 drivers/input/touchscreen/zinitix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 3421b8ffb19b..fdcb80f52c91 100644
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

-- 
2.54.0

