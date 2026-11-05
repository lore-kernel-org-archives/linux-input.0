Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876107;
	b=BQHnyVC0rYZ1kvfuZ0+/CtlWiOxxUPUViX4qt97s01nwc73nGH8jq5vS+ckmO/Rvk4zQ
	 kGXpbHBJ+gxwfHKw+4R+QmNeZ+2grJPGuTPaZmmC48JUTEM+nTU5xvW+lJeo7YIxjKiZc
	 37akuJ1Z1vzKW5vfpow48pAHlM2FqHubiXNMuED7y3ED5qgItuTl/TSebGx90JNdXMl4V
	 l0AMPJ9+B80n27a9ryX0JLVEA2GvvV7uwCL1MskGZI2j/PJUPnAjqlgyRI4H8LFvt+dg+
	 ZArhcakoO56i3ousUFleUaD9Sb0MfYPUfDei2x5s6hsv1/uGiQmQeEZ1LSkx+SdLZdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=040g9tgoQF5ilNHm+RXbvx7PJjfAS0uRa+b5tR6vP1U=;
	b=cLSqtgX1eCHZSh0VofPCxx04R1+V14bD1DzhIeKkJUehbJdz13CzlPq0zJiPwV2hfwps
	 6qDt3k/oMBsM8UDtIqWbd23HeVajae4yVJ7Tdo5+guFVex96DDA1PSfK8I9OMtAgYMGto
	 MjczTRcHmJSNx6+5QGhpCJpNiMd2oEjxD8JsQMuCyUQNpMfpoBiw9azlr+8Tb40haJcXH
	 XolNgC62wFjnCiYU+w6oXV3nNKxb6aYI30dSiCCL/08F5aojB3im8KgDSbhgudBRDK0w7
	 gz5xq+3LCd8FCX9DCkgVJdGid2Dr20U0odjvLiOhp/ZLYCZfGCivL9Ni0a7BKVdxlng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMUvuIMm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5774606D821;
	Thu,  5 Nov 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMUvuIMm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876106;
	b=boVnRxVa7yMiiHIwEIPr5i4i1/ChP9sGRxYQX1bh1c8DYqfhFElOniZEJV6lynxo+wun
	 n3+QjE8iRiLlb08KSWPVR0bgtVzH9MHIo+c1sL1L3lTtqy/9sXAmgL3mmHIEzpTbp8Z0f
	 nTqm0Es6ApNyDbIUS93IsFr3/iNj7rTNoVlsoiKX3YFJVgGYjn91GQPpZaRDqD0gsutZS
	 i2LTzBzWHpZ+t5YyOFFfdZabORDBS5dC8ypdWot490N4gi+xKKy2aXx7P2wwMKIQLu3vx
	 R5fWMt9Mxlfm7/gx/ukRBrKJ1dVYyJ6BRCsqkLfJfyEFdldK0uZEbrq7V5TnVoycpxg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=040g9tgoQF5ilNHm+RXbvx7PJjfAS0uRa+b5tR6vP1U=;
	b=mNYwEspQKdg7RZIsYd1WFkKd2BqO0WjoUlR40hzuMiQZyn3fAKsXUDQDYbJsyTALxQ5+
	 SyxP4JGX56CJVs0V8ytwYWe8M+Dspb232HFzeTSJich7N+9/CxsHVZrsRt16Iz5C3FE/O
	 tUu7keT5F8m6Ync2GhFSPJVfLmmDW6QCSiAJfi9f9thklW4yjw/J3kQ/Tk4fnhsDAd6zg
	 HbbKK7m9Yr0tNR0abBqmzwgHTWbGIjLlvgoDa7P1OSXnYT1W+NaGfAvJ1e0hiiLZlxlgA
	 Da3jHs6lFTuU43Uoc/OCxG1v73oI8ZrgI4tq/R18Q+Tk0nwZ8Kl5QZnxu7FgiHBZGdA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4EBCE1F00A1F;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876106;
	bh=040g9tgoQF5ilNHm+RXbvx7PJjfAS0uRa+b5tR6vP1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JMUvuIMmu2IVKhS2sEuN+lVHsWzd5wVooZ+TpTeTKOYN4j79l162cv0fn+bGAx7yK
	 K/tLObY1SGQQI5dmtmawxpY4/SasfUbeIaVgA+ub0YKPZAIYhzTQnVfJrUP0WNqYFo
	 Cn2ukjTRjLkc3BdwEUSJRGzJZSUjKL2/7v8sDtl2EK8XsRbZNcGDXvaDd5ZR3Ehwo6
	 KlYM40+yoh7zGMs2wNxd971EIYCt5vj59VcF4xgPMb7yxfFAEFhwy+PIFql2YITwdn
	 Zm/SQ0eIvuCRU/8ZbnpJInFnVSwNT7JPLGIvwxu3vRMe11RkPO2sk/FCwjhldFw/tf
	 8bmvpuvhU9F0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6A7A7471F4;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:12 +0300
Subject: [PATCH v8 08/11] dt-bindings: remoteproc: qcom: adsp: Add MSM8952
 ADSP compatible
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
Message-Id: <20261105-msm8952-initial-support-v8-8-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1719;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=TdJtPJWcgCTApekSG/YSFXMQlTXs1iJDxy72QBeRJ4I=;
 b=T86QTCcFsFyUBp42pyRmNcskgrmpmOK8QjvuxWKygJkNXfzpP85MKuEolyU9Mwj3BXjGiAYcY
 tUmSQ1KD4kKDOykvEwD+rFHRKCyno1XbyObG/bYZOAgz7EEuwaX5hP/
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the ADSP remoteproc found on the MSM8952.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 31 +++++++++++++---------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 7e8ecae8e6cb..1e4650aafa82 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -15,19 +15,24 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,msm8226-adsp-pil
-      - qcom,msm8953-adsp-pil
-      - qcom,msm8974-adsp-pil
-      - qcom,msm8996-adsp-pil
-      - qcom,msm8996-slpi-pil
-      - qcom,msm8998-adsp-pas
-      - qcom,msm8998-slpi-pas
-      - qcom,sdm660-adsp-pas
-      - qcom,sdm660-cdsp-pas
-      - qcom,sdm845-adsp-pas
-      - qcom,sdm845-cdsp-pas
-      - qcom,sdm845-slpi-pas
+    oneOf:
+      - enum:
+          - qcom,msm8226-adsp-pil
+          - qcom,msm8953-adsp-pil
+          - qcom,msm8974-adsp-pil
+          - qcom,msm8996-adsp-pil
+          - qcom,msm8996-slpi-pil
+          - qcom,msm8998-adsp-pas
+          - qcom,msm8998-slpi-pas
+          - qcom,sdm660-adsp-pas
+          - qcom,sdm660-cdsp-pas
+          - qcom,sdm845-adsp-pas
+          - qcom,sdm845-cdsp-pas
+          - qcom,sdm845-slpi-pas
+      - items:
+          - enum:
+              - qcom,msm8952-adsp-pil
+          - const: qcom,msm8996-adsp-pil
 
   reg:
     maxItems: 1

-- 
2.56.0


