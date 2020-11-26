Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B695C64E75
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6852087C
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+JCQyhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbgKZNgU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbgKZNgT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Nov 2020 08:36:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99011C0617A7
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 05:36:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so2163133wmc.5
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJZuOyPoke9O1aNcUMwMh4SJuqZZoxbP5+ZVqt4w+RI=;
        b=X+JCQyhrfwOusPtMMbMFFQqy9G3DnrN0Apfg0toduxUQh7QrAPEpyOcrVwrW4GIGOf
         WZO3vAn7iAx/44TweVYH0J+J8iBHKESeAod+9TIG5Ol3Xr3Oey1B6tY21C5nhyjzJqEc
         GSRuryP7dGIjAzaTCsuaWDaDHUV8Px1plwRMkMwh6yZeI/EiLZ+rB1qVgPfozWIfdQ01
         WX5/+bkNu2JwnKYrQijfM/RKsGURD370CI+TpX3yb0nuCi5Z4HDdgFqeM8qRNbSc1W/I
         vSHpIUrn6C0LaCRUj3lhTFyTlm5r2Mby3uov+qbe4t8u3uK2krXnEC37R7SGeZ6L1UIP
         zoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJZuOyPoke9O1aNcUMwMh4SJuqZZoxbP5+ZVqt4w+RI=;
        b=KZbx6Xfb0QqSXYMutP0CXLOUO+TlvyqOq8JCUZzwCtBQgz0HFQok3cCauG2Su6oIf/
         aQcMjlXGMeMezOw/Tt7/HtUohyepxN23XmmWQRRFCLhti1pMEcQtEzyJcDZOSHK6a0Hm
         Y78ZGB/eTI8sTDUfyjUuc+8D8ET/O6ntl9pxwp9BtBEAaQz+w0nWaLOuVDdUj8CkOkxu
         Re6EYBtaocn7SZpL7jPqk038nQPLWsYuCMZEY1kqe6pft1ZM2SksY+kzmHblrrTvYvNd
         voXai+2ap/WO0QFs7mljzuM3PH8zMRlNhiZiiyuzLy0B64hYf7Wi2OlHviJFcdvDgtcw
         51jA==
X-Gm-Message-State: AOAM532UxhQCF0gQyWc55IY58r3i+gnOfWX4BNuFZuIOH7TL4zFkbtTV
        l06JMmAwBZguUuYG/fmLT8Y92rnq69wDM5L+
X-Google-Smtp-Source: ABdhPJxLtvF9xQt6Eye8xlahrZrJol0bdVI8FzxBdv1mrVpSPY40QBjsFnhs3BvAKDV65oEIj6UgcA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr3511199wmi.88.1606397778263;
        Thu, 26 Nov 2020 05:36:18 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id l3sm9056280wrr.89.2020.11.26.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:36:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] input: touchscreen: surface3_spi: Remove set but unused variable 'timestamp'
Date:   Thu, 26 Nov 2020 13:36:07 +0000
Message-Id: <20201126133607.3212484-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133607.3212484-1-lee.jones@linaro.org>
References: <20201126133607.3212484-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/surface3_spi.c: In function ‘surface3_spi_process_touch’:
 drivers/input/touchscreen/surface3_spi.c:97:6: warning: variable ‘timestamp’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/surface3_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index 731454599fcee..1da23e5585a0d 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -94,9 +94,7 @@ static void surface3_spi_report_touch(struct surface3_ts_data *ts_data,
 
 static void surface3_spi_process_touch(struct surface3_ts_data *ts_data, u8 *data)
 {
-	u16 timestamp;
 	unsigned int i;
-	timestamp = get_unaligned_le16(&data[15]);
 
 	for (i = 0; i < 13; i++) {
 		struct surface3_ts_data_finger *finger;
-- 
2.25.1

