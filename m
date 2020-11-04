Return-Path: <SRS0=fHkP=EK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2AAC388F9
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D01B2072E
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygYYu735"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgKDQYt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgKDQYs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2020 11:24:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BAC0613D4
        for <linux-input@vger.kernel.org>; Wed,  4 Nov 2020 08:24:48 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so2951729wmh.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2020 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LB9LqGfpy+30nABDjym4HdQWYW62bGrOr/5f5NXpmtI=;
        b=ygYYu735nXc5z/svx7/UBJe5GdmHVtu7p/5pU1OPA/+sz6DB1GdD4fHVZqKjjZ9ALo
         xQm0xlwMTbs2Rz1qZRX4Tv7FEACq2QRINXmcCIKv0neUELMOJ0UMAGvbeXBgn5gS1dXu
         oqhTcBQoB64cp9kYILgj/CarWEIq9BIZnYex/MPaxDfaeGG7snx6Gvfc9qmf3M/sir+l
         DO/+lfQxwCBD8f8W1MBfwxWmN6TRc6ibbTWBOf31jq5tpPhGw6yidxQCxb9LsDV1+K0T
         9llR5KHq1Wb8d7VG53DLwlo1zd+Cllmja8LXho054Uyukc5x297XpeQ6WTIZrXzn5A6e
         2bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LB9LqGfpy+30nABDjym4HdQWYW62bGrOr/5f5NXpmtI=;
        b=BW3f4oFpnhkxnD2Z81FLW1DP3DeZfI+Ev7o8ytkyIW79IAFnHyB01CENtvO6Zk8Wo3
         oInX1EJbNM5mS1vjlDooooeYjyhtadyrpPP9V5/lrCo26kgMqwYgQdpdsLyopC3RE7uF
         9bI2DLHjhf9z3qxhgzXHpJ9V5yF41NZ4Z05O55R2bb7O0shm5Y9IYA5y4QnNH0UXkOw9
         dWi1n79eU498WTMrym6hpi7vjkbcCzgelua4Itgu16QSFY4rMlghaITXB2+PctRWlk8C
         tpnms2/O2+TbSJCz+7tTvvRuTUT9vYYdP0ht5eioB/7fFFYwsND4W7OKPpOae7JEUFq0
         Mb8A==
X-Gm-Message-State: AOAM5303YWZWut1Pv8EA4hzj91ujt3J8dnDCA1cbthEb5K2R0minOFJb
        rCFr4lLZ42wOdLE6iqnoYLYMlQ==
X-Google-Smtp-Source: ABdhPJzw4O4khcPkEHvyp46qCx1iQxm2OTchT8Dp0VbG1IUwRFlpvz1kpFK3RPfxkVVS1nvphGFsQQ==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr5623109wmj.126.1604507086891;
        Wed, 04 Nov 2020 08:24:46 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sundar Iyer <sundar.iyer@stericsson.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 04/20] input: misc: ab8500-ponkey: Fix incorrect name in 'ab8500_ponkey' doc header
Date:   Wed,  4 Nov 2020 16:24:11 +0000
Message-Id: <20201104162427.2984742-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/misc/ab8500-ponkey.c:32: warning: Function parameter or member 'idev' not described in 'ab8500_ponkey'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index ea3b8292acdd5..a9b9013680d62 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -19,7 +19,7 @@
 
 /**
  * struct ab8500_ponkey - ab8500 ponkey information
- * @input_dev: pointer to input device
+ * @idev: pointer to input device
  * @ab8500: ab8500 parent
  * @irq_dbf: irq number for falling transition
  * @irq_dbr: irq number for rising transition
-- 
2.25.1

