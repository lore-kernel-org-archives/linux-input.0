Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7423A3E8B
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032186; cv=none; b=hl38PZ6h0djY6PZhiUuNhS5rAzT1r0KFpXxCh+jjCgronFRsv7gQ9PnVPKtFY5g2DlaZQGnHLR6CIc2ohwHX1yUV1MUlhw0T0lPgQnTZApsp4Xn8xpjkMdTgzzN8TGYLsbUl0Xv9ieBzhtbtpLs+SAdH/QZoqhQjSg8TDYSDv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032186; c=relaxed/simple;
	bh=jTwMOmyz6NqS7PQapPujdg9bPtfrUTYsGa1vQFD7WG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je8M2GNHXdeF63vg48jvZsRg+mCRShTb1v1HHpflC5P85CA4172Y6cR4tyz57rsNZandfjhSRDvznbrfEr8AcCB5WzkMM6UygHbss5nNerTx2Qz+h8nvJM6DRpCSSK4fgOEagvvdVtnbm9RCtj5/qPYo7mnb4t/SGfUzn+63QsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFwqNkki; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFwqNkki"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e55b95ba13so6940975a34.3
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 22:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032184; x=1780636984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF4nOUMSYWHAuFSlYY+ocAG8zIXA/0Y12y9w/560UiI=;
        b=ZFwqNkkiWWjGcUbR0vd/VP49dku/DtwYZiaS/ASEVEeN9nFPhDKsB5Os5PL8ZVVNb1
         frzMnxHaZjtShLZ55OAf66ZdAX35RKBfaYCti0QNFPxPn8VgLsg7RAmU1/gx5dNNMKWn
         sSz+1Kff4WK70Zs3edbtQskF+E5LX321nIX8rjvMpPW1siIGPyvfmklqE3V2fDAASbY6
         VVCK6QDAtEdmM/alVo+vQRreDXIK/AxPIibRkiIN4mxWNWysra/581f4iWmr7q+oJDRL
         LeWO2I1kW4VkWeDHCB3UXO2EZ2nJ7Ln+YOMfIlagw6L3AWbynR9ir09vRaVGvpLbxQfn
         cXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032184; x=1780636984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF4nOUMSYWHAuFSlYY+ocAG8zIXA/0Y12y9w/560UiI=;
        b=ZxWc+4wNRM+7qArwOPmQNuB5lBdORR2eIKtvuvVOeL9ej4eW9sNSP2rAtXwYX6pJp/
         2X0Vbl87RZbbdCOojxPFerL5gMP+YgxlUUfBhlGpW7DceQN3ZbsB9wRR1w0dZUiDWtNT
         e9AOHXnihW4aFwSnW90gPI4gdPFO4nBfLL9GZbn74w6DONXJJV5hQbUsDDpSVRyx79MN
         xLP4QAt/jLrf7NcxC7LgBNLHaY1nXif5KBdRP7q5Ulxz9DMWBS5+/iSMzGAzVeskiyuJ
         WnzWSl+DFcpWFT1vrkxF8ovOn4Dg0iXXoLUzwndEfB1HUKel4fJiQSjjMvz5DzW1eQhv
         H0XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fpY6wILI8tp2q2VFq9VQf+/V2JySh5a6o0zn1tCOUeIoJzigfaoHyhvx62CjCj2IHxHLk6vC2gq3vbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm11Pxs3czyz40/7SBQSGUnb8ShLwMSqdCtxPoMYTco6W8aexb
	rCzoykI2gOcymtWViDm4Sf3rfHvawteZmUeuQ942LI2238/ryTTmhdVd
X-Gm-Gg: Acq92OFdE6xYdIRyqa1cr7Xbgf/mc6W6cY59j+stTmEPUs4eyFuglrqAGd9NI/BnHun
	HFAV8aM/d4ovXaEpNrTI79qg/Vuq3QLHHbiabjKW+Jin+dw6+4/LsbZesbOgw84ikq+F9jZoI6y
	sTSQ4OmyGvvcFp/YpzEZFNptuMw26DtgaPKUWcsuM/8iApGWMkHsSRDSYpRS9SmH5osH3UCr9RI
	daR7PYblw01Chrdo4fc41vVcVl1ELJNeZqUWKh4BEaSPTlANGKxuHDpIT9X+CNza9eBXADAWfeV
	bD4lcAywf1LnO3Wy+CGodRMUxS/obGlTrqEGtgl+DhxOZZ879qAju7lkn7KExZdQM8MHd1OCYC/
	cvGEVJsDfhfmXKFdEyy70LFqV0jDQUWFojmGoNRY1xuXgPZXas0F+G8F6J93BFr6JdJ2JDz/F0P
	FPYI4Wz4xtZOtKqR24Zn8Y1B+K93dR1fwvCRbT3yVy+0/+9e1LGk9K
X-Received: by 2002:a05:6830:67d2:b0:7dc:dd58:50c7 with SMTP id 46e09a7af769-7e694df7f54mr1039318a34.18.1780032184244;
        Thu, 28 May 2026 22:23:04 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bd790fsm760909a34.10.2026.05.28.22.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:23:03 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: input: remove obsolete matrix-keymap.txt
