Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448835;
	b=P6Rw/IMoLB9xY8lFC8b9smJZ94sMxE09rT8akA/zSPUKEbm3lWmssNWEZPgPvdUlQLl7
	 XOxzaHdMGrHy4eB+b/s5mlTBLqktrMMMABe3KeUd1FKnWa1v54z7obuYsir40rth3nzwd
	 7RnUNIfRIv7cwUI/2smpIP9IT84uX650wtDtD3Dk5ags/8ad4WQCJxke3vPpgGLCbJ+RZ
	 mJGdj1J5uBl+bry6dboHHKsQzthw51MxU67GPWoJmdNTdOKtBCdu3HMfO+7qsbmnuDy39
	 5LA1BoJdSCClPYsa12NIsrmslX+OfScWV4i42F2wiRx8NHVfkVc4pJhClg1CZrgo5Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448835;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=w6GSaQZ1YWPu7r01oRscCvKngFyipxtXhFF9Dl0tkUI=;
	b=dk4YLJx/aJ05CMOM/iyhYu8LUrAnE7u3S+8cF458TyAk0A0K1vwfDVcwigKkB7NR/Iqx
	 KNomcjWhDBnSp8TTRO09P/uq9Uth8gpqBMEIXFVVeDGvHi/SR+TGdTnVreLUBehKM5Ks1
	 aGmRc6pKi1AToXMvgFd6F9GN4JzOW8oe/E5spw/Gd/fROTVCAA5zh4hAFIp6tlSSc9EbZ
	 gfgI0C9TIiuKZQKOX3aPPnSFT1IqytQ8UUmIXxYjc/kKXkETCbxApZQ7HspuHeqyj/YYO
	 rAwGNz1BkeQXSqq1rHftH2WSW7itqKccvVf6pVTcLP5F90dsoFySsFOSjDuq+3jV7dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImKEQIYr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A83606A31E;
	Mon, 23 Nov 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImKEQIYr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795448834;
	b=XnYBIAURtWhMH4hN41KCeocIyp3iW0jlycJmYCmQ9a//s9J0fJ+kUZ2D1bLWdY5sWDVb
	 0wAEQQM8bcrOYRoSjSdAZVc7nl9oWoc4dte4NfJwTu9c/zYRzMxJxccczXjhBVrQccDLw
	 QpY1qCAqGPR5mZjRrLkHL730ckwONT7QM5LI4J9zVmigzJpFBPwCDT/syd6c12QH91sVF
	 7QaK9WSXDR6M67VopRGAi86Q1cWGqdxXV3IY/VsYdxxZFLHHka28SA1MRjwkJTUqZpLKT
	 0KD1GDXVCef1T0hs8IVrjxH2xuUfzWv1geN33LYiX7mw82aXTso+rxYwAebOw75MUyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795448834;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=w6GSaQZ1YWPu7r01oRscCvKngFyipxtXhFF9Dl0tkUI=;
	b=vPDm2zVwrKLh7HCN6F1wrnqOXQjmoihFxpnrsbeNB+vf2dCEhekwP+nWp+w00YtgMaVy
	 tH/Y6Iq0gp88/EeDti2ETionhuqFg8oTi6zRYCuvN/yCEBNyqr5tsWU9hmH2bDtk2sfaJ
	 SulJtrhDVEOEKojxaZ1hV9Shjf4Vq+kP8tPcws81D1J9oj9+u7DJ4xZZMnOya97dM6iYs
	 6UcHaRsewsEaTYuO6+x7EtHfXguMa9o1fI1xRC7zwstGp2E/NcR7gWYs7pfwpE+Q0Cb9T
	 PrwafwOjkz8h0kZ4sk9L78fbqFmcgzcrB9oGSukIdk50HQY3A7skVaXMtOPNYjM2pYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 12CE51F000D4;
	Mon, 23 Nov 2026 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448834;
	bh=w6GSaQZ1YWPu7r01oRscCvKngFyipxtXhFF9Dl0tkUI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ImKEQIYrYNyjnhpEsdUJ1WTKWXXvvYLRL9g217ZqLAF3wcODuw6gZx0ne6lPDpXzP
	 O/QSeLo2UF5uQ+Zt22cOKzHz0hFvbgTp42/4yPGQAedITdhiskQdRORf89ej4e5DXl
	 kYbw+P1GeuElVH+XD5qBf3dOgka5xjwbZIcWMFo0kzfWv60D2U9CW3RXHqrRlAQQr1
	 rHTT1JywTsQXAYzADo8plqC8kuFSlbgVcBi929xN1BDycfbOF+dJIEfJndfepAhPnu
	 FgDun8ecII1o9Kn7fr0hzulbfZl1lVlIAB1NDmYb4iAXODhlfSndNTpQSG4CLw6CR0
	 WyvAwDBT5J0Qg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6437C4C535;
	Mon, 23 Nov 2026 15:47:03 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 23 Nov 2026 16:47:01 +0100
