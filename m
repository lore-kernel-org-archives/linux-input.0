Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AF46EF80;
	Thu, 23 Jul 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806030; cv=none; b=aCxH+0c5DZCrLIcuY9iLkpLNsfaVyyhzLxKoeg5yvGbbkKjhN7W+vfl7aIq1LWA65+lPJSJkQo77HL6zNjYHuB2MrktE90DhyYWffDdzCzrrALgzzWzpHe7i699vHJSEpBrsrr6gIzXbzGayJlSP88Zjc+06Gqras/f+tI6aoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806030; c=relaxed/simple;
	bh=F/STKscT5wBCfIr4tGpfk1umGluriePYuowtYacQTvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1emxsmi15VYYkxB8fUYizkHqNkUW9+pfC5KSVmBwdgYUjjjjGGJ2dZGLEzjCBs5IKNkoY6aZ5FXWaInC38TFA8683MtmNRSI/uPqt5fj0LJ55y0unnojA8B0ybeDGT3GNU4YFI4Yg3o64gz0m7ghxKsCwdEwPpsKCvWxCXpzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeOu+r7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeOu+r7m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E11CDC4AF0B;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784806029;
	bh=F/STKscT5wBCfIr4tGpfk1umGluriePYuowtYacQTvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XeOu+r7mZQVq90XG8mgIEAN6RccE85BgyNVE5+2aCYvEAnRQtiNLghX8ukRyxwb/T
	 K7LdjhTxeVM1MWrRnSCafMKGvpf+0Pa4CMIu88sqAwV6rGyUMUFUMjQXwj81G4pykG
	 f3zsRR5aApyyNN0vXN0Qxbyi1HGi9KbAlb73lGo8yi3Tg7rF0eKZTsBJuKPuVhDv7i
	 S9kcIcKvD2BhMGoHcJUkA8IYGbpkUsAzcU+JudelG86mm27w4P4HhLRsW/poSAZD0X
	 UziGGoiCS3W+gxKocK1qqrWkHkhOwbqGUJ0kH37QsA4JdVUjhoFzT/FG5TeTJ1l6WF
	 6rxjHLg8FN+vQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E1C531D0;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Thu, 23 Jul 2026 18:27:09 +0700
Subject: [PATCH 2/4] dt-bindings: input: edt-ft5x06 - add
 no-regmap-bulk-read property
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-ft5426-v1-2-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
In-Reply-To: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784806028; l=1274;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=Y6plFHAdYOrN+v0JnPDtGVQB09ZIhxaAyZp05Rxn6xo=;
 b=AnFiHS16i0k014X7gtwrdF8LI0B2V9NUk/mHSujJOLMYi7m1cJkwgsUyo80cOMKx8UUiRXHlO
 Ize2/S5daARBtx4frDkwkgciyZdjEGpqSt3k7N+jRkMZ8plRr0v9Nk+
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

From: Alexandre Hamamdjian <azkali.limited@gmail.com>

Document an optional boolean property for boards whose i2c controller
cannot reliably sustain the multi-byte block read of a full touch frame.
When set, the driver reads the frame one register at a time instead of in
a single bulk transfer.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 68b2f1601654..0d8310a290ea 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -111,6 +111,14 @@ properties:
 
   interrupt-controller: true
 
+  no-regmap-bulk-read:
+    type: boolean
+    description:
+      Set this when the i2c controller the touch controller is attached to
+      cannot reliably sustain the multi-byte block read of a full touch
+      frame and aborts long transfers. The driver then reads the touch
+      frame one register at a time instead of in a single bulk transfer.
+
 unevaluatedProperties: false
 
 required:

-- 
2.55.0


