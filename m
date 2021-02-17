Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C3C433E0
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38FB64E4B
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 17:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhBQRf6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234534AbhBQRdz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Feb 2021 12:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613583149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Umkkn1s1heqSfUE9bVr0PbKoq2Y4J9beIKh4Qxtjpc=;
        b=PHxaH8e7HvD98+H8MIqVGZjoV4dppJNf+tuIvELpksjWJloU3g4tGNfbb/yfE4O7IT9CqE
        +jxI6OKCBLYTi2hnfFifBbsWn1TNR6ImyP6MDXEe1mK0tHVtgvRa2OsvFxFz+VvOdKSEZr
        SEJ7WSWTAx4f06w959+MeKpXz2v5ZU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-hK0Mxl0YOCSg5UbiiPDWOA-1; Wed, 17 Feb 2021 12:32:27 -0500
X-MC-Unique: hK0Mxl0YOCSg5UbiiPDWOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91F91020C21;
        Wed, 17 Feb 2021 17:32:25 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23DCD60C62;
        Wed, 17 Feb 2021 17:32:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 08/11] HID: playstation: fix unused variable in ps_battery_get_property.
Date:   Wed, 17 Feb 2021 18:31:55 +0100
Message-Id: <20210217173158.3122868-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20210217173158.3122868-1-benjamin.tissoires@redhat.com>
References: <20210217173158.3122868-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The ret variable in ps_battery_get_property is set in an error path,
but never actually returned. Change the function to return ret.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-playstation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 84f484fce1ee..f279064e74a5 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -333,7 +333,7 @@ static int ps_battery_get_property(struct power_supply *psy,
 	uint8_t battery_capacity;
 	int battery_status;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	battery_capacity = dev->battery_capacity;
@@ -358,7 +358,7 @@ static int ps_battery_get_property(struct power_supply *psy,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ps_device_register_battery(struct ps_device *dev)
-- 
2.29.2

