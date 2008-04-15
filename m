From: David Brownell <dmitry.torokhov@gmail.com>
Subject: [PATCH 23/37] Input: gpio_keys - irq handling cleanup
Date: Tue, 15 Apr 2008 01:31:13 -0400
Message-ID: <1164ec1ae43770db6ea5450c6cac0761b11d6d1d.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:25621 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759817AbYDUNS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:18:57 -0400
Received: by el-out-1112.google.com with SMTP id n30so388741elf.21
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:18:57 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Cleanup IRQ handling in gpio_keys:  bail after handling the IRQ, and
report IRQ_NONE if we never handle it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a9ca4b..a54dc15 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -43,10 +43,11 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 
 			input_event(input, type, button->code, !!state);
 			input_sync(input);
+			return IRQ_HANDLED;
 		}
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
-- 
1.5.5.rc2.6.gf58d


