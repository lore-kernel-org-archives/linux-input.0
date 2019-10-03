Return-Path: <SRS0=81TE=X4=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C69C4360C
	for <linux-input@archiver.kernel.org>; Thu,  3 Oct 2019 03:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BD2085B
	for <linux-input@archiver.kernel.org>; Thu,  3 Oct 2019 03:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QaccEgu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfJCDSO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:18:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41521 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfJCDSO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 2 Oct 2019 23:18:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so827660pgv.8
        for <linux-input@vger.kernel.org>; Wed, 02 Oct 2019 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/aJshR20zBGmQxdU3JHIUrDxv6WMD/oZMV4/RGmXKI=;
        b=QaccEgu+T//6PP/p6dHVkugRL5dVEAHDgyIIOJORDCAAfYPdJoKQR2/wu1Gu+icFBo
         i8oVQ7DioL4pb2/bUIwTIdJBHxoytKLFq1TLRm7WdET/dA9zk0+BUHxvhHKcLabeJE2D
         7nDX52Wfl7ZIvh9r8fW+yGegZ//YDnnd8UtZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/aJshR20zBGmQxdU3JHIUrDxv6WMD/oZMV4/RGmXKI=;
        b=gvKPogmb3jWfuPhbuSZgoWrVWOhYBdOqqNekd7CxmCBWWf/QLWf1eIDPnXVtdiGpIx
         Qx1t7eB64ayphNpFpIVLGM/TH1rQq07cOSVOtW79tNTSbOH5H1+U9RfhZPRwYjc/12Pa
         /iYgJUyZpU1bcAOm+dMRHRSA0sTg3mzUwrUsvRQezZAwgTFCIeEV+rucVQPJQ0w6lZTx
         VNigWDn4SOXjjPtKFsAvh6wBADQ93CwWRzaKHCeWicotaPtWo5OOHXoCk94lAs5sm4Ia
         rElCYhJpN/KCGLDNPlQWFe0tLtk8W/YBTsMU1Bq0md331y4oUeJ0WQqZXHCgRfK6fL3i
         jIVw==
X-Gm-Message-State: APjAAAXirHnhWa4sms74V/g7q/uDGns34pdi3yAgc/SjGJMKmV521jNi
        VVbQm66RUBgFcqW7X32PpCVt0w==
X-Google-Smtp-Source: APXvYqwnlMUjWmu3dVl0hJhSOQr4CKnpfJETmBtC5LRWM7LsP/HAn/y/eMyT5Sh5l21oRlzQw8WjwA==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr8470046pfk.118.1570072693206;
        Wed, 02 Oct 2019 20:18:13 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id z12sm880999pfj.41.2019.10.02.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 20:18:12 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dtor@chromium.org, ikjn@chromium.org
Subject: [PATCH 1/2] HID: google: add magnemite/masterball USB ids
Date:   Thu,  3 Oct 2019 11:17:59 +0800
Message-Id: <20191003031800.120237-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20191003031759.CG6NG7yAjO7LlhHvQldIwSwrkVWKNPLqRXMqfaZJHzQ@z>

Add 2 additional hammer-like devices.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 4 ++++
 drivers/hid/hid-ids.h           | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 31e4a39946f59ad..a52535ebc6fe92c 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -531,6 +531,10 @@ static void hammer_remove(struct hid_device *hdev)
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MASTERBALL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 76969a22b0f2f79..447e8db21174ae7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -476,6 +476,8 @@
 #define USB_DEVICE_ID_GOOGLE_STAFF	0x502b
 #define USB_DEVICE_ID_GOOGLE_WAND	0x502d
 #define USB_DEVICE_ID_GOOGLE_WHISKERS	0x5030
+#define USB_DEVICE_ID_GOOGLE_MASTERBALL	0x503c
+#define USB_DEVICE_ID_GOOGLE_MAGNEMITE	0x503d
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.23.0.444.g18eeb5a265-goog

