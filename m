From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 12/12] ASoC: Fix use-after-free at card unregistration
Date: Mon, 19 Jun 2017 09:27:09 +0200
Message-ID: <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:43287 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbdFSH2m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 03:28:42 -0400
In-Reply-To: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

soc_cleanup_card_resources() call snd_card_free() at the last of its
procedure.  This turned out to lead to a use-after-free.
PCM runtimes have been already removed via soc_remove_pcm_runtimes(),
while it's dereferenced later in soc_pcm_free() called via
snd_card_free().

The fix is simple: just move the snd_card_free() call to the beginning
of the whole procedure.  This also gives another benefit: it
guarantees that all operations have been shut down before actually
releasing the resources, which was racy until now.

Reported-and-tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2722bb0c5573..98d60f471c5d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2286,6 +2286,9 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	list_for_each_entry(rtd, &card->rtd_list, list)
 		flush_delayed_work(&rtd->delayed_work);
 
+	/* free the ALSA card at first; this syncs with pending operations */
+	snd_card_free(card->snd_card);
+
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
@@ -2300,9 +2303,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	if (card->remove)
 		card->remove(card);
 
-	snd_card_free(card->snd_card);
 	return 0;
-
 }
 
 /* removes a socdev */
-- 
2.1.4

