Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876110;
	b=1q4msBEvkze2r019Um2s8ENTM/HSrP3lKEIlw1626GTVHSJdcMhyZMVb5M9ncJbnKtJU
	 wPPn0kUg0U83Q6EhW4dfUN2+MSg2h3uQGrzT7bw/8rTZzXB9cIALIgzu6TO6i8kzKsBdT
	 g8nH3yBcC1wTo7/7rtpS7qQQ4qMyUtob6av/i/HuvUoyuFufYLoYUB6FtLzt3SlcpmeZE
	 UL7dy0R/7leCHxQSTpTndmVxv9nHZAsRT6GDXpc6wvY4Tzq7y6yklDj+f5tPr/3Z3FGTU
	 64Nbfq2rbRWxRrFD6HE8zSVw+SwpQPlN+kTxkM0oqMRXGvtZuoulGfLz7ODaJs2X0ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eqtig5fCjOjVJrrKZpZL50g3TFZKrPCAhqPARLo2Gk8=;
	b=sCAXVHYgMgy1WG5dHlOlr7DZ6GLUgCan4nvhHV8CYRoy+JbvL3Wu5Thig2FThm2wmr2T
	 oqTvQUcGfRV/jy15Ni5Rt8dpxWH9ec5RwJEsTG8e2hNNIH0cH3GJ1/nUa2xZdUhrZW/T7
	 rTcEIHAOVV/tVeM1NqFfsC/GRUSVgarBqYr2qgqNi40z4vnPzfVOlEh9mXOQptUGpKhc4
	 s/GwRU80lrgsZuEM0DvxmHIY/7ydVbwc1v2hZZ5hi3civv5rbSrC0nMgk7GZHQhyccGoq
	 e4dkBfEYjHp5YgMYve60BNcscJrcjACTgO/y+sli3uLAIEKibBJMUQCDj8c6yc7DmbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxUNwHI9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD6606EE80;
	Thu,  5 Nov 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NxUNwHI9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876107;
	b=r8/0ZgQ8IvVY60MhsBFnNbrgvdqsAl1Y5JuIQ6DqTlf7XkDK9ue8moos1GrdVeWhebQd
	 zmvuCAi1gzuLmlVD1A4yh56eC0UPGXcvw4oUnhaQauDQ+BU2lst7v5QB/OdviAWlrHk4d
	 9x30cWMxEz89tr+c9P3xnFL5OTXFvAVR2EKi8zH890MZ/iAhgqxe62kGRuL9iycwewbgE
	 SRJ9IXiDLp2HwaVqTEzjqy0p0FkomGJ9WshkCoqXaBTdHTR2t7dAMiAoQXD3FDD21kEg1
	 aJuU6LC6cnASsvq7+7qywiDXuvgLAXxCNvWKR4NzekiqXQCqRu1r1L0YyrWdeKuX1WQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876107;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eqtig5fCjOjVJrrKZpZL50g3TFZKrPCAhqPARLo2Gk8=;
	b=md74BaCspjGeRD20aRu1C2NUNKfMdNhGmFyR0ZcNS3JgULTaPJUZG1646TkOydRq73So
	 xCwivg6qfpPELTxtWwuWIibGAUnT4VRn1UPWr0nV/DAuyA3+pv0RKbXngMIPfZk/24U6F
	 291GKzND5eBm02mlq7mXHqlcMMLbJbwKqMpp7hveR511kH0beJV4ANA+cEen/MMxlTYAk
	 s1JD22Dgtg4VFmgh7PY8PXWCqXh1xLujiqY6T55+x05v3Pquk6h8pzW7Mv7NWf36LcsTj
	 aT5YFqYmg2WZy/OJIGsoJgzYSeZOgV8g8GDkgH8ztqk3X4OS2M+NUaHJetaNcKZs9Cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4DF831F00A1E;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876107;
	bh=eqtig5fCjOjVJrrKZpZL50g3TFZKrPCAhqPARLo2Gk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NxUNwHI9rG2DOHB6dc0gmcOAGpPGgDh96ebvElScVF7uikeig4QhmpPfnAh6IGZsh
	 wnMHq1cPgc3VbsdmcP/IG76F2q7bcvE3TJzqzZO3sSl2iwTEKtqAPo79n6hQndaE8S
	 iSOIfB0b1SKQNuuyWMK6zo5DqnTNqBhdS7d/o3esYuPutvpkTc6SXgHX0kq2ZtlD0F
	 htgQ+8JKT7Md8z6nZ/ZS2A0B/UWQE5/tXD05MJ59TGWuQ2ZhFJJ+rQz5KslpwiEH+t
	 SaaKlJxNEwmqVIL+WMJhszCEbWIlmcjN/AF8weKToWK4REo78uv7Qv27OEc21kvi7k
	 WConI5rGFtI3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 59BD9471F0;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:11 +0300
Subject: [PATCH v8 07/11] dt-bindings: display: msm: dsi-controller-main:
 Add MSM8952 compatible
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
Message-Id: <20261105-msm8952-initial-support-v8-7-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1230;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=tE4ESt6GLbLrou2AMZ3vpaz7ObZA7wbkAMXSAYph8E8=;
 b=yD38J7QlQ5YHfbQ0SdqjEMcRFJ861/b4IajAwjl3suzukhe2Rs+U3loQHHNsJCe8NLrd0Wkoa
 HWoFzkab6toCwCRNkGusupAbdieF7EygivjjRfpXUAjF2KLho+tKU+e
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the DSI Controller found on the MSM8952.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e4fd1cbbd4e0..8b352380827f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -19,6 +19,7 @@ properties:
               - qcom,milos-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
@@ -271,6 +272,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
     then:

-- 
2.56.0


