From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/8] Input: synaptics: Fix misuse of strlcpy
Date: Thu,  4 Jul 2019 16:57:41 -0700
Message-ID: <070330472a7314a21d85c42dd66cdd43222559c3.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562283944.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Probable cut&paste typo - use the correct field size.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1080c0c49815..00a0cf14f27f 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -705,7 +705,7 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 
 	serio->id.type = SERIO_PS_PSTHRU;
 	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
-	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
+	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->phys));
 	serio->write = synaptics_pt_write;
 	serio->start = synaptics_pt_start;
 	serio->stop = synaptics_pt_stop;
-- 
2.15.0
