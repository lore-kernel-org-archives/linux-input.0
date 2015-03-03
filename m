From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 4/6] HID: uclogic: apply quirk NO_EMPTY_INPUT
Date: Tue,  3 Mar 2015 12:44:03 -0500
Message-ID: <1425404645-20134-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309AbbCCRoW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Mar 2015 12:44:22 -0500
In-Reply-To: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

NO_EMPTY_INPUT is useful when MULTI_INPUT is set. It prevents to create
empty input nodes that user space does not know what to do with.

It does not seem to be required at the moment, this is just a preventive
patch. This check is only made during the plug of the device, so it does
not hurt to have it.

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

no changes in v3
new in v2

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

