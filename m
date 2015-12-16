From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/4] HID: wacom: Fix touchring value reporting
Date: Wed, 16 Dec 2015 13:37:35 -0800
Message-ID: <1450301856-7253-3-git-send-email-killertofu@gmail.com>
References: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35667 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966412AbbLPVh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 16:37:58 -0500
Received: by mail-pf0-f180.google.com with SMTP id v86so18412828pfa.2
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 13:37:57 -0800 (PST)
In-Reply-To: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit c7f0522 reports incorrect touchring values to userspace. This is
due to its incorrect handling of the 'touched' bit present in the 'ring1'
and 'ring2' variables. Instead of using this bit when determining if a
value should be sent, the ABS_WHEEL and ABS_INPUT check (different?!)
portions of the position bits. Furthermore, the full values of 'ring1'
and 'ring2' are reported to userspace, despite the 'touched' flag
needing to be trimmed beforehand. This commit addresses both issues.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 94dffde..23212af 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -560,8 +560,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	input_report_abs(input, ABS_RX, strip1);
 	input_report_abs(input, ABS_RY, strip2);
 
-	input_report_abs(input, ABS_WHEEL,    ring1 & 0x7f ? ring1 : 0);
-	input_report_abs(input, ABS_THROTTLE, ring2 & 0x07 ? ring2 : 0);
+	input_report_abs(input, ABS_WHEEL,    (ring1 & 0x80) ? (ring1 & 0x7f) : 0);
+	input_report_abs(input, ABS_THROTTLE, (ring2 & 0x80) ? (ring2 & 0x7f) : 0);
 
 	input_report_key(input, wacom->tool[1], prox ? 1 : 0);
 	input_report_abs(input, ABS_MISC, prox ? PAD_DEVICE_ID : 0);
-- 
2.6.3

