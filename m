From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 4/9] HID: uclogic: Remove allocation failure messages
Date: Wed, 14 Sep 2016 21:38:15 +0300
Message-ID: <20160914183820.20737-5-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbcINSin (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so3752772wme.0
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:42 -0700 (PDT)
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Remove unnecessary allocation failure messages from hid-uclogic.c,
following the checkpatch.pl recommendations.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-uclogic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 6a59f6a..790528e 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -777,7 +777,6 @@ static int uclogic_tablet_enable(struct hid_device *hdev)
 	len = UCLOGIC_PRM_NUM * sizeof(*buf);
 	buf = kmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
-		hid_err(hdev, "failed to allocate parameter buffer\n");
 		rc = -ENOMEM;
 		goto cleanup;
 	}
@@ -821,7 +820,6 @@ static int uclogic_tablet_enable(struct hid_device *hdev)
 				sizeof(uclogic_tablet_rdesc_template),
 				GFP_KERNEL);
 	if (drvdata->rdesc == NULL) {
-		hid_err(hdev, "failed to allocate fixed rdesc\n");
 		rc = -ENOMEM;
 		goto cleanup;
 	}
-- 
2.9.3

