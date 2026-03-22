Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAA32C302
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179387; cv=none; b=ZiJa7/0ePk0t1Pvxkwxn3xAj4L1TMzPBWKbqckdWi+QkHKFu2YAiFXvYKTfMXEUF9QD1+SoQTKA9v/B/jxkzuggetKVp7VTxqdWMVXa49KzsXAPwWNTyPWpYI4yZnosOuUFqtBq7IoC+u8yZm3alZ61VFuNCZjuXivVZDzupD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179387; c=relaxed/simple;
	bh=oP8iPYwELlN3bc8kEB9JSXu3FaAd0wPrhrPNSAWbHd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laLX2gqRSJk3GViyXsJ45nXdP4VxVdnZm17rGQ73lLN15p+9FP/WIIlg/cbV4DnRrROCd/nxTMcGrQmwCmyRiJcV8m8jZEUemxfIdM54aBAZq4nzS+Tp+xNn/Cg1MHWTUUc4IgFYWR61PWWQx+uKJyaYA+UWS+uhopbBAuFZzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN6P88zU; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN6P88zU"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso4243279c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774179384; x=1774784184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAgor4tni5JNj1fMi6G3//s4wOx2xwRy8ot6naCedx4=;
        b=FN6P88zUpGZuSL4sNmgYb3wHSIpkEokj3e9o/pF2JvU9UY2TUXxndErqC4AhQaObRh
         J2NltbrjSoFNAfUIc0g8e4b6KasqL9QOYxCafhdA+lSdQQrR2e0qovGXKw4wfxEbWrAU
         sUICmvP7B/Mr9yHaolINi7oyvvqnV35JqOfIJTqke5O9Cfjp1fwxnNwRz1vIYJ8YyLnQ
         4rJc6xGadeaSu3s9W2brUI5AP2u+K4iI6MHi6NSVHHBBqs1ANWrA1vzwFiJnOM284eSE
         VyK8cO9TpWnh2mmg4mQS8LQQx4dUKe8UIL8u7ypDp9ml0sCt+eu34r8AVANu3z6jl5CQ
         DLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774179384; x=1774784184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAgor4tni5JNj1fMi6G3//s4wOx2xwRy8ot6naCedx4=;
        b=SXDsUlUpkZ+gVinTxkWszVaSxOoC+GW+hdPE0MXZ4JuQ270H1pTbNP+6EPIWGiE1Xo
         k9qXU2DgxmUGL5qY5yic2nGqbf/B5Pi+51C5YVQD3z2taFfumKkw5JJrvcwb3c5RCSmb
         BQVmRg9i3ryr+8jSdMwZyGqwzhhkn2cMpp7ngFFGA+rM+WItTxmQOQQwwWjA5aFk1Pkx
         bTuQ8krGFFm+mzW0D/uJmcE/PHM7mcMVBmgoIao3UltlVdARrJQSMXlsSd1/lVJUmXRf
         GW918IcAWdRyah0geT3FItN36FLL1QvjeKzisfYmIC8Z7FBueJhIN3PA2A/mAgAaflhj
         kx9A==
X-Gm-Message-State: AOJu0Yzqkzn4tY++zDVIleabFy67Zfe+HjrnCXq4XBple4j5+TmDyMhi
	1lSc8ZEiddA26U2cwQCdSl9+9LkwOGk0lIcwvK7gdWQWVP94WB5f5uR9
X-Gm-Gg: ATEYQzwS9tHXZ2p6qL4Kz9Fa0Ff4ieQ3yu0eNPpARLhiu15Oxu33VAkKhMVl9CPL1Ug
	KpZoki7x4N6t00W1hJ130HpySW7ZqlYI6Mv8DJzwpB+kQZfSRuC7zmm7LMG64/sDIYcZrH/gyvi
	Ju13wQIyAbpzQbz3hdq5po8ZIyalzShLbKIJaN536AhligVDzMQy/HIrEcagUY+QqUmQJnEavYx
	jQzak0DOrnyh779n1fbYKjUfw1fsd+WCQfNdPsMrDHrXoUVoOHSoUFV7YD7BoMKOss0mHM80USB
	2XYn/gCkjsR9F72nzGNUGgSs7wbFEPZuiU3PRjwVPQcUB0kLh20UbWdh+drZobf501SdJG+1lds
	RTL74d1VzlS0DRnPLSqHe5hXPS7+JbBxqLWUmZ4+Xq/Bp7TN9J8b3UGLBegAWs6ESy97XL6zFuO
	NCqpzdpPJylbkb1WG9DI89VhdgifOyu0SN
X-Received: by 2002:a05:7022:226:b0:128:d4be:7433 with SMTP id a92af1059eb24-12a726ced02mr3880711c88.34.1774179384391;
        Sun, 22 Mar 2026 04:36:24 -0700 (PDT)
Received: from localhost.localdomain ([2408:8409:ce0:691:14fa:6bbc:50dd:e268])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12a733fe80esm9022181c88.7.2026.03.22.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:36:23 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Nandi <xndchn@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v2 2/3] Input: gpio-keys - use shared axis counter for EV_ABS events
Date: Sun, 22 Mar 2026 19:35:07 +0800
Message-Id: <20260322113513.9380-3-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ab5CXO6Fk7lhGazv@google.com>
References: <ab5CXO6Fk7lhGazv@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When two buttons share an EV_ABS axis code, releasing one button
zeroes the axis while the other is still held.

Add a shared atomic counter per (type, code) pair so the axis only
resets to zero when the last button on it is released.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 40 +++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f97ca8dd073a..4cbfd5a273bd 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -51,8 +51,10 @@ struct gpio_button_data {
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
+	bool axis_active;
 	bool suspended;
 	bool debounce_use_hrtimer;
+	atomic_t *axis_count;
 };
 
 struct gpio_keys_drvdata {
@@ -374,8 +376,15 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 	}
 
 	if (type == EV_ABS) {
-		if (state)
+		if (state && !bdata->axis_active) {
+			bdata->axis_active = true;
+			atomic_inc(bdata->axis_count);
 			input_event(input, type, button->code, button->value);
+		} else if (!state && bdata->axis_active) {
+			bdata->axis_active = false;
+			if (atomic_dec_and_test(bdata->axis_count))
+				input_event(input, type, button->code, 0);
+		}
 	} else {
 		input_event(input, type, *bdata->code, state);
 	}
@@ -951,6 +960,35 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
+	/* Allocate shared axis counters for EV_ABS buttons */
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+		unsigned int type = bdata->button->type ?: EV_KEY;
+		int j;
+
+		if (type != EV_ABS)
+			continue;
+
+		/* Reuse counter from an earlier button with same (type, code) */
+		for (j = 0; j < i; j++) {
+			struct gpio_button_data *prev = &ddata->data[j];
+			unsigned int prev_type = prev->button->type ?: EV_KEY;
+
+			if (prev_type == type &&
+			    prev->button->code == bdata->button->code) {
+				bdata->axis_count = prev->axis_count;
+				break;
+			}
+		}
+
+		if (!bdata->axis_count) {
+			bdata->axis_count = devm_kzalloc(dev,
+					sizeof(*bdata->axis_count), GFP_KERNEL);
+			if (!bdata->axis_count)
+				return -ENOMEM;
+		}
+	}
+
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
-- 
2.25.1

