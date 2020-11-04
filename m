Return-Path: <SRS0=fHkP=EK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4AC2D0A3
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7305A206D4
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3mrDnBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgKDQYy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKDQYw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2020 11:24:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC7C0613D4
        for <linux-input@vger.kernel.org>; Wed,  4 Nov 2020 08:24:50 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e2so2901171wme.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2020 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PA3FVb+J4SclMKAlYY0ZMYvDath2dI2KOPbq273rzfU=;
        b=h3mrDnBnxtdzKtq6qaH4Yz1GlgnTi+jA7inH14IUqkWjyA20QAPGpBiFc5cf9nym+c
         UKA2KLCEXqYJ+/I+mXu1z10VqS9jsWRdHfYMrB+XlRjv/TZ/maeIkMV3qMQiFzmqU6ow
         8XZlmBPWezi1G23RYmGrnMtlKHgFerW9GLD34mvRWQwUXNQ5UobzGUUzmsnLGp8itYZY
         h0iL1qsbz4OLNS4fmSrER/WH5x0DLsEG+6diVr4hIvo/+D26b67sBDojSRbCfd1o4p9q
         S5mjIwswjmXCigpggCkdguU0N+WfNIydyl12UiqtKt6MrbwKUTUP9BqQqOoMabm17Ffa
         ZrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PA3FVb+J4SclMKAlYY0ZMYvDath2dI2KOPbq273rzfU=;
        b=FJxykrIUUDcZ7XAgaAR5IopXQizgv3sRS5SmjFl++CEVQJmIjXIdvaV8E/SuFdM/+k
         HolOu4aXyNGJ3LjHrzaEdmEXz38WoXBIdUDwRNe8MkEW9AxvPv4vaGFataBpsH20bdyA
         Q5e/nwWSluE7uJj3AAiZ2m2DaKcmMPgXtxTdung3aCYd81gRZKWRH0Kl3lor6gE5fH6/
         UxVNdmLIjXzYu75p/FQhVPalymTPnhjDGGlTKCu3erNWtuPAtEXIOviwQKLf7UbhE3Wq
         vAo4mK4c3oJoleYOajclzIdBIKonL5NacgIUMrvP5kCrak3wVUnnzJHL3PG8eSwa1GC+
         /EfA==
X-Gm-Message-State: AOAM530xbCTlrRXLWnEIQbyS7+c55kSCvlP2ql4f9q0rTfM0HiO6SXAA
        51y1IEgzzEWCw28+iyBG49MiMw==
X-Google-Smtp-Source: ABdhPJzGkwC0/0zybFgME2vUtjZnUQpYba8BVXb2AQnp+5IpCvk1PI+MgzlLVHgipc70m2+Cb7ZTHw==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr5384063wmf.58.1604507089249;
        Wed, 04 Nov 2020 08:24:49 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dusonlin@emc.com.tw, KT Liao <kt.liao@emc.com.tw>,
        linux-input@vger.kernel.org
Subject: [PATCH 06/20] include: input: elan-i2c-ids: Mark 'elan_acpi_id' as __maybe_unused
Date:   Wed,  4 Nov 2020 16:24:13 +0000
Message-Id: <20201104162427.2984742-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Some drivers which include 'elan-i2c-ids.h' make use of
'elan_acpi_id', but not all do.  Tell the compiler that this is
expected behaviour.

Fixes the following W=1 kernel build warning(s):

 include/linux/input/elan-i2c-ids.h:26:36: warning: ‘elan_acpi_id’ defined but not used [-Wunused-const-variable=]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dusonlin@emc.com.tw
Cc: KT Liao <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/input/elan-i2c-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
index 520858d126808..b6976d99b6b75 100644
--- a/include/linux/input/elan-i2c-ids.h
+++ b/include/linux/input/elan-i2c-ids.h
@@ -23,7 +23,7 @@
 
 #include <linux/mod_devicetable.h>
 
-static const struct acpi_device_id elan_acpi_id[] = {
+static const struct acpi_device_id __maybe_unused elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
-- 
2.25.1

