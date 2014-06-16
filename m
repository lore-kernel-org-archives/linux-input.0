From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v4 2/2] elantech: Call psmouse_reset when elantech probe fails
Date: Mon, 16 Jun 2014 23:53:09 +0200
Message-ID: <1402955589-23709-3-git-send-email-ulrik.debie-os@e2big.org>
References: <CANq1E4S5xVuWO3THy2rB5O_8fsLeYCWAres2Xk5Pf1j1_Po=og@mail.gmail.com>
 <1402955589-23709-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:50994 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbaFPVxh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2014 17:53:37 -0400
In-Reply-To: <1402955589-23709-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

elantech_init() calls elantech_set_absolute_mode which sets the driver in
an absolute mode. When after this the elantech_init fails, it is best
to turn the ps/2 mouse emulation mode back on by calling psmouse_reset()
so that it can work as a regular mouse.

Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 5dd620a..771291c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1620,6 +1620,7 @@ int elantech_init(struct psmouse *psmouse)
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
 			   &elantech_attr_group);
  init_fail:
+	psmouse_reset(psmouse);
 	kfree(etd);
 	return error;
 }
-- 
2.0.0

