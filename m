From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 13/14] HID: picolcd_core: validate output report details
Date: Wed, 28 Aug 2013 22:31:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282222460.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58006 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab3H1Ub4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:31:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious output report that would cause the
picolcd HID driver to trigger a NULL dereference during attr file writing.

CVE-2013-2899

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-picolcd_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index b48092d..72bba1e 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -290,7 +290,7 @@ static ssize_t picolcd_operation_mode_store(struct device *dev,
 		buf += 10;
 		cnt -= 10;
 	}
-	if (!report)
+	if (!report || report->maxfield < 1)
 		return -EINVAL;
 
 	while (cnt > 0 && (buf[cnt-1] == '\n' || buf[cnt-1] == '\r'))
-- 
Jiri Kosina
SUSE Labs