Date: Fri, 29 May 2026 00:22:41 -0500
Message-ID: <20260529052246.4934-5-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
References: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

matrix-keymap.txt has been a single-line redirect to
matrix-keymap.yaml since commit 639d6eda3b80 ("dt-bindings: input:
Convert matrix-keymap to json-schema"), which introduced the .yaml
schema and reduced the .txt to a stub in the same change. The .yaml
has the same filename in the same directory, making this redirect
unnecessary for discoverability.

Eight files still reference matrix-keymap.txt, forcing readers
through an extra hop to reach the .yaml. The stub has not been
touched since June 2020. Update all references across input and mfd
binding documentation to point directly to matrix-keymap.yaml and
remove the stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt | 2 +-
 Documentation/devicetree/bindings/input/clps711x-keypad.txt | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.txt   | 1 -
 .../devicetree/bindings/input/nvidia,tegra20-kbc.txt        | 2 +-
 Documentation/devicetree/bindings/input/pxa27x-keypad.txt   | 2 +-
 Documentation/devicetree/bindings/input/st-keyscan.txt      | 2 +-
 Documentation/devicetree/bindings/mfd/tc3589x.txt           | 6 +++---
 7 files changed, 8 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt

diff --git a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
index 262deab73588..33514eba0c9c 100644
--- a/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
+++ b/Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt
@@ -59,7 +59,7 @@ Board Specific Properties:
 	  subsystem (optional).
 
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 
 Example:
 #include "dt-bindings/input/input.h"
diff --git a/Documentation/devicetree/bindings/input/clps711x-keypad.txt b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
index 3eed8819d05d..5f4514c0cd5f 100644
--- a/Documentation/devicetree/bindings/input/clps711x-keypad.txt
+++ b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
@@ -5,7 +5,7 @@ Required Properties:
 - row-gpios:     List of GPIOs used as row lines.
 - poll-interval: Poll interval time in milliseconds.
 - linux,keymap:  The definition can be found at
-                 bindings/input/matrix-keymap.txt.
+                 bindings/input/matrix-keymap.yaml.
 
 Optional Properties:
 - autorepeat:    Enable autorepeat feature.
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
deleted file mode 100644
index 79f6d01aecaa..000000000000
--- a/Documentation/devicetree/bindings/input/matrix-keymap.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has been moved to matrix-keymap.yaml
diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
index 1faa7292e21f..460b64d332cd 100644
--- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
@@ -12,7 +12,7 @@ Required properties:
 - nvidia,kbc-col-pins: The KBC pins which are configured as column. This is an
   array of pin numbers which is used as column.
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 - clocks: Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets: Must contain an entry for each entry in reset-names.
diff --git a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
index f8674f7e5ea5..a727d66eece4 100644
--- a/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
+++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
@@ -10,7 +10,7 @@ Required Properties
   interval for matrix key. The value is in binary number of 2ms
 
 Optional Properties For Matrix Keyes
-Please refer to matrix-keymap.txt
+Please refer to matrix-keymap.yaml
 
 Optional Properties for Direct Keyes
 - marvell,direct-key-count : How many direct keyes are used.
diff --git a/Documentation/devicetree/bindings/input/st-keyscan.txt b/Documentation/devicetree/bindings/input/st-keyscan.txt
index 51eb428e5c85..fd88f40faebf 100644
--- a/Documentation/devicetree/bindings/input/st-keyscan.txt
+++ b/Documentation/devicetree/bindings/input/st-keyscan.txt
@@ -17,7 +17,7 @@ Required properties:
   See ../pinctrl/pinctrl-bindings.txt for details.
 
 - linux,keymap: The keymap for keys as described in the binding document
-  devicetree/bindings/input/matrix-keymap.txt.
+  devicetree/bindings/input/matrix-keymap.yaml.
 
 - keypad,num-rows: Number of row lines connected to the keypad controller.
 
diff --git a/Documentation/devicetree/bindings/mfd/tc3589x.txt b/Documentation/devicetree/bindings/mfd/tc3589x.txt
index 4f22b2b07dc5..a6d356e90f42 100644
--- a/Documentation/devicetree/bindings/mfd/tc3589x.txt
+++ b/Documentation/devicetree/bindings/mfd/tc3589x.txt
@@ -48,11 +48,11 @@ Optional nodes:
  - compatible : must be "toshiba,tc3589x-keypad"
  - debounce-delay-ms : debounce interval in milliseconds
  - keypad,num-rows : number of rows in the matrix, see
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - keypad,num-columns : number of columns in the matrix, see
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - linux,keymap: the definition can be found in
-   bindings/input/matrix-keymap.txt
+   bindings/input/matrix-keymap.yaml
  - linux,no-autorepeat: do no enable autorepeat feature.
  - wakeup-source: use any event on keypad as wakeup event.
 		  (Legacy property supported: "linux,wakeup")
-- 
2.54.0

