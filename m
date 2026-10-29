Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310404;
	b=PSgtkGvCyLq5hjopSokZOcEqK3hhnd6Rh4/DtBIEFr+4e+36NE6qqC1dZf9Dh23hUnL+
	 QXUteiJJ30A4mJHlAUAhSyP9L/5hd6s3XJvQUtG3onrsaOQu6LoDGawvpfxr6AjJKYoQi
	 mQIG7U/kDVL5JmRaIOPh0lGWiZklchvZKQAfbC1GxoKoYBk3+JRrI0Cc4dbusfxBQNemt
	 +mmHLjP/aikWCi8LjNNO9B9dEpVL0WvN5CbnQzUQBrc6ObNNiROXqJVZPE46gkqE/dLsA
	 hS7xTplN2jXdOVH1xgZ7uL/XrUNMqH/rHkc1mE2RmUHE1hM0MeW/L9rYKPAQZtIN5yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310404;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=nokvmFdO/lMAIkL8CGtuOjag9qyiXJpuOJ3k1GovAAg=;
	b=vDHjLEiXDCFYjUNAkHDa8CsauMqn9+PD2GLP6pMMlX1kJpJguUJpRh7ZQtuPufrGyOXf
	 hw6B3MLPJbK8WZbV1JC9VAe6Jzenm4AuICnGV+uNj8+C525eHaLVP4vC2+8d24gHFOCmP
	 iduk5Zxn9/nS3wPeXZmkc3FSobg7nNeaaKr38wpZZaFXFWBSAmpgQLZM7R8j3BMt4ipUf
	 mwx/AFQNH3sYnp4K3bCboQ+2Md2OxNEoaFDyAXkjaieOsNq1KRISah46G+QqmGt8F7lch
	 igCuGKKSh1/HbYFdPF9pOtkakzXGrFwGz54NhWSNVXFUD/l0SHD//+XnCaNf1Q7KP/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 38E03606A31A;
	Thu, 29 Oct 2026 21:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E03606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69268.dsl.pool.telekom.hu [::ffff:81.182.146.104])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 0000000000080988.000000006AE3BEC3.000368A5; Thu, 29 Oct 2026 22:46:37 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support
Date: Thu, 29 Oct 2026 22:46:10 +0100
Message-ID: <ca2fd61b3b0fdf6551cdf6900dd9115a8c31a0fd.1793308351.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793308351.git.soyer@irl.hu>
References: <cover.1793308351.git.soyer@irl.hu>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v3:
 - add &aw86224_reset_default to pinctrl-0 (sashiko)

Changes in v2:
 - rebased on mainline (Krzysztof)
 - order by address (Konrad)

---
 .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
index 3860ab8508a0..a90407a40451 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
@@ -721,6 +721,17 @@ fsa4480_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	vibrator@58 {
+		compatible = "awinic,aw86224";
+		reg = <0x58>;
+
+		interrupts-extended = <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 46 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&aw86224_int_default>, <&aw86224_reset_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &ipa {
-- 
2.56.0

