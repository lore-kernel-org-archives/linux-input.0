Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69E1684BE
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470777; cv=none; b=NT7yuCSgBWpepS1LRPw4vz5D5/lWRIexiMKvrmgq9MQKe18dGn2sXIN8PMQiq6pTekH/n30gd4kdtfeQIAPT0O5+NzZTzdmKGRvpr5fzvEH0+yUy0fYGwwm9USEEx6fyIbmtFMfhZ6F3aD88qsG+P4+Sm8noQkKd+NoCXl6nYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470777; c=relaxed/simple;
	bh=71Pco1NKvzYOgDQFPKWlV/QQfZzmcsD9+Kah4+wKs4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfEhRSwGwT0hcNZScRwDfokV0DOyF77vwuBk0XNPuGLcDTEyMwoZG9NOGi+s15hqx+FE8zaP4S0G7mVub+WJLLEb67y8xDkE34Y5kWgG3QS6g7L40m13kTzwY0rI3HqFpeN+OerTKG47IZmUZJyCd/04xAuN4y6zLJFPkoxUd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com; spf=pass smtp.mailfrom=cirque.corp-partner.google.com; dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b=KGui10Ja; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b="KGui10Ja"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-447207fb885so51457fac.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cirque-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1783470774; x=1784075574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S+0b9PO2VuXYQdQayE86fJIhTlqbTK6Zlb8iw7pO6Ts=;
        b=KGui10Ja7xO+EGZvWt6YPIPgyTR5ByO9z/HAV7ZlFGdNY3YF+4h2VnnTrT2EsnKBTf
         tmvN8q52Q7H4mZkJ9/SlozPOtr+BQjbH/n+QSWYXqqYdcwdzFCoOKhtWPeC86a0c/x0n
         GmlNYy8EX+/78NsbAYcbCGSS5h5a6/HCvtUMRwAM7tPTRmwPhvaoyNsXsxx6rQ771dL+
         /BfKq6jOi/f9cGCNcOe8PmjeuanewLQ+T1169xlMx7oeJzdUqBiwYn89xhmjJe6yDqMn
         Y7INDcrE4VTzX5ujfM1JDj3Hbvf/K2dKwS7iXbx9XPbgrB3gcLftBqpOCepfzvTtlQg9
         bNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470774; x=1784075574;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+0b9PO2VuXYQdQayE86fJIhTlqbTK6Zlb8iw7pO6Ts=;
        b=YG5Qx/AxvqavnP8ugQ83z4g94g2QIhqyCXt0CngT51NkGe7h9Z1boIMyXW9kfZCXD3
         iCm2jquu3B4fb2NBRsdJrz/9OdRqpxtof+dSV7yPXBT5wXxeFWsPUD7/iXu7nZQXXamK
         PRD7wNB5jFcufIhLgOy4XVPpNZkrnQH10RuCT51OHF/SBLtoy7B+839NDxova4WLvjxg
         wK1u0Os4yM1IIwtwhzTpY2JH9MTsEQeqVHSxxS9h9gemvSilQS9wMPoIdmloTl96eUp4
         WqoKgz0on8UhF0IZDAbYlXXxb79Q5aEqW62/jPesMce7d7bfYmAcShXSMwcR3AEo6MJU
         KcNw==
X-Forwarded-Encrypted: i=1; AFNElJ+Am4lvsnN6gHzcnujrMJUcnwIsUEEW+yfsFdXMTO5x7STnPEgjBmQgjz3fbzKfeAb+N+TUHYS2dEkd0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWN3wcKKi9xdJvqfWlqasWE70tdfDvufc51olGp8AFfENRyUCp
	v9T31Hlhw4YgAQfaKOJ8DNydElJhfTdBPNcAr/NdbQ+fwu2pHcmaFdWeZMGvB2mx3qI=
X-Gm-Gg: AfdE7clOI27GmNpjNTJoDjVuD/k/tKhRyrtG7d/tvX3/ZfCsW38AAkaTiiCu+daslia
	z91IWCfD+jWiiwMnb9MhY0JsUFddMme+uqNdjyLjcRNqm6Tmd6n9WE3qVIq8bhYUApvPbe5ipLA
	2UdkJ6jPGONWB3O5PQ4c5xMOceaJAuwQiT+ljtYOZY3FNuIcGvK7OYYyTKkPIP9weO8kQUEXtRm
	aPeh3UQfuMcRBgQaF3q1THRCt1xZzgBrGqb31FYg+erCdPK2Bo3zZRVbjgfnzjuOL0/ZELZ2d3R
	ruHPRlJWDNr5U+pgj9bFNi/yVI5UfyDGtzI9KcpTKVCS6ElC5r+WGHYqsuBWqwGl5xLBioEM3hT
	q3DouRfRqLVaKeXfYItNxEAMUXte29FHWa5LCOOyEmzYA8/0oO7e/Kz1Whh/iTM/xGwmVOmSe8w
	c8uVh0NX1dbQ==
X-Received: by 2002:a05:6820:2114:b0:6a1:5756:10d3 with SMTP id 006d021491bc7-6a36da8098bmr227013eaf.22.1783470774670;
        Tue, 07 Jul 2026 17:32:54 -0700 (PDT)
Received: from Armorhide.. ([2601:680:ce01:1ab0:829f:8735:5765:ed5d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a5b559dsm801148eaf.1.2026.07.07.17.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:32:54 -0700 (PDT)
From: Vadim Klishko <vadim@cirque.corp-partner.google.com>
X-Google-Original-From: Vadim Klishko <vadim@cirque.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	dianders@chromium.org,
	treapking@chromium.org,
	raoxu@uniontech.com,
	superm1@kernel.org,
	kenkinming2002@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AJ_Cheng@compal.com,
	kevinchou@google.com,
	andy.hung@cirque.com,
	andy.hung@cirque.corp-partner.google.com,
	CindyXT_Wang@compal.com,
	frank.chen@cirque.com,
	Vadim Klishko <vadim@cirque.com>
Subject: [PATCH v2] HID: i2c-hid: Add a quirk for a Cirque I2C device.
Date: Tue,  7 Jul 2026 18:31:08 -0600
Message-Id: <20260708003108.20288-1-vadim@cirque.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703144726.14808-1-vadim@cirque.com>
References: <20260703144726.14808-1-vadim@cirque.com>
Reply-To: vadim@cirque.com
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cirque touchpads with PID D0C1 generate an error when probed
by the I2C HID driver, resulting in no hidraw device created.
Adding I2C_HID_QUIRK_NO_IRQ_AFTER_RESET fixes the issue.

Signed-off-by: Vadim Klishko <vadim@cirque.com>
---

Changes in v2:
- No code changes.
- Added subsystem to the subject line.
- Revised the explanation.
- Link to v1: https://lore.kernel.org/all/20260703144726.14808-1-vadim@cirque.com/

 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..496589277bd5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -334,6 +334,7 @@
 
 #define I2C_VENDOR_ID_CIRQUE           0x0488
 #define I2C_PRODUCT_ID_CIRQUE_1063     0x1063
+#define I2C_PRODUCT_ID_CIRQUE_D0C1     0xD0C1
 
 #define USB_VENDOR_ID_CJTOUCH		0x24b8
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3adb16366e93..63004bcbfa71 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -136,6 +136,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_1063,
 		I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND },
+	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_D0C1,
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	/*
 	 * Without additional power on command, at least some QTEC devices send garbage
 	 */
-- 
2.34.1

