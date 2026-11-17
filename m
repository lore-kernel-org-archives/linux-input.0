Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892879;
	b=yNHD6JUTHeT17OMXQYdK7VFneiC+EnEJx6xaS+EY6WbPoucF6qPLD+YYRo1e/TPFWGRB
	 EypoZk0NQVyBSJd/IdZXKYY5GMmSDw5r/MWBVQoaZ3vYOCesCMbZKaTFAw8QpErZNLq9i
	 raUaYzPPod/15uQvPWbuQsJM9U02X76eYI9M5ck+9ceOuuTL6pkfb7wMfJM+Tc0vXKEYl
	 DXQ6u6BX6NkYhG3ujgZrIHMvI34URcePiIjeclV/dumrlml/j+GeZZJkK+MJxaIHHI2Ub
	 0+PeVFIWkertA2v5kJFXVsGmi1sW6c/pNQznNhgUTrwQnWOkfZ9HKIQbgkonsYadGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892879;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=yVoIT8g2pgmeOmN72TZTEXhJKsJNuLcIIB0q7BG0/3s=;
	b=0nd1yefLT/WNQ8QHaJeXO2drGjipMNo08SOib1HvfHVGemWxTYVbSF+SYm2vfxyNv5+W
	 GuIfP1C2y/sG+OvrDyyWStcqwNJySPlBPmgLK9zlhEeoCDH9SQ6tkM7rgUuaRwkpFAIHJ
	 JTgyHn6tyU4Pe6cqp9KgDZAeJHI9BkSr9NmCOQI+eaIdOd2Pu2nBIgGWUCVnU/x7MpWIv
	 /cAHXKsqRS1Th09JlH5v6hbiWwm+y1P+BZlqFMyjQEUOuXq51/CrzZfijXVPGC0PR7mbk
	 u2LmBMQUVQmPRfDk3El+a5Igl2fUUjlEJIpq4J+vv6xZoeyIXTEGpfOMNhJHnX5/h0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=c0FU2f1F;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30159606A891;
	Tue, 17 Nov 2026 05:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30159606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=c0FU2f1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=yVoIT8g2pgmeOmN72TZTEXhJKsJNuLcIIB
	0q7BG0/3s=; b=c0FU2f1FBetpFNJ6xd4dRKVJpMwHbyBbDWAmKkYzXjLc0gIi5P
	RzNn5f3Q1HlvC43uE2Ka3Fxqe+EVdlaCUNltiwGHLT/4axSaDJFTxvLS9obQk0iy
	gSvv6UgM4+6H942TSHpUbH84o/TuCtGLjtNI4pVzH0LlPANPFAsil2c3g=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S8;
	Tue, 17 Nov 2026 13:21:14 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 6/6] Input: aw86927 - stop playback over suspend and on shutdown
Date: Tue, 17 Nov 2026 13:21:12 +0800
Message-ID: <20261117052112.32527-7-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKryDAw4Dtw47CFyktry5urg_yoW7ur1kpa
	98CFyYyrWDXF42gwn8Kr12v3Wak3s7KFnFyF9rWa43tasrXw48KFn5tw4jyF15JrWkGa13
	Ja1vqFWUur4UAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
	xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07bO5lnUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAWsp

The chip keeps playing whatever was programmed into it when the system
suspends or reboots, so the actuator can still be buzzing after the screen
is off.  Stop playback, drain the work item and park the part in reset on
both paths.

Suspending also has to stop the memless effect timer from queueing new
work, otherwise a queued event re-arms playback after the stop.  Use a
suspended flag protected by the input event lock for that, and take the
input mutex around the whole sequence so that open()/close() cannot race
the drain.  The magnitude is read once per work run, so a concurrent
event cannot change it between the check and the register write.

Register the reset action with the device as well, so that the part is
also parked in reset on unbind and on a probe failure after the GPIO has
been acquired.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 79 +++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index aa69994..793bb88 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -15,5 +15,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
@@ -204,6 +205,7 @@ struct aw86927_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
+	bool suspended;
 	u16 level;
 };
 
