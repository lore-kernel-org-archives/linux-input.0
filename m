Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3630EF97;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712434; cv=none; b=ccMdbKCAzLzvsq+QNVWavSiPlXe67+E28a/C3SxnhOUWAAGA30nPcU0nYk0xzXe6At0BTWwEyFOpM9rdjG78D4Tu7ZbODXMN2VJ2j4fKiM/OwuFD7gK8reavwZMvI5seZX+gGELSvtHa+Ujt7aMqYoi/jvY1o6ZYxie7DRcFXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712434; c=relaxed/simple;
	bh=GTKCuKerEVjbEq+ru51jw6Xl/RomTGKgH6W2wG3Nmm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCC+Wcm8J18W1mDQxkZtoUUmbwUZ2UGm3impPZNthL8iSsDtcxG/gq0dq+gK55to9cF+xxCtsvIeP8uS7ofarsLeTthj/JJ2koAOtKntWrdr9T2q2CD7+hyMByCQobSbNEP3POlGA23ITgAuUb2CcOnHmrGnSub0CcMqZvz6t1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoQ3oFPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoQ3oFPw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5044CC2BD00;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788712434;
	bh=GTKCuKerEVjbEq+ru51jw6Xl/RomTGKgH6W2wG3Nmm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZoQ3oFPwoNw9uiHW4BQLLbE0rsLeOl+zQrlsWmeTLmFUmw5bTA5YftJ7/wmZkATZ0
	 +3Eblv5JM3tmGohRuKIUizIiW2ezU2SBilw6UF8u6JC0UjWtJzsl3fm08mWvcQL8m2
	 HH4VTacIb/JQjMh2o3/9Ps4e4ex6+hgMLaIzNXIBOBsmWPz5kolfMyRByQJBzQ0S72
	 4x546Q70u51aIdYefGVpNanY7QF6oUkb8xcCnoTILbiQ7WvmFKk8dOCVBn8AL3hRfb
	 1YljXUEWNOE1VV2plxetkZ4Kr1VaPj9Zv2RuG3GX5dI1CzlkmBmOOHSG/bd37Eg27K
	 Jd1zZH/X1rDyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C51C79F85;
	Sun,  6 Sep 2026 16:33:54 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 06 Sep 2026 18:33:51 +0200
Subject: [PATCH v6 3/3] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-stmfts5-v6-3-50fbf6af8718@ixit.cz>
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
 David Heidelberg <david@ixit.cz>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=UYybbePhFZQL67dBaI7ZZMSBOFWG/ciE0qllsHbgzEk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnZXweyV+w1DXqt1mMsyGPwwNYULoSaJ+5XDXl
 CX8VS1RRnGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap2V8AAKCRBgAj/E00kg
 cpbAD/4+PL3GBlMtZ7FWZ6NoUDM1965ux0TqDTVHiZv91Sn09Lfqy5NPwLsgc6dqt6JeE+fJeRP
 LsJPNGteE0kWPSAUYJ0cYsz76ikj3NLYY7x1oQgSp/ASmFlw455D7GNY4Aae/ifQoBA4EivZA4r
 ecKs6GlKv1xvYhCQxH6DN6ILzIrn6IfhRAAWJ3ROJzyj4xwGh9Jw5kTenCqE9KPma7Qj6D6MLim
 ZAaLBZg8hYEpFVE3N5iNyDkRFZF70fOcQ3azh05Q1EbOoL5L+1yx9ZXPOmKHt70LnkDb/GlK3in
 WzjITu4HA9hcKRMEC63JiHdIQikf+1mDlBgutJ+MKqrMldLZMlxJa3pmTNL+dULO2+vZz84Iozu
 qfTX38VRKYpScCUH6kdugXYZ/3g/5dU81fTEkhNiV/9cGwukoX37K923zBL/RUf5UqbdfEXvSRL
 lLYP4oT9Y8Jn6xnpAN7vcclCH5ZtuCpQwbqHQbIPo/6SD+mnl2IdT76JpviKzmMMjPTIBvgCAC7
 wWYzxK0rw6sNTGMOWRrhZoGY0p2pqYl9zbqUR2Pbha94ICczVNxXdKrkFq6WcRk3vrexqi7TZv/
 dC8nZ4CYwvy4m5etjLAmmJLWH/XqmsOLuUdUfbOUj22VgN6y/chZUchbRs8XO1HcWIRlxwRgAg7
 qYGgCrzDVyhH4IA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Petr Hodina <petr.hodina@protonmail.com>

Basic touchscreen connected to second i2c bus.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 19 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi  |  2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
index fa89be500fb85..51c835dca43f1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
@@ -21,17 +21,34 @@ &framebuffer0 {
 	stride = <(1080 * 4)>;
 };
 
 &i2c2 {
 	clock-frequency = <1000000>;
 
 	status = "okay";
 
-	/* ST,FTS @ 49 */
+	touchscreen@49 {
+		compatible = "st,stmfts5";
+		reg = <0x49>;
+
+		pinctrl-0 = <&touchscreen_irq_n>, <&touchscreen_reset>;
+		pinctrl-names = "default";
+
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
+
+		mode-switch-gpios = <&tlmm 136 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l19a_3p3>;
+		vdd-supply = <&vreg_l14a_1p8>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2160>;
+	};
 };
 
 &mdss_dsi0 {
 	vdda-supply = <&vdda_mipi_dsi0_1p2>;
 
 	status = "okay";
 
 	panel@0 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index 9e952f9862f24..c9db3ea50f5ed 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -492,17 +492,17 @@ nfc_enable_default: nfc-enable-default-state {
 
 	touchscreen_reset: ts-reset-state {
 		pins = "gpio99";
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
 	};
 
-	touchscreen_pins: ts-pins-gpio-state {
+	touchscreen_irq_n: ts-irq-n-gpio-state {
 		pins = "gpio125";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
 	touchscreen_i2c_pins: qup-i2c2-gpio-state {
 		pins = "gpio27", "gpio28";

-- 
2.55.0


