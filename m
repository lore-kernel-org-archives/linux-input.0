Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309275;
	b=fxMjkZOMWCToQ8d8/eQNAm/MUYaQsWvpMfyUQNBKb6mh6iiKi+8IzQ95NoLjzvuOA3m8
	 plTaeiA/82dVrvLulV7uKLXwQIPfq9Vx0b4x9Rsk9hO8hz/7QGMIJL60xhE+PcQqaZ83n
	 bzxzTbqAKUh00V6SwKjYXJVIlBB63xF7yOPCSPSRjbr+25H/lNY5QYakFWzatxpvDziPp
	 vuco3KSS8LILZHSbMcUG3c89m84j2WSstNbBnrjH7HdnVllo4T6+PIpWEoamE+FI/l6rr
	 Qge46ZcV5IkNvh7+QJF9Sbn6U86aj9hr6VOGAgIw8Ss3MFJakhIqjbodTl0PJ3DpXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vDiweiYOObynXPO198CmBSeMUJu3WdkZCa738v5k3/E=;
	b=M/GQpZjVHDGWmTPo6PX2xzAIO+7AU9vZ+2zY9LF1NpedTOQ07lZ4fC6OO9ijC+xRhMSV
	 dzZloz4CkK+nj9P/NYWqNuUgIY9w5a40CncmA1vZ5z/UCXgq/mWq74g9MZVxHq6/NGmQn
	 xl9VpVOvM/sR9McXtIpZTefH2IhfbBgMYf+GwYxd4SjwS9AKGrtYMyaik7qDYe1orLhu2
	 HIctyxpsW3loY1XqkuXQc9plBeOh7DLQeuafPcjmVCKAH5ohjNMiRHVBRyJW17ElUI9b/
	 +p4zZHPT907cpN3K/8GexJBZ2Z8ewjrQrVaGZKgoJpvWSyXyrIi7Cv0Iiges2MElJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0A4NBtI0;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB154606A32A
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 11:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB154606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0A4NBtI0
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1081787a12.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309274; x=1794914074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDiweiYOObynXPO198CmBSeMUJu3WdkZCa738v5k3/E=;
        b=0A4NBtI0eyXzfDdgbJFJ0O+X5G9I6rwPW7cDcK3TBsChbEgP3ATozn1s+AimSSjxqm
         eRcFDjUgqeGUyIa1o7Yi0YEHLGcr1EWbADhlYgoFlkAxVmKhewf8cghrZc+4CQrZlfRz
         U82qtl5cQHGi/el/C3+TstzdjXim7pE8wXX5j5Hue+TvObXOQ8dRuSjoDUrdhYi6x7LZ
         rEdNhPcZmY9t9wRc+pwsBOHq0hgtzUxSvIAE7szblCSWxTOwEZ1oHQuCqvZdh0X4aEhj
         k/x7KzleGiiYPI3F7IFpbIlzCyxyI0S7/fcZhCQ0JveNxGBFOy8NnIVMiN/kzJzdw9uX
         GmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309274; x=1794914074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDiweiYOObynXPO198CmBSeMUJu3WdkZCa738v5k3/E=;
        b=USJn+iNGbXAKzZ0hYG8MDFn9M64FBb6PM9opRBqtlvFTHsKkaJEhIixwij0402dlEU
         EtrX+DRzqY5lzUqHhB3UhbbFi/DHsXNJ3OEdsHrH4YRxy1s5VzA31egI6qWFkN5Dv+Hp
         YpT8ZBZTk6msnox+ouxL2h0RVxLOiZnoRUiV3s5imZ6ikq88w5g94GMP0XJ78E+r3C3u
         qZVe8xCK54PwUNR6WHzPWx/QpN2eprWJTzCqcqB6V1UIytnurgJ+XuqSJXLX+DwAi3Fb
         fjE31N+S0cT3JKqE71HtFY6AnJv7Cyre5VqA1wtyQLKqbJ9+qV++YioeKYtp4BiBkQSU
         pUCg==
