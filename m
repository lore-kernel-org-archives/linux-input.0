Return-Path: <SRS0=lJJv=5K=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AADC54FD0
	for <linux-input@archiver.kernel.org>; Wed, 25 Mar 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05216207FC
	for <linux-input@archiver.kernel.org>; Wed, 25 Mar 2020 13:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgCYNfO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:35:14 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:53177 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgCYNfN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Mar 2020 09:35:13 -0400
IronPort-SDR: uJ54B6VET4J0aExDf3W4gUUPpIHwyhO/yK2A2Ou/4WqH3kxU3y/at5pie+oLQJs4FEhTdI6kov
 N0XSxrEkNwNw0euji6aSi04nejg1K/xHNk5xJkflzCKBgovURJlxBwfnyi90CgCQ7dduZp0Z0H
 pDMMQ3fZm8P0a2f90M+J7dEfl7e3D12viUN9oPFthIlQ+E3CbIVT5kP3A3hrRkWws/r0VQwlm4
 H9kxeEuwSlroSaTZySL4ID6I1i8mlIJBj/67znGkJRLj3AVlj0J6PN1xEy2WZaQMAp8lb40J5c
 yow=
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="47099706"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 25 Mar 2020 05:35:12 -0800
IronPort-SDR: PzApt4fKg84Um2DlnGFtM4M1fVGucDVQwby7JMDdotAOid2ZhrDyeIUu6HYiY3Ws8qJPRqrWRe
 0uF3JPw1hafHx0dkmPNQ/+Gk+f0rfev1Q9YpJ+LacdzDxztRIKwF614pMMQOizZfUGUd8XX082
 89yZ7QnkpgJ49DLmPGNGY+YwvppveFjRFQ4lhBZLLxIxpmRRs3bgtUCD6xp5sKD3d0/rFne8k9
 zQdMMY7XPpkts/QYCqU3wMlXHHohN6JI+/XnY0bWCIAtm9aM8Gfp7/C/wmyXmmAuqL2mxJEyeX
 AYY=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <bsz@semihalf.com>, <rydberg@bitmath.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v9 23/55] dt-bindings: input: atmel: support to specify input name
Date:   Wed, 25 Mar 2020 06:33:02 -0700
Message-ID: <20200325133334.19346-24-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325133334.19346-1-jiada_wang@mentor.com>
References: <20200325133334.19346-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Support to specify input name

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 713ce870805c..d7db16920083 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -40,6 +40,8 @@ Optional properties for main touchpad device:
 - atmel,cfg_name: Provide name of configuration file in OBP_RAW format. This
     will be downloaded from the firmware loader on probe to the device.
 
+- atmel,input_name: Override name of input device from the default.
+
 Example:
 
 	touch@4b {
-- 
2.17.1

