Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847CBC7618B
	for <linux-input@archiver.kernel.org>; Wed, 15 Mar 2023 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjCONql (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjCONqT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Mar 2023 09:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631A366B8
        for <linux-input@vger.kernel.org>; Wed, 15 Mar 2023 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678887885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7KlC7BXqTjMXquVGJ6jNAnxOjGMB0624p+6TQUkHcfA=;
        b=GucdI2L6QP2Ovfb3YAoIdovQuaB0/uF6Ha5MnZdkBb3UZeOauxwWuOsd+a/KxhBuD32VKQ
        jgK6pk7GBzFDgkNCML+4tZ+GA7FXkyvK3xPyyUepD2u/CA7OUW8xpzSUWybyD4D10B4a+j
        IJq7kDD+y7GFn9X1127hX/B7Sy3RuFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-fpZvHCR0N8aBQPdyUyMsJQ-1; Wed, 15 Mar 2023 09:44:43 -0400
X-MC-Unique: fpZvHCR0N8aBQPdyUyMsJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867ED887400;
        Wed, 15 Mar 2023 13:44:43 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEBE1492B00;
        Wed, 15 Mar 2023 13:44:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Subject: [PATCH] Input: goodix - Add Lenovo Yoga Book X90F to nine_bytes_report DMI table
Date:   Wed, 15 Mar 2023 14:44:42 +0100
Message-Id: <20230315134442.71787-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The Android Lenovo Yoga Book X90F / X90L uses the same goodix touchscreen
with 9 bytes touch reports for its touch keyboard as the already supported
Windows Lenovo Yoga Book X91F/L, add a DMI match for this to
the nine_bytes_report DMI table.

When the quirk for the X91F/L was initially added it was written to
also apply to the X90F/L but this does not work because the Android
version of the Yoga Book uses completely different DMI strings.
Also adjust the X91F/L quirk to reflect that it only applies to
the X91F/L models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3c71f0df9769..88c223a4da61 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -128,10 +128,18 @@ static const unsigned long goodix_irq_flags[] = {
 static const struct dmi_system_id nine_bytes_report[] = {
 #if defined(CONFIG_DMI) && defined(CONFIG_X86)
 	{
-		.ident = "Lenovo YogaBook",
-		/* YB1-X91L/F and YB1-X90L/F */
+		/* Lenovo Yoga Book X90F / X90L */
 		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9")
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		}
+	},
+	{
+		/* Lenovo Yoga Book X91F / X91L */
+		.matches = {
+			/* Non exact match to match F + L versions */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		}
 	},
 #endif
-- 
2.39.1

