Return-Path: <SRS0=X7PX=EE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A978C2D0A3
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87E920796
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ2RPk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:15:40 -0400
Received: from goliath.siemens.de ([192.35.17.28]:36929 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RPk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Oct 2020 13:15:40 -0400
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 09TH47WX011958
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 18:04:07 +0100
Received: from dev.vm7.ccp.siemens.com ([139.22.33.215])
        by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id 09TH47uD015940;
        Thu, 29 Oct 2020 18:04:07 +0100
Received: from mail2.siemens.de (localhost [127.0.0.1])
        by dev.vm7.ccp.siemens.com (Postfix) with ESMTP id D963270FF87;
        Thu, 29 Oct 2020 18:04:06 +0100 (CET)
From:   Andrej Valek <andrej.valek@siemens.com>
To:     nick@shmanahar.org, hadess@hadess.net, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrej Valek <andrej.valek@siemens.com>
Subject: [PATCH 2/3] dt-bindings: goodix
Date:   Thu, 29 Oct 2020 18:03:12 +0100
Message-Id: <20201029170313.25529-3-andrej.valek@siemens.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029170313.25529-1-andrej.valek@siemens.com>
References: <20201029170313.25529-1-andrej.valek@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add information about option how to disable FW loading for each boot.

Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index da5b0d87e16d0..e7d9404c86abf 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -53,6 +53,7 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-swapped-x-y: true
+  touchscreen-do-not-load-fw: false
 
 additionalProperties: false
 
-- 
2.20.1

