From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH] hid-magicmouse: Add pointer and buttonpad properties for Magic Trackpad
Date: Mon, 13 Feb 2012 20:12:31 -0800
Message-ID: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40885 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759141Ab2BNEMg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 23:12:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 2ab7175..7cf3ffe 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -418,6 +418,8 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
 		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
 		__set_bit(BTN_TOUCH, input->keybit);
+		__set_bit(INPUT_PROP_POINTER, input->propbit);
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	}
 
 	if (report_touches) {
-- 
1.7.9