Subject: [PATCH v9] arm64: dts: qcom: sdm845-google: Add STM FTS
 touchscreen support
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-stmfts5-v9-1-3ab247cd32c0@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13Qy07DMBAF0F+pvCZoPH6MzYr/QCz8pF7QojiKC
 lX+HadIOMny2nOuRnNnNY0lVfZyurMxzaWW66UF+3Ri4ewuH2kosWWGgBqQy6FOn3mqavCSBOf
 ZRxLI2vTXmHK5PZre3ls+lzpdx+9H8czX178OAfy/Y+YDDIhBKuOtC9q8lluZnsMPWxtm3Ciuu
 sKmCHwwIiWrLN8r0ZUE0ZVoSkVH2oQcEQ5KbpXtSjalZU66fVH0aq9UV4ZDV6opCCQoWrSW9F7
 prizorvS6IWSftcuG+OEatFXUFTUlnRLC8BBBHJTZKNzc0Kwb5pClTRiMyl0ty/ILzIIP/RYCA
 AA=
X-Change-ID: 20260214-stmfts5-b47311fbd732
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, David Heidelberg <david@ixit.cz>, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7114; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=BZ0jNhMewCco0W3GXqptMNj2qzAX+JOz+BtCMJgBCLQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBF/2l+atC2bSO1qox+encpqS3x3oTwbR9q7P1
 lPMQNUewEOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawRf9gAKCRBgAj/E00kg
 ckQkD/wLWCfHtUy1Alv7HMK0uwsEWGQx7am6tJx3Xevd6TXHu3eW0yb3UPBFvEVDMTnrw9I/7uJ
 L0pvQj0EKAPLLRxfF+IOpYfOgYae/siKX3/Ybq76Rna6oxqBnjrroXC87AJG3iDyykB+SWKME1i
 WGfOJ2eBYx6G0rVwP3p17VwH4SGe9KgLZdAN7vpyGxJHJkHTXUqaqWhDD2wYLxLh579ro/0OZsp
 TD/LdMuqnPsRpEC3YyQ5x8fwOipEe5iO8X6eGEgFpqe8O/fb5c0vwV98VjJMe42HoDHeJmEKCaM
 ymOPyKevexWYrQIeiMCnaVJtFEDuCE16SBNvAzvR1EK4qtanVjpJITPPcM2GvemKy++TJNtuv5Y
 3tu9ezw9RmJPjfBcgs9kWixfwqe7QaMUJjxBdp+9uMkox4JqZ8YyBBumsMNbjs/+bDxpr2KkOZz
 FDArT1MI5ZMB3CIE6ATcYP9uq0eFRuMA02JK1U+tuFtpHVBzTEJ7GtLyerNIkyihM3t7T6WDh40
 SIoguFUqZgc0iqC2/ZQmtIUAmeV8v02DP9EiLOM8SfMcSpxf1NIFZqz0+WRfDHmalyupW33H7OE
 fDVlfEFPWnTyeH5hYzC+LJrnlwTU7uiFj9tL2JGzxekvqCkbNhbxdZn10u45/XHepZ0/wHcuW8E
 F87mQ3iaVyufD/Q==
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
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v9:
- Only Device-tree patch remains, rebased against next-20261120.
- Link to v8: https://patch.msgid.link/20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz

Changes in v8:
- Split DT binding example changes into own commit (Krzysztof, Dmitry)
- Refectored the stmfts_power_on fix. (Dmitry)
- Added ABS_MT_TOOL_TYPE. (Dmitry, Sashiko)
- Link to v7: https://patch.msgid.link/20260907-stmfts5-v7-0-4a53381cd038@ixit.cz

Changes in v7:
- Added 'Input: stmfts - wait for controller ready after reset',
  the waiting is done for both FTS4 and FTS5, similarly to the
  downstream driver. Should improve reliability everywhere.
