Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3F42D774
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418833; cv=none; b=BJfD+W1aThIhCOLPQW0pJnoz0pzlpv1+AO7sGeWo/8pR09C+ZBEIqVRmrb5ucnrzeTVL6KM/TGAM0Lkj7s1JIL0dxWGsY7JWOoRQz11z0xVTBEsvJK5guQOA7aVWB0h9f09+xKSKtSIUYux1sj9m4XBPUaZhaIlZphQrp9OefoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418833; c=relaxed/simple;
	bh=eEglfdU5NKeCVkGM1ZbDEcNdiQaf6a8VpYub4K+kR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUxQpQKyyviziSoKf9z+tntXoq/AdqbfnZBdkJCyjwupojGCNq5b84nTcV1AzFba0bGy8V6Gilg0Ii6MfTszYqqTfx5G5jbRwK/cVm1+ovaBw1pp3v/hS/eV8E3wSmOWEh3lIb6Jz26S3HZCCZZLTbBN2gmjzgUj1o+t40QaiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekEqOmFF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekEqOmFF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954df200ddso13042835e9.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418830; x=1786023630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXlmEM+opo6hR1/SsuBV9a6HOAEDgwAGIwmp3dr8Q0U=;
        b=ekEqOmFFG9Jm9LjmaNyNRgKDN7xvC6UVFlioCFX0r8LJ5ZJF1oJ+LOVPkx0i2pZ4Rr
         EwH0znGuAZ0Crwp9M3SQbXpXRDPtbP0Apdzk3NqeP3w7zsYxpsz+ITcbeA6OI+Ze6WC6
         otzzVrbNKJ/JJ2Yl1CeJMOTa7UmDvlQPp4GNbixLvAkqwm67oCYiDYqpkR6Q3UGkoDBq
         uP2zI0znhPr2N8NtWv5cWiTR8R1lBDG4KbOZL6qWaGTbD0/sM5bPN77GY1LrBndmxHrp
         pcmeNTfZlE/DHEUf4XYEf+9KGI0xW0i2AfGFOGHTsfTYgF+TSB3dmhe2Bg00qNWu4NIY
         TPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418830; x=1786023630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXlmEM+opo6hR1/SsuBV9a6HOAEDgwAGIwmp3dr8Q0U=;
        b=B1J8Lhl1vHtUg3ldc+WdJhiBmOIXHiNODJC1e62musZHAwPm6toYpK/oP0D08cz0Bz
         2gj9fks8ZU4JVPZ9kfXrYbf6w5Yjcy/AaPaLfxGA8BjLroMBaCYxpEalBsPm6Evye3HQ
         E0QTk98DdFBRQ6aVZwaVM1yom1fGG5JKMacrKaIWCpJTHjjHjz2d40e840lnDOYeEoAN
         2B1rBHCkBm6PRtDbANpCe2v8GcTtl1GQV1PdrM00QaiZxS6VWmnWos5IKyHrsgqMCNoD
         ML80j1EMbZL/o/1mTZICf+/vAuUqkyOiWU/RYApyxqwhSzj/m+9pLid+99svrjvqTSLJ
         /PKw==
X-Gm-Message-State: AOJu0Yw+jvbIBgYqzNzwW1Mh6WTTEYrfmvQEkPQL8t5JCYE8eGjRXYT0
	R7Ky/2yKR4cCkvt9mRxIG5I4QZAiMvw+itis+/a0Z7BelXR3cogocrfCLLlRMWvm
X-Gm-Gg: AR+sD13qOHiBVTNtBLen2W6bmlbzSo+55uGSKtzIWJKjfFdg5ezuhmxdjoOZm0+7BJi
	Kj3ysP5oRKnftuhrOswPEh0b8XOpF7JE3obAWXnvG2ZmR8eQZlN+cNeWmLDD5AbxKzkF+e3jCWl
	07FLjNWy4Z1XPv9ItO4N3mjuKnW6v84OoybZ/6pmbItV4gVB5RULI8FzhpW7yKoy5Ra85/EJWHq
	7ObLfmErpsKVnHXFxPY6x1cjSl8QtEI80l02iTMzziVX6M+LrOAKQvaIUmP61U5V76CJlhDYaCB
	XmsTC3rMvXD0/fzY8qmzzgfdOgwNYQ7oELqDaHSVinYi8ckw5nSCh85Zo60cZA9105ZZaYDs8o2
	eZijSyUhM3MRR9o1ObYF1/kiLlTc1X+UmBoBPO1E55Nj3iYjfRi5Kfh8qM1LkGJTk/8d1767usH
	UXKO/pdVk+L3HRzh94zauImKXcn1+X/MpnCDOuorOLCgkk1kv6nYZW+Xuj2hQOZQTxpkVMYIVt/
	xCVethiF3bm3r1vkMiIjl+4jmcWYtY=
X-Received: by 2002:a05:600c:45d5:b0:497:ffd4:ee3e with SMTP id 5b1f17b1804b1-49800ea001bmr37209415e9.20.1785418830423;
        Thu, 30 Jul 2026 06:40:30 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm66405305e9.15.2026.07.30.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:40:29 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v2 3/4] HID: debug: Add FF_TRIGGER_RUMBLE name
Date: Thu, 30 Jul 2026 15:40:03 +0200
Message-ID: <20260730134004.1118476-4-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without an entry in the force[] array, hid_resolv_event() prints the raw
hex code instead of the name in debugfs.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3583,6 +3583,7 @@
 };
 
 static const char *force[FF_CNT] = {
+	[FF_TRIGGER_RUMBLE] = "FF_TRIGGER_RUMBLE",
 	[FF_RUMBLE] = "FF_RUMBLE",
 	[FF_PERIODIC] = "FF_PERIODIC",
 	[FF_CONSTANT] = "FF_CONSTANT",
