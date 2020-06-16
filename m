Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5160AC433E0
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D1120B1F
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="SbJeLTFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgFPTGt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgFPTGt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 15:06:49 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C4C06174E
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2020 12:06:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2824115002EC;
        Tue, 16 Jun 2020 21:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592334062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c+vtbEXBLAum4cfRDsthiIbEKyQV6GkxTQYpGQE3yPc=;
        b=SbJeLTFdGV5nnJh7kfshfOSin5u0cKyL0m18MP2GfrlEGsRJfd5l2KMmVUgxIRgD4ZFDBx
        3cxFPT4L3PnJqQ4IIpLt+m6ulLBORf6YSxVFS1DVEcP4xgahbkuAbQTnz3sI8cdn0uLZWb
        2sOeRX1SmL4WtoQzQUnstwCMdoLLM/XEPPQbVoe6E0EXdmoid3awRMYMUlwOmPOIHmErSq
        wPRK5vbIXpVv+Zjsi1KYuH/FIF89IRG6jkRHS3KjeNU1ovlw3l66J5c0U4wufVl6K15uw5
        d/dFuzerZJ4TfIESO4Fmg5IX4Hv0fffndA3GbdOGBtmkTkfvoSCj/RR4JMfx/g==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        linux-input@vger.kernel.org
Subject: [PATCH 1/4] drivers: hid: lightly fix code style
Date:   Tue, 16 Jun 2020 21:00:41 +0200
Message-Id: <20200616190044.126928-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/hid/hid-input.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index dea9cc65bf80..5a7282a0abbb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1185,7 +1185,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		if (field->application == HID_GD_GAMEPAD || field->application == HID_GD_JOYSTICK)
 			input_set_abs_params(input, usage->code, a, b, (b - a) >> 8, (b - a) >> 4);
-		else	input_set_abs_params(input, usage->code, a, b, 0, 0);
+		else
+			input_set_abs_params(input, usage->code, a, b, 0, 0);
 
 		input_abs_set_res(input, usage->code,
 				  hidinput_calc_abs_res(field, usage->code));
@@ -1198,6 +1199,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 	if (usage->type == EV_ABS &&
 	    (usage->hat_min < usage->hat_max || usage->hat_dir)) {
 		int i;
+
 		for (i = usage->code; i < usage->code + 2 && i <= max; i++) {
 			input_set_abs_params(input, i, -1, 1, 0, 0);
 			set_bit(i, input->absbit);
@@ -1280,10 +1282,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
+
 		if (!hat_dir)
 			hat_dir = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
-		if (hat_dir < 0 || hat_dir > 8) hat_dir = 0;
-		input_event(input, usage->type, usage->code    , hid_hat_to_axis[hat_dir].x);
+		if (hat_dir < 0 || hat_dir > 8)
+			hat_dir = 0;
+		input_event(input, usage->type, usage->code, hid_hat_to_axis[hat_dir].x);
 		input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
 		return;
 	}
@@ -1306,11 +1310,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	if (usage->hid == (HID_UP_DIGITIZER | 0x0030) && (*quirks & HID_QUIRK_NOTOUCH)) { /* Pressure */
 		int a = field->logical_minimum;
 		int b = field->logical_maximum;
+
 		input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
 	}
 
 	if (usage->hid == (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects Max */
-		dbg_hid("Maximum Effects - %d\n",value);
+		dbg_hid("Maximum Effects - %d\n", value);
 		return;
 	}
 
@@ -1869,6 +1874,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 	if (!force) {
 		for (i = 0; i < hid->maxcollection; i++) {
 			struct hid_collection *col = &hid->collection[i];
+
 			if (col->type == HID_COLLECTION_APPLICATION ||
 					col->type == HID_COLLECTION_PHYSICAL)
 				if (IS_INPUT_APPLICATION(col->usage))
-- 
2.27.0

