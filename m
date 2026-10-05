Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89813DC4B6;
	Mon,  5 Oct 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234677; cv=none; b=vAXDZP8+20TFPC+d0079MlYtkAdwG8b2RuZRhuBQcSpQ29IhJCe4cW5kL2AeHDP2lNjpRw0n9uDeB3Rq8Ush64gEucAlq9p2pvGNtCPGtZTZ4d9dtlTSu1XbBxrgvxTWPr72Zocc/Iyna/JKiRR4oVa5YLyXOKENqErfW40kG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234677; c=relaxed/simple;
	bh=7nG6pM8RsmqYSHGT4La1wpm4Xhm1OCgRW3RM8Umq4ys=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZveW7R4bzeRQS8/RyPQFIwPKhoyWCwYIlsVQwFX4uxcjcp+TKXsrQvMwf35sgpdHULA+l72k/9kzVAmutwIrWX4hrfsI6uFg66xEbDg/4oLOPmwbwDxcWpnmAkkQT2+HWulPI1rd/HPinLopVR+5kvBDCrEX8JNY4ChZ77O7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDpxp-000000005uo-08GC;
	Mon, 05 Oct 2026 21:11:13 +0000
Date: Mon, 5 Oct 2026 22:11:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: input: touchscreen: hynitron,cst816x:
 axes and panel
Message-ID: <614a8ac3f9e568d6ccf4787f48b894ba8ce4b584.1791233147.git.daniel@makrotopia.org>
References: <cover.1791233147.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791233147.git.daniel@makrotopia.org>

The chip hands out coordinates in its own frame and knows nothing of
the panel it is glued to, so how it is oriented against that panel,
which coordinate range the assembly reports and how noisy it is are
properties of the board. Reference touchscreen.yaml and let its
properties through, among them the 'panel' phandle naming the panel a
controller is mounted on, which asks for the two to be power sequenced
together.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3:
- describe the whole of touchscreen.yaml with unevaluatedProperties
  (Krzysztof Kozlowski)
v2:
- allow the min, size and fuzz properties as well (Sashiko AI review)
- allow the 'panel' phandle
- justify the change in the commit message (Conor Dooley)

 .../bindings/input/touchscreen/hynitron,cst816x.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
index 72d4da636881e..72b1bbff6e57b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -41,7 +41,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
+
+allOf:
+  - $ref: touchscreen.yaml#
 
 examples:
   - |
@@ -59,6 +62,7 @@ examples:
             reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
             linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
                              <BTN_TOOL_TRIPLETAP>;
+            touchscreen-swapped-x-y;
         };
     };
 
-- 
2.56.0
