From: Richard Leitner <me@g0hl1n.net>
Subject: [PATCH] serio: avoid negative serio device numbers
Date: Wed, 8 Oct 2014 23:54:27 +0200
Message-ID: <20141008235427.55d0963f@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay07.alfahosting-server.de ([109.237.142.243]:55689 "EHLO
	relay07.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754722AbaJHVyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Oct 2014 17:54:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, richard.leitner@skidata.com

From: Richard Leitner <richard.leitner@skidata.com>

Fix the format string for serio device name generation to avoid negative
device numbers when the id exceeds the maximum signed integer value.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/serio/serio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index b29134d..d399b8b 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -524,8 +524,8 @@ static void serio_init_port(struct serio *serio)
 	spin_lock_init(&serio->lock);
 	mutex_init(&serio->drv_mutex);
 	device_initialize(&serio->dev);
-	dev_set_name(&serio->dev, "serio%ld",
-			(long)atomic_inc_return(&serio_no) - 1);
+	dev_set_name(&serio->dev, "serio%lu",
+		     (unsigned long)atomic_inc_return(&serio_no) - 1);
 	serio->dev.bus = &serio_bus;
 	serio->dev.release = serio_release_port;
 	serio->dev.groups = serio_device_attr_groups;
-- 
2.1.1

