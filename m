From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 29/51] Input: atmel_mxt_ts - Add bootloader addresses for new chips
Date: Thu, 27 Jun 2013 13:49:04 +0100
Message-ID: <1372337366-9286-30-git-send-email-nick.dyer@itdev.co.uk>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Later chips (for example mXT1664S) different mappings for bootloader addresses.
This means that we must look at the family ID to determine which address to
use. There is an additional complication: when we probe and we don't know the
family ID yet, we need to try both possible addresses to find the bootloader.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4385653..780952a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -393,6 +393,12 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data)
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
1.7.10.4
