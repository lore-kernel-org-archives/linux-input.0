From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 3/4] HID: uhid: Use GFP_ATOMIC in uhid_hid_output_raw
Date: Sat,  1 Dec 2012 16:07:20 -0300
Message-ID: <1354388841-23854-4-git-send-email-andre.guedes@openbossa.org>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34342 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LATHp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 14:07:45 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so688953vcd.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 11:07:45 -0800 (PST)
In-Reply-To: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

We should use GFP_ATOMIC in uhid_hid_output_raw as long as it may
be called in atomic section.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index a5cf905..ef74fc6 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -261,7 +261,7 @@ static int uhid_hid_output_raw(struct hid_device *hid, __u8 *buf, size_t count,
 	if (count < 1 || count > UHID_DATA_MAX)
 		return -EINVAL;
 
-	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
 	if (!ev)
 		return -ENOMEM;
 
-- 
1.8.0.1

