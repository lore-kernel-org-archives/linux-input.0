Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E504434984;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116675; cv=none; b=FujaL1EeHqPtO6LrVeADNV+LWcAFaT+Zxahf32vb4Gkh86mmiK3v2ik+sgQnpNgQAk7PCDbCSVxv5/pJk9U5p88IM38FudoTqsxdkLoSvuxt+7g+XDH0JuDWZaApNxR075Ong5/jYxH6bHFny1uFZ0kcvywzRN8KqO20zWyIrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116675; c=relaxed/simple;
	bh=07d8wKscWXVq7RDJjHkW9XddOX815xGvrx1VHtKkGvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMxKuesPyy1a3/zHEAdAfs44OWPrXQaVtwDMlo58D/TzOUyU/ETSRXJuW7xmHluYjGalrv6JJ3d4GiqHyr8RST1efz0H1/IOoyWZJhrcx+iZtLCY5cL1Rwmqpu8KqvA2QIl4UxOqGoGh1hZkoRiLEDSIjB1kVWn41Ffft9DKWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF5ylQ+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF5ylQ+2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92810C2BCF5;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789116674;
	bh=07d8wKscWXVq7RDJjHkW9XddOX815xGvrx1VHtKkGvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VF5ylQ+2c/h0Bl+82CoyVZ2QgmKthihLuNpr9gwMdtAbDCuGWaVgpWEuLrmAYyh5f
	 y9PaJRwNV9by3p9x8fFUfOcl4+y5PmZYaBD8129bZ68ekJ3G3Ev2aWTXxhi+kLNu41
	 8i9bS0sbHnJB9DuBetPM1iwV7w3SlA94CBS4H89x+B/GLWYSrWWx8pjAkK/Dx6o41B
	 A3Qw925Xux6my/4yptEPZrfgkoKs4AVR4ePz47rVhLbSpIJG/G08Uy0HlAkbWpPfH3
	 M+y3tTG1wwhtwR0TI61JLI85jAyFhqI0HGlzdStWHPrGrHxmFcw05lmWhF1FKIIDPj
	 tld0n7NfQE68Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC6C88E50;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?= <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:50:58 +0300
Subject: [PATCH RFC 01/10] dt-bindings: backlight: add Kinetic KTD3136
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-1-0e68e63a18d4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=2380;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=1qOWka2RqpGg1tbdhR9VbVnp2Dr9kAnrMfXquGM3d6U=;
 b=tPsC38NGiMj10cf2MHZTTpvh8GU5kjYbScAMNbDcYn3V2e+KSk4lCvwoX6GGsgBKF0/jvxY1j
 92U/sQgU3zNC9FOygauFmLnU35Ax7LZfLjiF0lcSDwfW4mxZjFKgCHj
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Reply-To: kavakliyigitcan@gmail.com

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

Add devicetree binding documentation for the Kinetic Technologies
KTD3136 3-channel LED backlight driver using the official "kinetic"
vendor prefix.

The device is controlled over I2C and supports an optional hardware
enable GPIO line (enable-gpios), supply regulators, and standard
backlight brightness range properties.

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 .../bindings/leds/backlight/kinetic,ktd3136.yaml   | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3136.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3136.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f85381c29964529a09989a1ff60d9c9fe4897bb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3136.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd3136.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTD3136 3-Channel LED Backlight Driver
+
+maintainers:
+  - Lee Jones <lee@kernel.org>
+
+description: |
+  The Kinetic Technologies KTD3136 is a high efficiency, 3-channel LED
+  backlight driver with 11-bit exponential or linear dimming control
+  via I2C interface.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktd3136
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the HWEN (Chip Enable) pin.
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator providing power to the VIN pin.
+
+  default-brightness:
+    minimum: 0
+    maximum: 2047
+    default: 2047
+
+  max-brightness:
+    minimum: 0
+    maximum: 2047
+    default: 2047
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@36 {
+            compatible = "kinetic,ktd3136";
+            reg = <0x36>;
+            enable-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+            default-brightness = <2047>;
+            max-brightness = <2047>;
+        };
+    };

-- 
2.47.3


