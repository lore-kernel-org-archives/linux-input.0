Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186356;
	b=t/3qvUFgBKmD78olOgVJUMBTRZ84d4B1ym3c6sjKNajLoiUjBScKHT2zDFoKpNABbr/I
	 Bz0hLMFRAEDKkGZmE9telLNg+/UgIVmCLsP+PN/2WWpR6pa0Z0azMYvycNt4vHnH9rg9L
	 SCViuyvejPDc8Xgzpw5LfXXYubds0LV2jzoFTDnSTZqq4Ma9otHE3sjsF78Rws5HCnZF6
	 DistWp1IpmbjadaFKVZ8Jha+W23T7dxFJpCiiVF1hW5y0WhWdUPnY3BRonMlet2l2LwQs
	 84QBlA4fzOQhx1ghIXtQM17BB4RUGWSOjKVtlbBuwAetQ5VBFIVqUgxaaMqFzlhDxBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186356;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	b=HkF86KmGt1rrQwTnwiVwFboZvPKOEErhzS/GTqKqSLU/AClyBTmkNIbMSz3IMrRCbQ57
	 +uFVlDxdVBJMjC++gEH63RHVFAIp4tlxUlyzZWcTA1t04N57WVaMl8+CZNw0m2OBePOX/
	 yXq0nFsVwXrXZuSG3NuIgtMbnHWhiCTSqNKVJioBNrYSCnhkhLjbGKo/zNrIVVNoB7A6I
	 +u3BVaEXkhixp/IEz8UqfPyXcNZTfibdlwjBUeYz0BwBOn7NWdCyIrKYx5gN5G/i/pR8H
	 MtiIc8cwRHGfVqfhn3A8WHb6yKtifa08ZoHcBb26NkCoX1cfoYD3VVW//tWMR519ySg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwsAPRhA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92826606A33D;
	Wed, 28 Oct 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwsAPRhA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186356;
	b=RbBEoi7Q6WS0VKUv2W8OyO3u6i7dYDzqMiSHE/KSS31TQqCU8n+PRvLO3PeBL5/RL6Rr
	 aY2UJAD5n2svkRUlats+mRC5xGfQbprnAjR9Z5tyhYMh+f05TPLH4Q5IIAgmSim8lw+mr
	 30JKJtx06q1ti01GvGmonjYRzHcZIrBFjuKun3PZDRXYZEJIuGLihth4sgLWEyRITipBy
	 Kh2SfEyegzTp801V7gYFsiudefgDTLiyXxHNzXCjLpn81Vc8YKN/UAKAZrlsK3n2s3WVV
	 2LCNCdxQ1QN037oxWwLzH/MIL28kxYREie1xhFEj7FT6IO7XFvBNPDarbfgkUvGaCFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	b=tMc8eeYY4Wygc470W2pTAzQ5ruR4qHtPKwxCogIutoDUiMOJ8l3C5n9OMSui9fjt2yGh
	 RtMR/43togm/8r3oCbIvbRy9o78JXwMqD81+f59aaq6loxHpHJyXQI9e2lL57BBO4aGbe
	 s2o9GDAaekQlngsxHxJbasl7tA4onYBqG1BcEgtzFXXub7/Q4jrPqQrJpZFFvhC7h6n3h
	 Un/hfJtqRq/iL+0y21YjuiySPCKqcesKf8GY2UF9ghzERJkfdFg0W9mAb8csHGsLTH88v
	 Pcw3Bg43YzrOyYc1niTGewxQZiZsoGRPDZJm3Y70of+6WZfmp9SDctkQW4jzU25438Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0C9A31F01346;
	Wed, 28 Oct 2026 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186356;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bwsAPRhAEPLPdAEgCTM7WLjSXg7Vejdvu48r8z/GpNvVoUsLmsouTOkLB30DYL3Vy
	 4/niltAuHaFH4fBgveGl7OFsgnuWg62t19mXfZYShvPrpL6bEGKAbgli800BcQACdQ
	 6vGFv7xCdCdSTK6fAk3q/PZurmzuX6vERahCf8Bu1a6lyH8oCc5ZxuEBybttzGkxqv
	 z0S2a5APPLdPdMCOEyX8WzGh63RDi5C6VWJ1PGeLUzM2WssD3rr0EDuUwYGccBCy2w
	 hCR/DQMvowgNcPhTD6bG8WgB9GS6MflrpGofJ6dOxPD+kfYuGIqGJl1i0bLhtx2Ziu
	 6IDoyR9qhL9mQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 036734542F;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:27 +0300
Subject: [PATCH v6 08/11] dt-bindings: remoteproc: qcom: adsp: Add MSM8952
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
Message-Id: <20261028-msm8952-initial-support-v6-8-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
In-Reply-To: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=1646;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=zeeDd1bkkmg05ycXckrFpXocFkJ+mpflUejuSXRUXv0=;
 b=OElJ9nUeKVZWJA248QF2W159acvwuJ6ku3S6WwmY1o+eEbwBHSYD/Ft28uFyB3WLJwvbND+ZW
 gnBrLNTiiHQBWV7uLF3mugrhoON0uWCgFqLc/9UW67scjHs8jVOCnAF
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the ADSP remoteproc found on the MSM8952.

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
2.55.0


