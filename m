Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38A3A5E97;
	Fri, 14 Aug 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713263; cv=none; b=jJuPUYVcZnExpitzcUiv6rIZ4Dd41uFio0+6COwKXNbEQGMvYxJnTligQWQKyy40I2j1Lqpfq6j47d5x7ZQ7wZBwW4Pmk6waumxEoMkOhSOs/kYIC0aZI62lOSKrKN+gazd5jP+ttQF879mya6xLj0Jr6aDcJDaTwVKW6ro6GWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713263; c=relaxed/simple;
	bh=SehANLEi1AhnebfTL1kjlO9MbWFqPE1U/G9I2+q8iqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kr6GHzJXhnNn2cjP8DdaKrffdBOiA6to0IjVAwJ2wo7Qb22tlwN9Nkmfjajdi7Ru6XwLGqnm1VRGL0Qcd1+bcTcxlj3za3u7G1pxrnKPORkDtuVdHSeNJASojyhupztGdfx3a0KtJheMz2y7mTmywrBlVdQZ4ezOeY+rQYCGuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=por2zTBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="por2zTBM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F7B2C2BCB9;
	Fri, 14 Aug 2026 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786713262;
	bh=SehANLEi1AhnebfTL1kjlO9MbWFqPE1U/G9I2+q8iqs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=por2zTBMLibZcg4USnC89ZsLcBriS53gQfOjGVBSgXR8XfNxPZ40hTCGfTgCwxb+T
	 qmaIt/siez/re03IegYooGWBV9Dzw6A0a2XLJhaUZse9y9YczqyTXpa2y3J6G6hMLJ
	 VC0z4QcLyIxoMJ48eJkTpb+vNf7a5T9M7thxxuePeBXiRoaQx4TZ3NwC/pPnI0nm6q
	 hrtfe3U4vjr+eyZr/s3tYzZvc7cF7LMROI4m6VlYrjuAWvU2cGujD0v+3ln+3eta8w
	 XqE2Rb1q1YqY1uCNYcl/9uOM/v1tCuj5uploimcBpeUxCjXzjazJ4mrvmEnQvF+b8h
	 loV25GCyLoqJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47FC5B572;
	Fri, 14 Aug 2026 13:14:22 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Fri, 14 Aug 2026 16:13:52 +0300
Subject: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6572
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0MTXTNTcyPdlBLd7NTKgsQUXaM0QwNDS4NUA4skAyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgCOtcbzcgAAAA==
X-Change-ID: 20260814-6572-dt-keypad-2f10190e08b0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786713259; l=1041;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=dnFCakk4vuGhlPYs5js9z6YmW0GnQtXr03hvBnhKxc0=;
 b=n5oqb/qqHWnBuYOLTPzQm8tLKvcunF+q145rv7u6gZq2JHxvdLiDZCezeD+FxS7AWq7o+O9F0
 jNVhnoo38TAD3bJqDh5TZBqVx6BwcorClnTnwfd24kRG74EOJNUf32w
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6572 keypad, that is compatible with
mt6779.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 914dd3283df3..20fa41f691ed 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -26,6 +26,7 @@ properties:
       - const: mediatek,mt6779-keypad
       - items:
           - enum:
+              - mediatek,mt6572-keypad
               - mediatek,mt6873-keypad
               - mediatek,mt8183-keypad
               - mediatek,mt8365-keypad

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260814-6572-dt-keypad-2f10190e08b0

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


