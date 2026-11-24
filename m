Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495856;
	b=V5pxE97rhjeOTHhzch7SsvB/5XO3tejJIc+CUf0HUK7ayOkZa0kyPynmn1QoXDEWADIS
	 SIO+Mi4utPdJC1h2Ut99j+mCpFjBLOxzBdvh8/xv9/zS6LnbAKrOVVlpJyqI6f0JzYVNW
	 fN8AcgPPWAOabWA93gYrQYRYsuC+VpzegGIzWKNItpWCHF6Jt+RvzTRrs9KeTUaHF2mRV
	 DV3UfkvHqYnmuBA79mWl/Z9QGVKOqP8ij/dWDxE6O2ndUtNrisN4Z7MbtSdB6QfrFs6/P
	 9RmriEAe0tr4DGEKwfaPLz1RFZP+l3WJGnpBpIukQgJtELZNvrIC25gI0txxcuA2M9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495856;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=aaZkQfB9TkPV5MVamumc7Voqi9CsIgJvi2MZncIDPnc=;
	b=0Fw9Rf4AnUYBsVzuzr0pC+O0a+OIIwYXSrSuHea6XAjm9jWxQ1exBLCKikoscY9h//Bj
	 qRlbkkJVw9fbxO9sVeV9CHUVR/eovSNri3TkaxSS5YzAjZFgBA9MH+jePZRfK9PTAyZvV
	 HZLTm6e+siEby64AiWoaSI9hgeqPPouMmTq0Td7GYJLZ7BuTfHi4Lrz+SrkSJa4vipeQA
	 FO4YPK4Qf/h8xxVrlK23NhEfGkZNHX3Z1olrxc/NHi6m5ROShIacIPuBHmusV0BgJhVrg
	 rIqxO1ZO86T7tWBK9l4+4ZKaz4rrOcS9lHfWhiFkH/pa1lwFH0wIVdB6uzMk5mxajMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=jwDyHKFF;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D55606A6BC;
	Tue, 24 Nov 2026 04:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D55606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=jwDyHKFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=aaZkQfB9TkPV5MVamumc7Voqi9CsIgJvi2
	MZncIDPnc=; b=jwDyHKFFxKZ5f+pi36CtrwmU0+oLQnNaubIY1a9YDRGkcExvqf
	BAtCtoZYBsk1fHdZ1nSu1AQQxbORlBjMH7ufkgh1LCcCyAIoai1khfOSSpQEX+m0
	hrdln+aA6YuhFMoIB5ruklFwc1nOkySXaIgfMYwoUzyq0TZIqxyNOVFQg=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S8;
	Tue, 24 Nov 2026 12:50:51 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] Input: aw86927 - stop playback over suspend, close and shutdown
Date: Tue, 24 Nov 2026 12:50:40 +0800
Message-ID: <20261124045040.559317-7-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S8
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWrJw1xZr4Dtr1DtF15XFb_yoW3AF1kpa
	y5Ca4YyrZYqFW2gws8Kr12vw1akwn7KwsIyF9rWa43tasxX3y8KFn5tw4jyF15JrWkGa15
	Ja1vqFWUur4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
	xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUyfWFDUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAqsp

Playback is not stopped across system sleep, device close and shutdown:
an effect that is being played when the system suspends keeps the chip
driving the actuator, a memless effect whose timer fires around close()
restarts playback on a device nobody has open, and nothing holds the chip
in reset on shutdown or unbind.

Park the chip in standby on suspend, refuse new effects while the device
is closed or suspended, and assert reset on shutdown. The work item is
drained from a devres action so it also runs on unbind, where
input_close_device() is skipped for an inhibited device and the memless
effect timer can queue play_work again; that action also covers shutdown.

Suspend parks the chip in standby without asserting reset, and resume
only clears the suspend flag: the chip is left in standby with its SRAM
initialised, which is the state probe leaves it in. Shutdown asserts
reset without a separate stop.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 120 ++++++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 1dbcba7988..9ffea6a2bc 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -14,6 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
@@ -203,6 +204,8 @@ struct aw86927_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
+	bool suspended;
+	bool enabled;
 	u16 level;
 };
 
@@ -365,22 +368,30 @@ static int aw86927_haptics_play(struct input_dev *dev, void *data, struct ff_eff
 	struct aw86927_data *haptics = input_get_drvdata(dev);
 	int level;
 
+	/*
+	 * Ignore new effects while the chip is parked in standby (suspended) or
+	 * while nobody has the device open: a queued effect would either fail or
+	 * restart playback that close() already stopped.
+	 */
+	if (READ_ONCE(haptics->suspended) || !READ_ONCE(haptics->enabled))
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
 
@@ -425,7 +436,8 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 	if (err)
 		return err;
 
-	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, haptics->level * 0x80 / 0xffff);
+	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG,
+			   level * 0x80 / 0xffff);
 	if (err)
 		return err;
 
@@ -437,12 +449,33 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 	return 0;
 }
 
+static int aw86927_open(struct input_dev *input)
+{
+	struct aw86927_data *haptics = input_get_drvdata(input);
+
+	WRITE_ONCE(haptics->enabled, true);
+
+	return 0;
+}
+
 static void aw86927_close(struct input_dev *input)
 {
 	struct aw86927_data *haptics = input_get_drvdata(input);
 	struct device *dev = &haptics->client->dev;
 	int err;
 
+	/*
+	 * Stop accepting effects before draining the work: the memless effect
+	 * timer runs from a softirq, and clearing the level without blocking
+	 * aw86927_haptics_play() would let the next tick see a level change and
+	 * queue play_work again.  input core calls close() with
+	 * input_dev->mutex held, so this cannot interleave with a new open().
+	 */
+	scoped_guard(spinlock_irq, &input->event_lock) {
+		WRITE_ONCE(haptics->enabled, false);
+		WRITE_ONCE(haptics->level, 0);
+	}
+
 	cancel_work_sync(&haptics->play_work);
 
 	err = aw86927_stop(haptics);
@@ -455,10 +488,11 @@ static void aw86927_haptics_play_work(struct work_struct *work)
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
 
@@ -800,6 +834,20 @@ static int aw86927_detect(struct aw86927_data *haptics)
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
@@ -828,6 +876,17 @@ static int aw86927_probe(struct i2c_client *client)
 		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	/*
+	 * The work item must exist before the devres action below can be run: any
+	 * later failure in probe makes devres call aw86927_reset(), which drains
+	 * play_work.
+	 */
+	INIT_WORK(&haptics->play_work, aw86927_haptics_play_work);
+
+	err = devm_add_action_or_reset(haptics->dev, aw86927_reset, haptics);
+	if (err)
+		return err;
+
 	/* Hardware reset */
 	aw86927_hw_reset(haptics);
 
@@ -865,9 +924,8 @@ static int aw86927_probe(struct i2c_client *client)
 	if (err)
 		return dev_err_probe(haptics->dev, err, "Failed to request threaded irq\n");
 
-	INIT_WORK(&haptics->play_work, aw86927_haptics_play_work);
-
 	haptics->input_dev->name = "aw86927-haptics";
+	haptics->input_dev->open = aw86927_open;
 	haptics->input_dev->close = aw86927_close;
 
 	input_set_drvdata(haptics->input_dev, haptics);
@@ -899,6 +957,50 @@ static int aw86927_probe(struct i2c_client *client)
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
@@ -910,8 +1012,10 @@ static struct i2c_driver aw86927_driver = {
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

