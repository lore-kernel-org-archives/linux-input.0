From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and
 ac97 with its private field
Date: Fri, 25 Apr 2008 10:23:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804251008270.7882@tm8103.perex-int.cz>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc>
 <20080424145749.GB22369@sirena.org.uk> <s5hr6cvb5f3.wl%tiwai@suse.de>
 <20080424185658.GA19029@sirena.org.uk> <s5h8wz24dto.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250906090.7882@tm8103.perex-int.cz> <s5h4p9q4d2e.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0804250931050.7882@tm8103.perex-int.cz> <s5hve26v0aw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:46175 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbYDYIXx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 04:23:53 -0400
In-Reply-To: <s5hve26v0aw.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, dtor@mail.ru, Sebastian Siewior <al+sa@ml.breakpoint.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, linux-input@vger.kernel.org

On Fri, 25 Apr 2008, Takashi Iwai wrote:

> At Fri, 25 Apr 2008 09:35:47 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 25 Apr 2008, Takashi Iwai wrote:
> > 
> > > > Sure. I applied the simple 'void *device_private_data' patch, because 
> > > > current usage request is really trivial. We can implement complex code to 
> > > > handle data for multiple "extra" devices on AC97 bus later.
> > > 
> > > Actually, it's not "used" yet.  The ucb1000 reads the data but no one
> > > stores yet.  And, if its usage request is trivial, we should use "int
> > 
> > Yes, I hope that the appropriate initialization code will be added to SoC 
> > drivers, too.
> > 
> > > irq" as in the original patch instead of void data and cast.
> > 
> > But other SoC (or other) drivers might want to pass to extra devices on 
> > AC97 bus something different or more complex. Mark Brown already noted
> > that. I would keep it as 'void *'.
> 
> That's the very problem I've been trying to point out.
> The void pointer is good if the same driver assigns and casts.  But,
> in this case, the allocator and the receiver are different.  Thus,
> there is no guarantee that the data type is what you want.  OTOH, if
> it's "int irq", this is crystal clear.
> 
> So, in short:
> 
> - if only one device needs such data, it should be a strong type like
>   "int irq" anyway -- no extra need to cast to void pointer
> - if multiple devices need such a pass-away mechanism, then they can
>   crash because you have no data type check.  The void pointer is
>   dangerous for multiple devices.

I see. In this case, I would propose to add a 32-bit "magic" at the 
start of 'void *' data. How about this modification:

diff -r e2ff47e8771b include/ac97_codec.h
--- a/include/ac97_codec.h	Fri Apr 25 08:29:05 2008 +0200
+++ b/include/ac97_codec.h	Fri Apr 25 10:22:00 2008 +0200
@@ -407,6 +407,9 @@
 #define AC97_RATES_MIC_ADC	4
 #define AC97_RATES_SPDIF	5
 
+/* device private data magic number */
+#define AC97_PDEVMAGIC_IRQ	0x20495251	/* in ASCII: <space>IRQ */
+
 /*
  *
  */
@@ -545,6 +547,11 @@ static inline int ac97_can_spdif(struct 
 static inline int ac97_can_spdif(struct snd_ac97 * ac97)
 {
 	return (ac97->ext_id & AC97_EI_SPDIF) != 0;
+}
+static inline int ac97_check_pdevdata_magic(struct snd_ac97 * ac97, unsigned int magic)
+{
+	return (ac97->device_private_data &&
+		*((unsigned int *)ac97->device_private_data) == magic);
 }
 
 /* functions */
diff -r e2ff47e8771b kernel/drivers/input/touchscreen/ucb1400_ts.c
--- a/kernel/drivers/input/touchscreen/ucb1400_ts.c	Fri Apr 25 08:29:05 2008 +0200
+++ b/kernel/drivers/input/touchscreen/ucb1400_ts.c	Fri Apr 25 10:22:00 2008 +0200
@@ -492,14 +492,14 @@ static int ucb1400_ts_probe(struct devic
 		goto err_free_devs;
 	}
 
-	if (!ucb->ac97->device_private_data) {
+	if (!ac97_check_pdevdata_magic(usb->ac97, AC97_PDEVMAGIC_IRQ)) {
 		error = ucb1400_detect_irq(ucb);
 		if (error) {
 			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
 			goto err_free_devs;
 		}
 	} else {
-		ucb->irq = (int) ucb->ac97->device_private_data;
+		ucb->irq = ((int *) ucb->ac97->device_private_data)[1];
 	}
 
 	error = request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

