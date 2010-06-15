From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 2/3] input: wm97xx: set GPIOs with AC97 GPIO busops if implemented
Date: Tue, 15 Jun 2010 17:55:46 +0200
Message-ID: <1276617347-3522-3-git-send-email-manuel.lauss@googlemail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0FOPz7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 11:55:59 -0400
In-Reply-To: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: alsa-devel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>

If the AC97 controller implements the ->setgpio callback, use it.
Some codecs (i.e. WM9712) only accept GPIO data through AC97 slot 12.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cbfef1e..4f7b38c 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -206,7 +206,10 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
 		reg &= ~gpio;
 
 	if (wm->id == WM9712_ID2 && wm->variant != WM97xx_WM1613)
-		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
+		reg <<= 1;
+
+	if (wm->ac97->bus->ops->setgpio)
+		wm->ac97->bus->ops->setgpio(wm->ac97, reg);
 	else
 		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
 	mutex_unlock(&wm->codec_mutex);
-- 
1.7.1

