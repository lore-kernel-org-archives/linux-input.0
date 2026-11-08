Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126837;
	b=gDlmUu3UvPAltrYPob29TTcweqYFHICdxi+8rYnofBpAtTHfDDUMRVdUvFpq6cX9pL3+
	 WrXmQ3fR5PmaQJA6dwQmVZ5sLDGQ1G7OdeKuryS8UaxkVr27rr5JjdcEstVhC9J70yxqr
	 2U8ugWhjCfcmafXAgFmVoCwpEsBs/Gey4kD/wyDiVJm7XK7RkP3hEsU6ycyMIEh45r9I2
	 YJV5ka8D9iPlUYrDIWcNmtpkc0aQICGl3LTgLMSznrVq/WiKEc/4HLMYqZlZ7xMkrlF45
	 n3P37pifUuQqHlkuXnqPfVLrBScj1PTcwZ53Lz58DAFQMWrD9txIBya6B4pImRn6vTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gaWhNV/2UAiD8U4pTKgcpgVjav+zOayQzMlMgcXFifU=;
	b=Qy2EXyTqLxKuq/ZPglT+Cu9S+dPlsegQ5URmJ3o7GaVcasbCw8ImKehPsUHNRxzRiEcK
	 xOv5+Vgs29AdgThwyUDzEBeC171XLqBbWreSnMzWQAQrxos/BZkzUFAf7dhhk2CEkvSrL
	 TQkCOtrP1/Yd0hCT3kHrU9dgnLhKg9wSg4MSVunNTGB1csLSjk/U49xu9yhNzveaqyB90
	 2tKmoFgiudC1f/nITGSaPIkZdU3OeLwC3Z3xB9l2TTSUCoK5aG1hO3sNbfp4hnrT7kJBw
	 qCPrcf2gmlITJiZQetBbIGrkqoDtgLqEDPd8oHDFIJ21UDPpb7+wbtPTBqdfek4Okhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeMYiPez;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24D606A322;
	Sun,  8 Nov 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeMYiPez
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794126837;
	b=Yf7LcBrbXvlo/DZi5K1OJ+YDoNlT4fm/Yri8ifkStL+xJiCflDBaYNWE77gxoLbxnBmi
	 LchtQHwMd3UYLOxdyJQDQA5wkrkRio3CCi8pCsENtcWPp82YdaX0/3w4QyYicCW8mIACm
	 6jSewnOqujSYLCsC2MVZvXzP01ap+zguzoL4IdexBwLB0GcAo8Xd+1ueywqhuGo//ojQZ
	 n8j6g8yyBSwFcRD381MiJ4FazMs6CzMpu6GnIgVAGsC9NtYUOjs70Do+uZmvteVrynggH
	 BfJDCLndUTjAplP93p0qVx2YS/be8zfEeK3OGNGEXB+GQnsCNuwH+vZmd876HY1Oigw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794126837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gaWhNV/2UAiD8U4pTKgcpgVjav+zOayQzMlMgcXFifU=;
	b=HAwlGs/PwPCrcfY7tfrx+Mayc6OWE/w6wb4XOda/89iGkp19hK3eK0+UK0odvneU1lFl
	 u0o06WpBvbLKNFFvMRdtmxyTI0JS0NFgmw67Gynh3mmjZk9FFJRtgcaV5RctyoxCntg+I
	 BxWGAasX0PfH6L4wNOP66+WlbDrUPK4A/3wDSCT6xkxv16fiXj3W8VJJ1fZ62CFM4VKzS
	 vU7UuasY4Oib4DrQcVR/1nIdIwukZsfBJ6t04n/SPFUHnevrbg6ukpF/84jQ1mvc+9vIG
	 bwSl7CVgIvi7LWWpmqLCkBxbIu8PUUFjA9qh9QKI8Iv0OacZFAIOALwhFjDN0Oh5S7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 66D6C1F008A3;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126837;
	bh=gaWhNV/2UAiD8U4pTKgcpgVjav+zOayQzMlMgcXFifU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DeMYiPezFK8Q55B6mxRAi9++zUbwp6MXVH1AIUx3pPKUmpS4mJmYGNSk+TzVm1N7v
	 himhfAua+ct4DgaNaAU2MDUFxgqtwP8QiG20oESWXlXyks4XMfyDuRPJHksLcehzQP
	 YSjH52taNBKVZ/WmlReJ5VYZL26mwgBgYBso5QAMLHnkdx4mFZa3b2C8L/taxgmhm3
	 V6QpvlBCdt9u0GbbQlN44ho43ICtWtc8j2cqR1Vh9Yr2akLKyOOFmN7lRT8C4988W4
	 YBYyKbfaSQ7Um6oENQBP2puU7ahbhzRCEgOxcUu3rDGwyhDrsNqSGX5FBc14JBgYGt
	 Z98dhWhroz1/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E151647E94;
	Sun,  8 Nov 2026 08:33:55 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 09:33:55 +0100
Subject: [PATCH 3/5] dt-bindings: input: samsung,s6sy761: Add ST FTS1BA90A
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
Message-Id: <20261108-b4-s6sy761-fts1ba90a-v1-3-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794126835; l=1350;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=Flhr418PQSRALX306tCmpNhdbdYHNpQZPYQ/lvdWiZk=;
 b=449RXd/PIhn0/o9lzW3zF9HBXchOZUIIIoH6vVPIsTM6PIDM/KlRN/4uCLczLKWpD4d7Q8kwQ
 h/s71c2adWGASBV+ss9hX4h4ahY24Z6BU3COhqciYyzp3lSxKeBsNAQ
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The ST FTS1BA90A in the Samsung Galaxy Tab S9 Wi-Fi runs firmware that
speaks the S6SY761 protocol rather than the ones of st,stmfts and
st,stmfts5, and it has the same supplies as the S6SY761. Its event size
and some commands differ, so there is no fallback compatible.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 .../devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
index 1ffd17af3c53..92d071852d71 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/touchscreen/samsung,s6sy761.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Samsung S6SY761 touchscreen controller
+title: Samsung S6SY761 and ST FTS1BA90A touchscreen controllers
 
 maintainers:
   - Andi Shyti <andi.shyti@kernel.org>
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: samsung,s6sy761
+    enum:
+      - samsung,s6sy761
+      - st,fts1ba90a
 
   reg:
     maxItems: 1

-- 
2.56.0