@@ -366,22 +368,26 @@ static int aw86927_haptics_play(struct input_dev *dev, void *data, struct ff_eff
 	struct aw86927_data *haptics = input_get_drvdata(dev);
 	int level;
 
+	/* The chip is powered down; a queued event would only fail. */
+	if (haptics->suspended)
+		return 0;
+
 	level = effect->u.rumble.strong_magnitude;
 	if (!level)
 		level = effect->u.rumble.weak_magnitude;
 
 	/* If level does not change, don't restart playback */
-	if (haptics->level == level)
+	if (READ_ONCE(haptics->level) == level)
 		return 0;
 
-	haptics->level = level;
+	WRITE_ONCE(haptics->level, level);
 
 	schedule_work(&haptics->play_work);
 
 	return 0;
 }
 
-static int aw86927_play_sine(struct aw86927_data *haptics)
+static int aw86927_play_sine(struct aw86927_data *haptics, u16 level)
 {
 	int err;
 
@@ -426,7 +432,8 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 	if (err)
 		return err;
 
-	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, haptics->level * 0x80 / 0xffff);
+	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG,
+			   level * 0x80 / 0xffff);
 	if (err)
 		return err;
 
@@ -445,6 +452,7 @@ static void aw86927_close(struct input_dev *input)
 	int err;
 
 	cancel_work_sync(&haptics->play_work);
+	WRITE_ONCE(haptics->level, 0);
 
 	err = aw86927_stop(haptics);
 	if (err)
@@ -456,10 +464,11 @@ static void aw86927_haptics_play_work(struct work_struct *work)
 	struct aw86927_data *haptics =
 		container_of(work, struct aw86927_data, play_work);
 	struct device *dev = &haptics->client->dev;
+	u16 level = READ_ONCE(haptics->level);
 	int err;
 
-	if (haptics->level)
-		err = aw86927_play_sine(haptics);
+	if (level)
+		err = aw86927_play_sine(haptics, level);
 	else
 		err = aw86927_stop(haptics);
 
@@ -801,6 +810,13 @@ static int aw86927_detect(struct aw86927_data *haptics)
 	return 0;
 }
 
+static void aw86927_reset(void *data)
+{
+	struct aw86927_data *haptics = data;
+
+	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
+}
+
 static int aw86927_probe(struct i2c_client *client)
 {
 	struct aw86927_data *haptics;
@@ -829,6 +845,10 @@ static int aw86927_probe(struct i2c_client *client)
 		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	err = devm_add_action_or_reset(haptics->dev, aw86927_reset, haptics);
+	if (err)
+		return err;
+
 	/* Hardware reset */
 	aw86927_hw_reset(haptics);
 
@@ -900,6 +920,51 @@ static int aw86927_probe(struct i2c_client *client)
 	return 0;
 }
 
+static void aw86927_shutdown(struct i2c_client *client)
+{
+	struct aw86927_data *haptics = i2c_get_clientdata(client);
+
+	disable_work_sync(&haptics->play_work);
+	aw86927_reset(haptics);
+}
+
+static int aw86927_suspend(struct device *dev)
+{
+	struct aw86927_data *haptics = dev_get_drvdata(dev);
+	int err;
+
+	guard(mutex)(&haptics->input_dev->mutex);
+
+	/* Block events from the memless effect timer before draining the work. */
+	scoped_guard(spinlock_irq, &haptics->input_dev->event_lock)
+		haptics->suspended = true;
+
+	cancel_work_sync(&haptics->play_work);
+	err = aw86927_stop(haptics);
+
+	scoped_guard(spinlock_irq, &haptics->input_dev->event_lock) {
+		if (err)
+			haptics->suspended = false;
+		else
+			WRITE_ONCE(haptics->level, 0);
+	}
+
+	return err;
+}
+
+static int aw86927_resume(struct device *dev)
+{
+	struct aw86927_data *haptics = dev_get_drvdata(dev);
+
+	guard(mutex)(&haptics->input_dev->mutex);
+	guard(spinlock_irq)(&haptics->input_dev->event_lock);
+	haptics->suspended = false;
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(aw86927_pm_ops, aw86927_suspend, aw86927_resume);
+
 static const struct of_device_id aw86927_of_id[] = {
 	{ .compatible = "awinic,aw86927" },
 	{ /* sentinel */ }
@@ -911,8 +976,10 @@ static struct i2c_driver aw86927_driver = {
 	.driver = {
 		.name = "aw86927-haptics",
 		.of_match_table = aw86927_of_id,
+		.pm = pm_sleep_ptr(&aw86927_pm_ops),
 	},
 	.probe = aw86927_probe,
+	.shutdown = aw86927_shutdown,
 };
 
 module_i2c_driver(aw86927_driver);
-- 
2.53.0

