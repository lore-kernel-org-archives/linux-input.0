From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 3/9] Input: psmouse - implement fast reconnect option
Date: Fri, 10 Mar 2017 15:01:08 -0800
Message-ID: <20170310230114.788-4-dmitry.torokhov@gmail.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33399 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbdCJXCR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 18:02:17 -0500
In-Reply-To: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Make use of serio's fast reconnect option and allow psmouse protocol
handler's to implement fast reconnect handlers that will be called during
system resume.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 30 +++++++++++++++++++++++++++---
 drivers/input/mouse/psmouse.h      |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a598b7223cef..47fd2976da7f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -966,6 +966,7 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 	psmouse->protocol_handler = psmouse_process_byte;
 	psmouse->pktsize = 3;
 	psmouse->reconnect = NULL;
+	psmouse->fast_reconnect = NULL;
 	psmouse->disconnect = NULL;
 	psmouse->cleanup = NULL;
 	psmouse->pt_activate = NULL;
@@ -1628,15 +1629,26 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	goto out;
 }
 
-static int psmouse_reconnect(struct serio *serio)
+static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 	struct psmouse *parent = NULL;
+	int (*reconnect_handler)(struct psmouse *);
 	unsigned char type;
 	int rc = -1;
 
 	mutex_lock(&psmouse_mutex);
 
+	if (fast_reconnect) {
+		reconnect_handler = psmouse->fast_reconnect;
+		if (!reconnect_handler) {
+			rc = -ENOENT;
+			goto out_unlock;
+		}
+	} else {
+		reconnect_handler = psmouse->reconnect;
+	}
+
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
@@ -1644,8 +1656,8 @@ static int psmouse_reconnect(struct serio *serio)
 
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
-	if (psmouse->reconnect) {
-		if (psmouse->reconnect(psmouse))
+	if (reconnect_handler) {
+		if (reconnect_handler(psmouse))
 			goto out;
 	} else {
 		psmouse_reset(psmouse);
@@ -1677,10 +1689,21 @@ static int psmouse_reconnect(struct serio *serio)
 	if (parent)
 		psmouse_activate(parent);
 
+out_unlock:
 	mutex_unlock(&psmouse_mutex);
 	return rc;
 }
 
+static int psmouse_reconnect(struct serio *serio)
+{
+	return __psmouse_reconnect(serio, false);
+}
+
+static int psmouse_fast_reconnect(struct serio *serio)
+{
+	return __psmouse_reconnect(serio, true);
+}
+
 static struct serio_device_id psmouse_serio_ids[] = {
 	{
 		.type	= SERIO_8042,
@@ -1708,6 +1731,7 @@ static struct serio_driver psmouse_drv = {
 	.interrupt	= psmouse_interrupt,
 	.connect	= psmouse_connect,
 	.reconnect	= psmouse_reconnect,
+	.fast_reconnect	= psmouse_fast_reconnect,
 	.disconnect	= psmouse_disconnect,
 	.cleanup	= psmouse_cleanup,
 };
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 8c83b8e2505c..bc76e771812b 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -80,6 +80,7 @@ struct psmouse {
 	void (*set_scale)(struct psmouse *psmouse, enum psmouse_scale scale);
 
 	int (*reconnect)(struct psmouse *psmouse);
+	int (*fast_reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
 	void (*cleanup)(struct psmouse *psmouse);
 	int (*poll)(struct psmouse *psmouse);
-- 
2.12.0.246.ga2ecc84866-goog

