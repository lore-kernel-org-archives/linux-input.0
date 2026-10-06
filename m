Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CF3EE1EA;
	Tue,  6 Oct 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288941; cv=none; b=q4nXRW1XLQZarqmdpaaJfbE63m633Dp58tNCzHzbV9wT0K+vdIhqkfQUrc3tFts2aYABDp9/Thxs6O1euh5ejtfS+ZtCn2GUKGwYnwdivWmjtizSVJH7DmRCkDfRgS23B+iSbcWB0nmaE37SagCyNhDf2ExLdblVfUS96PV7Ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288941; c=relaxed/simple;
	bh=Fnd+0sqejGQ0KX+O+NuogAH/m8bc5UQymiGVlXraqlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FP869nNhU0yTYVaarFfFQ5mu2h66nzTGIpkCTYMj3zSAWED+geMLoTCWtTp6KzScbICxLfqF4Z4gSllYbNl/ZlmaEJ5G8R0q2c2CmY8yC/wdNLx7dRCMXsBXvj7Z05ZcWaM+1IYrq4ery+oD1VbUkN7FC9ouXD7kLl8FDrqFPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCfjW0vB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCfjW0vB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B83ADC4AF13;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791288940;
	bh=Fnd+0sqejGQ0KX+O+NuogAH/m8bc5UQymiGVlXraqlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XCfjW0vB1KsnqT1i9YGvyuPcci0RHDv5nw79XHSfBrj+/yMbgy/DpZ2xe6CHfWhGm
	 qcSVhYvF6F5lHa2Qo1s37Gmijz607mp07BZejqG+SMceBNktFGfAAPsOycLdqAXnXc
	 ycx5WT94H2cisf+4GJwJQ/n9MAMxHLMt4qnq69ei3grBZWhJoSlX1/vG5bjJ3VtNv5
	 q2znEBNKxh7RsIqRvogCVleRyfY/cLVcjqEKR9imU7UEyI7J5y5xFEYJEYyyvFinfe
	 h3c9U6FuJZrVcR1PPVgJOQSsYRstdVHX5XEbBAFAlsX7adZFftibC5uyAIl9fuEzTj
	 HJBvS0+Ql30eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F222CA5FFC;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Tue, 06 Oct 2026 15:15:08 +0300
Subject: [PATCH v4 1/7] dt-bindings: nvmem: Add compatible for MSM8952
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-msm8952-initial-support-v4-1-ecdcc1ac620c@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791288938; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6JMvRgvxX2he4PG9Fo4mqxxQVXCwNkBZtmdxWuS+a1o=;
 b=ouklt+iwE6o9nsLIUAQgB9iEEYplHi/tr4MD/pww+XopGrZ6VZMY8KL8FK6SrhZtjaewDN71Q
 0mQunLAN1+oCf9IR1Tp4He1wP0MJEW53wAJLlHKP6gUcNVqyZ/O2S7a
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


