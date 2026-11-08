Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794153320;
	b=Etq2qTSXEjih2TWJNez8JXf+BHuGc9cuC/q9RxjYrw3zWxwpEj4UYpMkyT/wYHZnmQIh
	 Bkh8A508HkKzoVNLiG5Ua0kQH554cO1JmfReGo7cNaFlklBaCPgbtwVbVQs6BohsPLRnk
	 c5rJvEuFsL4Vj1S+rgnYGbk2RGTY4vPG++Hujp/RFYnT5jTxrE3VEbP/emS2qv8uf5DY4
	 lG+XoVTamcnwehyB9T8599sYwXWER+RWVotLRsFCjd+lwWnD8xKyjzXLwKu9YCR77DOQA
	 yrmT4hvdDYqBrQzVff9ipK1OcEUJRnhnbZMiH6dSv89tqSRPmANiNafs6GF0B4u1PLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153320;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=naRY3LivuuNp7aOaJBA7q72WcB6N6bwNBYS0Qj5pXrM=;
	b=XZi8CKDCibbtiJAPHPcowicerROQhEiflvgEwaSsax2pd9qdZM6aYAjD6bXWv8gKKDqE
	 Ln8xwo3bzxO+kjSBk24Ph3xh5ZRFhuEgNwXW90ge7/zQw39HHM54CxLDH7iLZkzW39iUO
	 EG4Y27K3QhLExK9YYULoBhEk1NIaLtQjFFtvMT3mXP1U1Vc/U8NZB5zzmx3X7kCsD1G3l
	 m8Jh9Vp9Qpt7AA1I7akpBRcyrqsvhdejBdVib5vcR5qnDq87JD7B85syjkcg2US7Vvcx1
	 61g6CfGfMWHMhTurbvkpwgizxmQNsJYyjVWN58/9xKXdtNiJs1mAD/AD9Wbci8lvWUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hviItnhg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB27606A320;
	Sun,  8 Nov 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hviItnhg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794153319;
	b=wA21mHqVLBaSiwq5EXrDhnTQWRqbg4jykUbkwWZogoXtCLEYsnLch6LYNWnD5457v0wQ
	 7LpvgKUi2RkjY5AwY2RKrRhxHIXVYkH+POfqQUEVZ23l3DavQR1lOvtsRyj457qgzsmLR
	 NRImVZJ3xqq6wwJIIf6pEAgLc0fRnJMw/+IeO5QygoU0cJNYD20BGRgFpsZB/yaTapuJV
	 olXMKizR7mx/vlDWQYk+l+2aAPxzO7DfPU/JX8we059T32SSuHnMf7P1NG4vua3ET2Dnq
	 LM2gNOSQGxsDXqpAVwJZQYvRx0eyvp3TGdZV892SR/KnMKVkMD6RxdsBHz5Up+0S2dw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153319;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=naRY3LivuuNp7aOaJBA7q72WcB6N6bwNBYS0Qj5pXrM=;
	b=mVWyNRy+85Fc12H9PjXyy7wpXCJxVIg3Jw/LYOTWIPCwStLQZ3fKivD30HnlVZbbnW2O
	 M2+CRb1Xfl8MiEqKKoV4xqN9wzm/m5rBZugcLCergqDPvWVUkmo5w5+GXPzq+XrhaHCCY
	 S9V/GChCO18yUyNJ1dzec6a5QMn4RWUPvR/v0FHm1+obFJVJX8v5wZZWWBOQw21OSY91c
	 M/9MX3dRmD8Kw+jC7SD0u1v6WvdwgO5F1bkIj8dGOVNflAeoaCOcaXNWfE/Nznw4ywF0U
	 eKIUdhbQvLKvRDj+tOKDvx8Pu3T64XorG9KJ7zkIqPNzY91I0GyFguu1bn4Ofuc2f4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D54841F008A1;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153319;
	bh=naRY3LivuuNp7aOaJBA7q72WcB6N6bwNBYS0Qj5pXrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hviItnhgF0f/4nu17J8UHPhDSfyFdVWR75Rn+7wVVN0QMon9bz27/aAWR7h4KuRJN
	 dRlWcgdt1xH4zCb9BErgC9tdXBom+t2FWWhngRoUGVBuAPdFPm6N2qFdt31lez/IdT
	 4z6QpK6k0aPM6J0cigZfPzITwf6a+kr1/jcGYgYvon+1YEHmOoCXZr7gsiBBGkBVXT
	 tigrVSw+T+CVHGZtWQBruIyvLjaCINpyNGOV26uuH+5mUDs+3ypMG/Leiu8Jf6IdI1
	 rx0ZN1OWumjsqIz4tWVlmhv8lNtqH13fMiwTedHPAP120QvzKpUHo7Q+GyQufX2A3f
	 pdLJsFnaSxVpg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5622747FCB;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 16:55:17 +0100
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: wacom,w9007a-lt03:
 Add Wacom WEZ01
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
Message-Id: <20261108-b4-wacom-w9000-wez01-v1-1-c2b5e3466187@dxdmail.cc>
References: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
In-Reply-To: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794153317; l=1172;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=zq0lqjUM9FPeexdWfMB8KmeYqsPCzR+RvN5Mv4EBnCA=;
 b=Oyt4cvYMINkHSVaq/j/EVgTsYe+L1Dt788tUrL5ktHt2lFF/o29J9V5Gwo7bd5NL0OiWL6+3P
 yON+NPF8H7CAnk9aTsKEutT+xIR6zZvBdbnq1Zu8TmsPyWzyhIYhJF2
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The Wacom WEZ01 is the S Pen digitizer of the Samsung Galaxy Tab S9. It
is not compatible with the W9002 or W9007A: it is queried with a plain
32-byte read that returns the query at offset 16, and its 17-byte
coordinate messages carry a packet type in the first byte.

Its firmware differs between devices (the Galaxy Z Fold5 reports the
buttons differently), so the compatible has the Tab S9 codename as a
suffix, like the W9007A entries.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 .../devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
index 6d1da6a435d3..7b541c91de36 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
@@ -24,6 +24,7 @@ properties:
       - wacom,w9002
       - wacom,w9007a-lt03
       - wacom,w9007a-v1
+      - wacom,wez01-gts9
 
   reg:
     maxItems: 1

-- 
2.56.0


