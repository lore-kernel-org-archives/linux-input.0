Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B435E953;
	Mon,  7 Sep 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778227; cv=none; b=KKz44q4llK9tVR8qBzXkfYvjM2AqNZLvDKB+mc0vhV3k1dSLmKT3SFEnGxBi7F4LKHoQ++qy9cZd93yyTQwZ31ww7/GI0EfF8vj5jKPU83j/hxToKMAQHMEUe9JK0qwBIjrn0Tn4M7H0Tcdh8RQLvIjO6PLvvP4hV6tRYw6ff9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778227; c=relaxed/simple;
	bh=NnOq+xRUSpOQqEwshprztuziPWpVBsyCAlS5zdxPx2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+BuWYD/3PVEkMksmRNYP4z71XjX8t6voQ9NnBnq8rfFNnf+yMp8ho29MA6pYEaD66l4IPPeQESDczFKDlq6nYWhu/3C/D1tdAl0+8giYnP027mqfjGRvBbPe1wYvsqUeVzEuItZPI+yBG1wSxzai0I7a4BsMaXDzK7BLQifLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0lWlN25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0lWlN25"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18924C2BCFA;
	Mon,  7 Sep 2026 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788778227;
	bh=NnOq+xRUSpOQqEwshprztuziPWpVBsyCAlS5zdxPx2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q0lWlN25ZhfX7WjJBTu0Eeo4wcbF8hmc0CwooVuNdMcTMYkgyytCNX3VVQlfTog6a
	 K0X6NRMPg5I0ztsoZAfkHnIAoUbPBtHlIlMtegg3v7CAMEdCI9fgI5VGH3dVwlbF7D
	 iO5+kgOkFqbqT5KgfzxbHNhRDnsnp3hDLtoRjxbJTsGRTrBMzE171oVzv72bjnMs9q
	 5dw1vkjBpAiJBzRCWSbZMSWenS9YCDntB+2UP+yy38NPk1uZxtuifZDy2hXMmed89Q
	 pOERTNvEenGnjziD83gmnIuasfgUGpAfbXdnB4yJJB5q4ZwF5IiJ0hhOUAZZpkYOYF
	 FQ7grFkOGeevg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC5C79F9F;
	Mon,  7 Sep 2026 10:50:26 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 07 Sep 2026 12:50:20 +0200
Subject: [PATCH v7 2/4] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-stmfts5-v7-2-4a53381cd038@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
In-Reply-To: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pbzOh5CHeD/4F3W1fha7bB0ZUX+yDlqPPUvexzr6fCU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnpbwm/VbbsTyNpKmRD0XVO0hSRIGBkkoEdqGS
 hx0/PrIhyeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap6W8AAKCRBgAj/E00kg
 cqZkD/46SiFUpC0wzVRBwi3o7XmkKwjoNM/e0Pl71MYXsT7Sz4KcjSbWInFdzVuB+qStCyArjCV
 2xbcuQdJryEGmwvjFKeHLzFoNGypjI3osWN5wRYW4aUom3XYkIb4MnIoaQhowm6dYwH8nj+2cKv
 z1HIN4SAYpyjt8ljJfrBwxeJMm28Z7dzS5y3ugKgEhmvvoZnr3dBw+yE7w3EVVD1UTS3ZwMdZhY
 oFlEJHakJRHle4t+J6j49vyq2hSsy5cwxG7Lgc8hAY4I8eetgxJabttoYbUIC5RyeiuDRYOF5Xo
 g+E/OJ3pmRpTPwpHznj4JJSZZQ9UAu+hFHl1aH+J/K2AyUOVvL5uyuMuXy5zWqhCEfKOeEa3auZ
 uihV7fEUCkw/89syR3Rr6FAbtpVnp/J7Rn7jsd5c/PiWdQkkKi+TKCUgiFVdbTGiPdjxnoEBzIF
 IdZwAmi2F7eG2uucMbt+NQ4ZpP3hMvJ5h5oC3dRQoQabI/53Ml7d0h+88d5BVSmDRtQldKEPlRs
 O8F/tKzQvgY6XM5Gb6WEeu8HOa72GCEDfskDpjz3CxYpJLFv17l1mvepwnHGz5f/3+uLzr1ejKW
 yeSp2mhPOoXaRWD2kaOc/yAOgksbYS9FTgtj6C7tOKZnLocwhZKw//JtHftNDWmQy0mQGzI/caO
 SpXMCX2OvSVl9cw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Introduce more recent STM FTS5 touchscreen support.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/input/touchscreen/st,stmfts.yaml      | 29 ++++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
index 64c4f24ea3dd0..3de4bc5cd3f78 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
@@ -9,22 +9,21 @@ title: ST-Microelectronics FingerTip touchscreen controller
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The ST-Microelectronics FingerTip device provides a basic touchscreen
   functionality. Along with it the user can enable the touchkey which can work
   as a basic HOME and BACK key for phones.
 
-allOf:
-  - $ref: touchscreen.yaml#
-
 properties:
   compatible:
-    const: st,stmfts
+    enum:
+      - st,stmfts
+      - st,stmfts5
 
   reg:
     maxItems: 1
 
   avdd-supply:
     description: Analogic power supply
 
   interrupts:
@@ -35,42 +34,56 @@ properties:
 
   touch-key-connected:
     type: boolean
     description: The touchkey feature is connected
 
   vdd-supply:
     description: Power supply
 
+  mode-switch-gpios:
+    description: Optional switch between touchscreen SLPI and AP mode.
+    maxItems: 1
+
   reset-gpios:
     description: Reset GPIO (active-low)
     maxItems: 1
 
 required:
   - compatible
   - reg
   - avdd-supply
   - interrupts
   - vdd-supply
 
+allOf:
+  - $ref: touchscreen.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            const: st,stmfts5
+    then:
+      properties:
+        mode-switch-gpios: false
+
 unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
 
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
         touchscreen@49 {
             compatible = "st,stmfts";
             reg = <0x49>;
-            interrupt-parent = <&gpa1>;
-            interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-            touchscreen-size-x = <1599>;
-            touchscreen-size-y = <2559>;
+            interrupts-extended = <&gpa1 1 IRQ_TYPE_LEVEL_LOW>;
+            touchscreen-size-x = <1600>;
+            touchscreen-size-y = <2560>;
             touch-key-connected;
             avdd-supply = <&ldo30_reg>;
             vdd-supply = <&ldo31_reg>;
             ledvdd-supply = <&ldo33_reg>;
         };
     };

-- 
2.55.0


