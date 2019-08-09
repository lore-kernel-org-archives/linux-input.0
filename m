From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: synaptics - Fix a typo - synpatics --> synaptics
Date: Fri,  9 Aug 2019 17:08:14 +0200
Message-ID: <20190809150814.24793-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, grawity@gmail.com, dev@pp3345.net, lyude@redhat.com, teika@gmx.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

This should be 'synaptics', not 'synpatics'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b6da0c1267e3..bbd799c7b058 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -191,7 +191,7 @@ static const char * const forcepad_pnp_ids[] = {
 };
 
 /*
- * Send a command to the synpatics touchpad by special commands
+ * Send a command to the synaptics touchpad by special commands
  */
 static int synaptics_send_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
 {
-- 
2.20.1
