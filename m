Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186354;
	b=ULaZieq+qhQ6WDT+HOZFAmYyAamCidLUcR0hRr3VOet33HkjV/5GUXBLBqkh5S+acNsi
	 JwLaDjX0Y+IQ/UVbFc5/76FUzy3EnARZsCAJlS0ZxeQeXCYYRv4HWDNG+5AvuALkV1aVa
	 m2I6mD+dwQ4vkj/EzdABW7u418nTdc+CYyF3ia94pAo6xLoJVc+HEaEoN8843vv1PrMNZ
	 K7ewtzdSEUGxWm9vmAKN8KWZOfx3yrkXeWJM9hD7lhp1Kt0ru87OQCzeFrVJkJW3eH1lL
	 h94pcSZPu5SmI+bPoryL3x1Fzp23hOwFK5ph8XD0bQboIg9IuvtCTl9Weg8TPlSMpuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186354;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	b=hYPqgT2f35dYtyiUf42Z4JKJZgAuXzGQWUVcXqcxBHOSZRRZmS5seP2RgZMU3FvLlDst
	 TCH8uubyz7klj+0tP46UH7+Zw0SYUt76VbmJB0qHARCCiHn87ciUUh/GcjeIWLTwlsFBc
	 N49FKm4GJrFa4vDX9+EI5TSqDRBWE0oUSZM3/hD1qz0tUX09K8znfCEs0A913fMR9znzY
	 1RVTBhYbS42vVTre9H/KbI9TYm6/O2USwsV9hnm7F+PeMIp+9Io376QJyO3RKvPQAyi1/
	 MwzslqKSi0m01hm+bcurUkE+RYeFHiTZ3IR63rcxGHhYJKEQUc09nuyHoCa0wSH+0Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doGXCvlG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF5606A32C;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doGXCvlG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186354;
	b=SDuJlp14ZJNGbIBc0kzWCu4PF5ssQB7m3Cj5zvLD1/WsDv+CNA4WWMJCxIrZ3/LvY67T
	 1hM3nzl6ZMBK0NLUd2YwX24CVJnVdXEDyyp7eOZ/bUOUrBQ8I9arlCZJ1qYMF9h5c6u6b
	 41eu105XUAesmBlJ8dyCxHYsyi/uC3uQQ0kw+0sdeVl8amueCoM0RAcfwan+pK9enPqad
	 alHnldDYGHP2wJvFIY5cTLmcwLZs7bFkpB8/NgQsJjVmAV5K6FP4zqarhbSD6RvBvDkbL
	 xLh+RJwoh8X0nxCZ3H88bzcuKLRWc+iJ6YuB/3Z+620ecuRsjU9hUcWBD4TQrvekiYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186354;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	b=3MxyttweVjOwu+1DBSwdN5nxGhXGsHFTWI9Tn1VsnMTNlytewUXWHktxHwR0D6D1wRdb
	 EqeoqlzDCh9kTjOkrCADagaDUj5ibhZ7BoNLpzZ+KukbALbVgFLWN+7NeZyAji/2EVyN+
	 EgGSbI9Zj77BrSn8VZB2fqoGdVTrKLHNfsMkTzgBZqP04lu2kGShpdMVYIwTLMqyus7Np
	 3C97IbxYcj6WRmSxFlXDA6Dg6FwRmgKWjxE8f0cxsKEF6UnL6nRNd9f2L2OVfbcV597yx
	 l1hGuf72+SN8gP6/8OkfqOcJ7vUSTxYuRDeBEO4h/6fvifz2xAkhGM9CF0lXmvTlu6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2FBD01F031E1;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186354;
	bh=g8Sqic2cOdKyz7gLzY8YHf0mVtz6soexJxJCuTaxVbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=doGXCvlGzHsMLVq5iL11JPPq87+5k1QIAJa+3JMGzojZyzTBCMQ/4nOJo6uZtbeKo
	 mEY5NbWnYNMCFzDIaMrEIOJa8Q0UlAAEy2htfkXfK6wHZ01QPEidukSd7w0uNfxEzb
	 BlvQaKIgY4alhnhwbuJfRaAsi/8eOMRWHVxCdzEOgq/P2ZZOBB/Ma0R+wfrUaANzhy
	 lo+OsPjZqCGw9K4TfOq5AiTMDNqthRAQHZ0FRqRFeFs4KDNrgP//WgFt40RBrNCoor
	 CmLz3zyv3shf5mVH6vLjgZTzRChguiCblxF2BkOcekzFiChKoSAfqxIiRucFGV8Yzh
	 L+ml2XlwD93jQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AD13C45417;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:21 +0300
Subject: [PATCH v6 02/11] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
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
Message-Id: <20261028-msm8952-initial-support-v6-2-e07ddd8bcf4c@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=ITO15xkGcBa687Mp0TLRvjwHoI0S0V/a2UgW08TP0cI=;
 b=bbQ9B6ZoQ4CoytedQ/JXDc2wPLkfC+fkBp6G90/GKqHkDx7uw2JbSd1kXJKeLW7gXIYZCAyvc
 RiNyjtD+3PsBdiW3MeVjBZDs5EdVLeBFpeGiimDFRPJzkq2+uXuskO1
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


