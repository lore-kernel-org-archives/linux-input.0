From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: logitech-hidpp: fix spelling mistake, "feeback" -> "feedback"
Date: Fri, 14 Jul 2017 14:37:12 +0100
Message-ID: <20170714133712.28071-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in hid_info message and add line break
to split an overly long line to clean up a checkpatch warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 41b39464ded8..8d7a1a5ef427 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1957,7 +1957,8 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	/* initialize with zero autocenter to get wheel in usable state */
 	hidpp_ff_set_autocenter(dev, 0);
 
-	hid_info(hid, "Force feeback support loaded (firmware release %d).\n", version);
+	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
+		 version);
 
 	return 0;
 }
-- 
2.11.0
