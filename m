Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EACC6379F
	for <linux-input@archiver.kernel.org>; Mon, 20 Feb 2023 00:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBTAOk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 19 Feb 2023 19:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBTAOi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Feb 2023 19:14:38 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA65C650;
        Sun, 19 Feb 2023 16:14:35 -0800 (PST)
Received: from fedori.lan (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F9B3.0000000063F2BB6B.002C6C1F; Mon, 20 Feb 2023 01:14:33 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-oneplus: add alert-slider
Date:   Mon, 20 Feb 2023 01:13:04 +0100
Message-Id: <16e6c00389bf0ee881a055f81a3dbfd5bfc9c469.1676850819.git.soyer@irl.hu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676850819.git.soyer@irl.hu>
References: <cover.1676850819.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The alert-slider is a tri-state sound profile switch found on the OnePlus 6,
Android maps the states to "silent", "vibrate" and "ring". Expose them as
ABS_SND_PROFILE events.
The previous GPIO numbers were wrong. Update them to the correct
ones.

Co-developed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 64638ea94db7..ff982dd853a9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -52,6 +52,45 @@ key-vol-up {
 		};
 	};
 
+	alert-slider {
+		compatible = "gpio-keys";
+		label = "Alert slider";
+
+		pinctrl-0 = <&alert_slider_default>;
+		pinctrl-names = "default";
+
+		switch-top {
+			label = "Silent";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <SND_PROFILE_SILENT>;
+			gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+		};
+
+		switch-middle {
+			label = "Vibrate";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <SND_PROFILE_VIBRATE>;
+			gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+
+		};
+
+		switch-bottom {
+			label = "Ring";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <SND_PROFILE_RING>;
+			gpios = <&tlmm 24 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+		};
+	};
+
 	reserved-memory {
 		/*
 		 * The rmtfs_mem needs to be guarded due to "XPU limitations"
@@ -753,8 +792,8 @@ &usb_1_hsphy {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	tri_state_key_default: tri-state-key-default-state {
-		pins = "gpio40", "gpio42", "gpio26";
+	alert_slider_default: alert-slider-default-state {
+		pins = "gpio126", "gpio52", "gpio24";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-- 
2.39.2

