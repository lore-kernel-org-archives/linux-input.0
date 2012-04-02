From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 3 Apr 2012 01:41:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204030139470.16928@pobox.suse.cz>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <4F78AD8B.9020104@gmail.com> <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz> <4F78BF82.70903@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36494 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab2DBXlv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Apr 2012 19:41:51 -0400
In-Reply-To: <4F78BF82.70903@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:

> > I will be travelling for the whole day tomorrow, so I will look into this
> > onboard the airplane and will try to come up with a fix.
> 
> Great! Thank you :)!

Please let me know whether the patch below fixes the rebinding for your 
drivers that replace the report descriptor. I believe it should. Thanks in 
advance for testing.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: make hid_parse() reentrant

It is possible to rebind the drivers on HID bus manually from userspace
(through sysfs bind/unbind facility). This way, we can easily allow drivers to
claim device IDs even if this doesn't happen automatically through explicit
hid_have_special_driver[] entry.

If driver is rebound, hid_parse() sees the HID_STATE_PARSED flag set, and
doesn't proceed parsing the report descriptor again.

This might however be unwanted in cases when the newly rebound driver does
a report descriptor fixup, as it doesn't get parsed again with the replaced
values.

Instead of bailing out directly when HID_STAT_PARSED flag is set, throw
away the old report descriptor stored in hid_device->rdesc, and let the
whole rdesc parsing be restarted (with ->report_fixup callback of the newly
rebound driver being called prior to the actual parsing).

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 include/linux/hid.h |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3a95da6..f771eba 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -807,8 +807,16 @@ static inline int __must_check hid_parse(struct hid_device *hdev)
 {
 	int ret;
 
-	if (hdev->status & HID_STAT_PARSED)
-		return 0;
+	if (hdev->status & HID_STAT_PARSED) {
+		/*
+		 * We want to be re-entrant to allow for dynamic driver
+		 * rebinding and still allow rdescs to be replaced and
+		 * and re-parsed once the driver has been dynamically
+		 * rebound
+		 */
+		kfree(hdev->rdesc);
+		hdev->status &= ~HID_STAT_PARSED;
+	}
 
 	ret = hdev->ll_driver->parse(hdev);
 	if (!ret)
-- 
Jiri Kosina
SUSE Labs
