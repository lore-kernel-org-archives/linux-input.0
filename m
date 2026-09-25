Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB34FC8C9;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371343; cv=none; b=gWcPSHCEUCCTgnqnub4l92X6qCzPdb3f/Wsjgds9EJNLvLRj7xMaBac8ylZpRmlVoJSexKXXLY4gzQ76vc7vtLSHU+z8Jr/rNnoC42c3fT1gOwJnT0pv7sXp3ca1v3y1mpq3xZaO9P3ZAeWzu8gZStZOO43baSCHBiHwE+4SRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371343; c=relaxed/simple;
	bh=GoyLU2U3ppXbJU9VRV2KKSjfBJtgMQqJ586u/SdHnow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+sS3DMMCBidmIGSMvDCmHHLptdwReTbnqA95zWZRtnB9MFXSiYAPYObUFZkHbN/ziqpJLVEHHy7qMUNtdJDyJR/ae01Y9YQvUBqCzHKbUtNcRITKSmdEH+a43QNZ5/ytRX5KU5EKncgx0CzxcDeJplrAj/A67MR5JH8y7MUdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6Tt6HN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6Tt6HN6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE091C2BCF5;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790371342;
	bh=GoyLU2U3ppXbJU9VRV2KKSjfBJtgMQqJ586u/SdHnow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E6Tt6HN6dDVsoSQ9s7/R/C5uG/20efuDuoui5xfBmxKuopsKOVMSW7o3Ea0GnFS8d
	 nrHGiplAi1QJXgizemJPopFXCSunX9eLLks43SWZE3vRTlFisTFroOVRCdeups6YAe
	 psFQscgHyCv2cgs2VdZsCF6buhzmuLabB5BZHxlj9TOsQ6Z7VI1OX2jQmn79cs0uGZ
	 nh7HJwRLNENR+7L98lhnts1SJNC9hrAXTT9WUdq/BaGgxxg9zVrAyKz6dVbRWOl8ZV
	 NBZ3sKBWQ582ZApTvxm7h4gmQ4OmI00T3zXUN6EcOCfkhAZS20egjx9dndVcLvkiXi
	 HQESCYtEuJMXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC45C9830E;
	Fri, 25 Sep 2026 21:22:22 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 25 Sep 2026 23:22:20 +0200
Subject: [PATCH v8 2/5] dt-bindings: input: touchscreen: st,stmfts: Improve
 example
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-stmfts5-v8-2-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
In-Reply-To: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=8hrNriBZ9r5NUpjg2ye3gjvx8mrHqp+97D+QCG0V3A8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtuYMItkEShhRrfUYkEQkLKY95RkKZ9aBK821r
 KzsaRioKoeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarbmDAAKCRBgAj/E00kg
 cgUwD/0fup7gi4EPXq8XUj2gTbqngr8fFCroIEUBSk69EYJYBEP3euvVnv7BWAb1FueivXZz8Qy
 VcRY+on9bUdVD28j9oP8q3bYjsQwtlI4CkBJYYPxRqT0kdkLWlfyWWWqFR6d6IcB2kdzeuuGnYd
 zTsdPPhrNH2D61G35Z5ajlLItQ1asun/oSGNOZNlMdFwSD7JGxidOVWh19i3Bgx6/8vyWpZO3s2
 OmESlUJIexP0O4l19baYbTmUb08kbQONDEvDJBPBz74fcb/aPG0uOhzpczCT3r65QLUkCxncM2a
 xYMYoqHN61vTJrWl8W4hCFswqPPG3Yf7VNDoXL3AHpjqDpNo40DdHY+YbdcFkUWHKJhNTzgegiB
 ftN0w+ZnWgZZsiRqyUmK6hMRkKyKRU1ifRGU10K4rjq3kby5BXjtyGPKf3CrEz8BlKgx29ZaOz8
 hoPrmMzkk/dxle3kgDwwlAP1dEzVhe5va21gj2EX1UIVWUcyu0mz2nboz4sx+9NtG94PRav5btm
 XgNlDQjkoGyBLkQTMUUVw+7EkTAJiW7FcmXyyhgAUeaaMUI90AY3d+lKYsRfNyuGST3cdWXxqtA
 q9TAzHZVMhNhKIa7qJai5FkT9o9H8FJ0BWN2TpK0syQqrWLorz8sg0HdydidnDnbG/tB349J6/b
 zgKF1caJjGptipw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The touchscreen-size-{x,y} is exact number, the -1 deduction is done on
driver side.

Example now use interrupts-extended and size obviously not deducted by
one.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
index 64c4f24ea3dd0..6eb1ad6582d82 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
@@ -59,18 +59,17 @@ examples:
 
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


