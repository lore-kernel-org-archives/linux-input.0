Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980692BEFFE
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124779; cv=none; b=LqgyWBfqp5VvcL5PjjlsIbBPHt9kgTFK/mwQlw+a5Ab5Q9mjOAkkd6EJ6otCCrSblVf1T2wL/k6wGmPM9GuL3Y1NsSoJuIDH5oRlZFmGWNUQGThWOBqvKpWKWnsqKUTtylsnypHnIda6ZArMCTy112nsbLNh/6DhPQQ18MYH9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124779; c=relaxed/simple;
	bh=5ngumEjxfAFycPTzcVq1fGSTOt9ubavv/yYOSrGeaec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwTc/Acb8kQIjj3G544k7XE8BuNXDz0KCUdYqo7fAgmwno4wojc5H/jqJNndExQtKMFTmsxCwGvYRW3oKXWU9oy30C31QDGeCM397UDNRMrZaOFl3aShw1dOKi4Uy/2ZzAd1aQNvh3zez9ZjhqkoCopzPnR/hoNh4zPsAm75aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzhcfBKQ; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzhcfBKQ"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5fff77ff719so1778057137.2
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124776; x=1774729576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fSugZcQTh0oH9WEdoXD6zAAOWVvT2ciBhlERPxyzt8=;
        b=QzhcfBKQqsqRSiN3XtxfMypNVDG6J38UqsfE+wbkr7j/4Bbry0HTaAbGhl3RuZCm7t
         V3YJ9/fBrhm+CkpnTnHp1u+rX5O4bH5LvSFPA00KoCaCz6T07vzBGeDKeIE4gJ7LAw3u
         xeGf64LuKNc6G+EDtc81wIlBO+kG9LM6Fh1l5szDD6HW5ircWPkBpt5A4GmyAsVR2VmR
         3Z6EzC1vjFvrRj9fvWgB98Fxhf6s+uSjizPL5qAUP5ZTLz+cAuzZ9lhWC+G3iQw0QAyG
         jpEeRPIUEAzZwq/enkhM88afp4fAwToLXWEt6A9+8LNQw9ROys62tZ2T3fGRb1ttrNeR
         1sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124776; x=1774729576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fSugZcQTh0oH9WEdoXD6zAAOWVvT2ciBhlERPxyzt8=;
        b=Uq+b1PhL3zFf3hVAQsyAPqbTIP0pwMJiFqWQG1ueJ884+y7HLdEQjinnrXUhe1gngd
         s2juxhxWD6ljmmGpqr8n3IsVEHFEKCArBJpMxEeGxo3BwS0zTgNscJ/kabbHUm0ON6d+
         HM0LmKEDcZJSIvIy86CRFSj+4p0390cqVdnz5CXFbc5pZBTvfotYTss4QBih7CyPCRW8
         jw1qxOkulGcNR+8tZXDd22MqfDGs0Z0rSQsRo7BUqqY9iRt2+MN8QZCgf4WtHc63+lnJ
         Q5mzllfkf8SWTPy7STNrWhQptJEB0rwXmS/mDXtjlFAK/5861Rx6Ng54xudlkVTQpwDm
         qO3g==
X-Forwarded-Encrypted: i=1; AJvYcCXNoD/Puz54y6J3FHAF0tryIuIwnoXyHEQxfrseFReXW6+pulC1ukfpU8u2l4mi3yyLkRXXhfzXHzbPZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzr/wpH8T4QCY8aHTA9A9hcSvkTf77OAFWZSK3NNXJclkk3vnk
	YUgsskzREEgkbspLUZ5gNl/tv+nss/tm40/9HXQn58ontHi03QBIDZEE
