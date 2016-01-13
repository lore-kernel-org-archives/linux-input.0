From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH 2/2] HID: sony: Fixup output reports for the nyko core controller
Date: Wed, 13 Jan 2016 07:40:43 -0700
Message-ID: <1452696043-18362-2-git-send-email-oreaus@gmail.com>
References: <1452696043-18362-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:34931 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbcAMOks (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 09:40:48 -0500
Received: by mail-ob0-f194.google.com with SMTP id tr5so31389995obc.2
        for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 06:40:47 -0800 (PST)
In-Reply-To: <1452696043-18362-1-git-send-email-oreaus@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: ao2@ao2.it, jkosina@suse.cz, frank.praznik@oh.rr.com, Scott Moreau <oreaus@gmail.com>

The nyko core controller uses the same output report format as the
sixaxis controllers, but it expects the report id at offset 1.

This does not interfere with the official controllers as this byte
is considered a padding byte by the current code.

Signed-off-by: Scott Moreau <oreaus@gmail.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ea13de0..fdd92a1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1798,7 +1798,7 @@ static void sixaxis_state_worker(struct work_struct *work)
 	static const union sixaxis_output_report_01 default_report = {
 		.buf = {
 			0x01,
-			0x00, 0xff, 0x00, 0xff, 0x00,
+			0x01, 0xff, 0x00, 0xff, 0x00,
 			0x00, 0x00, 0x00, 0x00, 0x00,
 			0xff, 0x27, 0x10, 0x00, 0x32,
 			0xff, 0x27, 0x10, 0x00, 0x32,
-- 
2.5.0

