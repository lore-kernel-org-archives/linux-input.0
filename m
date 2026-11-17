Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919195;
	b=RZyjR7q00NT0YoOYwI2dLLhPX1Sz0IjalU3rhOLfVDCCE+LMpOtxK49ruQB+66YSGQMH
	 A7ZZommwoeox9EUQjN1R13+klYSq75M+QNDMzt9yd3wVauxjpDrL13D7X481MTr2ffMXW
	 EkvF+SeCgQjnkTbuD8/5FYeUQjmONoE8H+wUgvSF8vc81qMqKi8DLJkOnjV4uSFF0P3hn
	 AfAo4zZkk81DUBR30nJFLXx509AYV4P3uoHAE9hDdCufgylTdE6RfauckBoYQmzajSUJW
	 Amx0RiqGEBhSS6kWHAVsfHobHnCZPuqnS6rxdEsmBBDkF2W+3yzeY1paTVZl+SsrmcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T5qIDqJW1HylN9V1krTTvvmwCzdpLearj6f6TGS/cFE=;
	b=NXtpYP9vJf/t4LVUJxF891jRSNOYhUvmgTg3mndWhA+8TkiSNc2DrQoFe8lsVr0ioHvo
	 3ghMFpxwMhVFLwl+/p9lyoPpTzjv2/41vs53ZHvhFq+dBNcQIt4uJYy3egs+7iHN7nxSR
	 ntiWalujD/shoOqPM8HLP39ktJv579Or7pvqlX93jV4FIWLAsRqJTILfg+xvdNU2xNEFi
	 8Bl24F4Bu4JU/aDAF1PA8lLGGK29gqpX0KelHUEtmpY+S+AfnOQspisdQ822CfSL5z0JS
	 cFizOW8xO2t1pLvr3HdzAnQ1r830Bee+J+u3vWmcyTfSUMp+JsPk490p8+1arg/bniQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKqmelpS;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A838A60A2610
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A838A60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gKqmelpS
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so21347775e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794919193; x=1795523993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5qIDqJW1HylN9V1krTTvvmwCzdpLearj6f6TGS/cFE=;
        b=gKqmelpSihWWG/SBPNWiup0TtC/pZsi60X7mAIi+TAQYFt7+0MgqlU2IIuIunAogkw
         a6LBtOHF+5Axo0gsL0Q8UtGMP3PE5yvnyE4naACIO3TQgR1mJZkAjQ9H9fCdYHWMF7at
         OIV6MH3ix5xMyDw26/RHwNQt8F1lYEXEpM5gZfn+6R3opTm/PuzNERQufwkd0RpEEB6Y
         pHp7Jv7hrkK4qCoouK2+6aXkteZIpikR36SiwLUg6ev4S44x98ON4EPlPfpYhEQHszhE
         Xj2sA7CeWqo8bciqV7gr/OSJXSlDgHrg7zblmIwxvct8C3ooV7y+OPknTctlMMHlT3qs
         mNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919193; x=1795523993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5qIDqJW1HylN9V1krTTvvmwCzdpLearj6f6TGS/cFE=;
        b=ki10uPyCtFAsBDZFj5hDGwt++xtrqegUY4dQ4bTmtnjgY1BupdqC3nr6MOKqgypBeF
         0t6Py25XTyWv+gg74QvbFhukgzbSPxcU9jxaxkmwZFTDInWarmRJXoBBPWXVGlQA3NFZ
         PBPBD3NaMBy04UVWX2ve0FZuAnYuCTzlrkJRh8HTTrTSRc/Nb0yDOKOvitFBwQB/2+Cs
         QQ89Ti22ORLRRJqrTbYNwSdARB+bRls5Z2g3e45Z50sNkdA2oosmD5Qr6TIokgOuztMl
         yUA/S+1q9aAqSqrvdj6A/hpX15it5caRDCVTJPctKDofHotrOrM29vjOaui9pIat9wjc
         og6g==
