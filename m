Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A7480DC0;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338177; cv=none; b=skRuaNNVjtWjngShKNGPMtbiJhelzR9D9CvMgE9Ga0yrQOwPp7HjLB4JP6EpvX+C6l6utlzpO/UyKOSxGDN0sToEv9Ap8pHv3gVi/KS/UlkYTB+4j+YkcTfMD3xTLYgSjKSOhn9EVhjr3Kcd+pYUYj0RBsb69HAz66Cc5DHiRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338177; c=relaxed/simple;
	bh=t5iAp3fMjkIZ0RzU4Fip5Mdwa1CzjHXcMHU8zfCTkBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McDJrjJi0j3eHG1/LJhyj8mWJgo8y9Y59xwb38cDpB4DomQtjOPJKgjk6RLpnreASArl/rqLaw50FP/FES+uon1wD/mNB6q0ANWvsqz7fFPD694wTaIfBMbFbxkSwgEGOz0lIHRLq6EI6wKa1ug81xqxssZIGqHHfjUEiXCrqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0fA6E8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0fA6E8h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 648D8C2BD00;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790338177;
	bh=t5iAp3fMjkIZ0RzU4Fip5Mdwa1CzjHXcMHU8zfCTkBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C0fA6E8h/bKRVFIx92eLQ1Dg2TkHU7qIYnv0LaWeOlCMzzsklXVE96J4WdIhFUZML
	 qd+6pYcAn/Wkr9Pc9qczzd54EbkSzPbTpX6EZPDyjDXNefqKtpS/gIxiaj5+eNnO6w
	 oC8cTdhOXKp8LTr6EyvqvbuENaMnk8I3njNc/rVViM14jn9BU+iA0pDqgi830hXPD3
	 +9REJW479HR80PMt+GVAlGJbmmVWjDkJjHGraYT744PmHcS9lv/WmPKXwnMW3B69ji
	 nXNdbeHoCm1j+6n4FOIvLQ2BlcH6qDhOP9sQ5bzuLNn9k5k9tdp4lhMAcW8SFzklNC
	 S3R1VQ4brwZsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D1C98328;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 22:09:30 +1000
Subject: [PATCH v4 03/10] dt-bindings: iommu: apple,dart: Add M3
 compatibles
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-mtp-keyboard-final-v4-3-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790338174; l=1038;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=eobqpYoOQsgGWNW9L5TA1i/2YQsYWCHpu2/7P/SVNyI=;
 b=ioTQIm0EYLBTFlBRu4MzWV+HAV+mDzEq51dsp5PfG2k3KkG4dYWTIMxUf2NqA8XsyIk1BP3qD
 NBso0HsBhrnCjlkKytJCdK0w1Di8qdQDu+atiHWRZhhfFGJRtA0yPwc
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Add the t8122, t6030 and t6031 DART compatibles used by the MTP
coprocessor on M3, M3 Pro and M3 Max SoCs, with the t8110 fallback.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 47ec7fa52..efadec786 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -29,7 +29,11 @@ properties:
           - apple,t8110-dart
           - apple,t6000-dart
       - items:
-          - const: apple,t6020-dart
+          - enum:
+              - apple,t6020-dart
+              - apple,t6030-dart
+              - apple,t6031-dart
+              - apple,t8122-dart
           - const: apple,t8110-dart
 
   reg:

-- 
2.55.0


