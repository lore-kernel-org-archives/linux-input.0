Return-Path: <SRS0=gGDZ=EM=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A190C55178
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A75206DC
	for <linux-input@archiver.kernel.org>; Fri,  6 Nov 2020 10:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgKFKMg (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:12:36 -0500
Received: from david.siemens.de ([192.35.17.14]:52798 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgKFKMf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Nov 2020 05:12:35 -0500
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0A6ACI6L009417
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 11:12:18 +0100
Received: from dev.vm7.ccp.siemens.com ([139.22.40.104])
        by mail2.siemens.de (8.15.2/8.15.2) with ESMTP id 0A6ACHFg009304;
        Fri, 6 Nov 2020 11:12:17 +0100
Received: from dev.vm7.ccp.siemens.com (localhost [127.0.0.1])
        by dev.vm7.ccp.siemens.com (Postfix) with ESMTP id 27CC970FF89;
        Fri,  6 Nov 2020 11:06:56 +0100 (CET)
From:   Andrej Valek <andrej.valek@siemens.com>
To:     robh@kernel.org, nick@shmanahar.org, hadess@hadess.net,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrej Valek <andrej.valek@siemens.com>
Subject: [PATCH v2 2/3] dt-bindings: goodix
Date:   Fri,  6 Nov 2020 11:05:38 +0100
Message-Id: <20201106100539.6646-3-andrej.valek@siemens.com>
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
 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index e7d9404c86ab..8b0fa25ae96e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -53,7 +53,7 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-swapped-x-y: true
-  touchscreen-do-not-load-fw: false
+  goodix-do-not-load-fw: false
 
 additionalProperties: false
 
-- 
2.20.1