- Link to v6: https://patch.msgid.link/20260906-stmfts5-v6-0-50fbf6af8718@ixit.cz

Changes in v6:
- Enable only the multi-touch scan on FTS5 sense-on (0xff was wrong,
  only 0x01 is needed. This broke Xiaomi Mi 8 toucschreen).
- Fixed Y-coordinate comments. (Dmitry)
- Corrected event[0] parsing. (Dmitry)
- Dropped checking < 0 on unsigned area. (Dmitry)
- Dropped unnecessary i2c writes after reset. Verified against
  downstream driver. (Dmitry, Sashiko)
- Added pieces for supporting non-OF integration. (Sashiko)
- Shared input open/close into one impl. (Dmitry).
- Link to v5: https://patch.msgid.link/20260810-stmfts5-v5-0-0c737d929976@ixit.cz

Changes in v5:
- 3.3V is analog, 1.8V is digital supply. Fix that.
- Name the error variables "err" (Dmitry)
- Use scoped_guard() for ->running, and only set it once the scan
  mode has actually been enabled. (Dmitry)
- Use i2c_master_send() instead of open-coding a single-message
  i2c_transfer(). (Dmitry)
- Drivers may report coordinates outside the declared min/max, so
  remove the clamping. (Dmitry)
- BTN_TOUCH and INPUT_PROP_DIRECT are already set up by
  input_mt_init_slots(..., INPUT_MT_DIRECT). (Dmitry)
- Let the input core track contacts: drop the touch_id/stylus_id
  bitmaps and the hand-rolled BTN_TOUCH reporting, and sync the frame
  once per interrupt with input_mt_sync_frame() instead of calling
  input_sync() per contact event. The controller pushes contacts one
  by one into the event FIFO and only resends the ones that changed,
  so INPUT_MT_DROP_UNUSED is wrong here and is dropped as well. (Dmitry)
- Restore the FTS4 interrupts accidentally dropped by introduction of
  FTS5.
- mode-switch-gpios isn't required with stmfts5. Some designs, such as
  Xiaomi Mi 8, has no such GPIO connected and is limited to AP mode.
- Nit: updated example to use interrupts-extended.
- Nit: (maximum x/y coordinate reported + 1), corrected example.
- Link to v4: https://lore.kernel.org/r/20260409-stmfts5-v4-0-64fe62027db5@ixit.cz

Changes in v4:
- Wrap everything below enabling the supplies into stmfts_configure()
  to avoid bunch of gotos to power off on error (Dmitry T.)
- Finished chip specific ops and removed is_fts5. (Dmitry T.)
- Link to v3: https://lore.kernel.org/r/20260403-stmfts5-v3-0-5da768cfd201@ixit.cz

Changes in v3:
- s/touchscreen_pins/touchscreen_irq_n. (Konrad)
- Use interrupts-extended. (Konrad)
- Fixed rebase conflict against 8665ceb926ec ("Input: stmfts - use guard notation when acquiring mutex")
- Rename switch-gpios to mode-switch-gpios.
- Do not define properties in if:then: branches. (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20260315-stmfts5-v2-0-70bc83ee9591@ixit.cz

Changes in v2:
- Fix typo in the binding s/switch-gpio/switch-gpios/.
- Deduplacate allOf. (Rob yamllint)
- Add missing S-off-by. (Dmitry B.)
- Dropped irq-gpios as it's not needed. (Konrad)
- Correct x and y touchscreen area size. (Konrad)
- Correct reset introduction commit description. (Krzysztof)
- Partially implemented chip specific ops. (Dmitry T.)
- Separeted license naming cleanup into separate commit (Dmitry T.)
- Link to v1: https://lore.kernel.org/r/20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Petr Hodina <petr.hodina@protonmail.com>
To: David Heidelberg <david@ixit.cz>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Henrik Rydberg <rydberg@bitmath.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
---
 arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts | 19 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi  |  2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts b/arch/arm64/boot/dts/qcom/sdm845-google-blueline.dts
index a000c75494f1c..f65263955229c 100644
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
index 3c9656b88b696..7d90c0be485ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -525,17 +525,17 @@ firmware-pins {
 
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
 };
 
 &uart6 {

---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260214-stmfts5-b47311fbd732

Best regards,
--  
David Heidelberg <david@ixit.cz>


