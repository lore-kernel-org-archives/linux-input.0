From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 1/3] psmouse: export psmouse_set_state for ps/2 extensions
 to use
Date: Wed, 13 Aug 2008 15:24:43 -0400
Message-ID: <20080813152443.5e39699e@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.queued.net ([207.210.101.209]:1724 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYHMTYc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2008 15:24:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/psmouse-base.c |    2 +-
 drivers/input/mouse/psmouse.h      |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index f5a6be1..960f2da 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -220,7 +220,7 @@ static inline void __psmouse_set_state(struct psmouse *psmouse, enum psmouse_sta
  * is not a concern.
  */
 
-static void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
+void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state)
 {
 	serio_pause_rx(psmouse->ps2dev.serio);
 	__psmouse_set_state(psmouse, new_state);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 1317bdd..ed40415 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -94,6 +94,7 @@ enum psmouse_type {
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
+void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 
 
-- 
1.5.6.3

