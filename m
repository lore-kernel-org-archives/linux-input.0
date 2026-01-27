Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2F35CB88;
	Tue, 27 Jan 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525523; cv=none; b=ZgsuySeSIAgB4PqldY9FCxXG4mIzi39EiBUyvX7EbV3pubqjgFseqMZCn3Ams9MpXkQpb8AJGt1ouEFsZRDH2/3xFCQzJSBS9t6s6CBYttypmyZqKf/FDdMQUerGFbrVt5KDUc3eh0DflyKjCWSDz2AtqSg2Ll11VLWvtUtBr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525523; c=relaxed/simple;
	bh=Y1aTGrj+T5ew/r2tekQVQC4kuyZlpaq34RSWtkkdDXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNrpQgD4rIJvTG0qOm8TBxFRil5iFLGiRojyjFxcryAqgjSm8Ae9Qiym2eClvyVXYtwIIc8DuLvZ4y8d4hAg1A1sZK1OzikM3JYZ3bN8dt3iOuuu2aIud6e40NO9veHxnNHZ22VzDvVjPeoiem+xMrkYinyEt6xRZqpE3EDef20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=Vv2bJrFl; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="Vv2bJrFl"
Received: from pps.filterd (m0341555.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R3xtne2168300;
	Tue, 27 Jan 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=pTdiG
	SQWR8CoFPJB6g5SSv9kU6UpFlXRfiZeFiLJKnI=; b=Vv2bJrFliFYR1YzKi1gQz
	q0dxpNSENzQIlxKZ+mSyXGq6cX2FcNwY3BkKR1Qom+4J/QFnMUiKLoiS3G0/4Bby
	Nw1+gWkTPbWust+AIboOKHilLSDXx3MT2SP3LLNulxRExKjY7457Pzq/tAwbEroG
	tF9YriZjdvBYN+k+VpGn6VF4Na8kQ5lehqU4E1JC68jkPYKVeiInrMcscOAFL9Uc
	r4kSWwytj08cNuhJjGx92m9V1chpMkQ2aNsE0VDccLtBYxAv+N45TVYIz2xJJv55
	QE02eBSu/KU2/tzV5L61Ic9SHOf8puGSJVsyk75IBJGUBDJmdrD9NcPhF0tZaxet
	g==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bwcb144b0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 14:51:42 +0000 (GMT)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id CD0E8580C2;
	Tue, 27 Jan 2026 08:51:41 -0600 (CST)
From: Danny Kaehn <danny.kaehn@plexus.com>
Date: Tue, 27 Jan 2026 08:47:48 -0600
Subject: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
In-Reply-To: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Danny Kaehn <danny.kaehn@plexus.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769525272; l=3302;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=Y1aTGrj+T5ew/r2tekQVQC4kuyZlpaq34RSWtkkdDXM=;
 b=GVlGDiAHZohuzcYIs33doTgqxsMtx5zMpDCYeRY3IOKd1yjcPFOVOVTIXDD+Fv7ewRgcVhrMG
 5JWvDWk9noZBN7amoQryflE1nWGphjF/aSMM2vkNnmQ1u/QQ7HYyUMZ
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QvVTHFyd c=1 sm=1 tr=0 ts=6978d0fe cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=Y_joWELsAAAA:8 a=a1k9qEM8g4OboYts1TMA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-GUID: vqOdFnRwUQZaWRMpHF6wECOKh_D6q8h3
X-Proofpoint-ORIG-GUID: 1oZbHwha7lLEgM-L5EbAbnAff3ljd7f5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX2qCt9E6HStZo
 /XxuEBiAO/OsdOKa7H3nnw/xEHZ4tensWGvYaABcvejpaiSaL7tpL+ZDSOG+6hnySUqkBtBZOsb
 XRnv7OKo9OR9fnGK7J1gvoga6gcGAylmDhPAuv1k3yG1gUDBAUAXaeQtWJDc7uGXw2+ZEzjHYjT
 N45lLLcQvNkFZpKnEkvCWz52+AGfPINKRH3juCCEwbApQf0x67VzH5EHh9Ji0eDKXWrC2HbxyA5
 fF2j5HWutHqgzPxF6d+Ou2ZY751ZvU7krliFElJ9E5m6fqTSX+qxfu6TdprJ3o1Y8NCKyYoHPbh
 nFyUg7cp87fn91z6YyMeyIftDd/MRDiM1NqlAXclvu83GgLKOjnTb9cWy1W8ZIt0TLhy89IPbDS
 GNiMJPP31hkCuFhIZzpxq7gFOw5sLSmHP5KYHuoMc98N3N06+oY5Se7QxR17lB4g1s1iL7EcT5+
 3u8IUBfNLartnyUTBtQ==
X-Proofpoint-Spam-Reason: orgsafe

This is a USB HID device which includes an I2C controller and 8 GPIO pins.

The binding allows describing the chip's gpio and i2c controller in DT,
with the i2c controller being bound to a subnode named "i2c". This is
intended to be used in configurations where the CP2112 is permanently
connected in hardware.

Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
---
 .../devicetree/bindings/i2c/silabs,cp2112.yaml     | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml b/Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml
new file mode 100644
index 000000000000..a204adfe57b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/silabs,cp2112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CP2112 HID USB to SMBus/I2C Bridge
+
+maintainers:
+  - Danny Kaehn <danny.kaehn@plexus.com>
+
+description:
+  The CP2112 is a USB HID device which includes an integrated I2C controller
+  and 8 GPIO pins. Its GPIO pins can each be configured as inputs, open-drain
+  outputs, or push-pull outputs.
+
+properties:
+  compatible:
+    const: usb10c4,ea90
+
+  reg:
+    maxItems: 1
+    description: The USB port number
+
+  interrupt-controller: true
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 8
+
+  i2c:
+    description: The SMBus/I2C controller node for the CP2112
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      clock-frequency:
+        minimum: 10000
+        default: 100000
+        maximum: 400000
+
+patternProperties:
+  "-hog(-[0-9]+)?$":
+    type: object
+
+    required:
+      - gpio-hog
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cp2112: device@1 {
+            compatible = "usb10c4,ea90";
+            reg = <1>;
+
+            gpio-controller;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            #gpio-cells = <2>;
+            gpio-line-names = "CP2112_SDA", "CP2112_SCL", "TEST2",
+                              "TEST3","TEST4", "TEST5", "TEST6";
+
+            fan-rst-hog {
+                gpio-hog;
+                gpios = <7 GPIO_ACTIVE_HIGH>;
+                output-high;
+                line-name = "FAN_RST";
+            };
+
+            i2c {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                sda-gpios = <&cp2112 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+                scl-gpios = <&cp2112 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+                temp@48 {
+                    compatible = "national,lm75";
+                    reg = <0x48>;
+                };
+            };
+        };
+    };

-- 
2.25.1

