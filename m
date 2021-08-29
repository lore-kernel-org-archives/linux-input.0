Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01795C4320E
	for <linux-input@archiver.kernel.org>; Sun, 29 Aug 2021 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF99860F38
	for <linux-input@archiver.kernel.org>; Sun, 29 Aug 2021 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhH2JUh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 29 Aug 2021 05:20:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45769 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234584AbhH2JUh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 29 Aug 2021 05:20:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4C540580B0E;
        Sun, 29 Aug 2021 05:19:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 29 Aug 2021 05:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=32Umrmr7bVOCf
        HszrT7/dKCGNVfpwUR3PiX2IsuXkD0=; b=oKaIEvcX/D5L7ukZRUGEqzIiG2K1G
        CdMHbFlteAvUYrPh3J9v2YyP4yF/uLRpU0h+/vgVpM28v9R8zqJGz2SmpxSOP5sC
        T9+V1h3mJBoNfLWvNqmAX7JPDifpGZH3TdUVV4gv+LvtodMgD4Mq+6YnB2eUSqmR
        +FrAIy9op3F9+afVz8Tv9qa5zDSeUUbSqtxEcYq0YeUcv0oeEors08LUv1QzCcT5
        GCAibOLd45MAP2ygSCmCqHg/xaLA3h3p9Iotcw8UsAGMaOurxpFPEujhAPjGqRl4
        UDVGroQtIL2OXP7bKvuEIEtmpYoCOyYtzgP2ZQVSmVOdCHt1JlmQpdWUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=32Umrmr7bVOCfHszrT7/dKCGNVfpwUR3PiX2IsuXkD0=; b=LVjX/cRm
        VoOH29x6JCD82rcSBG5VL/PC5XwpvLoqMMNlnReD0efW3vsiez3ae+yMHDXkjSUt
        RxcPmANMBBQPREbAVOWsJQPlcO8ClfepJZ3SGJbvh1Ad4owFr5wjkLBOpyY0Azf5
        bl5PKsZmJbRm3t69usmoyVIHO1+bQ9JcIR9vzzihv33hOi6lvSjmumVOERESp/iD
        mS7JE+RKv8vqjbizHqdhOcfgv7JIt5pkhCT1I/0Opt48pdGNWaiG8dIuMU8mY8hx
        BQxl5AH8HXWojF0n+Gho5gb9E70z2lPAidGVNedSNZD6YAB/ta/4TDnH75ztMhd/
        w7GfkKZCZ52dHQ==
X-ME-Sender: <xms:MFErYWLqfnuBYz3obx4gEQQ3GWlEUkCvna6S5bYZeOe3EcVZsHDDlA>
    <xme:MFErYeLz6_F4XJubj7nDN7txPund1mC7ybCwk-p7bwf9bOxvm0ykZLH7ckNOFrFao
    RAkJqXlwp6k_6vyanc>
X-ME-Received: <xmr:MFErYWs7TMbqHfqccjShVM64bSRSSPisyFjVc5m9W0xk5Gqsyt-74s8QitQp_H7XqSjUJcu46SAeF-j3CmwWMtFsczHj6lA93UJqHKolLdbaWUfIng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddujedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepgeegtdetjeekgeeguefgheeuvedugedvteejveeiudeg
    vddtkeffkeehtdetudfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:MFErYbbaXsFvMooDZSDOCeSgijiJ2NRWKHYhZ_bUA8j_A5vpLemrkA>
    <xmx:MFErYdZn7j2LPJBmAvHOfjc9yRqir7hXgoqpLDIFl1sLZqWJrN6JAg>
    <xmx:MFErYXAW-11qs4VI5hG-RJq1SQLq12xnvZpAiTLeIIL3K6HqOD9MMQ>
    <xmx:MVErYRT5QEDt6V2l8tO-RqPjxHiB_cDCzZRYpLFcGoecX5mYcUzswQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Aug 2021 05:19:40 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, pinglinux@gmail.com,
        tatsunosuke.tobita@wacom.com, junkpainting@gmail.com,
        ping.cheng@wacom.com
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 01/12] dt-bindings: Add Wacom to vendor bindings
Date:   Sun, 29 Aug 2021 19:19:13 +1000
Message-Id: <20210829091925.190-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210829091925.190-1-alistair@alistair23.me>
References: <20210829091925.190-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4dfaae537daf..31745c45dd92 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1252,6 +1252,8 @@ patternProperties:
     description: Vision Optical Technology Co., Ltd.
   "^vxt,.*":
     description: VXT Ltd
+  "^wacom,.*":
+    description: Wacom Co., Ltd
   "^wand,.*":
     description: Wandbord (Technexion)
   "^waveshare,.*":
-- 
2.31.1

