Return-Path: <SRS0=2vxM=EI=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D03C388F2
	for <linux-input@archiver.kernel.org>; Mon,  2 Nov 2020 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE425206E5
	for <linux-input@archiver.kernel.org>; Mon,  2 Nov 2020 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLN6PsCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgKBNhK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:37:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKBNhK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Nov 2020 08:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604324229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoSXyMwgflez4xlOa2hKOKmekQ8D0RbS78OQ+2bfqKM=;
        b=VLN6PsCuNnqqUZ7zlfukGUXCuO60XD9vbCfLHLEAHsaHqLLAJJCFDUu5mVLe2CGM4cQ/ue
        A3N4gv6z2Ppht3oCwJIKwNFM+LMG1+3XAZGPafOOfCK6LeQxsTwBO4k0RQ3QtAK7bV/Gdd
        +BeY7Kk4zoxXMx0yE50pg9cX5K/JJRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-ZV8ARmBJMaq4WaUErXpEMA-1; Mon, 02 Nov 2020 08:37:07 -0500
X-MC-Unique: ZV8ARmBJMaq4WaUErXpEMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85AA81842152;
        Mon,  2 Nov 2020 13:37:06 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-9.ams2.redhat.com [10.36.113.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C8635DA6B;
        Mon,  2 Nov 2020 13:37:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org
Subject: [PATCH 3/3] HID: Add Logitech Dinovo Edge battery quirk
Date:   Mon,  2 Nov 2020 14:36:58 +0100
Message-Id: <20201102133658.4410-3-hdegoede@redhat.com>
In-Reply-To: <20201102133658.4410-1-hdegoede@redhat.com>
References: <20201102133658.4410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The battery status is also being reported by the logitech-hidpp driver,
so ignore the standard HID battery status to avoid reporting the same
info twice.

Note the logitech-hidpp battery driver provides more info, such as properly
differentiating between charging and discharging. Also the standard HID
battery info seems to be wrong, reporting a capacity of just 26% after
fully charging the device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d69842f79fc6..c810c7a28bdd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -743,6 +743,7 @@
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
+#define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
 #define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9770db624bfa..4dca11392459 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -319,6 +319,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.28.0

