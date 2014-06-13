From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v3 2/2] elantech: Call psmouse_reset when elantech probe fails
Date: Fri, 13 Jun 2014 23:21:13 +0200
Message-ID: <1402694473-11518-3-git-send-email-ulrik.debie-os@e2big.org>
References: <20140613205547.GA5244@lantern>
 <1402694473-11518-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402694473-11518-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 0eb185b..fa150d9 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1617,6 +1617,7 @@ int elantech_init(struct psmouse *psmouse)
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
 			   &elantech_attr_group);
  init_fail:
+	psmouse_reset(psmouse);
 	kfree(etd);
 	return error;
 }
-- 
2.0.0
