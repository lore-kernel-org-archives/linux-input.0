Return-Path: <SRS0=XHg4=DC=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79755C4363D
	for <linux-input@archiver.kernel.org>; Fri, 25 Sep 2020 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC620878
	for <linux-input@archiver.kernel.org>; Fri, 25 Sep 2020 13:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgIYNxH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:53:07 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:19050 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYNxH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Sep 2020 09:53:07 -0400
IronPort-SDR: Ib11UUXgMzKcf10oq3K1LQyVSn/Ud+ySbANNUVY8v4zFgGupRHyze439QwHmHzr7w3psU8sH+K
 E4VB/22g1lCz7r0q+htEq67WjU1z/uJGVTYRGxc7624b4FgwMJkpZ7BZJiVFq1GSKt6S9P+ur/
 kXUuKDFc07+vuy0bK1IuU9GB3+8+GPuDRza4LUks+47A83/uB8KymASeVt06DwucvMZd07xh4X
 h7pRR+VVxFRIu4tcovkVjWL9fMeNRk+LnPnkZzQr46eANlvnbYtKH0xUdFHRjVzEqNBXoACXqW
 /Ww=
X-IronPort-AV: E=Sophos;i="5.77,302,1596528000"; 
   d="scan'208";a="53316554"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 25 Sep 2020 05:53:06 -0800
IronPort-SDR: baxa69GpiJejL5AeAXFUJgNvpL+kSYoF2AwIXyBLvFd///es4tpwU5uL5TYsmtncWZYY0YYdwn
 R5sB7aJatjep+CKwQKNkrZ2fRKMPg3bLKmZJsaGwxWBeFFe9J/vl5t503wSmfTkZUc6drGbBH3
 qon65RakRdZRV4V+AcQPjNWmOYcz/Hvai2nyJX7mceApHhCsx44OR5Zia4xGSwGbSYrfptEw4z
 iQk1FbVt5u9hfkFlLUdA0oYTEj3go+lgEi+KqRxLzCWk2Obl60OgFj2NCCqKO6r0GxgZ7L9o+D
 Q58=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <nick@shmanahar.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <andrew_gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v2 1/3] dt-bindings: input: atmel: add compatible for mXT1386
Date:   Fri, 25 Sep 2020 22:52:55 +0900
Message-ID: <20200925135257.21138-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925135257.21138-1-jiada_wang@mentor.com>
References: <20200925135257.21138-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Document the mXT1386 compatible string.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index c88919480d37..c13fc0f3f00b 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -3,6 +3,7 @@ Atmel maXTouch touchscreen/touchpad
 Required properties:
 - compatible:
     atmel,maxtouch
+    atmel,mXT1386
 
     The following compatibles have been used in various products but are
     deprecated:
-- 
2.17.1

