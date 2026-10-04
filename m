Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD23ED5BB;
	Sun,  4 Oct 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106511; cv=none; b=j5v8CMWtUe03wyL/hCb7t1/hNtQ17prDIRW1ZA2rOfJVH7H9iGjbbPFxtXvSGet/eU0zlubf6MFRd1h28b0ssk7FDx66lhU6KQxF+TcAo635pfOVzwssmsspyrYj8R8cvIUEhP3V/N/EOq8bqkKLMj42KTWA8KHI7A7hQ6klGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106511; c=relaxed/simple;
	bh=u47Dgdvx91HMuVwC3z0p44i9nPKiM/KaDDcLFirxuWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzgHz3XEfjChvPD9I6Xus7G6/0Q2TyqVZqhuwDabPt/Dj/5P9krah2zMGoGM1T6jcxGgCWi7nfEmnz0zGWsQPerMPiMNhJu5K8BhKil6KmTaDZc8Pa+l1NNm7KBwZ6syKh+l2L/Lpmb1Yx9XYiSOpMgqZWs7A7VQR7xGVVuCLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDIcT-000000004p6-3W4Y;
	Sun, 04 Oct 2026 09:34:57 +0000
Date: Sun, 4 Oct 2026 10:34:55 +0100
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
Subject: [PATCH v3 1/4] dt-bindings: input: touchscreen: hynitron,cst816x:
 axes and panel
Message-ID: <747ca415953777441380b68fd0f004a0c4110095.1791103511.git.daniel@makrotopia.org>
References: <cover.1791103511.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791103511.git.daniel@makrotopia.org>

The chip hands out coordinates in its own frame and knows nothing of
the panel it is glued to, so how it is oriented against that panel,
which coordinate range the assembly reports and how noisy it is are
properties of the board. Reference touchscreen.yaml and let its
properties through, among them the 'panel' phandle naming the panel a
controller is mounted on, which asks for the two to be power sequenced
together.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: describe the whole of touchscreen.yaml with unevaluatedProperties
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
