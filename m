Return-Path: <SRS0=NW9P=5M=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E9C2D0E8
	for <linux-input@archiver.kernel.org>; Fri, 27 Mar 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAF9206E6
	for <linux-input@archiver.kernel.org>; Fri, 27 Mar 2020 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1PbCIaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0TWx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:22:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44036 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0TWx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Mar 2020 15:22:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so12020575qkc.11;
        Fri, 27 Mar 2020 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fLcUsacfDBKV0iW3Bh4PyEHk/cSwX5W93uAaRngz2gI=;
        b=f1PbCIaWNfInXvRFU/K5RmZtcKF82wR1MrpJibTzo5m+oVFCP4FmrZPumSRXi4C5Th
         ycqtZZgJGGmk7n+BOThbEsJxssAsyOPAvSlcVFfsntNhkjYd56Rs0enaKEDlWPM0n6eJ
         K6fxrsxj9n4VHDNcES/uvIrbu98NJfxaPk7gptSZRUamCA0Nqk//GS57fvRboP9OcoWt
         uBFQ+19nvvhUvyAUQnLuPbM0msZAD4KZmLud1tGcfU5yS6Sm9nIrDIDtWu06yW4GE/Nm
         EEDzpbFDDthxRV4jDcY+t/mhRgcJ2p5708JI2V3ozLRlCJvKTwL3aoKjs0A4xP6C+Iu7
         DRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fLcUsacfDBKV0iW3Bh4PyEHk/cSwX5W93uAaRngz2gI=;
        b=FkD72b45IP6tWQaqnHBF4S3ljfIlXfMSjqg32+nNyMBFdW8007BCtNHqsPtg73eJKJ
         RwIeMAQ3+9CQ2pSoIuCKS2jcIH/LX5yQa2vAv/eDHc80993flBJMZCO250YWVPHX0IeG
         OEDWv/RVExxTsZUR/Itno4PwQJvbj5mBK9M8irGbVVll8tBBqOGUwRuxtmR1F3LEb0EC
         KlDPoZlcoQ5uJIOwfTjLsjNWzTJIF6HEuCwvXOVNnUAPW/vMUxR/ia7TlHSO27UQnNZN
         xpIGKJURMkokf+/y78T4IBYCH4x4w3ENBb1myM+tMxCbTfjmEa/ELRQJczSHQbsr57HS
         2pfg==
X-Gm-Message-State: ANhLgQ3Qa2B3Oeq0bs9F/4VS6HLIzmWYnHMjIbixz0E3BnE0xQwq50En
        YEdcReI3rThbnWBR+mIKCf4=
X-Google-Smtp-Source: ADFU+vu7DVALwAAXBvXkP810Yy1CDJC0JZ2taerSBpqFOP4wlm3KeiUTAFlbRX11fIneW6SpcPgMrw==
X-Received: by 2002:a37:a854:: with SMTP id r81mr916290qke.384.1585336971766;
        Fri, 27 Mar 2020 12:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:5bb::4])
        by smtp.gmail.com with ESMTPSA id l188sm4220385qkc.106.2020.03.27.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:22:50 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, benjamin.gaignard@st.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: touchscreen: edt-ft5x06: Remove unneeded I2C unit name
Date:   Fri, 27 Mar 2020 16:22:40 -0300
Message-Id: <20200327192240.10458-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The following warnings are seen with 'make dt_binding_check':

Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dts:19.22-30.11: Warning (unit_address_vs_reg): /example-0/i2c@00000000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.example.dts:19.22-30.11: Warning (unit_address_format): /example-0/i2c@00000000: unit name should not have leading 0s

Fix it by removing the unneeded i2c unit name.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 8d58709d4b47..383d64a91854 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -109,7 +109,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    i2c@00000000 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
       edt-ft5x06@38 {
-- 
2.17.1

