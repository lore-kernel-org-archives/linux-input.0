From: nick.dyer@itdev.co.uk
Subject: [PATCH 10/15] Input: atmel_mxt_ts - add bootloader addresses for new chips
Date: Thu,  3 Jul 2014 16:01:32 +0100
Message-ID: <1404399697-26484-11-git-send-email-nick.dyer@itdev.co.uk>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:5681 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758536AbaGCPCd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jul 2014 11:02:33 -0400
In-Reply-To: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>, Nick Dyer <nick.dyer@itdev.co.uk>

From: Nick Dyer <nick.dyer@itdev.co.uk>

Later chips (for example mXT1664S) different mappings for bootloader addresses.
This means that we must look at the family ID to determine which address to
use.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index f9db3e1..5fe3285 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -391,6 +391,12 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data)
 	switch (appmode) {
 	case 0x4a:
 	case 0x4b:
+		/* Chips after 1664S use different scheme */
+		if (data->info.family_id >= 0xa2) {
+			bootloader = appmode - 0x24;
+			break;
+		}
+		/* Fall through for normal case */
 	case 0x4c:
 	case 0x4d:
 	case 0x5a:
-- 
2.0.1

