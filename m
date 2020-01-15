Return-Path: <SRS0=BonL=3E=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53743C33CB2
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 20:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C2E22522
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgAOUJx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:09:53 -0500
Received: from orion.archlinux.org ([88.198.91.70]:46128 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgAOUJx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Jan 2020 15:09:53 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 3231D182108DA1;
        Wed, 15 Jan 2020 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:8a0:f254:2300:dad6:8c60:8394:88da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Wed, 15 Jan 2020 20:09:50 +0000 (UTC)
From:   =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH v4] HID: logitech-dj: add full support for the Powerplay mat/receiver
Date:   Wed, 15 Jan 2020 20:08:18 +0000
Message-Id: <20200115200818.3198848-1-lains@archlinux.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The Logitech G Powerplay has a lightspeed receiver with a static HID++
device with ID 7 attached to it to. It is used to configure the led on
the mat. For this reason I increased the max number of devices.

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---

v4

- Don't define the powerplay receiver (I forgot that we already did that
  in a previous patch)

---
 drivers/hid/hid-logitech-dj.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index bb50d6e7745b..1009f741a11d 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -16,11 +16,11 @@
 #include <asm/unaligned.h>
 #include "hid-ids.h"
 
-#define DJ_MAX_PAIRED_DEVICES			6
+#define DJ_MAX_PAIRED_DEVICES			7
 #define DJ_MAX_NUMBER_NOTIFS			8
 #define DJ_RECEIVER_INDEX			0
 #define DJ_DEVICE_INDEX_MIN			1
-#define DJ_DEVICE_INDEX_MAX			6
+#define DJ_DEVICE_INDEX_MAX			7
 
 #define DJREPORT_SHORT_LENGTH			15
 #define DJREPORT_LONG_LENGTH			32
@@ -980,6 +980,11 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		break;
 	}
 
+	/* custom receiver device (eg. powerplay) */
+	if (hidpp_report->device_index == 7) {
+		workitem.reports_supported |= HIDPP;
+	}
+
 	if (workitem.type == WORKITEM_TYPE_EMPTY) {
 		hid_warn(hdev,
 			 "unusable device of type %s (0x%02x) connected on slot %d",
@@ -1850,6 +1855,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1),
 	 .driver_data = recvr_type_gaming_hidpp},
+	{ /* Logitech powerplay mat/receiver (0xc539) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		0xc53a),
+	 .driver_data = recvr_type_gaming_hidpp},
 	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
 	 .driver_data = recvr_type_27mhz},
-- 
2.24.1
