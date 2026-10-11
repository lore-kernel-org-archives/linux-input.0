Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F634C9A6;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737532; cv=none; b=EdfxKrggvB2kcJaemAg1ni1z2OCwvs4TYf/wbHaX9srmSTvg6bfjRVFLnXjY+yFcJqR/0XuexTPNZvH6JzDhEQ00vv9/eQ6dCBOg4GFupLHUHoalEcNiKA6BdrxYXvpRnlnsB0KX9GXFbtfV/RGRg+cIL1u+pMp++Xhbtf0+Vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737532; c=relaxed/simple;
	bh=td2I24nRoQ5+bn5CQxQqEo0inmSjlf0k47TwwMGhEuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lznFjYvkv8zbH/fFCyTqmHqVYsiMG+jIsITRrFCFNIgqFb+xUJRHe+kyindSJS2oOFTmXxfKiFymMhdxuywUsvwXxEovTNoSyh/UCbESttbqUJ0+HumpghZ6TL2hjinSUKS0z0y2Kd1Xya/takp5ZRkUhX/DHgSnhEolqZkx4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOYfk7hC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOYfk7hC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 566F4C4AF0B;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791737532;
	bh=td2I24nRoQ5+bn5CQxQqEo0inmSjlf0k47TwwMGhEuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mOYfk7hCsFxctEl8DpLPXbA8Co/0AfvfBv2t6+XLYlfIif/YItMNUIqeY5bdYMyzD
	 xIEl0VbL70+a6LvUoawaWux3gUktlvLoIg2ARb9T6TBi+5qw4tDJVpGM1sHvL4xG2Y
	 cYYtU1syhtaqTUYCw61urzNjD7CSFZ+sBO2n53vCHEg19oDvmR5PDp0bvBOgE79jeM
	 0PhanuW5jVfpumU8CKd9uS/0jUGXKfg0u5A1tNZEXvwUynnoZX1EpxPdrXEa9CqD5H
	 Y5Z2Ou1PZyzs14JXaGz/6YiGrVTyJNZS9qb4mTdNIs5HRITjmrtX0ZeHPz/6GKle/J
	 DuwSGObOhWvqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793ACA9ECF;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sun, 11 Oct 2026 19:51:24 +0300
Subject: [PATCH v5 2/7] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-msm8952-initial-support-v5-2-1857074992ec@mainlining.org>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
In-Reply-To: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791737529; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=ITO15xkGcBa687Mp0TLRvjwHoI0S0V/a2UgW08TP0cI=;
 b=m76TWNS/Yat00OIAy5Qh80LXCoUB5NfPswR+KOcfXkGHQrLab27a2eCCeFLpEGI/T1wnMGXjI
 guKTnMZv7vpD54GmHW3RLL2Mny+BXnhwJB0QHKvEH+//hdhyKzMZ+f+
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


