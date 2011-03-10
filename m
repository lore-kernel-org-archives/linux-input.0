From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 1/2] hid: ntrig NO_INIT_REPORTS
Date: Wed,  9 Mar 2011 23:33:51 -0500
Message-ID: <1299731632-9814-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr, Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

Probing reports does bad things with some ntrig firmwares, better to
just leave them alone.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>

---

This resolves an annoying delay on initialization and reduces the
chance of the device coming up in an odd state or crashing.
---
 drivers/hid/hid-ntrig.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index b1e9cca..850ba14 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -837,7 +837,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct hid_report *report;
 
 	if (id->driver_data)
-		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT
+				| HID_QUIRK_NO_INIT_REPORTS;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
 	if (!nd) {
-- 
1.7.4.1
