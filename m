Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307762;
	b=bc04eTtQeeLKzpNiLVbSFj3/btzI8sTOknjYO2I25LaL0rf2ogit/g3ia5vv38ZTSbV8
	 wPNEHnOJZ9yXOMNG48LCWSZfb3ftGj6MaTmejrBVW2Em/oRcmk27ZQdpmkjHq3+AHiKjA
	 5LCuIfSF657LIoTTt0DXiPEPM9IkM7exrbjVfWwwiFd1bziF7doYE+R96Lw53MyRwTQtj
	 zTV/kJkpF8/ArmDhjH/Tv5lwL/Ugo2zxopoBmYjTwc23NFZA5lwuMYRNFeG8iK1Km4ciK
	 /Aj91YXefPxpD2nRFf1FBKwlfy4xoP3qZFE0D0CxZAvvrO7z1D5ant66W+rkC4TQ8hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307762;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	b=z1UTgmhjj2m2CRayXsHiQJLL4GDUUq50mMzrEVI+OZmCQduX553J5Lah0ZP2JWfVfhCB
	 aM9FVG6lFb1gd5YEXC9EBsY0y9/W6CS96cgRt08UPlEN1DboHXxcXzPhEaXqOylup+lVc
	 5Q5kM6wOWEhMUYVE5L0NLv5/pcGRsuLsNeMNlj7eOhzbXnhlumHNCgZCsrWctR+J5eI30
	 U9rQp6BPZDOOH3L6YZbo1ARTm7vRdJs50UU+Fm3mqcu3vNf1Yah+K2i+JfBc1GlU2SCjy
	 5pGQO+jy4LrZ2WzKtdZR4qESWHxstlpmyCfPo41lDRwhGTHaLghFf5ijvCkcrtUP/WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDpSWw4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFA606A336;
	Thu, 29 Oct 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDpSWw4W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307761;
	b=Rb8EnTt/mWW9qlQBKtcyb8YjaEtch4ZcttUlcxnjzn3ldniRCD3sio38F9zap0nD520L
	 tL6CNIn/b4axh09AgVxHSu9FXQ2ZyO/yD3wk6BphXqWmKu+2/W5mILfJ9tpYOpXlNUH65
	 F+L0Kekf3YIe2/N4kLdTQ39/EW7zIZCow8L0HStvRwCg4JmSSBGVFaryvAzlo/GTQz1jb
	 CCrMluX5fsFbtz719WHcqeKU0g/xXZqvv0xpBDttTL2kt6eEg370TlVHpq2XdoFw/JYtI
	 3L3rRZdA6E63MRYLFuXTclPeYrE8z1EJTYKcEcft3th53ZcuD3WX+nmj0YmfDJo+k4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307761;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	b=xHEaODr6Z8dU9/QzuSn8EDbjeryYb94yVpbNYnLM0BCUr1RZ6R2df/Z2giV73nrxFAhF
	 Z2AbTVEt1/Ruw81h+RUxLHRgIsjIvXcV2Pls856uXb2x6N49QCH2A21e3Zm7kqe3hrgX4
	 nrf4Sn3w/sUCc/3/3xKHyKP66Apuez+LvmWchWPs1aZ3EirkEfQVnL9t8XnXEIE3SBmcZ
	 VOApVmGJnuFtCIytmx8bMz+SPpDPxvr9+CECHMZJSC3XQ709spPRUQTOAjr+PITsp6Qh6
	 XWQD/iDwpx04GmKoARoJG772Hw/1M80ztNYbg0P99zLxX31Lz14ojHATfCzP5wkp6Tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C9D721F031E1;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307761;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TDpSWw4W59AKLGDDYCjVCie/nHEK16eYDl9Dg19xFIFrnl9DT0x5J6BKGm/eLihBO
	 Bp2G2Oz9vTA6LzmpE/leE1uxkFH/1DNLoOi/BfVZNGTkju3V2w8zvRJ2am8sakWMqn
	 HbIqxaN/+Owua3ygS1VOGAAyDU49XcIyLzSG01MpOTir0i7y0iFqLjk3zHX9jbnCq1
	 4ycmi+5XXyUJIofdUL3cKPlVI4g2MN3ru9/IgVpFHTHl/uMm8d0FrEzR3HG1ct61Z1
	 M+kPoTKnZue5TSKdtEWKylL12kXaGAh2DKtDUBGK48WK/I7KOQ42EKhQ6j8lQ3KMwB
	 1tSFQtjsCKikw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 042B3459D2;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:38 +0300
Subject: [PATCH v7 07/11] dt-bindings: display: msm: dsi-controller-main:
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
Message-Id: <20261030-msm8952-initial-support-v7-7-ad748ace375d@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=1157;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=o++ptew9Ow2rBuPiY/JBHdw7xKutwMrQt/b2OznM4Wc=;
 b=nOBi0yzAQJar2cg4/mSbkfcTE7ca63iwygljAxIdtpcSKawrpAfG7tugw8Lb2Y6JR/nUWWN49
 FhaRteHL1QkBPgLnv/HuIYXKkF/ItE/ZpeS35QlCxUnGnDveFlVfnKz
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the DSI Controller found on the MSM8952.

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
2.55.0


