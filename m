Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB21C4742C
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DADC20791
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 01:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CT6dNV+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgKLBeN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgKLAnl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Nov 2020 19:43:41 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3FCC061A4C
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2020 16:41:45 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q5so2882774pfk.6
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2020 16:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWB6g7SgUuqbksYreAE2hvC6FZMTkuUHQsnGWriw73M=;
        b=CT6dNV+TWZZNUscLwC6dmB5ywU+BaFJQKP7WJw3hJFcnFMEikPzugFMiwB/iH5Wlz+
         8bEJo8l+ztT0EllDbM8H+5EQNnyZS9Fbrjm38V/uMij8/MuNAWGwxlkOJfuFo6gypiHx
         zq9RMncewywXY+N1e8k66hCS3ihonZOc0wfOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWB6g7SgUuqbksYreAE2hvC6FZMTkuUHQsnGWriw73M=;
        b=MD5392ZReUUF5ilFSX2ikXOwsOjTGjOSzmc5TObf6sYv1n/lvjt8GNu/YZGxllaGtX
         IF+UEb+y8P38rtbShawnhjhfA1wqthm/ak3iFTGaEkPfFkWkpuX5fUUS4o9EwXxVxMxN
         Oa6I4u1F2NpwSKlykF20785wpRuSKD2liRBiQQqC1YKcjWVKBtAh2Hn9++Sa1B3KEIGn
         kPWGvn7hdJ/UC1q06aZ5U4eWH5dSuEQLcCUJd53QH2BSA1ix2RLnnEObP89KEHF+KlUe
         FqRQtslnji/flNstRXI28idMguo5gtPN916u1JKhgWlenN2eGm2KZofFkskma4qJRila
         m69A==
X-Gm-Message-State: AOAM532Uik6lyVGqqBfUUBJpoHCZXi+FBl2r4nlfDs3//AOjMelvQmhf
        cDICR9AyP2mXFr5qNul5Hao/XA==
X-Google-Smtp-Source: ABdhPJwCNok+Lsh0ja3mTOu/Ky1lelVUsm/3MjwYBjN4SKOcugRW/jjW5QUZJgDXu5ShZPXd6OTJrg==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr6402941pjb.174.1605141704660;
        Wed, 11 Nov 2020 16:41:44 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id t26sm4265522pfl.72.2020.11.11.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:41:44 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     andrea@borgia.bo.it, robh+dt@kernel.org,
        kai.heng.feng@canonical.com, swboyd@chromium.org,
        linux-input@vger.kernel.org, hdegoede@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix GT7375P
Date:   Wed, 11 Nov 2020 16:41:29 -0800
Message-Id: <20201111164027.v6.3.Ibb28033c81d87fcc13a6ba28c6ea7ac154d65f93@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112004130.17290-1-dianders@chromium.org>
References: <20201112004130.17290-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This adds new bindings for the Goodix GT7375P touchscreen.  While this
touchscreen's communications are based on the generic "i2c-over-hid"
protocol, it needs special power sequencing and thus gets its own
compatible and bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v5)

Changes in v5:
- Added mention of i2c-hid in the yaml itself as per Rob.
- Adjusted subject as per Rob.

Changes in v3:
- Fixed compatible in example.
- Removed Benjamin as a maintainer.
- Updated description.

Changes in v2:
- ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.

 .../bindings/input/goodix,gt7375p.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
new file mode 100644
index 000000000000..fe1c5016f7f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/goodix,gt7375p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix GT7375P touchscreen
+
+maintainers:
+  - Douglas Anderson <dianders@chromium.org>
+
+description:
+  Supports the Goodix GT7375P touchscreen.
+  This touchscreen uses the i2c-hid protocol but has some non-standard
+  power sequencing required.
+
+properties:
+  compatible:
+    items:
+      - const: goodix,gt7375p
+
+  reg:
+    enum:
+      - 0x5d
+      - 0x14
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    true
+
+  vdd-supply:
+    description: The 3.3V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ap_ts: touchscreen@5d {
+        compatible = "goodix,gt7375p";
+        reg = <0x5d>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pp3300_ts>;
+      };
+    };
-- 
2.29.2.222.g5d2a92d10f8-goog

