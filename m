Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AA2749C1
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775625565; cv=none; b=hg+Xl0g1ZggO7MOeoCM2stOfc9pI3soMynXervE8UoThCWn/bb0xzeS4VS5EOIYvh3FYUvigWEuek4dSilFnirJ8cF7FAliSlbsXhm45TUgbcirW74R4kBMaTkVqJDJdBrkwnGo+ITvidxfh9CDOPgbZm4y2HInVAodqbviZOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775625565; c=relaxed/simple;
	bh=gAiqo1yEFSKZ4qMRWRKAF3hrIlPxkPVZO8mJMVl77xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWfU8jLtVNIuDcYJzrtj2UgGTvMc1X+ehRWM+Jiu/PldiUEM7CkOE3e/6/fb5jSQ8R1uz3rooYFZCfzBsQvpU3Tubh7EMyy84K2hKxrBBkgOrsyasWb1YKvT8MyqVssbiea5C8fChGhseMDlquRPnyk8h4kala1bFE8Vs1WTe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L313TnGi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L313TnGi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d7c12e48eso6054781cf.1
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775625562; x=1776230362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e6IVtq/fL2ky15iy49mcCbTc8AD9BaBUiCWPPudmx4=;
        b=L313TnGin1WyB3Ss2e4JCsJPRjTLzGIhKYS13ZizXSegsSUQEVq1myJ14gkJeb7avO
         yFb9DgiO0SEUdnksGxWArsnOq5rXBjSC0cQn1H01eNhOAl5hrs9jw/B34ReipiAVjgGK
         5VLCtTWjDHE5ClbZwzv5R5XniI7LAyhYRb0yonCcRiHqF5UqnfgDq+yKGbSIV4OSVXlI
         yI4WeF4NXP3tVkssoMji8qCbcBSJOB+fBoi8Cdrz2/BD7GrPDpp6rG7G6juSODXRdE8v
         K5k7DaVERF5TZP04bSFkzpYA7l0XtofjcNyHwKfAIHhRsHZUV7fTHhqHO4fLiv01HX/n
         Y9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775625562; x=1776230362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e6IVtq/fL2ky15iy49mcCbTc8AD9BaBUiCWPPudmx4=;
        b=Kzyv90EZFsnfUTdh6H/4f699TlDtsybRG0wIByVFFQ/bv/cwikKoc1Ex48Mu/o8/HQ
         uzN4QIV4l92gC/Drf8j7sM9fcSMv2HJTSef29UYEhuNv+3GwzDvd6DjKraeAlKX+VkFu
         KTSWnoAPj1Jb7WETTMFvpxq9DM8UJ9+VpSlKHe4YdPPOtFL30fc9nJKig9tdpJszoJSt
         kCEg6al5yHuIvW4vOPNTVHOt+HDu7S1vPdfg+69JpoALCSeRLbMVsrKsn8HB/HtnpEQJ
         4vzvlJNuGnbx1PTfwIdHS+BN7iRqC38jxrk2IeQCpBffljKh/Bnv6UJq/6WPe6UXSP5m
         sHlQ==
X-Gm-Message-State: AOJu0Ywyt9oVQfmBqI8HYJ+neBbBoa37kTq/lXEKV4lmFtL2SVLidr+E
	Z8tRvJ6eihd07g50SH7ckmL5c4f3EVROXLJSxHanE3rmk7Pt9mqkqpEo
X-Gm-Gg: AeBDiesnWGhAAyA2Usi2O43XDUZxFmDLBsU4Q6mSskE8NB6GHtQlR0xpkWmrfgkCrgS
	Ns9sYF+xhD/6YLBvCW0ShdSC0KFi7qXZb5L/mZ1vhXOQ66n4C2JEj9cktXce7UPINKyH5HU2yKG
	jhF1TXYjGR8Bf34HTnibZzmMTYV9sYKLrNaMF/8eDET4ziilr+Ok9OQQzv2HS6HCs8gyamyaYA7
	5bKY45gOfoLQz2fDLzNun+uWb+kBJ50em2Q/oS0r8aVc2aeQpkwEpSNEtlEmmt1yfv59zvEBmiw
	tFclMWotvgRJv5082kjC1kFQd2GR+EvVNb5eQ4Ab8sXWfdGPBaJ1jncNkC5Y9Dqx6E39sWsPiHp
	kczDeI8IeuYa8R5Kfdm/rfWGYpWHt/XpSd91bOD9eXktgF+Nb5AHkOOhAl2RhW1bk2t/D4iylsd
	I1Ials9GZZMxErnswYlDByKpsvEFzd9USahfCDuGBn+Je1FAw=
X-Received: by 2002:a05:622a:1a85:b0:50b:6d63:6a2b with SMTP id d75a77b69052e-50d4fa369admr283109881cf.2.1775625561886;
        Tue, 07 Apr 2026 22:19:21 -0700 (PDT)
Received: from LAPTOP-3SN9PV9T ([42.112.110.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm162919616d6.47.2026.04.07.22.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:19:20 -0700 (PDT)
From: Thanh Nguyen <thanhnguyxn07@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linus.walleij@linaro.org,
	timon37@lavabit.com,
	Thanh Nguyen <thanhnguyxn07@gmail.com>
Subject: [PATCH] Input: zinitix: iterate contact slots by finger count
Date: Wed,  8 Apr 2026 00:19:07 -0500
Message-ID: <20260408051907.792-1-thanhnguyxn07@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On affected devices (for example Samsung A3 2015), the value in
touch_event.finger_mask appears to behave as a count of reported slots
rather than a bitmask. Using for_each_set_bit() can then skip valid
contacts and break multitouch gestures.

Keep filtering by SUB_BIT_EXIST to avoid reporting shadow contacts, but
iterate from slot 0 up to min(finger_mask, MAX_SUPPORTED_FINGER_NUM).
This follows the maintainer feedback to treat the field as a possible
count while preserving the anti-shadow check.

Fixes: e941dc13fd37 ("Input: zinitix - do not report shadow fingers")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221278
Signed-off-by: Thanh Nguyen <thanhnguyxn07@gmail.com>
---
v2:
 - Address maintainer feedback: do not revert e941dc13fd37.
 - Keep SUB_BIT_EXIST filtering to avoid shadow contacts.
 - Treat finger_mask as a slot-count bound and iterate 0..min(mask, max).

 drivers/input/touchscreen/zinitix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index 716d6fa60..a2edae7df 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -471,7 +471,8 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 	}
 
 	finger_mask = touch_event.finger_mask;
-	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
+	for (i = 0; i < min_t(unsigned long, finger_mask,
+			MAX_SUPPORTED_FINGER_NUM); i++) {
 		const struct point_coord *p = &touch_event.point_coord[i];
 
 		/* Only process contacts that are actually reported */
-- 
2.51.0.windows.2

