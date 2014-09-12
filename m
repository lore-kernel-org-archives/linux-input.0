From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/3] i8042: Also store the aux firmware id in multi-plexed aux ports
Date: Fri, 12 Sep 2014 11:08:30 +0200
Message-ID: <1410512912-11609-2-git-send-email-hdegoede@redhat.com>
References: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaILJIi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 05:08:38 -0400
In-Reply-To: <1410512912-11609-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

So that firmware-id matching can be used with multiplexed aux ports too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/serio/i8042.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 3807c3e..f5a98af 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1254,6 +1254,8 @@ static int __init i8042_create_aux_port(int idx)
 	} else {
 		snprintf(serio->name, sizeof(serio->name), "i8042 AUX%d port", idx);
 		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, idx + 1);
+		strlcpy(serio->firmware_id, i8042_aux_firmware_id,
+			sizeof(serio->firmware_id));
 	}
 
 	port->serio = serio;
-- 
2.1.0

