From: Alan Ott <alan@signal11.us>
Subject: [PATCH v2 1/1] trivial: usbhid: Formatting fix
Date: Tue, 21 Sep 2010 18:18:32 -0400
Message-ID: <1285107512-6940-1-git-send-email-alan@signal11.us>
References: <4C98F245.2000002@ru.mvista.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:47865 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755288Ab0IUWSf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 18:18:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 777461CCAA74
	for <linux-input@vger.kernel.org>; Tue, 21 Sep 2010 18:18:34 -0400 (EDT)
In-Reply-To: <4C98F245.2000002@ru.mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@lin>
Cc: Alan Ott <alan@signal11.us>

Added blank line after declarations.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/usbhid/hid-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index b729c02..ff90069 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -810,6 +810,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 	if (usbhid->urbout) {
 		int actual_length;
 		int skipped_report_id = 0;
+
 		if (buf[0] == 0x0) {
 			/* Don't send the Report ID */
 			buf++;
-- 
1.7.0.4


