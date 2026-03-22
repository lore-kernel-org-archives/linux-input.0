Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EE175A80
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179395; cv=none; b=m+tkI5AcnzqTT+2zjB4iGSXCx5ei9ycd8KXVqQDVZ4mXi1RRZIUfaYqoysk1FkrItwqgUjYrosF2czCu35rYPx3xvLczw4QMsn8D3YjsiufS73V/3EvZM7wiNZyUY6BqaL9oLIi2uLMKthoVUHOGsfQ1OiJ3ks57GyQTJUSmzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179395; c=relaxed/simple;
	bh=33Q7+DMQmIAODT0OnbDSymzQ3eNHD1MSKp2X2wtT0qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j38YwDGfRVQjE264TIGvhT58btlnOjz7A9Gfq9khatwGjcHpPWBln6ziQzfdD0O43BLVuQHJlk/XQB8VT9G4Q1Tf7NFd+xg5nLPVjPUmJsf234iFKShu1qvwqsSGx2B9R2kZwjmIrxsr+Aqnr0m6FGG7NCKm0yM0KfYkwufNnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H89yQij4; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H89yQij4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128ebee22caso2569452c88.0
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774179393; x=1774784193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39ErwCcrrps5ICrC+rC1o1XtvsBygZKmIxP4LKkmMMQ=;
        b=H89yQij4Q0SGyRNh7nzyVp945Jms8p291waYdt9QUDzeo3RQIagyxfxAgkqq/F3HQU
         p47sDqgGxseuJ9MbAWIEV4H2X5Suw/w59TBmHlSmkU9nWuyFQ1LHCH1VkMtNa10MuEcJ
         jHbR8slo4/f12qrUdBUnnstm8VeW6qg0eREKHFfXuXv7o0KXmaY/4xng0/PumHhlHyvj
         dkJVWqJt79Eq4a10gNjcb1cEctac32uC75IiGwGdQzhHGVaZ0nf2I2qI+DSy5fmJad5r
         71QlY+8wrkl0FZqjh00ndp3Mbk/+6dKXv5j0QNKFo2Ko3fvMCU51PMy1EMgV6RRFzfat
         nC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774179393; x=1774784193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39ErwCcrrps5ICrC+rC1o1XtvsBygZKmIxP4LKkmMMQ=;
        b=AqIdOJvKRfjeoPFPl1KTwO9VJu6667G3hHgC51mGV5cxz1w1OO3Pw+5Dj2CoAJac8y
         b29c9kLHR3OwFNTIAesqDVQnQqGivXF3rLJOrVaL1ADgxuwyrd3X4xlj0BOITh9kzHU+
         ziN5HCvvW2gBilUo9ZSCYWGjtH52HKO93X1L6mCjGadSMm09Qd8KUV35ypD9qMPaIydf
         //7BBsp/XAfwlUr41DIPG6xcyV980qZyx+jL3h7hjvpRbpZ5B+VSnfSpeZWhCP9ny86L
         JaEooLHs7eZ0M2MwW0Cp+Q3YdJrlgSRPped5a7uA4qd0Bs8tGLlMPFoE/LEkBhyd3CRx
         NiJg==
X-Gm-Message-State: AOJu0YyKVP3V3+z4rN48dtau/YA0uG69GeZa5J5mEQU9kGnm1OLIKD07
	SZJw4UBHz5r6sMCbBS2CBixDZjxsWWVBzF2qZ+g8NyoeUk5JryOGuOwP
X-Gm-Gg: ATEYQzzPh0YTr0qI+SlC9xQu0aLyRmkfsCQgt3Y7gU9uBq9rqTTG0A08WbObhLcmU5x
	yJWGhUIhv/ETbsYZJ29+c+gxE85j85xAkr91E8peVDkGT5dNFwPhWQbtObxxGMVKIcccDEszQr/
	NPhcJZCt/bpgT7uiF2Gl7zyNopurwg7CLp/tPzWCEfIZXr2zH56aUpMjdA8KRctBIMpO5aA6Hb3
	vikX9n06E2s/GFwBT2d0s59EElwyvbI4ywYhw3/b7R/sFdONfsEQ9Nirmd5zBy+dpP/iHruRDRM
	cq4nvlMZ+MA/tvLzISU+dmTPSGpr1IHGVDgi+n6ymneB2zI10DzscHKCH5XJBNNWrT2YKrMO5db
	PcSP6yRJgX7nOEhj7oGrbVAD77oc8KAh5gyjsF3HJQZXz3Q6/3n8n5QrJZ0UACvl/qOLYeesms8
	7jL/orDko9TTL96S72uxlWtIN/2NW8DuJE
X-Received: by 2002:a05:7022:68c:b0:128:d5f1:d594 with SMTP id a92af1059eb24-12a7265ef91mr4310133c88.10.1774179393460;
        Sun, 22 Mar 2026 04:36:33 -0700 (PDT)
Received: from localhost.localdomain ([2408:8409:ce0:691:14fa:6bbc:50dd:e268])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12a733fe80esm9022181c88.7.2026.03.22.04.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:36:32 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Nandi <xndchn@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: [PATCH v2 3/3] Input: gpio-keys - add EV_REL event type support
Date: Sun, 22 Mar 2026 19:35:08 +0800
Message-Id: <20260322113513.9380-4-xndchn@gmail.com>
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

The polled path handles EV_REL but the interrupt path silently
ignores it. Widen the type check so EV_REL goes through the same
reporting and shared-counter logic as EV_ABS.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 6 +++---
 include/linux/gpio_keys.h          | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 4cbfd5a273bd..652a6932c52f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -375,7 +375,7 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 		return;
 	}
 
-	if (type == EV_ABS) {
+	if (type == EV_ABS || type == EV_REL) {
 		if (state && !bdata->axis_active) {
 			bdata->axis_active = true;
 			atomic_inc(bdata->axis_count);
@@ -960,13 +960,13 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
-	/* Allocate shared axis counters for EV_ABS buttons */
+	/* Allocate shared axis counters for EV_ABS/EV_REL buttons */
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_button_data *bdata = &ddata->data[i];
 		unsigned int type = bdata->button->type ?: EV_KEY;
 		int j;
 
-		if (type != EV_ABS)
+		if (type != EV_ABS && type != EV_REL)
 			continue;
 
 		/* Reuse counter from an earlier button with same (type, code) */
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c6..75a745a32fe1 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -13,13 +13,13 @@ struct device;
  * @active_low:		%true indicates that button is considered
  *			depressed when gpio is low
  * @desc:		label that will be attached to button's gpio
- * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
+ * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS, %EV_REL)
  * @wakeup:		configure the button as a wake-up source
  * @wakeup_event_action:	event action to trigger wakeup
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
- * @value:		axis value for %EV_ABS
+ * @value:		axis value for %EV_ABS/%EV_REL
  * @irq:		Irq number in case of interrupt keys
  * @wakeirq:		Optional dedicated wake-up interrupt
  */
-- 
2.25.1

