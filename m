Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067F3AEF46;
	Thu, 23 Jul 2026 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834672; cv=none; b=en4+2pXGMbswGazog/IKZweiPnFzkft/ZNlQXyYNkp6KsV/WSRx5BJKBqPETSloUH6GVyPVJ05LCKJiFZIV5qIcP4pV/RwBDEWzSXufvHu5LvAjC56ADd/Vf7Yobc02FASLI2W70T4QjuTRwX8sF/UDoUJdkCm3gtATv1gMCFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834672; c=relaxed/simple;
	bh=Kx/SqQ5YypakUXn6zd5yZDIz4kpBBehlvhVjWn5tQFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdX67lLIXFktZ/wJC6V70WHBcbQKB8dD3RbmulCMS2TzF4Z9CxZ7HVfxPbXslgq5jHPiABY5YMKMo0ccL8hBXvFXv4obeazhPfpYKSarAuuNN795OuHlcnku8D5CzQOnTpY58L2yd75QX4dBw8g845G2iPy7i+n4OzA5cW4eQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lYt8B6Ec; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lYt8B6Ec"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5742F8005E;
	Thu, 23 Jul 2026 21:24:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkwcVC02_uHg; Thu, 23 Jul 2026 21:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834667; bh=Kx/SqQ5YypakUXn6zd5yZDIz4kpBBehlvhVjWn5tQFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lYt8B6Ec8aCKgHoeIAWI5TNzhPf7xhbGeO1SuXw3/brsqt7GjpBKlviQGv4IzTLOv
	 5iB+qRE719Msg0JRxLIFA8Ad7h71dSJnUIB+ucopXoxJBDZfLopkg+/rr8L+LGrf4l
	 h7kpa5AjgAw7jmgUOKGwj02GfXibxIWFx6i/sVhRP/b5XHAnl/NZZORFlRWS/7sUKB
	 4a/Dn1dnhaRcU3TmdHkls9hBjWSV2ORJyk8+CQM8SQ+QkTwXFcZn8nRHI9egBW1yjb
	 0dZlR8J1yX3DJuqQUbZsl6sOGC+wVF8PafN2uFiUMzH24ztlZQ3OJr+39aV057YtUR
	 OZQc6EWW77pjw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Jul 2026 00:54:03 +0530
Subject: [PATCH 1/5] Input: zinitix - check all available fingers for every
 touch event
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-zinitix-modes-v1-1-f6df7d86a878@disroot.org>
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

