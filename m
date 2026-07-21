Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83F472785
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627837; cv=none; b=pvECYUMm6oWSacUNyswxbdBWyWJ+Sq97BdiuN8zMGgj5SQ/r7wgxbPBt5QFNe8Frt+wl9ffVj5XW65R5+qiiCELFd1FwQ8ly53gZveHrPQe5yjcoIBXF59n8hWa3JtGcQmT3NHJJiUxGL6lJoTexvawp6MkMZDrtNuIphSco/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627837; c=relaxed/simple;
	bh=FvfwoSqBdrnoxs5BiXAqEZAAhFsqtQJDrQcSxsbO9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la8xFA9OkDBzRoSJsCu2TtEFf4IK8BVzyUQqxVZeAlh9FamkwUr1t5nJuMm2zabvhZgaNas5Js/UTQ2CT2lL2JHXr0npuU5Fk+UsUwGnXIcf37dlEF54mwf/ObuoCWLyjroL74yIPpSBUlit+TLjC4OlgM+CPa8hViu4KJE1ARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rq54GAxx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq54GAxx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49553515a8bso31637315e9.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627834; x=1785232634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=at/d3WF+Zw9xKecGccpZLlU2r+Ygji0UehRFE3mgt/s=;
        b=rq54GAxxOIYegLPiDVffqle1elMP8uNrncbuduOpUKbc3leMN3nSjJqFhDuBGPYrF+
         dV8EnNl4dJ4zL1g82TldPVNNy427CoXgnfXNGKWgSu2mwP8DcZ2CcB6jsOptze+EIdwO
         vGWnjZkp9EeVg4zfltdlITF0pU9cHE0x+WriVmeQ8/jSMAQoLUQXZ99mmh87jaCPnTWl
         GMzc5pLfp3zm2a3EFb+O+DgBPvAhsJn5qedClqmpyGp5jixn/riuS3BmeMc/f2FZuPvv
         dBy2EIwVAw4SiaZskUxyUbjAS9/wOICSlo6jKL3NFYJA8QcWk7suwmUh5o1ze1WZNsLM
         AE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627834; x=1785232634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=at/d3WF+Zw9xKecGccpZLlU2r+Ygji0UehRFE3mgt/s=;
        b=IDuMpMmNvM0L/Oj1jr7eGWZ+fUro4bXprZlXDJCxFs5y1i6ty/PqBILCknXoEwvLB/
         ifTR6MNDIx0CT33UyHYX3IDN3ONtjwXDLTA/LX/ZFzZIIYlFJKTCZafgz0LMiG6/0KHK
         lFMQoTTdtSZz8BMrsUjWgE9eg2hwrrIKk5x3mHEFlpRojZ+KzvzOuXS3CmMvaYuGyhMn
         uJAsRLfCctRMrmPo//DiBJC3Jf8460Aetx/j6p4AFK5IuKR5+wq7FvH+tq1TOYIgZP8H
         a2eTnFU2ubvtVru1SpoLw2Z9KKAqFwZ9eJED3YxssHGHTcRKkrXh7P8HJONrS8kjSQ7X
         K3ow==
X-Gm-Message-State: AOJu0YwEiSE3aizClcqxx+g79507TpGZp8XDeRYD9lYP0fJgbvcaPEM5
	r9M6NnyMuQjtLN+E1D5oCRYIFCEJEz9ubLBrimef1OILd3MigwcjXCls
X-Gm-Gg: AfdE7cmaVePRV0rkVdPfxet4bRCrKTU2IBPmFXbrfaE2LE5wl2ElaK97AQXe81kATlM
	iclO7ygyiW3+/DdQDRUPJPERj83/UWuHcJKXgTULS/0P+d+OI5zCVi0gSmkHln4pVRyglJcgPcZ
	UZjmANs0G6yxLcRZj46vmT7hmTr3+g5cf9kCxvE9/B67j/FJIc5Bm++bOCs2j1PsIwdLrY+s49L
	VlXHq+2GXlVbRU5xak0BCLofBIxHKqX06+IW4ALLLZ4eEsFfFl4EOldSP71KoTAhLcqcFBOT8gi
	qCSecScW41d5V92TBuulBxif/Ey/MGYccv42Y7AvZLJ8vWq8SyIufzURbRnHb7LWSAKNuZCKft+
	R4oDj8/krgbW5Hq2KVmygkhnP0IAQHzH67E9NcRhMaXstYFHt0xLBQl23hnfZSpCGY9eHdyDFWS
	tUvjDOME+1zA8bG/UwNO8UenM=
X-Received: by 2002:a05:600c:474e:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-4954a403112mr221507855e9.22.1784627834246;
        Tue, 21 Jul 2026 02:57:14 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954995b78dsm227476185e9.0.2026.07.21.02.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:57:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v7 4/6] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Tue, 21 Jul 2026 12:56:51 +0300
Message-ID: <20260721095654.429346-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index 76705ea56805a..da7abe2ec9126 100644
--- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: motorola,cpcap
-      - const: st,6556002
+    oneOf:
+      - enum:
+          - motorola,mapphone-cpcap
+          - motorola,mot-cpcap
+
+      - items:
+          - const: motorola,cpcap
+          - const: st,6556002
 
   reg:
     maxItems: 1
-- 
2.53.0

