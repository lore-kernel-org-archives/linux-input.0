Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7147DF98
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708634; cv=none; b=Zxb0gXr3kPLXIxltVZcRFT8Nb7tpf75ndgHwmbWX4KTV0XmYqtUVvAUdPVIwsK7Z4jBeD+OfF6Kzm70Il0s+TPA90q8XgKUuJVFynWd+58sdy6+0pW9tN/8h7JhxUSi9Vaxf4ezjdbbxMsAu/N/2IQEdAOPFfrCrLxoomcwt+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708634; c=relaxed/simple;
	bh=XRt4srsjyYqjA+MY6rVOHPKtA0KHYMBxZKPqqpoNz54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/lCWr0EayC0r1zHnsRA4ZDpGruYxyKijrzg2PLQk9SeUcFkG65V/cQpbLLKSvxXV9v2HZ8vkhArXlhu9pn7kMxt99Ke1j6r8D+4AmCgTOtg1nsXjSG9e9LKZHejn21KQpV+Bto7Vr3FlKENiDh0ceKmJTgN63ULNw1xwa1+lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oG6pPzOK; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG6pPzOK"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1716366d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708633; x=1782313433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61hqGr3BmmUeHBEanL/FcLEbEl68pk5mF01rxEgZaz4=;
        b=oG6pPzOKu5O872YJW7WqNVXBEibtQHyOktx69ISoMxlBg8G4MC85fp8bFw6UYywXol
         cTxKbU6DKXzsPPBGiuyl3X0hAvgvOl3Z74+EHzoadVyfT3MVl2UBKs4zTlchxLxArDU9
         7T0wVAiIRTAYpvv8lBub5mtkESvSY35VZIxfYF4yL2TLuEPTZHAdhYtggI3edEWkYC31
         Qyv+cHmV9uXs6y/8IL/QxhB9abOZny2SYreeuILKhcLzy5pcj9AyCvnr9uR4HeIg6vAq
         7SCtnMf3uyRB9AfVY1bzvzO4e2ySIxcbiqcyhybnBKaap4vzu1/w4u+Ep0I9NEZ4x+JK
         uxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708633; x=1782313433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61hqGr3BmmUeHBEanL/FcLEbEl68pk5mF01rxEgZaz4=;
        b=Q0HZsbB+H0FXyG6vrYn+ncsmBFLvSWCSJ8jVdPIAduAK7ZzxCaqpsENzQ6BNfA7EKE
         zvMx6QNtY3ar9UniGY9S3DFnAL3XxG53O3QhspBIh6d0M5XMxBPkAKhN+WtW/Ykz9uG3
         yJmM2xbc0yCk4zrvyvZuJ5WM15z/x31Nu2lRnCHv9Klzf7C9eBXq9MzNP+pLWitHshXe
         wtbWARC0+7am2H1x9JS+Y9phQCygUP7QiNux65GpaV3mwFuvPrtajEva8lZwC3IfabtZ
         RO3fdTyF0sz+YxQXhFK5ihlsd3y2AYuj76wQbl2EOja4PD2PqbkKkX8I0fiYugNb4FAQ
         uUnA==
X-Forwarded-Encrypted: i=1; AFNElJ9g6eiIO0lQhHY4eZh95ZcpJ96gDIEVTi/33pXBxIAn0PiJKwUmQgYLDeXP75rKiSuBqmrRypLkl4XIGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBQPNdSg/cqPFISEdN04smO7SlRoqEUNbCtwAuAb6eMKzokCR
	r/zeOshGdTEQD+f8CGc/4eza2W2dq0FUpvWP4hM2jaFEqb8UijfHmvaY
X-Gm-Gg: AfdE7ck3BedSLt9laNkjGcG36OzEPNe/hEJQW85OFx2r43QyvQgfYqCeYn/zwrIoEGt
	nTnDt+PyUA8lpoiVPhnO4b+Ger6V3/NoOKJRwAPnnSI7cj9EswDkEBGPcIbSg8+V3v2mqsIgsf7
	LttwV7LtvjoI22iEK+KCvBMpgs+mZoDZOvR2I6LLd9zcaB6ACAL1yDUYY4rzG+lN/Xwou+Gm242
	2eS7NSn6jBGXQoKHIkU3y8KwaXazupnmKKffDxA3Gw6nLakc8YwWuZtPXsyZkvPuxHz4X0L0vAE
	sz4dTTrcI55DqtH3o0p+nW671+YtkVOlskKgdVX850VD4mqTDluwWwX5T6aEvV0upPiBlaLC9Xs
	vIGMzY1bOFcrrgiWxhQ8GS6CbkM/UGscQGuFFMNu5DqKKtolEnlu8MGq1Bg69e4+8FlPMcScj7w
	wam5mSCOaNJg==
X-Received: by 2002:a05:690e:c4b:b0:660:6497:f8ac with SMTP id 956f58d0204a3-662d7e5d42fmr2064701d50.33.1781708632237;
        Wed, 17 Jun 2026 08:03:52 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:51 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/10] dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg constraints
Date: Wed, 17 Jun 2026 23:02:43 +0800
Message-ID: <20260617150318.753148-5-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150318.753148-1-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply per-chip LED channel limits:
- CAP1126: max 2 channels (0-1)
- CAP1188: max 8 channels (0-7)
- CAP1106, CAP12xx: no LED support

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/microchip,cap11xx.yaml           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index eabf06a1163e..798035e942af 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -171,6 +171,19 @@ allOf:
       patternProperties:
         "^led@": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1126
+    then:
+      patternProperties:
+        "^led@":
+          properties:
+            reg:
+              maximum: 1
+
   - if:
       properties:
         compatible:
-- 
2.54.0

