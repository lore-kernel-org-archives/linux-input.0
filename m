Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38824679C;
	Mon,  7 Sep 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778227; cv=none; b=g8Tw4+4FxFgBEOB0q1bdzoqv/OUV/fBHLlilb1wdE1pBN8zNe4TYijmVVW4DdAb27Lt+v8RrHZLTKn4drFCYgVqFGz2fPWdrInDZcmpLoQ3DXIcT8fqKB5+ElU7Fshp4rrv4YyFxepz4DhcxBJOkc/3Dpx5tfNBU3Y7HehC0UUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778227; c=relaxed/simple;
	bh=GTKCuKerEVjbEq+ru51jw6Xl/RomTGKgH6W2wG3Nmm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kL67yxgTAD/GyCL8/2g1hvqZSCjnlSXDlW/Wf0Hk/M9fv2gxcwAYFle/MGecvJJXIDYUUqV1VKNUnleXUdqZ/mZcWSl16Tl6+QmGTW7CNzdcuVtO6++2GqYN69ds6Ne4zC9QQjglAyYnWiMIJYOEYahPLPprEpsNaUVqbAoZXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7eLdch5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7eLdch5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AB6C32781;
	Mon,  7 Sep 2026 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788778227;
	bh=GTKCuKerEVjbEq+ru51jw6Xl/RomTGKgH6W2wG3Nmm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E7eLdch5WLY5HM3QuLWloNkUlAlbY2iuXXF+aiOpuPrAYJ9sqT7S9LNjQaiIHAoUF
	 u/3K59vvKNrCczypXm62HLDb+6v82zmskJUaJQfSVHeFYXSNzYn1j+0vK1dkJUwrg3
	 nHOF6w1mmpN3mZGMzRXyiqlfueFa0kCcEzwVtI7pa4P/DX3uzZXrdE/j4lWkE/y2Bn
	 t+IF3I9cuZqhoZZaL2lgLOUy4P5X1oCsbRsjOV5Bbh+lAAdnpzF0Ww0HMwZAWrF+HO
	 LwA+6rc7YL08lySTQU5pSTnQ0AzlD7eLTKy9ezI9neyKARCajS5+HZzmypBtr9509c
	 1nQGY8CVnXgdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD1C79FA7;
	Mon,  7 Sep 2026 10:50:27 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 07 Sep 2026 12:50:22 +0200
Subject: [PATCH v7 4/4] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-stmfts5-v7-4-4a53381cd038@ixit.cz>
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
 David Heidelberg <david@ixit.cz>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=UYybbePhFZQL67dBaI7ZZMSBOFWG/ciE0qllsHbgzEk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnpbxszq1XdEXQk3tbuzwTTUhsGO41uqgWrSI0
 z7bZr9gA9GJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap6W8QAKCRBgAj/E00kg
 cj0gD/9K6AxPZdRFlTxauGLtzK5KNOzTOIRLBoApT1ArByXMbaGDsp2sJVaeD33WmHAFeoeySEV
 AxHbSt0WPZ6DFYiYx5sJwcQbML3r3+GTLSJ5zF0LH0Uk0MTYNUGzN2sIaIVcOd2NicyEfHIcRW1
 XmJ8GRe/wai2lxfcQsUEZ6sO1yfkujJKsjTCaIyzzddascllU71G3dcVCznVOU3fBzJStG1jc9+
 hzb5g7MHobWz2LF8Mz93YRvtX/v8OQaWRfqk4N3ox8bzsl50iNYf5JGB0Q/LT4pMzETeWByMYS9
 GqpBkNyQSj4o9mH9PtA1gUG6mOv2dcCEVHUso2fwnDnMjneMOdlcniQDwgUY8Hasc820YhHF1xB
 YEwAlfI/TeVBFxwUDJDen9rzHN5W34VgvJ1RZkyekcGq90PoufXUz+fTAkorbhM+ANPTE050YgJ
 IbPUBExoSmnwQtWa3x/DUP+Y5plELRxrA43iIhPw39FRFqQr4uTRQsEz8CxD+geaekDEguJ/9NU
 DLcLkKLjQt7RrZuiHDC716om51JKkxfkuoXP54jvnoGkmKvsressMFf/CtPOKtshYWBTVF4Ek78
 QbeHYFBT4rwZyS/ov+qudMAk/+y1DYfc8Gbb5gXLRQpBQamTNtlwgo8ZqC04cyqu65NuL85yQ6o
 +lpLd4ndAKoQw5Q==
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


