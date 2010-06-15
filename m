From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation hooks
Date: Tue, 15 Jun 2010 17:55:45 +0200
Message-ID: <1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0FOPz5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 11:55:57 -0400
In-Reply-To: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: alsa-devel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>

Add callbacks to struct snd_ac97 to set and retrieve ac97 codec
GPIO status.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 include/sound/ac97_codec.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 4940045..db3aee1 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -437,6 +437,8 @@ struct snd_ac97_bus_ops {
 	unsigned short (*read) (struct snd_ac97 *ac97, unsigned short reg);
 	void (*wait) (struct snd_ac97 *ac97);
 	void (*init) (struct snd_ac97 *ac97);
+	void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpio);
+	unsigned short (*getgpio) (struct snd_ac97 *ac97);
 };
 
 struct snd_ac97_bus {
-- 
1.7.1

