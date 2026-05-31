Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67110785
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780185730; cv=none; b=u9+Qkp1CSwlObyOsVfLJxPS3qHGyQldWohGqyl0uceOqJ91VboY4XQl4PPhs2r16/iFddAVQ3ryjKlTpveQbZcNtw0hbbIapEj8AJkSYUoiE+vDEBNZ+mUAkLd9gWdJOElQYO5eTShn7WWrZS/gVzgyWzs247WFd8AEIyOx0V1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780185730; c=relaxed/simple;
	bh=8BHtkJfLpdANA/7gvQQe3U8D1TtwzJSe0unQtr75/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oN0zMzrZdBIDZKWHkOnTQzNZkUk6VZJnzxrUWNg0L6LoLhf+GJc1YSD1sQ+begJYmMt9DFZzqCXW57rbC3BVI52e5vcM7t3yuEIa++8yRDh13GxDlHadwmWURO/sx8vXSmjUSWAx1i9PLfRpGtbIo8447Pc8sC0KfURA35YO1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2lYx0Cu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2lYx0Cu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2716953a91.1
        for <linux-input@vger.kernel.org>; Sat, 30 May 2026 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780185728; x=1780790528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz+tYaL/n2SOFYxXIqEfPXFbS71u7Ip+6TJGZI271Bo=;
        b=m2lYx0Cul/PiDjR5m3nQLh24o9g4+yObjUVKkPler/WuVLYoC+WU9pjRgSPuFJSTRh
         M+ftFtbQ1WxJVmWsoZOWWi3NB9EfkUYX7906U4NybVcq4HMitO0gWZAtwB72u6up84O7
         2Sw2L1VGtJZEuO8Nq2pCarSr24QbBQ9BixAulpyRkgRo6QAjCy9QG1SfYofdokoGj1bg
         jWZJ4CofVtQJ63H+zSjYC2qXxlTuTjLx1hHZedqK9aVS5EjRgYX3WRX7/PwEhS3ql/36
         hKWSzkx5if1y5M3eSJ7vZYwc1h8stFkBORmb8JNCSX+EO50UJN0vjoUiS4cFi013Sqod
         O0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780185728; x=1780790528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz+tYaL/n2SOFYxXIqEfPXFbS71u7Ip+6TJGZI271Bo=;
        b=Tb67/IEiJDvBmfZtKJM+chmuoWEFFuDHmHtHwuKXtjDgrmstdBaQgsbdL2a9d9kJ5m
         KexgMzw089mVzs4lFL2QDxNWyD7ymWLe8cDVag8ZqOMEPvovMn2dinzvCYNJRqqi5GHO
         w+CH0jlK1UGzVNyyxUexKuCapYweRW3OAlaJeVUdGGk+VSbSNYfF6oZLIckciMI0t30l
         J6XIGbl5YRy69JHYkm9kn/hxQgfI9s4fJMCkGGk1yUNYoRan+iGA8srkdioBr6dTiZx0
         fOYkdNGRRaePDxzxt4sZ26vdsIV9I/FE5qQgiS5twI6cPP6pUAVfjj5+bHiygx8UlnNM
         0vNA==
X-Gm-Message-State: AOJu0Yx8wpEjEqhgT0fWL7jVo0tTYmi5SnXQeh6e5pJOVlbnPIYjcQ5/
	o4Tyo5c1XDZWD9MXuSai76Zt3PFbQcPKjwojzNZy4GpoY+HqAojXMwCHh5E8pT2L
X-Gm-Gg: Acq92OHgTX2CjKl5ECSgo7R1SWJch1Rr82x1Pu05WH4tdTHn+e6Y+T7rgs1m/8IKnUi
	feLzYFwZo62PitIl5vF18vAsuniX06kcEr9LepG19BT4zDzkxG6Ayr0lsu0/N6LFoU2nwY+Tt98
	y4Y0i4exfDp9O2dC+Mb3t6NbAshLfkiq+CgvBOwJkBRkNoqxVToo3y31RYzhUhj92vKFHJau9xO
	EHTquwVEIoTryhOCWi6wP+Qb33lA5mdqs/ibDwCgWmjKnbMDRCw7S1jlb0WGd4qchP1qXOG1HUm
	o7QHVs/MoNAeauGbhnXlnSU60Auu/WHniheqbXVNDYzCiFS3iCS1HAxn5qhWqMc1KpRkrCkODw7
	8eFRMm4mwIYkpK5yKm1C2gw1BTVsXL6Fd334CMQjOqHu1DW3K7QPE0xHuXXiK+KW76MXHLDibAs
	7cjGzEGHobB5p0YAzL/iFbwZgPpJEPM9y1Q2/p4vxqKrSJz/sNLeLeyJQDnrK1V2abHQzcK3Afr
	VoU7Qc4Ab6tMsO3L5zgCYoW3sP21ymqus4ZSfxJWctzdw==
X-Received: by 2002:a17:90b:4c:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-36c4ff0b59cmr4895119a91.6.1780185728164;
        Sat, 30 May 2026 17:02:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6bc0b2fsm6153381a91.17.2026.05.30.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 17:02:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: logitech-hidpp: remove excess kernel-doc member in hidpp_scroll_counter
Date: Sat, 30 May 2026 17:01:50 -0700
Message-ID: <20260531000150.378695-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The @dev member described in the kernel-doc does not exist in the
struct. Remove the stale entry.

Fixes: 0610430e3dea ("HID: logitech-hidpp: add input_device ptr to struct
hidpp_device")
Assisted-by: opencode:big-pickle

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ccbf28869a96..1990ba5b26ea 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -164,7 +164,6 @@ struct hidpp_battery {
 /**
  * struct hidpp_scroll_counter - Utility class for processing high-resolution
  *                             scroll events.
- * @dev: the input device for which events should be reported.
  * @wheel_multiplier: the scalar multiplier to be applied to each wheel event
  * @remainder: counts the number of high-resolution units moved since the last
  *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
-- 
2.54.0

