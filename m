Return-Path: <SRS0=BonL=3E=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBEC32771
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA7B2064C
	for <linux-input@archiver.kernel.org>; Wed, 15 Jan 2020 20:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOUTS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:19:18 -0500
Received: from orion.archlinux.org ([88.198.91.70]:51938 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUTS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Jan 2020 15:19:18 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id A4BEF182130A0D;
        Wed, 15 Jan 2020 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:8a0:f254:2300:dad6:8c60:8394:88da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Wed, 15 Jan 2020 20:18:38 +0000 (UTC)
From:   =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH] HID: logitech-dj: add support for the static device in the Powerplay mat/receiver
Date:   Wed, 15 Jan 2020 20:18:11 +0000
Message-Id: <20200115201811.3271284-1-lains@archlinux.org>
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
 drivers/hid/hid-logitech-dj.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index bb50d6e7745b..79294b873057 100644
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
-- 
2.24.1
