From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH] hid: huion: Fix sparse warnings
Date: Tue, 29 Jul 2014 15:50:06 +0300
Message-ID: <1406638206-6108-1-git-send-email-spbnick@gmail.com>
References: <alpine.LNX.2.00.1407291121530.16390@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:36736 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaG2MuV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 08:50:21 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so8878598wes.3
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 05:50:16 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1407291121530.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>

Fix sparse warnings in hid-huion.c by using correct buffer type for
retrieved string descriptor.

The warnings in question were:

    drivers/hid/hid-huion.c:144:44: sparse: cast to restricted __le16
    drivers/hid/hid-huion.c:145:44: sparse: cast to restricted __le16
    drivers/hid/hid-huion.c:146:51: sparse: cast to restricted __le16
    drivers/hid/hid-huion.c:147:30: sparse: cast to restricted __le16

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---

Hi Jiri, Benjamin,

Thanks for the review. There is one minor problem, though. I didn't run a
sparse check and only just got a message with "sparse" warnings. This patch
fixes them.

If you wouldn't like adding a tiny patch like this, I can send another version
of the original patches. Otherwise, please feel free to just fixup my "Switch
to generating report descriptor" commit with this one.

I'll try to remember to run sparse next time before submitting the patches.

Thank you.

Nick

 drivers/hid/hid-huion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 438b54e..60f44cd 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -115,7 +115,7 @@ static int huion_tablet_enable(struct hid_device *hdev)
 	int rc;
 	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
 	struct huion_drvdata *drvdata = hid_get_drvdata(hdev);
-	u16 buf[6];
+	__le16 buf[6];
 
 	/*
 	 * Read string descriptor containing tablet parameters. The specific
-- 
2.0.1

