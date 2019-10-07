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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41DCC47404
	for <linux-input@archiver.kernel.org>; Mon,  7 Oct 2019 12:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD121655
	for <linux-input@archiver.kernel.org>; Mon,  7 Oct 2019 12:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T82xhtxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfJGMPx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:15:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36777 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMPx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2019 08:15:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so12317574qkc.3
        for <linux-input@vger.kernel.org>; Mon, 07 Oct 2019 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=emvcjo6PHktSR/F/QBOVnbRk0xibN3cUFxOu/jIV7wk=;
        b=T82xhtxyY1SQBIj/0bzolQMjMPAvX4LvckysglPtiLcYzgmpFY3ano4WZmhWuFghb9
         Kl8yHoqWkQqCgqAQunTAmf/zoeKCALkxCBERp8cps+FrQddDZGhgJtbJSk52vQ2SyeG7
         oKFFZIt2UA+ULw9HokdsPobrcK8ZsxacQEryCAkAiLhm6bcaAdpDtuLPqWFThbbEgEIH
         gF6Rz/hbfn0SdaxGnJkvYNV9PiZ2OIGBQDPbKfVIi1FB88igOw5fvsxI3pqhduAEDhmJ
         vB1Io5gEbVXt71ZR8KeZ4JLNOz229f0g6GgzPtBYEdQez4c7cBd1Upe8BYTkKh+0iEa7
         bVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=emvcjo6PHktSR/F/QBOVnbRk0xibN3cUFxOu/jIV7wk=;
        b=FkrZcCRuO04+t4+9zsCLYP/uTtnl0pLRsF40WajShalOGw3A+neTIdp8DUbKkzbiDA
         E0nzXm/o8FXQA0nEmCRJek9SIQ9vLvpNol/hGpfs7vMAbyDItgvjJAu2qN4Em2xbueVU
         v69CaXWrmOxPYbsweGx70QxSVhLIBeeh3i1X25573PL1Wf62sZW85psptTi5/YoKiIB/
         CyajzLDA4/mvPKbX7wCDf+U4F9cU8t1QmsRnIQevJztc+RcNgPND8h8c/E270nJ9Tppt
         m0myEHtW+Nor64u/sPq1UQRnB2v3VDln5VJzyEmXPYsSxk3LqOYN1LG1IWK6Bps15OAf
         HjdQ==
X-Gm-Message-State: APjAAAVshgdZCosOZK29IL6bPCWtp1XtB7tzcf2oHeYy3oy6qgDyppMP
        pArggfdvmqogmfVUp4qyqh4=
X-Google-Smtp-Source: APXvYqwDAeBhrf4qhYKUjc+NRrkO1wf+2ERaTPxK/7EIhTrV8f3caIOCd8xOPG4gsT7Zr8ff0/Yadg==
X-Received: by 2002:a05:620a:798:: with SMTP id 24mr22592334qka.238.1570450552290;
        Mon, 07 Oct 2019 05:15:52 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id g194sm8221678qke.46.2019.10.07.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 05:15:51 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, jcbian@pixcir.com.cn, rogerq@ti.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/5] Input: pixcir_i2c_ts - Keep header files sorted
Date:   Mon,  7 Oct 2019 09:16:05 -0300
Message-Id: <20191007121607.12545-3-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007121607.12545-1-festevam@gmail.com>
References: <20191007121607.12545-1-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Keep the header files in alphabetical order to keep it
more organized.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index efe5f1e86ef1..af2336da6954 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -5,17 +5,17 @@
  * Copyright (C) 2010-2011 Pixcir, Inc.
  */
 
+#include <asm/unaligned.h>
 #include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
-#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/of_device.h>
-#include <asm/unaligned.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
 
-- 
2.17.1

