Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17593A254D;
	Thu, 30 Jul 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440936; cv=none; b=sf1cdka9KePm8/vKDzeFh87UCku2JNDd9vgwoVzK0ViNWaPXhmfMyXm/yo7dj0nK716UWXRZLr3ewbInGXJN25iklbq41dvNMfIGdUASY6k5PpZpuxF9896es4ifiVikNOndfrF2H+NB9Ru/7n2sJv2LhXD0whL/3/WU73khJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440936; c=relaxed/simple;
	bh=Kx/SqQ5YypakUXn6zd5yZDIz4kpBBehlvhVjWn5tQFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTM+frfqMd/GbewcUzOqAMKylGJi4xKC7TJFZzWSzHuQpj+p5HtCN33lMMqSPT65r5EYnyNE4SRDW8IFwcm+YdvwKauNJAAjZ2QUtdDBkFgy7DpAQSDmq+1P3/R8FcScmyuXrNif+6FlDtp57oSO4D8J2nYYiPljw90RaPEWNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HQhm7n1u; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HQhm7n1u"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6B59641B83;
	Thu, 30 Jul 2026 21:48:47 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XI_ohf7IfS-w; Thu, 30 Jul 2026 21:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440926; bh=Kx/SqQ5YypakUXn6zd5yZDIz4kpBBehlvhVjWn5tQFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HQhm7n1uHtUAchYEysLVLhkwrzhRjkM+V8qbu+3yo7A8nHamF8sOq7X4pO1vIX1qV
	 uy2FVNe79/tlDoFBPBWSvZeiIUu07UdOM8Vt9a3yLIGvPm2vK8316i/DaoiNX9EIy7
	 tbzTjqzF+v6F9r7m8OYpl/HKuFBsvWGpmX7wFsDsrRjXXP3Qc1WdBoVDi6RHdnz8Hc
	 90w4C6pFf0EBRpj/9Mj1ZyOnNC1k6X4c3z1P/soFT+nfqM0fQNvUc6NpBd7lfw9GqN
	 x3D6oQb6yXVO3wQkSj7BjlHaXnFkI6Jst0oYvw71wTs6Yldb85VI+ZmjMt1/sGtbmn
	 yfv1zb+QVXxlQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:18:21 +0530
Subject: [PATCH v2 1/5] Input: zinitix - check all available fingers for
 every touch event
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v2-1-ffe2ec9a9031@disroot.org>
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

When this initial driver was first added to tree, that is, in commit
26822652c85e ("Input: add zinitix touchscreen driver"), the touch_event
struct had a field called finger_cnt. It was supposed to report how many
fingers are touching the screen.

But then, in commit e941dc13fd37 ("Input: zinitix - do not report shadow
fingers"), some touchscreens reportedly exposed a bit mask for the
fingers, instead of the count. So the code was changed to bitwise
iteration.

With my testing on the ZT7548 touchscreen of the Galaxy J6, I find the
former to be true. This shows that there's two valid methods depending
on what hardware the driver is made to work on.

One solution is to implement both methods, and use some flag to select
between the two. However, this introduces more implementation overhead,
and a possibility of regression on devices the driver is expected to work.

Instead, unconditionally check all fingers. The finger_mask field is now
left unused, thus serving as padding bytes in the struct. For each
finger, zinitix_report_finger() is called if the status reports the
SUB_BIT_EXIST bit, so phantom fingers are not going to be a thing.

Moreover, the android driver [1] does exactly that, so it's a tried
method of implementation.

Link: https://android.googlesource.com/kernel/bcm/+/23d376ef33aa4c500a5ea24a290f029d5f8e2de3/drivers/input/touchscreen/zinitix_touch.c#1942 [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/input/touchscreen/zinitix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 0c36765bd79f..3421b8ffb19b 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 	struct bt541_ts_data *bt541 = bt541_handler;
 	struct i2c_client *client = bt541->client;
 	struct touch_event touch_event;
-	unsigned long finger_mask;
 	__le16 icon_events;
 	int error;
 	int i;
@@ -470,8 +469,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
 	}
 
-	finger_mask = touch_event.finger_mask;
-	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
+	for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
 		const struct point_coord *p = &touch_event.point_coord[i];
 
 		/* Only process contacts that are actually reported */

-- 
2.54.0

