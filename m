From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] hid: hid-prodikeys.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:21:32 +0200
Message-ID: <1406384492-2442-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:46188 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaGZOUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 10:20:07 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so5542396wes.0
        for <linux-input@vger.kernel.org>; Sat, 26 Jul 2014 07:20:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux-kernel@vger.kernel.org

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/hid/hid-prodikeys.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 91fab97..007c7f5 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -641,9 +641,9 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail;
 	}
 
-	strncpy(card->driver, shortname, sizeof(card->driver));
-	strncpy(card->shortname, shortname, sizeof(card->shortname));
-	strncpy(card->longname, longname, sizeof(card->longname));
+	strlcpy(card->driver, shortname, sizeof(card->driver));
+	strlcpy(card->shortname, shortname, sizeof(card->shortname));
+	strlcpy(card->longname, longname, sizeof(card->longname));
 
 	/* Set up rawmidi */
 	err = snd_rawmidi_new(card, card->shortname, 0,
@@ -654,7 +654,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail;
 	}
 	pm->rwmidi = rwmidi;
-	strncpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
+	strlcpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
 	rwmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
 	rwmidi->private_data = pm;
 
-- 
1.7.10.4

