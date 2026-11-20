Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160047;
	b=I3I7eZr8X1yxgoeJd58XF4gHNxdb5MXyTDaMsXqQzYVievJC+k7yO+8kmWuRrGkpznoX
	 wa++cTPuU2aC38fBf83z9W9Z68rQW+HTX3dqBXEUBq+FDPV2r0UukD3rMmD7fp1RrcEHj
	 zJwYiSIgBw1+8NKi/ONJ788ImuWabAcdivz2gAyWMkKv5L0kGFgzfH6EshcpiC3+4nvcC
	 rn2e9bVV4Q4lTZqLQ+s9PB9QETCNeIOGzJ9VJwT6GJCRUeDE0WqGQSajNxo/NihnYBeXu
	 WeUcZw+8dqTzaiKqStPerWXDRffuceuothGboqTfQK9R9dIy0v6mPcvgak1/FuXyJ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
	b=4vcyb/mapvXkMOrVVtWRzoQqBK8pwOIajJbIOFt7TMOT5oSxIcQvbC5K/qsZNIC0D6Ah
	 ltf+xfNBL3jzaCf0jncHuOlZePwEKiOrZrCpI5OTIaX/9DRXrJPmelUaEa9wc0Eia1ZWv
	 tPu83T92NGXwj/plTM3RJTYqdV9ivzkooX2ahK8akpLSk2Oc7M2PlaZETDWgFAd2hfm6f
	 QB+6j7LMuvCvwKloHxfRGvq9rqHtcN/anLFA9GNxMeDIt4jUtFEb6DGm5T9VxUv9VBet/
	 OjaIP5Wa7t6kW079Bi802b3YBAv8p/0qm6pweWJUvf0Iwgt+Lp3d1HaTcvallsVK/6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QomUB9wk;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49560A3818
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D49560A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QomUB9wk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso15639155e9.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160045; x=1795764845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=QomUB9wk5UINFnNmRIvHm/ArMbX6n/cgwMpT4/4Nyjr1QDC9P82L5pLn7KFoBaJ2S5
         MRNX+Q93EVcI6f7taqmmyDBlHekO8S7XYnZHlzpW1YjWWrUpQ68XElhy2WriGo0TvS2Q
         eAgH6Mhv2D/Zb+QnbtMnkIwaumlMpk4WiY4xbvX6bd0u/Gzq+Ps+Ntd2CANoqmt+k3UE
         Xl+qpKBEwHT65+WEXab9TmclpX+XkvTgg7i+al4ZPxzRqTlhqsmXHqAPh967SXNpmCo7
         6DfDg4dDd6a5690opLuGnSaxGtRaokNqbSVP093PUcQCdXJrl3k54pKCgW4v+blQZQd6
         vhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160045; x=1795764845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=06e8U0oZFHxswqQRQd+79NjEL+U4fLEmyb/swCIbiSq2ti6Shk4spBct0DVOxx9WHh
         bsJSnYcqxzp/x7bhjOaUTnfCjubhMgF3MJwtoJ5AI7JAuyX6pSUWsKDIOHSkE90G7fgY
         FeqGZjTcxkZWYHTN3hf++v5fECympF7Hif3ZFhes8ujwJOFcu7YT4rqwec7LnLj+hELY
         6nGG4YB01A+l+7CDdWcIG65E/Z6GaD+wLW0tSu//COYdZP7YY8vEm3c7GbjWs067bm+N
         Wym6MM0iuosTi/SyJl5VIgtHZacZXYpngJct/a4N1jh72CgLHzNuGNoWaSydwEyD0Cx9
         tvcA==
X-Forwarded-Encrypted: i=1; AL+hErF0p3El435Yw8mj/9WhcmFyFu9Rg/Oav+6nVEGLhpPASEiRvOwYwlCngK7qj8rBdReYB+JPgCwjsdZWKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Iar/LWPnf3ZsA3xXr8xRm4DwWqJLe/5K+yQA7+D0ujbCVBsm3
	C3AypFxVcylcBWxomIbBKRlNVj96NMEqe8MLRQCRYOmG4hAoq7Jp7jZg
X-Gm-Gg: AYBFou2zS+JoBoyDOldbAEbGOcCXuS1JZHosB6M4ifxyFDoTty4ZMWsHl8XiYVjmno4
	2GpGZoPAe7933ILEld0evhSj/nEWGCD7BdVVgXeTBzUvlo/buNSjkr3nMO+ULlHF0EG/brYcweT
	sSTLjeu5OFngR1cfFsjPwWELzso7ENkXlbDAOSkFi6yD+cry8G9bfkNSYUzQYqebxyw99SQcr+W
	PKCGbpelAeqhV/Pc1Sp7MUigmDNJYLsjHMRcG+X9VqCjP0/7h4tXrNKFgP8PG6wFiV/pGI9LLzv
	DvpsbRMV1wCJrKvM/iaDy2jp9HqIoK2cdrTZ4Jex3Vk3tfgvJ0M13i3nJb20b2wUS4r9JUrQmmP
	9KbUP4vYN03fGE+BLrvFz13hWAa5wcaC74NSAejFAubF4LuhhdKh7jojC9lwMSZ+WgyeAt6eYoL
	Sh4nWtodjGXqAORe0BC9/bye9H5orJ2jYTXij6QED8Q5apQR/BD/Z/FX1A25h2uRVPEwi654Qr6
	ZToesT9aLJDTG8uoz91ezp2fdP61+6jJraG07Jyh/yQ+ljrZLUD+48uUkRGur0u2yewkjJ7aWK0
	xwQngffWuA3hz4/x252cFbP+preL3EKvJyJRkUA5INpHon6KHM5ClTtwYTV58I5Hzr/g6XvFoIW
	oPZParDFPEVuAzRD5cfEe
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id 5b1f17b1804b1-4bb8881099cmr44675865e9.12.1795160045388;
        Thu, 19 Nov 2026 23:34:05 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:34:05 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
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
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 05/10] dt-bindings: input: touchscreen: add Silicon Works SW42902
Date: Fri, 20 Nov 2026 08:33:53 +0100
Message-Id: <20261120073358.10267-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c5ec3bf4e545b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4aac18d44a..a29019d984393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

