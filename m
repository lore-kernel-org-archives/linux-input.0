Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485043;
	b=IWBG7cWsESkARvaBpW/xanpzABS3BipXzV5TSJIMOVDGLXJXS5HcV55E7o11HNIaaMLi
	 N145VX8vMGQXUj35ArCd2NOusQ8WVWrkpS3nf7/EP6xc1CS7hYehZpVtFM7dxoKUc2x21
	 2P5jlrU+DgCafR0k6x3tVttwYJk5srTQThK8gDtjnXmvPG9SJ9YtaHufFEXgxPZ1IEQCn
	 bg28jrEDWBa5DLPc4zMUGc5lRHyxAonlCt2vjfrqdQ1xa4ufQa6belUpNdtTghlT8AtqH
	 xdeTXHq0uAlaQX26ePBm3NJVOugMFABfwBGVwCYKVA+4yAMxba3PClflkUOygXZetGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485043;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=eUcM8EgeA20mYaCEW0h1hqOWjxH+MHwdnDgsqjLUTzg=;
	b=U/GarN4sJm8tYL4P8hCanoANdO6BizsgOEu/sFP6mcXWtFpn/Fl+IkcTWcu05/pjVlj4
	 TBkWnPb5Uiv/URs13sPIisiC/96eP2qIXMjNdsPd9OsehCqCqMQCqtWi7qetUWhmsYHxe
	 S5JWOW+B+drw38b0rZCTomwFDJXeqtP3dYVkmmpG2DiKNPo9GGla/RVQqf73+holx+Clj
	 yySsclouW0SXh1edo7ao101NS1Y7LUN/gaZflJGl+1Lr812KCz500n3vz6Emb0/NUmHgh
	 9uOckfDz/vYDv2KFe3EznyjWfXz/ZBiv0Nlw6cJMALpPIUf5aGzcC1k2rbAsKaKk0kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=sVRxlMmD;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9C606A69B;
	Tue, 24 Nov 2026 01:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B9C606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=sVRxlMmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=eUcM8EgeA20mYaCEW0h1hqOWjxH+MHwdnD
	gsqjLUTzg=; b=sVRxlMmD4BT0tBe+B0KB6176CZsbtHimqYdWYbZHG28+W0p5C2
	1sHTYLnHEhIoLNGCPvaVxz+5q0HecyGSyWrW60vxF3Fetv2KtV1df3dhxBHczGN7
	eGojKIYDo5Ap1oJp7bwBxTB/m1DURXJGXQvm6IfjA4aMOrguGGe88NPVE=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S8;
	Tue, 24 Nov 2026 09:50:38 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: aw86927 - stop playback over suspend and on shutdown
Date: Tue, 24 Nov 2026 09:50:28 +0800
Message-ID: <20261124015028.1427420-7-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyktw45JF1kKFykGF45Jrb_yoWxXry5p3
	y5AFyYyrWvqF42qwn8Kr12v3W3Cwn7GwsFyF9rWa43tasIq3y8KF95tw4jyF15JrWkGa15
	Ja1vqFWUur4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	kIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07beD7fUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQA2sO

Playback is not stopped across system sleep or shutdown: an effect
  that is
being played when the system suspends keeps the chip driving the
  actuator,
and nothing holds the chip in reset on shutdown or unbind.

Park the chip in standby on suspend (resume leaves it in reset, as probe
does), assert reset on shutdown, and drain the work item in a devres
action
so it runs on unbind as well: the memless effect timer can queue the
  work
again when input_close_device() is skipped for an inhibited device, and
the
work must not reach the regmap after the device is gone.
Changes since v2:
 - [sashiko, 2026-11-17, High] "race in aw86927_close() and unbind
  queues
   play_work after stop": the devres action now drains the work item
  before
   asserting reset, so an effect timer that re-queued the work
  (inhibited
   device, or a flush interrupted by a signal) cannot reach the regmap
  after
   the device is gone.  aw86927_shutdown() calls the same helper.
 - [sashiko, same report, Low] "commit message and comment mismatch on
   suspend/shutdown": the message now states that suspend parks the
  chip in
   standby without asserting reset and shutdown asserts reset without a
   separate stop, which is what the code does.
---
 drivers/input/misc/aw86927.c | 85 +++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 42ae123808b6..a84cada8f570 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
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
 
@@ -801,6 +810,20 @@ static int aw86927_detect(struct aw86927_data *haptics)
 	return 0;
 }
 
+static void aw86927_reset(void *data)
+{
+	struct aw86927_data *haptics = data;
+
+	/*
+	 * Drain the worker before the regmap can go away: this action also runs
+	 * from devres on unbind, where input_close_device() may have been skipped
+	 * (inhibited device) and the memless effect timer can have queued the
+	 * work again.
+	 */
+	disable_work_sync(&haptics->play_work);
+	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
+}
+
 static int aw86927_probe(struct i2c_client *client)
 {
 	struct aw86927_data *haptics;
@@ -829,6 +852,10 @@ static int aw86927_probe(struct i2c_client *client)
 		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	err = devm_add_action_or_reset(haptics->dev, aw86927_reset, haptics);
+	if (err)
+		return err;
+
 	/* Hardware reset */
 	aw86927_hw_reset(haptics);
 
@@ -900,6 +927,50 @@ static int aw86927_probe(struct i2c_client *client)
 	return 0;
 }
 
+static void aw86927_shutdown(struct i2c_client *client)
+{
+	struct aw86927_data *haptics = i2c_get_clientdata(client);
+
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
@@ -911,8 +982,10 @@ static struct i2c_driver aw86927_driver = {
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

