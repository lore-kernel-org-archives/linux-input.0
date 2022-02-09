Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C33DC433F5
	for <linux-input@archiver.kernel.org>; Wed,  9 Feb 2022 00:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiBIApe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 8 Feb 2022 19:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiBIApd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Feb 2022 19:45:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B05C06157B;
        Tue,  8 Feb 2022 16:45:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i30so1365699pfk.8;
        Tue, 08 Feb 2022 16:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DZVh/N3QbZRm9DhcTCQab8GXfTQimnfiKDgzwLsBNU=;
        b=CWnYqVOGH2x1KQBjU1bF6IcAP9hIoQswcMOkRfxerNHyy5bVaxkup0fit/QRJw9Kvg
         EYTjRVwmzTXsJOZDu2xkGiezAp4meZuan7A6TC1jlv0QQa82mDw2bulMWft459yKSsLW
         YDQYoGxHA8GdqlEcOjerHkYv2Yv8QYaCVhoSMIcR43r9thRalo3ZRsCxy0YasTB3F6el
         rDqCcZgIzr8eRbGCAwH/rdgTmRbISEFkthNmC97Ng1r/n1/ADyGUpvCFpAz+79199+mk
         IwRGimCSV/Wa1J/BwNjZLPN4oK6DUkX4L6jt0w6oQ7+lbYScrvV/RbO23q3BmwLTFCvU
         +YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DZVh/N3QbZRm9DhcTCQab8GXfTQimnfiKDgzwLsBNU=;
        b=DYiWvt6GwECUHTO6LlYs/3GpRiYRvfVWDT8oM5tVscV1iGMssAd3bNit6pAKjHoaOd
         81RK9GwgY6xNBjt9B/Ebr6Mx+1DfXBcwbu5T80jrQDKDoGcOJvqZ6DyFd5PDlvgPgLf+
         HJihju2Ww518Bxc6GFsY1HojDRPZkwqsZHPzxir98aJh3gLMIaYfaFBBRLMeZOtVB3l6
         1Vc8m2KhyVdRClvQPzieMWkk9VURMC9xB1bednz6CyAZjYtDGhEzA/hSUnvVWS1cku5s
         H8sSx2gJ1Mnud/oqhizwIWrWmfS5U70vTCEGGgqFotQ1kS9v5DVbxP9rWYI3KpDB/V4i
         vFYA==
X-Gm-Message-State: AOAM533Qv5U3MHi02z1UhTmPy9xA7zh9j8RLfDPQiaJdq/GVPjYWDF2m
        y+N2Pey/Uqf81lRXbwRhuFk=
X-Google-Smtp-Source: ABdhPJxh2vJJjJtZRhTaTcyMu/WE50NXh6IQ5JI9R0o4ajiGaxrShq0Ar6+kiSDbsmbqZsF8vDH9iA==
X-Received: by 2002:a05:6a00:1acb:: with SMTP id f11mr6876757pfv.28.1644367531887;
        Tue, 08 Feb 2022 16:45:31 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id c11sm17391258pfv.76.2022.02.08.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:45:31 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     erazor_de@users.sourceforge.net
Cc:     davidcomponentone@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] hid: roccat-isku: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:45:19 +0800
Message-Id: <e409636333fd11c58847a86aa30239e7f71b2112.1644285832.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/hid/hid-roccat-isku.c:66:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/hid/hid-roccat-isku.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index e95d59cd8d07..d356a0ac770c 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -63,7 +63,7 @@ static ssize_t isku_sysfs_show_actual_profile(struct device *dev,
 {
 	struct isku_device *isku =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", isku->actual_profile);
+	return sysfs_emit(buf, "%d\n", isku->actual_profile);
 }
 
 static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
-- 
2.30.2

