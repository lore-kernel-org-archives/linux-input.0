Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2542FE58C
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179378; cv=none; b=FKZEcTqt3J5gs5f0T4SYd2yGlXt1Kj8SES8CrihSKmmorhZ2YsOnQCYLML14tH+IXzn4sfbZDGqG7ftg/EV/dJOPX9J0jEN/135kN7ZQgJCARHVCZE4uYNmtdOYxrMdoJVEZ6V6dWSILooIJJXgCzACLcwaGnUnZnTbdR24DD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179378; c=relaxed/simple;
	bh=DIYGAKkiQv84DjravR8l4cNaQPIv7NXQM46FIpokZTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4ckXK0y0vgpxvW1ZPxYokzG4nTzcp0EPeAovEPqYVcGr9FAbKWviEcyHbZt2BILRmraDyJURjMq1qZEelozmgJlPvu1GuLJOChj6Q3KG4AIjiuwEuiAoZOI+8Sl6pGBPi5uQmWd93VcUbXsUOEWcT+3oFh4o+WXF2zoDZjtpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfy1HdY3; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfy1HdY3"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128e4d0cc48so2028032c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774179376; x=1774784176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn1Es4G+aXzKHxbyqkIp9Lp8O3htDnPp83ZXbdVyV08=;
        b=lfy1HdY3hroBb745X3sirDX1Jsx5QfdJCOshGIpk4p7qA45IopmXL/2DrSn+qid+AI
         i02cRFcV+KI6Y2DfZzG870sH27Cr68dg5rFeMrfQrU3/uPwQgVxlDyG4LJNMNNq+K/+g
         mOw2BckRGmpJtVU76jqVj6vH3dvFJQ2fZ2GPm84ga+aZd6v08pcSKnE+GU1MVrVIGQV0
         oi2KjW7CUVsM1lYPeH3WpzXHjqFpAOvwh6SAXEKLuufQmIXqX04xhdTXiAll23vBQ8Xh
         XomLp8gVcwJxIvW3t2Nm2RMWb7wDuwqMINnQboOfQcOQUokvJ4JnkTvUaTBBe0A2S4W5
         prMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774179376; x=1774784176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tn1Es4G+aXzKHxbyqkIp9Lp8O3htDnPp83ZXbdVyV08=;
        b=ZQtwxgrwo5zKO5Cd0TPWsqY9sN8DWBfLhQ34SGYw2u2UNxBbgZOcqqB1Fbtjsrk3lH
         UK67+YK1ntpW/feES901WqmmpLqgHyteoPv2TnF6Jj3luIlMpvOqzLFca5jgyEp5Yfc/
         5fpEQNpxgTZollfeeTmHq1ZqZ9JnWSKaGL9rNylh7Z4RAPAOaHw5mpbkQaDjMkLRlZX0
         QUc+g3p3PpCDj/OzYKMD9uMrG2+LSqAt79lDjwhM51q6S6oQnkv+1TGSWOcSRm7BDN2+
         37ggcXfZgzuWegp+Pu6ZaavFsusYxs05p/hbVROrz7m5JE6tkwHhpAKEXwR71bFgqwPF
         QASw==
X-Gm-Message-State: AOJu0YyP1fc2AmbHTxpwlwAC85DzePRjyePhkSa+1MXFqYI0kG9EyRuR
	zd3z6CqD900c6hoE8VKndaxQoqg9MMYglPXTx3p0YHoNZSrCVP0T+36i
X-Gm-Gg: ATEYQzyOnb+ZuCj6QXZY7JZQBTp8K/PBNouukMKSE8ByHl8OhsK6BN54tnOW4YZWu4P
	d2dXLQC9ES8PNvm6vCsYq8RhckKHxEC4sstngz1Sxmmx/CHhJLrGU+SZ4y80HrIeCXONo+UCHtW
	FPJi1Or9aVGKtQtG/VpEoNTCuR+XPuyfD+CV10F0nsAfVnwG12rMM7v3N50HuC7e2LbUBVSGyBx
	LEyrUTD/el7cwnL1yp9KUnFjlTvt7PGjMXH9QdQJRQmw7MigUV+abIh5LERkzESnKjKqEmDxsHw
	H/cfLKjgYOriEgIcovOZxGKv+z0ELeONZo3odJ+tOIdKzceUDsyv3a4FwFzbVum8YvOvq835VRu
	q9/+hniwnHpj5wHgkHVVdVeDt+7sVUXR5A8DBfW0TrpTYr5ueSyBr5nHpRUA0TaWHcW86Iyyf5N
	eim+vKBkUv9AjJACVmWQMo9zcLU8c4s/rp
X-Received: by 2002:a05:7022:424:b0:11b:9386:8254 with SMTP id a92af1059eb24-12a727038b3mr3714811c88.41.1774179376152;
        Sun, 22 Mar 2026 04:36:16 -0700 (PDT)
Received: from localhost.localdomain ([2408:8409:ce0:691:14fa:6bbc:50dd:e268])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12a733fe80esm9022181c88.7.2026.03.22.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 04:36:15 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Nandi <xndchn@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 1/3] Input: gpio-keys - set EV_ABS axis parameters at setup time
Date: Sun, 22 Mar 2026 19:35:06 +0800
Message-Id: <20260322113513.9380-2-xndchn@gmail.com>
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

The driver calls input_set_capability() for EV_ABS axes but never
sets the actual axis parameters, so the input subsystem sees
unbounded ranges.

Add a helper that scans buttons sharing the same axis code, works
out the min/max values, and calls input_set_abs_params().

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e19617485679..f97ca8dd073a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -493,6 +493,27 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void gpio_keys_set_abs_params(struct input_dev *input,
+				     struct gpio_keys_drvdata *ddata,
+				     unsigned int code)
+{
+	int i, min = 0, max = 0;
+
+	for (i = 0; i < ddata->pdata->nbuttons; i++) {
+		const struct gpio_keys_button *button = &ddata->pdata->buttons[i];
+
+		if (button->type != EV_ABS || button->code != code)
+			continue;
+
+		if (button->value < min)
+			min = button->value;
+		if (button->value > max)
+			max = button->value;
+	}
+
+	input_set_abs_params(input, code, min, max, 0, 0);
+}
+
 static int gpio_keys_setup_key(struct platform_device *pdev,
 				struct input_dev *input,
 				struct gpio_keys_drvdata *ddata,
@@ -651,6 +672,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	bdata->code = &ddata->keymap[idx];
 	*bdata->code = button->code;
 	input_set_capability(input, button->type ?: EV_KEY, *bdata->code);
+	if ((button->type ?: EV_KEY) == EV_ABS)
+		gpio_keys_set_abs_params(input, ddata, button->code);
 
 	/*
 	 * Install custom action to cancel release timer and
-- 
2.25.1