X-Gm-Gg: ATEYQzyIJFV++E8IoB2SH8Pqgky31vlywRfG94m1drsovLaZlYou+G3P7J51+XdfXDc
	YcZgak421PTL4H+o6ZVSjngzmtXVGLpzKxy5K1eZfc69fEuu2Jy0w6PfgdJ9noil3KDkMhzvZ3l
	QcQ0fLWCycKiZpBQRGRlC5n7Ir2FSgEIRirnLf3Aqz38N0FB7WwtCJwWSkUqjunG24YlgdY+xR2
	IoEqJSaw8hwfnVmraU9fw6kQTvxTRmF591Qnj3hL6iVqZNvQS2bKhqkdYYlAZgnwMceO4kUOZK8
	+r+0s4VJEGvA9/MkDI5NxGv3n3l8XU75R7LuqkXwjAsxL5PKxpi/lyyJjgKZOFHFa+us1R0iOOf
	qjitZTPgXxNNapPvU0TyM/0NwgALLGSksIocgAJvWh0HRaZHxy92aIS3/WMfmTVixIaVRN2bn/r
	eyLIwmdSoDAfZaz7prZqjSqtXC3LnBRECosQ==
X-Received: by 2002:a05:6102:38cd:b0:5fd:ff75:f437 with SMTP id ada2fe7eead31-602aed93dbfmr3558152137.33.1774124776545;
        Sat, 21 Mar 2026 13:26:16 -0700 (PDT)
Received: from charlesdias.. ([191.22.16.211])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de53d9sm4144378241.8.2026.03.21.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:26:15 -0700 (PDT)
From: charles.embedded@gmail.com
To: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [PATCH 2/3] Input: adafruit-seesaw - add interrupt support
Date: Sat, 21 Mar 2026 17:24:45 -0300
Message-ID: <20260321202446.724277-3-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321202446.724277-1-charles.embedded@gmail.com>
References: <20260321202446.724277-1-charles.embedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Dias <charlesdias.cd@outlook.com>

Use IRQ-driven reporting for button events when an interrupt is
described in DTS. Joystick axis values still have no interrupt source,
so axis reporting continues to use polling.

When the DTS specifies an interrupt, the IRQ thread calls only
seesaw_report_buttons(), avoiding unnecessary ADC reads on each button
event. The polling path always calls seesaw_report_axes(), and calls
seesaw_report_buttons() only when no IRQ is configured. This avoids
concurrent access to button_state between the IRQ thread and the poll
timer.

When no interrupt is available, the driver falls back to fully polled
operation.

Also remove the now-unused seesaw_data structure. Axis values are read
directly in seesaw_report_axes(), and button_state already lives in the
driver data, where it persists across calls for state comparison.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 drivers/input/joystick/adafruit-seesaw.c | 141 +++++++++++++++++------
 1 file changed, 103 insertions(+), 38 deletions(-)

diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
index 177b42446e9b..ed8896c639ce 100644
--- a/drivers/input/joystick/adafruit-seesaw.c
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -11,8 +11,10 @@
  * Product page: https://www.adafruit.com/product/5743
  * Firmware and hardware sources: https://github.com/adafruit/Adafruit_Seesaw
  *
- * TODO:
- *	- Add interrupt support
+ * Interrupt support is available when the DTS defines an interrupt for the
+ * device. Button events are then driven by the seesaw INT line, while joystick
+ * axes are always polled since the seesaw ADC has no interrupt source.
+ * Without an interrupt, the driver falls back to fully polling mode.
  */
 
 #include <linux/unaligned.h>
@@ -21,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -31,12 +34,14 @@
 #define SEESAW_GPIO_DIRCLR_BULK		0x0103
 #define SEESAW_GPIO_BULK		0x0104
 #define SEESAW_GPIO_BULK_SET		0x0105
+#define SEESAW_GPIO_INTENSET		0x0108
 #define SEESAW_GPIO_PULLENSET		0x010b
 
 #define SEESAW_STATUS_HW_ID		0x0001
 #define SEESAW_STATUS_SWRST		0x007f
 
 #define SEESAW_ADC_OFFSET		0x07
