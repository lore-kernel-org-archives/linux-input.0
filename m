Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138504;
	b=lXXsmjAozABSNKUY4MjvlP4VjTJvmZ27M9+3WNW0XdWC2sNqaUJH5NYYo5qqnjtRKoNc
	 LinoZd6odPk3fXK0fjRHZYO/iH/rF9CH8BN0Vib2D9cqoI9Rj6ls+hjX4nYNE/C+YyiRN
	 MUPzoGj/FPO7qm1pJQeY1B6LX5fkyYnMOG06STLRFNq2vUEi8wqQ/vQbbJB2x5lLL36k8
	 UGtwU6Wfnlm3po1SBPNFrRhqqdG0VvH12Iy6JVep4TgFCYrRc8I+MjJ7r1Qt8OxQ8kYPd
	 2/BSyea9NR+TrpX1uY6D0FnjgINtwdxj5nKqmlsIOP+Op86Q/Z7GSyH36uKZV/nypfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138504;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=7Am9ULA8kHdmHCifxnjPMxDcsJbrB1tfTLD3EysWVPw=;
	b=S/xv93t29ODYIf81Jz9OtZOT92gey0yR7QRqwDRiwd8fSWigucee2/2+c9xe69zVuHf0
	 /J8IAdrjS90Bz7u9DAjDtbrsChiGoujKrDHGLJgMRdQInBHSHIdhOQ0sHeH+0OlMjZvpz
	 9hnFvIMs7l4xseTQj6Mwt6LLixvI+hBcZyOzv8PEM8aBOx0uJiavyDPJ2gmiU2WHTZifu
	 TZqxcNt/uMp8g6TIni9ckpt0D/Y8HhDoVQ+ga6m9v0uC2k7tNahTpJz8Z6s9PwV/aQQYD
	 A1YYkVknXNsdn9WAJDHS7gt8l2G4GGyPleGYC0ovVDw7n6+q7HhwBb+Q/tgR+VoGfkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8BE4F606A321;
	Tue, 27 Oct 2026 22:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE4F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000808B8.000000006AE11F40.0002F694; Tue, 27 Oct 2026 23:01:35 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
  Enrico Cic <enrico@privacyrequired.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support
Date: Tue, 27 Oct 2026 23:01:25 +0100
Message-ID: <8717c3739be282747cbef611d242acfc5a40656b.1793135056.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793135056.git.soyer@irl.hu>
References: <cover.1793135056.git.soyer@irl.hu>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Add the required node for haptic playback (Awinic AW86224).

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
index ef91986a1fb9..434846be51d9 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
@@ -924,6 +924,17 @@ &i2c4 {
 
 	status = "okay";
 
+	vibrator@58 {
+		compatible = "awinic,aw86224";
+		reg = <0x58>;
+
+		interrupts-extended = <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86224_int_default>;
+		pinctrl-names = "default";
+	};
+
 	wl2864c@29 {
 		compatible = "willsemi,wl2864c";
 		reg = <0x29>;
-- 
2.56.0

