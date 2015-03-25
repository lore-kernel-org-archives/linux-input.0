From: Filip Ayazi <filipayazi@gmail.com>
Subject: [PATCH] input: synaptics: min_max quirk for Thinkpad E440
Date: Wed, 25 Mar 2015 02:20:28 +0100
Message-ID: <1427246428-7070-1-git-send-email-filipayazi@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35623 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbCYBW1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 21:22:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Filip Ayazi <filipayazi@gmail.com>

Sets min_max_quirk values for LEN2006 touchpad found in Lenovo Thinkpad E440
(board_id=2691).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=89641
Signed-off-by: Filip Ayazi <filipayazi@gmail.com>
---
 drivers/input/mouse/synaptics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index dda6058..63942d4 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -154,6 +154,11 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 	},
 	{
 		(const char * const []){"LEN2006", NULL},
+		{2691, 2691},
+		1024, 5045, 2457, 4832
+	},
+	{
+		(const char * const []){"LEN2006", NULL},
 		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1264, 5675, 1171, 4688
 	},
-- 
1.9.1

