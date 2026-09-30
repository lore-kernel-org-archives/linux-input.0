Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FA50B8DE;
	Wed, 30 Sep 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784485; cv=none; b=rND0zzLu4ZQF0ZVmUoVyYb2s2luUDdQKwvauEqg+1E/WTIO/ijO00+vXSSMCOPusHINCpwHBh9YpsHsF2Dk09Vc4+OYl5N9S9nlJg9vNnhXHRaivg6M4XvQGK5RxegloRdIX8cs19JJqTNmXGC+Shia1S1UgYnZslCnGeosO6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784485; c=relaxed/simple;
	bh=vhr3jJVJbkkdrVQjQBqkGhncAIMgy0DHJwn54om0vj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNtAU3T9h2VgiN2y5M/tJEDpRmbWjiDYYyKZl2bJpx0cCr04/tlMG80aFufB3VPvOgKrZ3gRHyuscnIB6lSftiJ0mI/eOmuja87GLMyLX51GhuzWgrkikKcLgsIayflCJOzm3lpLOEZa3XnSZ8dVokKXFThXBCL8V4fGvZ0rPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gir3bh9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gir3bh9v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9CFAC4AF16;
	Wed, 30 Sep 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790784483;
	bh=vhr3jJVJbkkdrVQjQBqkGhncAIMgy0DHJwn54om0vj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gir3bh9vZNqz8LF2sUnIjCJPumj/k2J+V/aw6iYqyjtqzPL6H/i7rAoV3M7VpH6e6
	 UxxHWRIxYX+vPI+57OvKW4jhQ7V8Py0JadGGj6ngmWAT6noQUPa3Yr31XughLx0t0Y
	 sGIJvsufpDNnGhl1691yVSE5IhQOsoQhFFEEfS6lT35GvfRLqrkDf5Nen3bBDLCQp1
	 7BhKxTCJFQ1MPg1aUTiS2AAvadZWiNGrwkfT6o6J7U9Dj9b64z70y92FeCFcO2SBew
	 7nHtqJTkGIm7y1S4TdhcA1MtPeIV8tXpDvdIeUAOA+MHH/JYL/HR+/futGCGXitnni
	 KVtP0Ux5IDHeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993BACA5FC7;
	Wed, 30 Sep 2026 16:08:03 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Date: Wed, 30 Sep 2026 18:08:03 +0200
Subject: [PATCH 1/2] dt-bindings: input: awinic,aw86927: Add Awinic AW8697
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-mainlining-v1-1-c303cbdb00c8@proton.me>
References: <20260930-mainlining-v1-0-c303cbdb00c8@proton.me>
In-Reply-To: <20260930-mainlining-v1-0-c303cbdb00c8@proton.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790784482; l=910;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=vjgADZjYsmMEWYX2/CD2xEyWknfDHe2frU9LLl603ik=;
 b=9H2f/yikka6KgHS/XPF5Uo6dHq3RwBVhhmUB8Scz5Mr5LBR8OUz8x9dqyOdfrW0OB9rEkQqsb
 VrXnZH4LMBkBQu/MOZ08DhhvWSaNBSk+/0tt8Wx3LHX+ij6lkSuR5oQ
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

From: Armandas Kvietkus <armandas.kvietkus@proton.me>

The AW8697 uses the same bus, interrupt and reset lines as the AW86927.
The register map is different, so there is no fallback compatible.

Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f6..f0e26664e3e4 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: awinic,aw86927
+      - enum:
+          - awinic,aw8697
+          - awinic,aw86927
       - items:
           - enum:
               - awinic,aw86938

-- 
2.55.0


