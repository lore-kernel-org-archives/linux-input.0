Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107783;
	b=ueAlUiD5KeGAAgXqHoxl/necaZ6poEkWPUbiykdUV9GQjh3lDPTZDgfgW8vbcg8A/5K4
	 p1JtpIja3RJYN874hfS275yMlSO1Q4Yn3MQ1zMvqNeSWSTrHs7vFWTO+HwRIHI26HgfnE
	 D+JCUsDnFCga4qCbSK5A/1uPcWXXd/5BpzEI7mM+5V984Xw7h3UQeujCnnUTvbwSBQLvs
	 YVZUNNHMoIYCo/nCJMD+1k2VzO/G6YRlkQ68DJUryMPpII83ycdP44QZHRdOPff6mZ4N2
	 F8r/hXGv5HUV9efSpcebvsOcwVoTTgqh97hniP9kLP14QZEb9mly953cTEvD42jRadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107783;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=r3LyntnGuJEGMdvW4ZYciCNy4SV0EklofYf997pOzkg=;
	b=IyY0bGHsvL1Xf8vFuClXXi+jnGlZsrSBc5r4Gayrl2RCg0gQJCTxl8KsLcxuN+STg35V
	 eipin8fT20nqMhcOOuE6R33VQHGSELf9j1wIdV1/0TCPSBItzYtyQxHXah/RdjAYCHcUB
	 OAk8Ad5sMOqqaFun8YmrvwlI/4Ua9yJH05oV5vEKKxLB7TbF5jEsRGcgF87dOOBcdrYQd
	 3bQhI/1nWSt09oX9KyWiwoJJ8jObjjX+rM5HNrZnNTBnHHN9HIMS3tjFom4hrDhbQskh4
	 xoX9NaH8rlmSIKIlJ/WEf/WzmBK2217CCCpCv6wqR6NCCxrc5ccZFq/O18A5YJZyDuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC726606A31A;
	Tue, 27 Oct 2026 13:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC726606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=r3LyntnGuJEGMdvW4ZYciCNy4SV0EklofY
	f997pOzkg=; b=tdIJeJ0OwjNPAEAUkxUSPj5UQ7GADEELAT3h27fX0HzJWLUD4c
	98TL08UT86dBzG3ekptCsRtSVEueNNYbRAQKDnmNHsl3XPZnMMmqEoJ1cm55/Uui
	ppOSCo2ei3rxVzNbOao21KCFdx9Hsicvh00YyjAYnpWVZGyP2RiujZEOs=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHhDg5p+BqGGxRAA--.1917S7;
	Tue, 27 Oct 2026 21:29:32 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: aw86927 - stop playback over suspend and on shutdown
Date: Tue, 27 Oct 2026 21:29:29 +0800
Message-ID: <20261027132929.242158-6-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAHhDg5p+BqGGxRAA--.1917S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKryDAw4Dtw47CF1xWFy8Krg_yoW7GFWkpa
	98CryYyrWkXF42qwn0gr12v3W3Cwn7G3ZFyF9rua43tasrXw48KFn5tw4jyF15JrWkGa13
	Ja1vqrWUur48AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgT7NUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAAusv

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

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 75 +++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index e8fd880ac..6d45c310a 100644
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
 
@@ -900,6 +909,58 @@ static int aw86927_probe(struct i2c_client *client)
 	return 0;
 }
 
+static void aw86927_reset(void *data)
+{
+	struct aw86927_data *haptics = data;
+
+	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
+}
+
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
@@ -911,8 +972,10 @@ static struct i2c_driver aw86927_driver = {
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

