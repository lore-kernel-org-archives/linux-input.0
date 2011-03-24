From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Subject: [PATCH] HID: hid-ortek: update hid_info output
Date: Thu, 24 Mar 2011 15:05:37 -0300
Message-ID: <1300989937-4329-1-git-send-email-herton.krzesinski@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Minor cosmetic issue, after adding Ortek PKB-1700 support I forgot to
update the hid_info output string.

Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
---
 drivers/hid/hid-ortek.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-ortek.c b/drivers/hid/hid-ortek.c
index f9b7dd4..6584c16 100644
--- a/drivers/hid/hid-ortek.c
+++ b/drivers/hid/hid-ortek.c
@@ -22,7 +22,8 @@ static __u8 *ortek_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	if (*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x01) {
-		hid_info(hdev, "Fixing up Ortek WKB-2000 report descriptor\n");
+		hid_info(hdev, "Fixing up Ortek PKB-1700/"
+			       "WKB-2000 report descriptor\n");
 		rdesc[55] = 0x92;
 	}
 	return rdesc;
-- 
1.7.1
