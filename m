Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808221;
	b=RB7sdfBVU+lhNUmU6g64vuUFZYkVMaRUSHOoU+ZGhP9lqaB5Bxv8MK1SDFZK/7kXUccC
	 +5/oeHjYPWwPI1k4weGUM2PiSe3uYUZXDRfgmDe7bhzEa+WDvunKRYR9mpPHIbMtePTTJ
	 7rQQKT9jy6bfgatBwZFDkA+bwho8UQqxKLIm2UNnWFy1mZPCnqPuUW9/xchCAMyDn/eOR
	 Hi/Ak6eMJYbRhWTmXjxcsgb4Xrt9cmqSWfTB8Gdre+fMPQcOSZNC3fSP389O7s/JcV8yp
	 2njl+TuQM0TCtTW+LRM9l4cGSLs83wVovU+HNFLW0EwpbQUTefRVkpFsyQ5QZZEZJig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808221;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wkqpLMb20RzQErK2xs2bAHys9BIwofJK0FKv2jVLD5I=;
	b=LvS0UB3OlF0mt31+TGSMcn1M1HSULk8MjxxIPkv7g9ybZzcFmpF1djYK6h351sOp9KEK
	 AYJsIGewuQr9tx1XPeohMZn9regAMxP37Q9eslfqgtgVx5rf5zMj5qByOiay5uibilVyM
	 iM1qUb9Tskqoq5AzsKHl9+xW3d/iFTSak0vHY2doiLmDudjCll6UUYF0cYfQ2pxqIszAh
	 wJofymcyuRPLF/ZODvOlkbvvb4EIbUPFoB5XHRYesTpODiV4DYnp8YEXUF7XEamEDgEs7
	 u9LbH8eQdhx5m9JfJRHisNXwx5g/Kbt13oOIh++6kt41D5mKpc1vWr8X66AhZeDOtsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="8wKVX/DC";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA7606A31B;
	Wed,  4 Nov 2026 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEA7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=8wKVX/DC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wkqpLMb20RzQErK2xs2bAHys9BIwofJK0FKv2jVLD5I=; t=1793808220; x=1795017820; 
	b=8wKVX/DCDZ2g1+KirpCwbk53rXi25MtD4rbkTEDhMghfetHJzEn/VZLR0bFV431/+IuAIZWY8+P
	hPAMrLwzmYXOWpavuSbcy9mJpo9iRtqrE58H1V28Et8CnkAvOYbQeWNKcnSiRmMLIvh4lSm24wN2H
	pFSyvt6sKKsVsKtnOnSXOrBijbLATv+X6b7IwQsED87J+jo1SJenK03BUuVUEUCqzoSR/SLmRxZWc
	CqfiOAo4j/D47Zou0FB4cIV6SXrsEAG69Fz5nvIM0E0nGOIUcyHFtB9aFkDe9dqsqKyr0rz9no1z5
	Fp513lP2pq0Xylwr4joFCVToNI92ODRgN8VA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	andreas@kemnade.info,
	bartosz.golaszewski@oss.qualcomm.com,
	marco.crivellari@suse.com,
	arnd@arndb.de,
	tony@atomide.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: [PATCH] Input: gpio-keys - do not BUG() on requested wakeirqs
Date: Wed,  4 Nov 2026 17:03:05 +0100
Message-ID: <20261104160305.2501369-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the IRQ handler called when enabled IRQs arrive should be considered
as a feature not as a bug. So do not BUG() there when this happens.

Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index fbc31c5db3db..f1c31c5366f0 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -412,7 +412,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
 
-	BUG_ON(irq != bdata->irq);
+	BUG_ON((irq != bdata->irq) && (irq != bdata->wakeirq));
 
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
-- 
2.47.3

