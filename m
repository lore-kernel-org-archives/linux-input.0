From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: [RFC / PATCH] [SOUND] add a private field for ac97-device drivers
	and let ucb1400 be its first user
Date: Thu, 24 Apr 2008 17:37:53 +0200
Message-ID: <20080424153753.GD26452@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:42651 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753000AbYDXPhz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 11:37:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

From: Sebastian Siewior <bigeasy@linutronix.de>

Currently the UCB1400 driver discovers the interrupt via probing. This works
probably only on x86. This patch adds a private field to the ac97 struct
where the ac97 driver can deposit informations for the device driver that
serves a device which is attached to the ac97 bus.
This patch also converts the UCB1400 driver to use this information if available.

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ucb1400_ts.c |   12 ++++++++----
 include/sound/ac97_codec.h             |    4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 5ee175e..531fb4b 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -494,10 +494,14 @@ static int ucb1400_ts_probe(struct device *dev)
 		goto err_free_devs;
 	}
 
-	error = ucb1400_detect_irq(ucb);
-	if (error) {
-		printk(KERN_ERR "UCB1400: IRQ probe failed\n");
-		goto err_free_devs;
+	if (!ucb->ac97->device_private_data) {
+		error = ucb1400_detect_irq(ucb);
+		if (error) {
+			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
+			goto err_free_devs;
+		}
+	} else {
+		ucb->irq = (int) ucb->ac97->device_private_data;
 	}
 
 	error = request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 0148058..b1af896 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -474,6 +474,10 @@ struct snd_ac97 {
 	struct snd_ac97_build_ops * build_ops;
 	void *private_data;
 	void (*private_free) (struct snd_ac97 *ac97);
+	/* This field is used by device drivers which serve devices which are
+	 * attached to the AC97 bus.
+	 */
+	void *device_private_data;
 	/* --- */
 	struct snd_ac97_bus *bus;
 	struct pci_dev *pci;	/* assigned PCI device - used for quirks */
-- 
1.5.4.3

