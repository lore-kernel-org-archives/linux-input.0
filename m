Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8465410D38;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824086; cv=none; b=ENMyJpslQHs/I1LmnNaOD+caMaW8HUDVL9QyXQ+4w6UkNe5i2tv3F6wxpv6YyHM7Z4rNh5DoOSUn5mrz9+qiNheuieX4JXTn3Ej28u9k2PZN/59k/6scMte7R5kLWlbFXQTRGFrWa5/Dnl4Bl4B7ahlnLANkaoQWP8LcxkOvdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824086; c=relaxed/simple;
	bh=9XzjbYaBUsoOWcEt/akYK3mjOrj4my2NJLQ/VEcsXjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5ceLLhdbNUF/FpUjOfSKMb20eCFYbqTcNkJxzIvfLJlXJ+2PhdjdZXCzxECE5ff00e+njs4nCyJTB225vf+/Brv417WpWoQmXNT8YDRfngdbFb8nYzMHv8N5xTa5VEtmOW9T3pdon6ncyM32+X7UR1pidFPlaD+gpltFzHut/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqMUR/ea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqMUR/ea"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7388AC4AF0B;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782824086;
	bh=9XzjbYaBUsoOWcEt/akYK3mjOrj4my2NJLQ/VEcsXjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nqMUR/eaOrw3tQzjrTkePZdxnmA3cdkEfwtNNFztLjJx9Kal+Hmp6orqbU3rdgJje
	 obRCLNr2M3YowCTQ/rKp3v8KOfbJzvchNndNRoYiLwmekhTGWng47aqBox1GMAOwdd
	 SV91RWaoehiffquNq/9D8XgTwUrG5YIfwnaGTEL8DrxqogGAX4Cy0DXbdrBmjQ61s1
	 mYoe0Tc0oqEhgp/ick4CYTaUjZopwCt8bZ3NTp17H99g5+7HURza537kSGujwfNfZU
	 kFIkxdM7gZw4ZsQCq9W5QSvHyXVzM6bJlSsIqzz4OwmpzojjbTrBt/Cr/sTl8eK6IT
	 VtZcx9RK6r4MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651CBC43327;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Tue, 30 Jun 2026 22:54:31 +1000
Subject: [PATCH 03/10] dt-bindings: iommu: apple,dart: Add t8122 compatible
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-apple-mtp-keyboard-final-v1-3-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782824083; l=963;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=y5JWfMxBJX2xwts+wGq01XJ6a6fA14G/VbJw916yMm0=;
 b=5iqh2NsfbrvbnnFMBUjNQ9JMWqmwkDS68TKoS3s6ZKyEuN8ohJJ4u5+rkTGBiNHhfR+95Ekiq
 ojKHCJikfWADnyTu62aZ30rMoFM5bYbdIPtKbGM4A7trN7HTSRd2pBQ
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

The MTP block on t8122 has its own DART instance for coprocessor DMA.

Document the t8122 compatible with the existing t8110 fallback because
the programming model is shared.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 47ec7fa52c3a..e179199dbd3b 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -29,7 +29,9 @@ properties:
           - apple,t8110-dart
           - apple,t6000-dart
       - items:
-          - const: apple,t6020-dart
+          - enum:
+              - apple,t6020-dart
+              - apple,t8122-dart
           - const: apple,t8110-dart
 
   reg:

-- 
2.51.2


