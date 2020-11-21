Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF51C388F9
	for <linux-input@archiver.kernel.org>; Sat, 21 Nov 2020 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AC6208C3
	for <linux-input@archiver.kernel.org>; Sat, 21 Nov 2020 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hard-wi.red header.i=@hard-wi.red header.b="FZlcZBDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgKUVBx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 21 Nov 2020 16:01:53 -0500
Received: from v133-130-127-43.a05a.g.tyo1.static.cnode.io ([133.130.127.43]:56344
        "EHLO mail.hard-wi.red" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgKUVBu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Nov 2020 16:01:50 -0500
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.hard-wi.red (Postfix) with ESMTPA id 92CA82000F1;
        Sat, 21 Nov 2020 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hard-wi.red; s=dkim;
        t=1605992141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMbsj4fI3PwnHDZc2eE/z5jL3LZDD7vI9BQLmOeFUQw=;
        b=FZlcZBDMXykj/mRRgP3imFPDLDPlJrBvLWIBmyOAc8+KtYFfOaH6K+6gdCO5NeUJON3OXO
        wQfyZx7P0ZKLMAeExeUHOBu/hVLtXY3Vh+LfzFfe/txoJgodkr+6CvuWzewm1yM4ISP01J
        dQTfw7DnDeaWF7gsnLF+s8XQYlggLJA=
From:   YOSHIOKA Takuma <lo48576@hard-wi.red>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     YOSHIOKA Takuma <lo48576@hard-wi.red>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: elecom: add support for EX-G M-XGL20DLBK wireless mouse
Date:   Sun, 22 Nov 2020 05:54:38 +0900
Message-Id: <20201121205438.4092-2-lo48576@hard-wi.red>
In-Reply-To: <20201121205438.4092-1-lo48576@hard-wi.red>
References: <20201121205438.4092-1-lo48576@hard-wi.red>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=hard-wi.red;
        s=dkim; t=1605992141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMbsj4fI3PwnHDZc2eE/z5jL3LZDD7vI9BQLmOeFUQw=;
        b=WcQdqk8k6YBxJZTa1sDLQF5tED9OdQaDboBShj4rwlCVgkoIUt7sx6bHx15aYnwOA7c0Il
        RFXb9VD72j4r83uVRHc2y8HxK9ZumFNu4y4sXT51rusjTqmqmjm7lsWyfdbWV6iAaavLvY
        yWxWrIxCIlCFkABtoD8xJn/v4ehdMaI=
ARC-Seal: i=1; s=dkim; d=hard-wi.red; t=1605992141; a=rsa-sha256; cv=none;
        b=PNzjEFiSa37qscaTQW/RwCrvBBjnksGqyiOpZIWdE8qb+tSHip5NQyYZYzVodM1ep8zxU+
        VJkSby7dJhcR+kDwE/q41kCBZujKBRtWiSSOPT+TMwh7K0HqczglL34v2al9QzzqHV7+pa
        J4kvcRkC6Vf8ktxB2PRFGhDTrEnkaKs=
ARC-Authentication-Results: i=1;
        mail.hard-wi.red;
        auth=pass smtp.auth=lo48576@hard-wi.red smtp.mailfrom=lo48576@hard-wi.red
X-Spamd-Bar: +++++
Authentication-Results: mail.hard-wi.red;
        auth=pass smtp.auth=lo48576@hard-wi.red smtp.mailfrom=lo48576@hard-wi.red
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Enables three buttons (Fn1, Fn2, and Fn3) on the ELECOM M-XGL20DLBK
wireless mouse.

While this mouse is EX-G brand, report descriptor is a bit different
from EX-G trackball mouse. To enable extra buttons, report should be
rewritten in a similar way to trackballs, but with different position
parameters.

Signed-off-by: YOSHIOKA Takuma <lo48576@hard-wi.red>
---
 drivers/hid/hid-elecom.c | 11 +++++++++++
 drivers/hid/hid-ids.h    |  1 +
 drivers/hid/hid-quirks.c |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 233188100884..3bd7207de2e8 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -64,6 +64,16 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[47] = 0x00;
 		}
 		break;
+	case USB_DEVICE_ID_ELECOM_M_XGL20DLBK:
+		/*
+		 * Report descriptor format:
+		 * 20: button bit count
+		 * 28: padding bit count
+		 * 22: button report size
+		 * 14: button usage maximum
+		 */
+		mouse_button_fixup(hdev, rdesc, *rsize, 20, 28, 22, 14, 8);
+		break;
 	case USB_DEVICE_ID_ELECOM_M_XT3URBK:
 	case USB_DEVICE_ID_ELECOM_M_XT3DRBK:
 	case USB_DEVICE_ID_ELECOM_M_XT4DRBK:
@@ -96,6 +106,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d69842f79fc6..a29f4dacf640 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -388,6 +388,7 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
+#define USB_DEVICE_ID_ELECOM_M_XGL20DLBK	0x00e6
 #define USB_DEVICE_ID_ELECOM_M_XT3URBK	0x00fb
 #define USB_DEVICE_ID_ELECOM_M_XT3DRBK	0x00fc
 #define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 7a2be0205dfd..9355d92c6f14 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -361,6 +361,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
-- 
2.29.2

