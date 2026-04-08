Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AD351C0B;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669673; cv=none; b=hMEtJQiSwTTTwhmCWWVbjI1/6R+MCLI8X64N4Qh664jVC11cPPMyRMSXalT1IO7KK0Rb2ywvNXAOttaQjd2qw+QLmaqhnOenmusWgDJFtpq4n+B8A66tfEvaOI6llUQbG2nAd/zAroAK6XquekILWijMfd4fkf4GUOSxBkQQ2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669673; c=relaxed/simple;
	bh=Q5X/IcDzTpW37er5WCqATsjv+uNnwswRrZUxQdnPDko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXtzX+aP62s4hxqCYuWW5QdftvUKQl7SJi3BUaB3M6nL5iBiql3YFTQIm1Cqh02xBDvVTzOH4HzELxOKhh/xnaMBvARspf4shDIJtnSgRoNVjVjrvAjUDGgK+WI1teNoXK9qSrbgLgUIc88ZJOJBcw9GUblGO3ZfqsNppKCIssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnXHuXF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnXHuXF9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58F03C2BCB2;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669673;
	bh=Q5X/IcDzTpW37er5WCqATsjv+uNnwswRrZUxQdnPDko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fnXHuXF9zfihy8Td2OIjt2YOHyz4/8EdnHqDSIL51Ia480ajPt4yOefwIAVjjeref
	 vI6gfsLjHwAwNLupPlL3QnIMsLAfGdTJ7nRpZ37B6aosUVphUTjK5EdcU83QMNb5CV
	 UHybSi2Xm006WtEX6Lll3wEjJAVUz7SMde0vuYR39wN9CXl57/rHsKhYpS/wFtqs/i
	 ZE2Ww5MCt+dITxAdcjfwOXxYRFrkuiTiLX5xpQ4W45vEozyB8Tq2bPEdk3ARlCfyQA
	 ngMyPET69gAhpww8uWSocDDBGOg5MmQl2hr39mcDQFa+4DYAxs4e/il/iExUXsHDqK
	 kwA3ZJY4smCEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827E10F9961;
	Wed,  8 Apr 2026 17:34:33 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 08 Apr 2026 19:34:33 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845-oneplus: Update compatible to
 include model
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-synaptics-rmi4-dt-v1-2-2d32bacce673@ixit.cz>
References: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
In-Reply-To: <20260408-synaptics-rmi4-dt-v1-0-2d32bacce673@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=H0Dnj26qpNUOEIXbqprRGTPK5SZ+iz0wAv+RBadPJ9g=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp1pGnCIps7eqk4gak7u3iaLt7/lptFl2iXRu8i
 DY9s5/48tmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCadaRpwAKCRBgAj/E00kg
 cuzVEACrAenxgZsjeY2unlTkTXQC8s4FYD4NqD1VonQ+I1CMGZbama3svy2jDkHLn1zL3dsyE9q
 yRldJVqMFeaZf2l6yAN5jU70JsoubOmbPtEF4j7mqPOaayYEone9n8LMU6sdD1PHQ01X2x6iQie
 aNhIoQky3SxY6Np1nb67a9R/Rv2a6r3105d9a5t6bLRgiyxkSJSBqO0dQpYZco2qtdC7t3SWOEg
 Ka0JdQTZTS1GsCKrza2D51K6xL/IHnw9JjzDzncBjt5VF6Lo6GgoF4NWjoAi0KUwQKW4440NYAP
 F16wDNQ8IUGOOFxsWasMh7Yw3qH/nXmyiSIE0hdD/Uz+DZVgs932IrzdGV5Z/46sdmxwwKJxByz
 Vow2AUobPuCDTxl0tEKGk2P4RBzQlUs13WjIlnQp8WtzKLm8XwP3yoUzHUYsq+8PjpzrlFwUIPB
 o9d74TiLsvhOOdkmS6flc/0muUk2MSJxbOj8YkuMbjRQcsck+6j4R0ZXAvtpT3rC7/HKmL+VPdc
 DKnpW8SY9+UROq15Qirjh/YTUPOs7nD/U+84wxcWkNjuLU57/+6vdGuyUadtGvb0+P6q/nRZchV
 POLZ0VdI0L8FpYUm2950DlCT2orYN8mTy373GYPeAEjIen06SChA4zq4h5elCJdjNJJohHZYSuA
 Hp1DX1lhuY5oWng==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

We know the driver is reporting s3706b, introduce the compatible so we
can more easily introduce quirks for weird touchscreen replacements in
followup series.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 6b7378cf4d493..148164d456a5a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -480,7 +480,7 @@ &i2c12 {
 	clock-frequency = <400000>;
 
 	synaptics-rmi4-i2c@20 {
-		compatible = "syna,rmi4-i2c";
+		compatible = "syna,rmi4-s3706b", "syna,rmi4-i2c";
 		reg = <0x20>;
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.53.0


