From: Dudley Du <dudl@cypress.com>
Subject: [PATCH] input: cyapa: fix the copy paste error on electrodes_rx value
Date: Mon, 12 Oct 2015 14:17:04 +0800
Message-ID: <1444630624-5127-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.cypress.com ([157.95.67.100]:46661 "EHLO
	smtp1.cypress.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbJLGSG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 02:18:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, sudipm.mukherjee@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Fix the copy paste error on the electrodes_rx value set code which will
cause the electrodes_rx value be always set to the value of electrodes_y.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa_gen6.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 5f19107..a5eb5ae 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -241,14 +241,12 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
 	memcpy(&cyapa->product_id[13], &resp_data[62], 2);
 	cyapa->product_id[15] = '\0';
 
+	/* Get the number of Rx electrodes. */
 	rotat_align = resp_data[68];
-	if (rotat_align) {
+	if (rotat_align)
 		cyapa->electrodes_rx = cyapa->electrodes_y;
-		cyapa->electrodes_rx = cyapa->electrodes_y;
-	} else {
+	else
 		cyapa->electrodes_rx = cyapa->electrodes_x;
-		cyapa->electrodes_rx = cyapa->electrodes_y;
-	}
 	cyapa->aligned_electrodes_rx = (cyapa->electrodes_rx + 3) & ~3u;
 
 	if (!cyapa->electrodes_x || !cyapa->electrodes_y ||
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

