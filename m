From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on	MACH_MAINSTONE
 instead of ARCH_PXA
Date: Tue, 17 Jun 2008 14:52:23 +0300
Message-ID: <4857A577.5030506@compulab.co.il>
References: <48564133.3070609@gmail.com>	<20080616120756.GA7302@rakim.wolfsonmicro.main>	<48570E1E.3070301@gmail.com> <20080617095928.GD6114@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sa3.bezeqint.net ([192.115.104.17]:60247 "EHLO sa3.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbYFQLwm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 07:52:42 -0400
In-Reply-To: <20080617095928.GD6114@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input <linux-input@vger.kernel.org>



Mark Brown wrote:
> On Tue, Jun 17, 2008 at 09:06:38AM +0800, Eric Miao wrote:
> 
>> Mike Rapoport said it could be re-used for EM-X270, so I'd suggest this
>> better to be PXA generic, and pass platform data as you advised.
> 
> Yeah, that's the ideal.  Unfortunately passing platform data through
> AC97 is a bit of a can of worms :(

Probably something like the patch below may allow passing platform data at least
for ASoC devices:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e148db9..690aec4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -92,13 +92,15 @@ static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
 static void soc_ac97_device_release(struct device *dev){}

 /* register ac97 codec to bus */
-static int soc_ac97_dev_register(struct snd_soc_codec *codec)
+static int soc_ac97_dev_register(struct snd_soc_device *socdev)
 {
+	struct snd_soc_codec *codec = socdev->codec;
 	int err;

 	codec->ac97->dev.bus = &ac97_bus_type;
 	codec->ac97->dev.parent = NULL;
 	codec->ac97->dev.release = soc_ac97_device_release;
+	codec->ac97->dev.platform_data = socdev->dev->platform_data;

 	snprintf(codec->ac97->dev.bus_id, BUS_ID_SIZE, "%d-%d:%s",
 		 codec->card->number, 0, codec->name);
@@ -1130,7 +1132,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	if (ac97) {
-		ret = soc_ac97_dev_register(codec);
+		ret = soc_ac97_dev_register(socdev);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: AC97 device register failed\n");
 			snd_card_free(codec->card);


> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 

-- 
Sincerely yours,
Mike.

