Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8E3EC81A;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116675; cv=none; b=YHdonp8MjEfjWLpQQthCt5IL8rI8E+SxUhpGOzgDD7DUwMuAdiVikvBXR/eWqc4m7R7BarKyAphhDFHmtmpQ1POGOZIAMeqVi9F1hj3iT6AHQoa0E0fr4yTKNo7j2hcD9k0ANHtTJRF9f1jvey4Pwaz5I11iTOmP1UDkw0x5owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116675; c=relaxed/simple;
	bh=6Om9mmFoyilZ7jFsN4qGp2OOoGqOwvUDJXp2zNRLp+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrdjMdR+UAJ6YV/yBss6quQQfC8Aw5lz1oZlayVWxlRi+5c5RIC3+ubsUd0AbOhe7+WhMbJ/DRy3a9RtntVnthhYT4KX0mQ9znKu3Wo3+ZyWUdM6HyuLo+UMy8qJOlu10bF53onpw/wJtv9sBeiZZqK2M6AcXHoJp0igJDsNJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgx9aTYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgx9aTYx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC14AC2BCB8;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789116674;
	bh=6Om9mmFoyilZ7jFsN4qGp2OOoGqOwvUDJXp2zNRLp+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jgx9aTYxluCSss6dcTipeMEk/+ocQA1Zq0771VYQvCRm73K9nAs0Ps/PJIbYnqYPA
	 mglS23depKXOCYFG+3BF01q9dsvXh3Pa9Px9qDDnhsLjrLddm4bWiM7CxR5dcCNAha
	 R8W9ADEtAtAw5iUBIaCSQT9C8SGklEbElTi/AihGD2cBqyGwbvs0lS3k/M/ZPI7fa6
	 e2F5jxt3KHRnOwsDLg5u7OSOZf5zk4W+OguddhjAJUh34vvr61G52W/4njH9xuhMd7
	 rEj8Zj5AnjN7u3szNHU8AvBQP7WZmsdQozby4Qhj3rjUYIBuHdhuK5wA0nO83sN0qQ
	 JFrPY1GixpzkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50F5C88E56;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?= <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:51:02 +0300
Subject: [PATCH RFC 05/10] dt-bindings: input: touchscreen: add Novatek
 NT36672A SPI touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-5-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
In-Reply-To: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=2624;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=sMolpDLxRIIdnSgm3TbA2Rk80AV3J5bHq36firTsw6w=;
 b=IdFFml977ayIZ6L6YdvcMn4Ol1XAEqjQLb7pnMby8TGCu+zLBKLhmg7UlQUs5xSnl1+k1kmsw
 r7mj8P4/nAhDtshh4wuZCFJWI/hbuWGi9O8ZA3vRaQCfKB7kgS2ehfe
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Reply-To: kavakliyigitcan@gmail.com

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

Add devicetree binding documentation for the Novatek NT36672A SPI
touchscreen controller.

The binding supports standard SPI peripheral properties, interrupt
configuration, the optional 'panel' phandle for DRM panel follower
synchronization, and an optional 'firmware-name' property.

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 .../input/touchscreen/novatek,nt36672a-spi.yaml    | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/novatek,nt36672a-spi.yaml b/Documentation/devicetree/bindings/input/touchscreen/novatek,nt36672a-spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0d89d60f2a93d26e2f7903371ecc6eb9ed683b33
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/novatek,nt36672a-spi.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/novatek,nt36672a-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36672A SPI Touchscreen Controller
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  The Novatek NT36672A TDDI controller is connected over SPI for touchscreen
+  interaction, with host-downloaded firmware into controller SRAM. It integrates
+  with the display panel lifecycle using the DRM panel follower API.
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - novatek,nt36672a-spi
+      - novatek,nt36672a-ts
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  panel:
+    description: phandle of the display panel that this touchscreen follows.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  firmware-name:
+    description: Name of the firmware file to load into controller SRAM.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "novatek,nt36672a-spi";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            interrupts = <88 IRQ_TYPE_EDGE_RISING>;
+            panel = <&panel>;
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2340>;
+        };
+    };
+...

-- 
2.47.3


