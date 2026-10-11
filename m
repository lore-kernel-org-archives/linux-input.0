Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7434D916;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737532; cv=none; b=lZ+IiHifY6yityLeNX45uLAV+7MtiZPuHMj/QAP+booCIxN7fHLpAv4r5mUhlYKHY7gfrBgaFvfTR04XlZacdNzGSs5LBR/O6SeSp261fZjHlf18rjKtJiKArJEFknK6O+c50sMCWM4vou8vnjwE2BUZcziTogTSpHWvXPNVt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737532; c=relaxed/simple;
	bh=01L3auXbWsKqF5qDXyY0RBxMKrA08Ada2I0PI6iBeVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ofs7v5pYLDljp5AVPy17CGJX9vf+iiWnrkO2ZeqPTcBSiT7szoepzmzVHOqvnVRY1uoYA8M7CBxXSY8LU/xp7IisRDjIeJHAnvhZUntKxrPMJZoow5Rgg6KFNHozHRr8X6bEcpAR0X46ApugIDjYr+JitEhMjKEDAg5YwkuG620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgm8XePm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgm8XePm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 661D0C32786;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791737532;
	bh=01L3auXbWsKqF5qDXyY0RBxMKrA08Ada2I0PI6iBeVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qgm8XePmj3gTFNoe6UgoMXJ0d/fFSsCmp84NndLQyuC5qjtjOdq9+OgPJQNmokF8W
	 z/phgLlY0bSVhtanibaXbVxYpyiaGO1SQS4y/wjrk2o0GnpNXPhtBqpwAoe14GTjfH
	 NNtFiQvF9EVAAjfVgLQNwwne2S3tiaEuRkgJ7QsKQRwb5H18qOXT1u0aVH/FR7znco
	 l4RLdZtfW9t8P16zErdW05k1JD/jPBEsKFMQXMBHcZUnRuSK6BUFZNTMzxVjNT+RYO
	 DDnR2BuuNOK6Umb//vMpPi4UVesjPrQo50UpkZnNUwrKNNo7lqtRdzudGfGyxFV7El
	 cFY6HwwoP8CmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC1CA9EC7;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sun, 11 Oct 2026 19:51:25 +0300
Subject: [PATCH v5 3/7] dt-bindings: thermal: tsens: Add MSM8952
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-msm8952-initial-support-v5-3-1857074992ec@mainlining.org>
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
 bh=3ZgUceNunaKIIu3OLKt6YNZfU8fyIjpBkrf/ZfEKkk0=;
 b=iWHncuGzyNZtyYMyHGcqyvmXiKzKnWl72x4xB0B4ZXsGT+yFYOZmMqtQS7oiFsjFoQEE2gqZ1
 irTsJM7DWGeBz9ePE5SUZ8kjKTkakPlaY55lyQ3tVCZPzPKi9QPgwbp
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add compatible string for tsens block found in MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 5a8f7673e730..c78074fbcecf 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,7 @@ properties:
         items:
           - enum:
               - qcom,msm8937-tsens
+              - qcom,msm8952-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens

-- 
2.55.0


