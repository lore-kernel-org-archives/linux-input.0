Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB9C43616
	for <linux-input@archiver.kernel.org>; Mon, 10 May 2021 07:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC0861409
	for <linux-input@archiver.kernel.org>; Mon, 10 May 2021 07:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEJHDL (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 10 May 2021 03:03:11 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2227 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhEJHDK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 May 2021 03:03:10 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2021 00:02:05 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 May 2021 00:02:03 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 May 2021 12:31:20 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id A26F84B46; Mon, 10 May 2021 12:31:19 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V3 2/5] dt-bindings: input: pm8941-pwrkey: add pmk8350 compatible strings
Date:   Mon, 10 May 2021 12:31:01 +0530
Message-Id: <1620630064-16354-3-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

Add power key and resin compatible strings for the PMK8350 PMIC.
These are needed to distinguish key PON_HLOS register differences
between PMK8350 and previous PMIC PON modules.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: satya priya <skakit@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Chnages in V2:
 - Moved this patch before the conversion patches.

Changes in V3:
 - No changes.

 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
index 34ab576..6cd08bc 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
+++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
@@ -8,6 +8,8 @@ PROPERTIES
 	Definition: must be one of:
 		    "qcom,pm8941-pwrkey"
 		    "qcom,pm8941-resin"
+		    "qcom,pmk8350-pwrkey"
+		    "qcom,pmk8350-resin"
 
 - reg:
 	Usage: required
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

