From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 17/18] Input: cypress_ps2 - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:28 +0200
Message-ID: <1443793229-22363-18-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/mouse/cypress_ps2.c:333:1-4: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/mouse/cypress_ps2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index 28dcfc822bf6..bca984f53434 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -330,11 +330,7 @@ static int cypress_query_hardware(struct psmouse *psmouse)
 	if (ret)
 		return ret;
 
-	ret = cypress_read_tp_metrics(psmouse);
-	if (ret)
-		return ret;
-
-	return 0;
+	return cypress_read_tp_metrics(psmouse);
 }
 
 static int cypress_set_absolute_mode(struct psmouse *psmouse)
-- 
2.4.3