X-Forwarded-Encrypted: i=1; AL+hErEOlPLV4gH45ElPxL7sLKMgSxmPIbpkiBNx9u3Jzh0yJlRsvb0imZr9TTR+EyJt3MIHlHg0WR+FHZ6rWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8penTOVjKoKGFqvdnOWS9CvUvXdWgH6ZZx5v+Su6B4/IYhmiTD
	hjFEpQMl68IgRRN2aOugzjXn9EmzXU9njG7j+nwSbye5RhZ0cuomd4mo
X-Gm-Gg: AYBFou1NHegNSCL77tlGuSQqxcV9wHY82cXbcB+556CrQVpEUVSxAHJeJYuzgxfIY/+
	q4vl8ZtnXXDSwF/fq2rltXKekoLIrtH0j2xM3bONkyVI+b2jHF0WthkEiabJLDAMVasJwiR576V
	H/BI7XMOxw/nA3d4cfeRXwktIOsU+ZgbxhLiAVG4+xWzs/5jkSunSx0fo/wbDEeWwBC/DYFMgKz
	06y+1RTeuW77PGy76m0O9NXYWNHOHUcooBAJHxTWAu28eQzz7uNxIXQawQBxYYZmzFJHfDUfMxQ
	7I/IOIMPks2KVcs1EfOcKmDFJK4LfP2cW6Lpxijp29gYYZvGPDeFtQwES/FnFDPtRYsBVnF8TCz
	+i2OZYhFy3KAUwuY0LFgeu516iWcCqJi7evODh6gpSarOG/QuoidPtgbZSZOBr42Z6mt0MFTJ2U
	1hBNyce75rkJeZRlhJ09CALZr6T6togS6CO6As+JiVBeLbF0WwoW9USlrgGA0JLieBbjpF8GzIm
	EWKbp+ISaYC3e1XG7zx0gj0//m8D8WR+WQk9mqqMFtYlyC9mVjH3pcAFK7xRnb2Sen+ZRkUY/Bn
	rWJHA1cx+6Irf8iBl7wZuT9ox/KYyrvLOIipR2RcjcnUfFyFy6Xo3q9NDDvHqlRekKBdqdv067Y
	ODNno
X-Received: by 2002:a17:90b:2e87:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3b166d05111mr2527465a91.46.1794309274191;
        Tue, 10 Nov 2026 03:14:34 -0800 (PST)
Received: from fyhsueh.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1678ceda0sm3556684a91.5.2026.11.10.03.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:14:33 -0800 (PST)
From: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: input: Add Nuvoton MA35D1 keypad controller
Date: Tue, 10 Nov 2026 19:14:18 +0800
Message-ID: <20261110111419.89535-2-fyhsueh4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
References: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Nuvoton MA35D1 hardware matrix keypad controller.

The controller supports up to eight rows and eight columns
and generates interrupts for key press and release events.

Signed-off-by: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
---
 .../bindings/input/nuvoton,ma35d1-keypad.yaml | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
new file mode 100644
index 000000000000..be678d0b38b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/nuvoton,ma35d1-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Matrix Keypad Controller
+
+maintainers:
+  - Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
+
+description: |
+  The Nuvoton MA35D1 keypad controller scans a matrix of up to eight rows
+  and eight columns and reports key press and release interrupts.
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  keypad,num-rows:
+    minimum: 2
+    maximum: 8
+
+  keypad,num-columns:
+    minimum: 1
+    maximum: 8
+
+  autorepeat:
+    type: boolean
+    description: Enable key autorepeat events.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - keypad,num-rows
+  - keypad,num-columns
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    keypad@404a0000 {
+        compatible = "nuvoton,ma35d1-keypad";
+        reg = <0x404a0000 0x10000>;
+        interrupts = <79>;
+        clocks = <&clk>;
+
+        keypad,num-rows = <4>;
+        keypad,num-columns = <1>;
+        linux,keymap = <
+            MATRIX_KEY(0, 0, KEY_1)
+            MATRIX_KEY(1, 0, KEY_2)
+            MATRIX_KEY(2, 0, KEY_3)
+            MATRIX_KEY(3, 0, KEY_4)
+        >;
+    };
-- 
2.43.0

