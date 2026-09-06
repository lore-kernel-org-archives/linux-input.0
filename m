Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58518C02E;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712434; cv=none; b=kXQ1hdQcwlzNgf/Wcn0ipRRwvbRGC8WY/Rl7B80Np6f/+fcMVO+v5dG3WIEwDaPyV06jAcr4xv54Jm2LApN8PBEx18Yo9JgE58TJOiWW8CM0bwJ0EysxyMdkqD4StUrxoJb1cOUZbZg9UjTsfqcKITczbiBA5Qb9S4PQoGfAP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712434; c=relaxed/simple;
	bh=NnOq+xRUSpOQqEwshprztuziPWpVBsyCAlS5zdxPx2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZAiEaj67w/AD5oLWkGfGgFsITGyosL/aKIvqShKb9WE0Nktkz0SLgCykIaMpm6576FYyCjKjIwgyM1H6TggImZeWChkSEp5Bzbj1X3K0nnO2syHHYBGbDi7eh9Vf1DL0sp65aUOUlW2l8fAndJuqZeb/pxXBkpyLwgLy92z07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnl8zsL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnl8zsL/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F3A1C2BCFB;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788712434;
	bh=NnOq+xRUSpOQqEwshprztuziPWpVBsyCAlS5zdxPx2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bnl8zsL/JyT/dgcCAq8LTdnrWW1o2J3TusKDfzsmt8x6BIgBFDjiKHEX9udLTrt3Z
	 0NulHgLX9seBNcpW5jAZoo7BjgDvFPjz8yCNeflKhAuzZNdy3dAqV16DA283RTVr8+
	 2ra8ZyBtXgweRj4tfWL6vjn5B8h3T5th610XlillOnPQ/VMhpaUHkcsd2HZv5BG2qJ
	 n+cvAM2gwy/DYeQpPG6hpXpntgKIYjSwg/hjDCf9eXA4U84qz8QWjjR1wYMsVddvpk
	 7fJAjqITAxjvCpnynVeYs9zY3+JowlAniKBmk6Nb2RA30RCg14t0qSO1WZV7VMI49w
	 UozsEVCQ8yZWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F754C79F8C;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 06 Sep 2026 18:33:49 +0200
Subject: [PATCH v6 1/3] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-stmfts5-v6-1-50fbf6af8718@ixit.cz>
References: <20260906-stmfts5-v6-0-50fbf6af8718@ixit.cz>
In-Reply-To: <20260906-stmfts5-v6-0-50fbf6af8718@ixit.cz>
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
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnZXwUAH+eKJkEZ1gLvyh6j1bO8MilyV+1mlSi
 jqW94afWTKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap2V8AAKCRBgAj/E00kg
 cjbBD/wPVJGY3JAGm5ebpcqA9d684JGdvBJdssDoNdmrCAMzePqjUYW8aQ/QPphJIBvA0izatL0
 kcsZ0R2O2cKTzTh67UPJRzDfFaaEst0DAPgJCUqgBEJhKJYhss2CEoBAw4W+BRAID9pSUlsMF3w
 UNEqhgeISyabwcD34X0zkWpnEueat04hV1NzSOSXfrdwevFr/H+bfgxs+fmcXjI3wfnQaPwo4Tw
 uQfsbpHD1VPay2Z6q6ySoQSRCSRGsft8bvREW8aDYAN1vM4MhA9wvV6fNDHmOheUgGOdUtpHDue
 boadbhrEOQiq4m0oNMZV+/2UOt+9cABQVhIMM855QbHdGKB4FNxrkWMZ1GrRh9D8LhB/WAjI0E0
 4t6a1A3G2S6VZfcgfWAbxf0xijIyO1N7LOPGVXc3CeGPuKJLr6Ql2KYvCq/DKG0B61BohGbz05Z
 Zdbx2fmYrPSg1fFwihVr8Uz1XsoOj2gpInbITn4zYTiZ1MT+3t+8MVDaJME6Xi5fHItTGXMNvvH
 UL8CfHl0hX6IZrwQQ7rlLgW3mlQ/ols6FXsg65z3VIZsmUvhgGQJQUqpqzMMl3TjSxeXQfjEMZK
 wChMhWRpXIO+UPO9hth8JmppjiDjmf+uDyCNPGAEUNgIiZfxpo/E9JUFajxacfH3AEKKU28CgZQ
 zQWs7SeVTnMrUvA==
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


