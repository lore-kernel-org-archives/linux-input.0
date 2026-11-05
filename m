Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876106;
	b=WmjcqveZ0gyhj3w/XoS3QvXKJHpGdTVD437kSrg6IoL5UlnaMSdcK8cOSrx8kWRvd3CJ
	 3RVg4yrjOJ4c1l/XTsN4nuGbR1KZk7GYfVbykvsGFncOY+wvgpeXZ0jfmZv6r2gmXuspb
	 HjA8SBjwTcyYhMzNzT3SdT2BYluCDQ5FXgtVWN342PyAgTw0ZFi5UK1PO79ch9h6zkRDO
	 VKdLcyWMaCdkjghJwhIDH2NJFdKuNTogNpBiBeruCQ6U+vERkMn8VAD+2AodghWO6qhbx
	 aHMYVdS4WctULEBknBoQ1D2PjeCg8D3+XYPD6hBNAeSICPOFHMedVmOmrjFHBMSDB6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876106;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R7gLIWsMupYRCkClA57yuL3SZT3mZmUhwmn+PS25Xlg=;
	b=Ohnq5QRP5/UAAnOy9I0pEmukAbgWhPPLP8UNc+krLe47Ab0jocO868N08Ekbl4ZKhS9A
	 zwQ7DGgtRJ40Ckoi2Pz7Vi/oUeZyUFPakXFEv1TK5Fiys/1P+7EoDMfimu7+4+CNBydWX
	 RaATQ/p3YNWEEJGuitHo+bGOltRwJlEe9eG8lx8ZCUjrifWSfDW3TBlP8eqketsklESPV
	 BJWMuseR6Z7mYiNWBPcTRu6VEby/MAF64WIqBOIGxdCYd3PwaZOJPRH5C/MLMHA2EUxFm
	 rfWRz12WGGASy0021MFYQgsO1Qzmg8jRzXkFgqB6DEjbeGWxafzphPjsWtqYG1vv+UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sv/SRLpo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE981606D80A;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sv/SRLpo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876105;
	b=EOh3wAvCERrs4H6v1IuC+Vxz1cWjT9rou/xl2ARbZTGZ8SEPJR/KEfWHKYiDfgFRYtzo
	 yeGNc5mDjb++0M6/zrUb+n9b5JeVUCi0chS7bF7H0CXxk7Orhjj0GEiilz+NzmCyOYSoV
	 h1XXrivGnbFzv5SNwJpmCzUK1JSYy7Rg7zwNovO9tOZIDXoYxLBNPtf9xUotrV5Hmorky
	 XwVHPOwKRwGV7+zTSm5QqlGZVK6ZHTbRdMOMnuqao+aS5+Qkh0O088Y+kftroV7d/CAtH
	 vUSQCrYgoxj9bqJSZ7O5WbCapgvJvrxdICFXQAj0OiGbhnBIB3O/yJWiOGW5PGZqtNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876105;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R7gLIWsMupYRCkClA57yuL3SZT3mZmUhwmn+PS25Xlg=;
	b=UZnSs5HeJd7HiHEF0XZva2OoZNPHmpinAefXtAQ8RsXI60s5FfZLmBeAh/r9Zy87tb/N
	 5HOWD9WEyNFIFbc18zRqdGs/xsgV+VomfKHgteFyQTBQrReS9nTsBc/j2h6KVwzaonIJc
	 4JMe62zaaKtDmp12Fc4T4FXEpRzU0/zkifP/9zZtyudDSqfd13mck2nu/SxXhpkiJI9Cd
	 N8lErXEKb7h7cTI/+s21Va+qXS5F9z11hrre4GSTPn4WDtwfdM5VRQo6WSsJhcmapoD29
	 TEpFGOwnsmZCPI0imq7qND7AN7aZj5o3HR15kL6T3jE7xJjMSbyONyI+rsEUi8J6Qbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B50231F00A1D;
	Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876105;
	bh=R7gLIWsMupYRCkClA57yuL3SZT3mZmUhwmn+PS25Xlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Sv/SRLpo8Wq3sUkgCyP3AD5FhnpKUwQ4wCyaf1VHZ6M7JHJN8Ku1eHmTKNDBbid1L
	 NsKVqgViGd+VR26gJs8nP2Ye4LO9DWzjoqFvhNSiHlXgmnmx6xd4674k1hkf5qCwWz
	 TK2XczPFLHcLUbg6pPUMSzEQnbrW9MhrPmCO73t2nvih3JlqFhiOy/T5mgE3v7iWmz
	 /f3r8Z82lqAahBeXQdUoLn9Qpmy9nBfHnEB8JFTQN5xZ8mKdGoFwIxqEWu9jGEE54K
	 FflwEGcvQ8cDgYnjQByTMbQ/GNpwASvyG2UVOufD6oOuHPb5VaGPg2VsfyxVEqX0rb
	 j+jCsif+u4tFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A79A471EC;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:10 +0300
Subject: [PATCH v8 06/11] dt-bindings: clock: qcom,a53pll: Add MSM8952
 compatible
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
Message-Id: <20261105-msm8952-initial-support-v8-6-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1455;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=XCIEEjoD19j/AIKNwqTlsBvKPtPEgIUzUJWdLdc8miQ=;
 b=FuyTp0ZryxCxUbbN5sUnAwICtuCjnzrSqGz1rYWnJrBRAY0QIV3MR6pCxjCuhss75PaF5PkMP
 dfVIdPtvZD0DRyUrvt24f70eV179MSe+yXgyl6n9Lx4TjwxGi+O/JR9
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the a53pll found on MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../devicetree/bindings/clock/qcom,a53pll.yaml     | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index 1eec77e75a0a..4abfaa24bc71 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -15,16 +15,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq5018-a53pll
-      - qcom,ipq5210-a53pll
-      - qcom,ipq5332-a53pll
-      - qcom,ipq6018-a53pll
-      - qcom,ipq8074-a53pll
-      - qcom,ipq9574-a73pll
-      - qcom,msm8226-a7pll
-      - qcom,msm8916-a53pll
-      - qcom,msm8939-a53pll
+    oneOf:
+      - enum:
+          - qcom,ipq5018-a53pll
+          - qcom,ipq5210-a53pll
+          - qcom,ipq5332-a53pll
+          - qcom,ipq6018-a53pll
+          - qcom,ipq8074-a53pll
+          - qcom,ipq9574-a73pll
+          - qcom,msm8226-a7pll
+          - qcom,msm8916-a53pll
+          - qcom,msm8939-a53pll
+      - items:
+          - enum:
+              - qcom,msm8952-a53pll
+          - const: qcom,msm8939-a53pll
 
   reg:
     maxItems: 1

-- 
2.56.0


