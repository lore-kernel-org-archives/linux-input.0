Return-Path: <SRS0=orFy=YA=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB9C47404
	for <linux-input@archiver.kernel.org>; Mon,  7 Oct 2019 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6220867
	for <linux-input@archiver.kernel.org>; Mon,  7 Oct 2019 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVfcgQjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfJGMPr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:15:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41215 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMPr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2019 08:15:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so1765663qtm.8
        for <linux-input@vger.kernel.org>; Mon, 07 Oct 2019 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zb2XL7Vyg4IB6+EsLyBQSY5RUnZ7G3E/z3E+QL6u9ug=;
        b=jVfcgQjmMtiXfRkrWXdhND+e9KTWWP4vpp20Ew6dTJDU2zr7xpkj0TIhpkwmc0NorE
         HR4j4RBUYP+L3PCi1lgE01Yvo8YtuGL7AO6GLBwJOSRQKH1dg+kmvd3YNZ8JSz+YHda8
         aXXX+RN7yaS9lazxUmsE0rMpCmRKfsyvEDY4XUn9gnCnwvQi6YmWy/BVVwrOdk6pwN1c
         4P4zdpR2CZFTRttelyV3YOxg3brLCRpfbYKcH7nHLbkTOKYq5AygpgSB0ORRJhsb7jIy
         TbCQc5uVyXgqiF8YlMWtl6v9ct7lqi/2ZlSqGDoiHmxfyuEknksHksNkfWfXQgwzgctq
         AEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zb2XL7Vyg4IB6+EsLyBQSY5RUnZ7G3E/z3E+QL6u9ug=;
        b=lXApoRD1ERFER8j49wGXTT+9u4rnQKSjdhPoXJWwIZjM2JtHsZSE+9pPIGkt6qpRVK
         ADRznSamJ3sCoypJU8ZRhp4pp2PLs4jHQYtrWA84UwmNdQrA0CNrh/H5xyf1bYXfLrfH
         7Bo7ag7NN3QL58bWsjYkQ0rMe1KU4VdUEj+3zQATeEyOCFh68GGiyQjnqWupKlxVDyHe
         nKRkFOnM/6gLyVev5DtndPPIU5gkZoAersG0WK9iqmWu4/46SZiOVtwckSU32QhS3hCo
         XWQ5UuHnJcygEMNgSximT0GSxnV4fmRr8E33n2RVD+m70Pgrs97/ZqpDLneDwKNtyiVu
         xikQ==
X-Gm-Message-State: APjAAAWW9x1XbrgA1l+SPp6qeTw+Ur06zrut89a/LgtjqNFtwn9xBREb
        ElWPadSDfr/JTk6u2R/J2R6QRRXd
X-Google-Smtp-Source: APXvYqzS7QqD+cS47Pq173ZvHx+KGjzTO1Bhif6WSBkTjC3GL338H7lIwnsi8UebxlDPrtBQ4/sQgQ==
X-Received: by 2002:a0c:e481:: with SMTP id n1mr27162374qvl.83.1570450546473;
        Mon, 07 Oct 2019 05:15:46 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id g194sm8221678qke.46.2019.10.07.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 05:15:45 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, jcbian@pixcir.com.cn, rogerq@ti.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/5] Input: pixcir_i2c_ts - Remove unneeded gpio.h header file
Date:   Mon,  7 Oct 2019 09:16:03 -0300
Message-Id: <20191007121607.12545-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The touchscreen device is a GPIO consumer, not a GPIO controller,
so there is no need to include <linux/gpio.h>.

Remove the unneeded header file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index e146dfa257b1..4561d65e7a1e 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -13,7 +13,6 @@
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/pixcir_i2c_ts.h>
-- 
2.17.1