X-Forwarded-Encrypted: i=1; AL+hErE8xeJb7fuMuvIbKKCY6fanEj8Zq7X3b0nHm57vZtI2lZtNenaW7OarJVoxtA6qPoK8TvH5I9VtBiNmgg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WFO3OfSFXg+T+dXmjB+9nd6vczJElmi9UFOakXaZtDKPbn6RZ
	IWvsQPWpSlwx5LOOJZ67Ae3GYu+9OHoYtkFIoorUK/uubfX/8ThwD98x
X-Gm-Gg: AYBFou2CgqQrmktS2+XkTbokhr392lhGDcoBHPPmY8VR31wOIaT4wXch1CAz03OzgjQ
	UrXJMSONfDHZ6Qogl2DGf2g1eRGR0tEoQUJWPGd8VzRfQHvKOK34OmCP9hBLZXkLWX15XXurVJJ
	A2y2YmXYK9GQ2HG6NxLFBLuO1L8eR2XiDUKEIJ43ZFO4sjEx/LSCa1uHQNILvnBaOCMweVnBhQZ
	pbjsLkPGYWDRn1g0gXsxC77IBAe7W7iI5Y5fzaPXuOZ3ZxKZ8S9JcNuTVZHKKt7sSoYKHtaA8yT
	mKhlx+WcniaCQGOFTCyYCrsFCfWI4MO3RigCWwKhu4XkuhdOF+AKUleVXrKrbdV38I3I34Xd0tu
	O6zAOqho4LClgbufqvecxGTS77UHekFdX5ElTlP7YDW9zpEsC7lZtfXa7bhHqq5amwdK/RVP0/Z
	t2IGstoT1rZZjzPgT24bsQ2nTnzsWUAJXKCJKdl89Ud8GlLbMDQgc9f6Yg8X1iWyy7WtTXxUAFD
	vIvpoPXmE8FW24P5usE3+J6iBNfRJukm5LCtXh0k7Y4HAjShChrqVFoteae9WJHMjwyquUjt1CS
	wAW26cy2D85cFhkVBmQGxVsm1x6kAVX5nx66z1pZTokB+te0eEfFZH8XOx7aYKCrsFynfw==
X-Received: by 2002:a05:600c:3152:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4bb55aac0bfmr303633355e9.34.1794919192859;
        Tue, 17 Nov 2026 04:39:52 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu. [94.21.223.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:39:52 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 04/11] dt-bindings: display: panel: add LG SW43103
Date: Tue, 17 Nov 2026 13:39:39 +0100
Message-Id: <20261117123946.668557-5-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
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

Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
uses DSI command mode with DSC and DCS backlight control.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../bindings/display/panel/lg,sw43103.yaml    | 70 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..edd007e2c0d76
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - rofikkerneldev <rofikcoga@gmail.com>
+
+description:
+  This panel is used on the LG V60 ThinQ 5G (timelm). It is a 60 Hz FHD+ AMOLED
+  panel driven by a Silicon Works SW43103 DDIC, operating in DSI Command Mode
+  with DSC (Display Stream Compression).
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lg,sw43103
+      - boe,sw43103
+
+  reg:
+    maxItems: 1
+
+  port: true
+  vddi-supply: true
+  vpnl-supply: true
+  reset-gpios: true
+  enable-gpios: true
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - vpnl-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lg,sw43103";
+            reg = <0>;
+
+            vddi-supply = <&vreg_l14a_1p8>;
+            vpnl-supply = <&vreg_l11c_3p0>;
+
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 315a4a000b405..bca5065166c25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15231,6 +15231,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mkrufky/tuners.git
 F:	drivers/media/dvb-frontends/lgdt3305.*
 
+LG SW43103 PANEL DRIVER
+M:	rofikkerneldev <rofikcoga@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
+
 LG V60 THINQ 5G (TIMELM) SUPPORT
 M:	rofikkerneldev <rofikcoga@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.39.5

