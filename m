From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/6] HID: uclogic: apply quirk NO_EMPTY_INPUT
Date: Thu, 26 Feb 2015 13:57:27 -0500
Message-ID: <1424977049-18648-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

NO_EMPTY_INPUT is useful when MULTI_INPUT is set. It prevents to create
empty input nodes that user space does not know what to do with.

It does not seem to be required at the moment, this is just a preventive
patch. This check is only made during the plug of the device, so it does
not hurt to have it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

New in v2

 drivers/hid/hid-uclogic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 90e2612..ada8a94 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -868,6 +868,7 @@ static int uclogic_probe(struct hid_device *hdev,
 	 * than the pen, so use QUIRK_MULTI_INPUT for all tablets.
 	 */
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
 
 	/* Allocate and assign driver data */
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-- 
2.1.0
