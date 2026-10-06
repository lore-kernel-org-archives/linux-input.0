Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E613F1044;
	Tue,  6 Oct 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288942; cv=none; b=d9fZbNn8bRpNoFIzpnyIR7k/4SgV/OFGhk+5chPWwdkokNNBY7lgPwU8iKCCZvPYZWUFctV2HAXNarEbongopTUmSir9Ug6EqAiez3wASn4Rg+rItjWymzEXdx/IpJCIGH4p1bDKwzcAY8ceHwyg+aeAYT7FqIhegkuDZTFV1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288942; c=relaxed/simple;
	bh=td2I24nRoQ5+bn5CQxQqEo0inmSjlf0k47TwwMGhEuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaXRxWnTCmCJOUqbTA2pDtVFTVBIBAkQcZZ7fcICTgSEibqxjKGZ7iX9sgMBqx8vi3c4Nf9TVHHoc126RLZ1Y2nXW3aG1epGIJDAsjC1WoT8G9/mTFNSLiMEFuBEBeMpwJRrPnBHrDusq8py0NrdmccgWV1sL6T4vqsyhJIptyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctkjs+Yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctkjs+Yj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1553C4AF67;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791288940;
	bh=td2I24nRoQ5+bn5CQxQqEo0inmSjlf0k47TwwMGhEuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ctkjs+YjExmKsGR6kzAY7qGBTugSc5JjfabXHkyvulnFEVdTXbzW+0dfrs/9bS1Vx
	 /u1lPzPmJojiNSaSPnQlBJQoSrdD8356CTb9rvjgjfIdDj7+Sw8AX8IrBkysyN/0Pd
	 4k7KyyIhcUC+wDRO8Ko/ZeQoJt8ijyFBkGl42vQ7/dtkWkTqBfkovlxV6xigvSPgBD
	 50V4lAbaSp8IhysfjbO+XgwZjYXkQbMURGguAAN3W/WPK4X/Ffe8QeOy50GuGvt5F0
	 l6wtnO5QJcBkfy9Jr60il3oMQUcRs4LMTzp+fTFAyfoabdtEjC8sP+lWJ7UOL01jA1
	 GbHBInkK9kn4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790FCA5FED;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Tue, 06 Oct 2026 15:15:09 +0300
Subject: [PATCH v4 2/7] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-msm8952-initial-support-v4-2-ecdcc1ac620c@mainlining.org>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
In-Reply-To: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791288938; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=ITO15xkGcBa687Mp0TLRvjwHoI0S0V/a2UgW08TP0cI=;
 b=aR9iJLeo1zn3F93QVjjTRCrpBuq2h2NParpPyp9IuREEWoYQ4URPKzNc19opyDaCKUd7bBm0W
 +zcGnI42ws3C2QPlYWQ/1tY9Iw+b2PTXWUWlhQTQm3nU1zUUA+TdUUx
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

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


