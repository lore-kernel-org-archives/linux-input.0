Return-Path: <SRS0=MgpI=DP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD209C43457
	for <linux-input@archiver.kernel.org>; Thu,  8 Oct 2020 18:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E592222D
	for <linux-input@archiver.kernel.org>; Thu,  8 Oct 2020 18:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msr9Ebwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJHSPZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJHSPX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2020 14:15:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C7C061755;
        Thu,  8 Oct 2020 11:15:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 13so7429433wmf.0;
        Thu, 08 Oct 2020 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGK0y4DdjN+ht1VXSEDsJItbDCIWKoPEWxNpiJk8/U4=;
        b=Msr9Ebwl0LoHzyi9woB78a84we1B3agBKl73dC6ioLmbR2GFv/EN5WlSiM+Of3o+Am
         qTGNIbZEEJExIrFjSV4F6z+2cEFuvL6kjfGtlY7l1RwaQx7rLBbVBVlKypRnEr4lRBMg
         njutfSu4ijclq2czEA7SK6Epnh/Pq3AsYI+APDHtsHDVoRimN6PeJSeshl+USYlXoQ3a
         GQiAiYmsoN/xhh7LLQSFNnUm5vBRoxYupBZ93mM5RoLj3VJ91DfvzaWHudia9/Rgt7ME
         1SmdzGiuQVnzFRW4H+MK35q7kkFJ6CHl0V2NBL8j5TX894q5PI36I7KFFALRlhj42vHy
         JFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGK0y4DdjN+ht1VXSEDsJItbDCIWKoPEWxNpiJk8/U4=;
        b=TvIoIPidg/aMt0bgNo3EHie5U+PS3ljMh2lmczmrkf3CN0Gim6txTd8JuFSdBsXdhE
         Ad3imqlBpRM39tzyG8qic2NoGEeLYDUgRf7lIbXRfEiC2phpmrvnHk67ShzbrV/KKlwH
         QUfb1za8yvOhEpmau61TR7HcA42q4GkBPRa97TO8mLjCNQb8b49p0RfKeBiexnkGjhND
         /r/9x2VENim1xSQyOpZ//3Sf7ZEVU+uMmpykvEANvJTgpQ0pYiNTGZNgonVo5NHs5kJX
         dvHmczamPPZunMIAvZqEdQtHy6MSv/qDgZMkbBu+4nKZ8mCqE27/9rhdGYzNYuTyqRi5
         iLEQ==
X-Gm-Message-State: AOAM530a4gCA2OQ6sXL5v5EVjddq/f8yNHqOITa8fJ8zjKhSgK/Zkaoe
        mPOL1c1IJ8GgF80iaQOUMiQ=
X-Google-Smtp-Source: ABdhPJw4aAAW7j+Um8By8g1PaZRZywWiwO1RaF7QPo1EFcJxEktRF9k+OGv2ZPLJEkP/b8PpUnBerA==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr10231568wmf.172.1602180920156;
        Thu, 08 Oct 2020 11:15:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id e7sm8897285wrm.6.2020.10.08.11.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 11:15:19 -0700 (PDT)
From:   kholk11@gmail.com
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, rydberg@bitmath.org, priv.luk@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Novatek Microelectronics Corp.
Date:   Thu,  8 Oct 2020 20:15:12 +0200
Message-Id: <20201008181514.668548-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008181514.668548-1-kholk11@gmail.com>
References: <20201008181514.668548-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Add prefix for Novatek Microelectronics Corp.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66e45112a8d7..f98ea0af487d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -740,6 +740,8 @@ patternProperties:
     description: Nokia
   "^nordic,.*":
     description: Nordic Semiconductor
+  "^novatek,.*":
+    description: Novatek Microelectronics Corp.
   "^novtech,.*":
     description: NovTech, Inc.
   "^nutsboard,.*":
-- 
2.28.0

