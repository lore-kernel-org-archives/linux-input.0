From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] input: psmouse: fix input_dev leak in lifebook driver
Date: Sat, 12 Jan 2008 15:12:52 -0500
Message-ID: <20080112151252.193d6b52@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762206AbYALUMr@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


The lifebook driver may register a second input device, but it never
unregisters it.  This fixes that.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/lifebook.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 9ec57d8..df81b0a 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -225,8 +225,13 @@ static void lifebook_set_resolution(struct psmouse *psmouse, unsigned int resolu
 
 static void lifebook_disconnect(struct psmouse *psmouse)
 {
+	struct lifebook_data *priv = psmouse->private;
+
 	psmouse_reset(psmouse);
-	kfree(psmouse->private);
+	if (priv) {
+		input_unregister_device(priv->dev2);
+		kfree(priv);
+	}
 	psmouse->private = NULL;
 }
 
-- 
1.5.3.5

