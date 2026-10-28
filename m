Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219883;
	b=boZl1pohxFfkQo/SeL0rwGixRnT3jX9c4Z9G0zWuDugasI4EuhrfJbTg8TdYuDQTgCHa
	 ODeLd1U4kahLg8EX4zfj7eGHQaL+oZ5JogGGjANM3an4y3ir6lGif+HT7tfySeZ1MxviH
	 g5VrMUMy2caySofDZWPD/V5fEEcxdfzBdoS5Yz4bbJYnQyY6tcmSYjyd6cQ3Pmlmx3SO1
	 9pIPT/GOf8NwJQ8uR1YCQYRO32vUifCnoXli73IhAm/dPh+gTGwA68iv8fMNrmruFgQZW
	 9qOJPLHdsvyeOXW7MOnZYAfkzAkmwr1ja0PGgE69IaTKMJoYVHfwnqG2N9z8XLRYATw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219883;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=KOdleQj/JopQCM5YO/WJ2/AzNTtXs3EqIAMQNw5IwkU=;
	b=1qpenUfUrfoTlG1jUOy+MGvdF2SAh0+E3k0lTSmn6KzdG3wmv+D1+FQk+PGpQ9xUqqrg
	 +ZSz4MZCZnexjdAV1yMmvAc2L/TpwjGuZw0qao7Wq3+LKZfY8parwe6MB9b65TbzkCda0
	 NE9mpYnFNquCuR5SMS3fE6+2XKNS8VdZvAvxILZ7AnwMTfClRtWBz0tx7iKMpAIEpeIUK
	 FMNbuogrfeumhiCV1Xnoqdh9hROVOti4qPByolEVFfQR0e97Eg5vbDhjQlZwvsmD5LzpG
	 YAXBE/2W9SbFCSZkssM4dFNIMrUgb59D0B4o8qv9XaUkY6a7/mGDihzk94raYP1+t3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CA5EA606A338;
	Wed, 28 Oct 2026 20:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5EA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 0000000000080918.000000006AE25D28.000329D2; Wed, 28 Oct 2026 21:38:00 +0100
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add vibrator support
Date: Wed, 28 Oct 2026 21:37:38 +0100
Message-ID: <89f7e6e9988c8744be37093777b0bc065a0e2ab8.1793218514.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793218514.git.soyer@irl.hu>
References: <cover.1793218514.git.soyer@irl.hu>
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
Changes in v2:
 - rebased on mainline (Krzysztof)
 - order by address (Konrad)

---
 .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
index 3860ab8508a0..df2cb58e95d0 100644
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
+		pinctrl-0 = <&aw86224_int_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &ipa {
-- 
2.56.0

