Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDA49159D;
	Fri,  2 Oct 2026 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945250; cv=none; b=euRqwxaDowWBdqEW8qK4h+1xQvnis8yKYYG8pZ0WM1ZPg2lFos1a+IzT4yUiFc1Z93+GQcGBbjS/9xyTPjZFEPCfYsKJ5t6mgqZTW8M6CcHoKjmBrLmi4NFkMIBzdADo6rL+/GUKNT/G5q16cf9wn77aR82z1v7SylSnXxXuwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945250; c=relaxed/simple;
	bh=1kBkac6LNnm0H0y/GognaOLkx+algFyVH6DXASx8gWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHyRzLfCj+3uH6UA2vqby/SboOcF0Nvp1Vr+QUK31mp3I1iVCMYrVXhNrNKRXDbTVt6mNyoahwgjOSu5EFg10EqFplAwhIKvWxko/wkTtE7R0fJnbmpB/rHDG45pbf5rkRo6GvjJjCkTWbwUB+6fBmMDvCWdNzVbg9urBtrzAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xCcfc-0000000039z-3INZ;
	Fri, 02 Oct 2026 12:47:24 +0000
Date: Fri, 2 Oct 2026 13:47:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hendrik Noack <hendrik-noack@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/5] dt-bindings: input: touchscreen: hynitron,cst816x:
 axes and panel
Message-ID: <04a70b1cb0969ec4e4b38f7945e0b22a977b038b.1790944534.git.daniel@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790944534.git.daniel@makrotopia.org>

The chip hands out coordinates in its own frame and knows nothing of
the panel it is glued to, so how it is oriented against that panel,
which coordinate range the assembly reports and how noisy it is are
properties of the board. Reference touchscreen.yaml so that a board
can state them with the common axis properties. Allow the 'panel'
phandle as well, since these controllers are mounted on the panel and
fed from its rail, which asks for the two to be power sequenced
together.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
- allow touchscreen-min-x/y, touchscreen-size-x/y and
  touchscreen-fuzz-x/y as well (Sashiko AI review)
- allow the 'panel' phandle
- justify the change in the commit message (Conor Dooley)

 .../input/touchscreen/hynitron,cst816x.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
index 72d4da636881e..027a2b3dcf2e8 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -36,6 +36,18 @@ properties:
       - description: Slide right gesture
       - description: Long press gesture
 
+  panel: true
+
+  touchscreen-min-x: true
+  touchscreen-min-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
 required:
   - compatible
   - reg
@@ -43,6 +55,9 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -59,6 +74,7 @@ examples:
             reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
             linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
                              <BTN_TOOL_TRIPLETAP>;
+            touchscreen-swapped-x-y;
         };
     };
 
-- 
2.55.0
