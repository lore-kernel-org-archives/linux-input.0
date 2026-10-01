Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27F409285;
	Thu,  1 Oct 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851959; cv=none; b=QHnZ37NYCqwNXmnYP3j9mWvCkEusC+/LBxbxFaNCWwfZxi9qS9omPKkP3GlPl9LEovQDR9hddCBXZqzRBaSkKkgCXU27uvzRJEIryanTCM/WiFCUkEUZwDbIyMlzeyPKmzH6FYNyx5yufu2etPXX+oefrhrO27F8mCt6stlCvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851959; c=relaxed/simple;
	bh=tEzzybSCBAVY0BrT0206CaJZOGOKqMLpWRNELtxfbJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5W+Ev8RwBg4myOAmIkYe9iWaktsOOkKRT058W1j7Y6iPV+i4uOclhD/wNhDYpe5NvlAGK1+GZGg7yumQuKOTsdhSwpCc43xkLMTF/7tF9M1TO/MXcoTSc/M1edRTj5kydV698uz+PCz8uHb6y9kEHZOR5//yejtszSPhgcQDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCEOw-000000003fd-0raq;
	Thu, 01 Oct 2026 10:52:34 +0000
Date: Thu, 1 Oct 2026 11:52:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH 1/4] dt-bindings: input: touchscreen: hynitron,cst816x:
 configure axes
Message-ID: <d18629ede3f2fd5a08d0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org>
References: <cover.1790851590.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790851590.git.daniel@makrotopia.org>

Reference touchscreen.yaml and allow properties
'touchscreen-inverted-x', 'touchscreen-inverted-y' and
'touchscreen-swapped-x-y'.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/input/touchscreen/hynitron,cst816x.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
index 72d4da636881e..ba56bf61038c5 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -36,6 +36,10 @@ properties:
       - description: Slide right gesture
       - description: Long press gesture
 
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
 required:
   - compatible
   - reg
@@ -43,6 +47,9 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -59,6 +66,7 @@ examples:
             reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
             linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
                              <BTN_TOOL_TRIPLETAP>;
+            touchscreen-swapped-x-y;
         };
     };
 
-- 
2.55.0
