Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186354;
	b=by8L0SCjx75OMIlLOezsXaw8KTS/xyxWWE1AaAxCznsD+vSpOZmxSpBEcy/rd8Mf/xk3
	 lXP5uufpBMZEMvGlLlwiiOVjoNICe/ZBQv8t6PcqQkPumuBfESGn3NMqjOyZ48/jFElov
	 PWaYY6mdDKBeU4Uazl/avU8nL1M2lQONEXI8eMSoCQwKuq0ihy9Fsf2pgPgKUqO+dX6WH
	 DfEbuVCRU/UzklOLegf77X3vWEw87qXtb/YZ9HnRwyctUa/u0W79OtrtruQCUnPeJ+zku
	 fO152WQlisVeg+YEKWT71P91iJqH3Kgh8GwK3zfbWybGqmT9IJQJUvVWPOXBdCMledw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186354;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	b=ehX27fLImNvWiHNwZLMrzCDSvZRzVpF/MEVpqJVE65OK15/d9QSxJgO7bShVYUxvir+a
	 XvyEVVxfpQqEaXNMhuRV46RQyDON6Pa4SmNNQlvzczPbrU2LMQ/Dw4MnBEI/zhJhWwwAf
	 d+ewidUwMM+SOLAoFGg9EIRDSsSadCjrv7tR9gbFtJFsXysOPFvpouMebKoLdxVc5jEl/
	 L6OwWACwyO1mQncm+GQTnSxSoTn19fxejLyYQamZE5Fl0ChIqoprRB/2WHnFNEVoiw5bD
	 P/Zb1Ztm4jTPesaebfAy1eGhcqwIDuykHSpS4oLAvUQQhoC79rAxxprdGQu07Nk4ioA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi6w15Kh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71A606A327;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi6w15Kh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186353;
	b=S3aUhx4nNrkdilf+zgHZ6B9CzpE+J8nIM0o+pFhgFREh+LPoR4LIhWariEwfHD2nog8H
	 IiWwlEZI5YHqVeiIGg+whbx9xxWpbgIf94bBWHskgv7Jgata2hFV/Czosp58QWB0TP7Oc
	 Z2rpCTExTtTZA6n0JkEpYOgAmBGmWgWnAQob5nhRn5G+0FnqxaB5aEBx4V2XnjdDakC2W
	 HsgATwbaQvU76Th83b7dvy6uIqaNREYybmuzWn7JY/lMkSHgnWPpnwzal68F21iNU5IHq
	 YXCw+PB80asT2xlNLebhuIbUIQwCbp52VuRowW/P5mlFrO//KY5A6K4HDkTu0ICBOsw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186353;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	b=tMzsGvMWQp7m2yiOWSUEjQIVS/6NTx+hhsnX/EoaFZgv5nTstJz+rU80A4nFy69H2Ww2
	 CWTPLysW3Ijsg3jk9pNF3a5Wh9ne8E88jYd9kZAJFQ4KQwtIiu25KOSXZyOpfbrVD/YOj
	 1Oe0JFz1/8CkWScGl/lIE70xvp5AJ0P5LpiM7coQclNszE9kkeD9ZXbjpVPENXn99B348
	 trA7bP4nBwQctJn9RLY0pQRpTJlaW3Hmep0bdR0Q1plDJAIuO15SC9Qs/GEoXigMXHoLt
	 TzfT78ojMYBRIFgDTkyaUCfwlL3XANDnb4+purFS64kIMZ1rkCUzNlqfwUE69qU4khA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 21C2C1F01825;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186353;
	bh=J1+OrXgrK2+f4Fq1WvJ/kjh6om47z7wamLYA4BYVuWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wi6w15KhDa/L7FfgAzPF609j7m0E3QWDCi8kmM0lsvZBkJUou0amZ9RM+Bfx3FRRi
	 LiE8BfBzZ2Xya+wlsho76qV25eeigLvvQT/PJY38is/c0vecozZqa1nf6Gsr31c0Qd
	 uPVivJ3LS6WEXoGOE3XcXmvm+j+jtZWPnpATklbWzrzBG+UmHHcknXA1yJiceKjhKu
	 PaoRNA2tTCV986HWICJOOMKv8d+iZahj++umpH1TBnZoJKyhaHrGvs0EyBas23///Q
	 esMAlz1WXptr/+iLK/+e5hX+tFZFt0a0gK/hRZrOFFJBA46tKo0RRwME3SzA6IEeiq
	 /pvtQh/PvgR9A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9ECC545403;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:20 +0300
Subject: [PATCH v6 01/11] dt-bindings: nvmem: Add compatible for MSM8952
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
Message-Id: <20261028-msm8952-initial-support-v6-1-e07ddd8bcf4c@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6JMvRgvxX2he4PG9Fo4mqxxQVXCwNkBZtmdxWuS+a1o=;
 b=eFxhaIJBFJRwEG4YuRjlJYkHQkgP4ol3CAcS5l2JYB8Rkw5mXz63GtI8VvCqCHdxoGcGsFfU5
 k16BEjt6Ts6Dd1ew9ZGR84jCd8NVqexao5c6kAjmD+gnY7SrNQBCR8x
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


