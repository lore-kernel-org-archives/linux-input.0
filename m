Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307759;
	b=vDtnvJxUa1+QAumo5OMvvpn1UIqQAszFsULEEkmVC5tXB6fHKs5ketBJju4M1EQLeBOL
	 FruaCXWf3BFvQ1U6rWoDWxpgWKK74AP1a4q/u5nHM8nDrsgre2yTEDxVJrbwXhRxPdSxI
	 DSpQ7niznzg9xla58h26ahJxERpxL8r6fUMmGhVfhQG2vxo1SGRGh1kxuXn1eCzeVOoMr
	 W348KYIAM8fHxUlwVe7+BvvfwjA397dxWTsiUswuVb5mQbmLumMdk4Td1NwTA1VhDpvT9
	 882OHBsKh35A7Szhl7Hr4LRrubeiCW3KKfkltW2C0HiqDe0dVlRVos24wEr83/TROzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307759;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	b=klVFUBlI4wlLi6fsTV67LRFhzaoiwPUs27AUhOL7dk4rPI4icVvVeO8W+Ek0X+uGq2F7
	 JEavwPhFVrkrT87J1YursyI/1IV3q4Dt0Jyl1YNqkJIgNbFTWrsfxg3tFqLezG2dS7oMK
	 RGE7vu9yJU/i7WlQIwh46Fw7K9c6UfzD+sfGMQyFSwBHlJ4aOgMzPb6ZwLtF3da3Tju53
	 R3md705vPt1IZNwbr3DxU4sg9EAu9dkrZlHQI1Fb14ndEi3Rolsp307l55u7JkhDjJ432
	 vNp4Zz1QJVY7LsAF2R9SRPM4bTWaJ+Ke21+pN9nXs2J+uEeo/eslbG5e/n8T2kUjsxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOAcI3j7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C93606A31F;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOAcI3j7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307759;
	b=gHsC2U1FimaqU7VFBPyHatux/oE4jGHuJeEKwpsmJtci1PXfMFHnpZSMo5HjWNVjHNNa
	 rvLW1q2Ka+qZLLPKMCaY6hOCriuVhm7cZOBQ7ez/2TyFuESWLqSUVBBQDnGhDvapF9m8i
	 ycOxTkCoazdLT4ipVNRWCRcmV20Z+q5w6vL2xTcmfxwQtH5dWnU3MjC7prSQydD5bJtRm
	 7SMIY+aH4XEKahNomYUEX7ieNoWJayjdxwvT8AR3WHbwup83DjgXcBDb3vGKuGgyhZ7hY
	 XGDCQ8Z4QqSfGL9CvC9aV/3A0LqX8q5aX75pzFhXhd/CeKTBmChLIvvRq1gvm6Kfk+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307759;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	b=KH79yAZWGaJ8JWB6UtVs1r6w4D8LG9RqGdi34uafO45t3AgHmsRBpEbxtIl0IIsrmFDk
	 YJqtO+TpGtdPo2I2ViGmdHXgGvCc66syMXpmQR63Gz70DI0OIdTXkRyhGeaTzEYFOrv5B
	 MRVU0V1uR83RX30WCZnL6o0SNx4jTt86uRi02EKtFLxWixclLQCIkoCOP9Bs82WPWU5x/
	 O2wEapq78tqR3bTzQlGM1lujZSr9cy3QkRJzCggu3iUmmVK21GbjENEhUJzQUEIJ+rHK+
	 FSMuQcr9LL4x2r7BEyl824XELImaDaPLIaehLT0ZWa8TY0ei66SQ/PcbdlytcamXAfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 347C51F01825;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307759;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NOAcI3j7Pjd6CqCeeEek8By8XRTez2mvUqu+LEx8iL+G7ZC6h9z4nOiEvoYJLMsop
	 eY33qzxM5pVJA41cNp8NU/qWaLFtso+QzoqrJqObyKiClso+r4ks3lOOkq4nGDyf2q
	 Eq7RU7CwPpccjcJV16pxh6COuDBJ7VlKQQw+RzyVwKScHds8PE1VPGhFunkQyIITqT
	 LhYEyBN4G8T99FfLaBeSy4N35+iUGTRLBhY3LgsEB5lqyek5EynVcJ/Y4b8zJ1qYW/
	 nqGmv5w+vZeSBWwy4WCBq+djwdov7Utm7Q8FmrHpdzRsD+WJwPE06oaOAgT3FlfgcD
	 8DlEv01nFwz2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9C87A45986;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:32 +0300
Subject: [PATCH v7 01/11] dt-bindings: nvmem: Add compatible for MSM8952
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
Message-Id: <20261030-msm8952-initial-support-v7-1-ad748ace375d@mainlining.org>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
In-Reply-To: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6JMvRgvxX2he4PG9Fo4mqxxQVXCwNkBZtmdxWuS+a1o=;
 b=Ho5sN1dY1oUffDS6VQODMFlBjBFh3wgB50BCyY6vcZPV2AsevVqMFA8lPuOFykbPm18FX2kev
 yeCggMCpEKICCAmefW194BWAcmjpSfDIiZ46pImTu1Wm8CZEqdvP0GA
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the QFPROM block found on MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 566304ed4c78..646f2e8dcf4d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
           - qcom,msm8937-qfprom
+          - qcom,msm8952-qfprom
           - qcom,msm8960-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom

-- 
2.55.0


