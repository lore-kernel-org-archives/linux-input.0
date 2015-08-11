From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 1/3] HID: lenovo: Use constants for axes names
Date: Tue, 11 Aug 2015 22:40:50 +0100
Message-ID: <1439329252-16809-2-git-send-email-jm@lentin.co.uk>
References: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/hid/hid-lenovo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index c4c3f09..65df414 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -117,10 +117,10 @@ static int lenovo_input_mapping_cptkbd(struct hid_device *hdev,
 
 		switch (usage->hid & HID_USAGE) {
 		case 0x0000:
-			hid_map_usage(hi, usage, bit, max, EV_REL, 0x06);
+			hid_map_usage(hi, usage, bit, max, EV_REL, REL_HWHEEL);
 			return 1;
 		case 0x0001:
-			hid_map_usage(hi, usage, bit, max, EV_REL, 0x08);
+			hid_map_usage(hi, usage, bit, max, EV_REL, REL_WHEEL);
 			return 1;
 		default:
 			return -1;
-- 
2.1.4
