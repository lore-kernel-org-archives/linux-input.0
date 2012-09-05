From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH v2 20/20] HID: hid-multitouch: Fix contact count on 3M panels
Date: Wed, 5 Sep 2012 17:09:37 +0200
Message-ID: <20120905150937.GA260@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-21-git-send-email-rydberg@euromail.se>
 <CAN+gG=FwXaSWN_AYnU7Vpxn4GcWYG3Bf100P0QD_8cQfEnGc7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:36908 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2IEPDN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 11:03:13 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=FwXaSWN_AYnU7Vpxn4GcWYG3Bf100P0QD_8cQfEnGc7A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Some devices report the number of contacts via the unreliable
CONTACTCOUNT usage, rather than using the CONTACTMAX feature.
Without this patch, the 3M devices are constrained to the default
maximum of ten fingers.

Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Benjamin, are you ok with 0x506 being treated this way as well?

Thanks,
Henrik

 drivers/hid/hid-multitouch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index eee19c9..63f120b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -171,7 +171,9 @@ static struct mt_class mt_classes[] = {
 			MT_QUIRK_SLOT_IS_CONTACTID,
 		.sn_move = 2048,
 		.sn_width = 128,
-		.sn_height = 128 },
+		.sn_height = 128,
+		.maxcontacts = 60,
+	},
 	{ .name = MT_CLS_CYPRESS,
 		.quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
 			MT_QUIRK_CYPRESS,
-- 
1.7.12

