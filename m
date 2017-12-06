From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: core: lower log level for unknown main item tags to warnings
Date: Wed,  6 Dec 2017 17:54:38 +0100
Message-ID: <20171206165438.676-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbdLFQyn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Dec 2017 11:54:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Given all the effort distros have done with splash-screens to give
users a nice clean boot experience, we really want dmesg --level=err
to not print anything unless there is a real problem with either the
hardware or the kernel. Buggy HID descriptors unfortunately happen
all too often, so lower the log level to warning keep the console
clear of error messages such as:

[  441.079664] apple 0005:05AC:0239.0003: unknown main item tag 0x0

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7297b1d1300c..c2560aae5542 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -551,7 +551,7 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
 		ret = hid_add_field(parser, HID_FEATURE_REPORT, data);
 		break;
 	default:
-		hid_err(parser->device, "unknown main item tag 0x%x\n", item->tag);
+		hid_warn(parser->device, "unknown main item tag 0x%x\n", item->tag);
 		ret = 0;
 	}
 
-- 
2.14.3

