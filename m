Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796943;
	b=UB4Egqj0B3ArgeThPNP+RkyqwSf8b/bCV9Snd/i/wIObTUOckkUFmO7IV7YCNM10zmnC
	 jbAiIo7ord4gRqnnzmCUVmicm/ghV3rJ2LRiNqjInU+GXNwSMSD8e3ZmlqnDQ2O4D5T5P
	 O4+/+hTR9IlTzBp2dvh39z9jLXupDaldCQQhleL38W+AsBHiOpwQawUSBJD0cpFrnurSl
	 Ww/T49pqaDTwTRpPSPmgoz9/eqQvO56gnBcJ9SxYUVFt+T90m11nGnHwcJvqX82zDohWy
	 ZayS6JIv8iEI+Ql9Nv3LwYc5YE3Z8eLnDtzSXryND3E4NBsJGTppQcVWoLW+iJmzqCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796943;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vTGqihwmGzrNuZflxgULY5U2b4s93bfhFCTQi2W61pw=;
	b=0/nC8fFltU/rF4r/JV3GEpIXDutv12fyqzq+iRyjfKG1rWf2QB3x4c+zGgdCug9kbgn4
	 yVRmHwUB33NbMzlSb3M+EsCBl+uAQnm20/csJb6cbaF8Qqnln1T5N+hvIVva79jdJTgZz
	 d0J5xNFypRRpks2HK3hh+WyoPjtqyyfUMQo0PsebJvU4R54k4yO6Bmv4Dxdc0ocUXJrYx
	 4+6od+p1BJJYqQSS9Iq9ZXBddVQ5MLttR7KwcwQwVcruh6xBfBiZPabXRNw7nd5TVxvho
	 lLO35wIgKak88wxs8RxNOnvHbuAYEAVOcU4tltGJSoCQe2/rY5IabTaSVB82uNH7Khg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYbyRHFH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D5606A328;
	Wed,  4 Nov 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYbyRHFH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793796943;
	b=DVNvmaLoadpzbJWFyKoCjTh5t1hzknKUc9pwPKJ7jn8Su4HSvvvMXTN069M2yBJQZ6Rg
	 zweB7Ty0gMLyPj6H+qRALJD9CjumHIji/FUv8bQtS9P0UUWAWiLpgPrReXI1tSR9D764E
	 Bp6zl0rL4n65wJrnP+MRlixLTB6XuUDendPAWekAEWh9IN9d3u4cKNKuaSG0ru8baGL/p
	 fPXujhSnAm17BO9lw3zDrhQjBOPCzk3KWoQmLWoQ6QpQM9l52EHZfvpqjuBJYkEDwnekR
	 jdy89KZ1acpiNP+SGtCkJgaPbRpMipGxUUBMUXPQb6YnBksp1Kkas2ucL2Sof3RWw5Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796943;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vTGqihwmGzrNuZflxgULY5U2b4s93bfhFCTQi2W61pw=;
	b=sk4ZI8YAzAwrDueMg88ZmlGzu4hSO0O2oKskayclrM00YkNqKt89rj5FHaPmI3ytFKCB
	 dCFg0f13hSIcd9oBlv9PTQW3BhPUD9+Rh2/FPZ8vmXdk+FoMWbVviG21RvpYCU94whLfH
	 K0UpWEg0pBEMGj92fR39qO9D7Dmih0CpkZrPxjHNSWwrZdsZ6Crfw+OXvcj7Ax9VNZt8Z
	 YGNBPIThz2QkV3DH3wSuiG6rib1DYBUliPxRgoI1org79AgjBi9c5ixvylBu1ID61K8r2
	 rE0feh1TaBeW7KEdGF9sB7K4ljcaYW3JM5LtSWOLL7V0QrSXsyXf/louaRCds2OPw/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 501A71F000C1;
	Wed,  4 Nov 2026 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796943;
	bh=vTGqihwmGzrNuZflxgULY5U2b4s93bfhFCTQi2W61pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cYbyRHFHki2MHX07ISexVK4LL5cJ8lRx/pHcdnWBeFBfKA/dDXj0JT+PznmgzBkyj
	 9MMjKFisyelh0oBWnJ6nM8bY5SF+SVSjs/fpjJVjWVa9tt3mYSLoQNRiwdOTP5s4kT
	 V8/AgvCucrwobSmklLfXJTWCANf63dM0NQrjCElNIWWaL2IGNRfPZ0MBfs+gVurA5h
	 6+1B/BCSczLC7YNrYCXdbZIBeJ612/NGS0rE782MtQVak/Mw9yE88iG21S6OBZR0Y3
	 0CQLW2GtM0jEpnnmi98q7xo8FGeeMWsSBQEmhwJLuSOdUop5yLKogOkLH/DHCARF49
	 GuPDYue1wLm7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B7AE346E11;
	Wed,  4 Nov 2026 12:55:41 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 04 Nov 2026 13:54:43 +0100
