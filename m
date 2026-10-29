Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307760;
	b=Bjke/YGfqrpnJc6t9o8MP+EwCDlvrlCrHke28hX+EJSSUVKY9Br/WcahH5sKhHM8FENx
	 Kc+7ta6u28mot1zD0lIf5y6YgcEqDZKor0dQ2HoBA9nV5i3nM7Xob484eyphZNUM7VQqE
	 Wc1KzlvwqXbSbBm7CCTSIr0YvVqyiQ8IHzlq2vBDMURWLB+mcXaDuxrHVBHbLIzmpAe4n
	 FVl0OkT0K0iWanefzazd2s+whyrWv+DFOFzADUTrd224gm9ycfcgdlA83okyMGWt9zyYo
	 YyVPwpgROaoqmVXZc2knsjyjj+bYMEGY9h9ghiyfsrE1U7xErJmRsn55ldmZMq7AqUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307760;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	b=WhZzTOZfj2AgKFO/Of2eCEADI+WSJpm0wbzcb0LVcJ3zqFyg0QNijyYnG17skb+PiSIv
	 gZAqcSqB/eKRJ2FEZh/1zBKQWk23GfaPBHS2iNhGktlKYFbif76VpNQbDX9EQzs8xIQCx
	 6mfN86a3n9WwuXcObvXq4ylehfp5XkdOMI2j+svmpZ3J21uSxUKvhk9SDHG9hrQ+dfii9
	 /gmRsFX297TdvzwK9yunBw16x4RUJsl4sBmg6IHiR1wJ/Ei+N3N/Q7qadGRS3BUgwT5p6
	 F3i6INsoRqy3NaYXD6c0H80XTXiGrrlmpc+xX75FTek7PQpT4YPjdiuKEGwLYkjSSDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDY8B8zc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60934606A31D;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDY8B8zc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307758;
	b=uTee+L5pN9PIgqgWDrOeuhYI+U+bluT7E8v3tCCW2vKOPEZu9T/2laKYkvSpXEojWyZ0
	 0oWzlY2Nlx8R3qWh1UKY6uTi7E+zeg8ifHOathPKjmoi/oEgT/iwXcu55MnzOXTbNV7fp
	 xl9hc037Ixp7oRCIlODrQBAwgHloeW/EVp6tyLFjh28VvI270VK0gGID+HgT0omZ09W7+
	 +3HwkSr7n0kuIKHZgcDBD0EaPenU2QbFtqJgg2fjcT9l9m2LHXRtxJPLPVBlVA5AdIRD/
	 cUuvSlkJGyqI7XNXszmKYsohY0kwtMacjLxGttUnODHmyqz/kvtsoZJlZKRjxGVyqdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307758;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	b=rC8P260ShJzWhMMOjbhOTHiLLoXK/Pt1zXfVae1Fh9+thiFVKZbqAO6cIhlTIsCSdSLG
	 KY7RdOAlcTdo/4DVSj5W1WArS5uic00WhXomOG5hdvflCwzY2DkhSgFMTvdHTYpw+UGtv
	 TQNELu9dM1yEHt8RFzrYh460oq/nIqgNcSidICj0wwh5X05M48nDr1P4E2KeJPmA80TIO
	 k9CmPpvD7CEmONJm85+ApX8T540XYLEpg1hEe+wmAB+i3TujXfZNubzo41yq67Sl4+k2N
	 runYhWxI4YFLABNOWo+p8WNXK/joe6HwGyoqP2C53oStpXtWQHsPqKg/hmyu9+YtR8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 333AC1F01816;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307758;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eDY8B8zcrcg2pB1AhIXEwnbDP/87dnhRXJNUaLTyLLwIE3LdfovzVlDZKjRl2Usaw
	 sLc2ogmTnYU/+2yzKJ2E+/ISdDeLjq5S9F3L3SAzsfAUqmwGtnwag2+S7KwWjpfeM8
	 oAX/Ki/aEaCc8+2TIFCQ5p9nBP2/w3hXFBhWzxhyj2RtfSQ16dTtPqBqCVR7JMYFqg
	 Y9AIi9c0OkTpmKf66/2HA+ocE/525mBA3zUBBZkkHq4xulVd08Ac/JaRdd6rM7+sje
	 i3chWA4XXM/wVWDlxgwg4+sHVMJbzhyvbPrXrgnoAfi9l6LpN9pMosEI03wct3yQAj
	 rTR0r87cqR9lw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB75A459BE;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:33 +0300
Subject: [PATCH v7 02/11] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
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
Message-Id: <20261030-msm8952-initial-support-v7-2-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=ITO15xkGcBa687Mp0TLRvjwHoI0S0V/a2UgW08TP0cI=;
 b=CUV6F81gpfUw8kiilS88HlhyhRXY1d37iEYwKQG1zeedUVa4rjpAs2KuP1ZR7qLVTnR5L+LpG
 CpgYiZU71dMDQA2qn5TQVGrou12g/nxlkNskyuSpyNJqAVZEPcUMx3P
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8952 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 93a489025317..9952b9da9a6a 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -27,6 +27,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8952-iommu
               - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2

-- 
2.55.0