+#define SEESAW_ADC_REG(ch)		(SEESAW_ADC_BASE | (SEESAW_ADC_OFFSET + (ch)))
 
 #define SEESAW_BUTTON_A			0x05
 #define SEESAW_BUTTON_B			0x01
@@ -67,12 +72,6 @@ struct seesaw_gamepad {
 	u32 button_state;
 };
 
-struct seesaw_data {
-	u16 x;
-	u16 y;
-	u32 button_state;
-};
-
 static const struct key_entry seesaw_buttons_new[] = {
 	{ KE_KEY, SEESAW_BUTTON_A, .keycode = BTN_SOUTH },
 	{ KE_KEY, SEESAW_BUTTON_B, .keycode = BTN_EAST },
@@ -142,39 +141,61 @@ static int seesaw_register_write_u32(struct i2c_client *client, u16 reg,
 	return 0;
 }
 
-static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
+static int seesaw_report_buttons(struct seesaw_gamepad *private)
 {
-	__be16 adc_data;
+	struct input_dev *input = private->input_dev;
+	unsigned long changed;
+	u32 button_state;
 	__be32 read_buf;
-	int err;
+	int err, i;
 
-	err = seesaw_register_read(client, SEESAW_GPIO_BULK,
+	err = seesaw_register_read(private->i2c_client, SEESAW_GPIO_BULK,
 				   &read_buf, sizeof(read_buf));
 	if (err)
 		return err;
 
-	data->button_state = ~be32_to_cpu(read_buf);
+	button_state = ~be32_to_cpu(read_buf) & SEESAW_BUTTON_MASK;
+	changed = private->button_state ^ button_state;
+	private->button_state = button_state;
+
+	for_each_set_bit(i, &changed, fls(SEESAW_BUTTON_MASK)) {
+		if (!sparse_keymap_report_event(input, i,
+						button_state & BIT(i), false))
+			dev_err_ratelimited(&input->dev,
+						"failed to report keymap event");
+	}
+
+	input_sync(input);
+	return 0;
+}
+
+static int seesaw_report_axes(struct seesaw_gamepad *private)
+{
+	struct input_dev *input = private->input_dev;
+	__be16 adc_data;
+	int err;
 
-	err = seesaw_register_read(client,
-				   SEESAW_ADC_BASE |
-					(SEESAW_ADC_OFFSET + SEESAW_ANALOG_X),
+	err = seesaw_register_read(private->i2c_client,
+				   SEESAW_ADC_REG(SEESAW_ANALOG_X),
 				   &adc_data, sizeof(adc_data));
 	if (err)
 		return err;
+
 	/*
 	 * ADC reads left as max and right as 0, must be reversed since kernel
 	 * expects reports in opposite order.
 	 */
-	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(adc_data);
+	input_report_abs(input, ABS_X,
+			 SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(adc_data));
 
-	err = seesaw_register_read(client,
-				   SEESAW_ADC_BASE |
-					(SEESAW_ADC_OFFSET + SEESAW_ANALOG_Y),
+	err = seesaw_register_read(private->i2c_client,
+				   SEESAW_ADC_REG(SEESAW_ANALOG_Y),
 				   &adc_data, sizeof(adc_data));
 	if (err)
 		return err;
 
-	data->y = be16_to_cpu(adc_data);
+	input_report_abs(input, ABS_Y, be16_to_cpu(adc_data));
+	input_sync(input);
 
 	return 0;
 }
@@ -182,42 +203,72 @@ static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
 static int seesaw_open(struct input_dev *input)
 {
 	struct seesaw_gamepad *private = input_get_drvdata(input);
+	int err;
 
 	private->button_state = 0;
 
+	if (private->i2c_client->irq) {
+		/*
+		 * Read and report current button state before enabling the
+		 * edge-triggered IRQ. This deasserts any pending INT already
+		 * latched by the chip since probe(), preventing the IRQ line
+		 * from being stuck low on the first open.
+		 */
+		err = seesaw_report_buttons(private);
+		if (err)
+			return err;
+
+		enable_irq(private->i2c_client->irq);
+	}
+
 	return 0;
 }
 
+static void seesaw_close(struct input_dev *input)
+{
+	struct seesaw_gamepad *private = input_get_drvdata(input);
+
+	if (private->i2c_client->irq)
+		disable_irq(private->i2c_client->irq);
+}
+
 static void seesaw_poll(struct input_dev *input)
 {
 	struct seesaw_gamepad *private = input_get_drvdata(input);
-	struct seesaw_data data;
-	unsigned long changed;
-	int err, i;
+	int err;
 
-	err = seesaw_read_data(private->i2c_client, &data);
+	err = seesaw_report_axes(private);
 	if (err) {
 		dev_err_ratelimited(&input->dev,
-				    "failed to read joystick state: %d\n", err);
+					"failed to read joystick axes: %d\n", err);
 		return;
 	}
 
-	input_report_abs(input, ABS_X, data.x);
-	input_report_abs(input, ABS_Y, data.y);
+	/*
+	 * In interrupt mode, buttons are reported exclusively by
+	 * seesaw_irq_thread() to avoid concurrent access to button_state.
+	 */
+	if (!private->i2c_client->irq) {
+		err = seesaw_report_buttons(private);
+		if (err)
+			dev_err_ratelimited(&input->dev,
+					"failed to read button state: %d\n", err);
+	}
+}
 
-	data.button_state &= SEESAW_BUTTON_MASK;
-	changed = private->button_state ^ data.button_state;
-	private->button_state = data.button_state;
+static irqreturn_t seesaw_irq_thread(int irq, void *dev_id)
+{
+	struct seesaw_gamepad *private = dev_id;
+	int err;
 
-	for_each_set_bit(i, &changed, fls(SEESAW_BUTTON_MASK)) {
-		if (!sparse_keymap_report_event(input, i,
-						data.button_state & BIT(i),
-						false))
-			dev_err_ratelimited(&input->dev,
-					    "failed to report keymap event");
+	err = seesaw_report_buttons(private);
+	if (err) {
+		dev_err_ratelimited(&private->input_dev->dev,
+					"failed to read button state: %d\n", err);
+		return IRQ_NONE;
 	}
 
-	input_sync(input);
+	return IRQ_HANDLED;
 }
 
 static int seesaw_probe(struct i2c_client *client)
@@ -268,6 +319,7 @@ static int seesaw_probe(struct i2c_client *client)
 	seesaw->input_dev->name = "Adafruit Seesaw Gamepad";
 	seesaw->input_dev->phys = "i2c/" SEESAW_DEVICE_NAME;
 	seesaw->input_dev->open = seesaw_open;
+	seesaw->input_dev->close = seesaw_close;
 	input_set_drvdata(seesaw->input_dev, seesaw);
 	input_set_abs_params(seesaw->input_dev, ABS_X,
 			     0, SEESAW_JOYSTICK_MAX_AXIS,
@@ -289,6 +341,19 @@ static int seesaw_probe(struct i2c_client *client)
 	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
 	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
 
+	if (client->irq) {
+		err = seesaw_register_write_u32(client, SEESAW_GPIO_INTENSET, SEESAW_BUTTON_MASK);
+		if (err)
+			return dev_err_probe(&client->dev, err,
+						"failed to enable hardware interrupts\n");
+
+		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						seesaw_irq_thread, IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						SEESAW_DEVICE_NAME, seesaw);
+		if (err)
+			return dev_err_probe(&client->dev, err, "failed to request IRQ\n");
+	}
+
 	err = input_register_device(seesaw->input_dev);
 	if (err)
 		return dev_err_probe(&client->dev, err, "failed to register joystick\n");
