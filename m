Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6083C3457
	for <linux-input@vger.kernel.org>; Fri, 20 Mar 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018355; cv=none; b=SH8oKEadqZXPgBE4pgK/jDtaDi1dY4ZXD24Lh89u9eqUbOB3bt4p9DZ5FpN03w9GqW4j3sNzF9LHUzlw3zwDKpjqCj487KLK5T+N8tvtIX+t8z3cHdT/6Pm6oSSxNmSFOQKmtjc1xB0KvKEBTBT3/mPUSqU7oMgEXtYX9UA6Wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018355; c=relaxed/simple;
	bh=bWCB5i98GUVHu1D5jnVWtk9sfTwm6mgsEF0tfg9BkZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDZUD3CZUf5qmU0pOFru+fAyuki/6qWhZpxLJyVSlLJY+e0/6DrDREZUDboWZI++VClPB1izTioTG8dP3Lv243ZUWKE/UcwuFqkw5695vK/6vz/aJQ1Nok0+8wfWfKYmTZrmEZbrEsm3SC1HoQ/Nzj1BkTFEIZwia+MzAP4o+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2p3Z0gF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2p3Z0gF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso578241a91.1
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2026 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018354; x=1774623154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXjhDdnDa0ijg1VTlgOl74pUpfJvpd6csZYcFWFPCgY=;
        b=T2p3Z0gFLTqDYgZO1GwicXmQv/TUC6xsWNSn2qajH/NeCmayoduGHjoHWyxXEOiz9r
         4XpM7H09vqLc0DJIEt3rGIbAH3uLRGb00XC1wMEs8esXj8bsRNQb5pEpScrjEvuTkG35
         UNWE3CDPE+Cz3N9104wy84XcfBoryYYlhfuiO1nD9QlNyb+zJcy3cANqFCkMaVszF94e
         AL96lNtQDcpoRffXLE7aqmdO6yDKI7N6kqlCvfc5rJIk8WOv9XySxJj4ojz6ZykETkwt
         cefPE6X4t1wtT2ZctG3drf9+8xcm5r3zJIsd8o1semcFsB/utirY7blICVyOD64AXdZd
         im3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018354; x=1774623154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXjhDdnDa0ijg1VTlgOl74pUpfJvpd6csZYcFWFPCgY=;
        b=MRbypN5+S8MOPb6f7x7cA/LwHXaASBblfAE+R9ou0xJwP4RNBkP6qyvEfVlVSWDjFt
         f85gqz+7/tbDB9VG/I6TjPIVSqFrYB7lL+xopexTEa5j3dOY3Xo1N0KiDnFwY+LoPpfT
         11gQuOxsdjYxr9lYxtgMJW1G0DByPKb97gcyCmn9OX3AkGDhEk3Zrh1e4jF2BoOTW5nG
         0qpiBcofTZ2+hJ5KiOU0tRSrX8weLOPvYrRXHLD8v8AUtHnXRGukg91eYzW7vtCfNVHj
         jGdqTfvwmdnvnAfZewE1YzJYy6lt1KB7baao48IGLCsFyuUy8UYh4/zmpXHBubVEw63S
         3NWQ==
X-Gm-Message-State: AOJu0YyPC7W7eej+I18+1wYhJrSou8MJ5gByUGXDn9GEXBw5WAAujQLN
	HyTAFElrIOW0euizVRV6vDDOw4vDCn1w8rrpX9+uVAAHFi7R3AJf2UqI
X-Gm-Gg: ATEYQzyrDBguWOxmGgGy7jRhUN8RX88hiQVuU72j4Lkeo/Q4gLI2FCDgoqNe3+Dk/my
	oVr39YhzaB9v/Vg6lVOH098+tEfJRgboDrT0KkWR5UAgQsVypFHZYy7acMFUpcemqY0+xDgw+z9
	VzN0dMh+ynVFCZtBLh6ldzwuVOvx4ynzbauyVQcGFhNMIHh7mzj7w2kJqaiqW0o17fLARSodjcu
	p1BE/wm/b+qQJjtECcYdgB8+knvR+dJM8htIr2X8pmztQnYjfHTIeZGgPivVY+KkzwgaJS4i+Er
	9bdxTuJEUu8icMuqbVIZOdGqkmule8br4UWeCscrzIvNrJBsb5cJt7+HXoqLXx3DFIe/08jjLXo
	iHZNqC1b7znAOPK7DpD//6aBK+QIQ1rCEui2mmeMuIaAdMVYa9Q7FtI3/FKYYdV1/c1O419zhy/
	Mz7dHEFkUYVHBym3Raq701lLfPWSx/nQ4LDQU=
X-Received: by 2002:a17:903:198c:b0:2b0:774b:d89e with SMTP id d9443c01a7336-2b0827b413bmr32815915ad.37.1774018353699;
        Fri, 20 Mar 2026 07:52:33 -0700 (PDT)
Received: from localhost.localdomain ([2408:8207:c90:e790:3de6:403c:8f43:3629])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b08353e94asm24623225ad.25.2026.03.20.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:52:33 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Nandi <xndchn@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH] Input: gpio-keys - add full support of EV_REL and EV_ABS
Date: Fri, 20 Mar 2026 22:52:14 +0800
Message-Id: <20260320145217.9088-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpio_keys_gpio_report_event() handled EV_ABS but silently ignored EV_REL,
while the polled driver supports both.  Extend the interrupt-driven driver
to fire an EV_REL event on button press.

For EV_ABS, use a shared atomic counter per (type, code) pair so that
a zero-value reset is sent only when the last active button on an axis
is released, avoiding premature axis resets when multiple buttons share
the same axis code.

Add gpio_keys_set_abs_params() to call input_set_abs_params() at setup
time, deriving the axis min/max from the configured button values.
Without this the input subsystem reports unbounded axis ranges.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 65 +++++++++++++++++++++++++++++-
 include/linux/gpio_keys.h          |  4 +-
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e19617485679..652a6932c52f 100644
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
@@ -373,9 +375,16 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 		return;
 	}
 
-	if (type == EV_ABS) {
-		if (state)
+	if (type == EV_ABS || type == EV_REL) {
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
@@ -493,6 +502,27 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
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
@@ -651,6 +681,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	bdata->code = &ddata->keymap[idx];
 	*bdata->code = button->code;
 	input_set_capability(input, button->type ?: EV_KEY, *bdata->code);
+	if ((button->type ?: EV_KEY) == EV_ABS)
+		gpio_keys_set_abs_params(input, ddata, button->code);
 
 	/*
 	 * Install custom action to cancel release timer and
@@ -928,6 +960,35 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
+	/* Allocate shared axis counters for EV_ABS/EV_REL buttons */
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+		unsigned int type = bdata->button->type ?: EV_KEY;
+		int j;
+
+		if (type != EV_ABS && type != EV_REL)
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

