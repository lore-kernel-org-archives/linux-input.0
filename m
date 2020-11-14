Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC43AC5519F
	for <linux-input@archiver.kernel.org>; Sat, 14 Nov 2020 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F842240B
	for <linux-input@archiver.kernel.org>; Sat, 14 Nov 2020 21:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EII7+lQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKNVVM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 14 Nov 2020 16:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgKNVVL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 14 Nov 2020 16:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605388870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LgUUdlmp5muwzhFui+d5AF0Ppr/CTIesYvMJ8BCdds=;
        b=EII7+lQ2Mj40coDRJUfNiyoRQ54B3/JPXsK/ipY+ylT0cwQLIAkyYDmWcpCbDUq7m9fU6E
        bQh4oMOsKOYiOsMmM7rlSlcPxCkAtaFHeqp4BYvdKC4Rx6SeZmp2PXM0d/2WGmkddb0AQU
        LtZydkunZFnEUkHmt/I6qkD0U9NNHYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-y10PMhXnNpe6JTEeKq8cYA-1; Sat, 14 Nov 2020 16:21:06 -0500
X-MC-Unique: y10PMhXnNpe6JTEeKq8cYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627A11868409;
        Sat, 14 Nov 2020 21:21:05 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-23.ams2.redhat.com [10.36.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6510519930;
        Sat, 14 Nov 2020 21:21:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org
Subject: [RFC 1/3] HID: logitech-dj: Fix Dinovo Mini when paired with a MX5x00 receiver
Date:   Sat, 14 Nov 2020 22:20:56 +0100
Message-Id: <20201114212058.19590-2-hdegoede@redhat.com>
In-Reply-To: <20201114212058.19590-1-hdegoede@redhat.com>
References: <20201114212058.19590-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Some users are pairing the Dinovo keyboards with the MX5000 or MX5500
receivers, instead of with the Dinovo receivers. The receivers are
mostly the same (and the air protocol obviously is compatible) but
currently the Dinovo receivers are handled by hid-lg.c while the
MX5x00 receivers are handled by logitech-dj.c.

When using a Dinovo keyboard, with its builtin touchpad, through
logitech-dj.c then the touchpad stops working because when asking the
receiver for paired devices, we get only 1 paired device with
a device_type of REPORT_TYPE_KEYBOARD. And since we don't see a paired
mouse, we have nowhere to send mouse-events to, so we drop them.

Extend the existing fix for the Dinovo Edge for this to also cover the
Dinovo Mini keyboard and also add a mapping to logitech-hidpp for the
Media key on the Dinovo Mini, so that that keeps working too.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1811424
Fixes: f2113c3020ef ("HID: logitech-dj: add support for Logitech Bluetooth Mini-Receiver")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-logitech-dj.c    |  1 +
 drivers/hid/hid-logitech-hidpp.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index cda50c420f0b..4976ed827b3e 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -876,6 +876,7 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
  */
 static const u16 kbd_builtin_touchpad_ids[] = {
 	0xb309, /* Dinovo Edge */
+	0xb30c, /* Dinovo Mini */
 };
 
 static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9fcd7f6c5a71..d062fffc6ebb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -95,6 +95,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
 #define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
 
+#define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
+
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
  * as register access protocol or RAP, the second version hidpp20 is known as
@@ -2952,6 +2954,26 @@ static int g920_get_config(struct hidpp_device *hidpp,
 	return g920_ff_set_autocenter(hidpp, data);
 }
 
+/* -------------------------------------------------------------------------- */
+/* Logitech Dinovo Mini keyboard with builtin touchpad                        */
+/* -------------------------------------------------------------------------- */
+#define DINOVO_MINI_PRODUCT_ID		0xb30c
+
+static int lg_dinovo_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_LOGIVENDOR)
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x00d: lg_map_key_clear(KEY_MEDIA);	break;
+	default:
+		return 0;
+	}
+	return 1;
+}
+
 /* -------------------------------------------------------------------------- */
 /* HID++1.0 devices which use HID++ reports for their wheels                  */
 /* -------------------------------------------------------------------------- */
@@ -3187,6 +3209,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			field->application != HID_GD_MOUSE)
 		return m560_input_mapping(hdev, hi, field, usage, bit, max);
 
+	if (hdev->product == DINOVO_MINI_PRODUCT_ID)
+		return lg_dinovo_input_mapping(hdev, hi, field, usage, bit, max);
+
 	return 0;
 }
 
-- 
2.28.0

