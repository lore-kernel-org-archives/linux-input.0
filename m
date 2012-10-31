From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] HIL: remove one goto
Date: Wed, 31 Oct 2012 20:24:34 +0100
Message-ID: <2837529.xgu9k1gmUb@eto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This goto is only used to skip the next instruction, which can easily be done
without a goto.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
---
 drivers/input/serio/hil_mlc.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index bfd3865..0280167 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -686,13 +686,12 @@ static int hilse_donode(hil_mlc *mlc)
 		write_lock_irqsave(&mlc->lock, flags);
 		pack = node->object.packet;
 	out:
-		if (mlc->istarted)
-			goto out2;
-		/* Prepare to receive input */
-		if ((node + 1)->act & HILSE_IN)
-			hilse_setup_input(mlc, node + 1);
+		if (!mlc->istarted) {
+			/* Prepare to receive input */
+			if ((node + 1)->act & HILSE_IN)
+				hilse_setup_input(mlc, node + 1);
+		}
 
-	out2:
 		write_unlock_irqrestore(&mlc->lock, flags);
 
 		if (down_trylock(&mlc->osem)) {
-- 
1.7.7


