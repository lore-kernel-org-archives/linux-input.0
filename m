From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH V2 1/3] input: Add some extra PNP keyboard types
Date: Mon, 17 May 2010 11:38:34 -0400
Message-ID: <1274110716-12488-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56049 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab0EQPjc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 11:39:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Matthew Garrett <mjg@redhat.com>

Some Japanese machines declare their keyboard with a different PNP ID.
Add it to the list of probed device IDs. While we're at it, add all the
other IDs that Windows binds to - we'll probably never see them in the
real world, but it doesn't hurt.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ead0494..871a74c 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -660,8 +660,21 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 }
 
 static struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0300", .driver_data = 0 },
+	{ .id = "PNP0301", .driver_data = 0 },
+	{ .id = "PNP0302", .driver_data = 0 },
 	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP0304", .driver_data = 0 },
+	{ .id = "PNP0305", .driver_data = 0 },
+	{ .id = "PNP0306", .driver_data = 0 },
+	{ .id = "PNP0309", .driver_data = 0 },
+	{ .id = "PNP030a", .driver_data = 0 },
 	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "PNP0320", .driver_data = 0 },
+	{ .id = "PNP0343", .driver_data = 0 },
+	{ .id = "PNP0344", .driver_data = 0 },
+	{ .id = "PNP0345", .driver_data = 0 },
+	{ .id = "CPQA0D7", .driver_data = 0 },
 	{ .id = "", },
 };
 
-- 
1.7.0.1

