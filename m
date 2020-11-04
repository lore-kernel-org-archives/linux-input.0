Return-Path: <SRS0=fHkP=EK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B20C4742C
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A91A206A5
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr1VrvM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgKDQZz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgKDQZD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2020 11:25:03 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C961C061A4A
        for <linux-input@vger.kernel.org>; Wed,  4 Nov 2020 08:25:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so22744624wrm.4
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2020 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upETjiEPBAeYXJaDapQnz8RTaIUvobSDgtGDF4HQ8C4=;
        b=Wr1VrvM29yIcMiycLDDk50Vjw0jKq/vpiQh5ADfzp3wkEnC6Y7VqHn5MvUQQWlcoCM
         xxBaZpIlakYPU2h5u6qS7bReTt7UJVeMCBP9fMs3f1Q5zkpMw2gCxsIqqmNz9MzBBvwT
         MinQcwv7J/3tybf+gufIF+/77sfs6L5YtbrTw8TviyVXy7/zXk8B+dmCcs9IXyzLtU4P
         br8bofp41oUg+oGnQNlbdLQaVpu1aidRsUmHOcXcHp30ag7/6XLaeMK/VCCkVp2eBHnn
         N5+A4cMELZCbpNPEmtVgPBNOyMLyGExtwyumqlgjOMphImk6RN+4Q19NCtKvGbF1qCJc
         QNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upETjiEPBAeYXJaDapQnz8RTaIUvobSDgtGDF4HQ8C4=;
        b=lXxeqwrL6JTV5RYu/7EyAsBuwtYXl7U76QexdlrO6dPsDZYsUmMsp3uHRRoPcotzz5
         D+zoUlZV2lspkTCq22t2aNJbZhQrLu+LwbwB+rdzNX+sQJwHZexrFImzkXdcHQUjKSsQ
         MPC0lRdJme7WtmK3l64LeiVOsxf+wyrbq+9e1MTHQCXCzXioi62jHHNWm9UhEyEyTPFM
         hz3ebxnjg7VeojPXoj+pk2sZgkgTftCOqjiBf6GX8N0fcYoLY7LpqzGQKEV+e25ofBHD
         vHfn92wuHE/jCSOveNMDj9C74GoUYbv2/TBxzhFOfpOhD0jlycBoWdPWmEDfOh7EdZjM
         TvmA==
X-Gm-Message-State: AOAM533/vanSUPUTH78GY/vEWCCgxPC4s14vHPBLObKVeGWSo04hI+op
        6K3k8ArvxhzcbLtwF8GVhNG2yQ==
X-Google-Smtp-Source: ABdhPJzMUHJTxNM97Uu4GmPbwhCG+T4iv6uaRjx8TRLWALfVEZSpGRW/Yi9M8aDD+SY+aRUPVpI08g==
X-Received: by 2002:adf:f841:: with SMTP id d1mr33437900wrq.297.1604507101738;
        Wed, 04 Nov 2020 08:25:01 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org
Subject: [PATCH 16/20] input: misc: drv260x: Fix kernel-doc formatting and remove one abuse
Date:   Wed,  4 Nov 2020 16:24:23 +0000
Message-Id: <20201104162427.2984742-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'input_dev' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'client' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regmap' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'work' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'enable_gpio' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'regulator' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'magnitude' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'mode' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'library' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'rated_voltage' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:194: warning: Function parameter or member 'overdrive_voltage' not described in 'drv260x_data'
 drivers/input/misc/drv260x.c:244: warning: Function parameter or member 'voltage' not described in 'drv260x_calculate_voltage'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/drv260x.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 79d7fa710a714..fabe106d499d4 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -167,17 +167,17 @@
 
 /**
  * struct drv260x_data -
- * @input_dev - Pointer to the input device
- * @client - Pointer to the I2C client
- * @regmap - Register map of the device
- * @work - Work item used to off load the enable/disable of the vibration
- * @enable_gpio - Pointer to the gpio used for enable/disabling
- * @regulator - Pointer to the regulator for the IC
- * @magnitude - Magnitude of the vibration event
- * @mode - The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
- * @library - The vibration library to be used
- * @rated_voltage - The rated_voltage of the actuator
- * @overdriver_voltage - The over drive voltage of the actuator
+ * @input_dev: Pointer to the input device
+ * @client: Pointer to the I2C client
+ * @regmap: Register map of the device
+ * @work: Work item used to off load the enable/disable of the vibration
+ * @enable_gpio: Pointer to the gpio used for enable/disabling
+ * @regulator: Pointer to the regulator for the IC
+ * @magnitude: Magnitude of the vibration event
+ * @mode: The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
+ * @library: The vibration library to be used
+ * @rated_voltage: The rated_voltage of the actuator
+ * @overdriver_voltage: The over drive voltage of the actuator
 **/
 struct drv260x_data {
 	struct input_dev *input_dev;
@@ -234,12 +234,12 @@ static const struct reg_default drv260x_reg_defs[] = {
 #define DRV260X_DEF_RATED_VOLT		0x90
 #define DRV260X_DEF_OD_CLAMP_VOLT	0x90
 
-/**
+/*
  * Rated and Overdriver Voltages:
  * Calculated using the formula r = v * 255 / 5.6
  * where r is what will be written to the register
  * and v is the rated or overdriver voltage of the actuator
- **/
+ */
 static int drv260x_calculate_voltage(unsigned int voltage)
 {
 	return (voltage * 255 / 5600);
-- 
2.25.1

