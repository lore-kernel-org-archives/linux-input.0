From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH v2 4/5] Input: synaptics - Skip quirks when post-2013 dimensions
Date: Tue, 27 Jan 2015 09:34:04 +0100
Message-ID: <1422347645-5194-5-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:52774 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbA0I2e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:28:34 -0500
In-Reply-To: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

If we queried min/max dimensions of x [1266..5674], y [1170..4684] we
have post-2013 model and don't need to apply any quirk.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 37d4dff..f6c43ff 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -420,6 +420,11 @@ static int synaptics_quirks(struct psmouse *psmouse)
 	struct synaptics_data *priv = psmouse->private;
 	int i;
 
+	/* Post-2013 models expose correct dimensions. */
+	if (priv->x_min == 1266 && priv->x_max == 5674 &&
+	    priv->y_min == 1170 && priv->y_max == 4684)
+		return 0;
+
 	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
 		if (psmouse_matches_pnp_id(psmouse,
 					   min_max_pnpid_table[i].pnp_ids)) {
-- 
2.2.2

