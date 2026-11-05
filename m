Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793878158;
	b=kfqPFDtPvI8waTp0VLDvMcFNRIZEDENe9I/dxtWQc1pvvhQEojiPYEYwGgJMN9U9bioK
	 jmqj3VWj69jGzOMyBYOGV1HGaRSmCFz7VZ2c8UvGkWg0k8fmNe5ziPaK4EKvNX9WVM4Sf
	 WvG+CXr0ZPiKJ1DmMu41DgQkL6sNHNxjhJg0UCJ89A3vg9UBdWSnKFMAWv+REo8o7GoYA
	 S0eniwNo8nYm/kCDGQXfW3Ta8aR7HFtzo2uWrg8aNFGmzgqpwOB42Q/VdcQSsabrS7wrT
	 pidfQ3mkQy1UzjIsqukZzN19ZOv50Ck6rMjBeGZ0ComC95ydLTTa6rlu02GtWB06Ciw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878158;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+kioeahfgGvkUf91Yc06eaj5tIJkAx04gn/a2VqmwN4=;
	b=DFnHXzJ9tdW7l1NaJndPINETc7cGBYjqtb3yRxnOJKocptWSPzRnkxcBw74lmJlCVnHM
	 A2W/b3JAskBhqR7Tp4F7iyVCpmuWLPA+M1TbGH6s3by/mfWGjCHRYUZsh2q+mufM/nf+i
	 JSRO7LbEmbVQ5ukXzsBiOgSy6KA2UzKIQQJOedzVXTmCnhHRQEyMhFlVCqe8I3762pseg
	 5P2EvQPlN2EHafGz+RSZOxopQGIIllS7ZWnP2Lzgsb1I6UrGTx/y3XLX6c3lKxNCik3ws
	 19rXoAwxqzKrSGKkTmsIVQIw1zvzznx2HTNHT0II2Y85IU8vGIY305fIe34lycsfBbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYH5m1Au;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00597606A328;
	Thu,  5 Nov 2026 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYH5m1Au
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793878157;
	b=jsTxyvh1ivJDJEwecKrvg3rLCmKAAWlvld57klRM5smYMdTFnOphznWOdY5ARXt6CNWa
	 7qgf+tTS3RantrS3n+4KkRXl8ipsPvT2pBRPT3PNSWAaV37N/ilogqUg3aZbeg9XUc6U5
	 HhzvkBie2dSKhUKvRaAXjTiUZW0hF+OSr191Nwe5Q48g8pCLVUfymnob797XlZhvkD0Jj
	 vfJXaWv0C/s0wutw2891LK/SzLT7l+THgePZNKnLRmUetENEVlsQQCQkrue+9Z0IdpzB3
	 jmjKRDNNWzWa0AAlfqFV0DmAyDYIN0azS86zYDrJGuJmyyRuhZd0mEHaxwg72iVsEpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793878157;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+kioeahfgGvkUf91Yc06eaj5tIJkAx04gn/a2VqmwN4=;
	b=WdNq3tjT873ZiEg3NHqwJ3c6/rLKYCUatCpo5Z/1xYxvjOnypH/4z4ANU8O3pBqlbWA3
	 /NukGP88/5RS9yPmONIKB1fj5qse0GW1QunzsFJKQhzqi5t+C0Kuv2t8QRgA49ssZA/RJ
	 XqDn3HMqVnarSMdNiFkPN65vMspZq8ADgco/0E3Lr7J0DqPpQX0ihAA0fKO1romNR8uKL
	 y52DoquOZkXhKqVInIwsnnmwncjEFt+BXM+bQqWS8JWX6/0UqazsgjpJwTsY80X7T1IA8
	 D6BeId8CVMXHkjet2fwBjh15s+j/FdROF6gfEsobm68/rFXod4C1bKciIctmNIDkPXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1A5771F000C1;
	Thu,  5 Nov 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878157;
	bh=+kioeahfgGvkUf91Yc06eaj5tIJkAx04gn/a2VqmwN4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ZYH5m1AuHS1GELMoVUJhmaqwp+m7Hh4/9TLI6zlBojT1zyo0U0i56+WVKx7fbAxtl
	 cb+goGZaLsreByvgGMU12Hx8lBsNBe/AdKqxUPjemHet7mXwi/Sh1r97UOktWxkK3P
	 LbH0FQFu2CB85KKjnS/OxxUaFHsS6fk2gQZOsxv/493s5WyJZ63B9dfMU/A5bEDEuE
	 IB09IZ7yNM/1EF72TsZXkuZCzIWsUI0j0VNMuv/Sb85FMF1t8LondL3XEGHg+lynJn
	 bfzi9qZyvx+AB6wJiiLAbC3qqDUCM1HRkZwfSxrm/OF/f+3MJ1QgV7eDTEtZ1U11LY
	 ytduIMb7H/4eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 70B3547204;
	Thu,  5 Nov 2026 11:29:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 05 Nov 2026 13:29:12 +0200
Subject: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6595
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
Message-Id: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EMBCA4VeROZukLWNjX0UcSgezEistQsS7b
 5fjd/j/EwJ74QDv5ATPmwT5ThE6TaAd7NQziosGo0yhtSIsqCR0C458zNahy5TNDXUv4gxiNHv
 uZL+HVf04rM2H2+V/gev6AR8w/uRyAAAA
X-Change-ID: 20261105-6595-dt-keypad-d30a425f75e3
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793878154; l=1042;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=1ilWPyJZwXIBoX7Ef7K1dJA5qk/q0NQM6AQiVyoSYi0=;
 b=gsl/L1Nidw63mZs0argyawLAon+vgqnunhZ5yy+E3ul11j/wHv6bXMvJ5xrU1xKAHQyY96nB5
 xCtkMOJ53ExAWZQr9KQL1lf3SKp0g2voI0Xnc9l1YvqCV2iz8HIHOOy
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6595 keypad, that is compatible with
mt6779.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index e0758aac7ffe..9f0da1240187 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt6572-keypad
+              - mediatek,mt6595-keypad
               - mediatek,mt6873-keypad
               - mediatek,mt8173-keypad
               - mediatek,mt8183-keypad

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-6595-dt-keypad-d30a425f75e3

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