Subject: [PATCH RFC 1/3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 wakeup gestures
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
Message-Id: <20261104-ft5x06-double-tap-v1-1-5a1bd80449cc@ixit.cz>
References: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
In-Reply-To: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=CWVg/HPnzh79xLHK286mGUAsBwZwcwLqhHu3WsPOxsc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq6ytMDofKtjnbQG0UW/hiJk4rmQoFmHnSJZOc2
 tOPq7B7Jw2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCausrTAAKCRBgAj/E00kg
 cofEEACZXxqt5oBzQbhOB7g5IHLixtw7MUeaM42qTTdhn5j7Fb+V61I+tEsdB2QfiQXv/AW1NrG
 jU+XpngB3wStXsi4+9tn9GdGhfTs+q0GQb0gJ0WUaMFbnG3tbHC+oUdjY8sbYypMN3fABIvBALV
 nuR5Vxc0LFV9R5OG7Tlm9g++E0V0xEQeGtVksWP6gK7qzJ+NUOSJkgt222KJR3IpZfvb5/yrXyJ
 +XIxA25BdSoDXCxrKKms6q9L0CrzolCbQsIDJJe5osnjv7NNQiJVssJQtIsomt2rikm6JUxei4a
 f6jn3PZx9j1fKKNpmHcJkZMySBef7a71gVemWmJ1XHi0iLpAmblLna6w0pC5uynWxsgYGQ3y1YE
 n8GKhnn0ikhYvQx9J9DAEll8L0uc5uUID7N1bpFfOXAi7GYK1wyhBNf0Xl4S+lEhz4ykt6b4/qb
 GjUKpDzuwW3THwPHyflsy+wu3gllWlrCWe43/OmUMcZ2c6v4Vj/6XH3GqBj0YUlh37NB8dIvUy5
 uovuwmXymPEoirWXKmfHKj4bsZGb7dIhrmN0nG2cnnhGnvn6ybdeO/jPj6BR44MX+Fjaw3vo7Qt
 oRWt2gaEtmge5GGIfQOakj8c6M82xSgyy1IeiY/aMdZMEWKDPa2S+9MmCzaJPvcr2yj14+Mwt5D
 0dPgu7e+jufiMTw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The FocalTech controllers have a gesture mode in which the firmware
keeps detecting a configurable set of gestures and signals them on the
interrupt line, so they can wake the system. Describe the gestures as
event child nodes carrying the key code to report, like the Azoteq
IQS7211 binding does, so that the mapping is the board's choice and
more gestures can be added later without changing the driver
interface.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/input/touchscreen/edt-ft5x06.yaml     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 68b2f16016543..bfc540665a2d2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -106,16 +106,35 @@ properties:
   threshold:
     description: Allows setting the  "click"-threshold in the range from 0 to 255.
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 255
 
   interrupt-controller: true
 
+patternProperties:
+  "^event-(tap-double|swipe-(up|down|left|right))$":
+    type: object
+    $ref: ../input.yaml#
+    description:
+      A gesture the controller keeps detecting in its gesture mode, reported
+      as a key on a separate input device. Gesture mode is entered when the
+      touchscreen input device is closed or the system suspends, provided
+      the device may wake up the system. Only controllers whose firmware
+      implements the gesture registers support these nodes.
+
+    properties:
+      linux,code: true
+
+    required:
+      - linux,code
+
+    additionalProperties: false
+
 unevaluatedProperties: false
 
 required:
   - compatible
   - reg
   - interrupts
 
 examples:
@@ -130,9 +149,27 @@ examples:
         reg = <0x38>;
         interrupt-parent = <&gpio2>;
         interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
         reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
         wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
       };
     };
 
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@38 {
+        compatible = "focaltech,ft5452";
+        reg = <0x38>;
+        interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+        wakeup-source;
+
+        event-tap-double {
+          linux,code = <KEY_WAKEUP>;
+        };
+      };
+    };
+
 ...

-- 
2.55.0


