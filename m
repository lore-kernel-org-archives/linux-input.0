Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE126056C
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781478846; cv=none; b=t9wJnBt6jpLrNHDDLEPxsqwyqWVrgcyfa2F5urA0fBeaN1WX+QqWq6p2ypSp//38oG7+ZXEeNcO4+Bcm4Z3XMQCuhe1N56BCVGdchUW7FcYMQExNqEPJO75+BQ4NfsKaKl3Bhezbb/J3TCL7mm6k4Ti+RUVE/kX7MxddDFK5Bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781478846; c=relaxed/simple;
	bh=q+8GgFY+dd3IIWuVIIparQD8LWX/WYB3KqPHcyn10Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXPsjuTfSKNcNNQ9T7dR6vPvah9u3KbMgKGhq6KPspIR0qtDmQGyaS/5mT6uJv/nk6E3nbHREye7/vCGkN7lXUSh55wSn1D5kerD5Wy/IJKaGbNmO69hvv7efinnMGLKNxUrg4Co1z7ITVcL1hPH+Eh5kCynY92wLYZPwdssxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GizL3rNc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GizL3rNc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3e03939so20417525e9.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781478843; x=1782083643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjC/SF7YnoUgzygAXrOjk3AG/UvKlNKu3Qop+wzKITc=;
        b=GizL3rNcN19pYhSZJzo+L3/LPgH72B9zaFUX/1+Qcj0fsZqnOszHw58xz9n2oMMZnS
         nKq1k4+koXr7rlEAaMeoMtG5nyectFCwbXRgXgin0AvnXZimf0rL02L38NRmBPUxn5Uj
         Zhqj8vqRgKSNnxM0kXYzQGwdk9FBSsffmGELDi/ljyi+MOQGOHQ5URc2jEKj0Xxs2L/a
         gDA+RWNFdeliqZJ512+63XvQ50L3gCYf6SWznnJYpZ6RaVg8ZXAI1dfydrjrNW7RKgZM
         l4Bom/SKNodDmT4rrvD5ld7Y+nk5DYW/gFEosaw04g71amUlFNEhv0QTW6zqvJzRlBdq
         K96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781478843; x=1782083643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjC/SF7YnoUgzygAXrOjk3AG/UvKlNKu3Qop+wzKITc=;
        b=cl3Uz2uHg2FjNJ+GHpEgJ1oxsBOsK2dBG54053BBb7Mq+TmBtpPD3rhtXMzcHRTSXT
         FlYidfBhHNWRchRX5efWUsMtRr+/sH4pS+CNgAzy2ysHBamc+bWw+zKopgCwaq50kNiU
         XoC0yMbK2xEaBkcDnRu8Vbh52QxkNjaOQDq17tA+vAm2lEJBd4NbUmDFMXHe71PB2kxV
         KnkzJMY+Z9LOi5kgM6m1sc81z6Z+lFZNUw5QvIe6y1QgwLZS7JUu5OE3XpezyjS2IgwK
         zHnIeunSARSTVnbMfUm3gkMMAJBOr/QbVIu1+Uv+lG9IUla5LvjFH6CQdGHX1GpESF11
         BAKA==
X-Forwarded-Encrypted: i=1; AFNElJ+pQJvC5N3ECfRDpiDNL6NYwUv7dYPCOYy3uffgPH2uRUZPqjoIk6JJqR3Wes4MS5z3Dw5sXqCzM/FFRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhelVf0NdfEZzy5YV+zaiA9NOWQKQRCucILPn6nXui4D3xk1nS
	TI8z0kAqKpkkAR/4MoJPPHFKdEXwjJknfVgL4+SY146NmhsxFxE7fpf8GmI4iyF7J+4=
X-Gm-Gg: Acq92OE1mHQmeDP5e/NxlO++If5NSsX4AAyKgFiS/Wjyq3vcEN5sI5tqDbD55icJQkm
	/xcucPFhgIqYxYl5gnz4SVply+5tg7GoE3FeEMRPGOZnV1HkF9gNG5IeEnxeI6KK747BAFHoFSu
	tfSRukWdowkmCLKceyXc0csw2jdQQyrr1YNXrZoMJdKV3dGlPmVN7Gh1o/3hWyeve9hLJpWgLg3
	Z8mRmnIf5qsJtbPNhemALSZMbJisXKaSIgsXdVi439CHPUWLKogjhqNPcrKwUdOt0YJkkap9jwp
	ItDP94oe8SvKK9ADbkIB5AENGOvgh6beK7J4use20IHpql+NoQG4YZMeORjl935bDA1Za0zrP8D
	N1btc8plJS8Z5ekcrb4TSWTcFRDAI37xDZkhYewty6uiZyQGr7VdyP69mE16LDuA1oOCSeLc3LR
	06//CQcO/UX3RV0x/8z0gu0bLyIurE9i5aafGhJRrLxGREGZ4dUkwlQVC3ngVVFo8/u14K2P5Q8
	lcjNgq5RTMORBU=
X-Received: by 2002:a05:600c:820c:b0:490:b4cb:3866 with SMTP id 5b1f17b1804b1-490ec4d77a4mr118517165e9.10.1781478843364;
        Sun, 14 Jun 2026 16:14:03 -0700 (PDT)
Received: from arch-btw (cpc106993-hali7-2-0-cust876.17-1.cable.virginm.net. [82.6.131.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220304180sm193120435e9.4.2026.06.14.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:14:03 -0700 (PDT)
From: Oliver <oliverburns.kernel@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver <oliverburns.kernel@gmail.com>
Subject: [PATCH] Input: sur40: fix MAX_CONTACTS value based on PixelSense specification
Date: Mon, 15 Jun 2026 00:08:47 +0100
Message-ID: <20260614230847.4938-1-oliverburns.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Samsung SUR40 with Microsoft PixelSense is offically specified to
support 52 simultaneuous touch contacts, not 64. The value of 64 was an
unverified guess as noted by the FIXME comment. Update MAX_CONTACTS to
match the documented hardware specification and remove the FIXME.

Signed-off-by: Oliver <oliverburns.kernel@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..77ec2c94b91f 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -128,8 +128,8 @@ struct sur40_image_header {
 /* polling interval (ms) */
 #define POLL_INTERVAL 1
 
-/* maximum number of contacts FIXME: this is a guess? */
-#define MAX_CONTACTS 64
+/* maximum number of contacts */
+#define MAX_CONTACTS 52
 
 /* control commands */
 #define SUR40_GET_VERSION 0xb0 /* 12 bytes string    */
-- 
2.54.0

