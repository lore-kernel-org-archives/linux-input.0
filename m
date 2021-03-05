Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C11C433E0
	for <linux-input@archiver.kernel.org>; Fri,  5 Mar 2021 05:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF0465012
	for <linux-input@archiver.kernel.org>; Fri,  5 Mar 2021 05:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEFje (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Mar 2021 00:39:34 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:54592 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCEFje (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Mar 2021 00:39:34 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 Mar 2021 21:39:33 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Mar 2021 21:39:32 -0800
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Mar 2021 11:09:12 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 0BF083C33; Fri,  5 Mar 2021 11:09:10 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH 3/3] dt-bindings: input: pm8941-pwrkey: Add pmk8350 compatible strings
Date:   Fri,  5 Mar 2021 11:08:41 +0530
Message-Id: <1614922721-1390-4-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614922721-1390-1-git-send-email-skakit@codeaurora.org>
References: <1614922721-1390-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add power key and resin compatible strings for the PMK8350 PMIC.
These are needed to distinguish key PON_HLOS register differences
between PMK8350 and previous PMIC PON modules.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: satya priya <skakit@codeaurora.org>
---
 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
index 302866d..32ac762 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
@@ -15,6 +15,8 @@ properties:
     enum:
       - qcom,pm8941-pwrkey
       - qcom,pm8941-resin
+      - qcom,pmk8350-pwrkey
+      - qcom,pmk8350-resin
 
   interrupts:
     description: |
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

