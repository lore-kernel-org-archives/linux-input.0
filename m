From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 1/4] Input: hgpk - detect simple mode overflows
Date: Sat, 13 Nov 2010 19:21:58 +0000 (GMT)
Message-ID: <20101113192158.5E3B89D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:57585 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754890Ab0KMTWD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Nov 2010 14:22:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Based on work by Paul Fox.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index b54f074..7f6cb32 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -431,6 +431,11 @@ static void hgpk_process_simple_packet(struct psmouse *psmouse)
 	int x = packet[1] - ((packet[0] << 4) & 0x100);
 	int y = ((packet[0] << 3) & 0x100) - packet[2];
 
+	if (packet[0] & 0xc0)
+		hgpk_dbg(psmouse,
+			 "overflow -- 0x%02x 0x%02x 0x%02x\n",
+			 packet[0], packet[1], packet[2]);
+
 	if (hgpk_discard_decay_hack(psmouse, x, y)) {
 		if (tpdebug)
 			hgpk_dbg(psmouse, "discarding\n");
-- 
1.7.3.2

