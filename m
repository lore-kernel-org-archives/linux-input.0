Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72663090F4;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381237; cv=none; b=AnKhCKvk8qQVP/gyhUp+dnyTMlYYyJ59smKVXpSB4xnLXdQz9H5o6quoOlr2y+IyqWXDQoRlvuIqhGn2LlyWvUryXxGivXE6uW6ri/InUeZqWv8uhSXHfGygAvatFmtoR4nI17Lz3DGyVv5XMA1roO6UbkVdFmGR/cPc0RP0RK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381237; c=relaxed/simple;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1GdxWP7rEzkFsIv+njIh23TMIdN/MK3QEnccqYDEYo/PU7Wovxw9jiwy6XHONxcfltEYfcAmw6FQh2nrERqI0l27cGARZb/DBGS9/2p9Q5EbYUcmjPKUAw71iN2JEilxCGZhzs4fz27oH0sDGMXXvvsYDA9/Yg8dZOC5h7EWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpMQ9lpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpMQ9lpI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 739F4C2BCB1;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381237;
	bh=oBgPDt/LJlibW8Hgm1a/bsT5ObHlCxGW++DUgK9IrHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TpMQ9lpIOvOTw2sOL0HLdY+Kt4Z2biTP1epI1DkBqVuaZpnUdxzlxtYuclMhztO0H
	 LDtmCIfitaNFslqfT8LhwuF21ZuEeeGRVXcABkDYxh7ZAaGkvOPKUrtAFffNgq8QXE
	 Xy/IoXn7LOQrDFoOukgki/hYZyRBv8XbYP0b7DU/xKtNsT4TFn4cvjwtNM8mX6uiJd
	 +5dyYoyAytj+ALTE+39qKqwJ16B4VKXh7sFgevlpIP2/aGSxEH72dUQElK4jyt/DJ6
	 g3j2Ybqx3F3SoW7tWHyYyB7rfHGx8lXTKbX36SMbgGjb0DxpaK9KdznCBQBFPjPRES
	 YOO2bFmkXynNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE9FEC100;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:34 +0100
Subject: [PATCH v8 1/7] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-1-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sEfAUOYzG1M4zvx/Xv8wME49V12PqhPhJ6Tk21Hc6yo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuiz5xzrEArqFAw1SDTk+XBbdHXOUSvBr9h7/
 xUG9+OoW5SJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 chtYD/9X46MqQT6R/aqVMflAKUjVnBv+ZV7Yq4B5/B3qd0ceScFj+t8IeLuqQSeYZwH/cNsSZwc
 Joex4ttjsmlvz/5KEwyDRx3wJQb4Ms8QRHTlrxgY4atncDJPI2kWopUwDpnCAdrRvWtYAYbuxSq
 VE8dNM7ISwWAcmqsY29m40mJKW1MyUrUUjFOKxZ9ZjjqtzbIXcpIaytsTnCXDWiGPb4SqXR2vOt
 rhmqZuCAQ4t8+MDnL5fOrvVXD7VBi5/Uv02fe7qkIcNrvKGngH5toerJhN6R1wlKnwUho/g6QT8
 xnGZTx/zPRjPQ6r7IgzLS9INdHg1bq5X9TCSWr1tpGZucmh3cEJa/VfqVpL15iXFgDy19h9qad3
 kl+R4Sp92e3yUpGcEHmoQqje7V6fkl5jlj4T1wGB3qH0/vgN3DZM3agT1J3l/kYU9+oVFNZT0gU
 QMFtdkDFZbC3EiP9ae+rzi9UuMR4Z4KMYMGSsltoAtBS/HOuCYrrXGFyUDJozDk/yDw6Xcm7d0N
 QAZQNssfHEn0xPamkd/62CNa5FOMhBLJ7gV5rLz/XseSR0ZJTLU9boc7UxBy26p6lK7WvhGlVBm
 U8fjvmEB8HSQATpNT2++j8d6jYIQz+eu5MjLMR4Pyn55IviA+Dg+RKSTCHCwJI8txv7nV9Jp4vG
 Lp2AptRLL5DVGag==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Mostly irrelevant for authentic Synaptics touchscreens, but very important
for applying workarounds to cheap TS knockoffs.

These knockoffs work well with the downstream driver, and since the user
has no way to distinguish them, later in this patch set, we introduce
workarounds to ensure they function as well as possible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index 8685ef4481f4a..fb4804ac3544d 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - syna,rmi4-i2c
-      - syna,rmi4-spi
+    oneOf:
+      - enum:
+          - syna,rmi4-i2c
+          - syna,rmi4-spi
+      - items:
+          - enum:
+              - syna,rmi4-s3706b  # OnePlus 6/6T
+          - const: syna,rmi4-i2c
 
   reg:
     maxItems: 1

-- 
2.53.0


