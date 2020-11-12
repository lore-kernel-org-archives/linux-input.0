Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4963C55ABD
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0AF22201
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 11:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SObc/VTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKLLF0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 12 Nov 2020 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgKLLCQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BEDC0617A6
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2020 03:02:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so5918586wmg.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2020 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWLlC6ktlLXwXUeWXx8bHoPHYfcR3KsyU0jvMMlPcPs=;
        b=SObc/VTeOY+p3UM45yQu+wx/n3vgLtnbs9/szCWi/Uvo6w0HOls+v+TDcCpiyOdtjC
         P3KGg0WoiPwPeYRB0YFAgeyLc0PHY9HMa4GQKPdksXYiNyoBz/ky+mK+k4bw3yjZixIu
         pYo5hFOvjY2WbyYn0McFr1GmUahWvP/q4wVCEtfYVpe+rbnZB6hperaWhadArmTxgwyp
         n0vDXHjgwqjaPxVewspdN+8qb7FEvKMwxUMUhwMbricwRpPHRawwjoSHoyi/tX+wcOKT
         L2omsdN7pcDaFR/6bivTcwDg+VgOBMSqtLus+U42ROhy2NIWfZtIT73pidnvJMktxlOd
         YUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWLlC6ktlLXwXUeWXx8bHoPHYfcR3KsyU0jvMMlPcPs=;
        b=IKMGeQJYG1KtRtMAXkZopY2HAV1TKiMEhmj2Q+Z4tusv4dE/v54E4xaLq1CxWY/1rg
         XtY8JeoVpXDPSF5AqqBuW8PG0mM1sEqF3SSTk4dupxl7bDl+d8XDpMHX3eHj0tb/zUzX
         2JTUhY/TzJLX8klrmP0dwHifWs2Ff38CE7pfNbENurpz3wf2h9xZVHB7F+5WJ6lUU6ps
         mYY5Bj4G0rsOTjpLHg4Yj5gDL/QLrWqSfiG214J1+pAiKfsEWnIQdXdW26A8LzZP2e6W
         0GL6JjVlyypWg06hZXy911k72nWGkzuwk8z3k3AErQdt1sztW2+odd+cK4TKzotzHqsX
         aJew==
X-Gm-Message-State: AOAM532u3XjwmkFPR8A4dzrY2uFAT1uQo3NS+ox5QIHvq//K2/mk1si+
        Evx+GGXlQsGn2IKEggd+j75bRQ==
X-Google-Smtp-Source: ABdhPJyDMS/KEjghxHHrXH5jorlSclEwYy5ef65oQXyCr7uZP+ZLYdL0R90cHziJKqAjJY5MN+NP/Q==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr9137231wmc.103.1605178934689;
        Thu, 12 Nov 2020 03:02:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 05/15] input: touchscreen: imx6ul_tsc: Remove set but unused variable 'value'
Date:   Thu, 12 Nov 2020 11:01:54 +0000
Message-Id: <20201112110204.2083435-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/imx6ul_tsc.c: In function ‘adc_irq_fn’:
 drivers/input/touchscreen/imx6ul_tsc.c:307:6: warning: variable ‘value’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Haibo Chen <haibo.chen@freescale.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index cd369f9ac5e60..e1852f7d4d31e 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -304,11 +304,10 @@ static irqreturn_t adc_irq_fn(int irq, void *dev_id)
 {
 	struct imx6ul_tsc *tsc = dev_id;
 	u32 coco;
-	u32 value;
 
 	coco = readl(tsc->adc_regs + REG_ADC_HS);
 	if (coco & 0x01) {
-		value = readl(tsc->adc_regs + REG_ADC_R0);
+		readl(tsc->adc_regs + REG_ADC_R0);
 		complete(&tsc->completion);
 	}
 
-- 
2.25.1

