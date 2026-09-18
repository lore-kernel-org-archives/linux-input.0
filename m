Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324824E432E;
	Fri, 18 Sep 2026 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729612; cv=none; b=OAb/Lkd1l+7WgjszXPTvBDfz/V37M13xh6UdRm6PthZ9kOB8oLY0pWYd1jZDLTH+Z+M0NCPx1KmW4JZbWhhjD7nky9TKGq/RH/1Z4aHnVGsk/RHgGPSmeFlceaeSd1e7W3W6gMseNWl7s/uvjs8u3TKYA8OdL3xE3403Y0y2Nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729612; c=relaxed/simple;
	bh=t5iAp3fMjkIZ0RzU4Fip5Mdwa1CzjHXcMHU8zfCTkBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n92tmyxjYuWr/EfQOsUIgixW3mbhjcYEpG+93Yik7g+qSk0ewiPfp08scIkoSa0LxGWr3ngqse0Sq8aJklPXqwJMEOPC+dpqFs8PPrPHzqIxt3BLNoVtYCvrh/nRifMmBvErp9Cl38NnfGAmUucmfxgEkhhcIJZK5K9CXdU4zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMUZzFtW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMUZzFtW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC80C4AF10;
	Fri, 18 Sep 2026 11:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789729610;
	bh=t5iAp3fMjkIZ0RzU4Fip5Mdwa1CzjHXcMHU8zfCTkBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EMUZzFtWAonPSXfvQ5NcURGV4vkWJN01fZCuOKBFMimVfygzu/hP5DjKnBtzYofQI
	 y2el/wyHwAp4rRYk8LPcEM8/Qapy/UbDRlUH8q6fAuMOc3/x0f2n6FIbAiKPFOpRuN
	 8oXBSzKnITGS+NEeb3FA9NLCVrhKCmnc7ZONd+ee+fCes9hqAFG8PRCwTfBHQLX84S
	 jdcyAl7KzuHd/EDPHMtm3e6YOl4iZHSmSguVFPi0gwLaiNHd/KleNK3JdQxGoWasLU
	 mUKxw5GhWJKptCZC3X4iqVtovD80GgGbf5CNvRXb/bHtj9E4O3RKAt1hJEaeJrLa6o
	 ra4pc7CKWjL+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43571C982DC;
	Fri, 18 Sep 2026 11:06:50 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 18 Sep 2026 21:06:46 +1000
Subject: [PATCH v2 03/10] dt-bindings: iommu: apple,dart: Add M3
 compatibles
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-apple-mtp-keyboard-final-v2-3-a5c685e50b60@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789729608; l=1038;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=eobqpYoOQsgGWNW9L5TA1i/2YQsYWCHpu2/7P/SVNyI=;
 b=1IQ7yYuYjitCuZJEYkWFM3TVxzJza7gs9nOblyZS8+q6iSQRIi3XBrJqVKGWInCX0EfluCxog
 84CIIn8467SDD0eS1P43JTtvwvhhWOcN3lsVN0f1LHS4cFt3R2Be/aB
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


