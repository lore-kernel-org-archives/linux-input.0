Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190104;
	b=hCHaBsgScf22B3oFAiPY/H/3uiLsttiKPe1kv7zEenojVgBYBxcqthv0ywgvGC4MGqZU
	 srsAILYZNak5dnhErQwwL7CV2w7Sn7l2WR0g/tO88fvBeZ5Sni0yclxGldtVPyeG4Irh3
	 ADbKJ7RQKE6JHjiLADez0aroedkTKuTbxKKWUUs+HDpAUPjT3RuQ/uY7NmRrPUfOe94M6
	 rSCjbOGUyvZ+E6j8phC7M81sAzOC630VfrgBb0xDcWllEQnual34hL0BXiBtKnigBhVae
	 a/aX6j2ApFEHhX/TqarU2dvGktMTnmhWdaDqiRJIYmaAJdvqaIMojtx4YOTFM3TGiJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=grKFuqlZy/vF+EZ9KT+ynP4RyPsh8Pe65v03F3LVnyg=;
	b=EayBcAFJ950l8GI3krgcZoBQNswgB7y3ggagUwgVgcBE/5Zfprpef7Cq1Is2qeAW+TNm
	 UuZ5LofvBD6BOnsOrSxbaGrIakFOCdi6dLqkvhgmehcASOLjWJOcNMYUbzwAoFWIHApWp
	 01dBmijZwjJ5asHpqJI/FxcvIVXRkbrVakkL6e8a70EaE/o4odf0xSWeTmwI/PM4t209A
	 clsfvkQQVJDEv7HSVMcLK4SlLiwfm/s/RhD/zeI1n4hWONcw0hhCxoPY63hyQ30FPEDCC
	 1TW3TBQ8h4AxxfzztgbRvL+pGxlQlDoKIhO+z0KAX/h/HwXFygACKF410U3zdjfb6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2kOcKCi;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976560A263F
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E976560A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2kOcKCi
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-498f5fa5103so644939f8f.2
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190101; x=1795794901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grKFuqlZy/vF+EZ9KT+ynP4RyPsh8Pe65v03F3LVnyg=;
        b=s2kOcKCiOdhayP7XlDN2K+jTO88jXK32Xj8Z2koNKcodABBvPJzDEE4lrX+uH+BskK
         0j3ep3cMpa603H22Sp9sjtiY5cc1X+dlyc2t1VLetPq93hcTtVn7qjJY2XO0nzH2u3+J
         jISqCrmykUqbgdHqNpBZMZn42xrQi+HUo94jrL0T5wA+C1RQjryX/goit+z12GCpIuyX
         rTN6a/b6TrCLyY4Tnt1HRXy5HelUHYJQ+iX8L9yCnRYQB+5LEeJumKhULoWd8pZfTJsp
         jAgjEBkCFcppCTLmOUI4cipO1YR5A9A8vrYTly24tBfFcIjv4eHRHrgGaKouh/fAOe77
         Egfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190101; x=1795794901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grKFuqlZy/vF+EZ9KT+ynP4RyPsh8Pe65v03F3LVnyg=;
        b=kKun4QMhuYCl6ZLEqWrSJGyej5DQZ75hiurb1rUK2deejL2I+1YucUQSGy2u0kmCZY
         UEHVBwQwZYUa+XnMWbiYgguiYy6gELl0je84o/am2GBK6gCQMqkhwDAUpIgtoOgiA5pr
         NtBcvo+PyD7j1EjzANRSDNNIyyIL3nOS5eQtsgWyKfFF1hPnlwES5hTwcLSwlkDOaWkJ
         1yqVUN9j36+SxD6l/SBQF5z6o2eVyT/ZS91xfEiMUYoKJeXRXpbvCBiJob07MbN4FN2o
         iRSORwRwBkamKLfXjlCzRQVQ4RPJO8qxr5G4LcdU0at2whRwmI2l5HGCMOTB2UOpMtlR
         M7Iw==
X-Forwarded-Encrypted: i=1; AL+hErHISZnPjPsYgnWJanPJlhUIc78/x92LCd7C1qp8eY7SaE9ogOUUrYDI7alV9NK7AzkWxsc1wDJbshsy6w==@vger.kernel.org
X-Gm-Message-State: APuU4Z92yZBpWZxNmK2IzxDEWjpTjhwJVoXXKquND3XFHkXjYwMk+e3a
	tfQeslnzgFtZskjnyiI/7AK5XGhAB1ekkBaLlx/zNKHvRd4KLAYVg2RP
X-Gm-Gg: AYBFou01vMq4AzkQMh94JOIVtoIA6DEdDYBsabuQIzEdXPF9mAjF9QLDrzghHEWyzwk
	5bj3YQzvmdO2dna9BbavZ44v/oIFBGkx5fAKmk//mzdCwfnhAj1LjcMgPx+4/9ZR4Lg/9P6I6VH
	G7E9NHYSfSiWZFecq1WcUBQxYwp6pz3k40EGnstvsHeJi9Pg/61dcy28fTx0T+xhS5fcaLPLDFf
	15OBKWf7IFqzvVKT/V2ud1ZG6OJZCiwVk+k8qI6v8gS8CP85U2pKUp4WH/BANA8m3nffgp6Pnsu
	fZ5CekFsPbv1RnKjLjm8KxqY0iCpK81W9MPBDA1z0WcwFE7MmAjwbp429WTXa7wSWUSDjtuGm36
	q/6TvYMgrkosqv+xAJjfCdkNrK9jDWsm/fXLRd1CbWAPHAcncxRtbBGGVXT1qLHVLBVY5fVB2Ho
	l9LTS8dJIYimIJURIbzHgWkMq4twoUnRUU4PDZWr7afaQzuYUbZM9JPd7Cb++S8dRWh2bkijcfT
	8t1g7Cz+zPXvrd9NpiJPWJb5Rfx2BQfTwq0stfrSwCDrEWnzDzS+tT78weSj/BLZ+RIgd874zew
	6eH2FXHmNkhnDh5FD0g/G3EuW8bR6L7Jnr8oApx0JqPs+Gh3Hff1QEkrfbCRunTc77JblYtX1Bw
	=
X-Received: by 2002:a05:600c:3e0e:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb88929c63mr74999345e9.18.1795190101297;
        Fri, 20 Nov 2026 07:55:01 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:55:00 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
Date: Fri, 20 Nov 2026 16:54:48 +0100
Message-Id: <20261120155450.7719-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
QMP PHY orientation switching.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 6f00495d42467..16ed6b3871374 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
 #include "pm8150b.dtsi"
@@ -555,6 +556,44 @@ volume_down_state: volume-down-state {
 	};
 };
 
+&pm8150b_typec {
+	status = "okay";
+
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "sink";
+		data-role = "device";
+		self-powered;
+
+		op-sink-microwatt = <15000000>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 9000, 3000)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				pm8150b_typec_mux: endpoint {
+					remote-endpoint = <&usb_1_qmpphy_out>;
+				};
+			};
+		};
+	};
+};
 &pon_pwrkey {
 	status = "okay";
 };
@@ -659,6 +698,10 @@ &usb_1_dwc3 {
 	dr_mode = "peripheral";
 };
 
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
 &usb_1_hsphy {
 	status = "okay";
 
@@ -673,3 +716,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l18a_0p9>;
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pm8150b_typec_mux>;
+};
-- 
2.39.5

