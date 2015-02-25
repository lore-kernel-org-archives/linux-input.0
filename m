From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] HID: uclogic: present only the working interfaces on the Huion tablets
Date: Tue, 24 Feb 2015 19:05:29 -0500
Message-ID: <1424822730-14938-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbbBYAFq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 19:05:46 -0500
In-Reply-To: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

The Huion tablets show 3 interfaces. Only the first and the third
are currently used.
Also remove HID_QUIRK_MULTI_INPUT for the third interface to not
create more than needed input nodes.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-uclogic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 397f1df..c03e076 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -840,6 +840,11 @@ static int uclogic_probe(struct hid_device *hdev,
 				hid_err(hdev, "tablet enabling failed\n");
 				return rc;
 			}
+		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
+			hdev->quirks &= ~HID_QUIRK_MULTI_INPUT;
+		} else {
+			/* Ignore all unused interfaces */
+			return -ENODEV;
 		}
 		break;
 	}
-- 
2.1.0

