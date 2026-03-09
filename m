Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C6393DF4
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054074; cv=none; b=IlnGRxjyh1LVVWIvuySds0A5c4Y1dlJNAJel8D2c8fwYlocm+X+R8wRkdKsZ/TK9SrVX5dR/nGuQl8viM/xvR8ADD9yQROb+bP5AKwpYtrOTmNW+hpQFt7jvB59WxvzV8fuNtx8u10DL+6wtCaXmXfDTY4w4fCsf7rTPohenGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054074; c=relaxed/simple;
	bh=L2/qOxKHTQKz7tTe9NevqobBIQclt/atXpIP78HnnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULp79EiuY7veN+7nl4JQnb4MnS0nba2uDkk6YvTuUGaTsbx+Dls65Q2favc+FWgYHH5pi0dn7MRsdxvC1UM94Aw1iCN1LcAjJRbxS+Em3Gv7/FO6wHBikrLIQNFCjRtV6IOKOFn0G0nMGKA2LD/ep1aEO73wovz7oIAxY0+vb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZM8EwBj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZM8EwBj"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359866a1d02so7167558a91.0
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054071; x=1773658871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdfZbw3s1pisbWO+qyvAF+lK8p/8MUQFjHrM1SRRAD4=;
        b=CZM8EwBjuXYzMb/pKHsYz6zESqsuMGqyek9eo/kqQEoGdarIYPDJkQL8zeG42vDLeU
         YAirayWNoIgnbJoHdNfb0yPJNZ2qie3QBuTADlmCz8FT6xPJF6QcIdaeQsmCVNA95dDV
         qymShDUkDXI1m3SLPWhvc/5Dxv9kBkwVJD+h/hnGKamW+e50SQvcHJ/xysqAnlpY8tdV
         hpScboRWdKFynu7pYbjhPM3ZicfGYFlQOC0S6gr9xzZqx1Yq082id+OPob8/6hdsNKty
         d8PfwD761yDkI5YtMxRxAWeFdIXTGQZ40xD56jR9UdD7GkA2diIS0AqRAkSlRL6TVrhW
         DTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054071; x=1773658871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdfZbw3s1pisbWO+qyvAF+lK8p/8MUQFjHrM1SRRAD4=;
        b=DXVsqeXI88KS5CH2OOFOf7Usf2wMrmaaeyV8lpQj6xbsHjSrx2ENaRjd4j4pI1EZdH
         RoDpx5yTWd2OlL3Ma2lnTqban9pCRICuhOEMgQ32lSd9l5R4LO++s9iMuLc3Ww5npjlo
         AnqOVzPRfvvyY/ewJUNSYLegn9pZazt0sZgotwmVDNBjs7+JipXNI8WASjjwizNbefxK
         Zfo4K2RTkO+0vKwUNOEfcEhgSA+1Bta/LHr97mQA4muYMGhGMGqP2bOJpIndm/+sQ0x3
         NPewoDKax+Q//6Jzn1EWxr+Y3zlk76hziHpSJ8VlMViqJecLznwdr9+uQdWOmLFmZK8G
         cRsA==
X-Forwarded-Encrypted: i=1; AJvYcCVChRpNL3Cd92ZzCVfi279KHz8gvwxqAftSx5qpRUResC/IcfFoaS9PYCNzIgJymetzdJ2pQt3KqRurRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRiVeXjBt0LrUHRZf/4COHdAgEDnuufVny4JnEfMnMEvqDPHr
	ZVQedp2SRZ7EX46/IQ5LxUwhzZL0eqUgcZNGUaAXYS6xBpreHqsRam0c
X-Gm-Gg: ATEYQzyB7gRLFQTvZ1Nw9dPKPrBfOlcqk2s9/bI9ZUi+Cm458t0KtFPjf2LGWDw/hNP
	6fDJHLmUvRFEciVgn23c+IXbw/C5MjvvlqFTC44Yl3eMjy7I6xxboLxd7D1J9VzJNaw2kXjHEIQ
	ze5ibvPrjU2gx1l3Ui4WeLzzmFy0Yein7bfE5DBiK/hddrGwwL7tKdaAVRXzUqhaUxnO51UlbAM
	VflGpt4CT2yOV8F7cuSz03Ed4J286x3VgdMu/PiEPZyV72G2/qa1YGNb1M7VhBxSZ0zwmiTZWMG
	b5yTRGIcrzZwozfnfz53uteYDU2FkYPohIbxBJdkFRDBYKuo4Gvig95oY0YMNrYIEo/BpX4aM01
	fEu//NV+fO/jKLc3Y86c/FGGR7GKp0IUqmj6Lqs1KERHU1aLhGoRB6IKI2JBRn7IwY1I8X3dkYv
	UwSeYXWZWu0F6dppfiKaV+EMKJGZVp5SpOcR7E7dk+QTZav/vdn3v1aZJCCg==
X-Received: by 2002:a17:90b:2891:b0:359:8ed3:8a65 with SMTP id 98e67ed59e1d1-359be349690mr9632532a91.34.1773054071032;
        Mon, 09 Mar 2026 04:01:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bff279f4sm13268296a91.0.2026.03.09.04.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:01:10 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Michael Welling <mwelling@ieee.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
Date: Mon,  9 Mar 2026 18:00:43 +0700
Message-ID: <20260309110045.108209-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309110045.108209-1-phucduc.bui@gmail.com>
References: <20260309110045.108209-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The tsc200x driver uses the "wakeup-source" device tree property to
determine whether the device should be configured as a system wakeup
source.

In the driver, this property is read with:

    device_init_wakeup(dev,
                       device_property_read_bool(dev, "wakeup-source"));

Document this property in the binding to make it visible to DT schema
validation tools and to clarify its usage in device tree descriptions.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
index 7187c390b2f5..c0aae044d7d4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
@@ -55,6 +55,9 @@ properties:
   touchscreen-size-x: true
   touchscreen-size-y: true
 
+  wakeup-source:
+    type: boolean
+
 allOf:
   - $ref: touchscreen.yaml#
   - if:
@@ -97,6 +100,8 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+
+            wakeup-source;
         };
     };
   - |
@@ -124,5 +129,7 @@ examples:
 
             ti,x-plate-ohms = <280>;
             ti,esd-recovery-timeout-ms = <8000>;
+
+            wakeup-source;
         };
     };
-- 
2.43.0

