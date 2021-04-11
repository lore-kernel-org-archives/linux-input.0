Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23FC433ED
	for <linux-input@archiver.kernel.org>; Sun, 11 Apr 2021 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DA1611C9
	for <linux-input@archiver.kernel.org>; Sun, 11 Apr 2021 15:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhDKPHy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPHx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Apr 2021 11:07:53 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D5C061574;
        Sun, 11 Apr 2021 08:07:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h3so5065240qvr.10;
        Sun, 11 Apr 2021 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jv3dHsWqn6+Uf6W69eH+Xrota24BdpgQVYuHIJN8/QM=;
        b=Kg6OUaAiG6gg4eY47sZDc+cJ9uBCBQHUhqlJUxBnSBauKplMUMo1VM12VOZUVro1Aj
         ihaU2yns/CJ2tGoQ9Ab9Tg64sG6SegotVWAZ7igED88K+RVmrL1APhpfgO5tS08t8+Xh
         hhUV0J5wT35C37x7fLTtnH7I59COfM1DGhs3PMos06j95sL3MmMfEp1M7f21PRRntyjC
         vxATBvJvYYhmt8GCquAmCRdxtJ10yd/mxmQSDYR7iOQrRZYBNY6kBhGm6Knw66pst4kg
         dVoKKozfKmzez6VDah0CKh+BX/ufbiUm9Btpb+85oTFIKL0JyP+qJ7tdeEV3SWXMk3Iz
         L0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jv3dHsWqn6+Uf6W69eH+Xrota24BdpgQVYuHIJN8/QM=;
        b=qE2ERXYec3B1ykc5csa2R3pMTEK1Nqc2gkcziUe4ol4EAzBrg8/A0Ia48RNZUDwfXJ
         P/+kGfnztXkwik9uy8oD9iQE2LxHDt/szBmGwN5GndSppb4c+lrMdirJtOi7853d5qJ4
         M+S1T9muIrcuWJrKg/OREkuYlSOuZJslXo0Qrf4KmdMS1yK3xbcfZysVQLmG99UsAT7f
         2ET8nbe8AmukUgrdeGTpYfs/J2ISc8wW80n8xuyBOa+uNUQWpm3CRPeEuIeIHnFXiNOz
         fCNJD5yah2v0w+jEcIFvd0VT6Ly1bupqzb4h0KCMwha8sFaL8LgOO5GlmhobQv8L7M97
         AUCw==
X-Gm-Message-State: AOAM531JglPHbdRjqYcFKwp679R26w2NQDeGwMwxU6u5Sr2tuvpFPUXq
        ghZ0l8GPElcwXynUZPkesQE=
X-Google-Smtp-Source: ABdhPJy3O03TxIhpLqTAE++Gw0NVWpxMCjrR9TgF73dcKJPM7EzA2QcYYUuFEq+dSZxLPBtiOVfQfQ==
X-Received: by 2002:ad4:5ec9:: with SMTP id jm9mr23563611qvb.24.1618153654964;
        Sun, 11 Apr 2021 08:07:34 -0700 (PDT)
Received: from localhost.localdomain ([181.115.133.133])
        by smtp.googlemail.com with ESMTPSA id h16sm6252895qkh.18.2021.04.11.08.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 08:07:34 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     jikos@kernel.org
Cc:     Henry Castro <hcvcastro@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hid: avoid invalid denominator
Date:   Sun, 11 Apr 2021 11:06:23 -0400
Message-Id: <20210411150623.8367-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Avoid a potential panic in case wrong denominator
is given.

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---
 drivers/hid/hid-sony.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 8319b0ce385a..67b45d82cc3b 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1134,11 +1134,16 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		 * Note: we swap numerator 'x' and 'numer' in mult_frac for
 		 *       precision reasons so we don't need 64-bit.
 		 */
-		int calib_data = mult_frac(calib->sens_numer,
-					   raw_data - calib->bias,
-					   calib->sens_denom);
+		if (calib->sens_denom != 0) {
+			int calib_data = mult_frac(calib->sens_numer,
+						   raw_data - calib->bias,
+						   calib->sens_denom);
+
+			input_report_abs(sc->sensor_dev, calib->abs_code, calib_data);
+		} else {
+			hid_warn(sc->hdev, "DualShock 4 parse report, avoid invalid denominator");
+		}
 
-		input_report_abs(sc->sensor_dev, calib->abs_code, calib_data);
 		offset += 2;
 	}
 	input_sync(sc->sensor_dev);
-- 
2.20.1

