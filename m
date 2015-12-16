From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/4] HID: wacom: Report 'strip2' values in ABS_RY
Date: Wed, 16 Dec 2015 13:37:34 -0800
Message-ID: <1450301856-7253-2-git-send-email-killertofu@gmail.com>
References: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35662 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966388AbbLPVh5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 16:37:57 -0500
Received: by mail-pf0-f181.google.com with SMTP id v86so18412686pfa.2
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 13:37:57 -0800 (PST)
In-Reply-To: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit c7f0522 accidentally used ABS_RX for reporting both 'strip1' and
'strip2', when the latter should actually be reported through ABS_RY.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cf87810..94dffde 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -558,7 +558,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 		input_report_key(input, KEY_PROG1 + i, keys & (1 << i));
 
 	input_report_abs(input, ABS_RX, strip1);
-	input_report_abs(input, ABS_RX, strip2);
+	input_report_abs(input, ABS_RY, strip2);
 
 	input_report_abs(input, ABS_WHEEL,    ring1 & 0x7f ? ring1 : 0);
 	input_report_abs(input, ABS_THROTTLE, ring2 & 0x07 ? ring2 : 0);
-- 
2.6.3

