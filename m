Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9A2C08D0;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737532; cv=none; b=tKCPyi00QwWCIh06G0zWhSLY2fgxpxJ1TFdWFEmSiQRV1frckFCjCki6fJVNryFCkfjf80B4He2dXr1AfgEaJWgATztoY5Uoh9uOlCfI+eleGgVK8Gc9muAPbPvZ3VF1STnph46gLu0++pExSi1ugthd+fpuLT/ir+ukV192Avo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737532; c=relaxed/simple;
	bh=Fnd+0sqejGQ0KX+O+NuogAH/m8bc5UQymiGVlXraqlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HV/wYipYUoTn0QNevHP1zAqr32x3hLiLej/oDp4OVtjaUzfO4raHRAT35hJkHF6aVstuoEMrPIe7Hu3pcBufy+8U4RDe0Cz9lGOLbHaMsi8rVH8+nJwxU4vUtRtR2dY3OuHIazH6s1UWoNlylrhS+wltUXVJomIgsU2aMZQ3SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd4bKnHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd4bKnHg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47AEFC2BCF7;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791737532;
	bh=Fnd+0sqejGQ0KX+O+NuogAH/m8bc5UQymiGVlXraqlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bd4bKnHg+wjZuVfwKpmiD84UKuxdOJ3sShL+ZX8nB+2ZkS8mT6f20A8IA/BKHrRg2
	 QB1TL3b8ygtjQOfqnodO/Q321YJHCbRzB1nBq3rMQE2vdz2h3QZdVAR2BgWVJrPJaI
	 o9jQWVbWT3P7+GWyasj5gIdfp9YU6LBzCifboHrb6aI5dxGg0X+BlNdAyNveul3VCq
	 /cG3BEe7yjySV/wTK7cwXJduzIuE+fDJiE2PpL/dDG/pZ3+aejF5ySejr+OvRB9QOZ
	 q7JvOLdUGLMgoseWo7iSGDII/Qdy5qSIAal/GIVEs4/FaP1g9HBaw4dTObcYhgY5+g
	 o8+1NJBj7Pngg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571ACA9EBD;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sun, 11 Oct 2026 19:51:23 +0300
Subject: [PATCH v5 1/7] dt-bindings: nvmem: Add compatible for MSM8952
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-msm8952-initial-support-v5-1-1857074992ec@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791737529; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6JMvRgvxX2he4PG9Fo4mqxxQVXCwNkBZtmdxWuS+a1o=;
 b=rTH5to7L7PETOvi7zfk8qVjP+OKs2EQDB5LNVFqYdp3+qNOlp5KoTUPOPblmkyzWJN1JJcOOy
 i3Rs2ntQoFWAV5PY4KEe515nxqt3+T/VywnON3rPX1yqvZ9OlOshiHN
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

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


